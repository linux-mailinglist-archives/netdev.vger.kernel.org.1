Return-Path: <netdev+bounces-255932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FOdMH7SgGlBBwMAu9opvQ
	(envelope-from <netdev+bounces-255932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:36:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DA0CF084
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B884306D860
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34FF3783AE;
	Mon,  2 Feb 2026 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDG0Jb5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0B2777FC
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049742; cv=none; b=XATaOSMjjxwzfAy4GdKadbWqkJgJLjRVVNkZh15U7sIrPdeAdjpaSLUzqXjnD5mgtLxaLrY+HaZAWZvdeRAEXDODqQUzhxoOuS7MiLxlbhfw7AhmVBSoS3A6QbyZ6fcJupG+SGItypvfhbFH79eqUxlw5sGgZZLna40he41gOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049742; c=relaxed/simple;
	bh=63fTxHcfNz+y6CmmsuhuTQ1tw+dCqMKhDbrMdSkShds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fETEmP550p4oYr2RXyJ2+LE8nkB+lh8Xi5dYawM4xn3Sgk16eg7VvPvakWgJSg8MMZUWeFQxvA0PeFg+pALpf7fk43+jIrHCtmJYlvd/jxkGzcNVoNy6CY/7ZRH/OrznRrQKolzQn7fLGiPJxYr0KgOccaapTbB7D11+50KrRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDG0Jb5Z; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8887ac841e2so41609506d6.2
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 08:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770049739; x=1770654539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yGTtUh+HMJcq464alMsXhC8I3gyi2aFxQJNPr3INNTA=;
        b=VDG0Jb5ZqPYd8IulygXxxFaWuFcXprThw7CxwvU/FhseXM6aZyjh0T6XR/S/SofheW
         7YDoQUmSHWN0StV7eUijKT9Yq7s3lcKrR4VVR85kSiWJ+384ONq+kKdM/eFrrBzQ/9yj
         GXAkRM5ujvuRlFQDF2XuM1TYcVCOyNs/x9DsdrPwvoKOf+karezK1R+K/j0w4i2TScIa
         dq/6ZNsiz/SPMI0hHkOGi+GX+m/7QF1IQ6+GisvtZXB+qd/g5pTkQ0YPDWVWHqnjsJ7U
         bCRXAJ+9emDNPrhYOWnG3uOfwi/BQiv3ch30GWt6QDNzi5/xJ5cVaybw7pbcCY9mUt7i
         svEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049739; x=1770654539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGTtUh+HMJcq464alMsXhC8I3gyi2aFxQJNPr3INNTA=;
        b=a9UlenHuxZ9Lp4BM+r6RCzbT5sSv4OHuMRjMWXNMT3DMOJvpgys5/NYndL0QUMu+cS
         7gnrmLUedqWrY+MFFACek5cAUyPb4r8CCbh+759uM2oAbF/9WoUY04g2G4h5oRC/VesN
         vgFlz/vxiQpFZ7h1x1JD8zvsbfrs7KE1aW4Wplng/72XnMjp4Y0/+Qim+wgo3G+WlP5N
         1HGWbcMk1YYN2IlsoTr4Q84WMdN2I0TTVrUM1Mn0RZmIb4hXVY5V1oA4fLqUV6+BkimQ
         BQYXg2f2FCtrARk4Xis8fzMbxY51l/Hz7n9S+Lm9IaoLA7h7Se5CYc7OtPnEiT6goR6b
         BNbQ==
X-Gm-Message-State: AOJu0YxnzofPqyJYOGtdvSMcDK8inlE49Vy3BsvKqkcvbYJGCFmmRTvL
	FWS//V/hRR+M0hZBuAM7lYfNvvsq+2EActDkcPAoSSDPY4r9jpO4ZT2Sbi3R0IGg
X-Gm-Gg: AZuq6aLK5CKfmRQdtXBvDSLRx9BdrEKBF7ZHJBTv90qjSg9mqMc2CpA0VuH9qNLb5TD
	Ra61snQ9ULVTY5V7Kwlqrt7SUOyrDwFcvSIo4+WFwTtrINKyeT92JAjVc8L6i+txKZpexe0ZAf0
	8aQxjPZv3eeaiiS96qyY0gnQAeAhzdAny74xzeOCVTM1DvZzHeOshL94GuNihD6eVXIL6o4Zppc
	sQGmRA2p4tZ6EThsxf4gb9Lmo9af8Difxn3mpMUpEd0/53n7Y+fwz/WKdLJui2gJMyumN1lojL8
	a38IqfjFvTYcxVQhmr2dqEEzJhEe1/Euq/p0SSyaWSlWeijqoEkLe3PwEEbrWV6ewhkur7L5MhB
	Jw3z+AyOCRvIX5qnYV6MwOYaLEhhfgFzqW2YWjAynfE/f7m4B4plQ76lgN3WlbIVlL7hIhLrBVZ
	v7k05eclcNRRRztbB2ATVVXd7CkdylojvgaYPgLj6HRh/4pC48QIg=
X-Received: by 2002:ac8:5a85:0:b0:4f0:153a:65ec with SMTP id d75a77b69052e-505d226f7bbmr127851771cf.40.1770042591459;
        Mon, 02 Feb 2026 06:29:51 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337ba3981sm106865171cf.16.2026.02.02.06.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 06:29:50 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	quic@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Metzmacher <metze@samba.org>,
	Moritz Buhl <mbuhl@openbsd.org>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>,
	Thomas Dreibholz <dreibh@simula.no>,
	linux-cifs@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Steve Dickson <steved@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Alexander Aring <aahringo@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	John Ericson <mail@johnericson.me>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Jason Baron <jbaron@akamai.com>,
	illiliti <illiliti@protonmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next v9 00/15] net: introduce QUIC infrastructure and core subcomponents
