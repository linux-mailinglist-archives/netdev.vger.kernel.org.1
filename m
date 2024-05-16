Return-Path: <netdev+bounces-96667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6BE8C7058
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 04:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33216283B2B
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 02:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF2515A4;
	Thu, 16 May 2024 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O2pAWbeM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8015C3
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715827135; cv=none; b=QGzpJ7h6IhcN69rMFwPtjofIEO+tdWHQf9IOGQfUxKzZuPKyWUuyRPri+QJHZqa9AGBwKrqg2s5HstDlpxflPKI9Fj9meTG/nEj6ky10D2jVCtVInA9yWrra8ddWplCkSOGDRqjdTbIS0s0bUvl6LxmLba8ZT/oEH7Jtyt/YYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715827135; c=relaxed/simple;
	bh=O0qatsONYd9VR8mWX4/rx8ERRwhr1IC13TezxLYKNao=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=a14EUdCXNNo06vsV3l9iPaYLbkZDSkvL+g6JLAQaOpHCOOmtThlH7mEYQ6G097vRBVoBstdAw1SKvWAs/MYAQGqTbL/zN8nUmQcoS5aiul2/aq9gDrGFF1FiqNADdAC9RiEBpxzuH3XthRJXWJIGNHioHKNGfuAZXw0mLjXAJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O2pAWbeM; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5acdbfa7a45so827695eaf.2
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 19:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715827131; x=1716431931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+SuRTZse4lz6//skPKIvTsSLuGULSSe5dVLzTLbORA=;
        b=O2pAWbeMfQSUtc58CzDWmgihRncctf/gzPaxVn/b9G0342b14E0QxL0/QIyE9DS4MK
         gZpGTrzye8zV1UNQPTW5GDpNizgXX4XMAug7Bt183dpfsbQMGUhzVRynNwQpi0Nv57oe
         kDmYkFO7jguDkvMXHFCvY5fZnjCAJVEyP8F9qrip3w/CkYt+2HgXqxyIYXiFX9uwYIma
         Exy5iNgFMdwX1KMrN+OgNU2b7EsFDNdPGXdMY9S3j9Kmn/A5hG9eVktrNO4x7OCcko8f
         QFmSUpfg3J19jkDdjvwZMyiI62K/eMxvjyx+s0hSs2UnavbW7J+2jzFfBhC/zjtZ7gZM
         jDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715827131; x=1716431931;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K+SuRTZse4lz6//skPKIvTsSLuGULSSe5dVLzTLbORA=;
        b=HYLQZ4kzyF/PBAVXTvXhUGLAcqY3wvxySAVzifeMGcOibUmOLSjB/ef1Je4afhRrOC
         lDmtqt7/UVpSJFH4bcnWxJiRBC5w+ozSVXLgwdAJcgeQyngmzuOluyYjfZQa7YgX1SvA
         5ghjvqHcC7fOvpge5+nFm3OfF9p4TuzbhtmuZjbL6xU4WIyEDbhk61Wutt4J+AhBCl2R
         ayf9Epo6AiTiA87JwMbhR4VSyC/oERNIUrHuqGO9LPFYoZou8uXndi8+SB0jpBbks51G
         NSyAC88G+0enrRuJboidIvMpcb9zvohmdSfNdTNw37/W2ZGTCFMqkn7+frQpvxDbP4lg
         QL2g==
X-Forwarded-Encrypted: i=1; AJvYcCWtCGBW+4lwBZ/imOc/BFQ0r13GM1fED0ch9eaOcfhN5AzHGz+IPr/sBuDgyuc2r9nbcmNw7qDWQK4MK1hLnLhyeqEiZ5WF
X-Gm-Message-State: AOJu0YzqRMbQK4F9sahjhj+myj3Ujor8PsbpCO7vwkSYu/TVRSKqWQ+f
	hcN1yaouXdPY8buVVfOaYYX8uaJrXY/KS/OUo/NpkC2LpTxxrNvi9kZ8VIBui+0=
X-Google-Smtp-Source: AGHT+IH36yKo1Q1FVbTBqRDfsTnRQXt9/O+mR4szSehvGMKI5EeiK+2eGs8/x1VSf8tCZIAVoAlCDg==
X-Received: by 2002:a4a:de14:0:b0:5aa:3e4f:f01e with SMTP id 006d021491bc7-5b28193cc74mr18702902eaf.1.1715827131390;
        Wed, 15 May 2024 19:38:51 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ade2besm12213380b3a.98.2024.05.15.19.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 19:38:50 -0700 (PDT)
