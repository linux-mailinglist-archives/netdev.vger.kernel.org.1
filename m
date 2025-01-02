Return-Path: <netdev+bounces-154831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC619FFF45
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 20:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734791883BC5
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0509A1925AF;
	Thu,  2 Jan 2025 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KoRbz5b6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82728176ADB
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735845150; cv=none; b=FKmBfAFu0Lxy5HBpMBqMSIy/V5eQiT1lq0TGBy9rOxMWH8OlxigVV7vBv8FWzYLl38S0RKTO1DzBW+s1YerEoOfJdDIno3zgeHjQ7doWYfGhB4LAv1nCdCii4dsY+rO0aXjlnPOO3/C5KGB4RX+wyyJEIMmEa8HwcxiD+eMo5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735845150; c=relaxed/simple;
	bh=iS7H+UYbLJdCXeo32YngBYw+OJxe16WVUxAT9k/4Vf8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VlS0aaBn79uAnb3WEbs58FiX4kqwOzkHXSQ7ejDtd/M+gQ+5MTPNZGWYHJ1lS3eJ5pS9CV2uXBAkgYEoe7Rrpg8NJCAUCyVChcRVGhRyzaaI9Wjaog7UBxahYQuTgV4TDQZdhbSwOxoxgMOO7YlXL2VMLUFPAr0wGqfO0YY4foA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KoRbz5b6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2163dc0f5dbso142978355ad.2
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 11:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735845149; x=1736449949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KmsYGRxwEHkFCMaogwrPEoq4fAdkqZTiz0RfrfxIqo0=;
        b=KoRbz5b6Mq8rBzrMKiGAVM/0r7JnYNdOSugln0jtGDv3wRMaOKpQglTKbObGP1QCRm
         7hANvWkkLSW8DdnTWn7vBETXLGzRk2drteEDRp8P0vDUbvJhfck8Pz7voPQqhwWbl2NR
         IC8MzFfms4btI9z3ldskPi4+4ewtbJFzZOgqAgiCJk8fR0DOcLHkoomCGtpt13TURJyx
         /1X0Z7CAqC7jVmE+133fzaByV7/HvqYWULirlxBdTyZsmFosJ5DL9Me/DNeMJW4GYw3S
         CMCUsLJxZbwE4JxvaZ/CPrlNhP7c+RZHlln6dPTxjhIntWYiy5yRZ6nxHxrxHEWov6/c
         kcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735845149; x=1736449949;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmsYGRxwEHkFCMaogwrPEoq4fAdkqZTiz0RfrfxIqo0=;
        b=NMTwHAAZSn7bxAF61mVJDhAHrjfFe33M7WmhffVt5cnUkWvo58gZiLUwfolsa7mp7M
         nGdIl/BBDr6g+lOYmzozSBeNGAmPFvuDBiAA0TlXvys2QG+s0OPip9b7A9CeYvkcr0Ly
         1Yfj3MHBMbI4nu9LHY1fZl3oahCRYW6VBEjl7mm4i7hXAsErjmGjHjVORY01KGqexSUF
         cJGt68Ik2LlmUt+QaEi5NEMxY+RHDrFfNHxBc6TGzYq+USuIQMHYH525nTTxOB4bt1fR
         npuRS6yWlEjQP7PTtGeAPzPMaM/3Sbw+upAK2XtYRjpzSaI//RDyLwCadv6DGXpQ5u2l
         KLlw==
X-Gm-Message-State: AOJu0Yw+fDvTxRHOvQUxqtEol4ENeW5LR/xFcuMddmGwioG3ZXN+Czey
	oxzmPuN37ir+naufiizo+xs4uEBRg0sSM2kMkTUTW0dR1K3CtFTLFvKWJGekLIO9cDIM6do/kTa
	5DlJgghnthA==
X-Google-Smtp-Source: AGHT+IF03slD11W6fOZI+zlcZrM5kDi+NtYdFMePpwNh/zn6muaqF7FD/vp0343zGND8ikEe818lmuLAx5Yy+A==
X-Received: from pjbeu15.prod.google.com ([2002:a17:90a:f94f:b0:2ef:a732:f48d])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d510:b0:216:4dfe:3ebd with SMTP id d9443c01a7336-219e6f262f3mr610968145ad.50.1735845148801;
 Thu, 02 Jan 2025 11:12:28 -0800 (PST)
Date: Thu,  2 Jan 2025 19:12:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250102191227.2084046-1-skhawaja@google.com>
Subject: [PATCH net-next 0/3] Add support to do threaded napi busy poll
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Extend the already existing support of threaded napi poll to do continuous
busypolling.

This is used for doing continuous polling of napi to fetch descriptors from
backing RX/TX queues for low latency applications. Allow enabling of threaded
busypoll using netlink so this can be enabled on a set of dedicated napis for
low latency applications.

Currently threaded napi is only enabled at device level using sysfs. Add
support to enable/disable threaded mode for a napi individually. This can be
done using the netlink interface. Add `set_threaded` op in netlink spec that
allows setting the `threaded` attribute of a napi.

Extend the threaded attribute in napi struct to add an option to enable
continuous busy polling. Extend the netlink and sysfs interface to allow
enabled/disabling threaded busypolling at device or individual napi level.

Once threaded busypoll on a napi is enabled, depending on the application
requirements the polling thread can be moved to dedicated cores. We used this
for AF_XDP usecases to fetch packets from RX queues to reduce latency.

Samiullah Khawaja (3):
  Add support to set napi threaded for individual napi
  net: Create separate gro_flush helper function
  Extend napi threaded polling to allow kthread based busy polling

 Documentation/ABI/testing/sysfs-class-net     |   3 +-
 Documentation/netlink/specs/netdev.yaml       |  20 +++
 .../net/ethernet/atheros/atl1c/atl1c_main.c   |   2 +-
 include/linux/netdevice.h                     |  29 ++++-
 include/uapi/linux/netdev.h                   |   2 +
 net/core/dev.c                                | 122 ++++++++++++++----
 net/core/net-sysfs.c                          |   2 +-
 net/core/netdev-genl-gen.c                    |  13 ++
 net/core/netdev-genl-gen.h                    |   2 +
 net/core/netdev-genl.c                        |  37 ++++++
 tools/include/uapi/linux/netdev.h             |   2 +
 11 files changed, 205 insertions(+), 29 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


