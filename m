Return-Path: <netdev+bounces-95032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E5A8C1472
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD6CB21279
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292D1770F2;
	Thu,  9 May 2024 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dVBrBlMx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B187441A
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277993; cv=none; b=ANPodVfzcgV1KeCUCfYo+bwFKIpGP36TYH3T5z2kzsuNdwyLNc9GK3txzoSDOhLw9DsGluFgT3SGa8zif6sAXPAanlFXQA5vQCkk4sn4I69xz8fHXAkPdm6wHXy79bdgKqkkuTWx9LgxWNttrUH4sd05cYTgCW8QvuE2mVTRYT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277993; c=relaxed/simple;
	bh=nJvf0+19Ak6nMFO86nEpkL3u66B7rYi6FXxb2XlHaao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OnyEumzHwqxx6enT194Gvf5q/jDcgdvgdSw/emrLTFOTdgHg1NihE2w2t5b/1J75VA3naLHDG7vE2bqkxK2CS7rcv06CA6OXXtbJ1eP5k8NPoMtYaLsUs9n97pEqJgCCLaxr/01OjULYosbG8X4NbON0dcm1SHCq15FJEk778ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dVBrBlMx; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7e18fe3164eso9758439f.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715277990; x=1715882790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VuaEukQr5J4tL+gRi+BGlLSodzKp68yXFmo7ZSi6OlQ=;
        b=dVBrBlMxIfqzqYKy+8TEMlw8Dn8xKwX1nMAggEsR3C8S0MowieY/yiQp7Xefmu95Lb
         98ZbwJr88ZgMeMdFGshcjb+hplSpBPY1qW8pe2QNf3ijgSz9yhmsTkrharFJcTtwZTBf
         vBo3hDaeAMC0IaDySp24hQpZNw+b/oKhFEWVKebSRUUPEz2M2SyeJpkPDYNn1HylppzG
         bh6uhSvcKpzZUgokNelbnQSS6ns50KohOLKhCY+h6/Az4OA0f/7dLX2rGR9j89uta58h
         uGqPLN14yimIfzxn7/uuYmbxrLSTe5U7IhLlG67T62hGyFzkEBq9JZfN2WcOSp1ElkBR
         Euhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715277990; x=1715882790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuaEukQr5J4tL+gRi+BGlLSodzKp68yXFmo7ZSi6OlQ=;
        b=D0k1daeAYCPEjAdxOk6/iOPAFOkcFqwJhVQ4eE/l0kkipXOe+sq1lvd+jUdTyqHmLR
         9UM4Q48QjN/2wAVT9H3pSz2O46PshaakJbKDmQtvNO++AilpcocTsKHexf9rJs+IJBjo
         AZJQqdN5MunmB9EsCmM3TdQk4h+1WmMSj3QBEADFIGGrBfWfsYcTktLULJk4QJGbdHZL
         qnJmipEHi95FcrsSpszxk3VoGd+VKWZxqxyk69JAIC3lh1bkd7RJOQ66Sn5QDcz6nFW6
         mejUVrpzRZiFNwmLpKCyyJOnpvBEXGlC1jin0YrDctBfk9V1tlnNEEJKtzblbAX2Z+F8
         vW0A==
X-Forwarded-Encrypted: i=1; AJvYcCUAjs3fCCwjnKCHdLbp1ij7vdebGnbPgk+JXaMy51Lwq/lNS9iLi6OuwYmJuRweB9OmcrveQVHbx1VqRDnVdAi+H49l4NhF
X-Gm-Message-State: AOJu0YzucFLYoEnRNtSVF9VhI50BlIgad5RBM+QS0LA/VGFLH9Vl1IWQ
	01mK/yxegMh4W+nreTs5Eoq0xyd73AB7KUjno5B5LM5SjoegLEt1wYHhQgay8j53z5Nj0EZ4cpe
	J
X-Google-Smtp-Source: AGHT+IGlgkx997Vi/uU0WCbQDYcHNPDaGv6PRCSt8JvQCfR93Xc8AcpWOapgSvjFHzDeEcG2Y2vj0g==
X-Received: by 2002:a6b:d203:0:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7e1b5022577mr62443939f.0.1715277989657;
        Thu, 09 May 2024 11:06:29 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1b23ab4f6sm19468739f.50.2024.05.09.11.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 11:06:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org
Subject: [PATCHSET RFC 0/4] Propagate back queue status on accept
Date: Thu,  9 May 2024 12:00:25 -0600
Message-ID: <20240509180627.204155-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

With io_uring, one thing we can do is tell userspace whether or not
there's more data left in a socket after a receive is done. This is
useful for applications to now, and it also helps make multishot receive
requests more efficient by eliminating that last failed retry when the
socket has no more data left. This is propagated by setting the
IORING_CQE_F_SOCK_NONEMPTY flag, and is driven by setting
msghdr->msg_get_inq and having the protocol fill out msghdr->msg_inq in
that case.

For accept, there's a similar issue in that we'd like to know if there
are more connections to accept after the current one has been accepted.
Both because we can tell userspace about it, but also to drive multishot
accept retries more efficiently, similar to recv/recvmsg.

This series starts by changing the proto/proto_ops accept prototypes
to eliminate flags/errp/kern and replace it with a structure that
encompasses all of them.

Then patch 2 changes do_accept(), which io_uring uses, to take that
as well.

Patch 3 finally adds the basic is_empty argument to the struct,
and fills it in for TCP.

And finally patch 4 adds support for this in io_uring.

Comments welcome! Patchset is against current -git, with the io_uring
and net-next changes for 6.10 merged in. Branch can be found here:

https://git.kernel.dk/cgit/linux/log/?h=net-accept-more

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
 net/llc/af_llc.c                   |  7 +++----
 net/mptcp/protocol.c               |  8 ++++----
 net/netrom/af_netrom.c             |  6 +++---
 net/nfc/llcp_sock.c                |  4 ++--
 net/phonet/pep.c                   | 12 ++++++------
 net/phonet/socket.c                |  7 +++----
 net/rds/tcp_listen.c               |  6 +++++-
 net/rose/af_rose.c                 |  6 +++---
 net/sctp/socket.c                  |  8 ++++----
 net/smc/af_smc.c                   |  6 +++---
 net/socket.c                       | 15 ++++++++++-----
 net/tipc/socket.c                  | 10 ++++------
 net/unix/af_unix.c                 | 10 +++++-----
 net/vmw_vsock/af_vsock.c           |  6 +++---
 net/x25/af_x25.c                   |  4 ++--
 35 files changed, 147 insertions(+), 108 deletions(-)

-- 
Jens Axboe



