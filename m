Return-Path: <netdev+bounces-298318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tv5COAENK2qE1wMAu9opvQ
	(envelope-from <netdev+bounces-298318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:31:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ED1674C0C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:31:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm1 header.b="R YJaNlp";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=Y+8ioT2t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298318-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298318-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 490333006D4A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D2129A309;
	Thu, 11 Jun 2026 19:31:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029372E7386
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:31:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206263; cv=none; b=QejSe+glrz4SDfwJ6iwao9L/pWnLFUarCtLiaewPRb23DFiH1g4US6lt+55r8QDx9YwPFXrpzSUxaJiRFfWPJ+lcgBKdpdT5bVLVEH6+ugh/jgMBgNJv0fvN4+nerCmHql0ub7GQODrmutg6ONejuBD7Ss2bVpzbm/KO7daxIm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206263; c=relaxed/simple;
	bh=j6RT/OCnC/DPUdMPpCvN5GGj86YCUCrkN6fjx+3ZR2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXEha6MDKoV78daBQ/PWXBLyafZtNAfY0hjuhVUNhscV74T1k3mu/lHyYOAGgz/uOVeQvRu/TB7K8sl/Pcd/qWihpf6jk0EJKsthryVBQumTZU3+rAJOn9zujPINjXmXsYz6kiLvWGO7FlX+Ypnfa2WMLe8UMF6X6oyVrmgSI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=RYJaNlp4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y+8ioT2t; arc=none smtp.client-ip=202.12.124.157
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EE0307A016B;
	Thu, 11 Jun 2026 15:31:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 11 Jun 2026 15:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781206260; x=
	1781292660; bh=c6K0kq2EZDxHltqO02vxX+5vTu4CdfVr+BNdXqjuxCs=; b=R
	YJaNlp4I2uPxNARbUABeD8GQ4wyxXIGXCckIohG3pHk3jYwc1dvcMaqVxuQlVgQ6
	Je+IccRLflI87UjBo8K/GsG2booP//ZOEJKgU9N8fzrp5eOKAHgVeLvucCk0GM8M
	pE1PZxMR+5bVTgOxjDseYR8Jsl6hWMmqdLsDNJvv2Z6onErFKQAul/UHXRjU0LOZ
	bu2bd+XAWg8aXzulcjzKZvCVnuU65ryEF/kj3Lybi92mqiVj2Cou79GoLqO2sjA2
	hpoCoQzaRuLWpya5dxC9EntyYcSDujv859asPIn70trII2ElHau8iMMEMHpRTPCE
	prEils8RGwCDvxvpYWbbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781206260; x=1781292660; bh=c
	6K0kq2EZDxHltqO02vxX+5vTu4CdfVr+BNdXqjuxCs=; b=Y+8ioT2tVvJqVJHUh
	vqBn2fI/fdTsG3ioKYL/yVq20CmNzbTUhITESRFrLKy1TYy4jKunBcwgkZ8kJGfY
	W3f/4dIynBHAzc5marpuYmefvBmJHV/g0YM7L3jRri8kn6Wy1LWE2IUScr8PvKqP
	b7VBSJZaPLl7BA2kqBf0VFD5sDWK0p/cEtoj0qYn2Zs1WeQZyYsNRhA6FbxH4MuD
	GVmwTz5oIV07reQ0l2cqMZhfcAcnc8GCXEs0qUym5OO6dgSjI8XWf7tlylArsS7s
	uQzttW7pxdj3SyKBnqXmPXa6wFGtHGeG58BmBwMnMArcsIFCqstNotLSGfcwfgGw
	Nt9QA==
X-ME-Sender: <xms:9Awras3k0XeSalIS0ndMV82V7RhplbNd2lnb1oeErubPDygPdL7xog>
    <xme:9Awrah-15sDEUtE1_xBckAMW3BkUR0qRIGmp1cU5Ib_2JQj22Km89I1ukS4Y0SEuq
    9izCaXGkRfxiyVnr8RSCzRsh6htpDsBj10NfxD8FI2HAC8kY7yPzg>
X-ME-Received: <xmr:9AwravFD7xTraHmQ7jemYW2908rNXmgMj8ibA08R0MQDXuzVYHepHNtKgAjVu2RF7kjd8ws7xi4Yp6eRN5HLlRA>
X-ME-Proxy-Cause: dmFkZTElDtKTZfl5mw59UBLLPrW8aIITHryvQ2nPkfR7IXQ9ce1folsZykrD4I9OVTdkfp
    PMWjjl6nkuUXhLPbzt3qohwu1pOBTiStMWOIUcSQ2JhziTT8P9Z7ptkabt25QYIUJA0UOb
    FtEClpW4Bxy5E5GbhcVpSAvd39BhalKdENFIjjg5M8mt9vzdyTxQPQIawEj0TawS+6EvUM
    3lb7CKhsn8uOyh1x6Nvw7C8IYqOO5CnLcYyVOQsMYJzI/yQEl4fZJSdk+e4k9YEIKrgg0p
    HjAxpNruOba/po3Nzd3U9dYI01SxZs0DBy/ExNAPd5vx4HhDPE+V7c+PMN+ehBtEKt0Ace
    OR+qwhDgD11qLKZ+eeMv4GEEcSKbibta0iBuk3icOfnxSgvg1Az7TIm5JAzYPQfZtTT2h8
    8ahI7AdQmk/Gze4MSCEwkDDAJ+gQ+2CBP9T7Ft8l5q3pWn4UVctQLFOza3TAibxmNgP1rY
    wIpuN0tLEvqI/zSoPxCrcbbJ9OznjfymXIleGFr3Fbe3+XGRBA7kcNbySCyI1xdPOh8IMz
    pvkZ9KkutIGwVo/RykanIqX9yb+qEmCpMOkZy5uKlg2PLB9m65eJkz00YnWSyiCEZsJzkV
    OEHe0Hwmx3UlmuAXPjvpwXcspSPZGJDt3UkSSnO9jJeDt4UtcNZ8Dnt6IYFg
X-ME-Proxy: <xmx:9AwranixFVHwM_V7bWFXNC2OFwtUa-AgnhVZHaEPSupBYc9mZ_nnpg>
    <xmx:9Awrak_ehuqIvUav3f23cU-2U5zyVVWzprVdRzDwDb6AJbbcQBNC3Q>
    <xmx:9AwrananqFgQ8GmcnrPKqvzBv-plHSAIAkjOo9_3BOD6XFfi2iFlwQ>
    <xmx:9AwraisbjagoVxCX-r8eOWCr2CDL34dTRzY6bm6lNILXXaJErKfbjQ>
    <xmx:9AwramkBl_fNRYt3pEq7fdrPEfU96K50sp-skbJnVDpc7jc-TSI35oXz>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 15:30:59 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v7 07/11] udp: Validate UDP length in udp_gro_receive
