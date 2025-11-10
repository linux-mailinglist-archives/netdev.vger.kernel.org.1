Return-Path: <netdev+bounces-237108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F4C452F8
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 08:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655513B1F4F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 07:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E3622173F;
	Mon, 10 Nov 2025 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIgxcZIj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7WWofnK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844327260B
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762758986; cv=none; b=jDiG+GJIT5V5sneYkwVQVe1uX8r1+FyFAQcsQLltKMFar+cUXS02mQu3887Jfe5GH+8gl5qp7kpeVTQlazKjqHxE/m835jLRFrxBOwIbZPP/dixgHQts1j3FQkgl0KqeMqztCEcam3YgO1W6fgdcLmKZT8VZzMeZwM+TZWR6lTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762758986; c=relaxed/simple;
	bh=woNJ/L3aR+lFVkkQCQU3hOMfYvGPT0/Us16RZEML7Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDgl1gjyi3TrWUdpMHAxULs2NVZaX0gD1dI+CZJISoU4CU6R8xaqxjo1KI1KoslOEl9MmPY121IILJJZDNdrd3L2n5VQekLcUmNNAbAGLzoUmBw0JKlasN+bs7hq66hyE3TjTPOsBCerZKpWIhTwZcX+qCEjYpDYu6/vbg1gNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIgxcZIj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7WWofnK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762758983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woNJ/L3aR+lFVkkQCQU3hOMfYvGPT0/Us16RZEML7Qc=;
	b=UIgxcZIjy/tkRmwjMHmn/U2Q0ku20Ubf0e8TIF1k2K0+WRkS/eC1gaXl6XNjXp+E6wGaI9
	fo3j1gLUbsytCYeYRCKLWHXEyKc9N1Fp4FixX2ByUZSALjAGhe09V9hYVH7ergAEEhMWG3
	H3lmmJ81fFEfsjc99EaTqEsmV8OQEcI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-mQsRwSwGM-uNgDO1aqSbZA-1; Mon, 10 Nov 2025 02:16:21 -0500
X-MC-Unique: mQsRwSwGM-uNgDO1aqSbZA-1
X-Mimecast-MFC-AGG-ID: mQsRwSwGM-uNgDO1aqSbZA_1762758981
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-295915934bfso43950245ad.0
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 23:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762758981; x=1763363781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woNJ/L3aR+lFVkkQCQU3hOMfYvGPT0/Us16RZEML7Qc=;
        b=I7WWofnKhKXRWHYfHq40I7HZn9s9TpxQs4lIQ+iUE6x3KQG9DL7O180YFLPY7Ij617
         piIwR1O62vNFCH/wlo9tecxF+wZVPrh9Gph+cWgxLiSLE2beHvd2lAsqVU2SNzhSXYVJ
         fTcVNoDtxwZPJsh3jE/JZeq/QtYvbP7JMoyBZg+EyEexu5XKi9lgziYg4z1tkUUjV9aA
         ARrqLmMXC3/nqlFMRptmmMpTiovyD/BuGlLhxduNL8EbDsXe+uefg7upxqfuIEXWlMqF
         NwtbGb8hBdPFtXtDHTgK/spVfWH053c0DYtfrXpcJuU35E3TueO8S7FhHeP0ZUVG3bcC
         2J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762758981; x=1763363781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=woNJ/L3aR+lFVkkQCQU3hOMfYvGPT0/Us16RZEML7Qc=;
        b=aXjxbEgmRjsUQAN6R9DSEtY0T9NlA6rS3qoKtk2YwqIq8vjWedGrKWXpGM2Jvr6Vkf
         WbsYSoBOHHDLthaXnAywi9bhlmzdHVXBrD53EjdVddP8YZy6sNM/9fQAVFrgMWKgGf3G
         6aHJn+dt1WX78zdOJHMuttVvmJ0vT5Pe8SjKSArhzC8eK8SwwHW7qSJ6Op6/QxO62/nC
         BbeteG7ORUGOhxKq4U+NGcctB3S454feADPEBxC5m/7UPgJQPllUXxPFTjtTbT6k2zGx
         P7a2ZW7WoVc77CgVm5NzmIencKLpIgk9Jts965zzcPdhAUf0jPRPmCRZhE7icrfVm9HA
         lkww==
X-Forwarded-Encrypted: i=1; AJvYcCV32dXXxCNljA/SJ73GpdS2b7gFMCxsJ+aJ81JGUXZaysm0afe9s70Vv0+uB08a9E3Zla6LQrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+8+/qnRZZ80rxuQJvgIkZbGQbkNHMXYZrOR921dUXObLNSS+L
	QQZFff+d0g8MM7z50uUo+Z737PYqmVbDDi9Y8j8qEPmp5ENWuhmRZPsRY4o+OubZkCyThpQ4RwF
	s8z5TiAvcxxyljYLUE78vIPJA5PSBX4quG4nvBkN4DvXSyR2OIotJD/h/hREijWsTXNLh8gGfnp
	b3U2oxRjrnr7TYPtpg1Kol3R3tpWIpMBmg
X-Gm-Gg: ASbGncvMhK4zqNJrvQDa0MzVVMPRDBK5VOoJlXzrrIkKKw2aGLspxKHl9xKQSJs7WYh
	s2kQ7ZE8rGldS8dYKgCI7Pf2o3CaHuq6X0Yj4zXkho+KQ4LQ06dH4Sq3VtPCMcjANSH6i2eLH9i
	XbOg1uvfZtDTAXvWboUhkaO4VpiqFElm5jCe/xm7DbTiO1JWyh1lM/
X-Received: by 2002:a17:902:c94b:b0:294:9813:4512 with SMTP id d9443c01a7336-297e540dd6fmr99366295ad.3.1762758980726;
        Sun, 09 Nov 2025 23:16:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyWxROkXiMDUVSb3RLFtOHycy16XKfPRQV2OSVyu8OSlagDoRuUKg6J6cQIIbyBm0s3zF/+eWz7qoXIAaK5M8=
X-Received: by 2002:a17:902:c94b:b0:294:9813:4512 with SMTP id
 d9443c01a7336-297e540dd6fmr99365985ad.3.1762758980269; Sun, 09 Nov 2025
 23:16:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com> <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
 <20251109163911-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251109163911-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Nov 2025 15:16:08 +0800
X-Gm-Features: AWmQ_bnkx6vTf5wHnwoJGVSoRMptjjphfDUQyvyoKqLw1ru0NtOodqRvT7p8cgc
Message-ID: <CACGkMEtxfZh=66TSTC2B8TdXWP-fsTrYFkfz5aOViYkZmmcvxg@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Willem de Bruijn <willemb@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 5:41=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Oct 30, 2025 at 10:53:01AM +0800, Jason Wang wrote:
> > On Wed, Oct 29, 2025 at 11:09=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > The commit be50da3e9d4a ("net: virtio_net: implement exact header len=
gth
> > > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > > feature in virtio-net.
> > >
> > > This feature requires virtio-net to set hdr_len to the actual header
> > > length of the packet when transmitting, the number of
> > > bytes from the start of the packet to the beginning of the
> > > transport-layer payload.
> > >
> > > However, in practice, hdr_len was being set using skb_headlen(skb),
> > > which is clearly incorrect. This commit fixes that issue.
> >
> > I still think it would be more safe to check the feature
>
> which feature VIRTIO_NET_F_GUEST_HDRLEN ?
>

Yes.

Thanks


