Return-Path: <netdev+bounces-264896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOh8E/whq2mPaAEAu9opvQ
	(envelope-from <netdev+bounces-264896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 19:50:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D04AC226DB0
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 19:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E801309AA65
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFF536F429;
	Fri,  6 Mar 2026 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQQJ5Vrt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F2145355
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823026; cv=none; b=khmI98Fwv4+TGPc97t4c9ufwedr2bHAt8McbJKlLSgmERr94AfhkJg5RqSIkV9Z19e9rt7iGhYJKLiKjVwLAM87NRo0M7wGeNj5ggBh4nqXnseEbElDBx9rF/k9zZb0UII6oP4Dtan3RkAlJykMEmCrKPykc2vXYPSgzWYjBG88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823026; c=relaxed/simple;
	bh=cmiwxDteA0bVU5ry0h+O5seSL9/dd7E9bW/vaIpx2a4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Np5QpYeSnhwJQ+CCtRYfpxL9DPZobiEgmslLg/mNRj5zWKMWnBwXf6Of1sr8OLq6XJxV0v3mDepKazKW0bFN/j9lCOM5DZuTLihyWUC6GLbIfmjqD1qgP/5ifQyW1YhOLZcHuK+lf/apcakSlJspRIpFY/Vrb4auS4Hr7H4LnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQQJ5Vrt; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7986d231b3cso124919697b3.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 10:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772823024; x=1773427824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0lI3EKSn/5Qi2aFTkakiZu1L3daiZqHsOPjru5Xcie0=;
        b=RQQJ5VrtRGw2BNuGkE4EdhOjmPf5opwMzWC5fjtKB2kLLoKhqowIXHNR3Bx6LSo8xb
         mBntdf7f4GTTqEOQioQRDjDTdT6yl4gRHAmB0wCfGug+DVoQvZMzQuKCaNb/tja5j8cR
         M/54XNA34W8MV8c6Fhq8PEG5Qv5rqC1R7VjpHCVuC/S6/I9tTcrgBzji039WgJck/XYn
         f6kIoDJXohG8XQQRDHdcZrlaFsHNVnEk2IPS6vGrgVPCHLnvJ98MXhhItgUSszk6MBYQ
         zKG4eQCv/g+yGtKUV4pdMSIDSvcnm2MZU6L7FN7NoBTJ6xuD3SXL1oIDMot0dNO5jWcw
         4gZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772823024; x=1773427824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lI3EKSn/5Qi2aFTkakiZu1L3daiZqHsOPjru5Xcie0=;
        b=vnwht/XGJJwH0aELDqwP791l4PjWpbnKTEok9I7KIx8axdDXIP/8bbOWWEVXGz3Lw2
         w4sXB4LtjzJcWEG/Eth8lor/XVATvHdNoLHXu/QqNYjwnE+/ydMChI2zO5poO7z3UnUS
         uCjAWY31Q7UHOzdGAjCxcTp8aIDx2GfhydOoV1f2ueTpfvk4vgJXUEtoK4Jh84zXLvnG
         vvm+KBQYYLBiwo/2Py+QSouDESMwRk6BegEp/PwIZCzN8nJlvGMN8S4Vg4toa/86NZgq
         Fu1SIt7QZQ7aJyuoyvt5Ad+Pbn9Lb5JTF/9JDImVLOCssnivHbg2mOvo9eVyg6Z9fGNW
         oXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqRckh2YIHDgyfrHcHI9ABGuN2KoSe5rHIXJfVEmL7enxp4nAql/qx4UeyUBkM20z9gQ7Dr3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0DcZd2bNtFr2Pd7yDvSwnJZsomof4GeGfEqdNPMKICeCX8+L
	Nc6bdriUl4hcuLPwzmcfEHzgL3TKFX+M3bp6p1hdsVNS7s83wPaTqzQb
X-Gm-Gg: ATEYQzwGmxVpJ9pqisi3C0qI8kZ/2rSS73IxWT2acwKje26Ktrra43WKZ6OVg+lyLpQ
	a8+zXVhkNypRzexLF88oaYIbjuhNk8pjbbGP3mK5L6d6ShU3LqmfexlYzA9oYIb/06wfI3RkGZ+
	FMqLJq4RlcG2pN7LuqQAsnoavq57cLsoBPg2VJQHzDgG6xuQEMkRIBB5YBTfPGg5fBCf+qr5TV5
	GEabTucbtfY05ahelVU8KtUN2w1eFLm9+X7VWYiptK0qDGNt0KHW3Pb0bwhImiUyrtorfV7rfZS
	+0+GmJ1Hd/1xfJDVhiyHmI2RLEUErMZMPWqBNtl9m/z/V6XqVrtoWQ4WQvVj5ml2IN7ziUk7HNl
	JYrn7Lf17Y5foG60W9l2y1dhL/1IXKJ5z0j8uSfRG96V/2+oDElzxTO+VX5n6KA/USff+3mynMV
	LvizmmZvBiaMjMKRz3DBMsTTB/Adea4TYznRJgznbIggYr0oD+FelNGIYJ
X-Received: by 2002:a05:690e:e85:b0:64c:98df:c5d4 with SMTP id 956f58d0204a3-64d071875e2mr6076685d50.46.1772823024193;
        Fri, 06 Mar 2026 10:50:24 -0800 (PST)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dec8b8b1sm9978057b3.10.2026.03.06.10.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 10:50:23 -0800 (PST)
From: Mehul Rao <mehulrao@gmail.com>
To: jmaloy@redhat.com,
	davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ying.xue@windriver.com,
	tung.q.nguyen@dektech.com.au,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	stable@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH net v2] tipc: fix divide-by-zero in tipc_sk_filter_connect()
