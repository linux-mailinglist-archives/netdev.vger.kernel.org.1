Return-Path: <netdev+bounces-227195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4037DBA9EDD
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239441922972
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737ED30CB3E;
	Mon, 29 Sep 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIEdNKCJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B046930C624
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161795; cv=none; b=NgpyCisI2UEFZzU4Ty4L7Tokbc/gX+fKeGQI/7+3zqQkLVAWeaGFVy+tuPj0b7dFM1KvEeCP47qmgTVriIJxhRvvznaHF32F8sS+WFmTly332WW9diNcFdevDW/rHFbMnXBqxgE3mHS0wMIHhewg3i6uuoCTZWxklShwNzhZJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161795; c=relaxed/simple;
	bh=1jkw+7EvuIa/Han8qcxFLmMTXaJYMq7ZJC5YxwM3xL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvjU8ZKBCmj5wJG7uxMKy+aCgeABsh8WfmAAlNX9jp8Dl3Xc61g+nMn//BETugg+JUElFbsDb1OnYJCtys6KdTZF2AhMgW9Hx5RDmztOFAY2HAHMcNBrfoIhEkKf4Chw8To/+Dtxz8YIwR+3tFi6wLcyZDZcRjCZaf2rYwDjD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIEdNKCJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77f1f29a551so6401348b3a.3
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759161793; x=1759766593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KefHEpASHlImKTlDtTejqsu/vtIp51mWF2HZGf1Fkyo=;
        b=WIEdNKCJukuVi1h9DOdGQ8/Muw/4sk1r+sFqcwhZkzSs/T7nS0Z5rIDRn0aJ6QR4nD
         L/ujvWnbM0exKAO889chaTUy8tlRN6IsN3nWEnANfXUV0O+wt6pJH7+L7wjJKiVQxVEV
         etiSJTLGdU3bIKYBrO5CitRoAZ+zhm9sET7i9OoMMxIkzQ31xC+s3zWMH3SZgFr6yhnn
         RkNGWUtxM1lrAPY8Rc4pCk6z/GF8x4C2rrkOyin9DU+vHh+X0hNrVbpVkV2oNWC4WeYS
         7cxdtiNjT0m1NveXp8MgDzScEXYM3IQEuAjTCdAtwFxaQmZlEWn8XD+AV4r+J20HiGYg
         NOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161793; x=1759766593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KefHEpASHlImKTlDtTejqsu/vtIp51mWF2HZGf1Fkyo=;
        b=Go+S/K3gMQ2vr+u7t6V70ugCzo8QLdprpt+2oMSWSAOpS0W0BWOvngJ4ptPsoriApx
         pqcyTYxb87Wawoc3fcLXSrf4NsRHx7VcKQOBB90cOBDLRHeI4FoShux4Gm5JGD48ilQ5
         9ar8c6n1DSpw7LPRhpHETywWPK82ZIC6p/TuNK2vl3RrY2KI9CmOA7qnn+Rn5EFER8EI
         z1ycBDBHTFIsrbUarPD6YWmxANNxU9OGcAP9mHIvxSE913OhxQ997MOJLzPllHPlqd2I
         EA3zjWWd3OH9nLJdPges247k3rmJR3yIVJuARda8l1TkXFy1Vxvpf+ovIilfN09rUHt0
         +KXw==
X-Gm-Message-State: AOJu0YwP41jRRXNMQJQkOsl2iFZWusHsr4RJhvHo09pRj0buZ5D95hnE
	pB3gEaw0Hqh0Vccw9zJ1u5o2oXwCCvtOf+GSXmmYyi0BdE6KEK96OLj7
X-Gm-Gg: ASbGncuwcLp3JBdofBoVSDI81dCv4FbMuPiq0B+LxGJOBX0QtEQ9yQfhEtYomT3UzUA
	b4N/RfDns9+BMoNLj++m7J9WjMtSo+4SWkWeAEWl0HeSAF1AuHebawN3tBJJmBrzWKZ1ujcb034
	bjCjDYR436jF2UrR+HSA/YT4coWd3kTZguVh26F9FZIKs5P3bT3EYOlPR3X7PcDPoLe4POafoZv
	g5yimGLkvY98Qlc9sIhYimnxyRiHSQ6gmT8dVE97KIhCHamjToopnzbX4mdiLJmiQKNzH6KQhZa
	ef7wXjEVjQjIviZOrL/IThA/JtPNGiMo+1gKwWA0sP+C29FJ5XcaEmVPACYL9YJz9bkIExz+Ki1
	D+sVkQMODJsUaTPZUKYoY/0Q3XZNM
