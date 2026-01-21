Return-Path: <netdev+bounces-251986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCoDDPv9cGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:25:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF5B59DC2
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69444AEA56A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18FD44BC90;
	Wed, 21 Jan 2026 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYhJEmO6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9242340B6C6
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011975; cv=none; b=tTQzbSd4QkCWNc++MNm7zhDvlwtVZMReH1XqKmipeXIZjOPsse13EAQWZ0HKRfIfrK5lVsP4z6tGtwyf+18gj+IpW8jmkebmFvswodL8m9skyOug6oBo5J4nO107w5SSqCNlxzXe2b/M4SqjKmpyD4qP9BVFSCvcaPXtzjOVkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011975; c=relaxed/simple;
	bh=Ia2dVXEJzEgH+C9y0/H+fScJBsfP9Z/m9xivD1Hsi8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms10nOq4eCi/Gg0XgZdt/PPfOoIQfvExdLtLEujtl4uNegTr5glyePVUVtB+IQFVI2+tQi4URhGtRtM8fWXEJa8PhQoaTBrfnnzh49VFDFoAS1qIcpFfhijGb+qtiYbCXy6wByN8EEpgCE6FvAwfHuzyOYduxpVg4fkWX8iNaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iYhJEmO6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769011972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoyPLpmLeM3yd2L/jfJ2gUcWDtCD2TrYSBVMXV+ge5Q=;
	b=iYhJEmO6513gsljj79O47XvDlPUWkpheo+tdrSTo2wE0air0W6U7t2K5S2VhCEK2+zPhOM
	/A8PNU0nVHiPd6vJuzo9LJDT/KDKywZA6hmFscbm850GE8zqfhuuBLUBnL7O9JBMK0Ig1w
	nrXYTQR5NXnhoekVOUlufaHU/Hs8S1U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-f0e95qvgM_WhKDAvYzsnXQ-1; Wed,
 21 Jan 2026 11:12:48 -0500
X-MC-Unique: f0e95qvgM_WhKDAvYzsnXQ-1
X-Mimecast-MFC-AGG-ID: f0e95qvgM_WhKDAvYzsnXQ_1769011965
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F6011956050;
	Wed, 21 Jan 2026 16:12:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA4E91800240;
	Wed, 21 Jan 2026 16:12:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	sdf@fomichev.me,
	petrm@nvidia.com,
	razor@blackwall.org,
	idosch@nvidia.com
Subject: [PATCH v5 net-next 08/10] geneve: extract hint option at GRO stage
Date: Wed, 21 Jan 2026 17:11:34 +0100
Message-ID: <cd0e9dc42ba83f388b604097cffe268ffcb53351.1769011015.git.pabeni@redhat.com>
In-Reply-To: <cover.1769011015.git.pabeni@redhat.com>
References: <cover.1769011015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251986-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,fomichev.me,nvidia.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9BF5B59DC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add helpers for finding a GRO hint option in the geneve header, performing
basic sanitization of the option offsets vs the actual packet layout,
validate the option for GRO aggregation and check the nested header
checksum.

The validation helper closely mirrors similar check performed by the ipv4
and ipv6 gro callbacks, with the additional twist of accessing the
relevant network header via the GRO hint offset.

To validate the nested UDP checksum, leverage the csum completed of the
outer header, similarly to LCO, with the main difference that in this case
we have the outer checksum available.

Use the helpers to extract the hint info at the GRO stage.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
   - reload gro_hint ptr after pull
---
 drivers/net/geneve.c | 188 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 5 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index a4c23240d9e3..2e1f85b8af4e 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -405,6 +405,165 @@ static int geneve_hlen(const struct genevehdr *gh)
 	return sizeof(*gh) + gh->opt_len * 4;
 }
 
