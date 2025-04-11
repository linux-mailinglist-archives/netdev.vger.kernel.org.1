Return-Path: <netdev+bounces-181756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B4A865D3
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D33E1BA55B4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BAE270EA6;
	Fri, 11 Apr 2025 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMm3UE/m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB211F2377;
	Fri, 11 Apr 2025 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744397953; cv=none; b=JIi/O3K20gR5FODVat5G/MZs+6MvL275PnsCP/oTCzJiuvGGtVSH9fELeReJYKfWFu79+Z6+pvUge3NXJzl12evNy1vFabSsKIW9gD3MT5DGVgg8Rh0VbnWSJ1qxx+3yXX0aDnAwHtKHPpuAquZua+4Ldk7sy7ixKGFc+aRsfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744397953; c=relaxed/simple;
	bh=x41J/jTpPqhyg2gUaV3xzM2HEf0hb4wTXv3Es1Aav6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpU16tNtnT3YJd1HWY8LeD49gvc0Yhvqh5khOD1Xw/vEUNYslNwjqoTrn8vyw9pAupesbP2A8dMKsukQ+fkAEOC3gbyZKVeTD3ns+M4RhnxeVpZj4KKNAuJuJkoQFNsaj+LaVU1s9xUCVF7T08+GjME5ZW75sSeQvB+rMUadoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMm3UE/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20A4C4CEE2;
	Fri, 11 Apr 2025 18:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744397952;
	bh=x41J/jTpPqhyg2gUaV3xzM2HEf0hb4wTXv3Es1Aav6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMm3UE/mzUZum9i4uZwtpkRHqYh8owYUCLN5AgyHHo86jXikCeh34b3giVRDZ2RX2
	 w7oJYgpPm/bgUF1+O8nA6X4uKwZXmZ1HBm9qbVHRvmbFYsQMqEGtL8shnD0tJT5d83
	 8mwUUqRJytYwz6bSmbHW229HK7lYz/xj7F9Qp+S1nzubuITP72ivObjwfKpE9DLyvx
	 yRzWErYMXE8Vr3j2RnRdXgxFqN0Pt7tMvVFpRBnTZqAlRSG8KCxMxxTX5xjb4eTg3C
	 VccN+yQtBjHQLYgEMkWG9s2/3GtOeJQOwn30Qjiz+i6ISTQlSgAGMaUG1jORv5LgzT
	 iP+4PhIBXvJSQ==
Date: Fri, 11 Apr 2025 19:59:08 +0100
From: Simon Horman <horms@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 1/6] pds_core: Prevent possible adminq overflow/stuck
 condition
Message-ID: <20250411185908.GA1398468@horms.kernel.org>
References: <20250407225113.51850-1-shannon.nelson@amd.com>
 <20250407225113.51850-2-shannon.nelson@amd.com>
 <20250409093730.GJ395307@horms.kernel.org>
 <15f8ff56-0359-450b-9fa3-cbb57781985b@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f8ff56-0359-450b-9fa3-cbb57781985b@amd.com>

On Wed, Apr 09, 2025 at 04:32:26PM -0700, Nelson, Shannon wrote:
> On 4/9/2025 2:37 AM, Simon Horman wrote:
> > 
> > On Mon, Apr 07, 2025 at 03:51:08PM -0700, Shannon Nelson wrote:
> > > From: Brett Creeley <brett.creeley@amd.com>
> > > 
> > > The pds_core's adminq is protected by the adminq_lock, which prevents
> > > more than 1 command to be posted onto it at any one time. This makes it
> > > so the client drivers cannot simultaneously post adminq commands.
> > > However, the completions happen in a different context, which means
> > > multiple adminq commands can be posted sequentially and all waiting
> > > on completion.
> > > 
> > > On the FW side, the backing adminq request queue is only 16 entries
> > > long and the retry mechanism and/or overflow/stuck prevention is
> > > lacking. This can cause the adminq to get stuck, so commands are no
> > > longer processed and completions are no longer sent by the FW.
> > > 
> > > As an initial fix, prevent more than 16 outstanding adminq commands so
> > > there's no way to cause the adminq from getting stuck. This works
> > > because the backing adminq request queue will never have more than 16
> > > pending adminq commands, so it will never overflow. This is done by
> > > reducing the adminq depth to 16.
> > > 
> > > Fixes: 792d36ccc163 ("pds_core: Clean up init/uninit flows to be more readable")
> > 
> > Hi Brett and Shannon,
> > 
> > I see that the cited commit added the lines that are being updated
> > to pdsc_core_init(). But it seems to me that it did so by moving
> > them from pdsc_setup(). So I wonder if it is actually the commit
> > that added the code to pdsc_setup() that is being fixed.
> > 
> > If so, perhaps:
> > 
> >    Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> 
> Perhaps... is it better to call out the older commit even tho' lines have
> moved around and this possibly won't apply?

Hi Shannon,

Sorry for not answering earlier, somehow I missed your email.

I see your point. But I think that it's best to cite the root cause.

