Return-Path: <netdev+bounces-203538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D48AF6556
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E01C1C43AF7
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2BA2F5C3B;
	Wed,  2 Jul 2025 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPceMjAG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755D828FAA5
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495770; cv=none; b=gIipwcLOpT11vzbVEFBhdfqau3/VsYbAT/SFK1RksvKffIHqbNZ7JY0QSacquCyUj3ohNdtau1vYUdz3viUT5NRcYB15iKgoDk9LIN3KYicvXwLAfK7l/2GvD901PLTWWKg0t85nXoh+xMXuBScBmEkM5HIf42nu+ZUX/8+Yqcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495770; c=relaxed/simple;
	bh=UuGCJtoWtvRkjfOL0i3eMt88ioxIQr7lDItP3Fcqrrw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kwp5OuiObRjNLsIYAOIsTKrO1ShzuX6l/MjanIulO+Jb2XNH9HGrv1PLdsDCzbyadxv5H+w3GS83JgixHd/JE7qFD4WOwGgY4p8ElSBaJoC+laAT6uiMwuF20+z0gjlfZEe/Ob+r1+x7LTyvQXHrcN50pAKQXMckstW/hAEWPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPceMjAG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313fab41f4bso10211047a91.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 15:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751495769; x=1752100569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Db75e96LplUcDlQItcgQ6vAr3c7eoV187JQSAseinaw=;
        b=cPceMjAGgDPV+Hos41EG83lWztO0+R+ocS8yWdBjVuFjjZYFhMzdVxN7AD/OykC/H5
         sXRSlaZ032EGTSwwYSlM0PEqW8uLhnwctVRrgE44W7egMXsxMBSJT2o5KnqUzabg+sIX
         FCTaHSB5nDybiyg3csEeWNTwrfbxc8lGxbh/2XJRrh8ZgbYD1gyB9F/S7ktramVZwJsX
         iKdufC7jM/26xUSAXKW3LR7YmSmlv7gUkV71yxZqMtHrZuxAjTLRIQU/k5MEXD9K+phW
         z3cDLERaOHa5a9vETwR5jIEuRl8bi3DtH/qE1XsA7UaI6x0i7wuckUbMSyQI8CqBFKzL
         fuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751495769; x=1752100569;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Db75e96LplUcDlQItcgQ6vAr3c7eoV187JQSAseinaw=;
        b=v+s3w1EScsxLENf9nz5yGuqA2iR6OZhysV+FAf7S7W1EtlujPCUW/U1DM6Q8wwFV6S
         PnSsSpKOc2cyHFlSmm1MIRJ2LsnlkX2CFs/lRDJQzN5BSv/j8bSChMInS1FRAXPGvUVI
         D+HC+E1WwHFAGfyyuzuBfLpfg+6QL4Gy5T8m3KrnqmKQ47ijSSoLLEap5kCNTYZ2F0lQ
         hdHAxCFd7d2bAILKJekLrlQOjFXWmkqhS0EEdzPPigBxmgL6gksrxMYm2mc9Z1bq3t6X
         hg1sIpCUJFKls8KqYVAI3qqe/EuMHOyWFSjweSsq3MbtoY/ErSeSHKKXVj/CJExYIxeT
         7U0A==
X-Forwarded-Encrypted: i=1; AJvYcCU4hxh7lAxQ1CGeKKL2ACYP08cPoF0yFaWV59H9Xwf1eVtpJFVNDO7LWYCAgdFkv/ipBa3WYSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDGsW+bbSSO4gOP1wWVBWdrIJEbLqWfjd+FSmUYaMh1lK53TPM
	XJOpp7xI0n9+QI1EprgcZcpK5E33nsvZEpjmq4CEw+bel8gSyswpqAYZIqhCbNCLSQyVz0GLL99
	Qo5OdfQ==
X-Google-Smtp-Source: AGHT+IHm9uXieWaJfcTxpXx1OfqgG356EVxJIlvQMBSsORXa5Kr8VLMbi+jQtVZScWPt0TPeDGzxlo7QwmA=
X-Received: from pjbkl12.prod.google.com ([2002:a17:90b:498c:b0:312:14e5:174b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c7:b0:313:176b:3d4b
 with SMTP id 98e67ed59e1d1-31a90bcad1bmr5504740a91.22.1751495768732; Wed, 02
 Jul 2025 15:36:08 -0700 (PDT)
Date: Wed,  2 Jul 2025 22:35:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702223606.1054680-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/7] af_unix: Introduce SO_INQ & SCM_INQ.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have an application that uses almost the same code for TCP and
AF_UNIX (SOCK_STREAM).

The application uses TCP_INQ for TCP, but AF_UNIX doesn't have it
and requires an extra syscall, ioctl(SIOCINQ) or getsockopt(SO_MEMINFO)
as an alternative.

Also, ioctl(SIOCINQ) for AF_UNIX SOCK_STREAM is more expensive because
it needs to iterate all skb in the receive queue.

This series adds a cached field for SIOCINQ to speed it up and introduce
SO_INQ, the generic version of TCP_INQ to get the queue length as cmsg in
each recvmsg().


Kuniyuki Iwashima (7):
  af_unix: Don't hold unix_state_lock() in __unix_dgram_recvmsg().
  af_unix: Don't check SOCK_DEAD in unix_stream_read_skb().
  af_unix: Don't use skb_recv_datagram() in unix_stream_read_skb().
  af_unix: Use cached value for SOCK_STREAM in unix_inq_len().
  af_unix: Cache state->msg in unix_stream_read_generic().
  af_unix: Introduce SO_INQ.
  selftest: af_unix: Add test for SO_INQ.

 arch/alpha/include/uapi/asm/socket.h          |   3 +
 arch/mips/include/uapi/asm/socket.h           |   3 +
 arch/parisc/include/uapi/asm/socket.h         |   3 +
 arch/sparc/include/uapi/asm/socket.h          |   3 +
 include/net/af_unix.h                         |   2 +
 include/uapi/asm-generic/socket.h             |   3 +
 net/unix/af_unix.c                            | 180 ++++++++++++------
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   2 +-
 tools/testing/selftests/net/af_unix/scm_inq.c | 125 ++++++++++++
 10 files changed, 269 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_inq.c

-- 
2.50.0.727.gbf7dc18ff4-goog


