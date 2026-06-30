Return-Path: <netdev+bounces-303228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rMjLHxvQQ2pBjAoAu9opvQ
	(envelope-from <netdev+bounces-303228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:18:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8376E552E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:18:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=SLOE4wyY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303228-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303228-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D1B130989A6
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA15385D71;
	Tue, 30 Jun 2026 14:07:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C4D382383
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:07:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828474; cv=none; b=DggTGhBQDXaUxaLUXiXj150e++GAoCUsltH3d5IVFF9LwnETQg2cFA/VHxV5AO5CCHS+4UXoLT7n4lHL2AlBGJwE3lQVqfdeNmSQgGuL39LEnr3KFe4v4df6w+5X6uyprs71NQupZ6LqCNAS+fdrnspdL3ycQ5SwQvWBmcJBwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828474; c=relaxed/simple;
	bh=R6PE3q4l5whDdU7yCMJ15ug5N5A00uM6KUFUVpMb5bM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUMSr35MPVTeKsTtqAoxEak6BB3flCJUgdDh082AnHhICaE5UQIo4D3z+yal7gnC5IeVzhP08roMVj4UjMKpjkw4vWloyClk/j1Lpa+9rNSbmEmqlQv9NK/0uyehsase6tUqcnkXe+BV/K6SEZxxtkBOy3xz+hREjcHh1/ftwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SLOE4wyY; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A30ED20841;
	Tue, 30 Jun 2026 16:01:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RQRziuo3PxHb; Tue, 30 Jun 2026 16:01:53 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 105FA2074F;
	Tue, 30 Jun 2026 16:01:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 105FA2074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1782828113;
	bh=4mju3TDWtg7VRyny+ZF2/UdWSqoec2zEKN+0dwI+wOo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=SLOE4wyY9LUURs1q2fkxlgbBPlrpMUgmRegHLT99AgPgTzEODqgJWbpexhIaZXULA
	 QzutOeuo+Yrx7HaiiwkDFXxFj2VcBe08qs+U+6jNKfNfL1pNpH9CAc77gEel+sSuuQ
	 QKdeAJa9FYZmiYZsdVGzWJSnPGoiaPSBEmw0crRkkEvWzt5IbGYYyfeuNqysQDHteu
	 LT/mYcEO2VRmq4d4uC2X8kvFwirOGopV8vGKt9lmM93U6tJhtTDWb8X4MQjQCm5mBP
	 OZ1K53LurHZJUGZeNMDslmgMQTlnD0Ezkux5TpfarkA6LI4DBAAH/TvP1X1dw/nbik
	 BKxpFAIWKW2tw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 16:01:52 +0200
Received: (nullmailer pid 1131885 invoked by uid 1000);
	Tue, 30 Jun 2026 14:01:52 -0000
Date: Tue, 30 Jun 2026 16:01:52 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Petr Wozniak <petr.wozniak@gmail.com>
CC: <netdev@vger.kernel.org>, <sd@queasysnail.net>,
	<herbert@gondor.apana.org.au>, <kuba@kernel.org>, <horms@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>
Subject: Re: [PATCH net v5 0/2] xfrm: fix async crypto (-EINPROGRESS)
 handling in validate_xmit_xfrm()
Message-ID: <akPMUICkNLVwrGPl@secunet.com>
References: <20260603064659.3867-1-petr.wozniak@gmail.com>
 <20260621100327.40203-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260621100327.40203-1-petr.wozniak@gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303228-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:mid,secunet.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:petr.wozniak@gmail.com,m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:herbert@gondor.apana.org.au,m:kuba@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC8376E552E

On Sun, Jun 21, 2026 at 12:03:25PM +0200, Petr Wozniak wrote:
> This series fixes how the async crypto path (-EINPROGRESS from ->xmit())
> is handled in validate_xmit_xfrm() and its callers.
> 
> Patch 1 (previously sent on its own, v1-v4) makes validate_xmit_xfrm()
> return ERR_PTR(-EINPROGRESS) instead of NULL when a packet is stolen by
> async crypto, so __dev_queue_xmit() can tell it apart from a real drop
> and stop reporting -ENOMEM on noqueue/bridge interfaces.  v5 also covers
> the GSO segment loop, as Sabrina pointed out.
> 
> Patch 2 fixes a use-after-free found while looking at that GSO loop:
> validate_xmit_xfrm() unlinks async-stolen segments but never updates the
> list head ->prev, which validate_xmit_skb_list() later dereferences.
> 
> Changes in v5:
>  - 1/2: also propagate ERR_PTR(-EINPROGRESS) from the GSO segment loop
>    (the 2nd ->xmit() call); v4 only handled the single-skb path.  Restore
>    the blank line in validate_xmit_skb_list().  Add the missing
>    maintainers to Cc. (Sabrina Dubroca)
>  - 2/2: new patch -- fix the stale skb->prev use-after-free (also flagged
>    by Sashiko)
> 
> Changes in v4:
>  - Drop bool stolen tracking and the ERR_PTR return in
>    validate_xmit_skb_list(); use IS_ERR_OR_NULL() so stolen skbs are
>    silently skipped (Sabrina Dubroca)
>  - Drop ERR_PTR(-EINPROGRESS) handling in __dev_direct_xmit() (Sabrina Dubroca)
>  - Move validate_xmit_skb() return-value comment above the function
>    (Sabrina Dubroca)
> 
> Changes in v3:
>  - validate_xmit_skb_list(): set stolen=true only for -EINPROGRESS
>    (Sabrina Dubroca)
> 
> Changes in v2:
>  - Reset rc to NET_XMIT_SUCCESS only when PTR_ERR(skb) == -EINPROGRESS
>    (Sabrina Dubroca)
> 
> Petr Wozniak (2):
>   xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
>   xfrm: fix stale skb->prev after async crypto steals a GSO segment
> 
>  net/core/dev.c         | 10 ++++++++--
>  net/xfrm/xfrm_device.c | 12 ++++++++++--
>  2 files changed, 18 insertions(+), 4 deletions(-)

Series applied, thanks a lot!

