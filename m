Return-Path: <netdev+bounces-175050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684BEA62B1A
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 11:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2179217DE0F
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5721FCD05;
	Sat, 15 Mar 2025 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Cic1ISm4"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618CD1FCCFA;
	Sat, 15 Mar 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742034672; cv=none; b=saZs+CXO2wGVca5jQctPHQ+hwaqjjt5Q+r4YVQlcd6AaV6IYSe2HiAgyx68JCXXAZ5YILMSHR+JvQSdw7RSVy86rfQZdzdth2I0t9I2pIzXgpBbGEygK+YRxInpetLaENbClo2eBYkKFtCWxvyuPdMByFHZv4RkcyK78GOIPThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742034672; c=relaxed/simple;
	bh=hq9s5srdFnc7QPUqhIHVUUHJEZhYYSCI546yWpXdPmc=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To:Cc; b=m+GY+1h4W8ibwpA/xQ2OslA+bPW/hCrTa0bZ740ufGGlIbi8l/i36Gkdp+/iGUr/pBJEsyCPac3rMpYA9/OAP+ZLNXGBKxI8dPgGsHW7FqW9w/gvhSl6cEXRwJoXV1O4LPmuUjXqL4uDiywL4B6cdCUyM9FK+mgjmR8Ps+U1aQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Cic1ISm4; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:References:In-Reply-To:Message-Id:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=12bTNIQ4qp+uVHm6mMioQ6QX+bgSJ+0cLz4U2S0lsro=; b=Cic1ISm4Pvy+d2++vo5igMEH+V
	ek5WJT1y42q5jWRIL9IAUC6iglIufBqT0TcjUUMBeGDjuqqv+rzDqCCcYlSM9H9D7C/lVrQB1y9k7
	qvv70LOsdtCpZ6gFBuKhITVJ5CoQ942MFFUq5YY6MdhfXqECm0y1gQ/J7x6gxCsEWrTz3p2nss4LM
	WSiLZ995upA8kJfcxzt3xVE0QPGK/Y+GF6NyftoagTmUCC0gOUybXs8bTgpGylTLOxfkQy8XNjDTc
	85BoW8qDmR5coG8Azf9Z8Cxfh+Wd0HJ8Hf8g1Vg+bJP0NaDRV9G9c5zL9urqhLTTReyReJsQ6CbuP
	RCUWeOvw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttOmx-006pCO-0h;
	Sat, 15 Mar 2025 18:30:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 18:30:43 +0800
Date: Sat, 15 Mar 2025 18:30:43 +0800
Message-Id: <d7bccafdf38259c2b820be79763f66bfaad1497e.1742034499.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1742034499.git.herbert@gondor.apana.org.au>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 11/14] xfrm: ipcomp: Use crypto_acomp interface
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Replace the legacy comperssion interface with the new acomp
interface.  This is the first user to make full user of the
asynchronous nature of acomp by plugging into the existing xfrm
resume interface.

As a result of SG support by acomp, the linear scratch buffer
in ipcomp can be removed.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/net/ipcomp.h   |  13 +-
 net/xfrm/xfrm_algo.c   |   7 +-
 net/xfrm/xfrm_ipcomp.c | 477 ++++++++++++++++++++---------------------
 3 files changed, 236 insertions(+), 261 deletions(-)

diff --git a/include/net/ipcomp.h b/include/net/ipcomp.h
index 8660a2a6d1fc..51401f01e2a5 100644
--- a/include/net/ipcomp.h
+++ b/include/net/ipcomp.h
@@ -3,20 +3,9 @@
 #define _NET_IPCOMP_H
 
 #include <linux/skbuff.h>
-#include <linux/types.h>
-
-#define IPCOMP_SCRATCH_SIZE     65400
-
-struct crypto_comp;
-struct ip_comp_hdr;
-
-struct ipcomp_data {
-	u16 threshold;
-	struct crypto_comp * __percpu *tfms;
-};
 
 struct ip_comp_hdr;
-struct sk_buff;
+struct netlink_ext_ack;
 struct xfrm_state;
 
 int ipcomp_input(struct xfrm_state *x, struct sk_buff *skb);
