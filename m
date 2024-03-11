Return-Path: <netdev+bounces-79220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524BF878529
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D214C1F26AAD
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A835A78C;
	Mon, 11 Mar 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyHqQh3m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAAA5026D
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173988; cv=none; b=G+HLTLRC+PGLlY7+9NNDftCsBRbHN34SUAUPNDG13yjo3RPVtDLynUF+9sJGY304vF2TwPcMG/BogclehKTlpVGWDM4onZqDY8N1Ntkku4LRXKlSXZhc0mB1xHrLY2Sfs9Sh6muOB9nqWNo0MS5GPOX6IFt4bDajJ4oqsJP5pFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173988; c=relaxed/simple;
	bh=rPLT6/qT6z7jTelqz9r8zgOf0Ll3Asj2mb8jcgDV+yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsoZFyQoqEGyIDTdXx2MwIa08yUhOq1fe3j4bGtRBuC/BUCKheVAsbT5UXv+Ai+5yJoOV/sVojaiKUvVlpDX6mrxmD8lU60D7BVErId7YiKNCs3/lArlj4mrNPAMXfsvweG95ytMqpSf4MlYaExncToaK3ERK6w5BLX+cLSHN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyHqQh3m; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68f571be9ddso39243896d6.0
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173985; x=1710778785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fr18Eer6KFN5crd5UPQZa0X0rvAm4GHlkjr53amniPI=;
        b=EyHqQh3mEvK28jUsjpEJOkTBes9LBDkhf95x4MAlgavZRDnJY4W4Ytu55BxhaxKurb
         xYuZgoYpjds5rHqYRYckRChLjhA6fKfQpwW8mqb6tilJm86/BENB2e6Pp9kEn9hddKsn
         cW3SF62auiZpRhU/n/iJlP9A0YqYlah2KZWls63aunzSIpsF8+QfwweQO7z04di/A9fR
         2I7STQIepKl6wyiZOoloa8lF+rsI/6ASIoroOU1Jxgtv4jUgw+EhTk/rOP4vZLXepo3V
         keM8MsWw3/6xHMcC7aNiAxWiyb2WRqjnDLmS2U/kHxMlik58P9rzdC5FGi5/7/eI5le4
         HmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173985; x=1710778785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr18Eer6KFN5crd5UPQZa0X0rvAm4GHlkjr53amniPI=;
        b=Cu6X/dKB8X4pcgLUKX0Bo/bncvVO0iYFo+sMfMXAjUUN06yDDbuhRHiYSlvCM+TN0s
         8b0C6zsxsBBfPIClg49Wg8LDeVo6yJTG+4BchbbCMdAnKvapIpv61bqrsRI/SdadmTnT
         GcYsQErIt/CGONFl6msmrr+DTfkkSuGE8BQfjwGjMtfEZ9vJifHR/r15cggb5fuOJdDM
         u2E+isHfPDP0yfWOfwmuoSObqGtrBZy0siiuwRKeY7b5x+h6uT9I5X6QoUYaPho8arfS
         d4z9N0V4DRuWKNi6QsKhOp5T6Gv/fKoJJipoRktYcrYFbpv/7B3cA6cVIVeryspJ5/VC
         tZaQ==
X-Gm-Message-State: AOJu0YzwU0Fe8ezri8AYVkVaSWFAS7RhkR1koBrr64cTJrJPg0CaXHhK
	IJowcvKDAHQgCE98hWzZLr4tb3jmvA4vZMrNCprZJlZ9zocNA/cehbqrW6yIzi4=
