Return-Path: <netdev+bounces-279360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBjgGr1X4mm25AAAu9opvQ
	(envelope-from <netdev+bounces-279360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:54:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB34F41CD66
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E65330C6EB9
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 15:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A97314A86;
	Fri, 17 Apr 2026 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgNe/BM8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F503358B8
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776441131; cv=none; b=jz0dDA/LXm/5XrEKF36F5r8Gq7bfyRtwp05lCHXkw1jnEpzk0krVaVi/yS0iiGeTObnv0UOxg+7OqDeE0Io1Ka7rM3XMwvAxRHYQv161fkoHKY4idDhDTaVdrp2Bu/fUmY49Jss85Y/HjUWAbnKBmJu3Yy+fUgfD8T0JGdw9v/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776441131; c=relaxed/simple;
	bh=mhVDE5oC2WyEUUzwIicNY08+79uEn8dNX7oL7LdIvTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVoF8bmGjzintz2PB/YJiEpX0IZha2aRGtfJyb3g2BF0Uo3oU2JTL3OeB4K0oDUl9IQSQHCTgOPZ8Q5u6/LkS2mk9Qmz0/QFuNP6POfuAtSIwMPbrpxvX48u2t4lSvn3yUmTVUFsFEa8K3/qiqzSbR52Ho0valX6MI6W2FkoT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgNe/BM8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488afb0427eso10603985e9.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776441128; x=1777045928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YG5pS9TWxmqTf918rKN1KswMtbzf96uqUuOjHSHvBmc=;
        b=jgNe/BM8apRtD0rI0MSJjWp+tCZXf0JUqeWxJskIvHgvvn3+kxqN33vm39KDJ2lrnn
         g1PiKysJXUdL+q+Rv97Gqwh1tAcm2oi9VntV6k/FARBNSCpnlOCKEdRlY4y/ZdYd0swy
         4R+xC0cr/zx+2H24KFU+NGgr593DUKajYRAeXQcirNzss/YoJld+QMPGsuK/zx+eHEj1
         0Ntva/bG1/GpLKNYHkLwP4uG5Z209e6nD30Ei49OYHbX7DlfGkPcvbK65C0WmqaBMfV6
         Sjc6r+KhobpW8PanRaLscreTRMAdBeiYEdKw2cUu9GXa5U7A0AqlaNP29WsKCOqw3sP0
         IwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776441128; x=1777045928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YG5pS9TWxmqTf918rKN1KswMtbzf96uqUuOjHSHvBmc=;
        b=DhxPOqtP8UwlievnmaeehCp69E4Ne0jaXWJ6dibrqMf9MIVWjcD0Nnu1AozgISFQAs
         5UO9c3pFZn+1kMwxQEhRJTcTmnNY+LyFnZySQ20m3GqdIQmje0RfsRs75CHIGPf74M8r
         54jMwCp75KMfVukcRlGV8eMJBXABpfJQDin2y1FDyQq3Q9MnM9iPWrpkRgTAum0bj+qO
         eNZFex7rCVQ2KaKPxO5iq+XpfjzGijgwsfenpE+99ghokv8i2F4HVNO8tQzIaplYLPF/
         MbqBH4czaBftO8+3Sti0VKpAAuzo1reRT4r9yOpd/jsdH4wLd8Gl0uZB867/Vf6dTpbh
         wtaQ==
X-Gm-Message-State: AOJu0YznuKc/j6prCXHcVbWXn54Q+ZSRf5gB5TaLdsMiKZgXUQaut5ay
	fyvQGyDZNj8svGoaJ3Jhg7VtvqAODvnyWvyBYz3AR2VdN46GVAmc75EWdWr79myUE1E=
X-Gm-Gg: AeBDieuYqnr3MkvWjoZzsSVVPadVA45oRymcoXVGAeVvASBVYZ1jMPLgbASux3itCjj
	fuk57ckfpTHtLjDCFdnrDRRDE3jXZaX+De0QlHxQMQxAj2AA+fgEaFwGYNKzvGZ/ggOHiMIVe5+
	DeYIIijghKG4mKCvq5TzcTRa47Iziyg6kcPbOQFPC2RUGYrGgdMhL1bAuNU2jeocCJSV7OYfADN
	69DYy2oBpNexRZS3H5liYL5iNFw9e1DGNFKU5xyk34G2RaR7CvcuprmhcO+5YRyjp5MblkE0M4A
	HTuFTJerLLDee8ypVoPZtLGAp34hNTCyJXlS49vNGFMzG+7BCJz19W+mVK//oqiPO1KbE96MALN
	d9qTXWr0OEOjasMLjgH0lglIqF9Q93yMRBETMee017p1K0MAcUc2W8RTplefOeHt2plDXfKYMlu
	RpOMSeXL3Ecg4/DFEJ/h434HeXA1okZAmd0ZBy1nY+sDS8NavvcB1WjelCLdMXnlD8VSI6fmU34
	7Sbrpukervzt9aYL8lrSpTNN0nbrEWbiuw=
X-Received: by 2002:a05:600c:674f:b0:488:be21:54ae with SMTP id 5b1f17b1804b1-488fb6e9cecmr54910425e9.0.1776441127809;
        Fri, 17 Apr 2026 08:52:07 -0700 (PDT)
Received: from fidelio-Precision-7670 (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc181c6dsm51035345e9.6.2026.04.17.08.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:52:07 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Woojung Huh <woojung.huh@microchip.com>,
	Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: [PATCH] fixup! net: dsa: microchip: implement KSZ87xx Module 3 low-loss cable errata
Date: Fri, 17 Apr 2026 17:50:25 +0200
Message-ID: <20260417155025.488290-1-fidelio.lawson@exotec.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417-ksz87xx_errata_low_loss_connections-v4-1-6c7044ec4363@exotec.com>
References: <20260417-ksz87xx_errata_low_loss_connections-v4-1-6c7044ec4363@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279360-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,exotec.com:mid]
X-Rspamd-Queue-Id: BB34F41CD66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

---
 drivers/net/dsa/microchip/ksz8.c     | 6 ++++++
 drivers/net/dsa/microchip/ksz8_reg.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 0f2b8acee80f..62fc59c3da7e 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1297,6 +1297,9 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 	case PHY_REG_KSZ87XX_LPF_BW:
 		if (!ksz_is_ksz87xx(dev))
 			return -EOPNOTSUPP;
+		/* Only accept LPF bandwidth bits [7:6] */
+		if (val & ~KSZ87XX_LPF_VALID_MASK)
+			return -EINVAL;
 		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF, (u8)val);
 		if (ret)
 			return ret;
@@ -1305,6 +1308,9 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 	case PHY_REG_KSZ87XX_EQ_INIT:
 		if (!ksz_is_ksz87xx(dev))
 			return -EOPNOTSUPP;
+		/* Only accept DSP EQ initial value bits [5:0] */
+		if (val & ~KSZ87XX_DSP_EQ_VALID_MASK)
+			return -EINVAL;
 		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_DSP_EQ, (u8)val);
 		if (ret)
 			return ret;
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 5df17c463f7c..cd41214f874e 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -206,6 +206,9 @@
 #define KSZ87XX_REG_DSP_EQ			0x08   /* DSP EQ initial value */
 #define KSZ87XX_REG_PHY_LPF			0x4C   /* RX LPF bandwidth */
 
+#define KSZ87XX_DSP_EQ_VALID_MASK	GENMASK(5, 0)
+#define KSZ87XX_LPF_VALID_MASK		GENMASK(7, 6)
+
 /* For KSZ8765. */
 #define PORT_REMOTE_ASYM_PAUSE		BIT(5)
 #define PORT_REMOTE_SYM_PAUSE		BIT(4)
-- 
2.53.0


