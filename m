Return-Path: <netdev+bounces-287075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFrhAVICA2pczgEAu9opvQ
	(envelope-from <netdev+bounces-287075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:34:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E6D51EAC4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F25733045EC5
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E280C3839BC;
	Tue, 12 May 2026 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnIDMLix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D33395ACF
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582058; cv=none; b=CGYXwZcaQ7WwZ//i99HdAIrNL6bk75XHQUKG13qS5BmMafu1f1PE5ADl2B2AVhQgtxfxw9wtKzOecwGIe+TGVxawUaOcy/+gCyspZrcZFifXVxHTZz0g/6x3kt+zkWBsG6bkwIxULG79ZAoSZMdgkRG+yhBWu5JuMN9Ac7m9UJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582058; c=relaxed/simple;
	bh=e9ounumzMsc0PFMj8de38rXvFznFr3brdooDiKsmj28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUkG1cA8TqIhSu3m1cAtuvktbFDUN13zo783yGNTkeqiBo0mghTXlkrHwqIfVY6kRie8QxaydHM+Zq/DiiT1Ux6qZNgrzxYLOfYLHOkOblJl+bvVpkQn1QLmvw7JjgQfEM/TyLq//uwxFi6K4Aw0sPCyWOcSbFyrIfzqhrQd/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnIDMLix; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67be41d5eeeso8005145a12.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 03:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778582053; x=1779186853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOP1vXEoJfnkmimPCpGl1dwzuJKQLFvAXHQhPIbHakY=;
        b=TnIDMLix51gNFOxQ99fs43PCYEQPv7Tm+55edDxp+5X38W1pZASZRpgfRisJiwMvEv
         Ssi+JizkZE2pDOiXMlVMeUBse+dT0tbh+o3nPm6sTqNEEvUWNSUFo0FfK2sTGbRpcqcc
         6ZfPmx0qTdebtoQDtRTIYBvvmc4GYss0ZdcvHIXlOWgoVoX1hensSIltvDAAI1Su09mp
         1hlLBhM51bdsULgXV9ONroYZnYMrjERC5axK0OC9irQweBZafYFfoDvhcxooESH3FA7G
         wB8mM26lzJuib/YoXe05IqckK/XHFqxLYKSQA1yeRbF/PTTuFTCAMU02dhWiQLO6Rz+p
         ZW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778582053; x=1779186853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LOP1vXEoJfnkmimPCpGl1dwzuJKQLFvAXHQhPIbHakY=;
        b=e3OiGYGZu/lU5kuftTZSLZofjfUcWzS+B93GctUxsZNyEG9PKfAdacMah2raPIxeA/
         dhzuMashw4zLLIKTDJydPH4P6hOj3Qq5RWdPUFUQgjDu0X86PzjI4DDZZ/EkLSRaij53
         I2pgHcGeSJUuHFxQral+VcEy1Ttm4R1d1C+NFze3AWzGO40+aasBdrhbV40uTge4cQz2
         HSt1RUPctjQe4Vpqwlhjomc/HtRCBF6nZQ4TI/uowchiqnxAbQEl+KTD3jP0xMrcwmUm
         6Ae/m+cXAO/3HmaRQiEO6Pj5x7p/PLWd5Tx2BROqDnoTAqjGBv8Un3+zL2ymzDXM1nD0
         WiKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gHATUCDvkvaFEEwW+is3mpcW8WuaSA0x0tQZspvZJtGccJ69I5ClLUnpOBJOU1paKJeQXj94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpi2KfSAy9fbOv39qHjSsU1syvTGZrduehwrnZI6g+LmbEo6m
	4WQtGapQC9koRD6PkL2ZOaltmISSLbe660Hou0vCdovFnM8V8gGAVmVj
X-Gm-Gg: Acq92OF/kB4L0bRTa6GyHJrvruKXy733D0h5IWs2XDwLsAdJmnMJPnn1xfdoGhU4zeE
	5avdpe5DDdWVG3DjU8VOKOI8gqTSBY6lggUlDxSAwWNzhFJJFrWALepADDmr/Sbl7HuZhK5MPCk
	nxAQVOLHjO3LRKFLXR0ytlmWiS6IEl6zcyauys8vd2kqDiCnLJ5YizQ6wmXFoZk9WELnPtkE3ub
	2R6KQ7B0UZNN5Ylr/3lrrZgy02apzqtfnn317v6HaUr+Q34kHYEVhs8HF+YbMXvJqBxvtU/3urr
	0Agbf4BmkJ+nbS2JwNlUdfPjC3hsxdPWAOQRGEWAYdtA9Sk6FIoXNSc0zxhMoptyysXnb7B6mrn
	lDiGnwo9gI367/TP8JPa5cZU90GYxeO774C3Osx9yJhdGHvlrmNpDXQAXTHHxxBvc9d2uZx5oWK
	OpaEOZuY7PPsisF0r3fPeDt+QAZAQJgZMBrKml8zZDJtcxiH8JmY/5iUTPsf4j8SO2dnA6/eweT
	VQ5Nt9sxaYFTPz+CE4p+f/ky0ygbLG+zkXP0RMMaE4DBjoHwT07zME=
X-Received: by 2002:a05:6402:324e:b0:679:223c:d191 with SMTP id 4fb4d7f45d1cf-67d642b24b8mr11741995a12.13.1778582053043;
        Tue, 12 May 2026 03:34:13 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0e1c044sm4629218a12.27.2026.05.12.03.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:34:11 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v20 nf-next 1/2] netfilter: utils: nf_ip(6)_checksum(_partial) correct data!=networkheader
