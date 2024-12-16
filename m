Return-Path: <netdev+bounces-152159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4144E9F2ED3
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED7816697C
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D08204096;
	Mon, 16 Dec 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sG3G8flK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BB204085
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347088; cv=none; b=VNzJHP7Ebo+Tct7rzdn6hh639IPaOaDK2Kzg0wqjCj9sfXMZcZ8G6/3vdTnxziZK1MuQf7tKsZKCR22PtYF+MS1VpmapJ7b6uzj1kqvXyyH2PU4+1Hsybzrxyb3SwUxuNNr521KizOKh2AIbT4swC7OxUxAFCv+CFyAN0Bs+P+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347088; c=relaxed/simple;
	bh=+ud13VZMSS14lwXTO/2li7VNQQusf0RaBWamAN42kiM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c4w9YhD9deMqBZ5XduzrLjxAflYajou5M7GDy4KnsbyVe9IIOEtm6LVQ7xpt/+569+2kgwFZjSEBOS7uWmrSVEq/YHa2jhneRoDvFrFgF0RuYQldhc0LPSOcwgZm3b9RJaFHRUVIPH+omqgmbECefV3zmFf7AZexHvIefjvQlSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sG3G8flK; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734347088; x=1765883088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hi/9yWdc8tFrrL1wO19FrTpkKGXfLtC9hWEQf6nHIjc=;
  b=sG3G8flKQp5Q4y3ZxjigBdHQiyDI3bnrnVDfvS6dz67lVXFETQmswRAH
   jJ2I+mNZqC9rLpua81OSK7KuWSdaMMwc6nmpxl35Mof/RZ8tVdll8mJHJ
   pR889DAU/DYUmJnnkFPZ3fG0Jt1kYSSQ4GAZIqi7pBHvtDubUXdQ/KsjN
   E=;
X-IronPort-AV: E=Sophos;i="6.12,238,1728950400"; 
   d="scan'208";a="456367520"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 11:04:44 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:61376]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.119:2525] with esmtp (Farcaster)
 id 7969350a-5549-4a5d-a3ec-42ef915e4c90; Mon, 16 Dec 2024 11:04:41 +0000 (UTC)
X-Farcaster-Flow-ID: 7969350a-5549-4a5d-a3ec-42ef915e4c90
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 16 Dec 2024 11:04:41 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 16 Dec 2024 11:04:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Cong Wang <cong.wang@bytedance.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, Xiao Liang <shaw.leon@gmail.com>
Subject: [PATCH v1 net] rtnetlink: Try the outer netns attribute in rtnl_get_peer_net().
Date: Mon, 16 Dec 2024 20:04:32 +0900
Message-ID: <20241216110432.51488-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Xiao Liang reported that the cited commit changed netns handling
in newlink() of netkit, veth, and vxcan.

Before the patch, if we don't find a netns attribute in the peer
device attributes, we tried to find another netns attribute in
the outer netlink attributes by passing it to rtnl_link_get_net().

Let's restore the original behaviour.

Fixes: 48327566769a ("rtnetlink: fix double call of rtnl_link_get_net_ifla()")
Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCORBVVU8P6AHcEkENMj+gD2d3ce9t=A_o48E0yOQp8_wUQ@mail.gmail.com/#t
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ebcfc2debf1a..d9f959c619d9 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3819,6 +3819,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 }
 
 static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
+				     struct nlattr *tbp[],
 				     struct nlattr *data[],
 				     struct netlink_ext_ack *extack)
 {
@@ -3826,7 +3827,7 @@ static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
 	int err;
 
 	if (!data || !data[ops->peer_type])
-		return NULL;
+		return rtnl_link_get_net_ifla(tbp);
 
 	err = rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_type], extack);
 	if (err < 0)
@@ -3971,7 +3972,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 
 		if (ops->peer_type) {
-			peer_net = rtnl_get_peer_net(ops, data, extack);
+			peer_net = rtnl_get_peer_net(ops, tb, data, extack);
 			if (IS_ERR(peer_net)) {
 				ret = PTR_ERR(peer_net);
 				goto put_ops;
-- 
2.39.5 (Apple Git-154)


