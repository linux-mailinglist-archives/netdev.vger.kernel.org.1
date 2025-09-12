Return-Path: <netdev+bounces-222661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AC5B554B0
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 18:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010AE5A1DD1
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602AC3176E4;
	Fri, 12 Sep 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9eqaYZs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CE11E503D
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694711; cv=none; b=evJ9kx4PtqqFH454tHDf62hs0F8RhjOqRZBQCML9EIkUEkgYDoX6c4ufl5EG1ilVbSWbxBAaio/fWeL1TLvKYFI2URLEhiazWVgScvWilIXCDUB3VM3wyF2ERSTvX0cBJAaYjm9XojYx3NBSD0CntJXa6bjjoFet1X5F9HzeByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694711; c=relaxed/simple;
	bh=9ihUSfzSFkwLShWje0yO2srPckLAAToJdNnr5Y0SusM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XbjLMTP129hn5tHYilK2fRpNAwvza0rpnHhJdT65CVDVxKhxszew48qe6ceuaGUNDp+jdlC7mwCFhiqpZtD319TXIayHn1XpxW0yqiopbGkpoy0aTnhn40nvNuNMmx9hzftCm3M+kzCWiRAS/vbCGtvGNj5Bj8m8AiBO0QAlWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9eqaYZs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso20128845e9.3
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757694707; x=1758299507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UtKuOJb160u4mrJLBMsiqKEZV9s8rb8J9qjSnxTlACY=;
        b=H9eqaYZsV/SEKfw+wGD3shjT9uPhaD2GpRZrWX1FwxMVksRLBVvueSGYixtC5Gv+gZ
         6mDOIsNVcLpxmVn+zeq3rlg5od84xJXerX5EMTUr2IoA+h3HndRWVmVzjg1MwF0nd9/1
         on+ah4fk8mgjyPYqRtDabi2KUdgeVgkcvssgPH4kdemXfanXM9R6ORipFx3k6M8oQzA5
         f6W66NWpef6en3LosJMPvUVpfTQh5fIZNE4n36Y8p6wb9fPRpnDhuwt0V8BpyImLH5Cb
         kv1W/db8YIsQnwHGr7T2BVDXmAsFGPCQi5X1UdDbqGU32467ctLx8GF8YpT//AnJzJyF
         ASxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757694707; x=1758299507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtKuOJb160u4mrJLBMsiqKEZV9s8rb8J9qjSnxTlACY=;
        b=w/F3rHT5+7GgIuiEd9u9FBfwfhv9Ad3uNaW3vqBHqJTm1NdmU5Pr5tvNosemJndK/+
         rUv/i/atyuVFmppgA8bu5wataVrDpoB2bVq9VEFs3qb2YUsn/ThTgET00kE7xKSPk329
         ADQ2AFsAcL/h9bP+u8zu7HvJciQAr4T92BTe2nShmC6Aj3cfQFsF0cWtSdCWA+5Epp6r
         N4A7f0BMAmJNCTge7jaPh9GTwJtm9l89/sh2SdSEQN0ISTaQdDOOtD2FoS6hHkkPNjaR
         bt0z7GQBItzPCqVVQaCvTFV2xMDqTpRrecGSV9frTVyFXiuFaE0byQjM202HX0z+v6O8
         Wm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzqTHc8oNUqOuK9BJmebfwb62+F3lRUSWcdcBv2Ski3KUlFR1NRsiz4By/r2IbE7NQvm2HJrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEyBkbIDPsZan3eIcigLmSW65j1T77+lN8YMH91CdOeJgYCgM
	bD8eNDIzrFJGUCQZp+0PhjRXvC5zlwZaDgceqGrEr6+hgObm11TneKdw
X-Gm-Gg: ASbGnctZ4omeisLjmro3Ir6IzFXZHb+lst3PGdTt3kq3Ci7Q2P4ORkz1SXFiaKtDKYa
	im27iurxJn1zHE2A8wKPeN8abMAHq2KginhdeTRY04Xp20gDpb8B6yeUf3775xZY73XMr8rhvCf
	kb7uuyrkqCmoHY61NV/qQ0J+uK8xVpNjoROLoZd4oXhfnsubhgzcAvQ1XZPdTXCnXnv7043J6lv
	BBxTFyw0EAccRE85yTEr2RsBvTCLqpTE8QSP+lRVRr/IXjy0xC3TEn1QXujsdOMUFZwroQKUUys
	DCt4ATID79KOk5m7riidi6gc9tUS1ePpWhjhoUam57KJQZd764oZKjC6I8lhhmVP8Mfey9XdB0u
	k/hUly4xxGkJ5m0JIC5bsLEuXP3XkBkGzeO8/5zWLerwRoLQR0J/CbmFvJb4Q68kR
