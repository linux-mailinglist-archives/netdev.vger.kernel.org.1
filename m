Return-Path: <netdev+bounces-198868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B99ADE127
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FAE189B976
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 02:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A216378F36;
	Wed, 18 Jun 2025 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ogls+M8B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BEF1A08A4
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214223; cv=none; b=peHo3RMgKcrM9khGHnkHvQHylJ9t3fmA4njkLhjZ5pXaMps+Djzpx/KitFKTYxdDnGgB6IAgslxykHY3tCEfoPcyc5MojRvg5M9lfFsznf8vlM04nTMVEGNY5GM45pg7PLCRP8jh7FNwohLl4feK5l6xDsaT0/BdSQTdzFaOXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214223; c=relaxed/simple;
	bh=zCTAi8gefriT5heozI4vTsZWDN8qPafoBOHcO3SUBPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZqZ0mXqDxbDWfG9TA1TRCz/Q4tn7GNz/lBxCTDwTQGQeajAjO3LkSqQLQedYcOgJm+63MFYIrExVqTpPW/iaF1zanOzMUrrLetZ9Dey+2qzpRmx0UWPfxd1ItKQA9B9UsvlfnFr97AgdDkp2KFgeboeeY6AQGYkHB8QL5NRK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ogls+M8B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750214220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCTAi8gefriT5heozI4vTsZWDN8qPafoBOHcO3SUBPg=;
	b=Ogls+M8BXlBsdxEv3rBvCKsrzbIaLtXLL1pshd4IMAfdJFYbCDNdZ9f00wiBFo9KmsCnCt
	nw5oYiU1CsYye9ogs1GoOVP8IYyUQ0KJ1gkS3OJlT58UWwJdhI8ffHKVVOSjHLhcGy6Qhw
	Q2+AJn7BPvOvRxpYiyZSiPr/SxBAmEk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-WHzeWvE8PBW_Ipjfyl7UpQ-1; Tue, 17 Jun 2025 22:36:59 -0400
X-MC-Unique: WHzeWvE8PBW_Ipjfyl7UpQ-1
X-Mimecast-MFC-AGG-ID: WHzeWvE8PBW_Ipjfyl7UpQ_1750214218
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2eb60594e8so4064784a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 19:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750214218; x=1750819018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCTAi8gefriT5heozI4vTsZWDN8qPafoBOHcO3SUBPg=;
        b=rrQtma2lGJIFaOzyp4FjXqn37fSKnelxRStpDYQF2YSLy87NphS6XcJQuXYMYP8gQW
         MqhTDMtn/x9lIH9r9f5FJq82Johh5UdViABhUSku4Iz5hJGKEOrXwYVr2bO3vBCe07uH
         iuRjZbqXT7TMF91dfbPNwKvTj3l5PIQSznE8VswBCDeiGBOhg1hXLMbDQYkwNrCpoxnN
         aMk7a+OA0g6ry9iYlUHlZaeUEDS3lj/wG4e06xYIXCsIgKPKttYp5T0nzYW8MeQtxMsa
         t/w74QGiVG7tnemMMWXRFN8y/M10W3ZHV4ssXL4D2+W9xIuMIwJPF//l2bViICJl581D
         3/dQ==
X-Gm-Message-State: AOJu0Yy/4JT5CARkZS3BB6skzlUtQzf7DaUu+QVMvdmJtQOA+S3ta/UM
	dIR3DXu2r7i3UYND6ZlENNoQtaTE+6BFY22Gh6rAFRHA/m6Mrb1rpNwKbu6csSqANQw44gldRVZ
	5JVeXky74UlDtdYO7QLs1Ne/mUbVL/ayJwi/PiYbM8fvvLPM6RiBxJDJBel0X1uW4OoCF3te0DF
	nptSq1pxIk68ab4dqnb62/ZLToLk8t03o1bKfESsCrtcsg/TU5
X-Gm-Gg: ASbGncu/xz8JTD4YwRzvaHurQW6vtpheFLa3ACw8rEMDyHwITiIj45xsw+mZz5qNjA7
	ZOpTssqhU8c+BbIHPVEtxVMhBPIPXEyiMOHZjgCThiecMXhnCXw0XQqV7Eeu/G3/5jtrfNoGbF1
	M2XQ==
X-Received: by 2002:a05:6a20:a123:b0:217:4f95:6a51 with SMTP id adf61e73a8af0-21fbd7af798mr23625559637.29.1750214218024;
        Tue, 17 Jun 2025 19:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER8W/gaz9Iia8qgHNQx7v5IO0lrt2J7J7RL61AgDGKfZ7q/yER/mbfgYCV3QeynKT8OzI3vqi5bQhkqlxR0vo=
X-Received: by 2002:a05:6a20:a123:b0:217:4f95:6a51 with SMTP id
 adf61e73a8af0-21fbd7af798mr23625531637.29.1750214217640; Tue, 17 Jun 2025
 19:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750176076.git.pabeni@redhat.com> <fad17d61c90caae4dcd56ea21e0ce6df8f2336cd.1750176076.git.pabeni@redhat.com>
In-Reply-To: <fad17d61c90caae4dcd56ea21e0ce6df8f2336cd.1750176076.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Jun 2025 10:36:46 +0800
X-Gm-Features: AX0GCFvcrIhuBYoh6XZr8DJLmavu0bzqilksoAcDFPoIBtG2WS8qbF9Fa9doBiA
Message-ID: <CACGkMEuBp4U4XHOGSSaDaQv2Y_ch5eWaUNazDbVx-fviHkr0jA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 4/8] virtio_net: add supports for extended offloads
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
> The virtio_net driver needs it to implement GSO over UDP tunnel
> offload.
>
> The only missing piece is mapping them to/from the extended
> features.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


