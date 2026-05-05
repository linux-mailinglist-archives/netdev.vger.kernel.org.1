Return-Path: <netdev+bounces-284271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMF8ADCx+Wld/AIAu9opvQ
	(envelope-from <netdev+bounces-284271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:58:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 551CF4C9030
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9277303DAB4
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA838C430;
	Tue,  5 May 2026 08:53:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBC82DF138
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971212; cv=none; b=hSxChmdJwcvGO4oFSTk8ldTmr9WQVq15YggqA/fmi+5K9/SU1rrXpC9uWdI5lG8Mg3bpnOLcsYoIUkFL7ZKXGR5hwsWy9JdbxqeMh6GJZwRn97jjq70ZLxPp3vF6U3bctI0Rl1ISqkx/qbQfUV7uVzKOo9H1DZhLJDjcJKixeN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971212; c=relaxed/simple;
	bh=d5I8vqzyHFczPZXouYwzWRXXl+9hXZKXZKhOayo59hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YA3OYVNk/gssY9QJVLwE+lqCrr2G5Nni8E6+CEFRxG/jzlgjGTSHjFzBTKto/gj5Zj2gpHMYWhkbzNGfJof8ZukQ4TvafqjNHUTwLopw9MWwjy0ll6NyfIZVP+kfudG9ISRzCakpeI7343lpakN/EkcmyLhSN6WDoPk47thYTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowADHYIfpr_lpFHVKAA--.39790S3;
	Tue, 05 May 2026 16:53:02 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	ronbogo@outlook.com,
	zylzyl2333@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] xfrm: ipcomp: Free destination pages on acomp errors
Date: Tue,  5 May 2026 16:52:59 +0800
Message-ID: <8c304d9250d947b94cebc1cb1f85c73aa2bf0414.1777923646.git.zylzyl2333@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777923646.git.zylzyl2333@gmail.com>
References: <cover.1777923646.git.zylzyl2333@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowADHYIfpr_lpFHVKAA--.39790S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1ruw1xKryxXryfGrWDCFg_yoW5GF4kpF
	W3G3WqkFyDXF9rGF18tFW8u3W3KrZ2gFW7Gw43Kw1agF43trWFvFZ5tryjgrW8AFy8CF15
	Jr4qyFy7K3yqvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0SCWn5ruQAGQAAsU
X-Rspamd-Queue-Id: 551CF4C9030
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
	TAGGED_FROM(0.00)[bounces-284271-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn,outlook.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.472];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]

From: Yilin Zhu <zylzyl2333@gmail.com>

ipcomp_setup_req() allocates destination pages for the acomp output
scatterlist. On successful completion, ipcomp_post_acomp() attaches the
used pages to the skb and frees any unused pages.

On an acomp error, ipcomp_post_acomp() skips directly to freeing the
request. acomp_request_free() only releases the request itself, so the
caller-allocated destination pages are left allocated.

Track the number of destination pages allocated for the request and free
them on the error path before releasing the request.

Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Peihan Liu <ronbogo@outlook.com>
Signed-off-by: Peihan Liu <ronbogo@outlook.com>
Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/xfrm/xfrm_ipcomp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 5f38dff16177..1e0080300ec7 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -33,6 +33,7 @@ struct ipcomp_data {
 
 struct ipcomp_req_extra {
 	struct xfrm_state *x;
+	int dpages;
 	struct scatterlist sg[];
 };
 
@@ -44,6 +45,12 @@ static inline struct ipcomp_skb_cb *ipcomp_cb(struct sk_buff *skb)
 	return cb;
 }
 
+static void ipcomp_free_dpages(struct scatterlist *dsg, int dpages)
+{
+	while (dpages--)
+		__free_page(sg_page(dsg++));
+}
+
 static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 {
 	struct acomp_req *req = ipcomp_cb(skb)->req;
@@ -51,8 +58,13 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 	struct scatterlist *dsg;
 	int len, dlen;
 
-	if (unlikely(err))
+	if (unlikely(err)) {
+		if (req) {
+			extra = acomp_request_extra(req);
+			ipcomp_free_dpages(extra->sg, extra->dpages);
+		}
 		goto out_free_req;
+	}
 
 	extra = acomp_request_extra(req);
 	dsg = extra->sg;
@@ -167,6 +179,7 @@ static struct acomp_req *ipcomp_setup_req(struct xfrm_state *x,
 
 	extra = acomp_request_extra(req);
 	extra->x = x;
+	extra->dpages = 0;
 
 	dsg = extra->sg;
 	sg = dsg + dnfrags;
@@ -184,6 +197,7 @@ static struct acomp_req *ipcomp_setup_req(struct xfrm_state *x,
 		if (!page)
 			break;
 		sg_set_page(dsg + i, page, PAGE_SIZE, 0);
+		extra->dpages++;
 		total += PAGE_SIZE;
 	}
 	if (!i)
-- 
2.47.3