X-Google-Smtp-Source: AGHT+IHoCHj8U1+9PWbh2Z7OMjlHyIJqDCM/H4CCuJSCWPFZBG+spmGuYgBUvU7dkUs9lHE4k0lf5w==
X-Received: by 2002:ad4:57cc:0:b0:690:d6fe:acc1 with SMTP id y12-20020ad457cc000000b00690d6feacc1mr1942704qvx.9.1710173985310;
        Mon, 11 Mar 2024 09:19:45 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id w18-20020a056214013200b0068fc5887c9fsm2788245qvs.97.2024.03.11.09.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:19:45 -0700 (PDT)
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
Subject: [RFC PATCH net-next 5/5] Documentation: introduce quic.rst to provide description of QUIC protocol
Date: Mon, 11 Mar 2024 12:10:27 -0400
Message-ID: <816c9fedc063828e057726fac14c6d84552e251e.1710173427.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710173427.git.lucien.xin@gmail.com>
References: <cover.1710173427.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds quic.rst to the documentation directory, providing
comprehensive information about the QUIC protocol. This new file
serves as a reference for users and developers seeking details on
QUIC implementation and usage.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
Signed-off-by: Pengtao He <hepengtao@xiaomi.com>
---
 Documentation/networking/quic.rst | 160 ++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/networking/quic.rst