Date: Tue, 12 May 2026 12:33:46 +0200
Message-ID: <20260512103347.102746-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512103347.102746-1-ericwouds@gmail.com>
References: <20260512103347.102746-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8E6D51EAC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287075-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In the conntrack hook it may not always be the case that:
skb_network_header(skb) == skb->data, i.e. skb_network_offset(skb)
is zero.

This is problematic when L4 function nf_conntrack_handle_packet(),
nf_conntrack_icmpv4/6_error() and other functions alike are accessing L3
data. These functions also calculate the checksum using
nf_ip(6)_checksum() and nf_ip(6)_checksum_partial().

They in turn use lower skb-checksum functions that are based on using
skb->data and will fail when skb_network_offset(skb) is not zero.

Adjust for skb_network_offset(skb), so that the checksum is calculated
correctly.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/utils.c | 52 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/utils.c b/net/netfilter/utils.c
index 29c4dcc362c74..b738444c9cb6f 100644
--- a/net/netfilter/utils.c
+++ b/net/netfilter/utils.c
@@ -10,9 +10,18 @@
 __sum16 nf_ip_checksum(struct sk_buff *skb, unsigned int hook,
 		       unsigned int dataoff, u8 protocol)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* pull/push because the lower csum functions assume that
+	 * skb_network_offset(skb) is zero.
+	 */
+	dataoff -= nhpull;
+	__skb_pull(skb, nhpull);
 	switch (skb->ip_summed) {
 	case CHECKSUM_COMPLETE:
 		if (hook != NF_INET_PRE_ROUTING && hook != NF_INET_LOCAL_IN)
@@ -35,6 +44,7 @@ __sum16 nf_ip_checksum(struct sk_buff *skb, unsigned int hook,
 						       protocol, 0);
 		csum = __skb_checksum_complete(skb);
 	}
+	__skb_push(skb, nhpull);
 	return csum;
 }
 EXPORT_SYMBOL(nf_ip_checksum);
@@ -44,29 +54,47 @@ static __sum16 nf_ip_checksum_partial(struct sk_buff *skb, unsigned int hook,
 				      unsigned int dataoff, unsigned int len,
 				      u8 protocol)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* See nf_ip_checksum() */
+	dataoff -= nhpull;
+	__skb_pull(skb, nhpull);
 	switch (skb->ip_summed) {
 	case CHECKSUM_COMPLETE:
-		if (len == skb->len - dataoff)
-			return nf_ip_checksum(skb, hook, dataoff, protocol);
+		if (len == skb->len - dataoff) {
+			csum = nf_ip_checksum(skb, hook, dataoff, protocol);
+			break;
+		}
 		fallthrough;
 	case CHECKSUM_NONE:
 		skb->csum = csum_tcpudp_nofold(iph->saddr, iph->daddr, protocol,
 					       skb->len - dataoff, 0);
 		skb->ip_summed = CHECKSUM_NONE;
-		return __skb_checksum_complete_head(skb, dataoff + len);
+		csum = __skb_checksum_complete_head(skb, dataoff + len);
+		break;
 	}
+	__skb_push(skb, nhpull);
 	return csum;
 }
 
 __sum16 nf_ip6_checksum(struct sk_buff *skb, unsigned int hook,
 			unsigned int dataoff, u8 protocol)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	__sum16 csum = 0;
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* See nf_ip_checksum() */
+	dataoff -= nhpull;
+	__skb_pull(skb, nhpull);
 	switch (skb->ip_summed) {
 	case CHECKSUM_COMPLETE:
 		if (hook != NF_INET_PRE_ROUTING && hook != NF_INET_LOCAL_IN)
@@ -89,7 +117,9 @@ __sum16 nf_ip6_checksum(struct sk_buff *skb, unsigned int hook,
 						      skb_checksum(skb, 0,
 								   dataoff, 0))));
 		csum = __skb_checksum_complete(skb);
+		break;
 	}
+	__skb_push(skb, nhpull);
 	return csum;
 }
 EXPORT_SYMBOL(nf_ip6_checksum);
@@ -98,14 +128,23 @@ static __sum16 nf_ip6_checksum_partial(struct sk_buff *skb, unsigned int hook,
 				       unsigned int dataoff, unsigned int len,
 				       u8 protocol)
 {
+	unsigned int nhpull = skb_network_offset(skb);
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	__wsum hsum;
 	__sum16 csum = 0;
 
+	if (WARN_ON_ONCE(!skb_pointer_if_linear(skb, nhpull, 0)))
+		return 0;
+
+	/* See nf_ip_checksum() */
+	dataoff -= nhpull;
+	__skb_pull(skb, nhpull);
 	switch (skb->ip_summed) {
 	case CHECKSUM_COMPLETE:
-		if (len == skb->len - dataoff)
-			return nf_ip6_checksum(skb, hook, dataoff, protocol);
+		if (len == skb->len - dataoff) {
+			csum = nf_ip6_checksum(skb, hook, dataoff, protocol);
+			break;
+		}
 		fallthrough;
 	case CHECKSUM_NONE:
 		hsum = skb_checksum(skb, 0, dataoff, 0);
@@ -115,8 +154,9 @@ static __sum16 nf_ip6_checksum_partial(struct sk_buff *skb, unsigned int hook,
 							 protocol,
 							 csum_sub(0, hsum)));
 		skb->ip_summed = CHECKSUM_NONE;
-		return __skb_checksum_complete_head(skb, dataoff + len);
+		csum = __skb_checksum_complete_head(skb, dataoff + len);
 	}
+	__skb_push(skb, nhpull);
 	return csum;
 };
 
-- 
2.53.0


