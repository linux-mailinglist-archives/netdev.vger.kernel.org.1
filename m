Return-Path: <netdev+bounces-249043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E49CAD13170
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0CF0301FC03
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6368D2561AA;
	Mon, 12 Jan 2026 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUJ7SHQ4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBI0Xs2y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07264215055
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227483; cv=none; b=U4XfE6Xtt3DrUTdRLiOQuyiKAAU3SQkwWmEm0Ttvkv4x42MzY+JDoOSxUMNb9Ky9lfSdtpgYfNAXc37ztgsgMPC6CgDoCpm7loc5xUdYtcgvp4VbtZ2PfDs+hK0c3mnLRvT6n/xbFdEGnIh4IOEvUIbM0Bv7thZQw38WC9Y9i+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227483; c=relaxed/simple;
	bh=ME1TLNI+USSWLfNTfmGzOvlZqzbGqHa3VyxFIGYd8eI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E4F3eqBlyjR7aRmeKbu3+dQv3lXfy8tNMQTKQbb7Ik8b8T8M+l3H2ZIvHkRHPDFo/kBQkDxgS1XcFNrDo5z1N8qzb/U55OJ8/AESm3I12cc8cL2GIUx5tMAELI8hkjwnMpt3V6Ke2MnFCQWxSfHUT2xsE+YAifvWju5e6vbPgEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUJ7SHQ4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBI0Xs2y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768227481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ywJXQckaF9BxFaegASdJuTtbFz0F5GKX4CYDkEEAEE=;
	b=IUJ7SHQ4TsdYQbmKYls/GtzWNahBTqGE0laaM6I9KUKVyirjMLPGxav29d2B/g49KOCfMN
	XICa3JHQVO/uvV8A8dT/k99jYl+GJ9tDoVfwlCof04J6npDzDf9RRqMMDYlAq4C/qEmcHY
	qtjQwTEbwVU+Hu5D+wNT9FrDFlZOicI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-9cTNtzVpPjSyN8PXMP1c4A-1; Mon, 12 Jan 2026 09:17:59 -0500
X-MC-Unique: 9cTNtzVpPjSyN8PXMP1c4A-1
X-Mimecast-MFC-AGG-ID: 9cTNtzVpPjSyN8PXMP1c4A_1768227478
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso50497675e9.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768227478; x=1768832278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ywJXQckaF9BxFaegASdJuTtbFz0F5GKX4CYDkEEAEE=;
        b=YBI0Xs2ybNn3t5oz66DTw9bpAimUSlbNnixhhP2BhEVFA8iPWd9pd/ej+kkf8a1WVW
         Agk0Yk2A0ATFHwlKu6i71N4f13II3Qs3qKw0o7iWNhBNYcfNIs598tIPs9NR0hpZhkPd
         icDz98H2QGfx8actKvJgkknfNR/D4fK6kVJ/I3nbF5Whe+izita96ZBio36jvdceMMwV
         Qz7RO6m0e/ir0gzjBmKo42b+yQE1yiVfc4X+2m1nHX0ZJvuDLqjPeKtOqV6BgQ9XMUbm
         BVsRqboE+TolIFzZFph+Oq5r9AYBP7BhYjZyFcg0VixA8xA8SyFIswhw6EexBBp6Bb9+
         1UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227478; x=1768832278;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4ywJXQckaF9BxFaegASdJuTtbFz0F5GKX4CYDkEEAEE=;
        b=jodsVQh16YnDF+T6Va3o0xiOhQkkH4QcS4/pQYxiJFGY5re7icvTDcUme4ZUPVTJ5D
         w1jgcQueSpuI3SQkr0ka8fLL8QUvAgfsQ3NHEt4zHwGSw/dQxN1PFvyGmCPsaxWKfFMf
         bROKRGuzETzPVEn33xXyZQ2GSZmbTk+5ASygM3wo5TOVCsUWnI62hJGpklckZ5cpOF/s
         0kUKhiMlfMNz8NiSM7ZgFTUM8CxYu2LHOwqL5BnkVbxoldEVGfx/f2UDcyKKMgA2I2Kv
         gtBEJTosw7BKmHYn0hoQPVRzUHsHk1idcC0MpwvSTHc2EUDY+AWam61WN9ywYX2PY+yH
         Wvzw==
