Return-Path: <netdev+bounces-149986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9541C9E8614
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749CA164FA2
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAEC16190B;
	Sun,  8 Dec 2024 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="x0Wk2VkA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1816D9AF
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673172; cv=none; b=tmSIPEc7zTCjNxPa1mTcQFn/ZFnJnVF0aedgVFcxeaqihV3f64eRV0pn2DSZKbz5LNcYDolkVZ2C+cXeiUCC9AYcL3wrOAvcKtImaqgW3RiY+uUAyzaW05j+QJXRMOIoOlEMnNrjqXFIh7h94go3t/onC140tH7z5Ij3MtzMy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673172; c=relaxed/simple;
	bh=HyyWUkVImKTbnfUbDT8H94jFhoM3eDYkpcrXi4gTshE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udxDpVRq0TbpIgeHMgp5nFRx97Tx9FiJhaX+Dbw9C2Zit7iyssra7Upk4kEM5ke1eYY5zpWTHlIdaBGCshbX1YlgjpV8HOgTNaBWuaP9JTx9KNYVJ9w1jHRj6zsfGx5XHd4zQn5yJIKGZ+CgjohMS47R9FWpAMRXlMSJIAWvq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=x0Wk2VkA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30219437e63so5976811fa.1
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733673169; x=1734277969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJl98tLA1KqA94ObFzxMBXTp9IXq9js5q87hBKbnvrg=;
        b=x0Wk2VkAF0goOOK9oA5ZQyOFU7541kKbRDUhCxBiBiP13EQpMeUSKSrSqThZcm7wFG
         BWCNbrThqdrJDPbgzoBc9XjN9x7/eh2pNT/HErJPJNx6yoLK5EnADw/7DozfAyWyNPvE
         h8/3n5yfZ2TYGY2rVOnVDzttFCE8SYVwib1Kirq+v2558bEIRb0SEc43PKJNSjvLi8AJ
         tG8SCmRhCdSw0YgX9/0wII4vH9fCU6CAoHNQo3qvAby1iZiV+RMvFbhdq8FPnNicYaDw
         DsGrcwjOxml7PyNKBnJlLCxLf2FbuttzNP+gEB5Ix2zZUGdwaJeOwDHzDBss6BwuUDHT
         i7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733673169; x=1734277969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJl98tLA1KqA94ObFzxMBXTp9IXq9js5q87hBKbnvrg=;
        b=v586O02Up/OU1fWn4sRzQKwCXf2Z817WrE8sArbFrvDYc9W8tZ20kDlPtcPurVy/LD
         bcdPc5IFDeROViCmISflu3ORjGlPK2Kl4/qVsm4iQPEyJ4rkxIDkfXIOmMIivvn2174V
         ipDVruylPEUtibuo/9U/P1k+x1pH7SNJ70V802qno8l9bfCAz6wV5Nf2JmXo+QycUp8x
         85BbH7cA9q2oHZwtwfDSxkMfY7dp4/xZDSzLg6NP2eW+uJ3fEbAMZJn5hNeKc9Sh5VST
         /sYlmtbYebsjcAa+5vPr5UioqF+UoXpoHbvtqFeRsidsH/ePsaNuTkhZsqVvpaGcsFEW
         QvAg==
X-Gm-Message-State: AOJu0YxRfOZmmo+vfVMuGyic6gokJa79CQwiWT5CXqinjmZET8TpFFHG
	/1AMKEb+nDmpbxUfA7EOPk4VQHiXS2fvGz46Lk7H6h4ta+vdFGlWsLTjNZnbCHA=
X-Gm-Gg: ASbGnctLecagESyFIodTu9U3SAkV3pw2py2jQOyh8zeczXx9dCHhR6O9Bpd1SqiqpbL
	VF71M3eXdVhzIMsiTTL7AvudIlTPodapkE90f3eHSHvJJ35F0qL4AMShc9tmt1Undb8EPuI2sUw
	hARGmjMJYv1zIXtvb6yi5LgDJO+iiW5/BSbGLcT6DrQyIbm6b3X3R9XB5AsoS0UA2ywPF/CgZUv
	luTcpH/z6Twz/9A8lIYs4zB7JuPBJFwik9acLoe+5WfeMKHOQ1OpUafoLWKEaF1
X-Google-Smtp-Source: AGHT+IH3PSTZTHavCvoa1I3kEsvmuL+iD0caZGd6QozHV+KkfcwNGoYPhdqy84lNEnLmvIZv5Ekjcg==
X-Received: by 2002:a05:6512:6d2:b0:53e:16eb:d845 with SMTP id 2adb3069b0e04-53e2b7328d9mr3358489e87.18.1733673169476;
        Sun, 08 Dec 2024 07:52:49 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3a1ce70bsm580882e87.66.2024.12.08.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 07:52:49 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next 4/4] net: renesas: rswitch: add mdio C22 support
Date: Sun,  8 Dec 2024 20:52:36 +0500
Message-Id: <20241208155236.108582-5-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
References: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic MPSM operation added by the previous patch can be used both
for C45 and C22.

Add handlers for C22 operations.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 8dc5ddfee01d..444e7576b31c 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1225,6 +1225,23 @@ static int rswitch_etha_mii_write_c45(struct mii_bus *bus, int addr, int devad,
 				    MPSM_POP_WRITE, val);
 }
 
+static int rswitch_etha_mii_read_c22(struct mii_bus *bus, int phyad, int regad)
+{
+	struct rswitch_etha *etha = bus->priv;
+
+	return rswitch_etha_mpsm_op(etha, true, MPSM_MMF_C22, phyad, regad,
+				    MPSM_POP_READ_C22, 0);
+}
+
+static int rswitch_etha_mii_write_c22(struct mii_bus *bus, int phyad,
+				      int regad, u16 val)
+{
+	struct rswitch_etha *etha = bus->priv;
+
+	return rswitch_etha_mpsm_op(etha, false, MPSM_MMF_C22, phyad, regad,
+				    MPSM_POP_WRITE, val);
+}
+
 /* Call of_node_put(port) after done */
 static struct device_node *rswitch_get_port_node(struct rswitch_device *rdev)
 {
@@ -1307,6 +1324,8 @@ static int rswitch_mii_register(struct rswitch_device *rdev)
 	mii_bus->priv = rdev->etha;
 	mii_bus->read_c45 = rswitch_etha_mii_read_c45;
 	mii_bus->write_c45 = rswitch_etha_mii_write_c45;
+	mii_bus->read = rswitch_etha_mii_read_c22;
+	mii_bus->write = rswitch_etha_mii_write_c22;
 	mii_bus->parent = &rdev->priv->pdev->dev;
 
 	mdio_np = of_get_child_by_name(rdev->np_port, "mdio");
-- 
2.39.5


