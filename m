Return-Path: <netdev+bounces-198883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB75ADE241
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D4817913B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0DC1A2541;
	Wed, 18 Jun 2025 04:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fteBDhMk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A323A9
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 04:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750220168; cv=none; b=NB9JlY/8FAkpOo/LeInnwoutJQZ7v1jlJAO/1hHGCbpGW3UT3rbS4ovC7aoDXo33gLiorH2cSYcyv6ek3Q09xKgXoVpvuinjmBKVGYoYhDDL1kCtV9n+uJEoRDJ2oMq4Pn/ijcQIAeFusk4wZhRIZZ4vvk7D7x16KFWObWZJYuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750220168; c=relaxed/simple;
	bh=xOAS80FC2FGW3kWjLUCSnKiIV4S+bnJurfNXljgPXao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pM1rwJjE9RyfwRQRk+ZOlICbxd6quoOpY3pRHd5JJ2gVQAY/QZAnZx2wAT7EBSzEqNMYEUVA+EUr8r+DloplCCVcMaAD4YfXL0+c+qGd7uk8x2ZJ7sYV0okFI6ffeummjcH/xQAA1f69bzMMQO5gTO/mnq9jgvVXWDGm9lhWusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fteBDhMk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750220165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0XrW4xN79OVxTyNN17bBcJQjURhuzlmM24bz9qYdiw=;
	b=fteBDhMk9g78opG57ZYA1rDsm0N+Jt15SjbTIn/xtgCpXXeSxyM5+e03uKiL4TwBxGM8yC
	7n4Xh45thGUpr9ceZ+2QnwpucEr1bEKtUbmgfYXhskWo72ENG4aV+3ZicPfEO0e5jkmLAY
	VWNYptSCDdMXmd6mIPQQ5EuvRMeLb4E=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-ul4CKEEgMKKGcrU_IYUJ6Q-1; Wed, 18 Jun 2025 00:16:01 -0400
X-MC-Unique: ul4CKEEgMKKGcrU_IYUJ6Q-1
X-Mimecast-MFC-AGG-ID: ul4CKEEgMKKGcrU_IYUJ6Q_1750220160
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311f4f2e6baso6297273a91.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750220159; x=1750824959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0XrW4xN79OVxTyNN17bBcJQjURhuzlmM24bz9qYdiw=;
        b=V7DLUetHfvkj3tzEhaLbsiY/S6zxa3AGH7iU8yGYhRAvtk/kBidfljSMQEDBtlTWEf
         IQzO+dRW/8Zhz+pe0gVVfHrygbtEhQnG1PRsESUBA4FzE1/n2p1qbrH7UtHv0dckIgtH
         4IQEHNTSStUAZGxzti995KsW5IHqAQC/m2mNZcRRhvaezKLJGjjsYfLfYO9JETKEWFBI
         wqbfb+PFYIAVJFKOxMAny/aP+8QOtJLhEUtXLgwlFSZ8uiBIDNArggiOCJy1rTRp515+
         nQ0FlHOFrBJ69/LqFLuzyYkjqmMOqY7aVSDwfTtZ6ONs2vgqhZLp13paoJOa2PuxCP9L
         NIaQ==
X-Gm-Message-State: AOJu0YyF7OddHG8Bmvvub5n/RYPzMuxOwmaQfNeHATc0EY/9skE1qsHo
	qn8cFoCczaizhOdDKm0H0xsfosjT/qSW5J4z15v/lGs0naHaqPzB514tQg1Np8LDETP8MkgwtC3
	Y2dJ+cp4JfgnmA/5BmQhUlr/dzM8lPGyoXRSs+ONu66RwyyF/DzAFOrdi3IoNK4Tw5knSWjEQEl
	B7UhfFH0Mu2CiKyotM4h9uEhkPUaOzpC2Zz5ZA6rAnV8ozLbAwqT0=
X-Gm-Gg: ASbGncuu/AmV+Lf1/6MUY9LN4SlDvnZ69UFy3Ix48ZD4pNLFPzhXrjU+XeAs2SguB3y
	CxAdu3ZATI3bn5DBDRpGvT8I20NUcjkogl+KsCeuQMBeNuvNQj1EXe1SawRD6YhMODvny81nzj5
	Pytg==
X-Received: by 2002:a17:90a:e7c6:b0:312:b4a:6342 with SMTP id 98e67ed59e1d1-313f1dd5483mr28988680a91.33.1750220159026;
        Tue, 17 Jun 2025 21:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFuLyoYOgSiTzwKepjszz33MdUk50eBYdsjA/1ctDPkw5wMR7br/aU/RPzhVVhLFAY7750LHOS1u7DsXaW8G0=
X-Received: by 2002:a17:90a:e7c6:b0:312:b4a:6342 with SMTP id
 98e67ed59e1d1-313f1dd5483mr28988640a91.33.1750220158554; Tue, 17 Jun 2025
 21:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750176076.git.pabeni@redhat.com> <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
In-Reply-To: <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Jun 2025 12:15:47 +0800
X-Gm-Features: AX0GCFtZw39hoZQo2YXdk3d6m5-9stc94bQgOC2eqsoyfpHEpv8aEAeLDn1PL-M
Message-ID: <CACGkMEtMKL4U8LBzQqDcmD4ujoyMsTLztXHABz8zc8PgV-YOqA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 7/8] tun: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 12:13=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> Add new tun features to represent the newly introduced virtio
> GSO over UDP tunnel offload. Allows detection and selection of
> such features via the existing TUNSETOFFLOAD ioctl and compute
> the expected virtio header size and tunnel header offset using
> the current netdev features, so that we can plug almost seamless
> the newly introduced virtio helpers to serialize the extended
> virtio header.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>   - virtio tnl-related fields are at fixed offset, cleanup
>     the code accordingly.
>   - use netdev features instead of flags bit to check for
>     the configured offload
>   - drop packet in case of enabled features/configured hdr
>     size mismatch
>
> v2 -> v3:
>   - cleaned-up uAPI comments
>   - use explicit struct layout instead of raw buf.
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


