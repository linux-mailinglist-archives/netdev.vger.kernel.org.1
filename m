Return-Path: <netdev+bounces-274527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGUzNhJnzmlRngYAu9opvQ
	(envelope-from <netdev+bounces-274527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:54:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F6238944D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B716302F0F6
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 12:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E573E2755;
	Thu,  2 Apr 2026 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbQ9cFSS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B23B9DAC
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134139; cv=none; b=G9QJbcX1F3fxT9eqv068SZ878gIfrM+0IRw2u0Pe0DbYq+QxZg6H5E5sv1fk9dtcik2IuK01uAMtpK3eCyFsGJZeMYaGVSrAyyKhgJuyNMCxmYoqz1XRFm+6J0v76mWrJs+o8a1Gza1msLOPeDmtrHyCFZi7mChOYr9lAny+MvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134139; c=relaxed/simple;
	bh=ik7uUTib9+LCz0UAAdU8wVthAJCsJQ9Tt8iu7WwCWkA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=fnv/6FHMH/FC3ajEWpDDPvsgzeXgu7/gnWnXDCiaxLOxw/wevkfFbNvi0NPMnPhkwcG7hm7qvlCozL9AwSYmEFmI9mUO9loPg+tSy3HQcq1NQjeQp17hjIRrd6wpM0hNOQFjwYe9rlKSPDXE4A8Zmk8NinFoByho3QqMVdYPrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbQ9cFSS; arc=none smtp.client-ip=209.85.222.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f66.google.com with SMTP id a1e0cc1a2514c-953ac1602f8so1347982241.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775134131; x=1775738931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f10hXx8Ya/o2nsVJSMU9jz32XKIcCmbLZ6lBcgyEWlM=;
        b=bbQ9cFSSls6GyfWBbnjfpg4bx3I6UDLFklF/yyHHImy2dNQIf0h4TfdnUgAvGz9Ul0
         CA2P02iji+o2VwsmYNg+8K6+/MBTCMDgptTGmGRRPtZ1keY9J47qcInI7AlAK2UnMXkc
         haqpgr2a3hQUN4uYDBRsrARPs+s8V6DOsJVFwQjljAbqTAnNrvr4XQ7OoSJUH8o6yYEg
         AxN2GLms2fofVgaW5yAzulG3pZrt0RPHHPsFqkKM89hE8P8739ct/F4rqqhDXevHdEQw
         XFfCtz48TXk+oq9YvKkKr7AkbTo4vvXll939cZeqD79hwlD+Zoikj6cHrVvyg+E1Jf0g
         Js5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775134131; x=1775738931;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f10hXx8Ya/o2nsVJSMU9jz32XKIcCmbLZ6lBcgyEWlM=;
        b=OLUsZl410iQ7ddBiyTokRwA9vggayHwoBqGSumUi744JzAPOmVrcrABr/I0/tHtZ6q
         Yc5LlCwhghhBSlaUxzlc3M96Kv9OAjI/M2KbNe4sQPihcBT86c5tGmT5coyizN0lsRh2
         KYvr9baLB8rGXMRYDI+Re+PCidWTbQzwGM68HQFrn7Uwcfk2oScANY6voJ6ygupAb12L
         lcNYsTkTD1uwSf1HpMgk4qlNewAOqTcwcdnbX+IWjKEICteEpoxHZTCcc5qgF8rYNu3C
         /1BlISYoKPU8a8RNiyUw7RWrkLjq6x2tDf3L4uS7h4UrPduTKKbEAoducVymWl4ZyhzB
         COnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9JVZpNy+Sl5LzVcEX1KDRpOhn5AFJIFfOYex3taBAoK4LVP6dsHwxAuaEQ91RfOf3STHZkg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzDJa3ZiB+h0pfatTn9srUF/zXshtSRT7rzNIQPBCWvEW18l4i
	2IL3ZsfURw8rdp7HNIgqbsdkqgqXNne3UZhLA9XC129iSqRTW09H28a+0x2gOmYGqG3UNkHW
X-Gm-Gg: ATEYQzwO0YPcDFIjDRIQ3s2TP7etpvVCkHpTK4qJkyfIGsi5D7SPE9/UL+ln+TXl+Ks
	gAYn+DYZ808apV81QVScXwJSOt1BV5q6jP0cXpkgxkC1yAXDviO4+Bvpvf7weAtuxTfRdPUvAfx
	TkrRxbE+PCJd+3+ov05j31eWmTeELi5cal4Yf7WI0kEuAwOq8HvZf4UwE+xQdIcMqek/I7Pz1bJ
	vuAehFdK8yrFjYxheLPNccfbi6Dx1Plx+CVc4Io8iWTEU3h7CePtGJf0dSOdn31z+ne4xwnUyEp
	7UXQW14FaeqH/09WJS5Z8VBR+eJ2JwhLB0D4LAXdd1IMLgw0Fq78t3PydN102FRq072IrF4N3/+
	9FDrMIx2zVj0ghe7J5Npa/LEevk020N7F/kBMZV2NGCMbYl2EP5YOBIYj2EFPcMtNAYkHbvt8nu
	7VsbO0ZKi9e7PHKdXgXSk=
X-Received: by 2002:a17:90b:1f85:b0:359:8957:7285 with SMTP id 98e67ed59e1d1-35dd67257bbmr1602746a91.3.1775128030888;
        Thu, 02 Apr 2026 04:07:10 -0700 (PDT)
Received: from localhost ([137.132.22.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35364edsm2447388a91.0.2026.04.02.04.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:07:10 -0700 (PDT)
Message-ID: <69ce4dde.170a0220.39732d.82c2@mx.google.com>
From: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
        Tom Talpey <tom@talpey.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Steve French <smfrench@gmail.com>,
        Neal Cardwell <ncardwell@google.com>,
        Simon Horman <horms@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        David Ahern <dsahern@kernel.org>
Cc: linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [BUG] Linux Kernel ksmbd Multiple Memory Leaks in Session Handling
Date: Thu, 02 Apr 2026 19:07:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: KernelStackFuzz send_email.sh
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,talpey.com,chromium.org,google.com,davemloft.net,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-274527-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ven0mkernelfuzzer@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.836];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mx.google.com:mid]
X-Rspamd-Queue-Id: 39F6238944D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Linux Kernel ksmbd Multiple Memory Leaks in Session Handling

  1. Vulnerability Title

Linux Kernel ksmbd Server Multiple Kernel Memory Leak Vulnerability in Session Setup/Teardown

  2. High-Level Overview

Seven distinct kernel memory leaks exist in the ksmbd (in-kernel SMB server) session handling paths. During SMB session setup and teardown, multiple kernel objects — including socket inodes (1344 bytes), LSM security blobs (120 and 32 bytes), TCP connection structures (3264 bytes), ksmbd connection contexts (64 and 16 bytes), and network skb buffers (240 bytes) — are allocated but never freed. These leaks accumulate over time with repeated session establishment, allowing a remote attacker to exhaust kernel memory by repeatedly connecting and disconnecting SMB sessions. This constitutes a denial-of-service vulnerability.

This vulnerability was discovered using ven0mfuzzer, our custom-designed MITM-based network filesystem fuzzer developed by our team. Following the common syzkaller practice, we submit the kernel crash trace as the primary reproduction artifact.

  3. Affected Product and Version Information

Product: Linux Kernel (upstream mainline)
Affected Component: `fs/smb/server/` — ksmbd session setup/teardown, connection handling
Supporting Components:
- `fs/smb/server/transport_tcp.c` — `ksmbd_kthread_fn()`, `ksmbd_tcp_readv()`
- `fs/smb/server/connection.c` — connection context allocation
- `net/socket.c` — `sock_alloc_inode()`, `kernel_accept()`
- `net/ipv4/tcp_minisocks.c` — `tcp_create_openreq_child()`

  Tested Versions (confirmed vulnerable)
- Linux kernel 6.19.0 (mainline, commit `44331bd6a610`, gcc 11.4.0, built 2026-02-13)
- Linux kernel 6.12.74 (LTS, used in Google kernelCTF COS target)

  Affected Version Range
All kernels with ksmbd support (approximately 5.15 through 6.19) are believed affected.

  Affected Distributions and Products

 |  Vendor / Product  |  Notes  | 
 | --- | --- | 
 |  Red Hat Enterprise Linux (RHEL 9.x)  |  Ships kernels >= 5.14 with ksmbd module  | 
 |  Ubuntu (22.04 LTS, 24.04 LTS)  |  HWE kernels 6.x include ksmbd  | 
 |  SUSE Linux Enterprise Server (SLES 15 SP5+)  |  Kernel 6.x based  | 
 |  Debian (Bookworm, Trixie)  |  Kernels 6.1+  | 
 |  Fedora (39+)  |  Kernels 6.5+  | 
 |  Amazon Linux 2023  |  Kernel 6.1 LTS based  | 
 |  Google ChromeOS / COS  |  kernelCTF target, confirmed vulnerable on 6.12.74  | 

  4. Root Cause Analysis

  4.a. Detailed Description

The kmemleak detector identified 7 unreferenced kernel objects allocated during ksmbd session handling that are never freed. These leaks occur across multiple subsystems involved in SMB connection management:

1. Socket inode (1344 bytes): Allocated by `sock_alloc_inode()` during `kernel_accept()` in `ksmbd_kthread_fn()`. The accepted socket's inode is not properly released when the connection is torn down.

2. LSM security blob (120 bytes): Allocated by `security_inode_alloc()` during inode initialization for the socket. Leaked because the parent inode is leaked.

3. TCP connection structure (3264 bytes): Allocated by `sk_prot_alloc()` during `tcp_create_openreq_child()` when accepting a new TCP connection. The TCP socket is not properly closed on session teardown.

4. LSM security blob for socket (32 bytes): Allocated by `security_sk_alloc()` for the cloned TCP socket. Leaked with the parent TCP structure.

5. ksmbd connection context (64 bytes): Allocated by `ksmbd_kthread_fn()` for per-connection state. Not freed when the connection handler exits abnormally.

6. ksmbd TCP read buffer (16 bytes): Allocated by `ksmbd_tcp_readv()` for receiving SMB messages. Not freed when read is interrupted.

7. SKB buffer (240 bytes): Allocated by `build_skb()` in the virtio-net receive path for incoming SMB packets. Orphaned when the associated socket is leaked.

  4.b. Code Flow

---
ksmbd_kthread_fn()                    [fs/smb/server/transport_tcp.c]
  → kernel_accept()                   ← allocates socket inode (1344B) + security blob (120B)
    → sock_alloc() → alloc_inode()
    → security_inode_alloc()

TCP SYN_RECV → ESTABLISHED:
  → tcp_create_openreq_child()        ← allocates TCP sock (3264B) + security blob (32B)
    → sk_prot_alloc() → sk_clone()
    → security_sk_alloc()

ksmbd_kthread_fn() continued:
  → kmalloc (64B)                     ← ksmbd connection context

ksmbd_conn_handler_loop():
  → ksmbd_tcp_readv()
    → kmalloc (16B)                   ← TCP read buffer

[on session teardown — objects NOT freed due to missing cleanup]
---

  4.c. Crash Trace

This vulnerability was discovered by ven0mfuzzer. The following kmemleak output is submitted following syzkaller's common practice of providing the raw kernel trace as the primary reproduction evidence:

---
unreferenced object 0xffff88810af3d180 (size 1344):
  comm "ksmbd-eth0", pid 328, jiffies 4294901355
  backtrace (crc 1a26ccb4):
    kmem_cache_alloc_lru_noprof+0x3ed/0x5f0
    sock_alloc_inode+0x25/0x1c0
    alloc_inode+0x64/0x240
    sock_alloc+0x40/0x280
    sock_create_lite+0x82/0x120
    kernel_accept+0x16b/0x380
    ksmbd_kthread_fn+0xee/0xf30

unreferenced object 0xffff888107243bd0 (size 120):
  comm "ksmbd-eth0", pid 328, jiffies 4294901355
  backtrace (crc 6bd3e180):
    kmem_cache_alloc_noprof+0x3ed/0x5f0
    security_inode_alloc+0x3b/0x140
    inode_init_always_gfp+0xbf9/0xf20
    alloc_inode+0x86/0x240
    sock_alloc+0x40/0x280
    sock_create_lite+0x82/0x120
    kernel_accept+0x16b/0x380
    ksmbd_kthread_fn+0xee/0xf30

unreferenced object 0xffff88810fbfa980 (size 3264):
  comm "softirq", pid 0, jiffies 4294902189
  backtrace (crc c2de1a0c):
    kmem_cache_alloc_noprof+0x3ed/0x5f0
    sk_prot_alloc+0x60/0x2a0
    sk_clone+0x79/0x14f0
    inet_csk_clone_lock+0x2f/0x760
    tcp_create_openreq_child+0x34/0x26a0
    tcp_v4_syn_recv_sock+0x115/0x10e0

unreferenced object 0xffff888108c514a0 (size 32):
  comm "softirq", pid 0, jiffies 4294902189
  backtrace (crc ea16adaf):
    __kmalloc_noprof+0x4eb/0x760
    lsm_blob_alloc+0x68/0x90
    security_sk_alloc+0x2f/0xd0
    sk_prot_alloc+0xfb/0x2a0
    sk_clone+0x79/0x14f0

unreferenced object 0xffff88810fd0b540 (size 64):
  comm "ksmbd-eth0", pid 328, jiffies 4294902189
  backtrace (crc f2da5eae):
    __kmalloc_cache_noprof+0x411/0x610
    ksmbd_kthread_fn+0x288/0xf30

unreferenced object 0xffff8881063426f0 (size 16):
  comm "ksmbd:::ffff:10", pid 434, jiffies 4294902190
  backtrace (crc 9e6ee6c8):
    __kmalloc_cache_noprof+0x411/0x610
    ksmbd_tcp_readv.constprop.0+0x16d/0x700
    ksmbd_tcp_read+0x88/0xc0
    ksmbd_conn_handler_loop+0x5dd/0xfd0

unreferenced object 0xffff88810fa94200 (size 240):
  comm "softirq", pid 0, jiffies 4294902419
  backtrace (crc 4367e44b):
    kmem_cache_alloc_noprof+0x3ed/0x5f0
    build_skb+0x46/0x370
    page_to_skb+0x5df/0xb30
    receive_buf+0xa3e/0x4940
    virtnet_poll+0xfb6/0x1750
---

Total leaked per session: approximately 5,080 bytes (1344 + 120 + 3264 + 32 + 64 + 16 + 240). An attacker establishing and tearing down sessions repeatedly can exhaust kernel memory.

  4.d. Suggested Fix

The ksmbd session teardown path (`ksmbd_sessions_deregister` / `ksmbd_conn_handler_loop` exit) must properly release all allocated resources:
1. Close the accepted socket via `sock_release()` to free the socket inode and associated LSM blobs
2. Properly tear down the cloned TCP socket
3. Free the ksmbd connection context and read buffers on all exit paths, including error/abort paths

  5. Discovery Method and Reproduction

  5.a. Discovery

This vulnerability was discovered using ven0mfuzzer, a custom-designed MITM-based network filesystem fuzzer developed by our team. The fuzzer operates by positioning an AF_PACKET/TCP transparent proxy between a Linux kernel filesystem client (VM-A) and its server (VM-B), then mutating network protocol messages in-flight.

Following the common syzkaller practice, we submit the kernel kmemleak output as the primary reproduction artifact. The output above was captured with CONFIG_DEBUG_KMEMLEAK enabled on kernel 6.19.0.

  5.b. Reproduction Setup

---
VM-A (CIFS client) ──SMB2──► Host:44446 (MITM proxy) ──TCP──► Host:44445 ──hostfwd──► VM-B:445 (ksmbd)
---

Trigger condition: Repeated SMB session establishment and teardown, especially when the MITM proxy disrupts the session setup handshake, forcing abnormal teardown paths.

---
Reported-by: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
Link: https://github.com/KernelStackFuzz/KernelStackFuzz

