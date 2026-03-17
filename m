Return-Path: <netdev+bounces-268534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ELRG/gquWmVtQEAu9opvQ
	(envelope-from <netdev+bounces-268534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:20:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 969A42A7C05
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17EF63010832
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113A63A4F29;
	Tue, 17 Mar 2026 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmGVIblM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E153A3E97
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742651; cv=none; b=CIRuoVwr1NJ+EI/4VEwWSrlaNMr+w6PaNMQs95Juk/zYLPkD6u+hbusD3qHtxiwo6r1DPmKo7rejDNVPuAqgZEJYO8aRSNo47mkQhfrDJCBPFkDgJbL/aEVh+rzPzUbHf4lpapCFnQxqxxDRUoXeDlq13Z2K03yDrkz3r1JvmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742651; c=relaxed/simple;
	bh=pBr7wKOt1VHnhEwSeJAROYu062K84Dc7BzVFIGRYKAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPuH/K1LawiRxH1S94kMR8DOgxd5PqPjBT1YtCZw4a0+yNJlb/GgKyjYCbf3tkF6JJlxD9YAdm7drCXKYABEO9vH/ia6JoinzOwrkjpDOtoFm4jKwU//tGnd0uEacJo2AG0IDx+7QkwzMbjoXAdm1nAbZkDrTj3FH2/Q9zyOD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmGVIblM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6611d20c026so7979240a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773742648; x=1774347448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Jj1znMuSQTPO/G2m5vicgYLbzdRn+Ba//APkQrLGbo=;
        b=HmGVIblMnbk64xAeY8hdlnNjTj6+w7QCeGjInCAq6bYuoTmaVHa1foXv0Tis2cbSq8
         lfMvCpc/12teQ803Zwkp/FXnT+43TueKImH9LuahdiExJ7lOAtD5cY4QiV2uiehgxiWE
         K0jen+UZIrzakcr5TfRnv9MIS6B63wqYE1eG5zzS1m+q2owB8XCPH6mOUkY/VZipq27M
         GPBnKN1I75YhKMZ8aOUvSFt6TZsPBWO9I2l/JH7CEUHBWryWqmAIf5QGlkzcmC5wWTE5
         xih4ZVc4qfC9zcwtoCfJOX19AgYkHn+r2crWn5+oq64rMn4JSCeL/Ym0lCatsk8qEbTX
         FpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773742648; x=1774347448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Jj1znMuSQTPO/G2m5vicgYLbzdRn+Ba//APkQrLGbo=;
        b=bNjgAJv0eYCj2ahFluiba5s2/tssR8sviOumCmfm96OLXcPYgnYwHvwbWqa7KfgoHv
         0X38/7nFPcX8lY/Bp2MecDDAd/WIhpt/NNCe4/tC7TFoT0SqnANuNq/SzBNGQu7O8omd
         yZ5d7UnRh5EQ8nDkCGc5J0yLEn03NJf0MnWvquNUZAEh6jGpJ6ok0IpEiYM4Q3wUJctF
         RRNaPLyGrgqK12IhaS6JjlcDMgCo33QBOEBaDBtSXJA0y5vbPP1AQPTCSmmuHXxbwD2o
         e+3HT+gSAAYZeB4kiKQkahd5oRxcCs0W4gvjJf+RbPGB7O4lIGf1HvOYATO1UWjoT6ih
         07nA==
X-Gm-Message-State: AOJu0YyW51OlmyKBwMk3ljHs/+X4chm2V7Vcu6v8Xp+P2GJ07sLVoU3T
	QfAXFaUsxNhbp4FJbn/tkLLYHol/n+YU+9UNCDeH1J/ONlXtlMM32Vn+
X-Gm-Gg: ATEYQzwGX+5T/QoiOCe6NkAs4PqIVh362e/eLLjKsPEjEHJPPAS1XotlsSttsqle65m
	ZaYlr3dVvygAQVXsdXpTnWI8J0FPDakaEiZ9ria0Mfey4RHh11PkkBIGiMxYCphBd2ew5Sno36x
	fsFBIa3ICMjsD41wFbt48OiKrqheNMU3N99Ypuejt9AAhF0HwtxDz/S5ePV/bfEc8QP8choskrG
	HTQHyBElMQHntl/EwcMwn9cFPDv+87E4aqYT/s+u4weo+8iC62Bt3V99aoLgxGyRp11It/l+aHc
	2b67mW/QveuPCmBJqq/JuTMllmUg2jY1Fo29bakHyYvVfWxtWMu/84MX2S4+dQ7Da9COaiExRTR
	4int+HKawggI1uvHA8Rmsdfcc35hsa/6SuTYnoTs7sGhcL1IUTCnMs+KUF37JoFwUmj31B8tP5S
	IudW4N1irhbgRS52X0EzWcYSGrlMEkherrOer15Doh8/U9yCKhe8kEqRmphZeTSB45+VoGV/X02
	6ciPkn7RKvnYYNfhongLmigDGM6AFZCKOlWnjkyfJIICF2klwjrUtk=
X-Received: by 2002:a05:6402:50cf:b0:663:44f0:640d with SMTP id 4fb4d7f45d1cf-663babe2665mr9318190a12.29.1773742647466;
        Tue, 17 Mar 2026 03:17:27 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66753a078c0sm318154a12.17.2026.03.17.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 03:17:26 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 nf-next] bridge: Introduce DEV_PATH_BR_VLAN_KEEP_HW
