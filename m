Return-Path: <netdev+bounces-178904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150E3A79816
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 00:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A84171ED7
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16D41EEA46;
	Wed,  2 Apr 2025 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EanQx18j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B76D1DFF0
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743632233; cv=none; b=LbYBXZar6SAUrRi0YTYqa19VjN87K4OqTvJeh0k3r/2Pvi8a77dLu6/9Tjzm/ZHKLESTi24S2X6ic6XV8JiR/8dj+2ppzeP96rdwl4n+KF+B2wmzFIw8uHfr8lxH+iISfIVNfMm09Q6+7foMsun+C4lDxDa+QY91tt2AcemEuIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743632233; c=relaxed/simple;
	bh=DXdIEcsktd3naZQba64jCvksg3ADoJ2wFaYLji2Jjy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eo7/XZvHkxVQa7zoxYKdhN6QVvy6B4kuJbbL1nuO0+BScZ56ubM56tGbuBGCsPxmMgJsSl7hXeeaaujsSbGjdkydM1CP3s2xJNlzH3shNGIz3CKy3UEIcPtX32mBBjY5fyVZFS+6y3GnTL/bNS2dLByD7qULY8iXiWTBfgLENXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EanQx18j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2242ac37caeso232995ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743632231; x=1744237031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEgZqWUEvE4WF6UMal5Hd55PofkbZc1vxIK0j1p4v2g=;
        b=EanQx18jR+tiGlp5VIFxxAGobwr6RqbtUfXYKcPekofx8a+tx/RdMKQmgcs+j+f1Ah
         vYu+rdaEO634W137WBELq70k9g7e0BvANWNemEPijXM3X8h+5Cx1hV/P9kmuUdXC8D56
         FkF8uU15be6cqDoQW+LoibrOZvk7Zcg4FemDavAH2hgCjOoJHcFv6fEwBC3ka6sPFvg0
         xFehesm7nnafzQZ4pWLTdqZPHNB1aU9Ma8maM0kFA9MZ1A4R/s3k27mnQmJkTiQrMtzh
         6TcS6ULvAOpzxuVyg/k0ABbRv0a4wQroEVJo7W7nL991cSReuKzlBl1vTM98E791Hltn
         Rfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743632231; x=1744237031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEgZqWUEvE4WF6UMal5Hd55PofkbZc1vxIK0j1p4v2g=;
        b=g31u7qcka4Y5VQCeSQQSHxqjCQ6bUKtyZlxJzeU2JaiSkRBnkmPKhlnhmpkS3AW3Ug
         mFaMjJUZon/wIVJ09xvXA8T5y0p+ViYPS7bxDIsJwcr/l9j9mt3ENNb+eL2l58A91gmP
         1S22WX9Uqi8+8q4aarF5zMLx8tgBMQumoItqGlZ3lD/B8FXQAG4hFvC2EtqJ1eXvE/+c
         8z2wtrDO9M0oNOfPKwvbE0PdSg0qT74l9QDaWkAf3NunlmKXrGahuOBuJuhP1r2rxh/Q
         xtumUwSlkLirzNHjV8HjrDQ5aicBCVSTEnlhJEKjr3ihwyh4GTob1vY8CBR7RGPq+C2F
         vROA==
X-Forwarded-Encrypted: i=1; AJvYcCUgdxS+v1J0Fi1NSPtc8Pa7hYgOTAiPiGepZ32/CUlrfkOW8T0vgmtQ5F9UaRnwEYFHqQC2njg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu0AJAiwsdgp229qFHkNBRMUoAALusyVhjYb8J0XXkBlweD/3p
	XO8lKtslx5Y1SCd1iZlDBFcOsJGtFUXyKeA1rZu1cYmLZaYpiky7oOxvCQ1m8CPRLKEtrfMwkvV
	aR+a1RjoddPyx4zX0WtCRSxNExsbOSngGpHNt
X-Gm-Gg: ASbGncuEC8uDYP+HTlKOU4oQZdS9BTLfKecidqvja4oJQ+Ek6h20wyf9ufRMdlFEEUA
	lTd/c3iV1jqMYCVaLFLp3NhWjDc3vwjOrCbyg4bhFxFn4JMHdo6LiCxjPhS6h1lRYKrAHgJOsZt
	IOPFJ3BKT3gKP8F5GLlsHMvvt3s1hdjfNmZMi4/MQEb/3HnPexrBNp91Yj
X-Google-Smtp-Source: AGHT+IFkJXqASTdWgYjSuy0KiObAwYK0CjX8f+BUYTjVctb7IKuP+yOr/qy29nI6BZTdzwbVxuOa/LHeD/pLFcH8Aec=
X-Received: by 2002:a17:902:ef0b:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-22977448709mr1168025ad.0.1743632231310; Wed, 02 Apr 2025
 15:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331114729.594603-1-ap420073@gmail.com> <20250331114729.594603-3-ap420073@gmail.com>
In-Reply-To: <20250331114729.594603-3-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 2 Apr 2025 15:16:58 -0700
X-Gm-Features: AQ5f1JqCqmyTQ-MamJNRm-t_SKgG92ygJiqG3WZNvwvtxoe62pEtqZzcBZ7AdD8
Message-ID: <CAHS8izOSaXcLB-8U5gFD2sj+pLuq+jMvPHPUj8bsaHzqG4cTsA@mail.gmail.com>
Subject: Re: [RFC net-next 2/2] eth: bnxt: add support rx side device memory TCP
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	ilias.apalodimas@linaro.org, dw@davidwei.uk, netdev@vger.kernel.org, 
	kuniyu@amazon.com, sdf@fomichev.me, aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 4:48=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:

> -static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
> -                                  struct bnxt_rx_ring_info *rxr,
> -                                  int numa_node)
> +static int bnxt_alloc_rx_netmem_pool(struct bnxt *bp,
> +                                    struct bnxt_rx_ring_info *rxr,
> +                                    int numa_node)
>  {
>         struct page_pool_params pp =3D { 0 };
>         struct page_pool *pool;
> @@ -3779,15 +3799,20 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *b=
p,
>         pp.dev =3D &bp->pdev->dev;
>         pp.dma_dir =3D bp->rx_dir;
>         pp.max_len =3D PAGE_SIZE;
> -       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> +       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
> +                  PP_FLAG_ALLOW_UNREADABLE_NETMEM;

I was expecting to see a check that hdr_split is enabled and threshold
is 0 before you allow unreadable netmem. Or are you relying on the
core check at devmem/io_uring binding time to do that for you?

--=20
Thanks,
Mina

