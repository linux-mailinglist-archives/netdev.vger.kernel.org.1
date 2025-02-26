Return-Path: <netdev+bounces-169974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A41EA46AFC
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E35188BBE9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257DD23959B;
	Wed, 26 Feb 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtIjqmS6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A977223959E
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598099; cv=none; b=AVP7m2+wRE6tWNGtBkrVO5kG6tYcrMbmgLvn7IFwi8/dYIZ+Hx8UiSVE6CupF99YtOPgq7apZ5n7QVsrFCvUKNEUYTX40vxS2fhU7w0XeNRf7Bcy5o1iPnJ9qXqdc4HbJhuW2eLD4Zfsn8Q3ioB8vDlAqeIOO776VJoGUoGcjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598099; c=relaxed/simple;
	bh=bl9Plq6JnXW74ZZ2OyZkxJ1bQfSDrH+0T8qUb2SbqgY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TeZPYyBWx99VPRtolEAZJXtG+glqEOBSlZOZbHGNZARmFzyhoZO3qE3s/uEDjO51u02t8aAVvHRtEFfoBeg21FKe5zfttG62Y8PJoXzhR5I6dL1kWkiw7KFc6r8SpYFmbKwnApnhBGrDRHcwpMxjl/tqZv1cr/joRN+Mm3pacxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtIjqmS6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220f0382404so1894615ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740598097; x=1741202897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qKg29E18EQ/8K9KKxW0a2f9wLs1Xc02tFARhkKQdFJI=;
        b=JtIjqmS6IYgExDgS6kJWBRzm7hW5KLRv3qNhDdu4R5/AxHzceNro3vmM+Vz9BCpL4t
         Rq5H4ZTpBA+0X5wzNrZdavjmpVQzGFqHl9wk4Ojrs/NpVPY5rfdNxJP6PsR6pwyiw2no
         uujzXnSg94EReU8HPNdl1ZUbjsUIgpFeRYmDN+xHP3cT47gBZhKvuiIrywCdCWMlR/T9
         x9QyacQapqkvSYxVDHXDNZTuBu0NYQuR55OC22xFoX3XA2+FYJFA6hcCexbCKgqVMdnU
         o8t2vGZsfzvhCs10Oh1Vyjhgo+jKenDTysLDNfSDfg+rfjDmt0/qevl64d0ggr7xa7f9
         aRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598097; x=1741202897;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qKg29E18EQ/8K9KKxW0a2f9wLs1Xc02tFARhkKQdFJI=;
        b=GyxDZsp2btFVDv21vdvxXDraKy/tluf2h2SBN3ZOY3WjnxNnaKor7kBr4jr0ZF0Ldi
         7XV6UBGjyJuBFxyOOkpsjTik6zRhLAxAOdLvtAfgbTRteeT5NQ/Spwh9PZN6akVfRvsn
         vjabZWoj44KvN5YydVhgggqDUkW0ocqxVLOiLqeXahyh3zzNdr8HTl6XExONLEvmsvIA
         eiXNd/HjUuCJuEQKtHyqnvWiuPHxZUlaA4+htkr1N3EAGVfmIEgsml8c9UXLxszOVcvk
         aW8u5kzZ3oQZ0hM7w4sWajh96Qiyh+/svh7fNJMZYFvj+AWpfxcGA7Ph2FEyynw1CPJ9
         FOqw==
X-Gm-Message-State: AOJu0YwQB/2qhxEnIEKzuR8KbfjBchbRSc39tqonvnjpaBlXAP2Jjj1T
	hk1LGJabbwsNAqj9/5TsUxFC/jHpA2vaCzBQBO8lzvP6LIE5CdhPbzcil9oVLIVikVnomURoUJf
	y1T4qF6ewugL8D6hOVyJS7Rt6beMl1PEKR+Q2Prj2nHQsCtnSALiOTBYH47WpI2j7lRsvCSLi4z
	8JfHtX2+iP9MzsDJfqzxhLPnwIE9YByfNwHFVkbN4+XA==
X-Google-Smtp-Source: AGHT+IHKu4c7meNjkGUZE1g8urh4/azLv13+UGEM3NtUkBkRgsExSR+jbSrEuSkHB2KxuBwP29fasZf1vU6dkQ==
X-Received: from pfhj23.prod.google.com ([2002:a62:e917:0:b0:725:1ef3:c075])
 (user=krakauer job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:8d41:0:b0:72f:590f:2859 with SMTP id d2e1a72fcca58-7348bdd0046mr5402845b3a.13.1740598096762;
 Wed, 26 Feb 2025 11:28:16 -0800 (PST)
Date: Wed, 26 Feb 2025 11:27:22 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226192725.621969-1-krakauer@google.com>
Subject: [PATCH v2 0/3] selftests/net: deflake GRO tests and fix return value
 and output
From: Kevin Krakauer <krakauer@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Kevin Krakauer <krakauer@google.com>
Content-Type: text/plain; charset="UTF-8"

The GRO selftests can flake and have some confusing behavior. These
changes make the output and return value of GRO behave as expected, then
deflake the tests.

v2:
- Split into multiple commits.
- Reduced napi_defer_hard_irqs to 1.
- Reduced gro_flush_timeout to 100us.
- Fixed comment that wasn't updated.

v1: https://lore.kernel.org/netdev/20250218164555.1955400-1-krakauer@google.com/

Kevin Krakauer (3):
  selftests/net: have `gro.sh -t` return a correct exit code
  selftests/net: only print passing message in GRO tests when tests pass
  selftests/net: deflake GRO tests

 tools/testing/selftests/net/gro.c         | 8 +++++---
 tools/testing/selftests/net/gro.sh        | 7 ++++---
 tools/testing/selftests/net/setup_veth.sh | 3 ++-
 3 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.48.1.658.g4767266eb4-goog


