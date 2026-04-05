Return-Path: <netdev+bounces-275448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5Ky9KpQG0mmWSgcAu9opvQ
	(envelope-from <netdev+bounces-275448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 08:52:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F049639D856
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 08:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34E343007E12
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 06:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E1F296BCB;
	Sun,  5 Apr 2026 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lspJUGpD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316640DFCC
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775371920; cv=none; b=M1kvAM/FlYDHqcRSFHFXru9TE5QumQEIk5XDyDhv9YxUY/H0JDTKtBQ8vC3uD2kdwOdhynXXTrmYVQLF+MimdtfJz6IXv+a001jWlmrQSigxi4LBJRMAJOFRiq54TzFsD7nNkDFJdl6BudfYccWkvrMIi1+Ja7ASc3DAwuE9K6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775371920; c=relaxed/simple;
	bh=0Nd4ZambN8rM6XvCCFjAtYGXS4JzjTrFyZy1ex9PqhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=phg02xPOWNQhmH/QlRqdqZkS7iCjYTfpkbYZoLRHRllnBI69CsxhgpRqg59207poC+pFbvO2BRF0dPa2xk0AJdvcZrIJBUxJDnP8Cd01yT0bPQlH7QnkysUJiztB7TJZxR61Tf4iev7L4ATbpOt/j5OsFQF8D0n+DCIBXTxyZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lspJUGpD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35c2fe0d90fso1719663a91.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 23:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775371919; x=1775976719; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7kD7tjluDb2luPauibsZdSB6rOPlWgHhP0Wmzs7TSc=;
        b=lspJUGpD9OYFknkFFH/f+2CF+XDFNzmgWfggAdrQcbN5Axe1XjaDNdzhFe3TgHEnVD
         +GL6i1tg7OBySIXJGYysh/clu0+lCC7IwNcOTkoa6Dzl6A+Zdmd3WGPJIYQ52Djbivn2
         izqw0ASm0L9ZQJkzZTuOe+OpR6tlus1FJVC0Jco141p8Es3+SiW+DcGKuk5pqkyagSV1
         NoD51PTAJlgvY5VXz7a/0NrQqpjY1Uh67TKH60OMiTZs7kzwMrT+qgkgL8IKbu01eVHt
         QWTWi98RIC1NyAgc474i/+XvHeSvXb/gzKxZfR9ohMT29lO1jd+seOMGkjMq28naPOLh
         SNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775371919; x=1775976719;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7kD7tjluDb2luPauibsZdSB6rOPlWgHhP0Wmzs7TSc=;
        b=lOzPqeyimtCHw/sS6SCGQpd/aiO/vfd8xXGS1NH1U1OhhUK+S+pDOeBxIEBNSw77Pa
         q7+EQLiRkpxjCkwH1zn/svrBVpC7+Guh4JvBcqc9NRF7EwjVc7EyQeFH93/wLk0MQ8uu
         IlplJIACO8qvXs4yivfE035pPqoBl4kF17M6L/vxYR16BXQqbIL1m0FdMu3nki7jalYe
         3MIt87w7y0snZ3dst6aEcDkq8ikDaxyIXM8iDHLjrZRyXf7y3o8kNWNJQK0lXnM34SlR
         7QziWFCuqQFeBTBWxjKpUsnNYe3SY2Tw1cr0NqGDJa35KzAyhFErlHw/lAKrL2ebdr0U
         VSUA==
X-Gm-Message-State: AOJu0Yw5knyWHer4mdbZy5hRvP3D16YTlVnGtbSt28T5r1WLWboYWlp+
	a9LxyR08yFxfBsEFJWiJ4+hOyjgR+OLzNAZfKH/PQavn4z/fW4Z9k3kE
X-Gm-Gg: AeBDiesvIht5KdHIlA+U1IV0KFDmzln5LuPf5jfIWi/r9Dd678NsBCGvDYJwL98XLpG
	B9iC5bOs/aGT/hbyWrLXmouc0QKmByKu1BVhIhiATGnxAkBJcwHBHCnCLBDZ3go9vGtMrJsNcld
	nXC5dmvsy+6lDDu0MpY2I0tDrbGNJ0MBDrP23KH4EHv85PRJscP4FWJFDRUNe50mG6vlfxEFudc
	CWw+22xbA8xrPCTeFQsfFRQJK3tnXORGplEZeD+dKWEeayPNkFCtZWJM+X8AKGXOLTXTmNX4No4
	2pAKMmYcbIPw738i/sqRjbt3sOBBHkrJvQhjBGSlA07rPM3mhNhVtrvZk8heaiiHQOHH8kq2rmE
	YANoRYxcCVX4X9LOyzhdZ72EEkr8NgEsCLKS/PgDKR5OVlJnrkbtNw+aQFboeuP6YsWlUyQwMgG
	BJ7znGdijtel/LyrA3TnrK/yVTvDUKY4yyoAOr
X-Received: by 2002:a17:90b:3f08:b0:35d:997c:8eb8 with SMTP id 98e67ed59e1d1-35de697d01bmr7702356a91.24.1775371919086;
        Sat, 04 Apr 2026 23:51:59 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9709b8sm14464958a91.16.2026.04.04.23.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 23:51:58 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 05 Apr 2026 14:51:52 +0800
Subject: [PATCH] net: mdio: realtek-rtl9300: use scoped
 device_for_each_child_node loop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-rtl9300-v1-1-08e4499cf944@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIcG0mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNT3aKSHEtjAwNdQ0vDpBQDA6M006QUJaDqgqLUtMwKsEnRsbW1AK+
 R01NZAAAA
X-Change-ID: 20260405-rtl9300-191bd002f5bd
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775371914; l=1254;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=0Nd4ZambN8rM6XvCCFjAtYGXS4JzjTrFyZy1ex9PqhA=;
 b=Tca11rgctlIdAun5MH/GpYguaaGIOfAaRmSLXTRG82FmuvCbI6oAN1C12af0EhSmQ5cBxdhk/
 TXuNpAzGznABQcAOMJCDpEzTEMUaW0Urpb1jKO6viTT+koHABk9BvzD
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,alliedtelesis.co.nz];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275448-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ustcgu@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: F049639D856
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch to device_for_each_child_node_scoped() to auto-release fwnode
references on early exit.

Fixes: 24e31e474769 ("net: mdio: Add RTL9300 MDIO driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/net/mdio/mdio-realtek-rtl9300.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
index 405a07075dd1..8d5fb014ca06 100644
--- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -466,7 +466,6 @@ static int rtl9300_mdiobus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rtl9300_mdio_priv *priv;
-	struct fwnode_handle *child;
 	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -487,7 +486,7 @@ static int rtl9300_mdiobus_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		err = rtl9300_mdiobus_probe_one(dev, priv, child);
 		if (err)
 			return err;

---
base-commit: 2febe6e6ee6e34c7754eff3c4d81aa7b0dcb7979
change-id: 20260405-rtl9300-191bd002f5bd

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>


