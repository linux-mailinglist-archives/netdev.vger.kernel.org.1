Return-Path: <netdev+bounces-164915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B0FA2F983
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CBB7A1883
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4EB24E4A2;
	Mon, 10 Feb 2025 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACIhIMQK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE324C671;
	Mon, 10 Feb 2025 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217141; cv=none; b=TWs6eEnxa7RbcXjsS2Gngy1VSZAoE7w3DQjBqYuGHAbnCS0GTS+6yok74J2/FKVTZ132LHmb4Q1lI24/OnCInm1DXUL+kMZMO2ip8oBE5Lh/wluQRAYBg9Huc4YWEtEFxzacP2w7acfnfjO2JTvJ/8W/EtJR938XYsepscvsJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217141; c=relaxed/simple;
	bh=eMbxPuWu6z1a5TgdGwnSavZW0+EQ98YYaSFxR7zGbl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQNcnUnRtlvG9dAsfS8Oo5athEyMahFMB3X+m9Eig7nNHphH5EfeAXVoWxAD23O2ZpQVjQyCCtqV0mCu1YGu3TwFNfran4bfORWnvciHRUhiK57nSdZJFnFFqy4GgEn299G5xG1fY0gaBlblgyVgOh/qmUzRSSDtu2LvjLgPAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACIhIMQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C20C4CED1;
	Mon, 10 Feb 2025 19:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217141;
	bh=eMbxPuWu6z1a5TgdGwnSavZW0+EQ98YYaSFxR7zGbl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACIhIMQKGnXkxrhhH458DUMhh90xayTEvDNTyGhfvUq2oegVOLIrQOdQwSEt6ObLh
	 28RPWflZVGWdyqucTbKI66ZFOK0m15AJ9vWgPP4/TRAKiw207SBiAGSKQZt1LmNMEI
	 J3reUvppkCrx58jjdviKatNd4TK+++aI60n4KBHmVOq+uXu8vonTIMyyHBFGql1b7Y
	 CDYpsnHiq4FiKCDcBUCGJDdG5yWSSw6KCSDACTZqfgUGYysNoAz2Ozo+Gz/kfeYkhT
	 inVBkMc5AvvrAYNtciLVMh88iqK8+9ZLdUZbLM6wPxrSZUPzAXokeUK0hIN2rVqGrD
	 dPJLm62HI9NbA==
Date: Mon, 10 Feb 2025 19:52:17 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 12/15] mptcp: pm: reuse sending nlmsg code in
 get_addr
Message-ID: <20250210195217.GZ554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-12-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-12-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:30PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The netlink messages are sent both in mptcp_pm_nl_get_addr() and
> mptcp_userspace_pm_get_addr(), this makes the code somewhat repetitive.
> This is because the netlink PM and userspace PM use different locks to
> protect the address entry that needs to be sent via the netlink message.
> The former uses rcu read lock, and the latter uses msk->pm.lock.
> 
> The current get_addr() flow looks like this:
> 
> 	lock();
> 	entry = get_entry();
> 	send_nlmsg(entry);
> 	unlock();
> 
> After holding the lock, get the entry from the list, send the entry, and
> finally release the lock.
> 
> This patch changes the process by getting the entry while holding the lock,
> then making a copy of the entry so that the lock can be released. Finally,
> the copy of the entry is sent without locking:
> 
> 	lock();
> 	entry = get_entry();
> 	*copy = *entry;
> 	unlock();
> 
> 	send_nlmsg(copy);
> 
> This way we can reuse the send_nlmsg() code in get_addr() interfaces
> between the netlink PM and userspace PM. They only need to implement their
> own get_addr() interfaces to hold the different locks, get the entry from
> the different lists, then release the locks.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


