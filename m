Return-Path: <netdev+bounces-275593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFbDCxy102nLkgcAu9opvQ
	(envelope-from <netdev+bounces-275593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:29:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD543A3899
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2417301372D
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30B0333725;
	Mon,  6 Apr 2026 13:28:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83B30C63A
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482116; cv=none; b=jU88R/kuNTLixolkltQTQDSEJKdqB1IZ93JiUUS6OczzdY0WsJEGfM8w4JTYtWq+I5WSNjClMNgAlhbKYJQI/ArFMMJvOWSRYutpuHru/OZS5dvsR77MJeeo2fWKcq2dlD4JVu5LvFDEmkjsnPl+l5MCCXwgW/lZ0iJsVE/rmA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482116; c=relaxed/simple;
	bh=YFl+3yr7JynCxJYawGnSTFCIJT3YeqX7qPlqbJs1yVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIWjVm2hyJcNGujW5XPMXDPTLB7yOHrobTfIuKz1Mn687yjLZ2Y3lusn+ipn8XfE6sFDItM13h/+HJAxbODNxUyXoG4WkUrZbc75Gb6Bmm7NltY/aVL0jDnuV47CXE/dV1AiZKI9cSMdtqHbVgOD6PGmRUlti4nAdO0DrgjzBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from Draw.localdomain (unknown [27.227.216.52])
	by app1 (Coremail) with SMTP id ygmowACXB_jwtNNpxr6rAA--.3337S2;
	Mon, 06 Apr 2026 21:28:16 +0800 (CST)
From: Ao Zhou <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@mellanox.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ao Zhou <n05ec@lzu.edu.cn>,
	Haoze Xie <royenheart@gmail.com>
Subject: [PATCH net v2 1/1] net: l3mdev: Ignore non-L3 uppers in l3mdev_fib_table_rcu
Date: Mon,  6 Apr 2026 21:28:16 +0800
Message-ID: <429dd4a81d4ca5624ab9f6d7b53c5fe08552c734.1775443332.git.royenheart@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775062214.git.royenheart@gmail.com>
References: <cover.1775062214.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACXB_jwtNNpxr6rAA--.3337S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy7ZFWxCryfZw17XrW3trb_yoW8Ww4rp3
	y3GF97KFW8XryUA348J34xuryDZr4DK347G3yvyr47W3WDA347X345ta4avFy7JayFkF43
	JF12ga9Yg3s5urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB21xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1s
	IEY20_GrWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe38nUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQMJCWnShX0IAgAAsL
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275593-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,resnulli.us,gmail.com,lzu.edu.cn];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 9CD543A3899
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haoze Xie <royenheart@gmail.com>

l3mdev_fib_table_rcu() assumes that any upper device observed for
an IFF_L3MDEV_SLAVE device is an L3 master and dereferences
master->l3mdev_ops unconditionally.

VRF slave setup sets IFF_L3MDEV_SLAVE before the upper link is fully
switched, so readers can transiently observe a non-L3 upper such as a
bridge and follow a NULL l3mdev_ops pointer. Require the current upper
to still be an L3 master before consulting its FIB table.

Fixes: fdeea7be88b1 ("net: vrf: Set slave's private flag before linking")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
---
changes in v2:
- point Fixes to the VRF slave ordering change identified by David Ahern
- add David Ahern's Reviewed-by trailer

 net/l3mdev/l3mdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


