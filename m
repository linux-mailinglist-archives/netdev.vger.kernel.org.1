Return-Path: <netdev+bounces-165520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685E8A326E4
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F187A2C66
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99C120DD54;
	Wed, 12 Feb 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKUjmH/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4020C489
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366662; cv=none; b=rbyXLQQovz7/AkCtQex0MeyDhv0yeWbVibvmP/ztHenlCGKqa18uNKBg4kf4ia4XqPuAAbxFKBfe8VkX/usiiOChSwcshIhi45CQggCDeyPKUWkZqDpPlJruRSh0bugTcekXXdgNyjrJV8t9ZRszfhkAbsppZv6otOzWvk/Z6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366662; c=relaxed/simple;
	bh=l9RpDYY3hYUTBJ103nDK+D1Q05QGtcvA2ULMmKvPzeo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=njiQS34AX6gj2o2+E1FvFr16eWRUo7bRoGP8X0BvHhrKj2PmpHMBBNkFMzVypKKqrFMZ7tTRpnY6JabP7+6umsHHEjdt1K65c34fws5rVeulnVe09OwbBNHioUnPEd3n1avYD/xCiGWhzQV8gvpuAaMtup67UrepICjVY8rKxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKUjmH/Q; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c0784e91e4so17234585a.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739366660; x=1739971460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a2Y/48dGXo8vc0V4fBMDgf/zAAYoMSFACYCj11vlC1M=;
        b=hKUjmH/Q8dJ+Z31VBwTQCUJj1LKwQHYcn+LKUcHVtRQ1Nl0F2cDHAuZMJoU/WjBwpS
         x+p4wdbNEhH/Dq3DQSn7RhNITomo8lS9AtUTy4yAdYbj5axsaNQeKhO40CengTudsdWw
         bRV23kTZFb0jxnLZKoLTl/cAzWlIk9T0dqAvmETwQ+zC3TBqw30N7ZINnPhKTQvDoECL
         6v0B0LRXdQBaARenfb6PmX6iNUGxnIfrYlkFroROoJU3t2oPP5btgifbC3buTYlqGmLa
         C8wEyH7cNDKMQJrG7zdKtOyPpGZk9gpYekrm8eFnK2kcxhPNes0GE8PMr4+CL4FSP1/d
         SUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739366660; x=1739971460;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2Y/48dGXo8vc0V4fBMDgf/zAAYoMSFACYCj11vlC1M=;
        b=C3EuuLMSl8bLqmWxMOTiW9IBX7ROuuJEkm4t4aCSWHsiv5NZd0MSd8XF543Vgta2wo
         2xV8WZ5enl9d/8iPL/nPZJR8XK0CerOU6xAIW4FfrTyUvRD/bqSOQCi50pgnYolkl6nq
         jduJl0c7eGbDNh0Qi3/elmc//aeGzXHD/7xLHT3iG+djpBV4V1hc6Ba33arMdwyvqRoU
         hB0ZlDhpgW4k2gMoOHNoYMMiAHRxY5dI+rnmVp+u627J9Cf/XkahkNUw9PBA5cF49AQG
         A5ewStF7Fm1Ksyy6xiewfOMM32mx2FEQ0mSnUJ6sNTwxo0pykxJ55tefY0vKM6ZQJ0Lx
         cvxg==
X-Gm-Message-State: AOJu0YwYF0kUilkX8izGZg8TgvgihunSoVpASFPVAbOL+QtjgNUG34q2
	EqY3+cdX2VYhAL9uIMTy5aAKfmgln8n5sRXLdu7Cz14E3RIVFw1iUbsWl2s9nPpFxtq4HTlTXro
	E1Usr6AyPaw==
X-Google-Smtp-Source: AGHT+IEyoeQ52CBCiL1jPqNsiK4wCnQICtZDn/kC9LIDsiJYcPUL4mU6D2LvtotBNyo25iBDb3nModjaBN1jRg==
X-Received: from qvbon7.prod.google.com ([2002:a05:6214:4487:b0:6e4:2e6e:d5f5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2b0e:b0:6d8:b594:c590 with SMTP id 6a1803df08f44-6e46ed78024mr41102906d6.6.1739366660053;
 Wed, 12 Feb 2025 05:24:20 -0800 (PST)
Date: Wed, 12 Feb 2025 13:24:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212132418.1524422-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/4] net: add EXPORT_IPV6_MOD()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In this series I am adding EXPORT_IPV6_MOD and EXPORT_IPV6_MOD_GPL()
so that we can replace some EXPORT_SYMBOL() when IPV6 is
not modular.

This is making all the selected symbols internal to core
linux networking.

v2: add feedback from Mateusz, Willem and Sabrina.

v1: https://lore.kernel.org/netdev/20250210082805.465241-2-edumazet@google.com/T/

Eric Dumazet (4):
  net: introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL()
  inetpeer: use EXPORT_IPV6_MOD[_GPL]()
  tcp: use EXPORT_IPV6_MOD[_GPL]()
  udp: use EXPORT_IPV6_MOD[_GPL]()

 include/net/ip.h         |  8 +++++
 net/core/secure_seq.c    |  2 +-
 net/ipv4/inetpeer.c      |  8 ++---
 net/ipv4/syncookies.c    |  8 ++---
 net/ipv4/tcp.c           | 44 ++++++++++++++--------------
 net/ipv4/tcp_fastopen.c  |  2 +-
 net/ipv4/tcp_input.c     | 14 ++++-----
 net/ipv4/tcp_ipv4.c      | 47 +++++++++++++++---------------
 net/ipv4/tcp_minisocks.c | 11 ++++---
 net/ipv4/tcp_output.c    | 12 ++++----
 net/ipv4/tcp_timer.c     |  4 +--
 net/ipv4/udp.c           | 63 ++++++++++++++++++++--------------------
 12 files changed, 114 insertions(+), 109 deletions(-)

-- 
2.48.1.502.g6dc24dfdaf-goog


