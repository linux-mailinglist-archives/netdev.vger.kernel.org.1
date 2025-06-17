Return-Path: <netdev+bounces-198803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEE9ADDDE6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33AFE189D65F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4982F0043;
	Tue, 17 Jun 2025 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+vfxfY3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA42209F5A
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195800; cv=none; b=ToILQIt/iz19xNRU7XdAt6BbYjkNcIfYTGNJwb48j7CVJ9U+SbIKIzZjl1Hz1wgKGkDh3FDm1aNHUnv5KJo5QPQteMt811eLpbptHy3FQ1mBUmd1qH9jnf2sKdQuu7H+DhilM8tvSJRdEDyDgJC13q4kkmQNYxX+EMgUmc7P2A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195800; c=relaxed/simple;
	bh=S59uip0FFcEC5W7trRE87a2xUx07B4UyQBUA0t5LQN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksiYna8OBhAi8mivc7/NEI7O/KJ70CY8EiuEkdIYW8DcMcmCmcszIwnRp2F5RM/6bNUszKh05zcMHk5VAQVrVT62jjdr7Zk296zU+uHPFjlpH2iP4avvQUWQXWVPQcJTDEoPDMPWhEalwRQLYppoi9VMbTi6FM8mbkTQvBGynXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+vfxfY3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7486ca9d396so3958672b3a.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750195798; x=1750800598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7NZ6vLUh2nuXArBgX71KXKWU1FNnvUjAToKj6eJwuw=;
        b=m+vfxfY3ZvsNHjza+yNBMM1yAELZFnHzETE8rJckd2gnEtW1X+E3KIDFYVTWa909Ei
         gZUFcVBxY6tWx4o7l4ENAllx/ipL1Xwqhc1pL7QJ053/9KiW9edMO0G6ZIWa9TLzb3eh
         XPj/2DRghSxcbrpA8O7w9PSsteNajspfBiw9lX3qUC9e0PLb2vVrrHFXXQYSJtIWqkpo
         Ho095xKDX9QoEmpkX7GiQvutDTMGCi0fC6+sbPdvfFCIxo+2ciJsOQlEReV6FDaQIw39
         +AIzGNKGs7J3nTAmWcByT5vqu5xSHP2kEpfpWclwcFzPlV1TvQ41MtgZEusHhsQhCAAG
         UzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750195798; x=1750800598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7NZ6vLUh2nuXArBgX71KXKWU1FNnvUjAToKj6eJwuw=;
        b=QXktT2qqEU4/ICReXI31vvOLwwHJ8V9E3IGlNnVQK9NlaZhh+Hlc++UE8e8qVBLe1N
         RAp70TzKQLlt11mWp6vAxhoZFPUVY4CutSfpvhU1RcnhBALoQwT5sGFeiB/854TQBVPG
         E51TxFrTeh2oLzsxkyLbqBP36zFEhZGWf01/AO4qns0xU3eCFaM4rbm+QZUcaHYc5pHm
         E/j/gRbFDYD9TX8/n+bzhCchuzTsJnUcerc2GekYKPFzg/ZyD4qyxLaeYFBJFl2qBu2b
         Rl0xjE58D0Ci30IytSnqoGimfgvFL1XhCg0RJQCPk9k89fHSTe5NkpUDo/in85jsywsf
         uHEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLor0iQXYfXfMrq/hmlZtLlYwci41Qki+pCvw3QTH2q3Ogrb5xWCOJ2G73wTOV4YGC9Xz49Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyPkbyWnhm3HHZlOyB9cac9x489GysrAxC76IJspiIV+YSADK
	bQp1SKLfjfRenNBv4hHGq4kQe1g0rxSDuW6AMfOx7oJdY2Ly83M98Ek=
X-Gm-Gg: ASbGncvc5vyQJ5j1dG0bDwQ3Pftl04ailgnQ3DRKbdEC8nflGMLFe6qb8PHLQMvLdzx
	2HiFNBsYcctImlpDqYFgrFvJsZ03/7zqB2EMGoUKxjrsFUxBwIYC7Ddg91nRvO04giHbUwXWZq1
	Z/HuNBvgiiiwee289KUNtxCLNhy7Vy88yn+bgYxEcLVwtRsqDBefspjrOgi1gr9Ydvh3EkK6MgD
	pzWJvjmT+KK5SFoWHdgFAPjk6Xo1V37AtQalOCCS9uYIBV+qaKZXDeb4ZViLyRgqQJvgy+sCuuU
	IyGLtVRtzK5L88Vb4GgGcrUUyw3NhpgIgAIWwTg=
X-Google-Smtp-Source: AGHT+IEgB8s2A6RGlVIbLjAicZ8kUilnUG5PGPpP6bIKULQU1JpW7NqrqiTnXKmuhUhbpUucqkP3Wg==
X-Received: by 2002:aa7:8884:0:b0:736:a6e0:e66d with SMTP id d2e1a72fcca58-7489ce0c6cdmr19071964b3a.6.1750195797945;
        Tue, 17 Jun 2025 14:29:57 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748da2e540dsm1617523b3a.93.2025.06.17.14.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:29:57 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: dw@davidwei.uk
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuni1840@gmail.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net v2 4/4] tcp: fix passive TFO socket having invalid NAPI ID
Date: Tue, 17 Jun 2025 14:29:44 -0700
Message-ID: <20250617212952.1914360-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617212102.175711-5-dw@davidwei.uk>
References: <20250617212102.175711-5-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <dw@davidwei.uk>
Date: Tue, 17 Jun 2025 14:21:02 -0700
> There is a bug with passive TFO sockets returning an invalid NAPI ID 0
> from SO_INCOMING_NAPI_ID. Normally this is not an issue, but zero copy
> receive relies on a correct NAPI ID to process sockets on the right
> queue.
> 
> Fix by adding a sk_mark_napi_id_set().
> 
> Fixes: e5907459ce7e ("tcp: Record Rx hash and NAPI ID in tcp_child_process")
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