Date: Fri,  6 Mar 2026 13:50:05 -0500
Message-ID: <20260306185005.22120-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D04AC226DB0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,windriver.com,dektech.com.au,vger.kernel.org,lists.sourceforge.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-264896-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mehulrao@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.985];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

A user can set conn_timeout to any value via
setsockopt(TIPC_CONN_TIMEOUT), including values less than 4.  When a
SYN is rejected with TIPC_ERR_OVERLOAD and the retry path in
tipc_sk_filter_connect() executes:

    delay %= (tsk->conn_timeout / 4);

If conn_timeout is in the range [0, 3], the integer division yields 0,
and the modulo operation triggers a divide-by-zero exception, causing a
kernel oops/panic.

Fix this by clamping conn_timeout to a minimum of 4 at the point of use
in tipc_sk_filter_connect().

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 119 Comm: poc-F144 Not tainted 7.0.0-rc2+
RIP: 0010:tipc_sk_filter_rcv+0x1b99/0x3040
Call Trace:
 tipc_sk_backlog_rcv+0xe4/0x1d0
 __release_sock+0x1ef/0x2a0
 release_sock+0x55/0x190
 tipc_connect+0x140/0x510
 __sys_connect+0x1bb/0x2e0

Fixes: 6787927475e5 ("tipc: buffer overflow handling in listener socket")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
---
Changes in v2:
- Clamp conn_timeout at the point of use in tipc_sk_filter_connect()
  instead of rejecting small values in tipc_setsockopt()
- Link to v1: https://lore.kernel.org/netdev/20260305215336.645186-1-mehulrao@gmail.com/
---
 net/tipc/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 4c618c2b871d..9329919fb07f 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2233,6 +2233,8 @@ static bool tipc_sk_filter_connect(struct tipc_sock *tsk, struct sk_buff *skb,
 		if (skb_queue_empty(&sk->sk_write_queue))
 			break;
 		get_random_bytes(&delay, 2);
+		if (tsk->conn_timeout < 4)
+			tsk->conn_timeout = 4;
 		delay %= (tsk->conn_timeout / 4);
 		delay = msecs_to_jiffies(delay + 100);
 		sk_reset_timer(sk, &sk->sk_timer, jiffies + delay);
-- 
2.53.0


