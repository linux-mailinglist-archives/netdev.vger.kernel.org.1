Return-Path: <netdev+bounces-233299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C5C11464
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 20:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E63A14FE79C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 19:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390031FA859;
	Mon, 27 Oct 2025 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHxajL7a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F70A2D7DC7
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594395; cv=none; b=Q2xmdmnEyKzRPEiFrcbxr/o70u3/GJ+pq2z29kyymZd3beim1ishZe70H73GPU4svjQC2IELI4UTN1UCzZMNOXHfVkdHeOuVXmLakjwGtbheQj2zpYYbnOR+3y3x6ISniyjPpUr+1EMAS0bCDJ8HG4tx02rUUTstBcWDzmSvCSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594395; c=relaxed/simple;
	bh=znaD9C1ITWlqa4RUrGrN4zi74wNoaCwyD9gcXPwB/h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aCbVfxNoPAX6yv2owolPhq4chxL8HMOH7aAYoqgFopBmGjqfCW/TB7G18mC3FS3aP0QV83jOVCQGRliMyjAEK93d0CM4R5hoI5FyKGhek+7gmNvpTo0l1baiXWg03HyK7Slsx+hspQn3NAmCVTEMSoXM9lQ3uPEpV3xtfccxo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHxajL7a; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso8128755a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 12:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761594392; x=1762199192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfHwNRKmLdBsQOGHfDtNbPOh+J8Tob6C3j78UQkTd5c=;
        b=cHxajL7aQYaMbf3bHhbnBgGDxxlSUUi3CsB4Y0WLXZzuTNXMAQXeHHNSDQyrzIXUzf
         FV8mxEF8jKWhq5J5Fhf7rAzitR0nvuUklaPpsg5XZdsthPQ2eSlnIPZ2wQDQiQTGwXkA
         mdfItaZKxWQ6ucmn6PTV9by14b8lj+4SvNNdnHrlu01lhbJplMVMPZFvMw0KJ+EWv4pG
         lLlmm+nj6N9H0nZue+gfMJtwgTMgSUCouZ28DURFX29C08LC7ls0Ydh7dkEVFPXr9BME
         OtzZu0rhcCa4k0D/owlaOt72Wufy9FXQAXWwEYhOouMWGfIct8Kl37YluRUhH6dxFNmb
         YKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761594392; x=1762199192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfHwNRKmLdBsQOGHfDtNbPOh+J8Tob6C3j78UQkTd5c=;
        b=DPQpj6jwI5poj6Jv3jnd4KNCOENybPpb7vrbMrF0bXdT9V7lUQqB3eJrWzic1zVdym
         eai4cxZoejABSDnECk9Cc6HfL4PIK3g/AGm21PwGI0v85ChFpJZGW+2l4vgdKFz7OgF0
         daA4BMNwaI7nVq7V+t5guv/ywBIWWu3LweNouUIG2tYxDPODuHujMNaL0q0LCYd6S3S8
         6fB2fkArDd6STvH22hxHMPgd5Zsw/UshI2ne7BboaaeyYhnKfqYLRluR2LbiKauPTeXu
         iwOO4wGFHY7SMczCefkBKjC+jl0rMW6jVKDsm3CwV7rLUgNsiIldmfWVyj6iYIxqpRuL
         KquQ==
X-Gm-Message-State: AOJu0YwZOp2y9GNTI4byPlAuPBtj2VTIlufRv4o5TrPkTzOChSiEuxNY
	ZaB1zWMfp6OJBr27TN595LWa0E3F5NolboZIWythLKsEX8IS9DhMzavB
X-Gm-Gg: ASbGncvpzea0UlumMGpKTIjmxLskUxqnPUgjN/4S5RsQ5Vpllg8ug+kMytOgAO49s0F
	4GZCjdJAtah7xgSP3niiyV1vZuJhBFKrPnGOiDxn0hnPMi8mNxbD3M2TXZaVy7X0xz/bp1Pkwfv
	bzMWAwEogjUC5XgWpLP/VKmPtx35/KcFTNaTA7eeEsxpoZIntjqwoocgVopH8sLBi4B/UquaTzj
	/jq3lCBIIwuQm9kTFedJOJrte2p1bhWdJx7SsiaspSsi3nk/o5AKJXElbiKk2otH5bx6KRY6BCG
	CjLNUlSkZ4Z9PFAN1nXEvjP87s/ZRzNFIBwOISHgJ0LtgRFns1QTLwXopZ4H7N3A4XpOXeK3pVf
	JyabFlG7SnYjPOKpDaTWqNJA9cxVp1Ou/8kCqPVymwL4rFjM3XwDaifGQfaTV6G3AEy3DT9fFQa
	QrYduiF2y++cF6kDXa2tPBcFqCqzIwjYYSE5vVG102o3GtwL5hmKRjI8QZlZLDoIf5BA==
X-Google-Smtp-Source: AGHT+IFaQrXgEZiPvJMRaaPNtsLgHDcXezwU0wDasdjJ3W+gyc1PWGYIPhmSCVU2aunfIh4C6JTOOA==
X-Received: by 2002:a05:6402:50d4:b0:63c:13b9:58b0 with SMTP id 4fb4d7f45d1cf-63f4bcb05bemr575785a12.5.1761594391575;
        Mon, 27 Oct 2025 12:46:31 -0700 (PDT)
Received: from localhost (dslb-002-205-023-060.002.205.pools.vodafone-ip.de. [2.205.23.60])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb9fa6sm7039317a12.31.2025.10.27.12.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:46:30 -0700 (PDT)
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
Subject: [PATCH net v2] net: dsa: tag_brcm: legacy: fix untagged rx on unbridged ports for bcm63xx
Date: Mon, 27 Oct 2025 20:46:21 +0100
Message-ID: <20251027194621.133301-1-jonas.gorski@gmail.com>
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
v1 -> v2:
 * rewrote the comment to make it less wordy (hopefully not too terse)

 net/dsa/tag_brcm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index 26bb657ceac3..d9c77fa553b5 100644
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
 
@@ -237,8 +239,12 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 	if (!skb->dev)
 		return NULL;
 
-	/* VLAN tag is added by BCM63xx internal switch */
-	if (netdev_uses_dsa(skb->dev))
+	/* The internal switch in BCM63XX SoCs always tags on egress on the CPU
+	 * port. We use VID 0 internally for untagged traffic, so strip the tag
+	 * if the TCI field is all 0, and keep it otherwise to also retain
+	 * e.g. 802.1p tagged packets.
+	 */
+	if (proto[0] == htons(ETH_P_8021Q) && proto[1] == 0)
 		len += VLAN_HLEN;
 
 	/* Remove Broadcom tag and update checksum */

base-commit: 84a905290cb4c3d9a71a9e3b2f2e02e031e7512f
-- 
2.43.0


