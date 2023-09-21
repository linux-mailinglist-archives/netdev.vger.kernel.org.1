Return-Path: <netdev+bounces-35400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FE27A9486
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 15:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08120281B27
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22384B65D;
	Thu, 21 Sep 2023 13:08:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA3B641;
	Thu, 21 Sep 2023 13:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C006C4E66F;
	Thu, 21 Sep 2023 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695301698;
	bh=1QnDPxs+eOFrGBGlAIfkO8jsMXLrh5hKaD4ar3Lv9SQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KY3RiyDnHedAFUhciM1W5rkRmEITEHotlUjyuJm8Ph2PmQpWXR8vAQZ3k/GTtEtRl
	 GVROz/syNO0YT9L4ZbNuBZxKXDl/++2MY9VNaxcy1XA4zIPURZ1TaKrp1IvWTAOn4x
	 n442WEbmVW1SIYUkYDo82jrUdcEEJLYmxDLn0M/cuQ7ZGfq3D3RMvkNvtzye6sIjJt
	 N+dsEbB2q8QkOAgZkaqc2tO5ket68IyNIWy9suOp1BXXWKppNoNGgJkGYz/2z5CHe5
	 EXd1mAFDkF0uB9H2S5zTk4sQeWuNrvYYo9ipVB6laJS+1W3Itc33c0rGw3e6KvBFiD
	 LcAyUvbL7NROA==
Subject: [PATCH v2 2/2] handshake: Fix sign of key_serial_t fields
From: Chuck Lever <cel@kernel.org>
To: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Cc: Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 21 Sep 2023 09:08:07 -0400
Message-ID: 
 <169530167716.8905.645746457741372879.stgit@oracle-102.nfsv4bat.org>
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

key_serial_t fields are signed integers. Use nla_get/put_s32 for
those to avoid implicit signed conversion in the netlink protocol.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/handshake.yaml |    4 ++--
 net/handshake/tlshd.c                      |    4 ++--
 tools/net/ynl/generated/handshake-user.h   |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index a49b46b80e16..b934cc513e3d 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -34,10 +34,10 @@ attribute-sets:
     attributes:
       -
         name: cert
-        type: u32
+        type: s32
       -
         name: privkey
-        type: u32
+        type: s32
   -
     name: accept
     attributes:
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 7ac80201aa1f..d697f68c598c 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -173,9 +173,9 @@ static int tls_handshake_put_certificate(struct sk_buff *msg,
 	if (!entry_attr)
 		return -EMSGSIZE;
 
-	if (nla_put_u32(msg, HANDSHAKE_A_X509_CERT,
+	if (nla_put_s32(msg, HANDSHAKE_A_X509_CERT,
 			treq->th_certificate) ||
-	    nla_put_u32(msg, HANDSHAKE_A_X509_PRIVKEY,
+	    nla_put_s32(msg, HANDSHAKE_A_X509_PRIVKEY,
 			treq->th_privkey)) {
 		nla_nest_cancel(msg, entry_attr);
 		return -EMSGSIZE;
diff --git a/tools/net/ynl/generated/handshake-user.h b/tools/net/ynl/generated/handshake-user.h
index f8e481fa9e09..2b34acc608de 100644
--- a/tools/net/ynl/generated/handshake-user.h
+++ b/tools/net/ynl/generated/handshake-user.h
@@ -28,8 +28,8 @@ struct handshake_x509 {
 		__u32 privkey:1;
 	} _present;
 
-	__u32 cert;
-	__u32 privkey;
+	__s32 cert;
+	__s32 privkey;
 };
 
 /* ============== HANDSHAKE_CMD_ACCEPT ============== */