Date: Tue, 17 Mar 2026 11:17:22 +0100
Message-ID: <20260317101722.358640-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-268534-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bridge_fastpath.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 969A42A7C05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Following the path through a bridge, there are 2 situations where the
action is to keep:

1. Packets have the encap, and keep the tag at ingress and keep it at
   egress. It is typical in the forward path, when a vlan-device and
   bridge are combined.

2. Packets do not have the encap, are tagged at ingress and untagged
   at egress. Can be found when only a bridge is in the forward path.
   It is also possible in the bridged path, that maybe added later.

For switchdev userports that support SWITCHDEV_OBJ_ID_PORT_VLAN in
sitaution 2, it is necessary to introduce DEV_PATH_BR_VLAN_KEEP_HW.
The typical situation 1 is unchanged: DEV_PATH_BR_VLAN_KEEP.

DEV_PATH_BR_VLAN_KEEP_HW is similar to DEV_PATH_BR_VLAN_TAG, with the
correcponding bit in ingress_vlans set.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

---

Changes in v12:
 -Split from [PATCH v11 nf-next] netfilter: fastpath fixes

Changes in v11: (results of testing with bridge_fastpath.sh)
- Dropped "No ingress_vlan forward info for dsa user port" patch.
- Added Introduce DEV_PATH_BR_VLAN_KEEP_HW, which changed from
   applying only in the bridge-fastpath to all fastpaths. Added
   a better explanation to the description.

Changes in v10:
- Split from patch-set: bridge-fastpath and related improvements v9

 include/linux/netdevice.h          |  1 +
 net/bridge/br_device.c             |  1 +
 net/bridge/br_vlan.c               | 18 +++++++++++-------
 net/netfilter/nf_flow_table_path.c | 10 ++++++++++
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d4e6e00bb90a..8a0dba788703 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -907,6 +907,7 @@ struct net_device_path {
 				DEV_PATH_BR_VLAN_TAG,
 				DEV_PATH_BR_VLAN_UNTAG,
 				DEV_PATH_BR_VLAN_UNTAG_HW,
+				DEV_PATH_BR_VLAN_KEEP_HW,
 			}		vlan_mode;
 			u16		vlan_id;
 			__be16		vlan_proto;
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index a818fdc22da9..80b75c2e229b 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -423,6 +423,7 @@ static int br_fill_forward_path(struct net_device_path_ctx *ctx,
 	case DEV_PATH_BR_VLAN_UNTAG:
 		ctx->num_vlans--;
 		break;
+	case DEV_PATH_BR_VLAN_KEEP_HW:
 	case DEV_PATH_BR_VLAN_KEEP:
 		break;
 	}
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 636c86fa1183..a42bc75bc883 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1494,13 +1494,17 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
 	if (!(v->flags & BRIDGE_VLAN_INFO_UNTAGGED))
 		return 0;
 
-	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
-		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
-	else if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
-		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG_HW;
-	else
-		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG;
-
+	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG) {
+		if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
+			path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP_HW;
+		else
+			path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
+	} else {
+		if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
+			path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG_HW;
+		else
+			path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG;
+	}
 	return 0;
 }
 
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index f2d7822824bc..e8e4465263e2 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -154,6 +154,16 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 			case DEV_PATH_BR_VLAN_UNTAG_HW:
 				info->ingress_vlans |= BIT(info->num_encaps - 1);
 				break;
+			case DEV_PATH_BR_VLAN_KEEP_HW:
+				info->ingress_vlans |= BIT(info->num_encaps);
+				if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
+					info->indev = NULL;
+					break;
+				}
+				info->encap[info->num_encaps].id = path->bridge.vlan_id;
+				info->encap[info->num_encaps].proto = path->bridge.vlan_proto;
+				info->num_encaps++;
+				break;
 			case DEV_PATH_BR_VLAN_TAG:
 				if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {
 					info->indev = NULL;
-- 
2.53.0


