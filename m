Return-Path: <netdev+bounces-307193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WKHFKEH2VGoyiAAAu9opvQ
	(envelope-from <netdev+bounces-307193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:29:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FAB74C642
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:29:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="Tfb3/ao/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307193-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307193-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5412F30A184D
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2ED2D7DCE;
	Mon, 13 Jul 2026 14:11:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C93282F01
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:11:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951883; cv=none; b=dA1XuVBOnqtLdoSyFOAZ0Y6w57MK8as6KkuMZ7DKps1MfnIDQOVmgh86o7R4mbmmAjcHSlvMdRPSw9W0YMabCc52ARjvziQqMpg1vzLhyU5++bIuHr8RjUIJ0d4D/8SegMMYQA8pHETSKzD/LZF2YuprV6MM1WS/p+78bBwK+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951883; c=relaxed/simple;
	bh=ky8a078BzuCeIqNQ3LW+dhReUhSCYk+x7jWpvgUSciU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z61lsEWieXSRp1WmBHTe5gIismNyYCM628hok6PXzVmpcjGCw1eHVAW2mORjOQ2i6ojlFIb7eQ5V3h4B5fT5Lbpy8HQUUZ00sBbCM/SujTIwTpFJsBxVWTsu0SvgQZbCBKRYAYfJTZlzbrpBVBsAACaLun2gpAEClVb5+5JhgYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Tfb3/ao/; arc=none smtp.client-ip=209.85.214.228
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so49791435ad.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951881; x=1784556681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hIl1om5v05Us/yKSHOl5DicDdbxl/J4daUVgzU7kfHw=;
        b=mkStZyiCMEeKM4KcojZd8rnAaU5HrCT55pCLdSPdVVm+mV9st+iS5zI8nOQhjByqpV
         muwRIrMg+cO6G1NlHWwb9wDajy1zfOSegNII6oQlCy95nobe30fo/uddYFiCYPN37EZL
         zdyssEd68gJ9AaUzLh/gXA3RKSKOZYJMqQe98FNY3KdJIkhqxdDWdu80bdcqap9eBgtq
         CNWp6gtGsx28d4n4rYmRW/+cqKA/MVAEaFTHktlffw4FdPGXjINlyWZj7pm/SQy3+a/9
         5p6QC143OFtF+Hi0Hg+WT7rWRVq6KzpNFpzXZjjcHnnCBq68y9oXuVjoqz+bz5Dv8+sU
         rtWw==
X-Forwarded-Encrypted: i=1; AHgh+RoNfrTa/uNuU6QRFlInJVHep8GH533l2HNPmXHgsatlkX9s0w6e+I3C+DeT3KGvpT21SMxFUYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7guJhSpEQrfvj9SFS6TP2njeJ4zLkJOBSTItOrLKxGRuhMOLD
	arkVoAaz8sBNf1JqAtZvdpZcONDqZb9sSXXgSTe3RIndjTsxdasV0xCxTYmtQ7Rl2CQ4cyyBdqP
	CksFHA7NvE8+khyvwjj6n+v51wtrTaEVLjkyaaIz68XYEGYY4auqeTy1a5utFfr+gPb7fCOZ7PM
	at9k6iYhuubzh0v8r2RyxlWnVh+cyUMg1IQAyryXy0NaTNYkN3Ijj77hUSgs9z4x7LkLcLCRWvC
	CoNXpNHXOO0OEdD30Au
X-Gm-Gg: AfdE7cmPztDjWXlpuffrIKhrzCMlPu/eJWUbGCJL4WchIeoVL6V4dbBbM5Tpbgtvg6w
	pi1Omh+co4JC5Xt7LV2xzKfat+CX3Kv6KNzi3RFPF81V8yvbfjrnSSbGpVV5FNgroQxwDdhn5b5
	ky8Dja7dNd8ZniR16+384GBpjfu0f507Jr18bQ0FsAUpOSb29WUMpMdBVphGvZ0DWco9uRfSB+8
	6uKtCvhnMJjm9YgaV99vf9Ep681LL+d+b8Uu9e0P07LWj71jk9OIE6fOmJoOVY8ryz2dEUfCt4Q
	/IjzxpVt6DTj0NbuGk3LAtY1W6kYxAWCGVh/JiWhB8Dybp+kdDVsWtpAyyvWG3x6nFJYl4XbpvM
	2IeWYnK5rm4doFuKlGAoFWSU6TbL0WA1/kY+2RznQJU+43Ucjs11QsB9hUmusm++ZsjWnagW7pv
	2Ehr2GNdfN695KjvEBHt7DoCAq5G1T65TZPlxCf3xbCqIiUTfk7g==
X-Received: by 2002:a17:903:240c:b0:2ce:9b49:d4a0 with SMTP id d9443c01a7336-2ce9f15cabbmr82713315ad.35.1783951881137;
        Mon, 13 Jul 2026 07:11:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ccc99c3da9sm20087405ad.0.2026.07.13.07.11.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 07:11:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so4675729a12.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783951879; x=1784556679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hIl1om5v05Us/yKSHOl5DicDdbxl/J4daUVgzU7kfHw=;
        b=Tfb3/ao/nQwagIIz630vndsvShhT3uslTlFZPIs3+kfdmLgk0wLBghtpRprgJHQc9i
         5agFbfeQdODCkQmZPMt247KEI0WUoagHpUSHqPzaGL/Jj4yhMK9CelcVlAQh22KOzsqP
         8gtPhvSftZRL6y2FxBGTib0F/xIw7Ro4k4+Sk=
X-Forwarded-Encrypted: i=1; AHgh+RrkCOPizuAibHylM7LQ9x6abevQWag6bUd4QF5+N7nvbRMN7ebnoGVPxLyHhK+K7pdPcHkqLhE=@vger.kernel.org
X-Received: by 2002:a05:6a21:9216:b0:3bf:9142:ba3a with SMTP id adf61e73a8af0-3c110a77446mr10555418637.26.1783951879478;
        Mon, 13 Jul 2026 07:11:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:9216:b0:3bf:9142:ba3a with SMTP id adf61e73a8af0-3c110a77446mr10555376637.26.1783951879034;
        Mon, 13 Jul 2026 07:11:19 -0700 (PDT)
Received: from lvn-dbc2448.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b93ae3b45sm19650511c88.15.2026.07.13.07.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:11:18 -0700 (PDT)
From: Harshaka Narayana <harshaka.narayana@broadcom.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	guolin.yang@broadcom.com,
	harshaka.narayana@broadcom.com,
	sankararaman.jayaraman@broadcom.com
Subject: [PATCH net v3] vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets
Date: Mon, 13 Jul 2026 07:09:15 -0700
Message-ID: <20260713140915.3381715-1-harshaka.narayana@broadcom.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-307193-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:ronak.doshi@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:linux-kernel@vger.kernel.org,m:guolin.yang@broadcom.com,m:harshaka.narayana@broadcom.com,m:sankararaman.jayaraman@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[harshaka.narayana@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[harshaka.narayana@broadcom.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:mid,broadcom.com:email,broadcom.com:dkim];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01FAB74C642

vmxnet3_get_hdr_len() assumes gdesc->rcd.v4/v6/tcp always describe the
outer header, but for a Geneve-encapsulated packet the device can set
them based on the inner header instead, signalled by the
VMXNET3_RCD_HDR_INNER_SHIFT bit in the completion descriptor. Since the
function never skips the outer encapsulation, this mismatch triggers:

- BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP), because the outer
  protocol is UDP (Geneve), not TCP.
- BUG_ON(hdr.eth->h_proto != ...), when the tunnel's outer and inner
  IP versions differ (e.g. outer IPv6/inner IPv4 or vice versa).

Check VMXNET3_RCD_HDR_INNER_SHIFT up front and bail out, since the
function cannot locate the inner header it would need to parse. Also
convert the remaining BUG_ON()s in this function to return 0
defensively.

Fixes: 45dac1d6ea04 ("vmxnet3: Changes for vmxnet3 adapter version 2 (fwd)")
Signed-off-by: Harshaka Narayana <harshaka.narayana@broadcom.com>
Reviewed-by: Ronak Doshi <ronak.doshi@broadcom.com>
Reviewed-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
---
v3:
  - Combined the two early return-0 checks into one condition
  - Replaced stacked Signed-off-by tags with Reviewed-by for Ronak
    Doshi and Sankararaman Jayaraman
v2: https://lore.kernel.org/netdev/20260709201654.4108084-1-harshaka.narayana@broadcom.com/
  - Check VMXNET3_RCD_HDR_INNER_SHIFT up front to catch the Geneve
    inner-header case directly, and convert the remaining
    BUG_ON(hdr.eth->h_proto != ...) checks to return 0
  - Reworded commit message to describe the root cause via
    VMXNET3_RCD_HDR_INNER_SHIFT
v1: https://lore.kernel.org/netdev/20260707165248.1859188-1-harshaka.narayana@broadcom.com/
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 40522afc0532..f8df83f9965d 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1530,7 +1530,11 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 		struct ipv6hdr *ipv6;
 		struct tcphdr *tcp;
 	} hdr;