diff --git a/net/xfrm/xfrm_algo.c b/net/xfrm/xfrm_algo.c
index e6da7e8495c9..749011e031c0 100644
--- a/net/xfrm/xfrm_algo.c
+++ b/net/xfrm/xfrm_algo.c
@@ -5,13 +5,13 @@
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
  */
 
+#include <crypto/acompress.h>
 #include <crypto/aead.h>
 #include <crypto/hash.h>
 #include <crypto/skcipher.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/pfkeyv2.h>
-#include <linux/crypto.h>
 #include <linux/scatterlist.h>
 #include <net/xfrm.h>
 #if IS_ENABLED(CONFIG_INET_ESP) || IS_ENABLED(CONFIG_INET6_ESP)
@@ -669,7 +669,7 @@ static const struct xfrm_algo_list xfrm_ealg_list = {
 };
 
 static const struct xfrm_algo_list xfrm_calg_list = {
-	.find = crypto_has_comp,
+	.find = crypto_has_acomp,
 	.algs = calg_list,
 	.entries = ARRAY_SIZE(calg_list),
 };
@@ -828,8 +828,7 @@ void xfrm_probe_algs(void)
 	}
 
 	for (i = 0; i < calg_entries(); i++) {
-		status = crypto_has_comp(calg_list[i].name, 0,
-					 CRYPTO_ALG_ASYNC);
+		status = crypto_has_acomp(calg_list[i].name, 0, 0);
 		if (calg_list[i].available != status)
 			calg_list[i].available = status;
 	}
diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 43eae94e4b0e..a5246227951f 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -3,7 +3,7 @@
  * IP Payload Compression Protocol (IPComp) - RFC3173.
  *
  * Copyright (c) 2003 James Morris <jmorris@intercode.com.au>
- * Copyright (c) 2003-2008 Herbert Xu <herbert@gondor.apana.org.au>
+ * Copyright (c) 2003-2025 Herbert Xu <herbert@gondor.apana.org.au>
  *
  * Todo:
  *   - Tunable compression parameters.
@@ -11,169 +11,240 @@
  *   - Adaptive compression.
  */
 
-#include <linux/crypto.h>
+#include <crypto/acompress.h>
 #include <linux/err.h>
-#include <linux/list.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/percpu.h>
+#include <linux/skbuff_ref.h>
 #include <linux/slab.h>
-#include <linux/smp.h>
-#include <linux/vmalloc.h>
-#include <net/ip.h>
 #include <net/ipcomp.h>
 #include <net/xfrm.h>
 
