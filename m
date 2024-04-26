Return-Path: <netdev+bounces-91839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00868B4291
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 01:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B111C219AE
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D463BB25;
	Fri, 26 Apr 2024 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T96rcwpG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E23C463
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173386; cv=none; b=Am278GSpcyRGFNacORRqir3qb05AVlE/0SXKgX+7T1RJdpknI4JTXwXKgct52KAFPxL5veAulNxfnmMNTbbaeWbzTEXspi+KI1ydsEnRsNS4Z+DBbDS1q/iYicbRe7T22/ZcMfmTQ2zC8cezZWBJja/A3jlhBB7xVqqTIAyjAA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173386; c=relaxed/simple;
	bh=Hw/Vm6LZ8E8f3p/6pvkT071TnyXIs5Nkopf7kc1tD7Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uJ1G7wbx+rWW5SLpArpm7eN+clmIDrJF3LhmgVH1ltJqFSBBsl844IL5UXUgNk23TGx25iHo53mz5ewPMJplQ7li3M9cX5Um3u2PWLmavsNysddNaCN6zWMxfDsaoJK6G/5PubTjM95ANmrWJFPFETqq7lRKLwKkD0UZ0YxGN+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T96rcwpG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61510f72bb3so52550137b3.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714173383; x=1714778183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6hE36stZFSpFdLbNBoVyWYgwDMImxgjqRQJEYsVAq9Q=;
        b=T96rcwpGEMOfZWDx/uX36rJ9L7M2iDywlMio2ROYutMlJjdYdGYpEd3j+bhPt3lm4C
         fK6fLGapJZ3by+JjwZqpwayJNSWsvx4Fm4pPKYd0lCojovd3wSDn7uIWrtVVdWZWjY2l
         9xNvrFAjcGV5iMir7Gruc4lJPmCpdcCGqOkv9nvltFOZBusucoO1F0OHocT6ke7EnQEN
         8bRWCpslPDp2czhVOhuRiytGHqmLvnS1YIWe+WQSYGz3N7R3zqMzxp2jOGyIEo52SXt9
         iaPSELk/ah9pgc1AkDjYGa4upAmgXYohQiEhvERs2F8xO8VDJHxtTAC6lo50iQWa9cMA
         BUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714173383; x=1714778183;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hE36stZFSpFdLbNBoVyWYgwDMImxgjqRQJEYsVAq9Q=;
        b=V/xe+0iItJRC8f1pdFU96gumOwfl/Pi4f2VuUaYVxvZ5zawvfLQuyZw4o4QZR2dIwj
         vJA25xAyHSjbNEffFPQ9oz2J2vEGwL/QE8mR/pR+qkB/wBNWvlyauTtCNH+ngRQ/+5eJ
         2EZCABshrELWdr9/zNQLMxK2f1jbhkJU4O/a7hUjAW+gU1BysKdkBqACyQXO8AgAetG/
         pBeu7VhBi75kN5ETG+/IDCgfj2+w6N5PVhcX5l91ndksui8DeSizgCPILEVvWw2Y9lpc
         e5yOsd9/SvQNIp807XTcyOrt2cfmbZ5jdDRKicJzw+1ImDvH5UqpQCaxeiNXeZM2f4TV
         W4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTa5a6HnzQkDzfkc+r4WzSGFNaSap092OREBrc84CM7Rd35dDMx0m7eGz3tSHRL/qBujyo1zI6N2V+K18q/rEiYqXdWAga
X-Gm-Message-State: AOJu0YxBVv+xQC/+/aH4K43p2EmPv1ktKie2LMX9WbVIrJTV/ipxFbCH
	/WGOlJqyd7Q8ZvYC0I0evaYXSCpw9AA4OhL0cc20m9eli4uONv2Y5GDiUQzxvC0mSw==
X-Google-Smtp-Source: AGHT+IFBo8RF51gRGqri0rLARvh73ixOcb8Mq3xEpt0vPf3CxbirCHkuIF+JsoDbSRswMgqKXkYV9MI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:72b:b0:de5:319b:a226 with SMTP id
 l11-20020a056902072b00b00de5319ba226mr1212592ybt.1.1714173383019; Fri, 26 Apr
 2024 16:16:23 -0700 (PDT)
Date: Fri, 26 Apr 2024 16:16:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240426231621.2716876-1-sdf@google.com>
Subject: [PATCH bpf 0/3] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
 enforcement in BPF_LINK_CREATE
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

Syzkaller found a case where it's possible to attach cgroup_skb program
to the sockopt hooks. Apparently it's currently possible to do that,
but only when using BPF_LINK_CREATE API. The first patch in the series
has more info on why that happens.

Stanislav Fomichev (3):
  bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in
    BPF_LINK_CREATE
  selftests/bpf: Extend sockopt tests to use BPF_LINK_CREATE
  selftests/bpf: Add sockopt case to verify prog_type

 kernel/bpf/syscall.c                          |  5 ++
 .../selftests/bpf/prog_tests/sockopt.c        | 65 ++++++++++++++++---
 2 files changed, 62 insertions(+), 8 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