Message-ID: <8c707a5f-2e33-4f5a-99a0-89a194625bcc@kernel.dk>
Date: Wed, 15 May 2024 20:38:49 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Enable IORING_CQE_F_SOCK_NONEMPTY for accept requests
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: io-uring <io-uring@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev <netdev@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

This one was deferred, as it both depended on the net branch and the
io_uring changes for 6.10. Sending it now as both have landed.

This adds support for IORING_CQE_F_SOCK_NONEMPTY for io_uring accept
requests. This is very similar to previous work that enabled the same
hint for doing receives on sockets. By far the majority of the work here
is refactoring to enable the networking side to pass back whether or not
the socket had more pending requests after accepting the current one,
the last patch just wires it up for io_uring.

Not only does this enable applications to know whether there are more
connections to accept right now, it also enables smarter logic for
io_uring multishot accept on whether to retry immediately or wait for a
poll trigger.

Please pull!


The following changes since commit cddd2dc6390b90e62cec2768424d1d90f6d04161:

  Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue (2024-05-10 19:33:52 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/net-accept-more-20240515

for you to fetch changes up to ac287da2e0ea5be2523222981efec86f0ca977cd:

  io_uring/net: wire up IORING_CQE_F_SOCK_NONEMPTY for accept (2024-05-13 18:19:23 -0600)

----------------------------------------------------------------
net-accept-more-20240515

----------------------------------------------------------------
Jens Axboe (6):
      Merge branch 'for-6.10/io_uring' into net-accept-more
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next into net-accept-more
      net: change proto and proto_ops accept type
      net: have do_accept() take a struct proto_accept_arg argument
      net: pass back whether socket was empty post accept
      io_uring/net: wire up IORING_CQE_F_SOCK_NONEMPTY for accept

 crypto/af_alg.c                    | 11 ++++++-----
 crypto/algif_hash.c                | 10 +++++-----
 drivers/xen/pvcalls-back.c         |  6 +++++-
 fs/ocfs2/cluster/tcp.c             |  5 ++++-
 include/crypto/if_alg.h            |  3 ++-
 include/linux/net.h                |  4 +++-
 include/linux/socket.h             |  3 ++-
 include/net/inet_common.h          |  4 ++--
 include/net/inet_connection_sock.h |  2 +-
 include/net/sock.h                 | 13 ++++++++++---
 io_uring/net.c                     | 26 ++++++++++++++++++++------
 net/atm/svc.c                      |  8 ++++----
 net/ax25/af_ax25.c                 |  6 +++---
 net/bluetooth/iso.c                |  4 ++--
 net/bluetooth/l2cap_sock.c         |  4 ++--
 net/bluetooth/rfcomm/sock.c        |  6 +++---
 net/bluetooth/sco.c                |  4 ++--
 net/core/sock.c                    |  4 ++--
 net/ipv4/af_inet.c                 | 10 +++++-----
 net/ipv4/inet_connection_sock.c    |  7 ++++---
 net/iucv/af_iucv.c                 |  4 ++--
 net/llc/af_llc.c                   |  7 +++----
 net/mptcp/protocol.c               | 11 +++++------
 net/netrom/af_netrom.c             |  6 +++---
 net/nfc/llcp_sock.c                |  4 ++--
 net/phonet/pep.c                   | 12 ++++++------
 net/phonet/socket.c                |  7 +++----
 net/rds/tcp_listen.c               |  6 +++++-
 net/rose/af_rose.c                 |  6 +++---
 net/sctp/socket.c                  |  8 ++++----
 net/smc/af_smc.c                   |  6 +++---
 net/socket.c                       | 15 ++++++++++-----
 net/tipc/socket.c                  | 13 +++++--------
 net/unix/af_unix.c                 | 21 ++++++++++-----------
 net/vmw_vsock/af_vsock.c           |  6 +++---
 net/x25/af_x25.c                   |  4 ++--
 36 files changed, 156 insertions(+), 120 deletions(-)

-- 
Jens Axboe


