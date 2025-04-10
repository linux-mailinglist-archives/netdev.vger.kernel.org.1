Return-Path: <netdev+bounces-181354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCFEA84A38
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295AA8A8EAA
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F4C2900AE;
	Thu, 10 Apr 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw6gvsAT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8728FFF7;
	Thu, 10 Apr 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302660; cv=none; b=EVwn8GKswX679cWnEiykoJrhDjae4mJpcxkz2YBcNEAqXv/mi3TDsvnmPpQX1Pw5rFQ+RLhfNNISHLzr+5B+xFcoyxhLXjM1Wqu6LROO1BgBJG1bLHGoJpknyhLlN/gCtAo+zTPTDP/RrtnOsHR7x1+AHm7hpYWBvhecdJ4nhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302660; c=relaxed/simple;
	bh=x1NGnsxiq3XODZrcpdPY8CFLV7LILCF+Jyd9E/F1GU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=almVHkR1vyk90ruh4mucXnUTnHtQuO5uOHXXO2unIkTbD7a4k207xDYOKCbUbfvr0lbB7qbqqPSRHY7h1y4ehtZiGTfXXLRJ2+nUff7v3UvAOLwYTAQdZ5r8BHU1XdybRn7qreZAtkRigWu9ATk3VDwlTkS9XLvnmS6qZf0mbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aw6gvsAT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39ac9aea656so948301f8f.3;
        Thu, 10 Apr 2025 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744302657; x=1744907457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViHFmfH38BAXSZxC5pAxZ33XZ4lXrW0Sii8iMmrd1Zo=;
        b=aw6gvsATwoaLoCdSxt0UYMaVZ1Kwt8GhjubHf2QBzqFR0O3hFwqhJXXMKPU/rbJvxg
         952feE5mfZLbYjD8yxT/HOqyfDcjEKbX33XPXalT2TrexkWOli0ZfAleo09m/Y/4xw9r
         YYh+JqNBGiH2B6aGrB0FWiQCoi+N7/ce1U18cRMO93QMl8DdIRSz0MUxZpJmcbpdb8sP
         fu2UANn/OWHGWGXzpbGtmaAXkW2Wud3zUvuoTFeET5nK/F/2sUprWCn//v8FXzHBJug9
         roeuKD9rBODHiKPVQXuI1VNSc8xcWjfxwqMexiRwPJjmXs56AL/wsNw4q7hNVg9/84oq
         do+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744302657; x=1744907457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViHFmfH38BAXSZxC5pAxZ33XZ4lXrW0Sii8iMmrd1Zo=;
        b=aSeEJmzEfI90XYdcwFxjWWHTRKIbeMgDJgg6FhmQJxyWRGhNE1pGF6cSN5uKV89iK2
         Il0kc+qa2YFk8gy2cl/UhygdXr3GMruMkY6byfZNJaqC8FIYVQJS1qWQ6a1NDprAHsdW
         MyU6GcrIVPz5eQhcomONPYyys218xE2gFlURRkOSq6X3NAKdPwhLJlwZozdT1s4BWZN+
         +eTIgHe+pdAD/X/YemajDg1rpWOQx+A+EEosA8YoPz+Dv22dwkS4b47lzXWtBpmSHkfy
         PdoxYtsEvvUd3aCx25yxZvETSUwNlBhKhdLFwkR9fpUcPYR0XVC299yqE8f1vkksbHzV
         dvMw==
X-Forwarded-Encrypted: i=1; AJvYcCVlACAjdOZq8J620X0rhQWTHqefwjXu3mCpr2rbjBs12a4WjteLWhlkf9hAEjBNDV8f/J7uG8U1JQgMX94=@vger.kernel.org, AJvYcCXSSNRvN/zPZ/uDXfWwOhWFS60o+I5dXIc8L98LZaQ+0gmKtKJXm6kSrg6A0ELsgYORHbFn+L/3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8is3k/qblRlUoTwtG3V6fjvRDKyz/MQLlMA3zD5OkXC+4KDTY
	tt5FRfhcs/48NTRrKM1W1p4bbWQeJfbog/WQZ5m+U5/f1cCk9WgJ
X-Gm-Gg: ASbGncvQlAX1JG0Tg6MFUe9f/4KRtWJigvcJpd1PqH/8tMejm+rOhp6F+d1CBSKl4bG
	h1vmftfFSCcCPkXj5iIOJkJrrl03uA6Se12bw0+lF0B6UARbaDYolkFJR9SWclZW6sgE8/lQY5m
	qRPkU6cMN6YCKKR94Ef3+lNDcqCC0Skl9ISW8OxXbcWlKYrnaML0FhvkwI5MoW8ejf9gIVjIFJd
	eXkeuFtQ73YXsuKf6pdjwi43HjOxXErb3/MivDaZHKEAljFZicUkTFCJsCmJ1+AXT5jY9ipb6ic
	fZEJveruAgoCSLYhtlv33hg/nWWGPcr12DjmZ9SRbHHlwY3SpIcfmv8VWwc5nKL+XOuf4r3AveQ
	7KUDm9mEhdw==
