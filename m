Return-Path: <netdev+bounces-86917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D58178A0C80
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61ED5B21A25
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B1144D2B;
	Thu, 11 Apr 2024 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="mkcrlzZb"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93FC144D17
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828130; cv=none; b=VIx0jFNlBtp8101ZHBr88gMVx/2Flp+fN7CfaTfor3EBzoy+q7/C2JukeuR8OgW8N1z9uoVkzteG2op9bpNvyTdssKHHdltbO/71UPVE8Bx6BsqNlWDZAiOu18bPP1XpOz8prB77UuEpAfHW44HVMU3QVa5rrjk/UiHFiSe8nCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828130; c=relaxed/simple;
	bh=fM1BkAjY2FMKKLOzZsWWEVPeHYVTMib5CZXYBrvFELM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1gS1IiduMnpvg7c0ZUkGoLqzZBiIgsdNtPf0M6jct08wb+7x0pbXqR87WN3PXvOzwOmHkpy47GcVQ1OQkKYUQG9CkPAlbiWIBAckyfH+hKwSYwyHkhDXp5S2xRzy3lYcqYcpIqvNAsB9zsRF/XpEDSRiIyla/sCKO1xYj8EPGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=mkcrlzZb; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5B72E20842;
	Thu, 11 Apr 2024 11:35:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JvBgyNMxrZ4d; Thu, 11 Apr 2024 11:35:25 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C24F42083F;
	Thu, 11 Apr 2024 11:35:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C24F42083F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712828125;
	bh=4d+ZmogmRY8ucQY/LpTiACjUELq/TYpb9Q5B1xJoQKQ=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=mkcrlzZbms+77s7tX21vvHFoBJ4esLw/nmSmVuwH1si+XDKTLPzYhbSTzp8Ll8uAu
	 gERHAADnw8qPyXDX26USsO2DeDB/SfgjvP/tupQ82pSeM/8hPh1Sqe5BksRobvfLxS
	 VG1x3usD2gOqznE2Rcbc/vWkmTjvM4utZpBAKoz+uw+SMBX16k4Pp2qEtCGoKP7CZ3
	 ClEKUMvBlnWmwzr5tnfTmsAJ+RBcqqUh1audCUpeQdIFnMYDoCpoz7DBXTb2OoUJFS
	 FDXGhmEin4zrl6n6fEqMPFvt5XUYkHISRoxhc4lm+SVhrDd15ZeEui7YgLpzhEm+ot
	 j2fjtI+eX7Opg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id B45F880004A;
	Thu, 11 Apr 2024 11:35:25 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 11:35:25 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 11 Apr
 2024 11:35:24 +0200
Date: Thu, 11 Apr 2024 11:35:18 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Nicolas Dichtel <nicolas.dichtel@6wind.com>, <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<devel@linux-ipsec.org>, Leon Romanovsky <leon@kernel.org>, Eyal Birger
	<eyal.birger@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
Message-ID: <Zheu1lOc6KalNUFt@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
 <ZheNx5AYKzmRjrys@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZheNx5AYKzmRjrys@gauss3.secunet.de>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Thu, Apr 11, 2024 at 09:14:15 +0200, Steffen Klassert wrote:
> On Wed, Apr 10, 2024 at 08:32:20AM +0200, Nicolas Dichtel wrote:
> > Le 09/04/2024 à 19:56, Antony Antony a écrit :
> > > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > > xfrm_state, SA, enhancing usability by delineating the scope of values
> > > based on direction. An input SA will now exclusively encompass values
> > > pertinent to input, effectively segregating them from output-related
> > > values. This change aims to streamline the configuration process and
> > > improve the overall clarity of SA attributes.
> > > 
> > > This feature sets the groundwork for future patches, including
> > > the upcoming IP-TFS patch.
> > > 
> > > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > > ---
> > > v8->v9:
> > >  - add validation XFRM_STATE_ICMP not allowed on OUT SA.
> > > 
> > > v7->v8:
> > >  - add extra validation check on replay window and seq
> > >  - XFRM_MSG_UPDSA old and new SA should match "dir"
> > > 
> > > v6->v7:
> > >  - add replay-window check non-esn 0 and ESN 1.
> > >  - remove :XFRMA_SA_DIR only allowed with HW OFFLOAD
> > Why? I still think that having an 'input' SA used in the output path is wrong
> > and confusing.
> 
> I don't think this can happen. This patch does not change the
> state lookups, so we should match the correct state as it was
> before that patch.
> 
> On the long run, we should make the direction a lookup key.
> That should have happened with the initial implemenatation
> already, now ~25 years later we would have to maintain the
> old input/output combined SADB and two new ones where input
> and output states are separated. 
>
+1

Talking about the history, the need for SA "dir" is long overdue.
My issue is when offload was added they aded a new direction flag
which is specific to off-load only. And now we want one for IP-TFS. 
Trying to restrict dir only to IP-TFS sounds bad idea. That is why I
pushing for an information only SA "dir", and it not for look up at the
moment.

Any case, I will send v10, please wait. I think that address most
concerns. We just have to polish the checks and error counter there.

-antony