Date: Thu, 11 Jun 2026 21:29:51 +0200
Message-ID: <20260611192955.604661-8-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611192955.604661-1-alice.kernel@fastmail.im>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298318-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,vger.kernel.org:from_smtp,isovalent.com:email,fastmail.im:dkim,fastmail.im:mid,fastmail.im:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8ED1674C0C

From: Alice Mikityanska <alice@isovalent.com>

In the previous commit we started using uh->len = 0 as a marker of a GRO
packet bigger than 65536 bytes. Filter out malformed packets coming from
the wire with len=0 at udp_gro_receive to exclude them from GRO.

Note that a similar check was present in udp_gro_receive_segment, but
not in the UDP socket gro_receive flow. By adding an early check to
udp_gro_receive, the check in udp_gro_receive_segment can be dropped.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp_offload.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 4f9a3922937c..8f77c8788f6d 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -707,12 +707,8 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 		return NULL;
 	}
 
-	/* Do not deal with padded or malicious packets, sorry ! */
 	ulen = udp_get_len_short(uh);
-	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb)) {
-		NAPI_GRO_CB(skb)->flush = 1;
-		return NULL;
-	}
+
 	/* pull encapsulating udp header */
 	skb_gro_pull(skb, sizeof(struct udphdr));
 
@@ -782,8 +778,14 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	struct sk_buff *p;
 	struct udphdr *uh2;
 	unsigned int off = skb_gro_offset(skb);
+	unsigned int ulen;
 	int flush = 1;
 
+	/* Do not deal with padded or malicious packets, sorry! */
+	ulen = udp_get_len_short(uh);
+	if (ulen <= sizeof(*uh) || ulen != skb_gro_len(skb))
+		goto out;
+
 	/* We can do L4 aggregation only if the packet can't land in a tunnel
 	 * otherwise we could corrupt the inner stream. Detecting such packets
 	 * cannot be foolproof and the aggregation might still happen in some
-- 
2.54.0


