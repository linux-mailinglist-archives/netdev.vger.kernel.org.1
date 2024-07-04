Return-Path: <netdev+bounces-109268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABB49279E7
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8661C2456A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9D01B1419;
	Thu,  4 Jul 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAw4I7ZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB611B1415
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106436; cv=none; b=kolcPbPPJNVQseC5WS29DpE0OYaz3Wku5AQA3wfiJtNZyCITqlzO4fLPeHZAZXxjJW7VwRsGpDaa7TxJM/DfTzN2rHRFirA+XobBluFiMtuDgtoR0zn1Q4uJCdrdycgfBhADnlhf/1wkLlzTVXQ5IgyxfxB6hvfHp9fv73E/kbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106436; c=relaxed/simple;
	bh=m1MSzlO1UoTFgOYGm4bHdM2hcVgh4Gj/4/U6sShVFck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIdMa6dc29hlW02Pr5Ry4unp8+n7BV2sdobTH0MKcHLqDllxLgPTqzq1Cl25hwyRV4zTPc3sv0EOH7FEUouXRxbuaD4ibAAJzAaCCmwCm/asJQvS07vpPTaEA3In0d61Ov86LZog5e3yJJshuESeEUrJunuJfauoqhLAqvU6KIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAw4I7ZJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e9a920e73so794803e87.2
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720106432; x=1720711232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1MSzlO1UoTFgOYGm4bHdM2hcVgh4Gj/4/U6sShVFck=;
        b=DAw4I7ZJick/HYSN9SZsSmSoHczd036w3E6RQF/UDUd6i5wDDfbqjuDeFQx7JjZEjH
         lAqux1bSjjuOWpyn/Zyb8egYRCWYxjWyhDrOpg2/6PLDYbqC2wSin7ZJK40K+O6A+dnt
         JQZWELmc8ialZYcuud6yO+IKXow8dw4/U/vT8bnj9TL6ah4A/ZbYlDvCBJTd+bh2Va/5
         Z2wnXOij4VXN8dwNxq9xSn2bq8Gog+4eRbNwtmPt29vP+CQkjdqSEiaDGRF1QNgqciJi
         shlgSbGM1LQu72ZeoBSTLEskrMCaghA2E0lxhU2Ra+heyEKxAv35wNvRnSxlBof+8K70
         9NxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106432; x=1720711232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1MSzlO1UoTFgOYGm4bHdM2hcVgh4Gj/4/U6sShVFck=;
        b=QoIUgT7Jn4F7ZOHMesFRNQxz0LqjX+VOy1rncHUvxrsIAXbqwCJapUR70WWMnFUtYV
         dVvBI/KWLjbG+0r98DZO/CYI7V8nVQHP3X2oBeJbD0qX+sci7eVRGfesPEVniYJ85x7o
         U/n016Si+eOYQfnFj+prZyxIVByyjDez/DCFPw5gk/cfupnXrnwZEmicCu16/WWIJf8S
         noVPOicoyKclwCzPcuyfR/0UXdU1ZVOEec42cYAE5He/A40UrMk6jxss9YF/b1IJaUv8
         wZ8wBpuKfEPKGkRpkkO2UWaHrxgZTSep1K1BkunsMucmpMEfGYsVr6g4lK5LWwaJvCCy
         Ez+w==
X-Forwarded-Encrypted: i=1; AJvYcCWYk8NnCvY3ZpojuEomRWrpVAwJCJuTquEu+YuHPV18YEKmlXihWEG6rWbIJEkkwOVG384VbjS+5It2eFtN2tbftP1nLEkK
X-Gm-Message-State: AOJu0YwMktmyQQa7wPJtm08mQhPtmHTRprGKZHmhMQgs7yCgLOBNu/Bj
	LzwebKIllLLGlYFBAm8EYyeItigweA8reEEWCRMgCzpXCwu+lC0HjctoTnpejQQ4KR/4qDLT3su
	uG8Z9Ev+N+N6TGZc4itR/GQqdwd8=
X-Google-Smtp-Source: AGHT+IHgU8m/bAYFZTEp3gyeBmKUS86R6KiPpeOSHKpEjKHWJkzWnVNALIFITjWt1C+BJzyZypoFCmh8HHfYSwnPOmE=
X-Received: by 2002:ac2:5dfa:0:b0:52e:9beb:a2e2 with SMTP id
 2adb3069b0e04-52ea062d034mr1319098e87.19.1720106432220; Thu, 04 Jul 2024
 08:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704074153.1508825-1-ap420073@gmail.com> <20240704063325.7ddd6e8a@kernel.org>
In-Reply-To: <20240704063325.7ddd6e8a@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 5 Jul 2024 00:20:20 +0900
Message-ID: <CAMArcTUNz7rABdgk2TMZAOSpHFr+fW8cu_X1jHa1H4j3MuUUBg@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: fix kernel panic in queue api functions
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	michael.chan@broadcom.com, netdev@vger.kernel.org, somnath.kotur@broadcom.com, 
	dw@davidwei.uk, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 10:33=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for review!


> On Thu, 4 Jul 2024 07:41:53 +0000 Taehee Yoo wrote:
> > bnxt_queue_{mem_alloc,start,stop} access bp->rx_ring array and this is
> > initialized while an interface is being up.
> > The rings are initialized as a number of channels.
> >
> > The queue API functions access rx_ring without checking both null and
> > ring size.
> > So, if the queue API functions are called when interface status is down=
,
> > they access an uninitialized rx_ring array.
> > Also if the queue index parameter value is larger than a ring, it
> > would also access an uninitialized rx_ring.
>
> Shouldn't the core be checking against dev->real_num_rx_queues instead ?

Oh, I missed it.
I agree the core should check dev->real_num_rx_queues.
But the current devmem TCP code checks dev->num_rx_queues instead of
dev->real_num_rx_queues.
I tested the below change, and it works well.
So, I will comment on it in Mina's patch.

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 7afaf17801ef..da27778c2421 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -146,7 +146,7 @@ int net_devmem_bind_dmabuf_to_queue(struct
net_device *dev, u32 rxq_idx,
u32 xa_idx;
int err;

- if (rxq_idx >=3D dev->num_rx_queues)
+ if (rxq_idx >=3D dev->real_num_rx_queues)
return -ERANGE;

rxq =3D __netif_get_rx_queue(dev, rxq_idx);


Thanks a lot!
Taehee Yoo

