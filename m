Return-Path: <netdev+bounces-304735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WAY7AIqbSWpZ4QAAu9opvQ
	(envelope-from <netdev+bounces-304735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 01:47:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0AC708A52
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 01:47:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KJnaY0hg;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304735-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304735-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7B003007223
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 23:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574313CEBBD;
	Sat,  4 Jul 2026 23:47:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D939377004
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 23:47:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783208831; cv=none; b=jYrXSryCjiIK9VGThRBMlOxkv0SasV66Sr+MbZbNtXtBjdfgi+7Gyl/gxPDz3VGSseSfjU4XvfAMDGu7L6qbMSZjtYo4M45iSuLO3Kz7EGSHcJrKsCbgHyfYpvU3k6WWnZlSdBjXn9N0hhh6Cs50z5fBnbvxdf9rR6FU78pXpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783208831; c=relaxed/simple;
	bh=rrYma4sdY/EKOaCz+0ZnCAGtPRG4kmPijBQ1M/kgDuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXgUJfHkXKvCVUysSPYJvW8XC4vjjWeKXTvfPpA/7KvW/Djzix6CMxC9PyIV7CiLDwzl4Qg73rfCQLFtWaYCIk8sHBUbQ5i1eafkLkrch//p7slTHuIYpX6vBh0Gi9m/+HbjfO1sLCBXaYDjMJOx7AnrtLO7gjGQJMygW4gXmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJnaY0hg; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493bb481d51so539275e9.1
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 16:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783208828; x=1783813628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KR6G98ejd7YQBOCRwJ4kmyrzqgrbuG5J4PbK3v86NWM=;
        b=KJnaY0hgCwYkV92FzSzL1vcuhYcLaMXgO6gA6pL3LyXqU+nVyePHBNrmXYyaWM8DOX
         xlINOJ4pnfCYOTFJO4pQ+pfo4Mr/mFy8nbModv4Y7icaoFVXS/SNQ32IT2vanRCteHj+
         vSbKzEXuvgd2DrA1tV24gcAxyI6Y7v70OQ50wwtocyLL4+2/4xlqpKsXdnqsSBDNMHS4
         4wWAIreUJoWnN8MiQR74Mmhyo9duculqDyJhLuCzAVBq313uq857FKy4+sVBhQk5bUjL
         WWfQdjf8AdFw6Gs/Olp326Z6zGbMJUA4whB8/Qvk2neEC8kUlCxfPnUvPqeobJnZmjM2
         kwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783208828; x=1783813628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KR6G98ejd7YQBOCRwJ4kmyrzqgrbuG5J4PbK3v86NWM=;
        b=dF0lxwFntg9vhcP06lq+wAXOYom2+6JzJpCp1aRMocUzW8Zz9UYR9RDyfawiMl/sFg
         zDrIFDYpvTpY+RvmvOMR54WpZKIdp0GEePWqLLORuTQ8syguu0aEGGJXFA90WTx+9ElH
         7pA4F4f8Urk22+kOWCmeiDcXWPBpwivMpc33W2XofOQiH91mEkgeckJoWepI0JAK0uST
         44gNc4YIIhlfdEnXWDIpkS/FMusWoAd08P680W46/8ydzWpGNqdGxYbN2k6JHASTJW0d
         5ZPVyNrdJwNHkHP5i0MkZwwW86SX3e1yTUZVhqXxtcZwiriin97d8wVQlq/hmtvt6KzQ
         YloA==
X-Gm-Message-State: AOJu0YydaJaye9UVgpEzdfEwpsK/zrQlBlrHlLprsPGRf0QGjnhYKjb9
	KtGOWfKBmlkRJRT4I6HuRV/V2bOBz5Mco4KR7cchXS2eU4kRgUOo8PgufCJIOk2zOSY=
X-Gm-Gg: AfdE7cmIxZ3VDB65YP8zRM8FcLzxOLldwVJ/3r5eNyeEC3jxnp7T/nCS9lF8Ga0X7Xt
	sihq8z7+gTXGNkHanedblthxMTIGamsHtd6SZS4hhY+NegFDRqXIbnuG3ejlm8bbu/CwLgm15Oc
	7qfSbZmbiIIUgPKQfSmtHgI2iAzjWjp1TLQOgyQVowq8RQE1YZLqN6IKjr58F5M9sMVoBaY6ZlX
	7Fyl1chhOg9xCTSvAEuTVaDa4AsKY45Ngznc9lpIE0DLF/wr32KRAWKD1FWYFwg+XZPHLaObgVB
	jewSy6vrZKrJWlV7RxfH5deUBxaGZP1ke75pcGuT+4+DU+ILHFgZzUrpZsCjijpHnyMz8V+YuFV
	ZW6UyiOL7MYXqIB3aGEHusAivjbE58QIQwTW9BKzR9LBvkBaQ+j4O2o82W/rGyISstM2fFy+6cg
	ZxYrfXxaBzZe0fVHJaNLMa+no627pDEs3wRKZnlbm9Vk1yU0iX2wUgJqfNPdjQzkKCizZKBrDXA
	I65+pYZ48feSV600Ax8scrVISX8DsOj1X6QGRDN44a9KmuxgPs=
X-Received: by 2002:a05:600c:5249:b0:493:d282:8275 with SMTP id 5b1f17b1804b1-493d2828325mr21184415e9.0.1783208827713;
        Sat, 04 Jul 2026 16:47:07 -0700 (PDT)
Received: from hpubt (dynamic-2a02-3100-5cf8-ddfc-6651-06ff-fed8-72a4.310.pool.telefonica.de. [2a02:3100:5cf8:ddfc:6651:6ff:fed8:72a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce040b4sm216014125e9.10.2026.07.04.16.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 16:47:07 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net-next 2/4] net: hsr: emit RedBox-MAC TLV in PRP RedBox supervision frames
Date: Sat,  4 Jul 2026 23:47:02 +0000
Message-ID: <20260704234704.4297-3-xiexinet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260704234704.4297-1-xiexinet@gmail.com>
References: <20260704234704.4297-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304735-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiexinet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B0AC708A52

A PRP RedBox must announce the SANs it proxies so peers populate their
proxy node tables. The proxy-announce machinery (hsr_proxy_announce(),
armed via hsr->redbox) already iterates proxy_node_db under RCU and calls
send_sv_frame() once per SAN, but the PRP sender emitted neither the
announced SAN MAC nor the RedBox-MAC TLV that IEC 62439-3 requires.

Extend send_prp_supervision_frame() so that, for a proxy-announce
(identified by the interlink port, an O(1) test), the frame carries the
proxied SAN MAC as MacAddressA followed by the RedBox-MAC TLV (Type 30)
and an explicit End-of-TLV marker before padding.

hsr_get_node() must also accept the reinjected proxy-announce: a PRP
supervision frame is an untagged ETH_P_PRP frame (mac_len == ETH_HLEN, the
RCT is appended only on egress) sourced from macaddress_redbox, which is
never learned from data. Exempt only PRP supervision frames from the
hsr_ethhdr length guard; HSR (ETH_P_HSR) supervision is front-tagged and
keeps the original guard, so HSR malformed-frame filtering is unchanged.

Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c   | 33 ++++++++++++++++++++++++++++++---
 net/hsr/hsr_framereg.c | 13 +++++++++++--
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5555b71ab..7cc21253c 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -372,10 +372,21 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 {
 	struct hsr_priv *hsr = master->hsr;
 	struct hsr_sup_payload *hsr_sp;
+	struct hsr_sup_tlv *hsr_stlv;
 	struct hsr_sup_tag *hsr_stag;
 	struct sk_buff *skb;
+	bool redbox_proxy;
+	int extra = 0;
+
+	redbox_proxy = hsr->redbox && master->type == HSR_PT_INTERLINK;
+
+	/* A proxy-announce carries a RedBox-MAC TLV and an EOT marker. */
+	if (redbox_proxy)
+		extra = sizeof(struct hsr_sup_tlv) +
+			sizeof(struct hsr_sup_payload) +
+			sizeof(struct hsr_sup_tlv);
 
-	skb = hsr_init_skb(master, 0);
+	skb = hsr_init_skb(master, extra);
 	if (!skb) {
 		netdev_warn_once(master->dev, "PRP: Could not send supervision frame\n");
 		return;
@@ -393,9 +404,25 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	hsr_stag->tlv.HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
 	hsr_stag->tlv.HSR_TLV_length = sizeof(struct hsr_sup_payload);
 
-	/* Payload: MacAddressA */
+	/* Payload: MacAddressA, the announced node. */
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
-	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
+	ether_addr_copy(hsr_sp->macaddress_A, addr);
+
+	/* Proxy-announce: append the RedBox-MAC TLV (Type 30) and an explicit
+	 * EOT to terminate the TLV chain before zero padding.
+	 */
+	if (redbox_proxy) {
+		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
+		hsr_stlv->HSR_TLV_type = PRP_TLV_REDBOX_MAC;
+		hsr_stlv->HSR_TLV_length = sizeof(struct hsr_sup_payload);
+
+		hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
+		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
+
+		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
+		hsr_stlv->HSR_TLV_type = HSR_TLV_EOT;
+		hsr_stlv->HSR_TLV_length = 0;
+	}
 
 	if (skb_put_padto(skb, ETH_ZLEN)) {
 		spin_unlock_bh(&hsr->seqnr_lock);
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 7a7c52a95..37ade2dde 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -293,8 +293,17 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	 */
 	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
 	    ethhdr->h_proto == htons(ETH_P_HSR)) {
-		/* Check if skb contains hsr_ethhdr */
-		if (skb->mac_len < sizeof(struct hsr_ethhdr))
+		bool prp_sup;
+
+		/* A PRP supervision frame is an untagged ETH_P_PRP frame
+		 * (mac_len == ETH_HLEN); its RCT is appended only on egress.
+		 * HSR (ETH_P_HSR) supervision is front-tagged and still must
+		 * contain a struct hsr_ethhdr.
+		 */
+		prp_sup = hsr->prot_version == PRP_V1 &&
+			  ethhdr->h_proto == htons(ETH_P_PRP) && is_sup;
+
+		if (!prp_sup && skb->mac_len < sizeof(struct hsr_ethhdr))
 			return NULL;
 	} else {
 		rct = skb_get_PRP_rct(skb);
-- 
2.53.0


