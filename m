Return-Path: <netdev+bounces-305535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZKJZMHYvTWonwQEAu9opvQ
	(envelope-from <netdev+bounces-305535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:55:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBA871E089
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:55:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="gQfS9/bm";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305535-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305535-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 818F9300517C
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC86436BC8;
	Tue,  7 Jul 2026 16:55:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4D436BDD
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 16:55:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443306; cv=none; b=AHLBOoLMNx5F983gf77u9DTVWneuY8xt3bK9I1ElUMWpmCzChZG6I22hgL9IQBeFU7cGfKfFECmd3b0D51Cgryy/dAcyHuH/p3fICDcthVwdsdZHwB9y/ma4PMGFIkOkjmNHS0xijhus/1DDsVQu9CpfDyKpDspfkvPo0yC+myk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443306; c=relaxed/simple;
	bh=xdqWMVTyjcElF2+ilk5el9xCjYpK51cxLYA6WZnhs5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kL7hbZApReIZbeRqo+GG0K0zfoejfQjqwdMOrHEqdHP+Jx1FBEMvQShi52APJZ7k+f/SGjZdOlzO1YPga/czxkYrFLIN+CdDH0w8dZzygNzd7bIwHn3kN3/rbEoBBno38xY/icZzWfpMB3DTHQ8QcMdmQXQNgQ+wxytVCipEHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gQfS9/bm; arc=none smtp.client-ip=209.85.216.100
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-388b404ea89so406592a91.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 09:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443304; x=1784048104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xWPdGdxBM/dST2DhblaJVlokULFCKTqrH5S/5RZZrnI=;
        b=GN7jLufL2xRoN+SZzMf/SuiNVOYH/JmU1u4lo2yj3tWIjn6XL+z7KDxIzYCicN3Lgy
         7D7g3iTVQBfmyjqfRpt0c2eDtTrz2piCLuNCD/sIM1l4qhkxZIrdgZGITbvHaXcFHxgR
         LNaeqtQ8shAuOlZrPULld2QNhXY9eNeMGOg6XqRdSELTaUZvnXaxp0fuPyAp7spmyTMF
         jO6pG0ajlJEpRONKSazJ8gEWCS4cW+ljw64fCRkeqBoHTckrt6HIp1ENhiGC+09ashVO
         ZBMiMNS36x0Iv9MDRozV0+2c7WvyFwus8JkQbElOIoPfy3m+eQ3INjYuWJ27+Lj6ag4L
         rBDA==
X-Forwarded-Encrypted: i=1; AHgh+RpJEeVHuLUlZGGCsyvapoRlsffsD+U9IiVV5CmojhbZ/0vkT1Tm4oXZ39V+Y8bf7MyFyJDWRnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLiYSczMcsOI3fsmGdmupAf/5JqhFQ1/cFVL110msEYU0sfI3+
	ej/Vl6qQxS+zKDyVccDFTsBpsxsZ4cIYbONSqV+wxZoow2q1SiOO8WDXpP/s5+Ha7aCo640mTne
	NQmpSwBmT8Z+44gp9TLDBfRtzoE6hLOexRHf4wIGo6DQKhOq7/RkFKLn8TOxjvSqunV5VQuAvXP
	MGZGbiOOc8bMBtS4XnzYQemPMNjfwD1/xjmKVonng+axDUqgGjBpt/WWv6XjPOWIfvPCDHwYwC2
	0aNrehVJNPyPhNRa8gc
X-Gm-Gg: AfdE7cm1OBU3U2kvvXwG5m7S6XpvcC6r5zVrefnsLD/RPzEZst/rgzVlxc6VlyD6EUt
	OD7SEnSXICailrdlgUvmRPSM6wZiiNAMa9qxT0+uvhuj9fYfzLTl01JGlMYbNTwp9DNgdR6bjRf
	4Pgtr2dtaBa5cc2jaY5+mMeC/UmRXctgUUssg8zuoym/fiHsUZO3iUnNFWFUV9YDzMP3qgap1Z9
	pgX3z+zvtllDG3HzOISiOMtGwG3J7NuzAZ6pvUTQyCHHIlEi4Lvn/NWmZO+ro1TpgZkTsGAVUf8
	Mye5bK529rNrYn9qhzcqXrsSmbSg0jvgwbZdM2c/6+HORtUkXTXkhME51b/gonBtPRRRTrBDPcI
	nNsLK+nxN7EHemCYD7rCQAulOHMu0EXA1wK0ExPJw0kSXvwOxsDszuV92updoFubw4W4W7oWswe
	zPfd5rLzSGrcJALUJcoWx/OOX591366P9hVklWmFFBrRRZeSV017sP
X-Received: by 2002:a17:90b:4f8d:b0:387:d9cc:7dc3 with SMTP id 98e67ed59e1d1-387d9cc8dcemr4520994a91.21.1783443303705;
        Tue, 07 Jul 2026 09:55:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-31174a86714sm150166eec.27.2026.07.07.09.55.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2026 09:55:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8e86066fc53so16114076d6.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783443302; x=1784048102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWPdGdxBM/dST2DhblaJVlokULFCKTqrH5S/5RZZrnI=;
        b=gQfS9/bm5twLwE8E4ClfYVnQ1EN0GwVbUMKK81TWMCWkV8Px8vF6S7fIL8wKaaImrp
         zEtNtZYxydrRE/0k0kdBrrzPUMCFElsEFDouuBHQhl900hrWMgABUSJTTTXY9Vq5T6y2
         Se5SCCDm6izqBKAiSythc5Zpx7ku53W01woqs=
X-Forwarded-Encrypted: i=1; AHgh+RquKhRjVGacTwUiDYaJUmw80qcDczB9kVI//6LRt1DxMDW25UwejnZm3FpjtO9q+bLL5CWlBmc=@vger.kernel.org
X-Received: by 2002:a05:6214:202c:b0:8f1:2fef:78c8 with SMTP id 6a1803df08f44-8fd3aff9110mr44331896d6.19.1783443301751;
        Tue, 07 Jul 2026 09:55:01 -0700 (PDT)
X-Received: by 2002:a05:6214:202c:b0:8f1:2fef:78c8 with SMTP id 6a1803df08f44-8fd3aff9110mr44331226d6.19.1783443300927;
        Tue, 07 Jul 2026 09:55:00 -0700 (PDT)
Received: from lvn-dbc2448.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e84dfb0sm162937756d6.12.2026.07.07.09.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:55:00 -0700 (PDT)
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
	Harshaka Narayana <harshaka.narayana@broadcom.com>,
	Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Subject: [PATCH net] vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets
Date: Tue,  7 Jul 2026 09:52:48 -0700
Message-ID: <20260707165248.1859188-1-harshaka.narayana@broadcom.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305535-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[harshaka.narayana@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:ronak.doshi@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:linux-kernel@vger.kernel.org,m:guolin.yang@broadcom.com,m:harshaka.narayana@broadcom.com,m:sankararaman.jayaraman@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshaka.narayana@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACBA871E089

When rcd->tcp is set based on the inner TCP header of a
Geneve-encapsulated packet that exceeds MTU and is non-LRO, the driver
hits BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP) in vmxnet3_get_hdr_len()
because the outer IPv4 protocol is UDP (Geneve), not TCP.

Convert this BUG_ON to return 0, letting the caller's existing hlen == 0
check skip the LRO path gracefully. Also convert the preceding
BUG_ON(gdesc->rcd.tcp == 0) assertion to return 0 defensively.

Fixes: 45dac1d6ea04 ("vmxnet3: Changes for vmxnet3 adapter version 2 (fwd)")
Signed-off-by: Harshaka Narayana <harshaka.narayana@broadcom.com>
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 40522afc0532..f706cacfa70f 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1530,7 +1530,8 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 		struct ipv6hdr *ipv6;
 		struct tcphdr *tcp;
 	} hdr;
-	BUG_ON(gdesc->rcd.tcp == 0);
+	if (gdesc->rcd.tcp == 0)
+		return 0;
 
 	maplen = skb_headlen(skb);
 	if (unlikely(sizeof(struct iphdr) + sizeof(struct tcphdr) > maplen))
@@ -1547,7 +1548,9 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IP) &&
 		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IP));
 		hdr.ptr += hlen;
-		BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP);
+		if (hdr.ipv4->protocol != IPPROTO_TCP)
+			return 0;
+
 		hlen = hdr.ipv4->ihl << 2;
 		hdr.ptr += hdr.ipv4->ihl << 2;
 	} else if (gdesc->rcd.v6) {
-- 
2.52.0


