Return-Path: <netdev+bounces-279975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CEqDYfm5mkl1wEAu9opvQ
	(envelope-from <netdev+bounces-279975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 04:52:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DAF4359E6
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 04:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B95E1302BDFB
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C326A08F;
	Tue, 21 Apr 2026 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLT3/GbE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296DD27FD43
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739894; cv=none; b=ZO8p3pbt6INyxgJINGwpwFHahGM+JUXMX4RS7GkGgu8doHQW3F0/+e9hH2tenRwgT1UhKCufnK9ojEKL9n518FkvoWgS+8JHU7M00cG+cp5n9Pc/ejvmH7b4fyHXK7tNT8wgkAXfYk3weUTuoCGW15RlcbwW7Gn8m2YhhPzE9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739894; c=relaxed/simple;
	bh=2GmeUgsVld79fKl1iNI45/UB/0MUWB93JcGKPSGrmas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uY4MGVdAxJMFvOwS5HLpi51+2YqcoRXxOcevBorKPBsO0L9wG6/dZq2s9oU8o/bJtTwIFGnWUQyXTDdqQhsg5BP/zdpcSOipWcPQDICph8AHtxXNcHqanSUiuAjhWLi48aeHCOZFm7uE04YEMJRXOZA4yr85W3H3xgl/HbB5DhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLT3/GbE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82418b0178cso2287616b3a.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776739893; x=1777344693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ95cJBTtwe/Q3ftFYdsD7Mm/4M8Wg0mB6kbaOeJjWI=;
        b=LLT3/GbEJBKqvtCxDzMplMKaq9W7twRUM5LB2NSL7xv//iAAJyEYHyKv4yDcDKymZY
         LZus+qvZU0Cfbb2K4AYvsdABZd4v8yqv6896Gsw1M73YnVZs2UKcnp1bWeJMaa6F02DA
         jm/RKyXmBqQTEFnBIkDMZ6GMoF0Sx6w5nX2hR1N1Ry56m+lDOSUxiqGn/i443X3h4M/g
         snpdoZwhOTXJ8zDB46OfftmEh0boIylpDlKddNIyJBI2f/RrY0zJbiriRE6ZvcJUSNY3
         KXj5r9D63om2P66wfRaawNdjJE5NUxAFhV82C3/CVG3uvTzh8DI0iSrS14zZvooF30+n
         TW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776739893; x=1777344693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJ95cJBTtwe/Q3ftFYdsD7Mm/4M8Wg0mB6kbaOeJjWI=;
        b=qnpKW9txOlkPcfptdbnscgycRH4wcpVR+1N9G7vTOzXvfJdhmHZigXPS6hHHUDVteB
         zP/uxyUCL/xoWFuwnvOEnHbWjf7Prpyp5ES/UbV6V0C+Hozze3wDb6Y8DE5vio6ttalr
         XgYSW34nxPTQnrx1Svhc42X2pqvHsmS9AwH7G3Xou+IMoQsKykhF614bcgYMx3U1Eiiv
         XQ2lgInRkmbcs7R6PrEDUQkPqsPbqjHq6Xh3ymI6qstzR1U8xXIhUc7sz6kUjw48RsC+
         9xcpQc7iHkAWjU/+72PE7ALqQXztiCKKy/CNfKIDEyBjGXU+FL1fTBMoIhvQalhb0yCL
         oDMw==
X-Forwarded-Encrypted: i=1; AFNElJ8WM46RDfsXvKc6OqvDabh5rHTiCFIlmN2oDMjNCNvUHlp0gtpO95bYc9Ch9cHtnxa5d4Nw2uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlFPgFHrUWWbb3H0y5dvEe+4rUC44uUzN3LdvtMn197EFEFAM
	ycgMI/lv/VcdMfFUhS4jvQatLsh7j8HkKAZXQyx9W2KxqcCON3+2Sls8
X-Gm-Gg: AeBDiesQ6vM/0vS3HxSy2LGGaM6w0TQL24OmvIoA9wjDiioxzg0X0A+9KIbRyHnnSfK
	E43f+FB6zlK26By4wUCUDzZRJuZiWJIsFY90uSVXzhTQTxGKwOOIgf1EhHKbEEK4Krv/IN8sIVp
	z6d085pz1trkiNFn+fDmY4qbWPrOVwnTVWwl5s5ioMJ7lCLLeMWqoB7oRJlzMgHDZKUq/U58u7E
	9ti4yihIXB++Xpg/fXN9Kby64iHAQumU7j0iQjPWbywIU3/wZgasQLPm3YoZ+F1S5G1qWMXhsUr
	bfj+P1lgUTqYOzp7oE4FzRX6tcQON5DSXMMlMEWmeGVb+A6R33kjTi3dk5KyOY4NhksL3c2yP3N
	uGwuzh8F1Q5+rbxvjyKdtXFeTRCK9RxvueRPm5L6eeN6PSL/okgZi2X+S9rZmbdE5zj+9hwZzMW
	uuGSpwmSDxGKcimmQrkpNJxOegE4BAqi6R8Vl4NwVdMMreL+eC6ZBX7DZoCg==
X-Received: by 2002:a05:6a00:aa08:b0:82c:66f2:1226 with SMTP id d2e1a72fcca58-82f8c8e4febmr15916913b3a.38.1776739892565;
        Mon, 20 Apr 2026 19:51:32 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm12823502b3a.20.2026.04.20.19.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:51:32 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v2 1/2] Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
