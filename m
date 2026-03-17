Return-Path: <netdev+bounces-268823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QASgL5bouWntPQIAu9opvQ
	(envelope-from <netdev+bounces-268823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:49:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B3C2B476C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1643830F1D39
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4ED3A7F61;
	Tue, 17 Mar 2026 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbG97JL5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280B18872A
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791354; cv=none; b=sElkK0EYMKmwqymXNKJCTzDMqhETjcB2n02zEFsmGXuR7plZdeZIJQGF15JXne/lb+lEhTeySLLuR9IFl2S2awhcF+3DxcRBj8rnTJ7Yt3fHbEUyxgNQrFXZ0RNr5PDVzSR28GzN37OJkBcvUbmmlugnD7CV+amvhh44i6aJP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791354; c=relaxed/simple;
	bh=mhZLdgPv0AOrvzsAowsgsKql1IibQ/eZ9KKbTpXInPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7WrPc79L1AGucrgIZNcPFQgPYIYVfAzZtSxvcPD14WNfrIwHPDmpMYiYV31KOBuYuc+W27EPOOHzMUvBhwKx3wNSc39+NSsx7mo/YGA/oqqi3VAchObbGU3pme3tuEN7e0PeSrTze2lHdklwAqqicy0sgJBojWJFLkg4KzYcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbG97JL5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b4915161fso1819431f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773791351; x=1774396151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5xWrxB4QyPLcPNl2mqQEN8z4jAQkq48jEe/HhbLuYs=;
        b=TbG97JL5plFY1XpEECm2fL0szJ7zvK1tMrOnvd9UKg46JvG0idfXKajtaHf84jDA/W
         eIunvO9xlwpE5/XHbj3s6fewHL6Z8jKcCRSaqnYqCkhz4nHCVZ91yiNcspCviLNaDoYY
         mDwOKB3iIR6eVnLcbGjG+2STInI/UzyhbBi4odz9MAOz6aN35bWsAacBgIQ0oGUIOFaa
         TcGdH3L+8Ogmx4JdoDXDN7qSdQgKePGRtMA80DGyzDUIKLD7UCLL8dy08ANk0bT6GfCl
         7wLvxzPL5+2o8k2c6SYUJoV1KFsYsntjADET8hs1uidb51BTuGPNjGe/LAjH8QZmR5Ta
         T/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773791351; x=1774396151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v5xWrxB4QyPLcPNl2mqQEN8z4jAQkq48jEe/HhbLuYs=;
        b=Q7Aeix/JjsRxMZPwe61G2k1g5v7Wd2lM/GeXvfqK62ObEmUAvl5hpFSX6hVm6xhVPO
         0MKxzePsy5V72sB+CUT3D1SHaBPdWmg8DCP02zmxie3/BH6RNihK0if+AvvUJUI8tuFT
         WdY8QOBjyavxUvWP60Joahw5sYy+Bxz2k3SLoCrlzu7WbBujoOM6ZFjzkC1Xs18cfHAn
         0+tu5lY8zA7CTJahKjsCnEogzsEO2sWJI/bUAlu6YshBlJlH8i/jV5OYbriDJXNGpfHY
         4r8jDCCpkbXW1XuD3LI7Ylbl6ajzRF8PG4CM3eshODz5UAltvanB5GZMFN6fKtcUkcYK
         0GBA==
X-Forwarded-Encrypted: i=1; AJvYcCWEHYsM4dmWO2TgbubzA1Hch3JFyfeWIwA2mSxr1FmPbHnZwfByUvDQRPqRww5sjKG22Y+8PMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5yxWJqElHbw3YvHIY2RyIdlwI7sl7rB9ccmxvp+1gVOzwk0y
	EhBp52n7daVGtUvw1auo3VvPix7NuGpFM/bMZsu72eSBnP2IaXSpeMFYRNBjV2avCSsALw==
X-Gm-Gg: ATEYQzwPbV74GJr8JlTOneVnjSnAmjjZ/kS9sS+B0elp8phZI23V0KwoptCSX7xeD5G
	yti38ogbFZaP5EYJlKUGcBZ6XNlcUhZwpCeD/qj6SJt+xqmpRD96xxyIj66+bnTAUHvDyKrZ9iD
	11Roy1K4OvfLWI8mlsO1c0yYjfeIGjKWQzMy7u3Zdx6t4VL1R1Rdc15yfc4q84hKWHWZhxvR1Qd
	7jUAhAhsTy+cZpgej4N3u1YpbB1ap9tSlPZOxIpR5Z3gQNCrkCMpcRH9sXS7HZpXqiQCos7z1mK
	UH6nRj8snpjNyeqeifH/e6gMMiukxe/Kn/UB2htsa5F5eKTTdArIxtbMj1u99qA1imxg6PBfNx5
	xq1DbXFM+aGAPvNyrGNR8p1x3Qci5kyqIIpnlNJPDzYS/QOuYSvNP68emIol3pk/LtlJIjU6Aal
	gBX9qcCT0wpKWSwEdhElf8
X-Received: by 2002:a05:6000:2681:b0:439:cb79:ab05 with SMTP id ffacd0b85a97d-43b527c8a0amr1983736f8f.36.1773791351261;
        Tue, 17 Mar 2026 16:49:11 -0700 (PDT)
Received: from azaki-desk1.. ([41.234.201.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518a3d78sm3279810f8f.34.2026.03.17.16.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:49:10 -0700 (PDT)
From: Ahmed Zaki <anzaki@gmail.com>
To: netfilter-devel@vger.kernel.org,
	pablo@netfilter.org,
	fw@strlen.de
Cc: coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH nf-next 2/2] netfilter: flowtable: update netdev stats with HW_OFFLOAD flows
Date: Tue, 17 Mar 2026 17:48:51 -0600
Message-ID: <20260317234851.234466-3-anzaki@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317234851.234466-1-anzaki@gmail.com>
References: <20260317234851.234466-1-anzaki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268823-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[anzaki@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64B3C2B476C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SNMP-based network monitoring systems (and maybe other tools) rely on
netdev stats to report the network traffic. We currently do not update
the netdev stats with the offloaded flows stats which creates
discrepancies in the stats with some of these devices inside a bigger
network.

Update the nedev stats with the hardware offloaded flows' stats. The
stats are updated periodically in flow_offload_work_stats() and also
once in flow_offload_work_del() before the flow is deleted. For this,
flow_offload_work_del() had to be moved below flow_offload_tuple_stats()

Signed-off-by: Ahmed Zaki <anzaki@gmail.com>
---
 net/netfilter/nf_flow_table_offload.c | 59 ++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index b2e4fb6fa011..fb325d4a1131 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -925,13 +925,41 @@ static void flow_offload_work_add(struct flow_offload_work *offload)
 	nf_flow_offload_destroy(flow_rule);
 }
 
-static void flow_offload_work_del(struct flow_offload_work *offload)
+static void flow_offload_netdev_update(struct flow_offload_work *offload,
+				       struct flow_stats *stats)
 {
-	clear_bit(IPS_HW_OFFLOAD_BIT, &offload->flow->ct->status);
-	flow_offload_tuple_del(offload, FLOW_OFFLOAD_DIR_ORIGINAL);
-	if (test_bit(NF_FLOW_HW_BIDIRECTIONAL, &offload->flow->flags))
-		flow_offload_tuple_del(offload, FLOW_OFFLOAD_DIR_REPLY);
-	set_bit(NF_FLOW_HW_DEAD, &offload->flow->flags);
+	const struct flow_offload_tuple *tuple;
+	struct net_device *indev, *outdev;
+	struct net *net;
+
+	rcu_read_lock();
+	net = read_pnet(&offload->flowtable->net);
+	if (stats[0].pkts) {
+		tuple = &offload->flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple;
+		indev  = dev_get_by_index_rcu(net, tuple->iifidx);
+		if (indev)
+			dev_sw_netstats_rx_add(indev,
+					       stats[0].pkts, stats[0].bytes);
+
+		outdev = dev_get_by_index_rcu(net, tuple->out.ifidx);
+		if (outdev)
+			dev_sw_netstats_tx_add(outdev,
+					       stats[0].pkts, stats[0].bytes);
+	}
+
+	if (stats[1].pkts) {
+		tuple = &offload->flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple;
+		indev  = dev_get_by_index_rcu(net, tuple->iifidx);
+		if (indev)
+			dev_sw_netstats_rx_add(indev,
+					       stats[1].pkts, stats[1].bytes);
+
+		outdev = dev_get_by_index_rcu(net, tuple->out.ifidx);
+		if (outdev)
+			dev_sw_netstats_tx_add(outdev,
+					       stats[1].pkts, stats[1].bytes);
+	}
+	rcu_read_unlock();
 }
 
 static void flow_offload_tuple_stats(struct flow_offload_work *offload,
@@ -968,6 +996,25 @@ static void flow_offload_work_stats(struct flow_offload_work *offload)
 				       FLOW_OFFLOAD_DIR_REPLY,
 				       stats[1].pkts, stats[1].bytes);
 	}
+
+	flow_offload_netdev_update(offload, stats);
+}
+
+static void flow_offload_work_del(struct flow_offload_work *offload)
+{
+	struct flow_stats stats[FLOW_OFFLOAD_DIR_MAX] = {};
+
+	flow_offload_tuple_stats(offload, FLOW_OFFLOAD_DIR_ORIGINAL, &stats[0]);
+	if (test_bit(NF_FLOW_HW_BIDIRECTIONAL, &offload->flow->flags))
+		flow_offload_tuple_stats(offload, FLOW_OFFLOAD_DIR_REPLY,
+					 &stats[1]);
+	flow_offload_netdev_update(offload, stats);
+
+	clear_bit(IPS_HW_OFFLOAD_BIT, &offload->flow->ct->status);
+	flow_offload_tuple_del(offload, FLOW_OFFLOAD_DIR_ORIGINAL);
+	if (test_bit(NF_FLOW_HW_BIDIRECTIONAL, &offload->flow->flags))
+		flow_offload_tuple_del(offload, FLOW_OFFLOAD_DIR_REPLY);
+	set_bit(NF_FLOW_HW_DEAD, &offload->flow->flags);
 }
 
 static void flow_offload_work_handler(struct work_struct *work)
-- 
2.43.0


