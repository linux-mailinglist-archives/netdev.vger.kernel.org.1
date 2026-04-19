Return-Path: <netdev+bounces-279597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1fFjMrXt5GltcAEAu9opvQ
	(envelope-from <netdev+bounces-279597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:59:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DA74246B9
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21C4430028FF
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB9933DEF9;
	Sun, 19 Apr 2026 14:58:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AF315B0EC
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776610735; cv=none; b=DsM40LPcLFoWClPuHuMgfohH/PIIuvDSWY3hnWiRYT74tTNyh2GyThFIHZ8FdB4RBnv6gavaOW47EEy683YjCda3zAiDbpI6zuysj0bAR/llLrFggUOwRJYv24PFQgiVvZZdIxeGmJqCIkohBIQSeo5HB5E8QdTLKHR22ebEdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776610735; c=relaxed/simple;
	bh=hnlFzATkkgCC02qpd+UPA+Wp8tCFSdfpfbR4i+Hd7hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvVdia6X1mXgsS50tDHO/HLiKMTJXE2y8sJVKHyqYXkFb/+BvGijTxUwngGyMc9UzcA3XIWlvcgGcMBM/S68ix/3sUA4cUmpGYJZod+Y/PzzvZA4yjV5zgMw3GPZ6o0J8rSL8L4idoRu2skg4rBAiIW/mcpacbQ/6hxHv31Wh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACXDwCX7eRpcI3UAA--.14510S2;
	Sun, 19 Apr 2026 22:58:31 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	idosch@mellanox.com
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	royenheart@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v3 1/1] net: l3mdev: Reject non-L3 uppers in slave helpers
Date: Sun, 19 Apr 2026 22:53:32 +0800
Message-ID: <20260419145332.3988923-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACXDwCX7eRpcI3UAA--.14510S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryktw4xKF4fCryxGw18AFb_yoWrGr15pa
	y7Ca4fKF48Gry7A348A3W7uFyqkrs5Kry7CayrJr45WFWDAr1DXryft3yjvFy7J39YkF13
	Xr129390g345ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQECCWnkluADMgAMsN
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-279597-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[lzu.edu.cn:server fail,sin.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,resnulli.us,gmail.com,lzu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:mid,lzu.edu.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87DA74246B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haoze Xie <royenheart@gmail.com>

Several l3mdev slave-side helpers resolve an upper device and then use
l3mdev_ops without first proving that the resolved device is still a
valid L3 master.

During slave transition, an RCU reader can transiently observe an upper
that is not an L3 master. Guard the affected slave-resolved paths by
requiring the resolved upper to still be an L3 master before using
l3mdev_ops, while keeping existing L3 RX handler providers intact.

Fixes: fdeea7be88b1 ("net: vrf: Set slave's private flag before linking")
Cc: stable@kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
---
Changes in v3:
- Extend the same guard to l3mdev_l3_rcv() and l3mdev_l3_out().
- Keep existing IFF_L3MDEV_RX_HANDLER providers such as ipvlan_l3s
  working by only applying the extra master check to the slave-resolved
  upper case in l3mdev_l3_rcv().
- v2 Link:
  https://lore.kernel.org/all/429dd4a81d4ca5624ab9f6d7b53c5fe08552c734.1775443332.git.royenheart@gmail.com/

Changes in v2:
- Point Fixes to the VRF slave ordering change identified in review.
- Add David Ahern's Reviewed-by trailer in that revision.
- v1 Link:
  https://lore.kernel.org/all/b3b88cddc7e79d4b43756b26ae5db965678f3ba9.1775062214.git.royenheart@gmail.com/

 include/net/l3mdev.h | 18 +++++++++++-------
 net/l3mdev/l3mdev.c  |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/net/l3mdev.h b/include/net/l3mdev.h
index 710e98665eb3..aed52bf03956 100644
--- a/include/net/l3mdev.h
+++ b/include/net/l3mdev.h
@@ -180,14 +180,17 @@ struct sk_buff *l3mdev_l3_rcv(struct sk_buff *skb, u16 proto)
 {
 	struct net_device *master = NULL;
 
-	if (netif_is_l3_slave(skb->dev))
+	if (netif_is_l3_slave(skb->dev)) {
 		master = netdev_master_upper_dev_get_rcu(skb->dev);
-	else if (netif_is_l3_master(skb->dev) ||
-		 netif_has_l3_rx_handler(skb->dev))
+		if (master && netif_is_l3_master(master) &&
+		    master->l3mdev_ops->l3mdev_l3_rcv)
+			skb = master->l3mdev_ops->l3mdev_l3_rcv(master, skb, proto);
+	} else if (netif_is_l3_master(skb->dev) ||
+		   netif_has_l3_rx_handler(skb->dev)) {
 		master = skb->dev;
-
-	if (master && master->l3mdev_ops->l3mdev_l3_rcv)
-		skb = master->l3mdev_ops->l3mdev_l3_rcv(master, skb, proto);
+		if (master->l3mdev_ops->l3mdev_l3_rcv)
+			skb = master->l3mdev_ops->l3mdev_l3_rcv(master, skb, proto);
+	}
 
 	return skb;
 }
@@ -215,7 +218,8 @@ struct sk_buff *l3mdev_l3_out(struct sock *sk, struct sk_buff *skb, u16 proto)
 		struct net_device *master;
 
 		master = netdev_master_upper_dev_get_rcu(dev);
-		if (master && master->l3mdev_ops->l3mdev_l3_out)
+		if (master && netif_is_l3_master(master) &&
+		    master->l3mdev_ops->l3mdev_l3_out)
 			skb = master->l3mdev_ops->l3mdev_l3_out(master, sk,
 								skb, proto);
 	}
diff --git a/net/l3mdev/l3mdev.c b/net/l3mdev/l3mdev.c
index 5432a5f2dfc8..b8a3030cb2c4 100644
--- a/net/l3mdev/l3mdev.c
+++ b/net/l3mdev/l3mdev.c
@@ -177,7 +177,7 @@ u32 l3mdev_fib_table_rcu(const struct net_device *dev)
 		const struct net_device *master;
 
 		master = netdev_master_upper_dev_get_rcu(_dev);
-		if (master &&
+		if (master && netif_is_l3_master(master) &&
 		    master->l3mdev_ops->l3mdev_fib_table)
 			tb_id = master->l3mdev_ops->l3mdev_fib_table(master);
 	}
-- 
2.53.0


