Return-Path: <netdev+bounces-272700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5v0hFosex2k9TQUAu9opvQ
	(envelope-from <netdev+bounces-272700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 01:19:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8F034CA94
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 01:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E58B300A774
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 00:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8A2175A62;
	Sat, 28 Mar 2026 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZeilZTd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878B16DEB1;
	Sat, 28 Mar 2026 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774657160; cv=none; b=pbFbytFSAOpWf7tD7w/eEEeDMwugxR7Roar3GgLHK19kHuRCyLlAFrTlf0tBntRAD4odgzLPvgBXPvZaKiuyyKOBJsk+GLdXSQ3ulrerbPlJ+vdei4n4SZleOPjh6JiNBq/hg8zOb0jOBMZkmVuK87mz6BmbgWE5wCmW73prYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774657160; c=relaxed/simple;
	bh=96/Bq7QsX0oS+XIrJ6cfIExvCtg0qQiSLSrY/A1UGIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+gdHhdfDLt80+1WZeF1X9+8qOW0vazB3g9rv792OR8hot1EzBZ5G0sOYz7quUXZFCWrHS2B4OgM/V72C00QnCrKH6MbTdHnCpTdiJIclwzzHyUb1hMGDX8L+EinXGVC8HH58Hx1ujLWJv4mTAkF9t/vsvhkhP8Ip+wCw4hzFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZeilZTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD75C19423;
	Sat, 28 Mar 2026 00:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774657159;
	bh=96/Bq7QsX0oS+XIrJ6cfIExvCtg0qQiSLSrY/A1UGIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lZeilZTdHiuhAkCdTAYQiNl+fJ+QqZA8qfDppHx2ccobb1J5XXuOqFOczt0gWjsXO
	 hZBpPwGj4zfKMaQezeTtvzkk8xz49+BBYVxH20wiW2/N1EV40uGLJ1A7zfI+WxsHfq
	 xcNRHt7MWIDVHKamuqn4++6DYb+kWDH8nMgcMnpMKvnBuC35YR9nkf/zLwhkCh81WI
	 QsEzuamZVlK4/l0dyb1lJp41oBGCEVgdKbb39+ezXKWXKtxqIsp7oos0zYzOvOXeqF
	 wNuSzb8mxYGyj/VB7hz6wWst0Hyx8z7iMWmcQw0aHGANWeZh5YpDBtjHnbxp1HkKjD
	 aFhz8qRFA350Q==
Date: Fri, 27 Mar 2026 17:19:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Simon Horman <horms@kernel.org>, Xiang Mei <xmei5@asu.edu>,
 netdev@vger.kernel.org, bridge@lists.linux.dev, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
Message-ID: <20260327171917.7575d715@kernel.org>
In-Reply-To: <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
References: <20260326032438.3307549-1-xmei5@asu.edu>
	<20260327113412.GD567789@horms.kernel.org>
	<f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,asu.edu,vger.kernel.org,lists.linux.dev,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-272700-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B8F034CA94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 13:46:39 +0200 Nikolay Aleksandrov wrote:
> On 27/03/2026 13:34, Simon Horman wrote:
> > On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:  
> >> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> >> interval value from netlink without validation. When interval is 0,
> >> usecs_to_jiffies(0) yields 0, causing the delayed work
> >> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> >> itself with zero delay. This creates a tight loop on system_percpu_wq
> >> that allocates and transmits MRP test frames at maximum rate, exhausting
> >> all system memory and causing a kernel panic via OOM deadlock.  
> > 
> > I would suspect the primary outcome of this problem is high CPU consumption
> > rather than memory exhaustion. Is there a reason to expect that
> > the transmitted fames can't be consumed as fast as they are created?
> 
> +1
> More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu usage
> conditions. This is a configuration error and OOM doesn't lead to panic unless
> instructed to. I don't think this is worth changing at all.

Then again if there's no practical use for 0 we should consider 
the risk of getting this sort of submission over and over again?
Dunno..

