Return-Path: <netdev+bounces-196828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC574AD68F7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9353A3C9A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 07:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D641EC01D;
	Thu, 12 Jun 2025 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDYuOFRT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E47216E23
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713141; cv=none; b=C0bHIMsMFTwMriRlwv+fq8plXPst07GlVL/xbUKDDCOPLyAMAMKjgHZRKQSM8jipvDersXVyuSNlS1UvmxYay/GiX2Fi/fXcfYXYRjCBuoRcDpmMldUqGhN6wfZU1Mzn1/2kcnVZUwMcmp5/7gORg/PNpT/vYm5GVAkci/in31I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713141; c=relaxed/simple;
	bh=+D4CJpkdFyReV9euETz9WLcXlKqxJZxwzxQO+xgfM+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S3yyQvzuiM1uCyB5Q+eFQY+uKp5sNeZ9COKp14OSAKGPmvEMxI7/JOcdGNb+2KxuRrkpuCwCQ2keoXVuzUeA1z+GRp5NtTij4UUu0EqvTA7ZEibUtsI3wQiVJIoO5Ur18XtPy1je3lRqDu9tcX8nLJKkj7fTzTvVk1iCdWuCXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDYuOFRT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749713139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+D4CJpkdFyReV9euETz9WLcXlKqxJZxwzxQO+xgfM+w=;
	b=SDYuOFRTwSxxq1J91IoShuOqKG0BO75tlAtPcm07CZTQr18DjzNeNQWIpQvIg4r/81h4aH
	7SkNMIT+yH101/n1qm/SLyK0vMLKver0hXBfGsDdvM+hg2oYktA3i6NiUoUW/2Oy1zOFDW
	FOUkZK3RmsvnTcUqSswoPwpvNnshGrQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-EXU3gTRkPyivZBnZbIAXyg-1; Thu, 12 Jun 2025 03:25:37 -0400
X-MC-Unique: EXU3gTRkPyivZBnZbIAXyg-1
X-Mimecast-MFC-AGG-ID: EXU3gTRkPyivZBnZbIAXyg_1749713136
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32a6e8b0d48so3346121fa.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 00:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749713136; x=1750317936;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+D4CJpkdFyReV9euETz9WLcXlKqxJZxwzxQO+xgfM+w=;
        b=M4QFimyT9Mlljr5sMa+0KUahqkin76SIB6UK+XEcAK6/Hoe1mwq7DDSggeAWmY2Eth
         3/mkBqw+TQ9zXdBw2JtDEfKvVaM/MeMgvbtrx+B1lMecSwZeUMlwnudEaZ9Wf1cepRcO
         XpibkLrpNGtV2IgRi/mWmDD2KcLEFP2nMgXLx4wzeAqInoZ66CHFtKAmWfMBVOO8PhZl
         WBmaYbU+bdXX/ZiLU7FSmGNr/jF8vh0qFZ0PXbyj1GkIRmA6IsMxI+dESD+K84IX2tG+
         XNO4sQGY2S4I6dzVqLmaCW57pXHRjiF114nxeM2h4JUnzVGgKqfGp/ejiHpggs9TuG8I
         fPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl2xzl0TBKOaHvMfDEkxHzSZPHMH3/Q65mRr0ZR5t0Yr7VydhhtWn9hWa05vrSPfsAIfDCv5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbGBWRK6LPEPHRDH14nXaOP9F0dKNuBHGku+K3GjaJEsU1ccz0
	snYwX1fn1tbfl7fuFZG3FmR+N+PvtIWd0573qQmxamkv/hrY9Hvvzq/j8ykM9WrMS4p3PPorCtr
	Jbazv68gF7RXmAbJCa2/OjeOEHlEH4swCmYudGRZoTo+VL+ccscaMiuXSOQ==
X-Gm-Gg: ASbGnctpVKgi56+/NS+GgCOD8unaNuBhT9Jce6jJgMZaSGsGtA2wuLgVwT+wHtGZLLY
	93JCkMSIroxhQTwG2KKcXmWRTJyyuIe5dakIiWh1meznO/vMmpiRexI9m678nPXf58AtCbz/hw8
	wedtNWfwOBrBg5uoQJeR5OuGW6JMGaV9h7u0efGLVluEPnVRZVjFTevWOZOEuCLGHpcp8x9ujRJ
	345O1WwyTOE0leaDGE2391HW8AVrW6YUAJ7V4+a9Ma2ZGWLTQhCrbZu1nsL8Jubizqn0uQuT1U4
	UN4ZX+5ga21E212MQrjp40sI3QKd/GL2oTYYDlHXAmoBxSw=
X-Received: by 2002:ac2:4bcb:0:b0:553:2bf7:77ac with SMTP id 2adb3069b0e04-553a6556fd4mr731254e87.41.1749713135743;
        Thu, 12 Jun 2025 00:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYXcIUPELqm844Oi0sfmBjt+dPKF9Oqlx+3OFLvEecnh1MblRL4rBN+Jxg88EOatPjNlEPHA==
X-Received: by 2002:ac2:4bcb:0:b0:553:2bf7:77ac with SMTP id 2adb3069b0e04-553a6556fd4mr731226e87.41.1749713135322;
        Thu, 12 Jun 2025 00:25:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1f76fesm17684e87.226.2025.06.12.00.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:25:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B64361AF6C9D; Thu, 12 Jun 2025 09:25:30 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>, gregkh@linuxfoundation.org, sashal@kernel.org
Subject: Re: [PATCH net-next v9 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <20250611131241.6ff7cf5d@kernel.org>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
 <20250409-page-pool-track-dma-v9-2-6a9ef2e0cba8@redhat.com>
 <aEmwYU/V/9/Ul04P@gmail.com> <20250611131241.6ff7cf5d@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 12 Jun 2025 09:25:30 +0200
Message-ID: <87jz5hbevp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 11 Jun 2025 09:35:45 -0700 Breno Leitao wrote:
>> On Wed, Apr 09, 2025 at 12:41:37PM +0200, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>> > Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")=
=20=20
>>=20
>> Do you have plan to backport this fix to LTS kernels? I am getting some
>> of these crashes on older kernel, and I am curious if there are plans to
>> backport this to LTS kernels.
>
> I think it's worth disclosing that the crashes we see are in error
> recovery on unstable HW. My vote would be to keep this out of stable
> until it reaches at least one final release.

Hmm, okay, guess we should ask Sasha to drop these, then?

https://lore.kernel.org/r/20250610122811.1567780-1-sashal@kernel.org
https://lore.kernel.org/r/20250610120306.1543986-1-sashal@kernel.org

-Toke


