Return-Path: <netdev+bounces-99741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851808D62F7
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE54B21C39
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40995158D66;
	Fri, 31 May 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdnnVHHK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC076026
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162004; cv=none; b=KssbUdgI6BNqwCSI3VCsYiWBxII/j0uBt1npRZ6i5f1mKsQrCB0MmJxlpfaU7s3ulXnwkk/IEOPSYIxjBp5s7dQbBX/I9RFDDf5NP4Ov5h52VAtDhI6axPIrCVzirgwYG9j+QOAqWX4umG2jNJvauwSlPDcBlDhnElteWOSZODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162004; c=relaxed/simple;
	bh=jquWp/lBm/wGIZ2Ie27x5gtgwrU1++eG5TZGttN/Zf0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P6mQ/j4A2AcpQVrYozRAUicVpRDKst88XXdfHsG6+DoCrmy9gz93ss5xzviEQS+MZEZBCI54cKiWg7jtW1k12rFlHjEHfZ5qrs8+awHhhuBtvQ8xhbHvVZazcL9mg2KtFzXf/4HOY5rr5bWUbksO+oaVLZCQUAc97L4KLS+olYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdnnVHHK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62c7a4f8cd6so11620217b3.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717162002; x=1717766802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DvMp00G1KEMs7HU7ZEBWzlIaGEEqvwbII5u9OOdYkl8=;
        b=UdnnVHHKlwzDAP8YBx0yYtQ//eukjMt7kTCMfhlzRlwhSnmjUPLQhb0j1uXPcRu+qY
         gGCZV8KjqOFD6bggKipb/DIGKpKqx4/BLw+JTeTMskJsBiTOmlxdCnXf8PmfrGeaoC6D
         X1dQSxhkNpCbwEqwmA1t0h7Yg9lRXLe60sro1Sic5QJOUJNNb/SiQ9p16CQ37ioW5f47
         RghailcRXvP1JCO2DYIs3S8NDQYECoyu5Ku62rDRsI4UrCbP4qcJ1mOZReAofgOeYw1Z
         0TjPmm9kpPQnvkfybwaZIbbVzEdsP7hh0pcFvtFSUETU2hmKYalozicxwsVnc0BShw4L
         6HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162002; x=1717766802;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvMp00G1KEMs7HU7ZEBWzlIaGEEqvwbII5u9OOdYkl8=;
        b=Im5z/ec7dHnFL+LKSuwsJXcBmWFoyhEEL1e7AHzlxe8Qxm7I1LL4LpNU/A+vZ/CMEd
         lJaqIkTLqKggmUCLmqbUX6oi7v3bS1w7E+cBtUylgYl+D7KQ0x2nkJ4x/4bO6S2nIqmc
         UXDz6wBKoBMND+I91ynIQcoM1XWJY+QzoyAyn5hrFEeVQBV+JI5oHsbNvA3+jNJtk2mS
         2JSavZoh2p4uh1RxU6u1libjXu080hkPJrUrurq6iY3GXZZPweCyyNPIrBb4HwxEH2bA
         SDQzHdZO5nRXjCLAef/tAssO794BbJ/acpfeBk4G6adTTrUTUojJjwIikEvvQtiAi06n
         HkPA==
X-Gm-Message-State: AOJu0YwrF+r6LSk4xhDG3EGgIPNzktbooakYgOVjfEARXGVkqVclZLFR
	03PbQW/YM/qXmYMM3NMgSsaWu01SrATQrTfvhnybgzsfJA699SPK+4Ma9X2dRhA+Uy0KRiAWsOe
	OtrrO50Jn3w==
X-Google-Smtp-Source: AGHT+IF4NXE24Btrzx7I7NqWEHtyFZJADCHlGwcgsTcLmqyFH9NFjv7dwNWKp4ct+fYEZnF3xuCPSr1vFPNr6A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:d83:b0:61b:e678:2591 with SMTP
 id 00721157ae682-62c7970174fmr4051757b3.4.1717162001787; Fri, 31 May 2024
 06:26:41 -0700 (PDT)
Date: Fri, 31 May 2024 13:26:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240531132636.2637995-1-edumazet@google.com>
Subject: [PATCH net 0/5] dst_cache: fix possible races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is inspired by various undisclosed syzbot
reports hinting at corruptions in dst_cache structures.

It seems at least four users of dst_cache are racy against
BH reentrancy.

Last patch is adding a DEBUG_NET check to catch future misuses.
 
Eric Dumazet (5):
  ipv6: ioam: block BH from ioam6_output()
  net: ipv6: rpl_iptunnel: block BH in rpl_output() and rpl_input()
  ipv6: sr: block BH in seg6_output_core() and seg6_input_core()
  ila: block BH in ila_output()
  net: dst_cache: add two DEBUG_NET warnings

 net/core/dst_cache.c      |  2 ++
 net/ipv6/ila/ila_lwt.c    |  7 ++++++-
 net/ipv6/ioam6_iptunnel.c |  8 ++++----
 net/ipv6/rpl_iptunnel.c   | 14 ++++++--------
 net/ipv6/seg6_iptunnel.c  | 14 ++++++--------
 5 files changed, 24 insertions(+), 21 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