X-Google-Smtp-Source: AGHT+IHIRSdEBgoLi0Q0DuZdQBqEeXcgKeXdgViwtka9Vqo2HBpKPmSlfWNGtBJ9utLxGObmeSXi0A==
X-Received: by 2002:a05:6000:3101:b0:3ca:3206:29f with SMTP id ffacd0b85a97d-3e765a2d9f1mr3941616f8f.40.1757694707074;
        Fri, 12 Sep 2025 09:31:47 -0700 (PDT)
Received: from elad-pc.lan ([2a0d:6fc2:68d0:5700:2165:4513:68b5:3f5b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d638dsm64844795e9.22.2025.09.12.09.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:31:46 -0700 (PDT)
From: Elad Yifee <eladwf@gmail.com>
To: 
Cc: eladwf@gmail.com,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next RFC] netfilter: flowtable: add CT metadata action for nft flowtables
Date: Fri, 12 Sep 2025 19:30:35 +0300
Message-ID: <20250912163043.329233-1-eladwf@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When offloading a flow via the default nft flowtable path,
append a FLOW_ACTION_CT_METADATA action if the flow is associated with a conntrack entry.
We do this in both IPv4 and IPv6 route action builders, after NAT mangles and before redirect.
This mirrors net/sched/act_ct.c’s tcf_ct_flow_table_add_action_meta() so drivers that already
parse FLOW_ACTION_CT_METADATA from TC offloads can reuse the same logic for nft flowtables.

Signed-off-by: Elad Yifee <eladwf@gmail.com>
---
 net/netfilter/nf_flow_table_offload.c | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index e06bc36f49fe..bccae4052319 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -12,6 +12,7 @@
 #include <net/netfilter/nf_conntrack_acct.h>
 #include <net/netfilter/nf_conntrack_core.h>
 #include <net/netfilter/nf_conntrack_tuple.h>
+#include <net/netfilter/nf_conntrack_labels.h>
 
 static struct workqueue_struct *nf_flow_offload_add_wq;
 static struct workqueue_struct *nf_flow_offload_del_wq;
@@ -679,6 +680,41 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
 	return 0;
 }
 
+static void flow_offload_add_ct_metadata(const struct flow_offload *flow,
+					 enum flow_offload_tuple_dir dir,
+					 struct nf_flow_rule *flow_rule)
+{
+	struct nf_conn *ct = flow->ct;
+	struct flow_action_entry *entry;
+#if IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS)
+	u32 *dst_labels;
+	struct nf_conn_labels *labels;
+#endif
+
+	if (!ct)
+		return;
+
+	entry = flow_action_entry_next(flow_rule);
+	entry->id = FLOW_ACTION_CT_METADATA;
+
+#if IS_ENABLED(CONFIG_NF_CONNTRACK_MARK)
+	entry->ct_metadata.mark = READ_ONCE(ct->mark);
+#endif
+
+	entry->ct_metadata.orig_dir = (dir == FLOW_OFFLOAD_DIR_ORIGINAL);
+
+#if IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS)
+	dst_labels = entry->ct_metadata.labels;
+	labels = nf_ct_labels_find(ct);
+	if (labels)
+		memcpy(dst_labels, labels->bits, NF_CT_LABELS_MAX_SIZE);
+	else
+		memset(dst_labels, 0, NF_CT_LABELS_MAX_SIZE);
+#else
+	memset(entry->ct_metadata.labels, 0, NF_CT_LABELS_MAX_SIZE);
+#endif
+}
+
 int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
 			    enum flow_offload_tuple_dir dir,
 			    struct nf_flow_rule *flow_rule)
@@ -698,6 +734,7 @@ int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
 	    test_bit(NF_FLOW_DNAT, &flow->flags))
 		flow_offload_ipv4_checksum(net, flow, flow_rule);
 
+	flow_offload_add_ct_metadata(flow, dir, flow_rule);
 	flow_offload_redirect(net, flow, dir, flow_rule);
 
 	return 0;
@@ -720,6 +757,7 @@ int nf_flow_rule_route_ipv6(struct net *net, struct flow_offload *flow,
 		flow_offload_port_dnat(net, flow, dir, flow_rule);
 	}
 
+	flow_offload_add_ct_metadata(flow, dir, flow_rule);
 	flow_offload_redirect(net, flow, dir, flow_rule);
 
 	return 0;
-- 
2.48.1


