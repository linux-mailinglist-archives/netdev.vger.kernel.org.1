Return-Path: <netdev+bounces-213558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632E3B25A3F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 06:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4AD5A3701
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 04:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315C71DB551;
	Thu, 14 Aug 2025 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Se+RYzgq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169179FE
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144098; cv=none; b=h3/gq6IY/6XJVe7gU46e1jLkKJQpYOiGcZWq9xLg1eanvgh6NI+q3VhUI2vQRAbuTveIdqRA2RX0TjNEqtSqyGYSObZQIWM6TVqtFKjnkSLqh4mkhqQZzQl3ZWuItzI0htDBZad0m4bzc5LLPIvw3tKXK1e1+GkEfZTm/LQtvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144098; c=relaxed/simple;
	bh=E+IcJ9QjPVmPeRoFB5qG4f11pCnEuZsgs4iWvpgqCc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fG63fnBlkUCsBC+w2CZaCaIxDrifDEXwO/4XUIulRJBxSUi1FgYlX4Un7oBDzkgppHCd7PlGybfo5dbxLrRe98IJHhZkSYTkAzA2sA+JZsxRBKq+VgBoDNj5ybmknfMBFTwDiE9GRQO1qqxGwUn2WG4ooaSYTXPsc6neTaRkp3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Se+RYzgq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755144095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+IcJ9QjPVmPeRoFB5qG4f11pCnEuZsgs4iWvpgqCc4=;
	b=Se+RYzgqLUxw9BVS7gdq/ynPFqRyQKT0npHeus4N6xi5kiDzoo5PvK0jBsH9n7/9zH7/zM
	hWCjoher6Fyv/Fs2v6/5JHj5/kaIRZOtqMAhWa6ByLwz1OUvQS3Y0aAWY6NQgTTpzZPDAy
	65BdLGUcxNyG8VfjEFi643hwq2b2lIM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-9QzGTcE1Oe2zNKrJyQxqDQ-1; Thu, 14 Aug 2025 00:01:32 -0400
X-MC-Unique: 9QzGTcE1Oe2zNKrJyQxqDQ-1
X-Mimecast-MFC-AGG-ID: 9QzGTcE1Oe2zNKrJyQxqDQ_1755144091
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-323266dcf3bso492467a91.0
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 21:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144091; x=1755748891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+IcJ9QjPVmPeRoFB5qG4f11pCnEuZsgs4iWvpgqCc4=;
        b=dmgI18HhdFwd5UDDluE3EQHfy9eRcuQz/vVc1hZtu61xG37owCQvRm+ntG9BtIMLeP
         uY3XRKlUf7sqfj7/UkmTAC1NkeRz5gUvQExH7eQjNrj9dCe7ZBmT5WCBJaYOyRC5s/Gb
         QGEVq+zD3mIM2yVT3uSMEFSmxsiN0fRciEyB3nGgb+oDVqRudFLcjHihLmULEzMT7+gu
         5Rrfkyc5zdoVVbmpNf3Lwhpwf7YOys8ZSu9bsIHs564YmW6uCPXXt+rVOIjUW6jZX9xF
         Bu1Jnb/k1IVULYneTPOvSGPwdWRlia3C+DqyL7khGq6RwN2uGAWxjATU+EVBGgQqGdGL
         xgVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR/pPyjMyk8uQkJ/qM1siHeB0eK6OoxWYg/D9g9Nd14038qBkU9oF3vVaFifMovnjKBVC0+6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+X6sigkSRPE5OgJMaqUoVcxBMTb6IBKyJ8xT9fP+VBrSuyYA
	2vnhmRZtf0xupwRhAOR97TolqM+waMPhlOg+lJHraLUDIddKn30fwAFgpL7FEk6owBGp1pCgU0i
	eWMaCApQsfhcJSqwVAIE55D4zbM5qotyckqOb7Ik8zs+YrF90+JUwcXRA4YQdqgoVQFf1nfS60f
	kIrVFQuDzJyyM8e06HR+r0aH/5tD5PAFlr
X-Gm-Gg: ASbGncvRBxuHd3Itr/R9frDbiQkrynFuRGcW9eWcYCwapOZ0qN6j+Y31+u5ntYHrUzr
	9KD4Af9AJ2VXrWCx7YUF5qWU0lODnu0u7BIDm+Kg+ERYuId4iQU9iGjUleH3KxjbBKhdECGUr/S
	qX+mD8C/7KacCRmDTUmT9hZA==
X-Received: by 2002:a17:90a:e7ce:b0:321:9536:4b69 with SMTP id 98e67ed59e1d1-32327b590d4mr2435288a91.27.1755144091266;
        Wed, 13 Aug 2025 21:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlgZcQQu+mkUi1deC7sDjvQ9QuH1SATW4bpi1PSZYoAkkkYuzX31t0W1PcNStDaF/dAIVS1DhTpkg+BudaI2w=
X-Received: by 2002:a17:90a:e7ce:b0:321:9536:4b69 with SMTP id
 98e67ed59e1d1-32327b590d4mr2435217a91.27.1755144090770; Wed, 13 Aug 2025
 21:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250814023554epcas5p4b3dcab50835e2da4749be1be135def20@epcas5p4.samsung.com>
 <20250813172307.7d5603e0@kernel.org> <20250814023607.3888932-1-junnan01.wu@samsung.com>
In-Reply-To: <20250814023607.3888932-1-junnan01.wu@samsung.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Aug 2025 12:01:18 +0800
X-Gm-Features: Ac12FXxgn-t3KycHNHz_KyALlzCrfoNrRoAOOEeUSfgRjxzlZkWqFGNrg_7ImpI
Message-ID: <CACGkMEs+RCx=9kun2KwMutmN4oEkxzW4KDNW=gwXNZD=gpetrg@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, eperezma@redhat.com, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 10:36=E2=80=AFAM Junnan Wu <junnan01.wu@samsung.com=
> wrote:
>
> On Wed, 13 Aug 2025 17:23:07 -0700 Jakub Kicinski wrote:
> > Sounds like a fix people may want to backport. Could you repost with
> > an appropriate Fixes tag added, pointing to the earliest commit where
> > the problem can be observed?
>
> This issue is caused by commit "7b0411ef4aa69c9256d6a2c289d0a2b320414633"
> After this patch, during `virtnet_poll`, function `virtnet_poll_cleantx`
> will be invoked, which will wakeup tx queue and clear queue state.
> If you agree with it, I will repost with this Fixes tag later.
>
> Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")

Could you please explain why it is specific to RX NAPI but not TX?

Thanks


