Return-Path: <netdev+bounces-218516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71178B3CF37
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 22:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B614201AA8
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 20:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F8A246BD7;
	Sat, 30 Aug 2025 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfbLVRPU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E84CB5B
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756584313; cv=none; b=T/SLaup0T0XqpDDg1l7D0mA+4LO+/YITqkyns/IuuTriOXF628ht7APN8QgaDvhO4R5vfkB+5g0Io41/6XsL5CQQbOVV5KyIk5lGlfLkAIROFobLPnKi/pIW8rwfkuFdk8VdG3vFfRw8OcCgNFGcQ4sMz6Cfp97fKDz4YrAkpd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756584313; c=relaxed/simple;
	bh=79Y4ahkSAtl6Z32MARWEKQUJHx1SGK5iD0Bl0JMCAyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H91gmZF6Jft+bFdbHu3+lk1exdXi/EEBtrZxTaDEFL90cUVqgjiPCLhIb77YX6dlVOi1xLt++dItOt94e54+AqU9XkhacU+5/aZ84qj1GpRdwEVWiu16aieqBrqeGviKTHlu549HQ2YxqMJg5o8JR9QKDH3TCq/Q8Kw15036ykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfbLVRPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF45EC4CEEB;
	Sat, 30 Aug 2025 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756584313;
	bh=79Y4ahkSAtl6Z32MARWEKQUJHx1SGK5iD0Bl0JMCAyU=;
	h=From:To:Cc:Subject:Date:From;
	b=rfbLVRPURCUGb00iUB1r28Vk6EXSbHRQ+nzDChq+LmBhlR8Th95FLRKb9CHe0DURJ
	 CKQA73VL7POzenNSSGLlnYDmRsEZsAZ/CQ3F1hfXuu+oLHZtT9YoRzN0wGyzqVRbUy
	 PZ/6QHGyvuGVa2PHjceEhtm5HmZzEshgkvgB5E1t+RdO7kGjkGwxGwUoztx0fBjEaI
	 pM5FuFnbOFBDFirGwiyZuXnjQgQio4Utdgz7YehurCdqgm8FvWRhrwZfWEJ2szXozU
	 fNw03Ham16e8KMar6DX/C7fdZlvGTXYNsu+/yuzMA1dihIPb2mBDeNXVh2ZUEFE2Pi
	 vk3pf/RXeJaLg==
From: Jakub Kicinski <kuba@kernel.org>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH ethtool-next] rxfh: IPv6 Flow Label hash support
Date: Sat, 30 Aug 2025 13:05:08 -0700
Message-ID: <20250830200508.739431-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for configuring Rx hashing on the flow label.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 ethtool.8.in | 1 +
 ethtool.c    | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 29b8a8c085f1..8efd1f4ef6bc 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -1121,6 +1121,7 @@ s	Hash on the IP source address of the rx packet.
 d	Hash on the IP destination address of the rx packet.
 f	Hash on bytes 0 and 1 of the Layer 4 header of the rx packet.
 n	Hash on bytes 2 and 3 of the Layer 4 header of the rx packet.
+l	Hash on IPv6 Flow Label of the rx packet.
 r	T{
 Discard all packets of this flow type. When this option is set, all
 other options are ignored.
diff --git a/ethtool.c b/ethtool.c
index 215f5663546d..c391e5332461 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -1106,6 +1106,9 @@ static int parse_rxfhashopts(char *optstr, u32 *data)
 		case 'e':
 			*data |= RXH_GTP_TEID;
 			break;
+		case 'l':
+			*data |= RXH_IP6_FL;
+			break;
 		case 'r':
 			*data |= RXH_DISCARD;
 			break;
@@ -1140,6 +1143,8 @@ static char *unparse_rxfhashopts(u64 opts)
 			strcat(buf, "L4 bytes 2 & 3 [TCP/UDP dst port]\n");
 		if (opts & RXH_GTP_TEID)
 			strcat(buf, "GTP TEID\n");
+		if (opts & RXH_IP6_FL)
+			strcat(buf, "IPv6 Flow Label\n");
 	} else {
 		sprintf(buf, "None");
 	}
@@ -6023,7 +6028,7 @@ static const struct option args[] = {
 		.help	= "Configure Rx network flow classification options or rules",
 		.xhelp	= "		rx-flow-hash tcp4|udp4|ah4|esp4|sctp4|"
 			  "gtpc4|gtpc4t|gtpu4|gtpu4e|gtpu4u|gtpu4d|tcp6|udp6|ah6|esp6|sctp6"
-			  "|gtpc6|gtpc6t|gtpu6|gtpu6e|gtpu6u|gtpu6d m|v|t|s|d|f|n|r|e... [context %d] |\n"
+			  "|gtpc6|gtpc6t|gtpu6|gtpu6e|gtpu6u|gtpu6d m|v|t|s|d|f|n|r|e|l... [context %d] |\n"
 			  "		flow-type ether|ip4|tcp4|udp4|sctp4|ah4|esp4|"
 			  "ip6|tcp6|udp6|ah6|esp6|sctp6\n"
 			  "			[ src %x:%x:%x:%x:%x:%x [m %x:%x:%x:%x:%x:%x] ]\n"
-- 
2.51.0


