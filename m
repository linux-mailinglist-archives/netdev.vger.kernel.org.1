Return-Path: <netdev+bounces-257032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMVrIbVOhGkE2gMAu9opvQ
	(envelope-from <netdev+bounces-257032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:03:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E0EEFB0E
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D1193037144
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B261236074C;
	Thu,  5 Feb 2026 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QQq8jiLW"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B9360729;
	Thu,  5 Feb 2026 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278314; cv=none; b=bn7kgF3k2ALP1wlfTukQFm9KI2MNHDSGKvO/jR101UXJyXuk5Tguxfqyv+Gs+xINPsK2Mv1bH21Bi1xN+1+JJdsSencvnNheaAdlf5zzUTblJdamqHMVo5K//c0ccW94dzFINTnOfb0fu/mztVtoV/bQcSZwCrX3C5WWinvUhXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278314; c=relaxed/simple;
	bh=pkWS7JtxH2V5mKX8UrQ08efERr2CUTHYYzCGVyb5BGE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUaY3ITjSno9+N6Y5+v6p0XfoLRR8lKTC+qaUSZs9v4YKuV6BA0m+KTP/vStGHusDqr5yT8MGp1kxemheaF9pp4wvghRg1dONBLYAs4UnvJIlwTFNHfxLJ3Fp7C9nZM2+58qJLkuRdiHGIlGe+astzDS8IcAgraAhPcRmk9kGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QQq8jiLW; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7A0BE2084A;
	Thu,  5 Feb 2026 08:58:32 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dMKAJ3yHvG15; Thu,  5 Feb 2026 08:58:29 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CEC5920844;
	Thu,  5 Feb 2026 08:58:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CEC5920844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1770278309;
	bh=3Sy60T/xKliudAYvigy+B1nmABmcknoDy0r3XYANbJs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=QQq8jiLWKhG6n2kihFvH8aLUtXmM0Irl0SzNfrKW3apfrAamVwrbdKVbDsUxCixut
	 KJZurcJtmmbEiCqjRA4RqQF3/adt5xWjfub1ZWM85NltRVDQPJmFYHuQa0VmXwByIh
	 bDK2zpnPFYbes1liiRsahCgspJj5IlscLCkfmQV4Qs1vraaFJ28IkLQ7RSqGf4+nbH
	 jTUjF/n/VJI7sOlb4b4v7jTrsooitNckGq36nkRjKKZ4HTYyGAN9yZG/Fx7mbn9eqe
	 D5tK0PgtrgefiOhbz667PuGA3Des1WUvQ4OJACXpbFc7R9mtF735vRl7JJoE+bnVnz
	 4gAiHmRgWto5w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Feb
 2026 08:58:29 +0100
Received: (nullmailer pid 856736 invoked by uid 1000);
	Thu, 05 Feb 2026 07:58:28 -0000
Date: Thu, 5 Feb 2026 08:58:28 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Alexandre Cassen <acassen@corp.free.fr>, Leon Romanovsky
	<leonro@nvidia.com>
Subject: Re: [PATCH net] xfrm: skip templates check for packet offload tunnel
 mode
Message-ID: <aYRNpFgo7ikv5F8V@secunet.com>
References: <1769518163-125874-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1769518163-125874-1-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257032-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,secunet.com:mid,secunet.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D3E0EEFB0E
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:49:23PM +0200, Tariq Toukan wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> In packet offload, hardware is responsible to check templates. The
> result of its operation is forwarded through secpath by relevant
> drivers. That secpath is actually removed in __xfrm_policy_check2().
> 
> In case packet is forwarded, this secpath is reset in RX, but pushed
> again to TX where policy is rechecked again against dummy secpath
> in xfrm_policy_ok().
> 
> Such situation causes to unexpected XfrmInTmplMismatch increase.
> 
> As a solution, simply skip template mismatch check.
> 
> Fixes: 600258d555f0 ("xfrm: delete intermediate secpath entry in packet offload mode")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Applied, thanks everyone!