Date: Mon,  2 Feb 2026 09:27:26 -0500
Message-ID: <cover.1770042461.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255932-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,samba.org,openbsd.org,xiaomi.com,simula.no,vger.kernel.org,gmail.com,manguebit.com,talpey.com,lists.linux.dev,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[office.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nghttp2.org:url,moritzbuhl.de:url,cloudflare-quic.com:url]
X-Rspamd-Queue-Id: 24DA0CF084
X-Rspamd-Action: no action

Introduction
============

The QUIC protocol, defined in RFC 9000, is a secure, multiplexed transport
built on top of UDP. It enables low-latency connection establishment,
stream-based communication with flow control, and supports connection
migration across network paths, while ensuring confidentiality, integrity,
and availability.

This implementation introduces QUIC support in Linux Kernel, offering
several key advantages:

- In-Kernel QUIC Support for Subsystems: Enables kernel subsystems
  such as SMB and NFS to operate over QUIC with minimal changes. Once the
  handshake is complete via the net/handshake APIs, data exchange proceeds
  over standard in-kernel transport interfaces.

- Standard Socket API Semantics: Implements core socket operations
  (listen(), accept(), connect(), sendmsg(), recvmsg(), close(),
  getsockopt(), setsockopt(), getsockname(), and getpeername()),
  allowing user space to interact with QUIC sockets in a familiar,
  POSIX-compliant way.

- ALPN-Based Connection Dispatching: Supports in-kernel ALPN
  (Application-Layer Protocol Negotiation) routing, allowing demultiplexing
  of QUIC connections across different user-space processes based
  on the ALPN identifiers.

- Performance Enhancements: Handles all control messages in-kernel
  to reduce syscall overhead, incorporates zero-copy mechanisms such as
  sendfile() to minimize data movement, and is also structured to support
  future crypto hardware offloads.

This implementation offers fundamental support for the following RFCs:

- RFC9000 - QUIC: A UDP-Based Multiplexed and Secure Transport
- RFC9001 - Using TLS to Secure QUIC
- RFC9002 - QUIC Loss Detection and Congestion Control
- RFC9221 - An Unreliable Datagram Extension to QUIC
- RFC9287 - Greasing the QUIC Bit
- RFC9368 - Compatible Version Negotiation for QUIC
- RFC9369 - QUIC Version 2

The socket APIs for QUIC follow the RFC draft [1]:

- The Sockets API Extensions for In-kernel QUIC Implementations

Implementation
==============

The central design is to implement QUIC within the kernel while delegating
the handshake to userspace.

Only the processing and creation of raw TLS Handshake Messages are handled
in userspace, facilitated by a TLS library like GnuTLS. These messages are
exchanged between kernel and userspace via sendmsg() and recvmsg(), with
cryptographic details conveyed through control messages (cmsg).

The entire QUIC protocol, aside from the TLS Handshake Messages processing
and creation, is managed in the kernel. Rather than using an Upper Layer
Protocol (ULP) layer, this implementation establishes a socket of type
IPPROTO_QUIC (similar to IPPROTO_MPTCP), operating over UDP tunnels.

For kernel consumers, they can initiate a handshake request from the kernel
to userspace using the existing net/handshake netlink. The userspace
component, such as tlshd service [2], then manages the processing
of the QUIC handshake request.

- Handshake Architecture:

  ┌──────┐  ┌──────┐
  │ APP1 │  │ APP2 │ ...
  └──────┘  └──────┘
  ┌──────────────────────────────────────────┐
  │     {quic_client/server_handshake()}     │<─────────────┐
  └──────────────────────────────────────────┘       ┌─────────────┐
   {send/recvmsg()}      {set/getsockopt()}          │    tlshd    │
   [CMSG handshake_info] [SOCKOPT_CRYPTO_SECRET]     └─────────────┘
                         [SOCKOPT_TRANSPORT_PARAM_EXT]    │   ^
                │ ^                  │ ^                  │   │
  Userspace     │ │                  │ │                  │   │
  ──────────────│─│──────────────────│─│──────────────────│───│───────
  Kernel        │ │                  │ │                  │   │
                v │                  v │                  v   │
  ┌──────────────────┬───────────────────────┐       ┌─────────────┐
  │ protocol, timer, │ socket (IPPROTO_QUIC) │<──┐   │ handshake   │
  │                  ├───────────────────────┤   │   │netlink APIs │
  │ common, family,  │ outqueue  |  inqueue  │   │   └─────────────┘
  │                  ├───────────────────────┤   │      │       │
  │ stream, connid,  │         frame         │   │   ┌─────┐ ┌─────┐
  │                  ├───────────────────────┤   │   │     │ │     │
  │ path, pnspace,   │         packet        │   │───│ SMB │ │ NFS │...
  │                  ├───────────────────────┤   │   │     │ │     │
  │ cong, crypto     │       UDP tunnels     │   │   └─────┘ └─────┘
  └──────────────────┴───────────────────────┘   └──────┴───────┘

- User Data Architecture:

  ┌──────┐  ┌──────┐
  │ APP1 │  │ APP2 │ ...
  └──────┘  └──────┘
   {send/recvmsg()}   {set/getsockopt()}              {recvmsg()}
   [CMSG stream_info] [SOCKOPT_KEY_UPDATE]            [EVENT conn update]
                      [SOCKOPT_CONNECTION_MIGRATION]  [EVENT stream update]
                      [SOCKOPT_STREAM_OPEN/RESET/STOP]
                │ ^               │ ^                     ^
  Userspace     │ │               │ │                     │
  ──────────────│─│───────────────│─│─────────────────────│───────────
  Kernel        │ │               │ │                     │
                v │               v │  ┌──────────────────┘
  ┌──────────────────┬───────────────────────┐
  │ protocol, timer, │ socket (IPPROTO_QUIC) │<──┐{kernel_send/recvmsg()}
  │                  ├───────────────────────┤   │{kernel_set/getsockopt()}
  │ common, family,  │ outqueue  |  inqueue  │   │{kernel_recvmsg()}
  │                  ├───────────────────────┤   │
  │ stream, connid,  │         frame         │   │   ┌─────┐ ┌─────┐
  │                  ├───────────────────────┤   │   │     │ │     │
  │ path, pnspace,   │         packet        │   │───│ SMB │ │ NFS │...
  │                  ├───────────────────────┤   │   │     │ │     │
  │ cong, crypto     │       UDP tunnels     │   │   └─────┘ └─────┘
  └──────────────────┴───────────────────────┘   └──────┴───────┘

