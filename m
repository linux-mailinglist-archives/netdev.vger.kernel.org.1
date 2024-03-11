Return-Path: <netdev+bounces-79216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D141987850E
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466D01F26A9D
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE7E4AEEA;
	Mon, 11 Mar 2024 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE5NGRat"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8C4AEC0
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173983; cv=none; b=Pd/2XVbEuU1eDplvY0X21KxrO4TwON51RA2OrdXYvQRdw3RvdXZYGbCendCq1lA7F18Ybp3MhImVwMTXOKE6xjWQoN+e9o/iC3lGX/NAfvpprvosE5rxNT8ZkwQOJT/kagyyPhEeCBIVrOq2voBv4R4lrYCNPyOb90imr8q4ReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173983; c=relaxed/simple;
	bh=qKPzHm/cI2wpmjZAWcCMB+nGT8s8+KuZYQVGHHNca8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtOeN1TyHBYjZ02mgnEcfJ6fWVp9HjX/LFN8caPB+FbMUU8SkfJijHEWSjzJfdEnLZcnClePWNLYlqJCVq5U2wd6k2szWjVA8L7moTse7VbzpViYBo372dTa3uh7BOi/+gxGKiv1xybASh91bF54r+RYtjG/NNb/NRQAEiXfZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE5NGRat; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68ee2c0a237so29830966d6.1
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173980; x=1710778780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tl2cQ1om+bniK6AfKft+/68dAHOOz7RyMMxeAhUFsco=;
        b=nE5NGRatMNSykrKxuZ6uK7D8k77tgMkx7hGOxk2JlJsFFpRdY+fTFUbqOfZiXsibpP
         gTgP+v6LAfqG/yAEcLw4pB5Z2p7q6cSVvRhDWiDQ+IzTdHxz4Qi8rqHXlJdxCjKYygVZ
         I0Doju1y/xTYDbf6Q1tPkHvo2kNwxxcmcPGbEp2fS1doh6ukK6KMURk/X9GZo2ljkddA
         TpinQL2stw5vtdrf4qOLbKZ6wI38b/+CisHZyTJ9boWAH+XK8dqiVkvGFZwIvVpUBFzc
         2bkbD8xEy8xcTIlZkdIu6QyZIcv1IRZnR0e+/o1JJPprQwAKdhnook1nLkR2xZD3J1hV
         NF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173980; x=1710778780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tl2cQ1om+bniK6AfKft+/68dAHOOz7RyMMxeAhUFsco=;
        b=qu3GbyXy8dEHKBey7+KrqoKtAR6ztB75L3S5h1JJOQzqKJE8jDf1LALAFxAEegJLzf
         YGTa9T4xOtK/wV1ZJCp0fRGcxXaXBKaW7IfMWFYUy5AibXX4lPnMH9br26LMCowKDegU
         RUvSrkZjZKi8SDbPWJ6C0LmFBTU/WHRRj9sipil4WrMs50tsGP67fzYuaaFxhQLYIQgi
         KsAisZaqq3kWSTLayhiFSfaOoX14D2C3Ok//5ceZ9yjP3UyUkZIzPDTB4pS4QWL4i1US
         iDEpc+RM+fJkuz5wHeslWiKOQbeu+FGV2IULdss+X+fdQZnfyhs8NcDVLqM8dcoisxmX
         2pLA==
X-Gm-Message-State: AOJu0Yy+29GLKOpJNckKuD1Bpj95u746tsBL4b9BaweliiGOZpk62HIv
	noA7ccFuM5ZiC+8FrtURGHE5ueP4bfwOaT+Gm8hmeen/uZ60PCc5ZFvpVWmONvg=
X-Google-Smtp-Source: AGHT+IE8npjo0Cqircr8BjD+dX3ZKkJT6FVRQIEg6ZTFMWvLOS9Tr1K7hKIbsvlr41FyLKjuLWbilQ==
X-Received: by 2002:ad4:4246:0:b0:690:d126:56ec with SMTP id l6-20020ad44246000000b00690d12656ecmr6569426qvq.12.1710173980477;
        Mon, 11 Mar 2024 09:19:40 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id w18-20020a056214013200b0068fc5887c9fsm2788245qvs.97.2024.03.11.09.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:19:40 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>