X-Forwarded-Encrypted: i=1; AJvYcCU3xYCxP0zpvh2mDafxIW6LoyZ/l/Qtoj2PBWoKj2uHNyvUFUyL+HfVD4tKZUAMNmfSD/088hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKIp6H7Fxlstss+L/XovGgq6csoKiPHnVo/oGxm/sm4O3BUMT
	DUnx4fWNNSvgBh4A0SvS9papN/q7zcng1IzY9szPqKxfgJuelQE6Wj69ZrJBrDOKMn/gAwPnChE
	e5pAG/yQhomFlKqu1pt2V6kYYpy30QBEKGSh6YfeZaJ+QmUlU05qtrUbnxQ==
X-Gm-Gg: AY/fxX7EIl33LxZWhG2h8W2/aSvwbmumuIKuTCBnyjDFUjps1kw/GiENE3Ohf02krOY
	H9h1obd+LiZy9hRKdcL8vh4P1vaDHRMaClbTZaZh7ZSYJkVpIZJpt4Kyv2+L1dBiP0BbyAF9MgG
	4BqoKLUwXOVel0pYTpUljpiL8TBPCqJlqG2kUyKmcxSxfDKUJ1l6PgTR71L8wB88e4XOdhHbZZk
	PZWmUvMHQczBdZkHIKeU/zSUcNk9uAvZOWgxJgMJJFOzAyH642F1z7O/If9x4k0immBBak8DO2h
	AJac9DVJXi2levQdS6JZ/UJbrMJZvp1v252lW1BavB4gA7bR4uQ+ljRiVSMYfa4UNnfTZiXmxGi
	CddflZ4Ft0XrQwcUBJJqIn26jdrGx5cJRVHnmMg5yL4hKBxw=
X-Received: by 2002:a05:600c:3152:b0:477:641a:1402 with SMTP id 5b1f17b1804b1-47d84b1a33bmr198583615e9.4.1768227478309;
        Mon, 12 Jan 2026 06:17:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT0zQot+e6GEd+jdLPWsrsUbNqiZP2Vy9Kr3Pt0rHnXkI957YUsVCNGc/s/pvot5hOInuPaQ==
X-Received: by 2002:a05:600c:3152:b0:477:641a:1402 with SMTP id 5b1f17b1804b1-47d84b1a33bmr198583175e9.4.1768227477858;
        Mon, 12 Jan 2026 06:17:57 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f703a8csm352677535e9.13.2026.01.12.06.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:17:57 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 8/8] cadence: macb: introduce xmit support
In-Reply-To: <DFJBVCNFR0ZE.2ZIJ3RYVOMQP1@bootlin.com>
References: <20251220235135.1078587-1-pvalerio@redhat.com>
 <20251220235135.1078587-9-pvalerio@redhat.com>
 <DFJBVCNFR0ZE.2ZIJ3RYVOMQP1@bootlin.com>
Date: Mon, 12 Jan 2026 15:17:56 +0100
Message-ID: <87h5sqoqy3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08 Jan 2026 at 04:54:14 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> On Sun Dec 21, 2025 at 12:51 AM CET, Paolo Valerio wrote:
>> Add XDP_TX verdict support, also introduce ndo_xdp_xmit function for
>> redirection, and update macb_tx_unmap() to handle both skbs and xdp
>> frames advertising NETDEV_XDP_ACT_NDO_XMIT capability and the ability
>> to process XDP_TX verdicts.
>>
>> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 166 +++++++++++++++++++++--
>>  1 file changed, 158 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index cd29a80d1dbb..d8abfa45e22d 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> +static int
>> +gem_xdp_xmit(struct net_device *dev, int num_frame,
>> +	     struct xdp_frame **frames, u32 flags)
>> +{
>
> nit: a bit surprised by the first line break in the function header.
> Especially as it doesn't prevent splitting arguments across two lines.
>

Will fix it

> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


