Return-Path: <netdev+bounces-281121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DguMsvu7Gn7dgAAu9opvQ
	(envelope-from <netdev+bounces-281121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 18:41:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C8D466F39
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 18:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B74D63006976
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694D430E0F2;
	Sat, 25 Apr 2026 16:41:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFC84A07
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777135304; cv=none; b=tDnHKlWp1edscy98OIfJJy8D4isOZbrJGAROBvmF5CXCDks4BFLFfzIvGGAEZ3o1eAVexR/kt+exxELOo5i8ZyjUnSpniXI5mGIGAOCTNWxYBy3XMhdbZ/33fEWCGxdpm2bjnnohFV3jSpCpBnGXtG52WOgUd3WeJJq5eqjpbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777135304; c=relaxed/simple;
	bh=IyEjCDE7epQ0rtjjw9pg94OGT7uTsHOMvbnm25wia0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGzVwtR5jclvXm8C58n2mYJC4zsu+cUL5wDFIFJ2WCQPZWLZH0r6YCdfjBKs891iYYdLOBkZ3p7qlvaPsAGv+WdDNSwjHb00znxiBqYI87T1LL6iYvvmNTzNfRAPP8Cvtvgim9EpNQEao0/ZQ7DeaVQwaB7l4KW5JZ9KLl7e/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowAAnvoSc7uxppodDAA--.29050S3;
	Sun, 26 Apr 2026 00:41:03 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jbenc@redhat.com,
	e@erig.me,
	yi.y.yang@intel.com,
	pshelar@ovn.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	ldy3087146292@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] openvswitch: reject oversized NSH MD2 metadata in push_nsh
Date: Sun, 26 Apr 2026 00:40:59 +0800
Message-ID: <9d2b5c6127e149ebd35094d662bfd008c20347c2.1777120226.git.ldy3087146292@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776929256.git.ldy3087146292@gmail.com>
References: <cover.1776929256.git.ldy3087146292@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowAAnvoSc7uxppodDAA--.29050S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar18XFWrJw4xWr1kWw4kJFb_yoW8AFyrpa
	y3KF17KrW8Ary7Xr4kAr4IgFW2kFs7GF47Was8AF4I9wnrWr9Fgr4rKFWa9w1v9ayDKFZ8
	ZFW2gr90k3sxA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRMXdjDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0ICWnsf+IDngAAsI
X-Rspamd-Queue-Id: 52C8D466F39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-281121-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,erig.me,intel.com,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]

From: Douya Le <ldy3087146292@gmail.com>

The NSH header length is encoded in 4-byte words in a 6-bit field.
The current push_nsh validation only checks the MD2 payload against
NSH_CTX_HDRS_MAX_LEN, which still allows metadata sizes that cannot be
represented once the base header is included.

Reject MD2 metadata lengths whose total NSH header size cannot be
encoded exactly in the NSH length field, whether because the field
would wrap or because the length is not a multiple of 4 bytes.

Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Douya Le <ldy3087146292@gmail.com>
Signed-off-by: Douya Le <ldy3087146292@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/openvswitch/flow_netlink.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 13052408a132..8a1ae5309c2c 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -1432,7 +1432,13 @@ static int nsh_key_put_from_nlattr(const struct nlattr *attr,
 
 			has_md2 = true;
 			mdlen = nla_len(a);
-			if (mdlen > NSH_CTX_HDRS_MAX_LEN || mdlen <= 0) {
+			/* The NSH length field stores the total header size
+			 * in 4-byte words in 6 bits. Reject MD2 metadata
+			 * lengths that cannot be encoded exactly or would
+			 * make the length field wrap.
+			 */
+			if (mdlen <= 0 || !IS_ALIGNED(mdlen, 4) ||
+			    NSH_BASE_HDR_LEN + mdlen > (NSH_LEN_MASK << 2)) {
 				OVS_NLERR(
 				    log,
 				    "Invalid MD length %d for MD type %d",
-- 
2.43.0