Subject: [RFC PATCH net-next 0/5] net: In-kernel QUIC implementation with Userspace handshake
Date: Mon, 11 Mar 2024 12:10:22 -0400
Message-ID: <cover.1710173427.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduction
============

This is an implementation of the QUIC protocol as defined in RFC9000. QUIC
is an UDP-Based Multiplexed and Secure Transport protocol, and it provides
applications with flow-controlled streams for structured communication,
low-latency connection establishment, and network path migration. QUIC
includes security measures that ensure confidentiality, integrity, and
availability in a range of deployment circumstances.

This implementation of QUIC in the kernel space enables users to utilize
the QUIC protocol through common socket APIs in user space. Additionally,
kernel subsystems like SMB and NFS can seamlessly operate over the QUIC
protocol after handshake using net/handshake APIs.

Note that In-Kernel QUIC implementation does NOT target Crypto Offload
support for existing Userland QUICs, and Crypto Offload intended for
Userland QUICs can NOT be utilized for Kernel consumers, such as SMB.
Therefore, there is no conflict between In-Kernel QUIC and Crypto
Offload for Userland QUICs.

This implementation offers fundamental support for the following RFCs:

- RFC9000 - QUIC: A UDP-Based Multiplexed and Secure Transport
- RFC9001 - Using TLS to Secure QUIC
- RFC9002 - QUIC Loss Detection and Congestion Control
- RFC9221 - An Unreliable Datagram Extension to QUIC
- RFC9287 - Greasing the QUIC Bit
- RFC9368 - Compatible Version Negotiation for QUIC
- RFC9369 - QUIC Version 2
- Handshake APIs for tlshd Use - SMB/NFS over QUIC

Implementation
==============

The central idea is to implement QUIC within the kernel, incorporating an
userspace handshake approach.

Only the processing and creation of raw TLS Handshake Messages, facilitated
by a tls library like gnutls, take place in userspace. These messages are
exchanged through sendmsg/recvmsg() mechanisms, with cryptographic details
carried in the control message (cmsg).

The entirety of QUIC protocol, excluding TLS Handshake Messages processing
and creation, resides in the kernel. Instead of utilizing a User Level
Protocol (ULP) layer, it establishes a socket of IPPROTO_QUIC type (similar
to IPPROTO_MPTCP) operating over UDP tunnels.

Kernel consumers can initiate a handshake request from kernel to userspace
via the existing net/handshake netlink. The userspace component, tlshd from
ktls-utils, manages the QUIC handshake request processing.

- Handshake Architecture:

      +------+  +------+
      | APP1 |  | APP2 | ...
      +------+  +------+
      +-------------------------------------------------+
      |                libquic (ktls-utils)             |<--------------+
      |      {quic_handshake_server/client/param()}     |               |
      +-------------------------------------------------+      +---------------------+
        {send/recvmsg()}         {set/getsockopt()}            | tlshd (ktls-utils)  |
        [CMSG handshake_info]    [SOCKOPT_CRYPTO_SECRET]       +---------------------+
                                 [SOCKOPT_TRANSPORT_PARAM_EXT]
              | ^                            | ^                        | ^
  Userspace   | |                            | |                        | |
  ------------|-|----------------------------|-|------------------------|-|--------------
  Kernel      | |                            | |                        | |
              v |                            v |                        v |
      +--------------------------------------------------+         +-------------+
      |  socket (IPPRTOTO_QUIC)  |       protocol        |<----+   | handshake   |
      +--------------------------------------------------+     |   | netlink APIs|
      | inqueue | outqueue | cong | path | connection_id |     |   +-------------+
      +--------------------------------------------------+     |      |      |
      |   packet   |   frame   |   crypto   |   pnmap    |     |   +-----+ +-----+
      +--------------------------------------------------+     |   |     | |     |
      |         input           |       output           |     |---| SMB | | NFS | ...
      +--------------------------------------------------+     |   |     | |     |
      |                   UDP tunnels                    |     |   +-----+ +--+--+
      +--------------------------------------------------+     +--------------|

