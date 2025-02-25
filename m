Return-Path: <netdev+bounces-169273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2777FA432E2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDE0189AEDE
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 02:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F359D299;
	Tue, 25 Feb 2025 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNDtnb7l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D02030A;
	Tue, 25 Feb 2025 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449729; cv=none; b=nDlJSDRlWUiU6B/wMmHExwOayTbW3UNrvksUpM6dWkT8tJ1RyZPBQgBRQYe/zQEtPIpi9I6377KTlrZHjmeB5jQ70locmzjA8VI3jmDLxs2NvrN2dQQIWKyaMEAoWYUxAA1PuWnC2pD31B6tHZpQGWOnt8hbBOht8tj1zxxbAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449729; c=relaxed/simple;
	bh=iRbG47sCANDY3FCzmTRh11kWxd+TdU3fhkQZyTjVa3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hvrKZ4GwGvE9iycoFjnVclF41J8mBUhlYpdQxNDwzjNt6PDVXOaNPPqeAy9zSkOEPmr5x+4jJwFnsubQyih+ALSnUIrHsRxzh4qXfUgHRvYEJJc7EJL4R6K1kzgLzwrC9/4PrnW3p4mTbTDPuSMpjBuZizNx4ULlEmNSuitGJjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNDtnb7l; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso8713084a91.0;
        Mon, 24 Feb 2025 18:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740449727; x=1741054527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F2RCAC+gdt/KaJu/iQUcgfbAB6xrc5AkdAaC3TV+ngQ=;
        b=CNDtnb7lqIpDvkBjbSgueAcw/QxpcQker51o/jZEXfQNk1ycdVTiinoUu5iMDK8tgH
         qaWrIj1ASUYSPtILausMpSddxp4NxWSEt2omGXTQbLoSTWKiW4sij1sJg0gYGHwNaZnG
         uCEb4BWMvtlO4F5McKccknMyvEQCL4StpvqVL6Wyab7Z37tJSg5LaGTtRJFkbAypHyxd
         Abr+zJfeZzaUZLOONVYPowuFoW+1IK4RHSAU1Y/r8k/XqmcTaIMOUOxkZziHnDUEfHUI
         Xo34DThoaHGAKig80ME3H+nvEX8oT2pLkdpOb0f3BR3ssjeRF1xe5/gJFlEhPezYy0pF
         7iSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449727; x=1741054527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2RCAC+gdt/KaJu/iQUcgfbAB6xrc5AkdAaC3TV+ngQ=;
        b=BiTdkh8IbGrMQHtkh17b0W2cDbL6cfM//vTT1t+dfoMJcG1wU9eaHaNNfabF/l75RG
         BlWniCPicR6JEHs4yLqeeYgXRcaM9NZCflx339LBeH770jwEY1rTYA9drnCLPQ4thjHJ
         vVTOhpNRXaPzv+2ZQntPcI1cwjWMrGWZOsujXO+1dit5oc1Y69/9cWBwDC2PFoMerSdK
         D4NLekQIFRr1utzqCWOEj0wJKPS220r5ufdRHXGpuIRESOZuwo6SOU9DTuJrT3LblH4s
         5PsfNSWZgwwl4VO3a0GB9NgCJPIcePegow09yP16wBR3Hzaf4LTO3l8rt6G/Ok3Y2Pjt
         gftw==
X-Forwarded-Encrypted: i=1; AJvYcCVffGg8mZWPHkYEwK/5o0kYh2TX1vkef70Agt3d00tsl1AAkAqg9LPExpz/LwmhjiFybagtQ4ps@vger.kernel.org, AJvYcCX2kYs9SalYoOy4vo5kB/JkdtJbF8QPmxwTvDcRaIPqmLok2Y5ncumPK5aCHdkvnv+d+JidjCv4qE6vLW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuy27X/oHIH3aPxc1sgoRD6NYby9aRup2zXO8Z5QrWs+pGFDUT
	wW/ZEDyPgQAi+HoqVZZWYyqNkzsDzcY7q2Ajep01RRPPjltlTeo2
X-Gm-Gg: ASbGncszKLOFe0VbK8j/NtMdP672UmHEHkfjp7SqZNrFaFVaWpCk67o+D/+J1s5x9B5
	wJWnRuyEh4osRo5rrSYgGCaMGtNbAFz4fjsU4yae1MOTMeZ3QJm28OHzLD2Rv6G8aZpLRyzKT/2
	YuealnXmuuLCIj8XynfxK15gSWE0V1Gj1CIZVtooEv/objeV3MRPhx0sD7/63e2NGVVDAuJZO5u
	BQaKvjoH8OmmwQYC7B6pRLHs3o69zu4Bq8Ts88fvNl4Df1U0zq7dc7H/HPHBqX2UAlOXM0VkuTc
	xI5SHY1JJPrL+sNDI/s+uyRojPwmHwqnOdi9SoQT5SikHd1235WH0WQCAtgIpPN1hI45iTMAbke
	jUQHvYkHW
X-Google-Smtp-Source: AGHT+IEun3d0mqviGGXiD1pq62e8dvIHV3jZdQZVXB3L8zSulmRDjEGghXZS3iOG95u+DQXXM8ROXw==
X-Received: by 2002:a17:90b:2647:b0:2fa:2268:1af4 with SMTP id 98e67ed59e1d1-2fccc117cb6mr32839386a91.7.1740449726980;
        Mon, 24 Feb 2025 18:15:26 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-206-67.dynamic-ip.hinet.net. [220.143.206.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a39a691sm359880a91.4.2025.02.24.18.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:15:26 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH v2 1/1] af_unix: Fix memory leak in unix_dgram_sendmsg()
Date: Tue, 25 Feb 2025 10:14:57 +0800
Message-Id: <20250225021457.1824-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

After running the 'sendmsg02' program of Linux Test Project (LTP),
kmemleak reports the following memory leak:

  # cat /sys/kernel/debug/kmemleak
  unreferenced object 0xffff888243866800 (size 2048):
    comm "sendmsg02", pid 67, jiffies 4294903166
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 5e 00 00 00 00 00 00 00  ........^.......
      01 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
    backtrace (crc 7e96a3f2):
      kmemleak_alloc+0x56/0x90
      kmem_cache_alloc_noprof+0x209/0x450
      sk_prot_alloc.constprop.0+0x60/0x160
      sk_alloc+0x32/0xc0
      unix_create1+0x67/0x2b0
      unix_create+0x47/0xa0
      __sock_create+0x12e/0x200
      __sys_socket+0x6d/0x100
      __x64_sys_socket+0x1b/0x30
      x64_sys_call+0x7e1/0x2140
      do_syscall_64+0x54/0x110
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

Commit 689c398885cc ("af_unix: Defer sock_put() to clean up path in
unix_dgram_sendmsg().") defers sock_put() in the error handling path.
However, it fails to account for the condition 'msg->msg_namelen != 0',
resulting in a memory leak when the code jumps to the 'lookup' label.

Fix issue by calling sock_put() if 'msg->msg_namelen != 0' is met.

Fixes: 689c398885cc ("af_unix: Defer sock_put() to clean up path in unix_dgram_sendmsg().")
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
Changelog v2:
 - Per Kuniyuki's suggestion: Remove 'else' statement

---
 net/unix/af_unix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 34945de1fb1f..f0e613d97664 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2102,6 +2102,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out_sock_put;
 		}
 
+		sock_put(other);
 		goto lookup;
 	}
 
-- 
2.34.1


