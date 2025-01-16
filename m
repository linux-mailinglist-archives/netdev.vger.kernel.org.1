Return-Path: <netdev+bounces-159054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC360A143F2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5013A78F6
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CED1D7E54;
	Thu, 16 Jan 2025 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PnHTtpth"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7626198A0D
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737062465; cv=none; b=kYq9Jk4msMoc14Br2ULbiPwjedg9YF3TwqxaR+7dvsWZ9qJcIriN2kHm3XThW6xqRvz46Lsfo8mJ2ayADA9BfALGEsa6qMzGpD6/c9y218Pd8wQQX8Ea/58mF+HCJPi/CKbYSun5jK4beDckVIFpMdOmSnRzsG03445wiaWeVAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737062465; c=relaxed/simple;
	bh=MjLB8cGPzHtA3JKM+gbMrilrolSPKow+VzxyU+G4jko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oALAO00o/O4KDaGs6xTVFrllCRJDuJUyRbxYwxCo7748F5IF5tWGzBM9SV0dbKt1ZysHU5knk8ZshrL3xgdmnEodYVBJRPned3bdZGO5KIr4C/I9HGeixR8FA+rjFcOS7Ekx9hxDlGV6I4jx5iYmplxNka39D1BxxZ3PdG+VY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PnHTtpth; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737062446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Syu9PoY8qUbezBkyLynlw3MObrHBcpVaz9Wa9zY10Q=;
	b=PnHTtpthJIwc1z9MljiV1oUxKhACxW70+pfWhahgBpTN8qBaJy4W7uXZHIPbNZSTlxbJko
	gB/A2PGO6mxxtviZ4B72ZbiquVCNSF4c1+LoXobKOEOdGTPAYPbNbZs+D9GbYQW7gz81Ww
	+YTqKbFAAufys3rJac5s7S2yF0DcNaw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org,
	Roman Kisel <romank@linux.microsoft.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] hv_netvsc: Replace one-element array with flexible array member
Date: Thu, 16 Jan 2025 22:19:32 +0100
Message-ID: <20250116211932.139564-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct nvsp_1_message_send_receive_buffer_complete.

Use struct_size_t(,,1) instead of sizeof() to maintain the same size.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Replace sizeof() with struct_size_t(,,1) to maintain the same size
  after feedback from Roman Kisel (thanks!)
- Link to v1: https://lore.kernel.org/r/20250116201635.47870-2-thorsten.blum@linux.dev/
---
 drivers/net/hyperv/hyperv_net.h | 2 +-
 drivers/net/hyperv/netvsc.c     | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index e690b95b1bbb..234db693cefa 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -464,7 +464,7 @@ struct nvsp_1_message_send_receive_buffer_complete {
 	 *  LargeOffset                            SmallOffset
 	 */
 
-	struct nvsp_1_receive_buffer_section sections[1];
+	struct nvsp_1_receive_buffer_section sections[];
 } __packed;
 
 /*
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 9afb08dbc350..d6f5b9ea3109 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -866,7 +866,8 @@ static void netvsc_send_completion(struct net_device *ndev,
 
 	case NVSP_MSG1_TYPE_SEND_RECV_BUF_COMPLETE:
 		if (msglen < sizeof(struct nvsp_message_header) +
-				sizeof(struct nvsp_1_message_send_receive_buffer_complete)) {
+				struct_size_t(struct nvsp_1_message_send_receive_buffer_complete,
+					      sections, 1)) {
 			netdev_err(ndev, "nvsp_msg1 length too small: %u\n",
 				   msglen);
 			return;
-- 
2.48.0


