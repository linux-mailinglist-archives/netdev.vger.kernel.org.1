Return-Path: <netdev+bounces-57229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DC98126C8
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 06:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70601C211B6
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 05:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC97C610B;
	Thu, 14 Dec 2023 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOf0Wlw6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00781D0
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 21:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702530570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xO88RRkOEho8UJ2yjNCpaLd/VuL7Hge2PfB6GXsL1SM=;
	b=iOf0Wlw6GjtSZqBVGPJF8CgBzIwvNxDfYi12g5/4hD5j/6/yHjhrHWM2ULuXOKCxcJQNQC
	s4/amR/iBLp+gcrQZiJzzgkLJgsZizaguZx0qgkQCVgxAZYQoQVE71b5cp93+mGwgftXJE
	qXbR+zaeRnsNo3xDEJQZcD1rSfBdsjk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-_O833TrAPga4AvVu-2wkIw-1; Thu, 14 Dec 2023 00:09:29 -0500
X-MC-Unique: _O833TrAPga4AvVu-2wkIw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d35dc29b73so9058615ad.3
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 21:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702530568; x=1703135368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xO88RRkOEho8UJ2yjNCpaLd/VuL7Hge2PfB6GXsL1SM=;
        b=Jal6/qSQoaUFhsM5+Bh1mkEa0sveaBKoM2glEISO+6LUk8vWMTBzNUFhXdFycp5Pmx
         00yguWd9xKXOWTXrquYHE3lC3lGm9Qk892AdUEOHKjQYu2vXSSqyb77OaYZiYO2LAK5K
         fhGAXLr4axqgVk19PS2d5cMbvLoHq6xdL57QQCEiw8lwZwJUXBtBZRWPeQK6P6UbCMNP
         nKGR23T5ttjrB0xN3rv00HrjSF3Mj35H0JgSsPzgZg64yR1u5MRA2NS/7aSQ5Fo8gscw
         smeumSyEVMM/3qgIS8/FpMg0V46t/6emd1tq0MPToNrJtK90F/RvppkxBakZfUr+/+r+
         J68w==
X-Gm-Message-State: AOJu0Yy8ltQURMVcWmZLb7wQ0xAbVFo7jBvArB3lvM6egb9A9/UInzVb
	v6lQEsyNn7lAvANpNkij2sBzErVVtSRZ24t/aQfGrLyRVkcr9LchF16WcwE2EkfxOxYBtF1hD8G
	U9E76vZt7gFrTlFrg
X-Received: by 2002:a17:902:dacf:b0:1d3:5084:e9f3 with SMTP id q15-20020a170902dacf00b001d35084e9f3mr1318161plx.57.1702530568279;
        Wed, 13 Dec 2023 21:09:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMxc/J25XfrysCEgFd0ZBPUbjJL5FfnrcIXQwa/DjXelYmb771MD7ewSwlMUHHTX0ORVI0ag==
X-Received: by 2002:a17:902:dacf:b0:1d3:5084:e9f3 with SMTP id q15-20020a170902dacf00b001d35084e9f3mr1318152plx.57.1702530567949;
        Wed, 13 Dec 2023 21:09:27 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id r7-20020a170902be0700b001d0c641d220sm11485771pls.257.2023.12.13.21.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 21:09:27 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] net: Return error from sk_stream_wait_connect() if sk_wait_event() fails
Date: Thu, 14 Dec 2023 14:09:22 +0900
Message-ID: <20231214050922.3480023-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following NULL pointer dereference issue occurred:

BUG: kernel NULL pointer dereference, address: 0000000000000000
<...>
RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
RIP: 0010:dccp_write_xmit+0x49/0x140 net/dccp/output.c:356
<...>
Call Trace:
 <TASK>
 dccp_sendmsg+0x642/0x7e0 net/dccp/proto.c:801
 inet_sendmsg+0x63/0x90 net/ipv4/af_inet.c:846
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x83/0xe0 net/socket.c:745
 ____sys_sendmsg+0x443/0x510 net/socket.c:2558
 ___sys_sendmsg+0xe5/0x150 net/socket.c:2612
 __sys_sendmsg+0xa6/0x120 net/socket.c:2641
 __do_sys_sendmsg net/socket.c:2650 [inline]
 __se_sys_sendmsg net/socket.c:2648 [inline]
 __x64_sys_sendmsg+0x45/0x50 net/socket.c:2648
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x43/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

sk_wait_event() returns an error (-EPIPE) if disconnect() is called on the
socket waiting for the event. However, sk_stream_wait_connect() returns
success, i.e. zero, even if sk_wait_event() returns -EPIPE, so a function
that waits for a connection with sk_stream_wait_connect() may misbehave.

In the case of the above DCCP issue, dccp_sendmsg() is waiting for the
connection. If disconnect() is called in concurrently, the above issue
occurs.

This patch fixes the issue by returning error from sk_stream_wait_connect()
if sk_wait_event() fails.

Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/core/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index 96fbcb9bbb30..b16dfa568a2d 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -79,7 +79,7 @@ int sk_stream_wait_connect(struct sock *sk, long *timeo_p)
 		remove_wait_queue(sk_sleep(sk), &wait);
 		sk->sk_write_pending--;
 	} while (!done);
-	return 0;
+	return done < 0 ? done : 0;
 }
 EXPORT_SYMBOL(sk_stream_wait_connect);
 
-- 
2.41.0


