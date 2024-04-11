Return-Path: <netdev+bounces-86903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0D38A0BCC
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87931286DFA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895B6142E61;
	Thu, 11 Apr 2024 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ghHgdOmt"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7D1422DB
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826268; cv=none; b=IE3L6dQqj6LnZw7WMd+uY+nNOQeDz2LhGF1qL9lz9otL6utXrBxFcW3OwrbWMzdb5aNTanOvGVR+tievUqTbTTwUJE1/jCWtElW/3A1vA3cnt5Llm4iBs5NS5X+iU5Hd5oTx9/jbaGoGGo9sOL5EzPfwiBKM/KIFOtpn2YaQAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826268; c=relaxed/simple;
	bh=k3Lkum2V3s3ad/qXh51QaeXBlornEWHojdYd15sEM+w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VybTJBTmJKD6Mbjy7PXnO95jJ1MQiPG5IEWLTdiUUOPCISuvOkQxrrh9GWwGfonRvwAx5a8P1OqXZ4cUspr+YzouwJK0dz5grEnm7bTSBxWkPL6NxgIfhh9eLU/E/JG/w7D896E9NgD4oDO6v6Xu8m/grsaM0QbmtrH29ez6Mgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ghHgdOmt; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 86E3920860;
	Thu, 11 Apr 2024 11:04:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TUiJSSrONQLz; Thu, 11 Apr 2024 11:04:22 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3DFC3201D3;
	Thu, 11 Apr 2024 11:04:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3DFC3201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712826262;
	bh=PwF5aW3SFNlJlD33SyZdqdBB92LTBLn5rY9719TcHiQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ghHgdOmt9iGvKQDQg09zt489lOsi4SkQs4IUKXK2fWFT59McCu+CsQfVefZC/JplD
	 6GD+yoZzutAFjdgKlGVoBMtK9FYidCi2Mfc9aB5oi3NpMgaRD2eI3/ym01SKk8U8nT
	 crlduFm4dp2WVd10NV5KSx55PW2s9AUxB9qd2X9rCSnxdOWlT7eXsib2XtdJRtmze3
	 sop63VXw5Y99GZo+ixj28MagGIKwYx8pWm+54ScbWS+QbLdQNlse9dpWwXUntCikTh
	 DE1KYYFDFUDvQXoeVm/q0cjXCw++MGblr5b0PD5cCtLad0mAa3QTef2k0zCj+2GELb
	 M38oUdIxrQwaw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 30C6980004A;
	Thu, 11 Apr 2024 11:04:22 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 11:04:21 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 11 Apr
 2024 11:04:21 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 51349318093A; Thu, 11 Apr 2024 11:04:21 +0200 (CEST)
Date: Thu, 11 Apr 2024 11:04:21 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
CC: <antony.antony@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Sabrina Dubroca
	<sd@queasysnail.net>
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
Message-ID: <ZhenlYZLnYD3A7jD@gauss3.secunet.de>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
 <ZheNx5AYKzmRjrys@gauss3.secunet.de>
 <39ed70fe-ee5d-4e9c-8fba-d3b2dd290cde@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39ed70fe-ee5d-4e9c-8fba-d3b2dd290cde@6wind.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Thu, Apr 11, 2024 at 11:01:32AM +0200, Nicolas Dichtel wrote:
> 
> 
> Le 11/04/2024 à 09:14, Steffen Klassert a écrit :
> > On Wed, Apr 10, 2024 at 08:32:20AM +0200, Nicolas Dichtel wrote:
> >> Le 09/04/2024 à 19:56, Antony Antony a écrit :
> >>> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> >>> xfrm_state, SA, enhancing usability by delineating the scope of values
> >>> based on direction. An input SA will now exclusively encompass values
> >>> pertinent to input, effectively segregating them from output-related
> >>> values. This change aims to streamline the configuration process and
> >>> improve the overall clarity of SA attributes.
> >>>
> >>> This feature sets the groundwork for future patches, including
> >>> the upcoming IP-TFS patch.
> >>>
> >>> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> >>> ---
> >>> v8->v9:
> >>>  - add validation XFRM_STATE_ICMP not allowed on OUT SA.
> >>>
> >>> v7->v8:
> >>>  - add extra validation check on replay window and seq
> >>>  - XFRM_MSG_UPDSA old and new SA should match "dir"
> >>>
> >>> v6->v7:
> >>>  - add replay-window check non-esn 0 and ESN 1.
> >>>  - remove :XFRMA_SA_DIR only allowed with HW OFFLOAD
> >> Why? I still think that having an 'input' SA used in the output path is wrong
> >> and confusing.
> > 
> > I don't think this can happen. This patch does not change the
> > state lookups, so we should match the correct state as it was
> > before that patch.
> This is the point. The user can set whatever direction in the SA, there is no
> check. He can set the dir to 'output' even if the SA is used in input.

Ah, yes indeed. That should be fixed, thanks for clarification!