+/*
+ * Look for GRO hint in the genenve options; if not found or does not pass basic
+ * sanitization return 0, otherwise the offset WRT the geneve hdr start.
+ */
+static unsigned int
+geneve_opt_gro_hint_off(const struct genevehdr *gh, __be16 *type,
+			unsigned int *gh_len)
+{
+	struct geneve_opt *opt = (void *)(gh + 1);
+	unsigned int id, opt_len = gh->opt_len;
+	struct geneve_opt_gro_hint *gro_hint;
+
+	while (opt_len >= (GENEVE_OPT_GRO_HINT_SIZE >> 2)) {
+		if (opt->opt_class == htons(GENEVE_OPT_NETDEV_CLASS) &&
+		    opt->type == GENEVE_OPT_GRO_HINT_TYPE &&
+		    opt->length == GENEVE_OPT_GRO_HINT_LEN)
+			goto found;
+
+		/* check for bad opt len */
+		if (opt->length + 1 >= opt_len)
+			return 0;
+
+		/* next opt */
+		opt_len -= opt->length + 1;
+		opt = ((void *)opt) + ((opt->length + 1) << 2);
+	}
+	return 0;
+
+found:
+	gro_hint = (struct geneve_opt_gro_hint *)opt->opt_data;
+
+	/*
+	 * Sanitize the hinted hdrs: the nested transport is UDP and must fit
+	 * the overall hinted hdr size.
+	 */
+	if (gro_hint->nested_tp_offset + sizeof(struct udphdr) >
+	    gro_hint->nested_hdr_len)
+		return 0;
+
+	if (gro_hint->nested_nh_offset +
+	    (gro_hint->nested_is_v6 ? sizeof(struct ipv6hdr) :
+				      sizeof(struct iphdr)) >
+	    gro_hint->nested_tp_offset)
+		return 0;
+
+	/* Allow only supported L2. */
+	id = gro_hint->inner_proto_id;
+	if (id >= ARRAY_SIZE(proto_id_map))
+		return 0;
+
+	*type = proto_id_map[id];
+	*gh_len += gro_hint->nested_hdr_len;
+
+	return (void *)gro_hint - (void *)gh;
+}
+
+static const struct geneve_opt_gro_hint *
+geneve_opt_gro_hint(const struct genevehdr *gh, unsigned int hint_off)
+{
+	return (const struct geneve_opt_gro_hint *)((void *)gh + hint_off);
+}
+
+static unsigned int
+geneve_sk_gro_hint_off(const struct sock *sk, const struct genevehdr *gh,
+		       __be16 *type, unsigned int *gh_len)
+{
+	const struct geneve_sock *gs = rcu_dereference_sk_user_data(sk);
+
+	if (!gs || !gs->gro_hint)
+		return 0;
+	return geneve_opt_gro_hint_off(gh, type, gh_len);
+}
+
+/* Validate the packet headers pointed by data WRT the provided hint */
+static bool
+geneve_opt_gro_hint_validate(void *data,
+			     const struct geneve_opt_gro_hint *gro_hint)
+{
+	void *nested_nh = data + gro_hint->nested_nh_offset;
+	struct iphdr *iph;
+
+	if (gro_hint->nested_is_v6) {
+		struct ipv6hdr *ipv6h = nested_nh;
+		struct ipv6_opt_hdr *opth;
+		int offset, len;
+
+		if (ipv6h->nexthdr == IPPROTO_UDP)
+			return true;
+
+		offset = sizeof(*ipv6h) + gro_hint->nested_nh_offset;
+		while (offset + sizeof(*opth) <= gro_hint->nested_tp_offset) {
+			opth = data + offset;
+
+			len = ipv6_optlen(opth);
+			if (len + offset > gro_hint->nested_tp_offset)
+				return false;
+			if (opth->nexthdr == IPPROTO_UDP)
+				return true;
+
+			offset += len;
+		}
+		return false;
+	}
+
+	iph = nested_nh;
+	if (*(u8 *)iph != 0x45 || ip_is_fragment(iph) ||
+	    iph->protocol != IPPROTO_UDP || ip_fast_csum((u8 *)iph, 5))
+		return false;
+
+	return true;
+}
+
+/*
+ * Validate the skb headers following the specified geneve hdr vs the
+ * provided hint, including nested L4 checksum.
+ * The caller already ensured that the relevant amount of data is available
+ * in the linear part.
+ */
+static bool
+geneve_opt_gro_hint_validate_csum(const struct sk_buff *skb,
+				  const struct genevehdr *gh,
+				  const struct geneve_opt_gro_hint *gro_hint)
+{
+	unsigned int plen, gh_len = geneve_hlen(gh);
+	void *nested = (void *)gh + gh_len;
+	struct udphdr *nested_uh;
+	unsigned int nested_len;
+	struct ipv6hdr *ipv6h;
+	struct iphdr *iph;
+	__wsum csum, psum;
+
+	if (!geneve_opt_gro_hint_validate(nested, gro_hint))
+		return false;
+
+	/* Use GRO hints with nested csum only if the outer header has csum. */
+	nested_uh = nested + gro_hint->nested_tp_offset;
+	if (!nested_uh->check || skb->ip_summed == CHECKSUM_PARTIAL)
+		return true;
+
+	if (!NAPI_GRO_CB(skb)->csum_valid)
+		return false;
+
+	/* Compute the complete checksum up to the nested transport. */
+	plen = gh_len + gro_hint->nested_tp_offset;
+	csum = csum_sub(NAPI_GRO_CB(skb)->csum, csum_partial(gh, plen, 0));
+	nested_len = skb_gro_len(skb) - plen;
+
+	/* Compute the nested pseudo header csum. */
+	ipv6h = nested + gro_hint->nested_nh_offset;
+	iph = (struct iphdr *)ipv6h;
+	psum = gro_hint->nested_is_v6 ?
+	       ~csum_unfold(csum_ipv6_magic(&ipv6h->saddr, &ipv6h->daddr,
+					    nested_len, IPPROTO_UDP, 0)) :
+	       csum_tcpudp_nofold(iph->saddr, iph->daddr,
+				  nested_len, IPPROTO_UDP, 0);
+
+	return !csum_fold(csum_add(psum, csum));
+}
+
 /* Callback from net/ipv4/udp.c to receive packets */
 static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
