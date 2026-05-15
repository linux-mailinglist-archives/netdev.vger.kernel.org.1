Return-Path: <netdev+bounces-288226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF5lA9HZBmoGogIAu9opvQ
	(envelope-from <netdev+bounces-288226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:31:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD3154B4FB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE56D301A7C7
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD573FF8A1;
	Fri, 15 May 2026 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bG7kBf99"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72EA3FCB09
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833774; cv=none; b=uGdY7HJSpgU0YQBdY5ixV5qA9N5jjSX8gqLS6UkTU9837cF9JQZ2tcAYAfvo/FqWiRPROnLH6WBQZ4Q8VKI0kML3eHsHesdL3pe81+XhqLIryaBgIKYdbnq6EkT6l3rY3YpUnz9i9/jI2GUNorV+a8PqF9MXQIe7NqitjqYmVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833774; c=relaxed/simple;
	bh=J40cBMKZnkdYVch+BEkXUq897dJ0R5SMRfWujopnYvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=XQpdxJo7TWt+gwi0AR2VfnZ4viBCnUV14hEC9TonG19F2YfMWMEWd4npXV44SA2NR3CrgCvDSaI26WmLTSk9A1nbRoHI1ltlNL9beP7Nt5MeZcMQeR+6QjuaiBwf++oOlXadg5cHkHm1CD/2ToDhkls3so+IW6R18Xbc6gONjh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bG7kBf99; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260515082923euoutp02153401aa44a9900e4dda90973140cbca~vr_In0oQj0251602516euoutp02P
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:29:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260515082923euoutp02153401aa44a9900e4dda90973140cbca~vr_In0oQj0251602516euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778833763;
	bh=oCUw65ZkuySCN2x85iWRYSGfuGUEHl5kVPgSzcqpawY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bG7kBf99Elh9Z8MO1z7dcJUXcKHwQ9wLbiYvhg8njjAA6vqiTau0OSlVVkQjNUnWr
	 Ck9bPww4A0USRZzHr2wj1LULIqiQ+MWLuDH0XiTFiBmLMyofpX64UoC6GwBWoJvhXI
	 RQ5WYFPQL5AXWN059S+6iTlGrHxWpJt4iEebF30w=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260515082923eucas1p2ae364a3d4cba81884ab551c4d31fa747~vr_IVZu3s0270202702eucas1p2S;
	Fri, 15 May 2026 08:29:23 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260515082922eusmtip2e75618af5c1efc20fc80a59d5a2a7156~vr_Htrdkm1845418454eusmtip2p;
	Fri, 15 May 2026 08:29:22 +0000 (GMT)
Date: Fri, 15 May 2026 10:29:17 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	k.domagalski@samsung.com, k.tegowski@samsung.com, Chang-Sub Lee
	<cs0617.lee@samsung.com>
Subject: Re: [PATCH net] net/stmmac: Fix free-after-use panic when interface
 goes does with XDP
Message-ID: <agbZXcsn9CAlofe4@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4ca19ae1-6606-433b-9860-0a8cce12f80f@redhat.com>
X-CMS-MailID: 20260515082923eucas1p2ae364a3d4cba81884ab551c4d31fa747
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----peYM.qn2Q3Y4BVPtHiU-d89xQHYyd0GEhBng.MjRSgXq9KTQ=_4244b_"
X-RootMTR: 20260511165107eucas1p1882391435991ffc19670a60a43bbde01
X-EPHeader: CA
X-CMS-RootMailID: 20260511165107eucas1p1882391435991ffc19670a60a43bbde01
References: <CGME20260511165107eucas1p1882391435991ffc19670a60a43bbde01@eucas1p1.samsung.com>
	<20260511165045.3091475-1-j.raczynski@samsung.com>
	<4ca19ae1-6606-433b-9860-0a8cce12f80f@redhat.com>
X-Rspamd-Queue-Id: 9AD3154B4FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,samsung.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288226-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:dkim,AMDC4622.eu.corp.samsungelectronics.net:mid]
X-Rspamd-Action: no action

------peYM.qn2Q3Y4BVPtHiU-d89xQHYyd0GEhBng.MjRSgXq9KTQ=_4244b_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, May 14, 2026 at 02:01:20PM +0200, Paolo Abeni wrote:
> > 
> > Fix this by following:
> > - Set STMMAC_DOWN flag before stopping DMA to signal XDP to stop
> > - Call synchronize_rcu() after stopping DMA but before freeing resources to
> >   ensure all ongoing NAPI operations complete
> > - Add STMMAC_DOWN flag checks in XDP code paths (XDP_TX and XDP_REDIRECT) to
> >   drop packets when interface is going down. This has already been done for
> >   stmmac_xdp_xmit() so make it consistent
> > - Clear STMMAC_DOWN flag in __stmmac_open() to restore normal operation.
> >   This was only done for stmmac_reset_subtask() during abnormal operation,
> >   which is not enough. This does not affect normal operation as this flag is
> >   used only for XDP apps
> 
> The above looks racy. I think instead you should just use
> napi_synchronize() in __stmmac_release.
> 
You put this after whole section, but I assume you are talking about
synchronize_rcu()? Because currently there are 0 checks and it is pure race
condition. synchronize_rcu() does secure it in some way, but you are correct,
proper ensuring that napi has finished is napi_synchronize().
Will fix in v2.
> 
> > @@ -5267,6 +5279,9 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
> >  	if (unlikely(!xdpf))
> >  		return STMMAC_XDP_CONSUMED;
> >  
> > +	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
> > +		return -ENETDOWN;
> 
> Sashiko noted here you should return STMMAC_XDP_CONSUMED
> 
> /P
Seems good, will fix in v2.

Thanks
Jakub Raczynski

------peYM.qn2Q3Y4BVPtHiU-d89xQHYyd0GEhBng.MjRSgXq9KTQ=_4244b_
Content-Type: text/plain; charset="utf-8"


------peYM.qn2Q3Y4BVPtHiU-d89xQHYyd0GEhBng.MjRSgXq9KTQ=_4244b_--

