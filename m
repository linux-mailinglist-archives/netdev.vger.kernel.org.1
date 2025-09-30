Return-Path: <netdev+bounces-227323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BC9BAC691
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C0F321209
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0B2F6186;
	Tue, 30 Sep 2025 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHRRs3bb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6472F5333
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226871; cv=none; b=WCqxgd35vrsx1QJLooqcn/Rqw4iLAFxm6Mborsj9BrKzXvuft4qWbcMLTwPVKwQWbBzwRNWyGOEJieq5dEppV/km++Mz4x3uuHwdGKi9k6ZIRsgjx3k1BqI604UZiREQ0kQkxTeVdeJ1a70EBXiRvflfavr1MJ4wUGaXZg1zWqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226871; c=relaxed/simple;
	bh=FKY8z1CEGgUY6q+4pHNC/Om4xVBeYJauYh54XqnoY6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kv3MF8vc8rsErJjZgzcdXCwBl6pnFUeFpI+IKVFF0/lsgwaxmXIhnwyFqBvKoqI9t8yBphHA0GakPoYlh5JD/i/iAYbfYLk5eqTkdM6SsUc7XADbHU7q7t94jxOePcapYEhijhtE23WOEBOJ5LMPiPfn2GWsQqs/UfjO4onVvGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHRRs3bb; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b551350adfaso5421964a12.3
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759226870; x=1759831670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2HgwqWLqv5BJjpLMqtyvMalLTTdm/aF2XY54W3HTWoA=;
        b=JHRRs3bbCfqBryaK1C7aE8tJvio5eG4vzQqVNUN2GsQ+5lMXTsxDuNhfqwLyMD0FTH
         dug+Vi+EipGWxS5WU1Rjainb1etD7zd+i5F2xBQae5KyCyc8M8JvEhZz7jW+UEhHiwFZ
         M52g7ukWZqSO1GiUuPQXWwCCaQwFvrMocBBTClHYA1kqdBsTndXIMMYK+xOhkJ8pjbwx
         iRG5es4Rqvam4zMCcsjbaxZ4x5MAoiq2dYS+vuUR/8vk1R3QGstP+XB/FDF29/Y0g+pp
         wUgARCzejgYXBefAiINq3UOA2hllyE8nQihSJurhAft0xdBYFB4XQ/siLTVyFVdiNHfb
         lpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759226870; x=1759831670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HgwqWLqv5BJjpLMqtyvMalLTTdm/aF2XY54W3HTWoA=;
        b=G7U6LJzk7SNjMiOvm7cFf3yNav3ibhwFE0FZ1+ULrLYwhqnIgY9iG78x3170Yre0tx
         /QyeIc2aniJSLzGJDUvZkuua6LsO6DuSlPOqUPbcULy5HYbfP5sWh8vjJgh4Lt42/2fP
         owbseXkMZqzFQQOx2FmnGurrzDqIT04DOEaLq4K3slGKoZjbk5LLSHTVd3vicQEpmiFM
         pttjuAKor2EIBZqypa7///wmfLHlGolVPBILXk46ddty1vclTnCq+5mKOQd/0MU8tt3R
         XE8utksD7Fl3uIDwV4QamrxRatsyc5YEA3xAEIp2CmrGSEgcp64hwbTn4imexC8XmcFP
         ei3w==
X-Gm-Message-State: AOJu0YxqC32SexHbCZ142AJEgX2x6UnAPTmiSE101+j4qy4nWmt4Mk1v
	q0T+bofoiZU96M24RGYx7VoAyxqvYHD+AgsdZz3cOMWSPb//wNAxDP67k0qiXeX63gk=
X-Gm-Gg: ASbGncuTr0TGdgad+Jyv5HO83DY+PeC9g49k/2vkvYyYCDqL5YDmV9uHYe8H6oJL83C
	qwhhzq+0d2qlsZtMPnqa7fbPrif+h/Wq/FNWnZKnkMy/j2botYJL6WU0fCDv15IdjQj9SgO5QlF
	OYOAvS7f7tb4pZXbaOO/xqvei/bZllE1OZDV2Lqn//V6GLP/1WRut5fNpZbysSzkz9H0uDTKa97
	qrzxCcM3P59uNiNAjkAnSPHfKkIEfDVVxafem2MCCnQylLogYzVr8T5N7fp3zxbkLbKmg564TWS
	ueTBBzTOsRqSy12DhWhntXYWy+4fGCNc7blh32P+U3ETXCnuTBcTTNjxxsFOA+A9lUKKKIh143Z
	T2slkp1l8FVHhGseYVbukBu/R8JqCXfkqxl5MopaKtQqv3Fy+0oVGzIR7vSYKqPo=
X-Google-Smtp-Source: AGHT+IEUeUIAzZJUtqx0W1k5wrTJY310MNYv8ZMr9OBtEg3B71EpiDEoNAOJyPoAlF3t85pkcXk0Ig==
X-Received: by 2002:a17:903:19cf:b0:269:7427:fe37 with SMTP id d9443c01a7336-27ed4a30e5cmr216987585ad.29.1759226869598;
        Tue, 30 Sep 2025 03:07:49 -0700 (PDT)
Received: from y740.local ([2401:4900:1f31:e91f:2d6d:e8a8:f2d7:94ae])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6733a63sm155381685ad.64.2025.09.30.03.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:07:49 -0700 (PDT)
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
	Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH net v4] selftest:net: Fix uninit return values
Date: Tue, 30 Sep 2025 15:36:57 +0530
Message-ID: <20250930100656.80420-2-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix functions that return undefined values. These issues were caught by
running clang using LLVM=1 option.


Clang warnings are as follows:
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


Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
ovpn module")
Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---
v4:
	- Move changelog below sign-off.
	- Remove double-hyphens in commit description.
v3:
	- Use prefix net.
	- Remove so_txtime fix as default case calls error().
	- Changelog before sign-off.
	- Three dashes after sign-off
v2:
	- Use subsystem name "net".
	- Add fixes tags.
	- Remove txtimestamp fix as default case calls error.
	- Assign constant error string instead of NULL.


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
-- 
2.47.3


