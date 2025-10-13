Return-Path: <netdev+bounces-228834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE8BD525D
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EDB4849B5
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257F03128AC;
	Mon, 13 Oct 2025 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpbuzf6C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDD30E842
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369328; cv=none; b=EjvQGx3SQxsKM0uGMhtSdVCHK/P5+vbLYCA1fCBAAPxj3275AgAb//gj3dlZ1F/2TVjqhUWAJcQc5QF50KJb4wJEZw55kyguNproFkulH4scIEM56ywWHyjdoNFNquofuZFaWLrc57mtOHbotaGdzcitZi8MwMRIb4DggatEn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369328; c=relaxed/simple;
	bh=WlMp0vM5w20TCEI5Z+Msdakq5JZXQl9RpmysD9Cx0EU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=udTOnHjj0V2Cj9JY6ToPwLRc44OTPkLAyoeCchoTBPcPmkez5RHafxPwCXGAdL/atuJOjHDbeXc/G2c7TSIYysHIZ2w8HM3cvHwO8YfYy/ffmIvzFdM4wujdh1l4PGVtNnvLgCSd3XNI/udEpCLJ3/uWOG/Jp9BV/sdWMSjwJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpbuzf6C; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so8555478a12.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760369324; x=1760974124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bwMSoXVUaeG8vhH/f/stQ8wxLvQaR89cQ6n9U3aN0cs=;
        b=lpbuzf6CuyoNRN7hwEpS1PfTAze9vbuY+EIU7/hxY0K+2Y2vRYcKJEx+0hhAGPtFDv
         UTEP+vER94L2I61RWUcvq4/htmTWGbqN1xm0T+NQ3R2QEXajwIJ7uvn7GLf9/qTY56ip
         C21qKUnGX0dX5iTGp9f4aYPeXNh/VGHcSAR3jKq2Oje9T2gFYJeYBGm/CcPBamWyMjD5
         pSSAae4fry5p622EeH7yhrlgSjVhuwVRuV+6gq+x4V14RI7hW023uF/o4afZEN8ydake
         t/H5glPYJYH8Aw/zl2RTcGuuwRzDteSLAal1LkRbh3R/xrjFfcbdejOAN9YftVWIuack
         FoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369324; x=1760974124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwMSoXVUaeG8vhH/f/stQ8wxLvQaR89cQ6n9U3aN0cs=;
        b=JLcGArWFcgvpjlM2k9MuIDvVQlzIAzhVomQLcY0Py1TxDLDxhDH8ym4h2gJxk3kU72
         n7NT9XSIHlGRHan3XnIG36dxjFhAwt796dydrb43Kl1HOV0QGUIJI5tjlZ2CKGxtUsH9
         CU5KDs8LIgPPjTpCcP40aVfLh8DjUdRoITt7X+kqw0bFkrTY1AbdD9990uYWx7ACkpFl
         BI/hZ82vMwjfty3DyNhp7uqL/skH/nOD1nGIT2G9rkXi9VsDzFoa0RGo8lGRdnIEkfm3
         NpsIj5M+CPrJYl6ls0xwFmhm/BR3G9iln7SMp60SJpRUn+HC5T/k3iz4MIWAfRgPC8dH
         Pylg==
X-Gm-Message-State: AOJu0Yy4ZlDQK/+Hs25Vvbj4sTizYhPJ1m9gY5ATqnB5R2CO1yGBHxB5
	BgGBA+EuMDl1c9Inv1RfF0/RMAman5uRBRaVyDjVQdat54SRtvW18L9h
X-Gm-Gg: ASbGncspZmu6RtM4I9vuujSFBCt50UyRn2vmYl+f7frQaDC6zNwjZBEIMJHbiOAjg9Y
	YXwsiP1s0cYY1GvD8XG8SfIvc296waiY1Pc36wGEdtgqYyrfmAjBWnbJmGK+EJjoJW/Kj2c+TcH
	wUyuf0bID+A4auQ1UwPJUR2KVE/oBbkfbbSigeB9QMSenm0jg84L/N4Sr4/I0DvbzAXqR09YqKe
	aavBWykY/WeNhl5pQKH/OEIxL9mbukqAxLwVh8WZme3VIIBWislRLIZIysQpndADsSDcb02fyvM
	nC/hU4zyrBkkHA8JddF8pnGNbZJDEmROybqmRJzpmcVR21CJ3Ma2tzaM2Kym18iQxePDkSV5Og2
	EAfrzqHx75HHxvXNCgo0k0x+mWdJVgZWS3VGgEuI5xKmC78CS4h6pbpBDt7xFWVxFgz/E1r4/My
	mgsCi6WmxMrUF3Q4WAkAqNjeAMgIDYp9Ay
