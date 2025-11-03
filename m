Return-Path: <netdev+bounces-235169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4143C2CD59
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35635189F36D
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69A3315D2D;
	Mon,  3 Nov 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nb0Vn1Rm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib5+eJCi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154CA314D39
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183781; cv=none; b=jYsybw3z3EQYGjA1XCuTB4U2E7txK1YcASbeq4vABl61pVw9FC5AKBmrpAOCTm6OPmMebUKcUfCpcCXDBnvoMi20qSPOsSYjfSkUlG/EVHemDv7kB0jBJMBnWnatokZCTHaHaGlF+n6wEzB0RHZ/3+luWEVweJuw88CnrsBOUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183781; c=relaxed/simple;
	bh=qxXgG1/ZVfoTBQmNPKXK2gfg9Lk7YA9Q/vkKgYC/5i0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKreG8tfGj8cTxxKiS6IQ0tjZlwfjIAtRTRFgIhEhJm9VTRYU+I7t0sTCfOoIWjmWozGBZdbBQU1cd+HSW6rpqLDCPQTYtWiTPn3CfYdJ5PcB/8tUxpW+13XhrbqtOUZKeYSheBz/7VbcWxrci5yZrfh1P+q+lOdvFFVBmsRxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nb0Vn1Rm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ib5+eJCi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762183779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4KzmL4mSHOG0NRY4Olfh+OhbksQdgkf1/uGRGrjW9s=;
	b=Nb0Vn1Rmngz3fIJEjhvQT0RPf2zJPf1yFKjd31egoGVjS6X5oIK4QP23+oXEW1C36/vWQt
	Y67ULICFgKF6BtyRPd9QxYJIlFSyF1jWsjZh9gNy+CqyAxju9aLIVWKytcPMa/4U9mmVpq
	twHu5Z9lh8+7C3yt56gHSq7LEgL+0SQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197--OAr3ERoNS-lNeL3THAInA-1; Mon, 03 Nov 2025 10:29:36 -0500
X-MC-Unique: -OAr3ERoNS-lNeL3THAInA-1
X-Mimecast-MFC-AGG-ID: -OAr3ERoNS-lNeL3THAInA_1762183776
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b70c6ff2639so193663166b.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762183775; x=1762788575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4KzmL4mSHOG0NRY4Olfh+OhbksQdgkf1/uGRGrjW9s=;
        b=ib5+eJCisZ/HnpyN2+9oIIYDnqkrcpThcu1/uzrp6x2GeF6M9OZZ5QX0frEATJEOD+
         agDhurGqtiFDThfoE1JFks4KNJswJLAUWSzfhoWmd7xlwvlOLxFl7GBYbAUIdMvLu4uG
         T7XSFYAjDSO7uUO+uTNC0xUGYCJzx3dZ4YkhFlvxtsdLmtxxgij9IfA/ViewLd4DTqde
         awJteBWhE+rE5bimJ9954zz9yKFOpPJ6pBPDEO3agiiRXx0uGR3GYn61ff0q+EozQQkI
         Gdp7parJOOHfiC6K18EJ7bvWjHegF7zj96MrO64s2NT6LcPwF1rgjeLR7FEhNiYTIMQS
         6bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183775; x=1762788575;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4KzmL4mSHOG0NRY4Olfh+OhbksQdgkf1/uGRGrjW9s=;
        b=o1y/5KuP72zcFKUkZq9oCxZjwuv/zhLptBK0rxTjY+XEc1gwsqSS+rPRol6U+vlHwb
         Rr0uWXo91/DpJnYm8codg1znaP9obNPeIrGwcIQ1ZrKPIXHEMEQoUk9F0cZNrNoVT9Zz
         Q6xKknW6K/ZJINXvj7sK7MGTdJ1MjhnEFqIWlelbY09S3f4eoB5ThhW3ud7P6PkojIgS
         EEa4lpuOHrhc+A/Lh6oeXoYalMbHKeagS6s/9qbqoBvmH57Ebs3R6OUj21jZ49O2HK/j
         U4481OYQUks023ACTBYLq3C2TkB6/do5jIpy6SK4Gc+imLay42tLsqv5dGVxMt1VKHTQ
         JJjw==
