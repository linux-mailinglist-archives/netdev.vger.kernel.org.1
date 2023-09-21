Return-Path: <netdev+bounces-35399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0247A9482
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 15:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673C2B20A3A
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 13:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F5EB658;
	Thu, 21 Sep 2023 13:07:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98FB641;
	Thu, 21 Sep 2023 13:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A368FC4AF7D;
	Thu, 21 Sep 2023 13:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695301671;
	bh=QSvZ1h0l3nqidFnih1V5qYuSkxD9/xAgXvBfT6+g/Nc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=DUhP5bau2L+SMKv1acq/LCNTTfwa9CHQ2o4T0eHgZVIybQNPhdhJRzwTtvjuwgYZ8
	 tqAPnxNz4jLrX1+o3AShH7TQOEBxvj5FFdnrMhKfzlz5fbTSeNejpPhh+u0Lq/h91x
	 vI4Rk3WBHFdFjV+EtFA3lmHh/IevTM5mV0DsSphFsfIW2UkRlKpI13c8w0QRpLNBJC
	 +D67c6Iw+wDa/Y+ZpTpCIZevQCabU4r1IlgjB6WcwLl0voKKj5b5u3LpHWOYyJdBTx
	 /7UoU3HXuBfXuqb5dB67H+Q/P4VTUiSGOnJ7xTq3Y4zXDjaLusNcNIyMHbhCZpk0lI
	 TjQbFtnrn5/ig==
Subject: [PATCH v2 1/2] handshake: Fix sign of socket file descriptor fields
From: Chuck Lever <cel@kernel.org>
To: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Cc: Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 21 Sep 2023 09:07:40 -0400
Message-ID: 
 <169530165057.8905.8650469415145814828.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: 
 <169530154802.8905.2645661840284268222.stgit@oracle-102.nfsv4bat.org>
References: 
 <169530154802.8905.2645661840284268222.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Socket file descriptors are signed integers. Use nla_get/put_s32 for
those to avoid implicit signed conversion in the netlink protocol.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/handshake.yaml |    4 ++--
 net/handshake/genl.c                       |    2 +-
 net/handshake/netlink.c                    |    2 +-
 net/handshake/tlshd.c                      |    2 +-
 tools/net/ynl/generated/handshake-user.h   |    6 +++---
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 6d89e30f5fd5..a49b46b80e16 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -43,7 +43,7 @@ attribute-sets:
     attributes:
       -
         name: sockfd
-        type: u32
+        type: s32
       -
         name: handler-class
         type: u32
@@ -79,7 +79,7 @@ attribute-sets:
         type: u32
       -
         name: sockfd
-        type: u32
+        type: s32
       -
         name: remote-auth
         type: u32
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index 233be5cbfec9..f55d14d7b726 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -18,7 +18,7 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 /* HANDSHAKE_CMD_DONE - do */
 static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
 	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
-	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
 };
 
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index d0bc1dd8e65a..64a0046dd611 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -163,7 +163,7 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (GENL_REQ_ATTR_CHECK(info, HANDSHAKE_A_DONE_SOCKFD))
 		return -EINVAL;
-	fd = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_SOCKFD]);
+	fd = nla_get_s32(info->attrs[HANDSHAKE_A_DONE_SOCKFD]);
 
 	sock = sockfd_lookup(fd, &err);
 	if (!sock)
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index bbfb4095ddd6..7ac80201aa1f 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -214,7 +214,7 @@ static int tls_handshake_accept(struct handshake_req *req,
 		goto out_cancel;
 
 	ret = -EMSGSIZE;
-	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_SOCKFD, fd);
+	ret = nla_put_s32(msg, HANDSHAKE_A_ACCEPT_SOCKFD, fd);
 	if (ret < 0)
 		goto out_cancel;
 	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_MESSAGE_TYPE, treq->th_type);
diff --git a/tools/net/ynl/generated/handshake-user.h b/tools/net/ynl/generated/handshake-user.h
index 47646bb91cea..f8e481fa9e09 100644
--- a/tools/net/ynl/generated/handshake-user.h
+++ b/tools/net/ynl/generated/handshake-user.h
@@ -65,7 +65,7 @@ struct handshake_accept_rsp {
 		__u32 peername_len;
 	} _present;
 
-	__u32 sockfd;
+	__s32 sockfd;
 	enum handshake_msg_type message_type;
 	__u32 timeout;
 	enum handshake_auth auth_mode;
@@ -104,7 +104,7 @@ struct handshake_done_req {
 	} _present;
 
 	__u32 status;
-	__u32 sockfd;
+	__s32 sockfd;
 	unsigned int n_remote_auth;
 	__u32 *remote_auth;
 };
@@ -122,7 +122,7 @@ handshake_done_req_set_status(struct handshake_done_req *req, __u32 status)
 	req->status = status;
 }
 static inline void
-handshake_done_req_set_sockfd(struct handshake_done_req *req, __u32 sockfd)
+handshake_done_req_set_sockfd(struct handshake_done_req *req, __s32 sockfd)
 {
 	req->_present.sockfd = 1;
 	req->sockfd = sockfd;