- Post Handshake Architecture:

      +------+  +------+
      | APP1 |  | APP2 | ...
      +------+  +------+
        {send/recvmsg()}         {set/getsockopt()}
        [CMSG stream_info]       [SOCKOPT_KEY_UPDATE]
                                 [SOCKOPT_CONNECTION_MIGRATION]
                                 [SOCKOPT_STREAM_OPEN/RESET/STOP_SENDING]
                                 [...]
              | ^                            | ^
  Userspace   | |                            | |
  ------------|-|----------------------------|-|----------------
  Kernel      | |                            | |
              v |                            v |
      +--------------------------------------------------+
      |  socket (IPPRTOTO_QUIC)  |       protocol        |<----+ {kernel_send/recvmsg()}
      +--------------------------------------------------+     | {kernel_set/getsockopt()}
      | inqueue | outqueue | cong | path | connection_id |     |
      +--------------------------------------------------+     |
      |   packet   |   frame   |   crypto   |   pnmap    |     |   +-----+ +-----+
      +--------------------------------------------------+     |   |     | |     |
      |         input           |       output           |     |---| SMB | | NFS | ...
      +--------------------------------------------------+     |   |     | |     |
      |                   UDP tunnels                    |     |   +-----+ +--+--+
      +--------------------------------------------------+     +--------------|

Usage
=====

This implementation supports a mapping of QUIC into sockets APIs. Similar
to TCP and SCTP, a typical Server and Client use the following system call
sequence to communicate:

       Client                    Server
    ------------------------------------------------------------------
    sockfd = socket(IPPROTO_QUIC)      listenfd = socket(IPPROTO_QUIC)
    bind(sockfd)                       bind(listenfd)
                                       listen(listenfd)
    connect(sockfd)
    quic_client_handshake(sockfd)
                                       sockfd = accecpt(listenfd)
                                       quic_server_handshake(sockfd, cert)

    sendmsg(sockfd)                    recvmsg(sockfd)
    close(sockfd)                      close(sockfd)
                                       close(listenfd)

Please note that quic_client_handshake() and quic_server_handshake() functions
are currently sourced from libquic in the github lxin/quic repository, and might
be integrated into ktls-utils in the future. These functions are responsible for
receiving and processing the raw TLS handshake messages until the completion of
the handshake process.

For utilization by kernel consumers, it is essential to have the tlshd service
(from ktls-utils) installed and running in userspace. This service receives
and manages kernel handshake requests for kernel sockets. In kernel, the APIs
closely resemble those used in userspace:

       Client                    Server
    ------------------------------------------------------------------------
    __sock_create(IPPROTO_QUIC, &sock)  __sock_create(IPPROTO_QUIC, &sock)
    kernel_bind(sock)                   kernel_bind(sock)
                                        kernel_listen(sock)
    kernel_connect(sock)
    tls_client_hello_x509(args:{sock})
                                        kernel_accept(sock, &newsock)
                                        tls_server_hello_x509(args:{newsock})

    kernel_sendmsg(sock)                kernel_recvmsg(newsock)
    sock_release(sock)                  sock_release(newsock)
                                        sock_release(sock)

Please be aware that tls_client_hello_x509() and tls_server_hello_x509() are
APIs from net/handshake/. They are employed to dispatch the handshake request
to the userspace tlshd service and subsequently block until the handshake
process is completed.

For advanced usage,
see man doc: https://github.com/lxin/quic/wiki/man
and examples: https://github.com/lxin/quic/tree/main/tests

The QUIC module is currently labeled as "EXPERIMENTAL".