X-Google-Smtp-Source: AGHT+IHPWlln/QzRNYimnmyb+Y3Gk2occy0aK6leRTpIX0XYqPpPMw7MZql9NWWJQQmfp/HL3MfMOQ==
X-Received: by 2002:a05:6000:2507:b0:39c:12ce:6a0 with SMTP id ffacd0b85a97d-39d8fd470a3mr3124611f8f.21.1744302656743;
        Thu, 10 Apr 2025 09:30:56 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39d893f0a75sm5374033f8f.62.2025.04.10.09.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:30:56 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 3/6] net: dsa: mt7530: move pause MIB counter to eth_ctrl stats API
Date: Thu, 10 Apr 2025 18:30:11 +0200
Message-ID: <20250410163022.3695-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410163022.3695-1-ansuelsmth@gmail.com>
References: <20250410163022.3695-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop custom handling of TX/RX pause frame MIB counter and handle
them in the standard .get_eth_ctrl_stats API

The MIB entry are dropped from the custom MIB table and converted to
a define providing only the MIB offset.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/mt7530.c | 15 +++++++++++++--
 drivers/net/dsa/mt7530.h |  2 ++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 54a6ddc380e9..f183a604355e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -43,7 +43,6 @@ static const struct mt7530_mib_desc mt7530_mib[] = {
 	MIB_DESC(1, 0x20, "TxDeferred"),
 	MIB_DESC(1, 0x24, "TxLateCollision"),
 	MIB_DESC(1, 0x28, "TxExcessiveCollistion"),
-	MIB_DESC(1, 0x2c, "TxPause"),
 	MIB_DESC(2, 0x48, "TxBytes"),
 	MIB_DESC(1, 0x60, "RxDrop"),
 	MIB_DESC(1, 0x64, "RxFiltering"),
@@ -52,7 +51,6 @@ static const struct mt7530_mib_desc mt7530_mib[] = {
 	MIB_DESC(1, 0x70, "RxBroadcast"),
 	MIB_DESC(1, 0x74, "RxAlignErr"),
 	MIB_DESC(1, 0x78, "RxCrcErr"),
-	MIB_DESC(1, 0x8c, "RxPause"),
 	MIB_DESC(2, 0xa8, "RxBytes"),
 	MIB_DESC(1, 0xb0, "RxCtrlDrop"),
 	MIB_DESC(1, 0xb4, "RxIngressDrop"),
@@ -867,6 +865,18 @@ static void mt7530_get_rmon_stats(struct dsa_switch *ds, int port,
 	*ranges = mt7530_rmon_ranges;
 }
 
+static void mt7530_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+				      struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct mt7530_priv *priv = ds->priv;
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PAUSE, 1,
+			       &ctrl_stats->MACControlFramesTransmitted);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PAUSE, 1,
+			       &ctrl_stats->MACControlFramesReceived);
+}
+
 static int
 mt7530_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 {
@@ -3154,6 +3164,7 @@ const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_ethtool_stats	= mt7530_get_ethtool_stats,
 	.get_sset_count		= mt7530_get_sset_count,
 	.get_rmon_stats		= mt7530_get_rmon_stats,
+	.get_eth_ctrl_stats	= mt7530_get_eth_ctrl_stats,
 	.set_ageing_time	= mt7530_set_ageing_time,
 	.port_enable		= mt7530_port_enable,
 	.port_disable		= mt7530_port_disable,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 9bc90d1678f7..a651ad29b750 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -424,6 +424,7 @@ enum mt7530_vlan_port_acc_frm {
 /* Register for MIB */
 #define MT7530_PORT_MIB_COUNTER(x)	(0x4000 + (x) * 0x100)
 /* Each define is an offset of MT7530_PORT_MIB_COUNTER */
+#define   MT7530_PORT_MIB_TX_PAUSE	0x2c
 #define   MT7530_PORT_MIB_TX_PKT_SZ_64	0x30
 #define   MT7530_PORT_MIB_TX_PKT_SZ_65_TO_127 0x34
 #define   MT7530_PORT_MIB_TX_PKT_SZ_128_TO_255 0x38
@@ -434,6 +435,7 @@ enum mt7530_vlan_port_acc_frm {
 #define   MT7530_PORT_MIB_RX_FRAG_ERR	0x80
 #define   MT7530_PORT_MIB_RX_OVER_SZ_ERR 0x84
 #define   MT7530_PORT_MIB_RX_JABBER_ERR	0x88
+#define   MT7530_PORT_MIB_RX_PAUSE	0x8c
 #define   MT7530_PORT_MIB_RX_PKT_SZ_64	0x90
 #define   MT7530_PORT_MIB_RX_PKT_SZ_65_TO_127 0x94
 #define   MT7530_PORT_MIB_RX_PKT_SZ_128_TO_255 0x98
-- 
2.48.1