diff --git a/Documentation/networking/quic.rst b/Documentation/networking/quic.rst
new file mode 100644
index 000000000000..d885cbcb8ef1
--- /dev/null
+++ b/Documentation/networking/quic.rst
@@ -0,0 +1,160 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Linux Kernel QUIC
+=================
+
+Introduction
+============
+
+This is an implementation of the QUIC protocol as defined in RFC9000. QUIC
+is an UDP-Based Multiplexed and Secure Transport protocol, and it provides
+applications with flow-controlled streams for structured communication,
+low-latency connection establishment, and network path migration. QUIC
+includes security measures that ensure confidentiality, integrity, and
+availability in a range of deployment circumstances.
+
+This implementation of QUIC in the kernel space enables users to utilize
+the QUIC protocol through common socket APIs in user space. Additionally,
+kernel subsystems like SMB and NFS can seamlessly operate over the QUIC
+protocol after handshake using net/handshake APIs.
+
+This implementation offers fundamental support for the following RFCs:
+
+- RFC9000 - QUIC: A UDP-Based Multiplexed and Secure Transport
+- RFC9001 - Using TLS to Secure QUIC
+- RFC9002 - QUIC Loss Detection and Congestion Control
+- RFC9221 - An Unreliable Datagram Extension to QUIC
+- RFC9287 - Greasing the QUIC Bit
+- RFC9368 - Compatible Version Negotiation for QUIC
+- RFC9369 - QUIC Version 2
+- Handshake APIs for tlshd Use - NFS/SMB over QUIC
+
+Implementation
+==============
+
+The central idea is to implement QUIC within the kernel, incorporating an
+userspace handshake approach.
+
+Only the processing and creation of raw TLS Handshake Messages, facilitated
+by a tls library like gnutls, take place in userspace. These messages are
+exchanged through sendmsg/recvmsg() mechanisms, with cryptographic details
+carried in the control message (cmsg).
+
+The entirety of QUIC protocol, excluding TLS Handshake Messages processing
+and creation, resides in the kernel. Instead of utilizing a User Level
+Protocol (ULP) layer, it establishes a socket of IPPROTO_QUIC type (similar
+to IPPROTO_MPTCP) operating over UDP tunnels.
+
+Kernel consumers can initiate a handshake request from kernel to userspace
+via the existing net/handshake netlink. The userspace component, tlshd from
+ktls-utils, manages the QUIC handshake request processing.
+
+- Handshake Architecture:
+
+      +------+  +------+
+      | APP1 |  | APP2 | ...
+      +------+  +------+
+      +-------------------------------------------------+
+      |                libquic (ktls-utils)             |<--------------+
+      |      {quic_handshake_server/client/param()}     |               |
+      +-------------------------------------------------+      +---------------------+
+        {send/recvmsg()}         {set/getsockopt()}            | tlshd (ktls-utils)  |
+        [CMSG handshake_info]    [SOCKOPT_CRYPTO_SECRET]       +---------------------+
+                                 [SOCKOPT_TRANSPORT_PARAM_EXT]
+              | ^                            | ^                        | ^
+  Userspace   | |                            | |                        | |
+  ------------|-|----------------------------|-|------------------------|-|--------------
+  Kernel      | |                            | |                        | |
+              v |                            v |                        v |
+      +--------------------------------------------------+         +-------------+
+      |  socket (IPPRTOTO_QUIC)  |       protocol        |<----+   | handshake   |
+      +--------------------------------------------------+     |   | netlink APIs|
+      | inqueue | outqueue | cong | path | connection_id |     |   +-------------+
+      +--------------------------------------------------+     |      |      |
+      |   packet   |   frame   |   crypto   |   pnmap    |     |   +-----+ +-----+
+      +--------------------------------------------------+     |   |     | |     |
+      |         input           |       output           |     |---| SMB | | NFS | ...
+      +--------------------------------------------------+     |   |     | |     |
+      |                   UDP tunnels                    |     |   +-----+ +--+--+
+      +--------------------------------------------------+     +--------------|
+
+- Post Handshake Architecture:
+
+      +------+  +------+
+      | APP1 |  | APP2 | ...
+      +------+  +------+
+        {send/recvmsg()}         {set/getsockopt()}
+        [CMSG stream_info]       [SOCKOPT_KEY_UPDATE]
+                                 [SOCKOPT_CONNECTION_MIGRATION]
+                                 [SOCKOPT_STREAM_OPEN/RESET/STOP_SENDING]
+                                 [...]
+              | ^                            | ^
+  Userspace   | |                            | |
+  ------------|-|----------------------------|-|----------------
+  Kernel      | |                            | |
+              v |                            v |
+      +--------------------------------------------------+
+      |  socket (IPPRTOTO_QUIC)  |       protocol        |<----+ {kernel_send/recvmsg()}
+      +--------------------------------------------------+     | {kernel_set/getsockopt()}
+      | inqueue | outqueue | cong | path | connection_id |     |
+      +--------------------------------------------------+     |
+      |   packet   |   frame   |   crypto   |   pnmap    |     |   +-----+ +-----+
+      +--------------------------------------------------+     |   |     | |     |
+      |         input           |       output           |     |---| SMB | | NFS | ...
+      +--------------------------------------------------+     |   |     | |     |
+      |                   UDP tunnels                    |     |   +-----+ +--+--+
+      +--------------------------------------------------+     +--------------|
+
+Usage
+=====
+
+This implementation supports a mapping of QUIC into sockets APIs. Similar
+to TCP and SCTP, a typical Server and Client use the following system call
+sequence to communicate:
+
+       Client                    Server
+    ------------------------------------------------------------------
+    sockfd = socket(IPPROTO_QUIC)      listenfd = socket(IPPROTO_QUIC)
+    bind(sockfd)                       bind(listenfd)
+                                       listen(listenfd)
+    connect(sockfd)
+    quic_client_handshake(sockfd)
+                                       sockfd = accecpt(listenfd)
+                                       quic_server_handshake(sockfd, cert)
+
+    sendmsg(sockfd)                    recvmsg(sockfd)
+    close(sockfd)                      close(sockfd)
+                                       close(listenfd)
+
+Please note that quic_client_handshake() and quic_server_handshake() functions
+are currently sourced from libquic in the github lxin/quic repository, and might
+be integrated into ktls-utils in the future. These functions are responsible for
+receiving and processing the raw TLS handshake messages until the completion of
+the handshake process.
+
+For utilization by kernel consumers, it is essential to have the tlshd service
+(from ktls-utils) installed and running in userspace. This service receives
+and manages kernel handshake requests for kernel sockets. In kernel, the APIs
+closely resemble those used in userspace:
+
+       Client                    Server
+    ------------------------------------------------------------------------
+    __sock_create(IPPROTO_QUIC, &sock)  __sock_create(IPPROTO_QUIC, &sock)
+    kernel_bind(sock)                   kernel_bind(sock)
+                                        kernel_listen(sock)
+    kernel_connect(sock)
+    tls_client_hello_x509(args:{sock})
+                                        kernel_accept(sock, &newsock)
+                                        tls_server_hello_x509(args:{newsock})
+
+    kernel_sendmsg(sock)                kernel_recvmsg(newsock)
+    sock_release(sock)                  sock_release(newsock)
+                                        sock_release(sock)
+
+Please be aware that tls_client_hello_x509() and tls_server_hello_x509() are
+APIs from net/handshake/. They are employed to dispatch the handshake request
+to the userspace tlshd service and subsequently block until the handshake
+process is completed.
+
+The QUIC module is currently labeled as "EXPERIMENTAL".
-- 
2.43.0


