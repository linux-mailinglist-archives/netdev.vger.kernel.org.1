Return-Path: <netdev+bounces-194658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22652ACBBDD
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E341716EE9C
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F37222D9F3;
	Mon,  2 Jun 2025 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdFOxf0K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964322D4F6;
	Mon,  2 Jun 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893209; cv=none; b=X4y7lFgv59ISt8Nj/WFV9UW2FCT2fCMl1leIWVaKSWhLv++1D6zJR/KC6arQr9U4NZbZl4ogwt+2QBgRIZ5gZtLZTN/4dJedsnnU1zSZhdNlXFIc8uehEdthXCnqeKy1wSdPXX8RJQ86sMRhCIq3J0smvsVrhnkXcrZtg56D5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893209; c=relaxed/simple;
	bh=kaMgHoWYLYvGbfKuyz8FjfIvHL93d78mxqSd9irxe/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzaYJQYkaXtErYvGr1/gVAfxHsRDWrKJbSJtg49ItLgHM4Yg8wBQJKo/laaet6aGW3FcMj500TR4xJPqvyh6jr3AB+PxwDC7qjoLTgr0DUVbX/IlwXb/Mn/JADpVAg0+mRC79kbSO112WJmDvvm/hf8r2ZJZN3mR+DRmil3LSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdFOxf0K; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6045e69c9a8so9228967a12.3;
        Mon, 02 Jun 2025 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748893204; x=1749498004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUzxaG7r98wSKohMlOOAAhXemIOrwTNYnmCUuKws3h4=;
        b=NdFOxf0KjtRFLAA2Xhq38EoKda423tiQXWsYlmSK01M3nh4jRMXnoNdnyPlehgSErm
         xDCP3XACm03SSKCL5VjMaCBIcWxsQ1QapHnuttJ0UerpZYAneTIG10loY5Ce/RWUdd2B
         o1jSLNsmOrrFxFh+Rk2fmqDXU7+Z6ASeQ8QHgZYmvIMsKeCvbBDVLWJSm6B/9BYaaWEm
         GqXlYlEVx7fCJbGhXBt6EhBk5biczv14eob0yG4q30RwHjRBsjQbOyNCn6dBI5ZmCsTS
         /EwAvfvl/5fZxzjQW6v2grsS3nn4IBux0IjJPtv+rDaNXWo2SriajClAy2qv0A3+gaVc
         GZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748893204; x=1749498004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUzxaG7r98wSKohMlOOAAhXemIOrwTNYnmCUuKws3h4=;
        b=Hrhf3wV78f95bqu/Zb+akGX9s0NTjHF+MRU7JXW4VD5FcYjmyZwlBEZg/9wYq3Mqcp
         69cEq8vA5NCxvWojsJadiNZ8DDdEC6IFYL1FegPvzhVhaDNiOMIbmcixb+NYtaW2ZkYp
         YkEWbgpphlBljh8uDf9phoqAr4Q/tpS7/7kcyjGpT4zMa83poorNT1HVdmPlcrs1RiJk
         Ge7LAEdvl6F9Pvm23jPFAlO/x5jMb/G2z5SKHiJ0qutxb/WdZdYoK+iutp/zZ3QVEL+p
         VWV+O/pKHn2Z9tfiVH9aE9cGhoNOO+xetHfWS+QVyur7mUORyA8pO5GOmP6ZbEotIhyd
         JIkg==
X-Forwarded-Encrypted: i=1; AJvYcCWOfEVcgsQToKxBIOt2T8+Gj0+x/AqXjQvBjYTIaPM294xk1agDLpi3XOHTBg+XGCa0aF2hZwvhwruvp1o=@vger.kernel.org, AJvYcCWvICTiKZXJzcBkuQp93TUuudq1CjSnyFENm2Gje3TfryWD6pJ5NXuyFNq1TnJCOjeQV1ZVDJkm@vger.kernel.org
X-Gm-Message-State: AOJu0YzMOvAFSSFkN1TWz57ES00HUCohmFxc/Sp9eed+LuS0Pn4U/lT8
	LxfKm+pVC144iiwKjriGnfMbA3EuMPQ0jlXGpI9MFSFptAbhQd/6WgyU
X-Gm-Gg: ASbGncv4Yc//NO4s05UQ2yexFYFRdS16fk3/OR3FOcQz4/YC0E3hnoEs9N5xLexABSm
	XKd+MQv/ZmV5+VKRAkpdB+ziH58IkQb4OYWHdCqKn8RqWLiPqOoi9hwQJaPQTZnhLgwSmw3v0uh
	wwRcpyJsxRmPmPpLFA402UwAuKAYFWPGx4bp9oW6XIOYi3bStwZNxse09kv/ZKPc8YgXlQLn2Vt
	o/Py2WCX+OVoRaBDzzrj4v2zGnVoc+kuFjT9D4H93gNvLjMLJgmYeLMt1yfqAX0A9xtsLuxihgg
	h7dkfSQ/B45fdwxf/BRUsuNnlL4GXko+4CDPADNKm9jDT8UmmAP8RbfgqS7mCZw9uNxWfCmRpGI
	oxxg2wUGYqOmpApHhmSE5a7fiARSzZ9M=
X-Google-Smtp-Source: AGHT+IHfZPl4EHqdvcHEsmAE+HPej3McuF8SlAf973Eld7dW+ssySVbsuESuRGVDGhGTauQmWW1q4w==
X-Received: by 2002:a17:907:97c5:b0:adb:2bb2:ee3 with SMTP id a640c23a62f3a-adb4954948bmr908599566b.46.1748893203784;
        Mon, 02 Jun 2025 12:40:03 -0700 (PDT)
Received: from localhost (dslb-002-205-016-252.002.205.pools.vodafone-ip.de. [2.205.16.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82eee2sm840999866b.73.2025.06.02.12.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 12:40:03 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 4/5] net: dsa: b53: allow RGMII for bcm63xx RGMII ports
Date: Mon,  2 Jun 2025 21:39:52 +0200
Message-ID: <20250602193953.1010487-5-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602193953.1010487-1-jonas.gorski@gmail.com>
References: <20250602193953.1010487-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RGMII to supported interfaces for BCM63xx RGMII ports so they can be
actually used in RGMII mode.

Without this, phylink will fail to configure them:

[    3.580000] b53-switch 10700000.switch GbE3 (uninitialized): validation of rgmii with support 0000000,00000000,00000000,000062ff and advertisement 0000000,00000000,00000000,000062ff failed: -EINVAL
[    3.600000] b53-switch 10700000.switch GbE3 (uninitialized): failed to connect to PHY: -EINVAL
[    3.610000] b53-switch 10700000.switch GbE3 (uninitialized): error -22 setting up PHY for tree 0, switch 0, port 4

Fixes: ce3bf94871f7 ("net: dsa: b53: add support for BCM63xx RGMIIs")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* add reviewed-by
* do not enable RGMII for CPU port (internal only, no rgmii)

 drivers/net/dsa/b53/b53_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 3f4934f974c8..be4493b769f4 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1439,6 +1439,10 @@ static void b53_phylink_get_caps(struct dsa_switch *ds, int port,
 	__set_bit(PHY_INTERFACE_MODE_MII, config->supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_REVMII, config->supported_interfaces);
 
+	/* BCM63xx RGMII ports support RGMII */
+	if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4))
+		phy_interface_set_rgmii(config->supported_interfaces);
+
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 		MAC_10 | MAC_100;
 
-- 
2.43.0