@@ -541,13 +700,13 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 					  struct list_head *head,
 					  struct sk_buff *skb)
 {
+	unsigned int hlen, gh_len, off_gnv, hint_off;
+	const struct packet_offload *ptype;
+	struct genevehdr *gh, *gh2;
 	struct sk_buff *pp = NULL;
 	struct sk_buff *p;
-	struct genevehdr *gh, *gh2;
-	unsigned int hlen, gh_len, off_gnv;
-	const struct packet_offload *ptype;
-	__be16 type;
 	int flush = 1;
+	__be16 type;
 
 	off_gnv = skb_gro_offset(skb);
 	hlen = off_gnv + sizeof(*gh);
@@ -558,6 +717,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 	if (gh->ver != GENEVE_VER || gh->oam)
 		goto out;
 	gh_len = geneve_hlen(gh);
+	type = gh->proto_type;
 
 	hlen = off_gnv + gh_len;
 	if (!skb_gro_may_pull(skb, hlen)) {
@@ -566,6 +726,25 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 			goto out;
 	}
 
+	/* The GRO hint/nested hdr could use a different ethernet type. */
+	hint_off = geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
+	if (hint_off) {
+		const struct geneve_opt_gro_hint *gro_hint;
+
+		/*
+		 * If the hint is present, and nested hdr validation fails, do
+		 * not attempt plain GRO: it will ignore inner hdrs and cause
+		 * OoO.
+		 */
+		gh = skb_gro_header(skb, off_gnv + gh_len, off_gnv);
+		if (unlikely(!gh))
+			goto out;
+
+		gro_hint = geneve_opt_gro_hint(gh, hint_off);
+		if (!geneve_opt_gro_hint_validate_csum(skb, gh, gro_hint))
+			goto out;
+	}
+
 	list_for_each_entry(p, head, list) {
 		if (!NAPI_GRO_CB(p)->same_flow)
 			continue;
@@ -580,7 +759,6 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 
 	skb_gro_pull(skb, gh_len);
 	skb_gro_postpull_rcsum(skb, gh, gh_len);
-	type = gh->proto_type;
 	if (likely(type == htons(ETH_P_TEB)))
 		return call_gro_receive(eth_gro_receive, head, skb);
 
-- 
2.52.0


