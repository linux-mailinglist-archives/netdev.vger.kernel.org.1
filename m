Return-Path: <netdev+bounces-229478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7C6BDCD45
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152FA3BA365
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709EB305948;
	Wed, 15 Oct 2025 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcI6kY0q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8931327D
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512160; cv=none; b=LyaHD1BERGdUKzHVcQS4kjvlrUZqYg5PadGWkcR6QEROFhOZ4vOGJmrlIq+Svext+L+G1UA/kTCLf+FoPYoIiRrY/iquFdoomT6KymjxotrKTh703FOhp+HpvVgLZn0yc4Qmw3uITXyMAT1vKl9y+oRYF3foqWlnv6Zvqk68W/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512160; c=relaxed/simple;
	bh=yd03i++/xv88QJgZo0ZPNbQK9vi5VCi99MKHAR0GtX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoyYjCW2w6dEJCKs4HqwVblwL65BFLA/QJK7UaDr6KAO4QkVON11nWlRZ904jqRxTtiFfS9H8dzj91IigQqo0yZNPY/u9nU5PCDdnzK2d2vP60tSEJni79jASEnUKXDtXPppOX/2ezOnhv+rDEt7mAvfgw2GOC4TIAPifKxtFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcI6kY0q; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso5594167a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760512157; x=1761116957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+Xzhf/EFNne2mEAT5tPrrO/yOV+bjpVxO1xTpLKaG4=;
        b=QcI6kY0qbUbz8Ug3dXubOLDfLs9mt3HYi16UDdTcjdId67R8GCJQVTdP9MvT5a2+9T
         NRfihVnPc2ZSUmCOgW5EZyw3dJJuobkiDdjqwUv2L5msE45UiY8q1TUahpS1g6KbshFo
         XVO7bMkGND2ylJWOOM1Lqeognb4Y0HuCBOIvso/2bCPPOpf0nxJFEOnu11bPPBEefgNN
         Trp0BfCeMRXUCAq4jpCI/edshoKP7BTXV7SQv2ySHTrSp1v3c4CY/han68RztRDq0zCn
         j7EBe+hI2EaWsoM6y0XLI8lxsP0HCgCQTgDdJouVE/et0FTfp0nWnLXFHjULP3ZQ4XWe
         NkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760512157; x=1761116957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+Xzhf/EFNne2mEAT5tPrrO/yOV+bjpVxO1xTpLKaG4=;
        b=oqKKfqNjxWtOBQl2oceyHCXg3ANDq7YnHk5KwATuM/UeTyxdVz2Heg+wjXMnFpdEtY
         gULXZFzO1AVou4cURNmx9m5foyXsH0ioNMB6bl4Fjs5i8OmMfUG/uPzXfy4kVT4SCkcy
         KuR0mQNv/GDz65JBcLtZYphNIJ50MWqxPM03eg2An66UnELXGeU1LKkhyVWewLSw/kK+
         HjBrf+h9KbgxImc8668zBZnQvCQAd5P9kk0BoyMOgLqgI6OH7CuvuNATSMmVQhxIpK8T
         7jWl/9sEgIp4kbwHsIW09Vs0LdZes5niJUYJV9dXU6Kg7UXUBSzlqVV4SZsShhTkh/+v
         VbeA==
X-Gm-Message-State: AOJu0YwC0itOVCAKngIxhOd/3UwiyBbgrkq3/sgMEjSEqRt0QPDBev5n
	Q0FpDnh0c34R438JC62jzS0c4nYn21qOLm9+CprTQV7OtH7/DZKG7SH7
X-Gm-Gg: ASbGncsaFn3CBX9AcRlzMXGxM7CRGT+ndK/5xaco/z1QTukAZYrrqcPIgn8vm3Oyq7L
	mFouiyTEWS+tjF8bA09KHjVhw36gDS9QDxJ0j34nS2sMO8X74n7K3O1L1S7Nsl5aVrV/sO2iW8q
	fMt3m5ICYUftt9dTC1nizxaai9MCAxK11oPej6TtJ4PDlCxqScmkuOc7xm3CBdY6PtusBLsKyeH
	o8TgpAEO1Y2BGnyp+y4R+0PLBaz63FbfuceUV/gw/fFuymTIoc7hHiTPPIQ8rzRGxg6kr+GbP49
	Ze+DHmPDXTaZfi5Kg+1OEnDZHn5R8UzzRcgcgEl9mYTpGfcxCst94qLeHGLHsZnoZrv2tbAaMcv
	fJ5+F04oR9p2/rR4tCcdZtztd8nWgmgF+cqO7mSVDFLlEXp1/zY0vv9pC9I1/ZaeNnY19Wt2S4X
	Hq2Gwu7d5dSEjhEfKbvyzt0w==
X-Google-Smtp-Source: AGHT+IGi4c772T1EvouKGzfpRwCrJWZt2fsMF2Lmdp3HYx9/OqUd/nTP8dW704aXN7545LxIfOBBMQ==
X-Received: by 2002:a17:906:4788:b0:b0c:fdb7:4df5 with SMTP id a640c23a62f3a-b50aa08f7f4mr3152911866b.18.1760512156566;
        Wed, 15 Oct 2025 00:09:16 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccaaba9sm157597666b.55.2025.10.15.00.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 00:09:15 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: tag_brcm: legacy: fix untagged rx on unbridged ports for bcm63xx
Date: Wed, 15 Oct 2025 09:08:54 +0200
Message-ID: <20251015070854.36281-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal switch on BCM63XX SoCs will unconditionally add 802.1Q VLAN
tags on egress to CPU when 802.1Q mode is enabled. We do this
unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configure
VLANs while not filtering").

This is fine for VLAN aware bridges, but for standalone ports and vlan
unaware bridges this means all packets are tagged with the default VID,
which is 0.

While the kernel will treat that like untagged, this can break userspace
applications processing raw packets, expecting untagged traffic, like
STP daemons.

This also breaks several bridge tests, where the tcpdump output then
does not match the expected output anymore.

Since 0 isn't a valid VID, just strip out the VLAN tag if we encounter
it, unless the priority field is set, since that would be a valid tag
again.

Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 net/dsa/tag_brcm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index 26bb657ceac3..32879d1b908b 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -224,12 +224,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 {
 	int len = BRCM_LEG_TAG_LEN;
 	int source_port;
+	__be16 *proto;
 	u8 *brcm_tag;
 
 	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
 		return NULL;
 
 	brcm_tag = dsa_etype_header_pos_rx(skb);
+	proto = (__be16 *)(brcm_tag + BRCM_LEG_TAG_LEN);
 
 	source_port = brcm_tag[5] & BRCM_LEG_PORT_ID;
 
@@ -237,8 +239,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 	if (!skb->dev)
 		return NULL;
 
-	/* VLAN tag is added by BCM63xx internal switch */
-	if (netdev_uses_dsa(skb->dev))
+	/* The internal switch in BCM63XX SoCs will add a 802.1Q VLAN tag on
+	 * egress to the CPU port for all packets, regardless of the untag bit
+	 * in the VLAN table.  VID 0 is used for untagged traffic on unbridged
+	 * ports and vlan unaware bridges. If we encounter a VID 0 tagged
+	 * packet, we know it is supposed to be untagged, so strip the VLAN
+	 * tag as well in that case.
+	 */
+	if (proto[0] == htons(ETH_P_8021Q) && proto[1] == 0)
 		len += VLAN_HLEN;
 
 	/* Remove Broadcom tag and update checksum */

base-commit: 7f0fddd817ba6daebea1445ae9fab4b6d2294fa8
-- 
2.43.0