Xin Long (5):
  net: define IPPROTO_QUIC and SOL_QUIC constants for QUIC protocol
  net: include quic.h in include/uapi/linux for QUIC protocol
  net: implement QUIC protocol code in net/quic directory
  net: integrate QUIC build configuration into Kconfig and Makefile
  Documentation: introduce quic.rst to provide description of QUIC
    protocol

 Documentation/networking/quic.rst |  160 +++
 include/linux/socket.h            |    1 +
 include/uapi/linux/in.h           |    2 +
 include/uapi/linux/quic.h         |  189 +++
 net/Kconfig                       |    1 +
 net/Makefile                      |    1 +
 net/quic/Kconfig                  |   34 +
 net/quic/Makefile                 |   20 +
 net/quic/cong.c                   |  229 ++++
 net/quic/cong.h                   |   84 ++
 net/quic/connection.c             |  172 +++
 net/quic/connection.h             |  117 ++
 net/quic/crypto.c                 |  979 ++++++++++++++++
 net/quic/crypto.h                 |  140 +++
 net/quic/frame.c                  | 1803 ++++++++++++++++++++++++++++
 net/quic/frame.h                  |  162 +++
 net/quic/hashtable.h              |  125 ++
 net/quic/input.c                  |  693 +++++++++++
 net/quic/input.h                  |  169 +++
 net/quic/number.h                 |  174 +++
 net/quic/output.c                 |  638 ++++++++++
 net/quic/output.h                 |  194 +++
 net/quic/packet.c                 | 1179 +++++++++++++++++++
 net/quic/packet.h                 |   99 ++
 net/quic/path.c                   |  434 +++++++
 net/quic/path.h                   |  131 +++
 net/quic/pnmap.c                  |  217 ++++
 net/quic/pnmap.h                  |  134 +++
 net/quic/protocol.c               |  711 +++++++++++
 net/quic/protocol.h               |   56 +
 net/quic/sample_test.c            |  339 ++++++
 net/quic/socket.c                 | 1823 +++++++++++++++++++++++++++++
 net/quic/socket.h                 |  293 +++++
 net/quic/stream.c                 |  248 ++++
 net/quic/stream.h                 |  147 +++
 net/quic/timer.c                  |  241 ++++
 net/quic/timer.h                  |   29 +
 net/quic/unit_test.c              | 1024 ++++++++++++++++
 38 files changed, 13192 insertions(+)
 create mode 100644 Documentation/networking/quic.rst
 create mode 100644 include/uapi/linux/quic.h
 create mode 100644 net/quic/Kconfig
 create mode 100644 net/quic/Makefile
 create mode 100644 net/quic/cong.c
 create mode 100644 net/quic/cong.h
 create mode 100644 net/quic/connection.c
 create mode 100644 net/quic/connection.h
 create mode 100644 net/quic/crypto.c
 create mode 100644 net/quic/crypto.h
 create mode 100644 net/quic/frame.c
 create mode 100644 net/quic/frame.h
 create mode 100644 net/quic/hashtable.h
 create mode 100644 net/quic/input.c
 create mode 100644 net/quic/input.h
 create mode 100644 net/quic/number.h
 create mode 100644 net/quic/output.c
 create mode 100644 net/quic/output.h
 create mode 100644 net/quic/packet.c
 create mode 100644 net/quic/packet.h
 create mode 100644 net/quic/path.c
 create mode 100644 net/quic/path.h
 create mode 100644 net/quic/pnmap.c
 create mode 100644 net/quic/pnmap.h
 create mode 100644 net/quic/protocol.c
 create mode 100644 net/quic/protocol.h
 create mode 100644 net/quic/sample_test.c
 create mode 100644 net/quic/socket.c
 create mode 100644 net/quic/socket.h
 create mode 100644 net/quic/stream.c
 create mode 100644 net/quic/stream.h
 create mode 100644 net/quic/timer.c
 create mode 100644 net/quic/timer.h
 create mode 100644 net/quic/unit_test.c

-- 
2.43.0


