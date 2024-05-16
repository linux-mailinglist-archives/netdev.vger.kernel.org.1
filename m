Return-Path: <netdev+bounces-96672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC478C7103
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 06:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847511F22363
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 04:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E350107A6;
	Thu, 16 May 2024 04:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjGOq4TG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880D29CEA
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715834869; cv=none; b=CMFoclJRYwPEByD6pGZ6vxLdRW6iLysUnDKMjIw1n/HWvsFIpyAaG9s6kIlg+rpjOaEtr1PY1yFynm2LbMSO2YoQD/5aJeZYTeYLeWVmlzq/jrc8lYs/0yOv9J8XdnFjyJAS/Gs3C4qTkLGoBQ+xSigOa+HAuzO1TeIVICN2zso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715834869; c=relaxed/simple;
	bh=Y+hSQ+Eo3s4/YSUffx3V0qw21OLsNhzKiR+hK/TFgUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkNq1n2FPdczSMTlYqlIODzT7juxiM/uI7dnxl5myCjU1SzP5HBMs38PQoMhzKnEUWKovdVqCQxV0j+61E0sJdHXCUQ5sz80993Muqnpx5E2bNuN4I4A+quW5NSZwDuVZ8UpnR3XT9YGXf6+mgIn02W7aB72pUUb/MzmKkQnDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjGOq4TG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715834866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+hSQ+Eo3s4/YSUffx3V0qw21OLsNhzKiR+hK/TFgUw=;
	b=IjGOq4TGjZ15OUN8HmS+hZhdnfzBOxrUYdZ03YkOr1Gg3D438eqjbBhgDAC8xUiE8swxyO
	C3t8tl5khh4xmUPNjqor9cYAmmLFmAQm+lepS5uO8e/uyUJRL59A03PzmfSBskFNGOdtOl
	PDEoDtmQX9P+uPeIwOUojhnfBUA7q74=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-KiGnXy4RM2i6WH1dRumuoA-1; Thu, 16 May 2024 00:47:45 -0400
X-MC-Unique: KiGnXy4RM2i6WH1dRumuoA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b265d41949so6677773a91.1
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 21:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715834864; x=1716439664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+hSQ+Eo3s4/YSUffx3V0qw21OLsNhzKiR+hK/TFgUw=;
        b=r5fi24TQbyIBwGCc2IqDu9Xen7bSQkUCC9319pD14IOzkigHD45+VGJ8MtVo/kaHCX
         xhjKP/DV67gB7hOfAa61HL2VXOOm1a/gjBDRyhKGMe5+VIRMiKTlKM17deK4aIKC02M9
         itM6Glb9MYEdAJw8VyiklSAsfaDrOXK0Ia5T5QptFpuoxavVmWCRPbccqK16jFvFPbRi
         3FVJq4hcYm9Cm8BzwVGFQWMOENEKc/Y6Kv4/JWEg1pWZw9QNW7z7kMRMq3JlO4BRKC3Y
         GolAqXAeJL04GNZQTtm8Qvi+0Xrf2/ndIF0yCa6GZDhTBkHQZz6I2Rh1PvcBqkEQdsAE
         px/w==
X-Gm-Message-State: AOJu0YyMDetmTjgDEPoIKI43JzC+LwSRCFPQ5IPkGI0cZa3qct+enUem
	5+8UxmmNWNUtNXNjrL8xAYaYH4EnKPeU+PXlstPDkBiVkKvRLHWaFdfFT/AKD06OjmXrhDOdtK3
	zqGbfUTJj3scxvBAM/0wQqORHvzs5wPvYPNc/ywJP66vQBEffpXqI6hBSCUBAxum689MHScxEt0
	vcj7ELRhX5IdoA/C+xgZ9rPsrRTnv/
X-Received: by 2002:a17:90a:1549:b0:2b9:44f2:eca6 with SMTP id 98e67ed59e1d1-2b944f2ee4amr8182197a91.25.1715834863959;
        Wed, 15 May 2024 21:47:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE2c51njQXV99PnsZamB8UQqh5DsdrmFenPfs4PgLHNR0d5D/evzbeZaQRgsTeAj0DTXb4g81NcXQohepW61I=
X-Received: by 2002:a17:90a:1549:b0:2b9:44f2:eca6 with SMTP id
 98e67ed59e1d1-2b944f2ee4amr8182182a91.25.1715834863559; Wed, 15 May 2024
 21:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515163125.569743-1-danielj@nvidia.com>
In-Reply-To: <20240515163125.569743-1-danielj@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 May 2024 12:47:32 +0800
Message-ID: <CACGkMEs6dcPvgrscYdDyyC7i5qHZ8+BcbGMUhKOtaec_+UMyOw@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_net: Fix missed rtnl_unlock
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com, 
	Eric Dumazet <edumaset@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 12:32=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com=
> wrote:
>
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
> Also changed the allocation to GFP_KERNEL.
>
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fh=
c8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