Interface
=========

This implementation supports a mapping of QUIC into sockets APIs. Similar
to TCP and SCTP, a typical Server and Client use the following system call
sequence to communicate:

    Client                             Server
  ──────────────────────────────────────────────────────────────────────
  sockfd = socket(IPPROTO_QUIC)      listenfd = socket(IPPROTO_QUIC)
  bind(sockfd)                       bind(listenfd)
                                     listen(listenfd)
  connect(sockfd)
  quic_client_handshake(sockfd)
                                     sockfd = accept(listenfd)
                                     quic_server_handshake(sockfd, cert)

  sendmsg(sockfd)                    recvmsg(sockfd)
  close(sockfd)                      close(sockfd)
                                     close(listenfd)

Please note that quic_client_handshake() and quic_server_handshake()
functions are currently sourced from libquic [3]. These functions are
responsible for receiving and processing the raw TLS handshake messages
until the completion of the handshake process.

For utilization by kernel consumers, it is essential to have tlshd
service [2] installed and running in userspace. This service receives
and manages kernel handshake requests for kernel sockets. In the kernel,
the APIs closely resemble those used in userspace:

    Client                             Server
  ────────────────────────────────────────────────────────────────────────
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

Please be aware that tls_client_hello_x509() and tls_server_hello_x509()
are APIs from net/handshake/. They are used to dispatch the handshake
request to the userspace tlshd service and subsequently block until the
handshake process is completed.

Use Cases
=========

- Samba

  Stefan Metzmacher has integrated Linux QUIC into Samba for both client
  and server roles [4].

- tlshd

  The tlshd daemon [2] facilitates Linux QUIC handshake requests from
  kernel sockets. This is essential for enabling protocols like SMB
  and NFS over QUIC.

- curl

  Linux QUIC is being integrated into curl [5] for HTTP/3. Example usage:

  # curl --http3-only https://nghttp2.org:4433/
  # curl --http3-only https://www.google.com/
  # curl --http3-only https://facebook.com/
  # curl --http3-only https://outlook.office.com/
  # curl --http3-only https://cloudflare-quic.com/

- httpd-portable

  Moritz Buhl has deployed an HTTP/3 server over Linux QUIC [6] that is
  accessible via Firefox and curl:

  https://d.moritzbuhl.de/pub

- NetPerfMeter

  The latest NetPerfMeter release supports Linux QUIC and can be used to
  run performance evaluations [10].

Test Coverage
=============

The Coverage (gcov) of Functional and Interop Tests:

https://d.moritzbuhl.de/lcov

- Functional Tests

  The libquic self-tests (make check) pass on all major architectures:
  x86_64, i386, s390x, aarch64, ppc64le.

- Interop tests

  Interoperability was validated using the QUIC Interop Runner [7] against
  all major userland QUIC stacks. Results are available at:

  https://d.moritzbuhl.de/

- Fuzzing via Syzkaller

  Syzkaller has been running kernel fuzzing with QUIC for weeks using
  tests/syzkaller/ in libquic [3].

