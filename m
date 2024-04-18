Return-Path: <netdev+bounces-89005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7AA8A931C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8551F21EA9
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BBA1CF90;
	Thu, 18 Apr 2024 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRNsepmk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A4123DE
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421890; cv=none; b=PJ62zXLvhdQhmWW2m0q0FezPwyRmPQfYrcu7+QAdkc7KuXG7NwXmrbKwLFu5o4mPso5S0ix2Qzsw32Vjz6Y0DdxZJbvg+ltrogQxPfMqZZfkmorthFFi6CP1tXHQarQwD6R4rUnHCI2j1ewrG1ud9t33f3KlBvQM/pYXY1iC3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421890; c=relaxed/simple;
	bh=Z4aTwWjCi/MnIGBbV6sZDaq4nJVU6aUu0Lp/2kiAj3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E62SsS6jLoRizUnTdQTy2ZOtBM9s6HG5OUzbc5Q7etOUmRh4Ln4AkpC40H29zMWK8Icf2BprjdeKuEp0cpwWFTPrb6M8C2g7ahSNqLsnZm6vUDLtSuWR2dTn8zj6j2tm05rV0X4nvi+FtGuKKCzArwl+2d+copE3DcOW0DZr6sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRNsepmk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713421887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4aTwWjCi/MnIGBbV6sZDaq4nJVU6aUu0Lp/2kiAj3o=;
	b=QRNsepmkVYzG08Qlt4lqdUO3pdLSBfrCqUtBY+8Uq8SzlZkcIdO1XMtpPPPyi5jZsHdzhf
	huRmpKS6mcL0WeGcAgfFG/bBi+XJcBCdoJBddmwapQs0qNOun5ARITdFQSTRPxglWwBwXj
	3IUy8LgzbYWKxVoIM/UqPf5uaUO16Ms=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-z2xrxWhvMQWr-m_9Zry0Nw-1; Thu, 18 Apr 2024 02:31:25 -0400
X-MC-Unique: z2xrxWhvMQWr-m_9Zry0Nw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a4a1065dc4so769174a91.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 23:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421885; x=1714026685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4aTwWjCi/MnIGBbV6sZDaq4nJVU6aUu0Lp/2kiAj3o=;
        b=oZ0BV+Up8Bi4/hO7LcqaV/4EB/cOz4CErqFDp6KcdWo5yP507IZqvJSW4aaRGVQx9B
         LJETSeOEcsbiCNMN42dd0AoRVC/CWKSUsZniOaB5x3MU3wGLTNr69oCu6o/Nkvwp+cFb
         LYUkCJc6BMLoYaRetfbJQZyKExFW5dSfwK3mdTq9+K1J1+VYN0cWjtIXLYlej4ZSbFCc
         dRVuHrvDCjbCA5FYz4y0FL2U3FOxSvoJpQxoM3BNyX8u8eWNHEvhzGUjSNCho7PwNTVn
         sI8zFxdexR+jrNiEWzoNcNX9JIn591DCAYDh3DONYw5pRIKnF/nnvoLqKPJYE7D9/zP5
         rEYg==
X-Forwarded-Encrypted: i=1; AJvYcCU2UrKL+QIVfMIuaHuBRbS5Ur6nqzkCvA9nhKItobGpX9RWFa5AsUUUZUhGUxhVINiCPpIXkvUQfTFCkU2wZz08/nHywY/n
X-Gm-Message-State: AOJu0YwdZdU3/Y3XZxSgMgswPgyxgvb0XvM3ENW2GlrUb8/1BVLaq8bW
	O5ncMCHOBsdHJH/wiC0ryWT7/LMR9YmN98K7YrNbnAEiPliVy/bnOBpJ2ZPJHgprGxGQR6yaPJY
	VkT/seTo/zTvqqKmq3Z9i7PnpWOgUpgQD2gTNqR4V5k4ZVxqI3qsNPTjPqbGdn2vUWC45oveLCs
	cv7JE6QGs2zxMu9mIzzYKrQvNh6ztm
X-Received: by 2002:a17:90b:534e:b0:2a0:9b18:daf with SMTP id su14-20020a17090b534e00b002a09b180dafmr1695018pjb.42.1713421884785;
        Wed, 17 Apr 2024 23:31:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyB5ocnOnvWNztnmqoLMVa/88NjPBu3Zp6Hqn5UxYJy04YcolmzPxAEiu28+YTF2ryVwuA7oPAdh93Y7VmIuo=
X-Received: by 2002:a17:90b:534e:b0:2a0:9b18:daf with SMTP id
 su14-20020a17090b534e00b002a09b180dafmr1695007pjb.42.1713421884522; Wed, 17
 Apr 2024 23:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:31:13 +0800
Message-ID: <CACGkMEu5j0KJQ--mKTs0pkEeMud_AbXMp705M-OK0HjvQ91BRA@mail.gmail.com>
Subject: Re: [PATCH vhost 6/6] virtio_net: rx remove premapped failover code
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, for the merge and small, the premapped mode can be enabled
> unconditionally.

I guess it's not only merge and small but big mode as well?

>
> So we can remove the failover code.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


