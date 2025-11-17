Return-Path: <netdev+bounces-239208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C53C6598D
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id AE5E328FA9
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569162C237C;
	Mon, 17 Nov 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pyid/BIG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83DA23C8C7
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401665; cv=none; b=JyHC1PFQQ45WGeiudrAVRVPHIxvFo7kN7F+w7cEpPKjjXoebdOunaoi8Qwfo1AtA99LFg48P7/Lc8AJk9C8mFKewlrc0dS+SGbsmfmKoAVu/hyJ137tSiNZlftBjQUtn25+bDsmjg4xmpC+vnrrsHzspus7v5zx5TrLwBXolWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401665; c=relaxed/simple;
	bh=b5FoYyebppm1EQfzfej+2jUKSqglTnMpDwEG0JHQtx4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YkjMeGAf8n8ouOBzfnN64di/yKfEPyho10TUpFypYxHzSjUPnJOt3SHqwkScG/+wSoFrpxRS5eCFWkqsQGlngtaFLgF2CJm8Qy8IfNy7FXrCugKbbnAhI8GxUGvo7U6lZ28bNXTXFIHAlRFNFEmSS7GGvPT6MsZt4ZjBXpqqNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pyid/BIG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b8a12f0cb4so4786808b3a.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763401663; x=1764006463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LHVwslpu8XDl1fVMhpiCdsrvhVh5Dz7yNwK5Uv5zSb0=;
        b=pyid/BIGJ+f5CaRTj5XKew4SUYo78jOobIUtaVYd1+kUZxF5tv7kgErtIrwX6jI3D7
         tpg8b0ikUFHuW68TjvF8vyHK6k5eFeOls47aFNte5r3JYfg8L3GOD9NqeQ/5sjyECTPe
         pYUtke+IjCEPjBKH+TGN17MlWg4Sk1oDBpGmspUKqQql+fytXSrfi2kkYPvd7Z2pcYhG
         DQ4288VKegCASvf+K8pxCkTbBIszXCu6uf1p6B4BubpyWZYxA59tcWAFNQgqGea0oQ2Q
         zd0abmCFX4AYHrxZjEOoQERIhZ62hzdAPQy0dTmi2DQkEmDIx/8DfODVymhiM8TausX6
         sS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763401663; x=1764006463;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHVwslpu8XDl1fVMhpiCdsrvhVh5Dz7yNwK5Uv5zSb0=;
        b=va+ffuo8DSR4OQ8NfuEX7nyatyMmLmikV0ywZzJuQHD+Fw1U78NsJlMExC/0m9eJ1O
         BZ7U4A+66jCU6kFLpueA0gE2M0J32BtAoE3oeVA94ESJfNvnK0pJSVUWJmmnrjPTG804
         ENuDIbnSNQlNDq7sqkRrqGk1kRt4HV8STU2aokyEjrBdFJ6rYLHnqXx6VitCxWCA/l1B
         qcTZDtNcE2A0jdbRvR/2geSoYMFgzhn+AbJfIcgcLCkU1bBkROJGEBjbygYQb40ReuL8
         xU4xfSQtCEbGTnwRgE3CIFLzdWMTn7Xkus+qKSk+A24afJ+KYU8KcXHT9nJHVS78weWF
         KvXA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Z8+bnzBR2ItWBPBB82MQz9Hfe+o0/MwDQ/LoME5wgyZ5hHiL/VOhZRrJPr9d9/6DlxTR7Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV493Nouf0u+IMrJyTDNztha+CJJW0IG1PWf0fRbOO+JiA8tPK
	CVnp5xKcpZM75HcjZpG3v9mkS5/Q2UYJleWv90TGUqokv6eJVhBUIxh0lYEsmJx2mB4fNDksVXh
	NSU/yjQ==
X-Google-Smtp-Source: AGHT+IHIwG9DoERQwiJ5DQQmuqjCtowXq1UvO6vpFmNKtlOo2Dl32e7y95XlF47OI+PGLdagnQcFZPDLoZ4=
X-Received: from pfqf30.prod.google.com ([2002:aa7:9d9e:0:b0:7ba:7428:2e5d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1251:b0:7ab:2fd6:5d42
 with SMTP id d2e1a72fcca58-7ba3c080378mr13751237b3a.16.1763401662835; Mon, 17
 Nov 2025 09:47:42 -0800 (PST)
Date: Mon, 17 Nov 2025 17:47:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117174740.3684604-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/2] af_unix: Fix SO_PEEK_OFF bug in unix_stream_read_generic().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Aaron Conole <aconole@bytheb.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Miao Wang reported a bug of SO_PEEK_OFF on AF_UNIX SOCK_STREAM socket.

Patch 1 fixes the bug and Patch 2 adds a new selftest to cover the case.


Kuniyuki Iwashima (2):
  af_unix: Read sk_peek_offset() again after sleeping in
    unix_stream_read_generic().
  selftest: af_unix: Add test for SO_PEEK_OFF.

 net/unix/af_unix.c                            |   3 +-
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   1 +
 .../selftests/net/af_unix/so_peek_off.c       | 162 ++++++++++++++++++
 4 files changed, 165 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/so_peek_off.c

-- 
2.52.0.rc1.455.g30608eb744-goog