- Performance Testing

  Performance was benchmarked using iperf [8] over a 100G NIC using
  various MTUs and packet sizes:

  - QUIC vs. kTLS:

    UNIT        size:1024      size:4096      size:16384     size:65536
    Gbits/sec   QUIC | kTLS    QUIC | kTLS    QUIC | kTLS    QUIC | kTLS
    ────────────────────────────────────────────────────────────────────
    mtu:1500    2.27 | 3.26    3.02 | 6.97    3.36 | 9.74    3.48 | 10.8
    ────────────────────────────────────────────────────────────────────
    mtu:9000    3.66 | 3.72    5.87 | 8.92    7.03 | 11.2    8.04 | 11.4

  - QUIC(disable_1rtt_encryption) vs. TCP:

    UNIT        size:1024      size:4096      size:16384     size:65536
    Gbits/sec   QUIC | TCP     QUIC | TCP     QUIC | TCP     QUIC | TCP
    ────────────────────────────────────────────────────────────────────
    mtu:1500    3.09 | 4.59    4.46 | 14.2    5.07 | 21.3    5.18 | 23.9
    ────────────────────────────────────────────────────────────────────
    mtu:9000    4.60 | 4.65    8.41 | 14.0    11.3 | 28.9    13.5 | 39.2


  The performance gap between QUIC and kTLS may be attributed to:

  - The absence of Generic Segmentation Offload (GSO) for QUIC.
  - An additional data copy on the transmission (TX) path.
  - Extra encryption required for header protection in QUIC.
  - A longer header length for the stream data in QUIC.

Patches
=======

Note: This implementation is organized into five parts and submitted across
two patchsets for review. This patchset includes Parts 1–2, while Parts 3–5
will be submitted in a subsequent patchset. For complete series, see [9].

1. Infrastructure (2):

  net: define IPPROTO_QUIC and SOL_QUIC constants
  net: build socket infrastructure for QUIC protocol

2. Subcomponents (13):

  quic: provide common utilities and data structures
  quic: provide family ops for address and protocol
  quic: provide quic.h header files for kernel and userspace
  quic: add stream management
  quic: add connection id management
  quic: add path management
  quic: add congestion control
  quic: add packet number space
  quic: add crypto key derivation and installation
  quic: add crypto packet encryption and decryption
  quic: add timer management
  quic: add packet builder base
  quic: add packet parser base

3. Data Processing (8):

  quic: add frame encoder and decoder base
  quic: implement outqueue transmission and flow control
  quic: implement outqueue sack and retransmission
  quic: implement inqueue receiving and flow control
  quic: implement frame creation functions
  quic: implement frame processing functions
  quic: implement packet creation functions
  quic: implement packet processing functions

4. Socket APIs (6):

  quic: support bind/listen/connect/accept/close()
  quic: support sendmsg() and recvmsg()
  quic: support socket options related to interaction after handshake
  quic: support socket options related to settings prior to handshake
  quic: support socket options related to setup during handshake
  quic: support socket ioctls and socket dump via procfs

5. Documentation and Selftests (3):

  Documentation: describe QUIC protocol interface in quic.rst
  quic: create sample test using handshake APIs for kernel consumers
  selftests: net: add tests for QUIC protocol

Notice: The QUIC module is currently labeled as "EXPERIMENTAL".

All contributors are recognized in the respective patches with the tag of
'Signed-off-by:'. Special thanks to Moritz Buhl and Stefan Metzmacher whose
practical use cases and insightful feedback have been instrumental in
shaping the design and advancing the development.

References
==========

[1]  https://datatracker.ietf.org/doc/html/draft-lxin-quic-socket-apis
[2]  https://github.com/oracle/ktls-utils
[3]  https://github.com/lxin/quic
[4]  https://gitlab.com/samba-team/samba/-/merge_requests/4019
[5]  https://github.com/moritzbuhl/curl/tree/linux_curl
[6]  https://github.com/moritzbuhl/httpd-portable
[7]  https://github.com/quic-interop/quic-interop-runner
[8]  https://github.com/lxin/iperf
[9]  https://github.com/lxin/net-next/commits/quic/
[10] https://www.nntb.no/~dreibh/netperfmeter/