-	BUG_ON(gdesc->rcd.tcp == 0);
+
+	/* v4/v6/tcp then describe the inner header, which we can't locate. */
+	if ((le32_to_cpu(gdesc->dword[0]) & (1UL << VMXNET3_RCD_HDR_INNER_SHIFT)) ||
+	    gdesc->rcd.tcp == 0)
+		return 0;
 
 	maplen = skb_headlen(skb);
 	if (unlikely(sizeof(struct iphdr) + sizeof(struct tcphdr) > maplen))
@@ -1544,15 +1548,21 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 
 	hdr.eth = eth_hdr(skb);
 	if (gdesc->rcd.v4) {
-		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IP) &&
-		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IP));
+		if (hdr.eth->h_proto != htons(ETH_P_IP) &&
+		    hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IP))
+			return 0;
+
 		hdr.ptr += hlen;
-		BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP);
+		if (hdr.ipv4->protocol != IPPROTO_TCP)
+			return 0;
+
 		hlen = hdr.ipv4->ihl << 2;
 		hdr.ptr += hdr.ipv4->ihl << 2;
 	} else if (gdesc->rcd.v6) {
-		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IPV6) &&
-		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IPV6));
+		if (hdr.eth->h_proto != htons(ETH_P_IPV6) &&
+		    hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IPV6))
+			return 0;
+
 		hdr.ptr += hlen;
 		/* Use an estimated value, since we also need to handle
 		 * TSO case.
-- 
2.52.0


