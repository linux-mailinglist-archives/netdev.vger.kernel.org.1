Return-Path: <netdev+bounces-188386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ED8AACA1E
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA898382E
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6975284665;
	Tue,  6 May 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWunD1Aa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202C25B69F
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546652; cv=none; b=FkUurP0dX8RnKx3gRGLNFsO5bm0Ge5QxcMQo0YwbBhAMQ+D/LkLclU424ZNHfKYYVWl13qsIasjRo5QGisp9C1lKp3UPZiEyeFgnFlGIdI5txymr5lGZwQ9Djs0WMWP60l77Tb89O18MsDv7pJ+632CFtnfgFil/jVny51asGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546652; c=relaxed/simple;
	bh=HxPxdKxQ8aAAnLQeFeMv6MNbGQW0L4eR0WVMDiX1RSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jis1ZRxLzEfP0KDlDW/UdM2ly/vTqIIbOiD0heRoO/l6ElLx6LGt0ZdjL/mJ0U6VwxWrMcJ3YiWo8CWJViI1SQQ0pxN1pXwcdbWc1TiksI3OwBV9EeZTPZ5nIhR7LcATasgtRjnyB8aIh8SUHWsBob3AFjyVZrBcxGq1gg9xdjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWunD1Aa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49635C4CEE4;
	Tue,  6 May 2025 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746546652;
	bh=HxPxdKxQ8aAAnLQeFeMv6MNbGQW0L4eR0WVMDiX1RSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWunD1AaK2Dl3aDAsIXIl5FBVOqvgQA4E1+j9jVrG6dzgafbKdNteSOiH2utCudLT
	 R8KQnWZmSiY6yuGlNTgAlhSuyAsoJBT9ecwixuDi5q67wchs/Oi502tN4xINiUDmnB
	 Fph0BoTrs0xINYIfqRWI6FvLN9jiIcfwUNCcRvVl8A5U4I4Ze0VxlNBi9A7Q1QKSSp
	 H4qNpBpCTCCsgR2AE9KO7U8m250DhjLRWBzGtTPNh+qw0xUXV+tkfNm3yoO+f+u+TN
	 BfReLoXbWqu66yJf4IJmo6km6yAKngruRNOgJElWLvG1wH49FQnac5MJlwdYhRlvm6
	 wjbaddp+/HbnQ==
Date: Tue, 6 May 2025 16:50:49 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [net PATCH 6/6] fbnic: Pull fbnic_fw_xmit_cap_msg use out of
 interrupt context
Message-ID: <20250506155049.GR3339421@horms.kernel.org>
References: <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
 <174614223013.126317.7840111449576616512.stgit@ahduyck-xeon-server.home.arpa>
 <20250502165441.GM3339421@horms.kernel.org>
 <CAKgT0UeQ6_HSQ=2E6-DNuKA0yMWbYYhhZrKPvhBEhmwODmbSeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UeQ6_HSQ=2E6-DNuKA0yMWbYYhhZrKPvhBEhmwODmbSeQ@mail.gmail.com>

On Sun, May 04, 2025 at 07:53:09AM -0700, Alexander Duyck wrote:
> On Fri, May 2, 2025 at 9:54 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, May 01, 2025 at 04:30:30PM -0700, Alexander Duyck wrote:
> > > From: Alexander Duyck <alexanderduyck@fb.com>
> > >
> > > This change pulls the call to fbnic_fw_xmit_cap_msg out of
> > > fbnic_mbx_init_desc_ring and instead places it in the polling function for
> > > getting the Tx ready. Doing that we can avoid the potential issue with an
> > > interrupt coming in later from the firmware that causes it to get fired in
> > > interrupt context.
> > >
> > > In addition we can add additional verification to the poll_tx_ready
> > > function to make sure that the mailbox is actually ready by verifying that
> > > it has populated the capabilities from the firmware. This is important as
> > > the link config relies on this and we were currently delaying this until
> > > the open call was made which would force the capbabilities message to be
> > > processed then. This resolves potential issues with the link state being
> > > inconsistent between the netdev being registered and the open call being
> > > made.
> > >
> > > Lastly we can make the overall mailbox poll-to-ready more
> > > reliable/responsive by reducing the overall sleep time and using a jiffies
> > > based timeout method instead of relying on X number of sleeps/"attempts".
> >
> > This patch really feels like it ought to be three patches.
> > Perhaps that comment applies to other patches in this series,
> > but this one seems to somehow stand out in that regard.
> 
> Yeah, part of the issue is that these patches all became an exercise
> in "flipping rocks". Every time I touched one thing it exposed a bunch
> more bugs. I'll try to split this one up a bit more. I should be able
> to defer the need for the management version until net-next which will
> cut down on the noise.

Thanks. I could see that you were working your way through some sort of
rabbit hole situation. And while I certainly don't want to be unreasonable.
If would be nice if you could split this one up a bit. And it would
be a bonus in my view if some bits could be deferred to net-next.