Changes in v2-v9: See individual patch changelogs for details.

Xin Long (15):
  net: define IPPROTO_QUIC and SOL_QUIC constants
  net: build socket infrastructure for QUIC protocol
  quic: provide common utilities and data structures
  quic: provide family ops for address and protocol
  quic: provide quic.h header files for kernel and userspace
  quic: add stream management
  quic: add connection id management
  quic: add path management
  quic: add congestion control
  quic: add packet number space
  quic: add crypto key derivation and installation
  quic: add crypto packet encryption and decryption
  quic: add timer management
  quic: add packet builder base
  quic: add packet parser base

 Documentation/networking/ip-sysctl.rst |   39 +
 MAINTAINERS                            |    9 +
 include/linux/quic.h                   |   20 +
 include/linux/socket.h                 |    1 +
 include/uapi/linux/in.h                |    2 +
 include/uapi/linux/quic.h              |  235 +++++
 net/Kconfig                            |    1 +
 net/Makefile                           |    1 +
 net/quic/Kconfig                       |   36 +
 net/quic/Makefile                      |    9 +
 net/quic/common.c                      |  583 +++++++++++
 net/quic/common.h                      |  204 ++++
 net/quic/cong.c                        |  307 ++++++
 net/quic/cong.h                        |  120 +++
 net/quic/connid.c                      |  227 +++++
 net/quic/connid.h                      |  163 ++++
 net/quic/crypto.c                      | 1226 ++++++++++++++++++++++++
 net/quic/crypto.h                      |   83 ++
 net/quic/family.c                      |  372 +++++++
 net/quic/family.h                      |   33 +
 net/quic/packet.c                      |  888 +++++++++++++++++
 net/quic/packet.h                      |  116 +++
 net/quic/path.c                        |  522 ++++++++++
 net/quic/path.h                        |  170 ++++
 net/quic/pnspace.c                     |  225 +++++
 net/quic/pnspace.h                     |  150 +++
 net/quic/protocol.c                    |  405 ++++++++
 net/quic/protocol.h                    |   62 ++
 net/quic/socket.c                      |  436 +++++++++
 net/quic/socket.h                      |  213 ++++
 net/quic/stream.c                      |  400 ++++++++
 net/quic/stream.h                      |  119 +++
 net/quic/timer.c                       |  196 ++++
 net/quic/timer.h                       |   47 +
 34 files changed, 7620 insertions(+)
 create mode 100644 include/linux/quic.h
 create mode 100644 include/uapi/linux/quic.h
 create mode 100644 net/quic/Kconfig
 create mode 100644 net/quic/Makefile
 create mode 100644 net/quic/common.c
 create mode 100644 net/quic/common.h
 create mode 100644 net/quic/cong.c
 create mode 100644 net/quic/cong.h
 create mode 100644 net/quic/connid.c
 create mode 100644 net/quic/connid.h
 create mode 100644 net/quic/crypto.c
 create mode 100644 net/quic/crypto.h
 create mode 100644 net/quic/family.c
 create mode 100644 net/quic/family.h
 create mode 100644 net/quic/packet.c
 create mode 100644 net/quic/packet.h
 create mode 100644 net/quic/path.c
 create mode 100644 net/quic/path.h
 create mode 100644 net/quic/pnspace.c
 create mode 100644 net/quic/pnspace.h
 create mode 100644 net/quic/protocol.c
 create mode 100644 net/quic/protocol.h
 create mode 100644 net/quic/socket.c
 create mode 100644 net/quic/socket.h
 create mode 100644 net/quic/stream.c
 create mode 100644 net/quic/stream.h
 create mode 100644 net/quic/timer.c
 create mode 100644 net/quic/timer.h

-- 
2.47.1


