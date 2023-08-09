Return-Path: <netdev+bounces-26012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30431776732
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278D11C212E3
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F21DDC4;
	Wed,  9 Aug 2023 18:26:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A301D31B
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8C2C433CA;
	Wed,  9 Aug 2023 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691605614;
	bh=mSF14+DWormk/WM3WbPHC8G74aizhXcqIW7++7eX9TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HqpSD3Jo1cENoXpcmCZkdsjtrRYQEO25yH5KAw42Y/2k/onKZn8jE13HY3Di2j5iF
	 QzVfPFq0KhDYbvSSInlYKvABI6/vg0ylrUxZBrTYPR0UKslaSTdXs4tbOzDzduvo0S
	 pTTLOFyans/JfxxGM7b0Ec6HVUZ4hFhAkuETz0RzqZCD5SBjnKiS4niV4KhMevrzhE
	 W2amZqrsGscH0fldUfiJWMY4vnUkkIABnYsjGlWq988YytQkt2XDcYppq8rWmlU3/y
	 gOBI53Ccu1zp9lLqpnjLqA1n/SZEkHMzrU7L3cyWhjJCh6tj4/PD+FW0Y0MACT7W+T
	 85uLCv4+864Dg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	sam@mendozajonas.com
Subject: [PATCH net-next 02/10] genetlink: make genl_info->nlhdr const
Date: Wed,  9 Aug 2023 11:26:40 -0700
Message-ID: <20230809182648.1816537-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809182648.1816537-1-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct netlink_callback has a const nlh pointer, make info
pointer const as well, to make setting genl_info->nlh in
dumps easier.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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


