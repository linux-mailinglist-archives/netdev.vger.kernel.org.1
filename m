Return-Path: <netdev+bounces-275362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePH1BHf70GlUDAcAu9opvQ
	(envelope-from <netdev+bounces-275362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 13:52:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6555139AFC0
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 13:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 204A43011749
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 11:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD293321C2;
	Sat,  4 Apr 2026 11:52:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96042D5432
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775303539; cv=none; b=rb3QGXnMJ48fMw4QWT0OPeUAqKxl8a0jQVBIThqbEqeUR7xRZuAio14+pHJkIA9HSryQ6zjqqcg0qLYKpYkIYG5CmcqDTJl/wWgfRpUtkJKp5F9p2/Yn0tii0cmj5/sYcTOC9ot4GxCUhgCjbYe/8zqZSt7hQSwNqNcFlKuXyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775303539; c=relaxed/simple;
	bh=HCK2E1Lz4FHwtzy64FBpm7QYgbBQ8bRmQTR0k+ZUD+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDJRQXXICp0NsGuNjcdEwk44WIfH8ofCAuoofJvjhhCVh5k6aLQkzp/AZHJmXmZD0Hcwx7M2kIoC1vG5aS1CwsWYgiG82eeLZhRvUJ5ZS7ZtoVy7RxQbDuAE+3BrWMAXyDOKa+XIW4o6NgViMkTOf93Nt+Mx4bMsqjkaYaedDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from Draw.localdomain (unknown [172.23.146.222])
	by app2 (Coremail) with SMTP id zQmowAAnvoRh+9BppMoxAA--.19647S2;
	Sat, 04 Apr 2026 19:52:01 +0800 (CST)
From: Ao Zhou <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ao Zhou <n05ec@lzu.edu.cn>,
	Haoze Xie <royenheart@gmail.com>
Subject: [PATCH net 1/1] net: l3mdev: Ignore non-L3 uppers in l3mdev_fib_table_rcu
Date: Sat,  4 Apr 2026 19:52:03 +0800
Message-ID: <b3b88cddc7e79d4b43756b26ae5db965678f3ba9.1775062214.git.royenheart@gmail.com>
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
X-CM-TRANSID:zQmowAAnvoRh+9BppMoxAA--.19647S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy7Kr4fAr4DXFyxKw43trb_yoW8Xryfp3
	y3GF97KFWrJryjy348A34xuryDZr1DKFW7G3ykAr43W3ZrA3yUX345K342vFy7J3yjkr43
	Xr12grZ5W3yrur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQIHCWnP4nwGewAAsI
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.992];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-275362-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6555139AFC0
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

Fixes: fee6d4c777a1 ("net: Add netif_is_l3_slave")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
---
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


