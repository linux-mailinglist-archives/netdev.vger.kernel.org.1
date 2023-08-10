Return-Path: <netdev+bounces-26578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F7778431
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 01:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BDF281F07
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5851ADC1;
	Thu, 10 Aug 2023 23:38:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219F2125A0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5749DC433C9;
	Thu, 10 Aug 2023 23:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691710730;
	bh=eiPKbSWhYnUgwdheV/lE6KD+9ALKc25tY/Ee2EbJYCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJjA/nu6BbLW0erRfH+KV1J8LPNENw5gCAKpKWpCiSGdvBIjeGpuiUip1WfT7p5Ik
	 DihfakrJl3FtwpXgqAZEOjlfu4qv2jraaKmV/jt6Fx0JKAMqw475Qknhu0sC2gFVtJ
	 UTKv5pFrRPUIRnAYreSUJp2P/ys17ojR3tNIts4HUzKkZiEC0QHftug0wKnTIutkgp
	 0sOxnBuDysQvhnqAFZFzJScTsNPh6eWJUSRbKhNVGtFKVP9PxHPDRpPT2YtKUSNK3Z
	 9jrrOqFYt+exMfTm9CNM43LkeUL8JSwE8ifMaFdQOK1oDPxrB4V7QB3fEtyNJpzwPU
	 gNcQvt3dU6Vig==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>,
	sam@mendozajonas.com
Subject: [PATCH net-next v2 02/10] genetlink: make genl_info->nlhdr const
Date: Thu, 10 Aug 2023 16:38:37 -0700
Message-ID: <20230810233845.2318049-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810233845.2318049-1-kuba@kernel.org>
References: <20230810233845.2318049-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct netlink_callback has a const nlh pointer, make the
pointer in struct genl_info const as well, to make copying
between the two easier.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
CC: sam@mendozajonas.com
---
 include/net/genetlink.h | 2 +-
 net/ncsi/ncsi-netlink.c | 2 +-
 net/ncsi/ncsi-netlink.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index ed4622dd4828..0366d0925596 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -104,7 +104,7 @@ struct genl_family {
 struct genl_info {
 	u32			snd_seq;
 	u32			snd_portid;
-	struct nlmsghdr *	nlhdr;
+	const struct nlmsghdr *	nlhdr;
 	struct genlmsghdr *	genlhdr;
 	void *			userhdr;
 	struct nlattr **	attrs;
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index d27f4eccce6d..a3a6753a1db7 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -563,7 +563,7 @@ int ncsi_send_netlink_timeout(struct ncsi_request *nr,
 int ncsi_send_netlink_err(struct net_device *dev,
 			  u32 snd_seq,
 			  u32 snd_portid,
-			  struct nlmsghdr *nlhdr,
+			  const struct nlmsghdr *nlhdr,
 			  int err)
 {
 	struct nlmsghdr *nlh;
diff --git a/net/ncsi/ncsi-netlink.h b/net/ncsi/ncsi-netlink.h
index 39a1a9d7bf77..747767ea0aae 100644
--- a/net/ncsi/ncsi-netlink.h
+++ b/net/ncsi/ncsi-netlink.h
@@ -19,7 +19,7 @@ int ncsi_send_netlink_timeout(struct ncsi_request *nr,
 int ncsi_send_netlink_err(struct net_device *dev,
 			  u32 snd_seq,
 			  u32 snd_portid,
-			  struct nlmsghdr *nlhdr,
+			  const struct nlmsghdr *nlhdr,
 			  int err);
 
 #endif /* __NCSI_NETLINK_H__ */
-- 
2.41.0


