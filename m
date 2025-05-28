Return-Path: <netdev+bounces-193838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399EAC5FE6
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 05:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCA99E2D7C
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FF81DF755;
	Wed, 28 May 2025 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnbfP11N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6141C8604
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402177; cv=none; b=c5mjOFx/vk3vLmWLF+RxNQIkJ32jzvJY++h1ZPisc359Vse5fiR70kRTUaW4C+xKHxtUaGHcUo/4HkI9xRFXhnSieEQ1POZVdQAF/xFlat2oCWgeLYTLTIBLjgQYuNMI4XlCZ+VhlseuRi41gQ0Agk1cbcTs6M8tEtNhzx7YUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402177; c=relaxed/simple;
	bh=0bdtpndwZMuDSr/xS0AhTKAcuII2GsnyUAe5k1Utuqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8DWry4IN8p0BAzqzTD2rQ9G5patx+yucH1y5I5P2dGaG7oYPiJa1lQiIT1Nk88qO8t3GZQPmL05yA7hett7Cw+w9nWlGvdkEInLw50cstdhYmzZSuGO137g6sD0m1Vf/gTF+ZpYBRnPj4MT6NWOA99sWxFi2Gw0GHv2/9T3QYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnbfP11N; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2348a45fc73so107465ad.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 20:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402175; x=1749006975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bdtpndwZMuDSr/xS0AhTKAcuII2GsnyUAe5k1Utuqo=;
        b=pnbfP11NPQBkIarbw0bv5nZdtf5tIu1Hgy9LFF0tcTIG4Ddky2BuBRbmRqjkggpzNU
         X9LoRi4J2pJRQy6Ymj83eBvcdEh1fLI9xel3M1d/KdIBEqWJFeccOP3vL+MpStwgEEjj
         rWq1uI2CwKoKD0IalwGeIBuhFot4jgq9qVu7N4sYrfUwcNKtC229un9ocw9diQqyAdz3
         qriyP0oPIPu5tyLSGxtrLxosl3mybzLMSWP5Ba19qAb63I8+nRc4X27ztH3ZRDYndCcR
         qLhN4RMDMepzE0JGVqEfXZ1gPJ5ZUtN9TxHAPbNFXtx4+/VK2ATOqK3xD+2fb3dt9XxN
         eumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402175; x=1749006975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bdtpndwZMuDSr/xS0AhTKAcuII2GsnyUAe5k1Utuqo=;
        b=vu6rHhkdu5uEzWm5AErAWHrxEaQlCY+d1ZLZb7ZlL4RawT5C7ZjcMizK8mEHLXztVR
         Vs0/jVllrx1cUBffrnGsctkdsKIdZCiHseV+D5utvUQ2PnGza2fJc6Yhpgy9Ab2MRFf1
         EKA6isz7hJf67osvfD27lBZB1lUUp8FBN4MaHiCkbLxo9A+w+fIOLTRSZeGCdB8XWo4u
         TQY4yEQAw5qiKofdk4gJ2ZW+24az80R3s7FXgGEacr7Xlsy1EXLpq29Izfk/z5f8XGj7
         c+IYR/OyTk1ptSGUsykeWTsqRdu5EIOVyZ40yuAif091cCQqK25l8H1QxQ29SGqFe9Db
         wLlg==
X-Forwarded-Encrypted: i=1; AJvYcCV2ScCIA8NJkrPnnxBwETVQ1o/K5RpBBNC6w0TVg38CwBzU669FT61/UvlVC5lftrcaLIjnbII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRnfnQ4+UivltNZWIak4N9mEZ8VO10SSpW7vL22yj1lAP0uUv
	Ed5MJlniZaLDaIwnOlZebpQ48Pa9r2e7lW0o6u4rIpceaQb41sQiYhT9j6tddTkUiA6VZZXjVCW
	M8pQdOj9LBJ3mp3OH9ocS6dK33A1CSgmi7L+FJX9h
X-Gm-Gg: ASbGncvLULMFgvUfBX6w6uIq9fi/mQLiqT/eyG3PXQP9N6SgnAkgpHgrQQDE8P/PMtO
	de2FYYrAGA7DB3n3svu333yqDrHXduecP/gU0Xmo7+DKVB+mp0kGCRzAgmV7JLUhU2dMxSkjzgZ
	VxoULs+KD+yv0N+pLfT+XXCoE0vMXE7z9eswo7PGIWJyUQ
X-Google-Smtp-Source: AGHT+IFWlfqtKFHMBOLGn7Z83pzgLQUiE0GOnbpIGbNfU5pFgYiUQrcsYOaQ/uMIysvwNUJIuaG+fK9N/GeYGeIrPqk=
X-Received: by 2002:a17:903:98c:b0:216:4d90:47af with SMTP id
 d9443c01a7336-234cbe69a15mr1091405ad.29.1748402174833; Tue, 27 May 2025
 20:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-5-byungchul@sk.com>
In-Reply-To: <20250528022911.73453-5-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:16:00 -0700
X-Gm-Features: AX0GCFumg6JlJqGa53nVXK2u3d4-rG_n2DPcLF5XB4A7_ranyMV2_0D-3YxOvnY
Message-ID: <CAHS8izMWhQsGuf4vFzU-LwViR5M0a2J3=H8Uuwn27ju4uZC6NA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] page_pool: rename __page_pool_alloc_page_order()
 to __page_pool_alloc_large_netmem()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Now that __page_pool_alloc_page_order() uses netmem alloc/put APIs, not
> page alloc/put APIs, rename it to __page_pool_alloc_large_netmem() to
> reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

I suggest squashing this to the previous patch that modifies
__page_pool_alloc_page_order to make the patch series smaller.

Also __page_pool_alloc_netmem_order may be a better name.

But either way,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

