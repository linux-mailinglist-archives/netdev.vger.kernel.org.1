Return-Path: <netdev+bounces-196708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AB9AD6058
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE953A2FFA
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF325BF01;
	Wed, 11 Jun 2025 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tT4KmrVq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97563226D03
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674932; cv=none; b=hmt0SqiXnt1K0NASME16kcQa0AEavo4xGKzKZtapGITGpKqrggKsALnOYeXyEfZssD7zr9yuwLPD0cx3iBRhqTe2+dp8ENOZzUgMQlN2Rjosv52WlapxmW2t91oDoLjdZ37188mMIEkDt14E4loioSx91AAUkHtUW0cbXCrBfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674932; c=relaxed/simple;
	bh=dy/Bwb6Thnom4khEjtNBkceEkdwxV066C0Be2MDTp9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWLXiMGg9tA5fcG+Y5aCxemL6KvpgEM2Xved09X6Xikf+2nkUqyPccpJ/5IF9s+CqDc/lpjcCQwBED8IvD/paETc657C9VEtPprIoxThdQt0O8o2cp5dRpCr4cSACZdilyMybCctqgyfxAvZBIiD19BjTwRZ73hZMh7eRZyJk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tT4KmrVq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235e389599fso57815ad.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749674930; x=1750279730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUvCi02xABTrop0OD7rFaiszrr+jU6INxefWYNqLLI8=;
        b=tT4KmrVqknjLs8qzr6UWSjt5mo+eef31F2aM9nz5IspAqwF7Aa1JIungUKk8h1qzQg
         uaPVaTBDZ5Y0Mr5HtmLN+w5CwseQTY1cal77Njj43cE8VM44xAQbglfBILtphlcZIF/5
         sqOkrVvLIqiL54+Fbqua2BvovxTIIjikNV4ei8OGaFG6XZyDqibGz1N3u8Ycz3OH4Msk
         HLjexu8cSIrp9WRrCgmpNm2GmCY+YLk5766s8X5M4Vkd4tVB1eJea51xcMQvK7Ugr7uI
         tByho5TjJaDxnZtLY9LuLVDSGJYRwXPm4H5hp7KO4zt2pT7LBD8OV4rS7is6YU8ysHHl
         SNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749674930; x=1750279730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUvCi02xABTrop0OD7rFaiszrr+jU6INxefWYNqLLI8=;
        b=ipIcJiz8oEB9zNJVOT8CkzmRoVdBV7tyAfo4hodEW98KQs3j58LSTcanqsmUYWs9+7
         v/9/PBSPqDb1GzJNdkjJOxQ2ave2uIuSlsfJOzH7FCqPOH7kgWSF/TzJo1Cb/cc2Z6FP
         OHezi9V7nGJnb08N1ZNhU+PBXflldbt/RoE0eqBbKRP6zdNlAoJCWmA5AlpjdrpZcLqW
         v2oY4S7ZqSgcinn4r2zcMifyp2HhlMPnYr6P0VfOyMzKUxkigKxO1aebj8GmX5otCxv2
         Gf3ItBRSEYmucO3XRizkkcWaee+JSVIXSSXmrDYn604oyO98NQcJrzgWoRyJGePmNBmz
         Tesg==
X-Forwarded-Encrypted: i=1; AJvYcCXobcUQu+cK41WHthNSr13nKqbkTy7qgbCXAU6+uMVe3LFrDMNzs/UchT2W7NJPIq41qYgxta8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHeIW+ZE/xhbg6+g48eEice4svBSsJYtro38+BRAKl0roEXXDq
	0ORkyVgh8vHP5iuufu9ZRUypoHjMJ2NJizBVgqzGvnnhAX9S6j7kmyPko9w9A32lsgQbi50Yt8I
	4CUHPjiSV6Sj80AV0mjsYEF8n0qE+SjRkYvMZZwG6
X-Gm-Gg: ASbGnctE3LK527IeWPLxOkLnG++WRfZEJ654/mUulK6It/KIE3vlTwWJu1S0rH87FRR
	8JLZ+YJxzBzUGIl4qK+9Wt+HEzK50qQdH4GM1zf6Knvy6rrFfzP7fwHhjM5rF+r5itYdo3twEZf
	/fI/hMQVZWmCPdjCZZnNfRZ7mJkf6oE2C7bF9J1LA9mjC9AOrAwXzmwIH1XXav8+/pzCiXOkQ7
X-Google-Smtp-Source: AGHT+IHPOhN+2kRO/ieW+5bXzKNpmLOWrF7VTuuMHfPxMqYhDS9sFU10fG4M5zXkX7CwS4WlSGyc/8tNtPMJ+fMmqfA=
X-Received: by 2002:a17:903:2ac3:b0:231:d0ef:e8ff with SMTP id
 d9443c01a7336-2364dc4e38fmr398195ad.8.1749674929600; Wed, 11 Jun 2025
 13:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609043225.77229-1-byungchul@sk.com> <8c7c1039-5b9c-4060-8292-87047dfd9845@gmail.com>
In-Reply-To: <8c7c1039-5b9c-4060-8292-87047dfd9845@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 13:48:36 -0700
X-Gm-Features: AX0GCFsiObw-5gr4V36jOF5DxyaQMi5Vz9ZSIsC4_vLQ1YuMrAJGB2FI0rG1Qcg
Message-ID: <CAHS8izNiFA71bbLd1fq3sFh1CuC5Zh19f53XMPYk2Dj8iOfkOA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/9] Split netmem from struct page
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 7:24=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 6/9/25 05:32, Byungchul Park wrote:
> > Hi all,
> >
> > In this version, I'm posting non-controversial patches first.  I will
> > post the rest more carefully later.  In this version, no update has bee=
n
> > applied except excluding some patches from the previous version.  See
> > the changes below.
>
> fwiw, I tried it with net_iov (zcrx), it didn't blow up during a
> short test.
>

FWIW, I ran my devmem TCP tests, and pp benchmark regression tests.
Both look good to me. For the pp benchmark:

Before:

Fast path results:
no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.337 ns

ptr_ring results:
no-softirq-page_pool02 Per elem: 529 cycles(tsc) 196.073 ns

slow path results:
no-softirq-page_pool03 Per elem: 554 cycles(tsc) 205.195 ns

After:

Fast path results:
no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.401 ns

ptr_ring results:
no-softirq-page_pool02 Per elem: 530 cycles(tsc) 196.443 ns

slow path results:
no-softirq-page_pool03 Per elem: 551 cycles(tsc) 204.287 ns



--=20
Thanks,
Mina