X-Google-Smtp-Source: AGHT+IH/kEGoSsNgpEJrmB2dhN7tK52GxxyaIXJai0G9MWbbAFq1kxi5vMJMyYElb4dKfPJMviVOZw==
X-Received: by 2002:a17:907:68a2:b0:b54:858e:736f with SMTP id a640c23a62f3a-b54858e73a1mr1347210266b.36.1760369324234;
        Mon, 13 Oct 2025 08:28:44 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad8dasm965607766b.4.2025.10.13.08.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:28:43 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: b53: implement port isolation support
Date: Mon, 13 Oct 2025 17:28:34 +0200
Message-ID: <20251013152834.100169-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement port isolation support via the Protected Ports register.

Protected ports can only communicate with unprotected ports, but not
with each other, matching the expected behaviour of isolated ports.

Tested on BCM963268BU.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 25 ++++++++++++++++++++++++-
 drivers/net/dsa/b53/b53_regs.h   |  4 ++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 2f846381d5a7..ad4990da9f7c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -632,6 +632,25 @@ static void b53_port_set_learning(struct b53_device *dev, int port,
 	b53_write16(dev, B53_CTRL_PAGE, B53_DIS_LEARNING, reg);
 }
 
+static void b53_port_set_isolated(struct b53_device *dev, int port,
+				  bool isolated)
+{
+	u8 offset;
+	u16 reg;
+
+	if (is5325(dev))
+		offset = B53_PROTECTED_PORT_SEL_25;
+	else
+		offset = B53_PROTECTED_PORT_SEL;
+
+	b53_read16(dev, B53_CTRL_PAGE, offset, &reg);
+	if (isolated)
+		reg |= BIT(port);
+	else
+		reg &= ~BIT(port);
+	b53_write16(dev, B53_CTRL_PAGE, offset, reg);
+}
+
 static void b53_eee_enable_set(struct dsa_switch *ds, int port, bool enable)
 {
 	struct b53_device *dev = ds->priv;
@@ -652,6 +671,7 @@ int b53_setup_port(struct dsa_switch *ds, int port)
 	b53_port_set_ucast_flood(dev, port, true);
 	b53_port_set_mcast_flood(dev, port, true);
 	b53_port_set_learning(dev, port, false);
+	b53_port_set_isolated(dev, port, false);
 
 	/* Force all traffic to go to the CPU port to prevent the ASIC from
 	 * trying to forward to bridged ports on matching FDB entries, then
@@ -2318,7 +2338,7 @@ int b53_br_flags_pre(struct dsa_switch *ds, int port,
 		     struct netlink_ext_ack *extack)
 {
 	struct b53_device *dev = ds->priv;
-	unsigned long mask = (BR_FLOOD | BR_MCAST_FLOOD);
+	unsigned long mask = (BR_FLOOD | BR_MCAST_FLOOD | BR_ISOLATED);
 
 	if (!is5325(dev))
 		mask |= BR_LEARNING;
@@ -2343,6 +2363,9 @@ int b53_br_flags(struct dsa_switch *ds, int port,
 	if (flags.mask & BR_LEARNING)
 		b53_port_set_learning(ds->priv, port,
 				      !!(flags.val & BR_LEARNING));
+	if (flags.mask & BR_ISOLATED)
+		b53_port_set_isolated(ds->priv, port,
+				      !!(flags.val & BR_ISOLATED));
 
 	return 0;
 }
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 309fe0e46dad..c16b3e3e8227 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -120,6 +120,10 @@
 #define B53_SWITCH_CTRL			0x22
 #define  B53_MII_DUMB_FWDG_EN		BIT(6)
 
+/* Protected Port Selection (16 bit) */
+#define B53_PROTECTED_PORT_SEL		0x24
+#define B53_PROTECTED_PORT_SEL_25	0x26
+
 /* (16 bit) */
 #define B53_UC_FLOOD_MASK		0x32
 #define B53_MC_FLOOD_MASK		0x34

base-commit: 18a7e218cfcdca6666e1f7356533e4c988780b57
-- 
2.43.0


