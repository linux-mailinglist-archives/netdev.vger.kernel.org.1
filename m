Return-Path: <netdev+bounces-141694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39DF9BC0D2
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB02281EDB
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022451FDF8A;
	Mon,  4 Nov 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1dwDCRd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47691F584E;
	Mon,  4 Nov 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759116; cv=none; b=I0ak4Sh+d8AsjdriVHFKE3l6sS2bTngeZOsc4+QCs8TT9Q0RSd96Gp5JAyVlPBo3Qtx07Ry+axUMe9rAAmU7r3rcukl81aT6IYRUrMRpI7fHYuWsmAvF95dbS+C0CgDJ9kQyBj+Ma9Je1zlL3yQDLQHsgNzavfa4CiTohNpKFiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759116; c=relaxed/simple;
	bh=EMMCpsdODJVzRgCRGNjxUyPSk2UohbpGVbsSjg+is+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HP9zJe8yhU/wVdqSk0bex95LLGPruzUjV41IH9TkdZqToTiKcteSB2XdXMlOuDi5hayPpyMf0IHUNjvdi1YGdap5JfihEZCMkDYaZ6f7ED+ROpSINt7TV9frsCzG6nkJvesK2kuFZCNprRUCDrfpHgApALtleaP4Ffnq8LZWY3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1dwDCRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7770FC4CECE;
	Mon,  4 Nov 2024 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730759116;
	bh=EMMCpsdODJVzRgCRGNjxUyPSk2UohbpGVbsSjg+is+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1dwDCRdo1YDA3tV8OP+eYNHOnBsfSWG9AKWcWpOZw762dgquzTpseCWiiR+XUGPM
	 XNSU2ro1fLMIcbzOqU0o8Ca5MUaq9bOwIM7PRBcbU+um4zp2i0J54R3amvd8QLpsmY
	 YhU7JMeAAAmdZoMGKfYpMjSOl0o1WZO77itIY1PSb4gQdNHgjmfBON13l7kpz7o5Vc
	 y27mNiGvZRpAEmIhiqIWQ2AClRipbxJcHRgf4YNSOSqt8wtvvCp/dtLfWLgZ/ojQhD
	 YTRkGHoKQiZq+Tn0dT9SdMpMTADzgrO8SNWnYI3md/iJOH+rGflS1zWkV9TVto2j6m
	 8AlJkjXVxt/VQ==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RFC 4/5] net: core: Convert inet_addr_is_any() to sockaddr_storage
Date: Mon,  4 Nov 2024 14:25:06 -0800
Message-Id: <20241104222513.3469025-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104221450.work.053-kees@kernel.org>
References: <20241104221450.work.053-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3869; i=kees@kernel.org; h=from:subject; bh=EMMCpsdODJVzRgCRGNjxUyPSk2UohbpGVbsSjg+is+c=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmanofKHSb3yEnXLfHgmHdLM/yfcSTvnP/Gn2fohWixf 12rqzKto5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCLaiYwMp1X4rorbOaxubj+7 6LB23upUS/GQpaf85HWZHlzdzdB+n5FhS2fRTIbrBbH18101q6LKLbx75cR0Zp7dYvvky9xVc1K YAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

All the callers of inet_addr_is_any() have a sockaddr_storage-backed
sockaddr. Avoid casts and switch prototype to the actual object being
used.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/nvme/target/rdma.c          | 2 +-
 drivers/nvme/target/tcp.c           | 2 +-
 drivers/target/iscsi/iscsi_target.c | 2 +-
 include/linux/inet.h                | 2 +-
 net/core/utils.c                    | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ade285308450..6e4f76711142 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1988,7 +1988,7 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 	struct nvmet_rdma_port *port = nport->priv;
 	struct rdma_cm_id *cm_id = port->cm_id;
 
-	if (inet_addr_is_any((struct sockaddr *)&cm_id->route.addr.src_addr)) {
+	if (inet_addr_is_any(&cm_id->route.addr.src_addr)) {
 		struct nvmet_rdma_rsp *rsp =
 			container_of(req, struct nvmet_rdma_rsp, req);
 		struct rdma_cm_id *req_cm_id = rsp->queue->cm_id;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..df24244fb820 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2158,7 +2158,7 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
 {
 	struct nvmet_tcp_port *port = nport->priv;
 
-	if (inet_addr_is_any((struct sockaddr *)&port->addr)) {
+	if (inet_addr_is_any(&port->addr)) {
 		struct nvmet_tcp_cmd *cmd =
 			container_of(req, struct nvmet_tcp_cmd, req);
 		struct nvmet_tcp_queue *queue = cmd->queue;
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 6002283cbeba..1ce68eda0090 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -3471,7 +3471,7 @@ iscsit_build_sendtargets_response(struct iscsit_cmd *cmd,
 					}
 				}
 
-				if (inet_addr_is_any((struct sockaddr *)&np->np_sockaddr))
+				if (inet_addr_is_any(&np->np_sockaddr))
 					sockaddr = &conn->local_sockaddr;
 				else
 					sockaddr = &np->np_sockaddr;
diff --git a/include/linux/inet.h b/include/linux/inet.h
index bd8276e96e60..d59e3013b0e2 100644
--- a/include/linux/inet.h
+++ b/include/linux/inet.h
@@ -55,6 +55,6 @@ extern int in6_pton(const char *src, int srclen, u8 *dst, int delim, const char
 
 extern int inet_pton_with_scope(struct net *net, unsigned short af,
 		const char *src, const char *port, struct sockaddr_storage *addr);
-extern bool inet_addr_is_any(struct sockaddr *addr);
+extern bool inet_addr_is_any(struct sockaddr_storage *addr);
 
 #endif	/* _LINUX_INET_H */
diff --git a/net/core/utils.c b/net/core/utils.c
index 27f4cffaae05..e47feeaa5a49 100644
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -399,9 +399,9 @@ int inet_pton_with_scope(struct net *net, __kernel_sa_family_t af,
 }
 EXPORT_SYMBOL(inet_pton_with_scope);
 
-bool inet_addr_is_any(struct sockaddr *addr)
+bool inet_addr_is_any(struct sockaddr_storage *addr)
 {
-	if (addr->sa_family == AF_INET6) {
+	if (addr->ss_family == AF_INET6) {
 		struct sockaddr_in6 *in6 = (struct sockaddr_in6 *)addr;
 		const struct sockaddr_in6 in6_any =
 			{ .sin6_addr = IN6ADDR_ANY_INIT };
@@ -409,13 +409,13 @@ bool inet_addr_is_any(struct sockaddr *addr)
 		if (!memcmp(in6->sin6_addr.s6_addr,
 			    in6_any.sin6_addr.s6_addr, 16))
 			return true;
-	} else if (addr->sa_family == AF_INET) {
+	} else if (addr->ss_family == AF_INET) {
 		struct sockaddr_in *in = (struct sockaddr_in *)addr;
 
 		if (in->sin_addr.s_addr == htonl(INADDR_ANY))
 			return true;
 	} else {
-		pr_warn("unexpected address family %u\n", addr->sa_family);
+		pr_warn("unexpected address family %u\n", addr->ss_family);
 	}
 
 	return false;
-- 
2.34.1


