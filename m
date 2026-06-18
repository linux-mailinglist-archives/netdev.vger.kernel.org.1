Return-Path: <netdev+bounces-300495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AmNhC1IfNGprPAYAu9opvQ
	(envelope-from <netdev+bounces-300495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:39:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D356A1A3B
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:39:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300495-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300495-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B284C308D953
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F101F3115B8;
	Thu, 18 Jun 2026 16:37:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036975A79B
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 16:36:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800620; cv=none; b=GBaS9+LSaYWXY3QoNttLVv76RTlE+q1bxE9Q3TEog/mOrtUp19MdWRkX8FCRiY5wiJYjUAXLS2dFy7yIuvjhVrxPqvldTEU626/b01GWFrE5Luo/Or+DkMjXUpK8UrghBoxTqvOPv7RovVjc2+ucSpNKyvzHlwC1p5vTmsppHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800620; c=relaxed/simple;
	bh=OX691bkwgSszjQe7pCxB1q7+f79cAw6Oj63jnS2/yOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyFljWsTUjxRVZC3qnIkgPTJjlzYB/Fsbq4x3m7jUm/IDtFsoMrHvYEphnWie+KaExy1zgu/Cqxn22BU/CUEqi/NDvqnZzghpVqhWwITJB5wpLGHGLSHNkKgub+7en6gDrq6dMjR40l8bRzCSNmJwEvQzETyU+2wnlLhGZ2l7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.161.220
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAD3E76YHjRqGNqUAA--.62477S3;
	Fri, 19 Jun 2026 00:36:44 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	eyal.birger@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	qianyuluo3@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH 1/1] xfrm: nat_keepalive: avoid double free on send error
Date: Fri, 19 Jun 2026 00:36:35 +0800
Message-ID: <46eb334399ce0e25e0897b42f21020541d159300.1781788385.git.qianyuluo3@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1781788385.git.qianyuluo3@gmail.com>
References: <cover.1781788385.git.qianyuluo3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAD3E76YHjRqGNqUAA--.62477S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4rWF1fXF18XFW7Aw4DCFg_yoW5Gr4fpF
	WUGr9xArZY93s0qr4DJr95Xr15Gr48KrWagF9xGw4Iyrs8Kr1UGF4jkw4aqrn5XF4S9w1Y
	qr4DtryqyF1DJFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svP
	MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQACCWozqlMJUwAAsw
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-300495-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:eyal.birger@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:qianyuluo3@gmail.com,m:n05ec@lzu.edu.cn,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,gmail.com,lzu.edu.cn];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lzu.edu.cn:from_mime,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77D356A1A3B

From: Qianyu Luo <qianyuluo3@gmail.com>

nat_keepalive_send() frees the keepalive skb whenever the IPv4 or IPv6
send helper reports an error.

That cleanup is only correct before the skb is handed to the output
path. Once ip_build_and_send_pkt() or ip6_xmit() takes ownership, the
networking stack may already have consumed the skb before returning an
error, so freeing it again is unsafe.

Handle the pre-handoff failure cases inside nat_keepalive_send_ipv4()
and nat_keepalive_send_ipv6(), where the caller still owns the skb, and
keep nat_keepalive_send() responsible only for family dispatch and the
unsupported-family cleanup path.

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Qianyu Luo <qianyuluo3@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/xfrm/xfrm_nat_keepalive.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index 458931062a04..f71328096f11 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -55,8 +55,10 @@ static int nat_keepalive_send_ipv4(struct sk_buff *skb,
 			   ka->encap_sport, sock_net_uid(net, NULL));
 
 	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt))
+	if (IS_ERR(rt)) {
+		kfree_skb(skb);
 		return PTR_ERR(rt);
+	}
 
 	skb_dst_set(skb, &rt->dst);
 
@@ -100,6 +102,7 @@ static int nat_keepalive_send_ipv6(struct sk_buff *skb,
 	sock_net_set(sk, net);
 	dst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
 	if (IS_ERR(dst)) {
+		kfree_skb(skb);
 		local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
 		return PTR_ERR(dst);
 	}
@@ -118,7 +121,6 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 					sizeof(struct ipv6hdr)) +
 				    sizeof(struct udphdr);
 	const u8 nat_ka_payload = 0xFF;
-	int err = -EAFNOSUPPORT;
 	struct sk_buff *skb;
 	struct udphdr *uh;
 
@@ -140,16 +142,17 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 
 	switch (ka->family) {
 	case AF_INET:
-		err = nat_keepalive_send_ipv4(skb, ka);
+		nat_keepalive_send_ipv4(skb, ka);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		err = nat_keepalive_send_ipv6(skb, ka, uh);
+		nat_keepalive_send_ipv6(skb, ka, uh);
 		break;
 #endif
-	}
-	if (err)
+	default:
 		kfree_skb(skb);
+		break;
+	}
 }
 
 struct nat_keepalive_work_ctx {
-- 
2.43.7


