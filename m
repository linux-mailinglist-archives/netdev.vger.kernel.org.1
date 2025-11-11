Return-Path: <netdev+bounces-237696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3EBC4F09D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7478C4E2A4A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD39E1D6195;
	Tue, 11 Nov 2025 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtameCjG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102BF257835
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878640; cv=none; b=Hm8JhLfg7lQd5USnxp1kORwu/SRR8UlAnvphAHQDELnztqBL0mc4GWfc/mQAyTFgWNsyIQMl6VxcGVwMiGoUug8lGqQrm9viD1mDNIjgrB83UMP73nK7LQmowvq3DdQzsDDg4N+Hy11uHwBbyCv4Ndeb6Pf+eio3sK/dVh+6lfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878640; c=relaxed/simple;
	bh=3bXZ5v9dkwEc5Ks8W4hzc0cKIciuQWusVaqeWoP/MRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUiKXTyCfInpjJve75Hq34tTq2zNkIN8xiepr670ouQAeb+nT6J2vUGgT50j+w7BEDHKN+jjRXWiSOO5CWiZq3jfZKlNGi7ep0fklDgG05blOERDgmcLJdkKCTzRlKSGiY9WXJRf66uEpESswps9UrBJ+7GRJ1W7LfwV8/Q+TB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtameCjG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762878638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sr5cWDjz4amzAYWu9EJS7Cs7EVWuhNbi0b56R2DoCok=;
	b=dtameCjGJo5D9YgQi26480HqPLgKEn2GlEFnnPx+F2SNl1iKJlwj/O8HrpgJHjSeiIEp07
	mQPYT0V5n5l6thxrP6ft5kjCMN+rq9u0XTakynLYpRAL4fkFIlV6U9cEClY/Tf+caKuPNg
	zthM+nRGfZefXcTkjofxktpy8Etz/RQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-aFPkGfDdMnGQL2p0pbdruA-1; Tue,
 11 Nov 2025 11:30:33 -0500
X-MC-Unique: aFPkGfDdMnGQL2p0pbdruA-1
X-Mimecast-MFC-AGG-ID: aFPkGfDdMnGQL2p0pbdruA_1762878630
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0775A180035F;
	Tue, 11 Nov 2025 16:30:30 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB54C180049F;
	Tue, 11 Nov 2025 16:30:26 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: liuhangbin@gmail.com,
	m-karicheri2@ti.com,
	arvid.brodin@alten.se,
	bigeasy@linutronix.de
Subject: [PATCH net 2/2] hsr: Follow standard for HSRv0 supervision frames
Date: Tue, 11 Nov 2025 17:29:33 +0100
Message-ID: <ea0d5133cd593856b2fa673d6e2067bf1d4d1794.1762876095.git.fmaurer@redhat.com>
In-Reply-To: <cover.1762876095.git.fmaurer@redhat.com>
References: <cover.1762876095.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

For HSRv0, the path_id has the following meaning:
- 0000: PRP supervision frame
- 0001-1001: HSR ring identifier
- 1010-1011: Frames from PRP network (A/B, with RedBoxes)
- 1111: HSR supervision frame

Follow the IEC 62439-3:2010 standard more closely by setting the right
path_id for HSRv0 supervision frames (actually, it is correctly set when
the frame is constructed, but hsr_set_path_id() overwrites it) and set a
fixed HSR ring identifier of 1. The ring identifier seems to be generally
unused and we ignore it anyways on reception, but some fixed identifier is
definitely better than using one identifier in one direction and a wrong
identifier in the other.

This was also the behavior before commit f266a683a480 ("net/hsr: Better
frame dispatch") which introduced the alternating path_id. This was later
moved to hsr_set_path_id() in commit 451d8123f897 ("net: prp: add packet
handling support").

The IEC 62439-3:2010 also contains 6 unused bytes after the MacAddressA in
the HSRv0 supervision frames. Adjust a TODO comment accordingly.

Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
Fixes: 451d8123f897 ("net: prp: add packet handling support")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 net/hsr/hsr_device.c  |  2 +-
 net/hsr/hsr_forward.c | 22 +++++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 1235abb2d79f..492cbc78ab75 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -337,7 +337,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 	}
 
 	hsr_stag->tlv.HSR_TLV_type = type;
-	/* TODO: Why 12 in HSRv0? */
+	/* HSRv0 has 6 unused bytes after the MAC */
 	hsr_stag->tlv.HSR_TLV_length = hsr->prot_version ?
 				sizeof(struct hsr_sup_payload) : 12;
 
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index c67c0d35921d..339f0d220212 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -262,15 +262,23 @@ static struct sk_buff *prp_fill_rct(struct sk_buff *skb,
 	return skb;
 }
 
-static void hsr_set_path_id(struct hsr_ethhdr *hsr_ethhdr,
+static void hsr_set_path_id(struct hsr_frame_info *frame,
+			    struct hsr_ethhdr *hsr_ethhdr,
 			    struct hsr_port *port)
 {
 	int path_id;
 
-	if (port->type == HSR_PT_SLAVE_A)
-		path_id = 0;
-	else
-		path_id = 1;
+	if (port->hsr->prot_version) {
+		if (port->type == HSR_PT_SLAVE_A)
+			path_id = 0;
+		else
+			path_id = 1;
+	} else {
+		if (frame->is_supervision)
+			path_id = 0xf;
+		else
+			path_id = 1;
+	}
 
 	set_hsr_tag_path(&hsr_ethhdr->hsr_tag, path_id);
 }
@@ -304,7 +312,7 @@ static struct sk_buff *hsr_fill_tag(struct sk_buff *skb,
 	else
 		hsr_ethhdr = (struct hsr_ethhdr *)pc;
 
-	hsr_set_path_id(hsr_ethhdr, port);
+	hsr_set_path_id(frame, hsr_ethhdr, port);
 	set_hsr_tag_LSDU_size(&hsr_ethhdr->hsr_tag, lsdu_size);
 	hsr_ethhdr->hsr_tag.sequence_nr = htons(frame->sequence_nr);
 	hsr_ethhdr->hsr_tag.encap_proto = hsr_ethhdr->ethhdr.h_proto;
@@ -330,7 +338,7 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
 			(struct hsr_ethhdr *)skb_mac_header(frame->skb_hsr);
 
 		/* set the lane id properly */
-		hsr_set_path_id(hsr_ethhdr, port);
+		hsr_set_path_id(frame, hsr_ethhdr, port);
 		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
 	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
 		return skb_clone(frame->skb_std, GFP_ATOMIC);
-- 
2.51.0