-struct ipcomp_tfms {
-	struct list_head list;
-	struct crypto_comp * __percpu *tfms;
-	int users;
+#define IPCOMP_SCRATCH_SIZE 65400
+
+struct ipcomp_skb_cb {
+	struct xfrm_skb_cb xfrm;
+	struct acomp_req *req;
 };
 
-static DEFINE_MUTEX(ipcomp_resource_mutex);
-static void * __percpu *ipcomp_scratches;
-static int ipcomp_scratch_users;
-static LIST_HEAD(ipcomp_tfms_list);
+struct ipcomp_data {
+	u16 threshold;
+	struct crypto_acomp *tfm;
+};
 
-static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
+struct ipcomp_req_extra {
+	struct xfrm_state *x;
+	struct scatterlist sg[];
+};
+
+static inline struct ipcomp_skb_cb *ipcomp_cb(struct sk_buff *skb)
 {
-	struct ipcomp_data *ipcd = x->data;
-	const int plen = skb->len;
-	int dlen = IPCOMP_SCRATCH_SIZE;
-	const u8 *start = skb->data;
-	u8 *scratch = *this_cpu_ptr(ipcomp_scratches);
-	struct crypto_comp *tfm = *this_cpu_ptr(ipcd->tfms);
-	int err = crypto_comp_decompress(tfm, start, plen, scratch, &dlen);
-	int len;
+	struct ipcomp_skb_cb *cb = (void *)skb->cb;
 
-	if (err)
-		return err;
+	BUILD_BUG_ON(sizeof(*cb) > sizeof(skb->cb));
+	return cb;
+}
 
-	if (dlen < (plen + sizeof(struct ip_comp_hdr)))
-		return -EINVAL;
+static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
+{
+	struct acomp_req *req = ipcomp_cb(skb)->req;
+	struct ipcomp_req_extra *extra;
+	const int plen = skb->data_len;
+	struct scatterlist *dsg;
+	int len, dlen;
 
-	len = dlen - plen;
-	if (len > skb_tailroom(skb))
-		len = skb_tailroom(skb);
+	if (unlikely(err))
+		goto out_free_req;
 
-	__skb_put(skb, len);
+	extra = acomp_request_extra(req);
+	dsg = extra->sg;
+	dlen = req->dlen;
 
-	len += plen;
-	skb_copy_to_linear_data(skb, scratch, len);
+	pskb_trim_unique(skb, 0);
+	__skb_put(skb, hlen);
 
-	while ((scratch += len, dlen -= len) > 0) {
+	/* Only update truesize on input. */
+	if (!hlen)
+		skb->truesize += dlen - plen;
+	skb->data_len = dlen;
+	skb->len += dlen;
+
+	do {
 		skb_frag_t *frag;
 		struct page *page;
 
-		if (WARN_ON(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS))
-			return -EMSGSIZE;
-
 		frag = skb_shinfo(skb)->frags + skb_shinfo(skb)->nr_frags;
-		page = alloc_page(GFP_ATOMIC);
-
-		if (!page)
-			return -ENOMEM;
+		page = sg_page(dsg);
+		dsg = sg_next(dsg);
 
 		len = PAGE_SIZE;
 		if (dlen < len)
 			len = dlen;
 
 		skb_frag_fill_page_desc(frag, page, 0, len);
-		memcpy(skb_frag_address(frag), scratch, len);
-
-		skb->truesize += len;
-		skb->data_len += len;
-		skb->len += len;
 
 		skb_shinfo(skb)->nr_frags++;
-	}
+	} while ((dlen -= len));
 
-	return 0;
+	for (; dsg; dsg = sg_next(dsg))
+		__free_page(sg_page(dsg));
+
+out_free_req:
+	acomp_request_free(req);
+	return err;
+}
+
+static int ipcomp_input_done2(struct sk_buff *skb, int err)
+{
+	struct ip_comp_hdr *ipch = ip_comp_hdr(skb);
+	const int plen = skb->len;
+
+	skb_reset_transport_header(skb);
+
+	return ipcomp_post_acomp(skb, err, 0) ?:
+	       skb->len < (plen + sizeof(ip_comp_hdr)) ? -EINVAL :
+	       ipch->nexthdr;
+}
+
+static void ipcomp_input_done(void *data, int err)
+{
+	struct sk_buff *skb = data;
+
+	xfrm_input_resume(skb, ipcomp_input_done2(skb, err));
+}
+
+static struct acomp_req *ipcomp_setup_req(struct xfrm_state *x,
+					  struct sk_buff *skb, int minhead,
+					  int dlen)
+{
+	const int dnfrags = min(MAX_SKB_FRAGS, 16);
+	struct ipcomp_data *ipcd = x->data;
+	struct ipcomp_req_extra *extra;
+	struct scatterlist *sg, *dsg;
+	const int plen = skb->len;
+	struct crypto_acomp *tfm;
+	struct acomp_req *req;
+	int nfrags;
+	int total;
+	int err;
+	int i;
+
+	ipcomp_cb(skb)->req = NULL;
+
+	do {
+		struct sk_buff *trailer;
+
+		if (skb->len > PAGE_SIZE) {
+			if (skb_linearize_cow(skb))
+				return ERR_PTR(-ENOMEM);
+			nfrags = 1;
+			break;
+		}
+
+		if (!skb_cloned(skb) && skb_headlen(skb) >= minhead) {
+			if (!skb_is_nonlinear(skb)) {
+				nfrags = 1;
+				break;
+			} else if (!skb_has_frag_list(skb)) {
+				nfrags = skb_shinfo(skb)->nr_frags;
+				nfrags++;
+				break;
+			}
+		}
+
+		nfrags = skb_cow_data(skb, skb_headlen(skb) < minhead ?
+					   minhead - skb_headlen(skb) : 0,
+				      &trailer);
+		if (nfrags < 0)
+			return ERR_PTR(nfrags);
+	} while (0);
+
+	tfm = ipcd->tfm;
+	req = acomp_request_alloc_extra(
+		tfm, sizeof(*extra) + sizeof(*sg) * (nfrags + dnfrags),
+		GFP_ATOMIC);
+	ipcomp_cb(skb)->req = req;
+	if (!req)
+		return ERR_PTR(-ENOMEM);
+
+	extra = acomp_request_extra(req);
+	extra->x = x;
+
+	dsg = extra->sg;
+	sg = dsg + dnfrags;
+	sg_init_table(sg, nfrags);
+	err = skb_to_sgvec(skb, sg, 0, plen);
+	if (unlikely(err < 0))
+		return ERR_PTR(err);
+
+	sg_init_table(dsg, dnfrags);
+	total = 0;
+	for (i = 0; i < dnfrags && total < dlen; i++) {
+		struct page *page;
+
+		page = alloc_page(GFP_ATOMIC);
+		if (!page)
+			break;
+		sg_set_page(dsg + i, page, PAGE_SIZE, 0);
+		total += PAGE_SIZE;
+	}
+	if (!i)
+		return ERR_PTR(-ENOMEM);
+	sg_mark_end(dsg + i - 1);
+
+	acomp_request_set_params(req, sg, dsg, plen, dlen);
+
+	return req;
+}
+
+static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
+{
+	struct acomp_req *req;
+	int err;
+
+	req = ipcomp_setup_req(x, skb, 0, IPCOMP_SCRATCH_SIZE);
+	err = PTR_ERR(req);
+	if (IS_ERR(req))
+		goto out;
+
+	acomp_request_set_callback(req, 0, ipcomp_input_done, skb);
+	err = crypto_acomp_decompress(req);
+	if (err == -EINPROGRESS)
+		return err;
+
+out:
+	return ipcomp_input_done2(skb, err);
 }
 
 int ipcomp_input(struct xfrm_state *x, struct sk_buff *skb)
 {
-	int nexthdr;
-	int err = -ENOMEM;
-	struct ip_comp_hdr *ipch;
+	struct ip_comp_hdr *ipch __maybe_unused;
 
 	if (!pskb_may_pull(skb, sizeof(*ipch)))
 		return -EINVAL;
 
-	if (skb_linearize_cow(skb))
-		goto out;
-
 	skb->ip_summed = CHECKSUM_NONE;
 
 	/* Remove ipcomp header and decompress original payload */
-	ipch = (void *)skb->data;
-	nexthdr = ipch->nexthdr;
-
-	skb->transport_header = skb->network_header + sizeof(*ipch);
 	__skb_pull(skb, sizeof(*ipch));
-	err = ipcomp_decompress(x, skb);
-	if (err)
-		goto out;
 
-	err = nexthdr;
-
-out:
-	return err;
+	return ipcomp_decompress(x, skb);
 }
 EXPORT_SYMBOL_GPL(ipcomp_input);
 
-static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
+static int ipcomp_output_push(struct sk_buff *skb)
 {
-	struct ipcomp_data *ipcd = x->data;
-	const int plen = skb->len;
-	int dlen = IPCOMP_SCRATCH_SIZE;
-	u8 *start = skb->data;
-	struct crypto_comp *tfm;
-	u8 *scratch;
-	int err;
-
-	local_bh_disable();
-	scratch = *this_cpu_ptr(ipcomp_scratches);
-	tfm = *this_cpu_ptr(ipcd->tfms);
-	err = crypto_comp_compress(tfm, start, plen, scratch, &dlen);
-	if (err)
-		goto out;
-
-	if ((dlen + sizeof(struct ip_comp_hdr)) >= plen) {
-		err = -EMSGSIZE;
-		goto out;
-	}
-
-	memcpy(start + sizeof(struct ip_comp_hdr), scratch, dlen);
-	local_bh_enable();
-
-	pskb_trim(skb, dlen + sizeof(struct ip_comp_hdr));
+	skb_push(skb, -skb_network_offset(skb));
 	return 0;
-
-out:
-	local_bh_enable();
-	return err;
 }
 
-int ipcomp_output(struct xfrm_state *x, struct sk_buff *skb)
+static int ipcomp_output_done2(struct xfrm_state *x, struct sk_buff *skb,
+			       int err)
 {
-	int err;
 	struct ip_comp_hdr *ipch;
-	struct ipcomp_data *ipcd = x->data;
 
-	if (skb->len < ipcd->threshold) {
-		/* Don't bother compressing */
+	err = ipcomp_post_acomp(skb, err, sizeof(*ipch));
+	if (err)
 		goto out_ok;
-	}
-
-	if (skb_linearize_cow(skb))
-		goto out_ok;
-
-	err = ipcomp_compress(x, skb);
-
-	if (err) {
-		goto out_ok;
-	}
 
 	/* Install ipcomp header, convert into ipcomp datagram. */
 	ipch = ip_comp_hdr(skb);
@@ -182,135 +253,59 @@ int ipcomp_output(struct xfrm_state *x, struct sk_buff *skb)
 	ipch->cpi = htons((u16 )ntohl(x->id.spi));
 	*skb_mac_header(skb) = IPPROTO_COMP;
 out_ok:
-	skb_push(skb, -skb_network_offset(skb));
-	return 0;
+	return ipcomp_output_push(skb);
+}
+
+static void ipcomp_output_done(void *data, int err)
+{
+	struct ipcomp_req_extra *extra;
+	struct sk_buff *skb = data;
+	struct acomp_req *req;
+
+	req = ipcomp_cb(skb)->req;
+	extra = acomp_request_extra(req);
+
+	xfrm_output_resume(skb_to_full_sk(skb), skb,
+			   ipcomp_output_done2(extra->x, skb, err));
+}
+
+static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
+{
+	struct ip_comp_hdr *ipch __maybe_unused;
+	struct acomp_req *req;
+	int err;
+
+	req = ipcomp_setup_req(x, skb, sizeof(*ipch),
+			       skb->len - sizeof(*ipch));
+	err = PTR_ERR(req);
+	if (IS_ERR(req))
+		goto out;
+
+	acomp_request_set_callback(req, 0, ipcomp_output_done, skb);
+	err = crypto_acomp_compress(req);
+	if (err == -EINPROGRESS)
+		return err;
+
+out:
+	return ipcomp_output_done2(x, skb, err);
+}
+
+int ipcomp_output(struct xfrm_state *x, struct sk_buff *skb)
+{
+	struct ipcomp_data *ipcd = x->data;
+
+	if (skb->len < ipcd->threshold) {
+		/* Don't bother compressing */
+		return ipcomp_output_push(skb);
+	}
+
+	return ipcomp_compress(x, skb);
 }
 EXPORT_SYMBOL_GPL(ipcomp_output);
 
-static void ipcomp_free_scratches(void)
-{
-	int i;
-	void * __percpu *scratches;
-
-	if (--ipcomp_scratch_users)
-		return;
-
-	scratches = ipcomp_scratches;
-	if (!scratches)
-		return;
-
-	for_each_possible_cpu(i)
-		vfree(*per_cpu_ptr(scratches, i));
-
-	free_percpu(scratches);
-	ipcomp_scratches = NULL;
-}
-
-static void * __percpu *ipcomp_alloc_scratches(void)
-{
-	void * __percpu *scratches;
-	int i;
-
-	if (ipcomp_scratch_users++)
-		return ipcomp_scratches;
-
-	scratches = alloc_percpu(void *);
-	if (!scratches)
-		return NULL;
-
-	ipcomp_scratches = scratches;
-
-	for_each_possible_cpu(i) {
-		void *scratch;
-
-		scratch = vmalloc_node(IPCOMP_SCRATCH_SIZE, cpu_to_node(i));
-		if (!scratch)
-			return NULL;
-		*per_cpu_ptr(scratches, i) = scratch;
-	}
-
-	return scratches;
-}
-
-static void ipcomp_free_tfms(struct crypto_comp * __percpu *tfms)
-{
-	struct ipcomp_tfms *pos;
-	int cpu;
-
-	list_for_each_entry(pos, &ipcomp_tfms_list, list) {
-		if (pos->tfms == tfms)
-			break;
-	}
-
-	WARN_ON(list_entry_is_head(pos, &ipcomp_tfms_list, list));
-
-	if (--pos->users)
-		return;
-
-	list_del(&pos->list);
-	kfree(pos);
-
-	if (!tfms)
-		return;
-
-	for_each_possible_cpu(cpu) {
-		struct crypto_comp *tfm = *per_cpu_ptr(tfms, cpu);
-		crypto_free_comp(tfm);
-	}
-	free_percpu(tfms);
-}
-
-static struct crypto_comp * __percpu *ipcomp_alloc_tfms(const char *alg_name)
-{
-	struct ipcomp_tfms *pos;
-	struct crypto_comp * __percpu *tfms;
-	int cpu;
-
-
-	list_for_each_entry(pos, &ipcomp_tfms_list, list) {
-		struct crypto_comp *tfm;
-
-		/* This can be any valid CPU ID so we don't need locking. */
-		tfm = this_cpu_read(*pos->tfms);
-
-		if (!strcmp(crypto_comp_name(tfm), alg_name)) {
-			pos->users++;
-			return pos->tfms;
-		}
-	}
-
-	pos = kmalloc(sizeof(*pos), GFP_KERNEL);
-	if (!pos)
-		return NULL;
-
-	pos->users = 1;
-	INIT_LIST_HEAD(&pos->list);
-	list_add(&pos->list, &ipcomp_tfms_list);
-
-	pos->tfms = tfms = alloc_percpu(struct crypto_comp *);
-	if (!tfms)
-		goto error;
-
-	for_each_possible_cpu(cpu) {
-		struct crypto_comp *tfm = crypto_alloc_comp(alg_name, 0,
-							    CRYPTO_ALG_ASYNC);
-		if (IS_ERR(tfm))
-			goto error;
-		*per_cpu_ptr(tfms, cpu) = tfm;
-	}
-
-	return tfms;
-
-error:
-	ipcomp_free_tfms(tfms);
-	return NULL;
-}
-
 static void ipcomp_free_data(struct ipcomp_data *ipcd)
 {
-	if (ipcd->tfms)
-		ipcomp_free_tfms(ipcd->tfms);
-	ipcomp_free_scratches();
+	crypto_free_acomp(ipcd->tfm);
 }
 
 void ipcomp_destroy(struct xfrm_state *x)
@@ -319,9 +314,7 @@ void ipcomp_destroy(struct xfrm_state *x)
 	if (!ipcd)
 		return;
 	xfrm_state_delete_tunnel(x);
-	mutex_lock(&ipcomp_resource_mutex);
 	ipcomp_free_data(ipcd);
-	mutex_unlock(&ipcomp_resource_mutex);
 	kfree(ipcd);
 }
 EXPORT_SYMBOL_GPL(ipcomp_destroy);
@@ -348,15 +341,10 @@ int ipcomp_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 	if (!ipcd)
 		goto out;
 
-	mutex_lock(&ipcomp_resource_mutex);
-	if (!ipcomp_alloc_scratches())
+	ipcd->tfm = crypto_alloc_acomp(x->calg->alg_name, 0, 0);
+	if (IS_ERR(ipcd->tfm))
 		goto error;
 
-	ipcd->tfms = ipcomp_alloc_tfms(x->calg->alg_name);
-	if (!ipcd->tfms)
-		goto error;
-	mutex_unlock(&ipcomp_resource_mutex);
-
 	calg_desc = xfrm_calg_get_byname(x->calg->alg_name, 0);
 	BUG_ON(!calg_desc);
 	ipcd->threshold = calg_desc->uinfo.comp.threshold;
@@ -367,7 +355,6 @@ int ipcomp_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 
 error:
 	ipcomp_free_data(ipcd);
-	mutex_unlock(&ipcomp_resource_mutex);
 	kfree(ipcd);
 	goto out;
 }
-- 
2.39.5