X-Gm-Message-State: AOJu0YzBV3BUIGH7CGTVezko2lvkQ88LYAsJgB/Gcjp0rEUdmKY9SmgZ
	KzZMt2Ugh3D4v5tgTmk4YYGDU67fGFD8nU1O5vnxTMrKL9KKQzpAhmv2uxw09P+Gr8ncPL1ou6c
	sL2CJln1jTpSrAhSszin9B2GVq6ev+NL3wR3XFZJMgojvQIlxfq/w0IwEThDpwtk432bd2XPe4H
	rtZYUiBTEshsosifref6S3/ypGXlhXgUAh
X-Gm-Gg: ASbGnctv5tumTqc1nXd978hqyO+YbHbtpYDaVg3tDqzTLA/S2w7hi8PUu0/4WLoXBle
	JNdvsGsiPd0ka5jl7a7JygxwRHPDNjy5PjtgBeywjQT0EbLORMkcTob1tkFgJ4bjre/xSRPt4KC
	VemOO/IkyrzrMg6AG16lxp/50hTGl5bkYZs5dCVqsUhNPfA1W+ohOksLMPpQ==
X-Received: by 2002:a17:906:fe01:b0:b6d:7f68:7874 with SMTP id a640c23a62f3a-b707061f144mr1297001966b.44.1762183775579;
        Mon, 03 Nov 2025 07:29:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEeyre5gK0cpKI1Q2+DYzhOn6+InSCUe74E0Xci1qbbA4oEB0h8kkJflrWJ9RIbM5vQPgseW5T8lTrnZTRw/4=
X-Received: by 2002:a17:906:fe01:b0:b6d:7f68:7874 with SMTP id
 a640c23a62f3a-b707061f144mr1296998866b.44.1762183775184; Mon, 03 Nov 2025
 07:29:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 10:29:34 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 10:29:34 -0500
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20251029080154.3794720-1-amorenoz@redhat.com> <20251030182057.59731b84@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251030182057.59731b84@kernel.org>
Date: Mon, 3 Nov 2025 10:29:34 -0500
X-Gm-Features: AWmQ_bmA0xF3CCQQU1dc0lEnh7ovEiiQIFlXKGri7DAAHjaQidAdLsxH4BmtAE8
Message-ID: <CAG=2xmOfirDS58uwj=eSsn1KDrkX3K936SN=cCU4ARw9WSaogQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in IFLA_STATS
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com, toke@redhat.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, 
	Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 30, 2025 at 06:20:57PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 09:01:52 +0100 Adrian Moreno wrote:
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -1275,8 +1275,9 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
> >  	       + nla_total_size(IFALIASZ) /* IFLA_IFALIAS */
> >  	       + nla_total_size(IFNAMSIZ) /* IFLA_QDISC */
> >  	       + nla_total_size_64bit(sizeof(struct rtnl_link_ifmap))
> > -	       + nla_total_size(sizeof(struct rtnl_link_stats))
> > -	       + nla_total_size_64bit(sizeof(struct rtnl_link_stats64))
> > +	       + ((ext_filter_mask & RTEXT_FILTER_SKIP_STATS) ? 0 :
> > +		  (nla_total_size(sizeof(struct rtnl_link_stats)) +
> > +		   nla_total_size_64bit(sizeof(struct rtnl_link_stats64))))
> >  	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_ADDRESS */
> >  	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_BROADCAST */
> >  	       + nla_total_size(4) /* IFLA_TXQLEN */
>
> Forgive me but now I'm gonna nit pick ;)
> Please break this out into a proper if condition.
> It's quite hard to read.
>
> 	size_t size;
>
> 	size = NLMSG_ALIGN(sizeof(struct ifinfomsg))
> 		+ /* .. litany .. */
>
> 	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS))
> 		size += nla_total_size(sizeof(struct rtnl_link_stats)) +
> 			nla_total_size_64bit(sizeof(struct rtnl_link_stats64));
>
> 	return size;

Sure, I'll send V3.

> --
> pw-bot: cr
>


