Return-Path: <netdev+bounces-251616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBYLMEDsb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:57:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4544B4BDB0
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C31C1AE052F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E813BB9EA;
	Tue, 20 Jan 2026 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kscLbviV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180CD3B5311
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941555; cv=none; b=u63s5fkI7mQHMl/TcUVLswJXi2I654LtdHLOe1ev8VH9xt5NeF7TRQuWtfn1WUNHIBGMuvG7vE72UchvFnlbXa+npKo/b3ok19Iq/Rw3ab61tpxlm/FzSekju45q6rVoG77YUKv6/I6iC5pSCRh8FJWzVQ7+ApntqtjcNDE64/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941555; c=relaxed/simple;
	bh=xHOEY7pj9A80Sy6IzpJUThtTf0+b2ch1RqET3iZnUTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usQBu/kriwNKLss9NAT3iYjY1k6ktK7N7HcpF7mojS6ksNIKh5zPHO47LhglE392fI3h8Dzf52j5rFNOXYj20X2bgqteAj1L20KqQ3BfAzZClUNeqE3VN5or3ZgQaOeVfH+fWTr/NDxJKJa03uJ9ZAeA+xla/v3rQ9fGdANSaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kscLbviV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-480142406b3so31838605e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768941550; x=1769546350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2eD+o7ZJqt8UHgxhoi1YhoZ79UecJ91Sm+qVMqrNb8=;
        b=kscLbviVEzBLFLSmc97ezJNsrGTqeKo1p+isy8Q0Cf/aZbdsrw8iZD1gPfqoppW9Fx
         0DD3sBGOjCrDCKJ07PWZDEdTsntFjCwbuuXGxa8UPGwF//pTYSrW4DFrNEEXG4u/rnq4
         ePuuUWEmF6u/xv/1Wcrt2UECMUpAs+r1ZOnT54ejlYDxGmBJrhPgD3byUvA1qc4b1+cK
         XEk09HqQa6w20yH4E0YSWlKdq5pwEUHPRgZp1t+aKYFMbfBDwYNU5WnbbR1fpbkdmNK2
         VGbjQSXbHDiW2NhlTkg0UIIAUOtLwti0SE0uir1qycwGOVQg0Z75dJmMJMFZOJEdu6nH
         1dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941550; x=1769546350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b2eD+o7ZJqt8UHgxhoi1YhoZ79UecJ91Sm+qVMqrNb8=;
        b=IGCqDwYl6TFCBCSI2MJY64tbqI5uGh1P6EEfEtOJxluu6UAarnH8QlDrarsYODOg3A
         l1Gc3v4bsJNu9olmLqqptMZnCwUHn6UPBBG/PtZ5B1/MbUtWTibobqCFYnQtB14P0F5y
         lyVqMB9fFN3pgKVkgB2qyjGVq6X0lJb54FoRKzeas7iBdQBf/vFenzAsAowsS7hNZ4nc
         MLvvLbtS9V59Fdox0KauidYAddxJvcdRFAwpNviU+JbM5HcUj6TIFy3lHULgIWtxKhkL
         yKgKVrYdF/dVi+co9LqTjdKAwg2cclHM+XKxf3BD9GlCMnGXX4358PGzj98LIuM9s46S
         ra8A==
X-Gm-Message-State: AOJu0YwK7KWulSKf9prrxUK6HJW11c1fineALT9Ub55AhjvH2jqe8Kgp
	YwBymLEuYph2U8co1WfSZI8vvwI06RpmLPemv56817z9AFkpaIut49nF
X-Gm-Gg: AY/fxX7k+NWYcN6LjTdM/npoKWmm772qowICv3m0KisndlEV2zbXlPgiBF2fPz/6FvA
	o68qxPaJUymE/JXe/VTJDfnp8JmES31DwR9Rn0C6berwgR5E1dsDLXArNndPXnVdxaMDAmddTGM
	4jNnDic3UjDae7nFmfQP22DnGbkjPQeSPTJXoekl1HKMtPC1pBHBARInWFhZuffT+SOtzYNAQY6
	552XjAS5DVqwBZX3MPRyBxRGT0zAFR4ZR+6RNlBxS7Pcx9Rki2UAYSyanqWeatO13X6WmtVVYBW
	o17rGRvyTXGAqaur0U44ixO3X47jXZ1HC+edN21uKa7tzyhkQ2V8yU1GP/3YRHKY4Mghw2/btYq
	qgP5eF0AtZapTDlx6RDdW+TOPhfGzwLcHNNik5sd/+2GYogAmUHmevGnLyJ0R84Sx5RkDXzxPTc
	EysvcuIdroHyduIg0P
X-Received: by 2002:a05:600c:8b55:b0:477:9f34:17b8 with SMTP id 5b1f17b1804b1-4801e2fbd61mr211779815e9.1.1768941550130;
        Tue, 20 Jan 2026 12:39:10 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:378b:c660:2f9c:b651])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042c3a7c1sm850425e9.13.2026.01.20.12.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:39:09 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	maxime.chevallier@bootlin.com,
	francesco.dolcini@toradex.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH net-next v3 2/3] net: phy: micrel: add option to keep the preamble before sfd for KSZ9131
Date: Tue, 20 Jan 2026 21:30:03 +0100
Message-ID: <20260120203905.23805-3-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120203905.23805-1-eichest@gmail.com>
References: <20260120203905.23805-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251616-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,pengutronix.de,armlinux.org.uk,st-md-mailman.stormreply.com,bootlin.com,toradex.com];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eichest@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4544B4BDB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

If the PHY_F_KEEP_PREAMBLE_BEFORE_SFD flag is set in the
phy_device::dev_flags field, the preamble will be kept before the start
frame delimiter (SFD) on the KSZ9131 PHY. This flag is not officially
documented by Micrel. However, information provided by NXP and Micrel
indicates that this flag ensures the PHY sends the full preamble instead
of removing it. The full discussion can be found on the NXP forum:
https://community.nxp.com/t5/i-MX-Processors/iMX8MP-eqos-not-working-for-10base-t/m-p/2151032

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/net/phy/micrel.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 05de68b9f7191..a51bfe4a8d7b5 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -101,6 +101,14 @@
 #define LAN8814_CABLE_DIAG_VCT_DATA_MASK	GENMASK(7, 0)
 #define LAN8814_PAIR_BIT_SHIFT			12
 
+/* KSZ9x31 remote loopback register */
+#define KSZ9x31_REMOTE_LOOPBACK			0x11
+/* This is an undocumented bit of the KSZ9131RNX.
+ * It was reported by NXP in cooperation with Micrel.
+ */
+#define KSZ9x31_REMOTE_LOOPBACK_KEEP_PREAMBLE	BIT(2)
+#define KSZ9x31_REMOTE_LOOPBACK_EN		BIT(8)
+
 #define LAN8814_SKUS				0xB
 
 #define LAN8814_WIRE_PAIR_MASK			0xF
@@ -1500,7 +1508,11 @@ static int ksz9131_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	return 0;
+	if (phydev->dev_flags & PHY_F_KEEP_PREAMBLE_BEFORE_SFD)
+		ret = phy_modify(phydev, KSZ9x31_REMOTE_LOOPBACK, 0,
+				 KSZ9x31_REMOTE_LOOPBACK_KEEP_PREAMBLE);
+
+	return ret;
 }
 
 #define MII_KSZ9131_AUTO_MDIX		0x1C
-- 
2.51.0