Date: Tue, 21 Apr 2026 11:51:21 +0900
Message-ID: <20260421025122.55781-2-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421025122.55781-1-suunj1331@gmail.com>
References: <20260421025122.55781-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,holtmann.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,brighamcampbell.com,linuxfoundation.org,lists.linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279975-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[suunj1331@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90DAF4359E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iso_sock_connect() copies the destination address into
iso_pi(sk)->dst under lock_sock, then releases the lock and reads
it back with bacmp() to decide between the CIS and BIS connect
paths:

    lock_sock(sk);
    bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
    iso_pi(sk)->dst_type = sa->iso_bdaddr_type;
    release_sock(sk);

    if (bacmp(&iso_pi(sk)->dst, BDADDR_ANY))  // <- no lock held

This read after release_sock() races with any concurrent write to
iso_pi(sk)->dst on the same socket.

Fix by reading the destination address directly from the local
sockaddr argument (sa->iso_bdaddr) instead of iso_pi(sk)->dst.
Since sa is a function-local argument, reading it requires no
locking and avoids the race.

This patch addresses only the bacmp() race in iso_sock_connect();
other unprotected iso_pi(sk) accesses are fixed separately in the
next patch.

KCSAN report:

BUG: KCSAN: data-race in memcmp+0x39/0xb0

race at unknown origin, with read to 0xffff8f96ea66dde3 of 1 bytes by task 549 on cpu 1:
 memcmp+0x39/0xb0
 iso_sock_connect+0x275/0xb40
 __sys_connect_file+0xbd/0xe0
 __sys_connect+0xe0/0x110
 __x64_sys_connect+0x40/0x50
 x64_sys_call+0xcad/0x1c60
 do_syscall_64+0x133/0x590
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00 -> 0xee

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 549 Comm: iso_race_combin Not tainted 7.0.0-08391-g1d51b370a0f8 #40 PREEMPT(lazy)

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e2736b7..290a1b9a9daa 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1193,7 +1193,7 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 
 	release_sock(sk);
 
-	if (bacmp(&iso_pi(sk)->dst, BDADDR_ANY))
+	if (bacmp(&sa->iso_bdaddr, BDADDR_ANY))
 		err = iso_connect_cis(sk);
 	else
 		err = iso_connect_bis(sk);
-- 
2.52.0