X-Google-Smtp-Source: AGHT+IFLs3m9GZxE68Q18gbvy+0afYHaST+CDXcgc2TlSHRuYVzEECyokcNZHk3sUQVFmBJDY053zw==
X-Received: by 2002:a05:6a20:9150:b0:248:4d59:93d5 with SMTP id adf61e73a8af0-2e7d72637famr22343288637.55.1759161792642;
        Mon, 29 Sep 2025 09:03:12 -0700 (PDT)
Received: from y740.local ([2401:4900:1f30:25ff:36cb:10ee:ba03:839f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a0ca2sm11504525a12.42.2025.09.29.09.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 09:03:12 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: antonio@openvpn.net,
	sd@queasysnail.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	willemdebruijn.kernel@gmail.com,
	kernelxing@tencent.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	david.hunter.linux@gmail.com,
	Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH v2] net: Fix uninit character pointer and return values
Date: Mon, 29 Sep 2025 21:32:31 +0530
Message-ID: <20250929160230.36941-2-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix uninitialized character pointer, and functions that return
undefined values. These issues were caught by running clang using LLVM=1
option; and are as follows:
--
ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
 1587 |         if (!sock) {
      |             ^~~~~
ovpn-cli.c:1635:9: note: uninitialized use occurs here
 1635 |         return ret;
      |                ^~~
ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always false
 1587 |         if (!sock) {
      |         ^~~~~~~~~~~~
 1588 |                 fprintf(stderr, "cannot allocate netlink socket\n");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1589 |                 goto err_free;
      |                 ~~~~~~~~~~~~~~
 1590 |         }
      |         ~
ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this warning
 1584 |         int mcid, ret;
      |                      ^
      |                       = 0
ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
 2107 |         case CMD_INVALID:
      |              ^~~~~~~~~~~
ovpn-cli.c:2111:9: note: uninitialized use occurs here
 2111 |         return ret;
      |                ^~~
ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this warning
 1939 |         int n, ret;
      |                   ^
      |
--
so_txtime.c:210:3: warning: variable 'reason' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
  210 |                 default:
      |                 ^~~~~~~
so_txtime.c:219:27: note: uninitialized use occurs here
  219 |                         data[ret - 1], tstamp, reason);
      |                                                ^~~~~~
so_txtime.c:177:21: note: initialize the variable 'reason' to silence this warning
  177 |                 const char *reason;
      |                                   ^
      |
--
Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
ovpn module")
Fixes: ca8826095e4d4 ("selftests/net: report etf errors correctly")

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>

v2:
	- Use subsystem name "net".
	- Add fixes tags.
	- Remove txtimestamp fix as default case calls error.
	- Assign constant error string instead of NULL.
--

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 9201f2905f2c..20d00378f34a 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1581,7 +1581,7 @@ static int ovpn_listen_mcast(void)
 {
 	struct nl_sock *sock;
 	struct nl_cb *cb;
-	int mcid, ret;
+	int mcid, ret = -1;
 
 	sock = nl_socket_alloc();
 	if (!sock) {
@@ -1936,7 +1936,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 {
 	char peer_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128], lport[10];
 	char raddr[128], rport[10];
-	int n, ret;
+	int n, ret = -1;
 	FILE *fp;
 
 	switch (ovpn->cmd) {
diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
index 8457b7ccbc09..5bf3c483069b 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/so_txtime.c
@@ -174,7 +174,7 @@ static int do_recv_errqueue_timeout(int fdt)
 	msg.msg_controllen = sizeof(control);
 
 	while (1) {
-		const char *reason;
+		const char *reason = "unknown errno";
 
 		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
 		if (ret == -1 && errno == EAGAIN)
-- 
2.47.3


