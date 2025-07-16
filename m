Return-Path: <netdev+bounces-207420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6891B07191
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2617D7B6B67
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3B32F199B;
	Wed, 16 Jul 2025 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A96Y+yss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3D22127C;
	Wed, 16 Jul 2025 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657825; cv=none; b=HXJU/oEzu/m49cIqfy+vWZFBNYiB+myUZ8NUCq6v1kluzR35s07RyxR+Odk50Mnl/UpL9jU1RPpE0Olk7jWBFWZCXyeypwGeN5JkixERNNR5t6hy6afHtqSBKY0UpoibqMkJGU5HwHYhQGcvGVOzpFGyKnzeJhzMihYAtKzbxAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657825; c=relaxed/simple;
	bh=8bb59Y7qB/JB1/x9ope6S0w9QIQuBIWcCUed5RbRWdI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=F+AbB0KTxx52ej3W9tQ1DhfkWLUcyWgeqn0T8V3egeWRpUC4cm6xdY/wj3VLtypEkwNJ7LI/49eox7xa0u7b+upjJ8ZfS6QjOb/TrEQGKOhjsVDTogQYZJrHCM4IZkkUaRLCSqyNQp60NMudAdxp/NEVYrAAwInwsaIYOBIC4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A96Y+yss; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-88173565536so670427241.0;
        Wed, 16 Jul 2025 02:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752657823; x=1753262623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8bb59Y7qB/JB1/x9ope6S0w9QIQuBIWcCUed5RbRWdI=;
        b=A96Y+yssh8lylf7PdrmBqHZjYOVs4Dzi4mP2PoULJhHSrR/idSvoWQzUbhfGyHUVyM
         sclrtRX6vLXO2JkJKXQFrUnFS1pe27l81XdIlJNzw1eqdSPA3kr60HY2fQNqyMLuGLt5
         t29S1ubBNHdHkxskjnQB+ugq+iaXWADBZA7AZyHrgJSKv6YEFzQeUak8f8T0FFka0RBw
         +Tq/du7/paCXLSKPOrg2yualGaFPZzkXUFfcj2QNkjsS2sh1p+atL7AY+KeTDi/0WyTT
         JuEU5pJIlpwFIt8Jo4fo8eHUGXnjLZzMbNxNkZlVZ6gNOcHmDwrhzlvDcGH3EuPeFLZA
         kmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752657823; x=1753262623;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bb59Y7qB/JB1/x9ope6S0w9QIQuBIWcCUed5RbRWdI=;
        b=vT8kAMRpbFV8ANN/abv6d0MirtwDUzOt3wAVmpK3eSYdADopD42dFrzAXyI1k5OO1O
         S7af9otiVK86ZmU3oaISwB4807pv27wVqbuvBbTHrCJjq1B039w1zVJosJFnYMxtGn2m
         NuWQ/7AxIOwEyfW9NNmEUbubB6Zbog7h9VxKZGGKYVqPBV3p/jeVWCyu0d8eY8LJAD14
         QzrIXeVf1jVyKyTQuLvt7vuIJFztORCmrbyIS/D3rkxfo/9HoEzb0yJggbb8PIa3dtkJ
         zdhzhKPfJlKScLSw5qPuuRp4ZI/OM0GaAUpAF0NRNcQdMoGksM34p2e5PykgPpz7IgUS
         qcmA==
X-Forwarded-Encrypted: i=1; AJvYcCU3D060rOp26/EgkyOateZcRXz2OK6liJm+zo93PvFnNcXUzBa4Ikpxmk7Yy9bOoJY3z+5xb5cI@vger.kernel.org, AJvYcCUbNYjWMIlw7ywSG0p7kpJV5waU13+WcIkPwLJ2mVjpbuP2BuNcJmWyGeIw5o8Suu5KnGc3Vgueeu5vVoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmLbyLz87yvlMUwOOtyS7WE6HrG5Yw75avHHXxXGURcDFF3CS
	upppr8rcQe4NPf0aQ3Nvamn6FubjEvS/+VfrcwPM8xLz5SGDwFUf/4fwWB0DlUeo8efitN0dLO0
	GU2c9/KagTxVx/ybtpY8cRAUH7EuVR9z3qXExSbyiEA==
X-Gm-Gg: ASbGncv4+rDtgvmdeojtFWu5CQV/ouzJ/7RIwBUwviqlYbBb3dVEEx61gaW6DN/4HQD
	yDBXOW5quBVhaSlJqYoj92BMmCGmucfnkEYZAzzhp5Qdg+YJejd3YqSvhNQ+QBkPpbdJEHHElrm
	ls1CAKOeQeYSS0R8+OeuiapH4jSzu9PH+ayIALurqsJyeKSZZo66dtwiJ9ecFoncxx0f6ZhrLXr
	hb3w7U=
X-Google-Smtp-Source: AGHT+IHbhfnfusQK9pbbtL026/fcLsRE78Jlhv++1FuiMatxhLTQJ+73q9kklmr2eP6jxQDehdPv2C7LAS1LRoealqE=
X-Received: by 2002:a05:6102:3e11:b0:4e7:866c:5cd9 with SMTP id
 ada2fe7eead31-4f890152c29mr1304099137.11.1752657823234; Wed, 16 Jul 2025
 02:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xianying Wang <wangxianying546@gmail.com>
Date: Wed, 16 Jul 2025 17:23:29 +0800
X-Gm-Features: Ac12FXyNFIaCK2pDYZ0jchMpDYF8x-Rd4WuhffoKeJLrRhYKDwWu0ZHWBZNeFqg
Message-ID: <CAOU40uCe07E+jSONsnFXWfdPHPQjcvEoFX-QdJ2eAw2DqXZ=sg@mail.gmail.com>
Subject: [BUG] INFO: rcu detected stall in unix_stream_connect
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I discovered a kernel panic using the Syzkaller framework, described
as INFO: rcu detected stall. This issue was reproduced on kernel
version 6.16.0-rc5.

From the dmesg log, RCU detects a stall on CPU 0. The NMI backtrace,
which shows what the CPU was actually doing, reveals it was stuck in a
tight loop within the timer interrupt handler. The CPU appears to be
spinning in functions like lapic_next_deadline
(arch/x86/kernel/apic/apic.c:429) while processing a timer softirq in
run_timer_softirq (kernel/time/timer.c:2403).

Meanwhile, the task that was running on CPU 0 before it got stuck in
the interrupt is blocked in the unix_stream_connect function
(net/unix/af_unix.c:1683). The syzkaller reproducer appears to create
a deadlock scenario by having a listening UNIX socket attempt to
connect to its own endpoint.

I suspect this is a complex race condition or deadlock within the
kernel's core timer subsystem. The stress and unusual blocking state
induced by the UNIX socket operations, combined with concurrent POSIX
timer usage, likely exposes a latent bug in the hrtimer or tick
management. This causes the CPU to spin with interrupts disabled,
which in turn triggers the RCU stall.

This can be reproduced on:

HEAD commit:

d7b8f8e20813f0179d8ef519541a3527e7661d3a

report: https://pastebin.com/raw/N3GD5hL7

console output : https://pastebin.com/raw/RCZfTKCb

kernel config : https://pastebin.com/raw/xAVw5DnH

C reproducer :https://pastebin.com/raw/Z1B1ray5

Let me know if you need more details or testing.

Best regards,

Xianying

