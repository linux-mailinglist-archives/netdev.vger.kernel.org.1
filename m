Return-Path: <netdev+bounces-253394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WInIKJEyd2mrdAEAu9opvQ
	(envelope-from <netdev+bounces-253394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:23:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABA985F5D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D670B301C960
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4709E306D40;
	Mon, 26 Jan 2026 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTSG/xoX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603A309DCC
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419331; cv=none; b=CS75Rh+YUVzVn/V6bL7oHG957GGOg9HopbrloyCsn3ChF9eEooSDcG88Ov9WV6Lbj9rO2cI+kVyzHv4+0ozhemsmjppCQhB+Ih8dUT4sWsynZ7w80m6S4yxL8NN4dfykrRkNSZUCyQuEK/GIhrUQ+vSbOLftje5e7E+CPTfBcps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419331; c=relaxed/simple;
	bh=rRZrBOTEL98igZrxjeyvohslWGlOhGCZd+W/KF9qYh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/VyOjbDsUmfq+vCmfeBJ0auWPM6HTArrwzatHEzrlVgO5K3SOuo10zAuZc0ISiCH1TCSZXTeX3aLgvN+bPubm4AIpcFHAh3FxTEkNVIIceKhC/On6GROodyvsBl+oTAw6IsZvujMew83uM580GEtjWNn2hFE6Bq2/c1qVuLfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TTSG/xoX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so31578375e9.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 01:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769419327; x=1770024127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l0bRB7VVDjDIq+ulMsBVmhmzBjYiR54K3+u8tiEuOs=;
        b=TTSG/xoXgiDAwLo/45en78JlxyD3JJLNcG/NzSxknEfQBGXffkbLy6Cv4Brx28JKLu
         mcZz7M4rMjAlXl9K2YM6FGfsZ3zkqWGFWLmeoYoYv9VCYCspQ9azT96CfQmZQXFQ1Y32
         DH9c1vwMeWr328YoYIMyrU3FDxAakG5R+FBWeYylFs8BxCp51TFN6rN9y/XrX0/i9QDJ
         yoKwTDkyez2FfVVaZhK46OQHx8eVc6BSZFotQRIZiuT6otJoCZNS4FnQRo6BsZWLr6Oe
         e++9HTLlZIxUmI10nQ9WgwJYmE7vPZzucmF4u26L4rHGeGYBiBJtPWe4YKJwkJnFAsOZ
         5c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419327; x=1770024127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6l0bRB7VVDjDIq+ulMsBVmhmzBjYiR54K3+u8tiEuOs=;
        b=IEdV4aMzBWWyjQyoBZyeryVshmC1n3azgHWD5E0q1PMvJZwDqTX/h5HWLxaTSghbvx
         b9sJWu6LXKp1kpORg9MBuTur47ehwhXv+cPhfN9+WiVNuc7JzaHh4KAQzO0900MhkJ/A
         VJp65lJFwIaJeGtR9XpGgCIYVryNNaEzWzqEJLaP8fZfVeTXPH1zKQg8DUGa/J66KOKN
         NW/FgNmrcRhmeJnQp9Z3xz/is8agFoZt4huRGnOqZJo7E/aaFRLg5RgGcv0vnojfoetf
         c9UEfSpA+l5uEpez6Zbd/KGX2hPT6ekNyKUP4PzQ/c41KMyBdHIch2JmgbixNvoeeRrR
         AjBA==
X-Forwarded-Encrypted: i=1; AJvYcCWknN8+OKriOROlk0AOHJczaIHME5MUIjPYOOIYol2FkAJLo7O4FYnOtgCXwSvJ6sDyr4lMO9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvSnVPcJM3SDbH2sLMkz4w5JciCdk1eiT9UmwdZf9n6uledI5
	8DKV7NhJFxsu9tr8Vr7NYeG/EsTQQZOnbSZYqOsIVL9I45WNXcv/15oiRmr7pQ69PWQ=
X-Gm-Gg: AZuq6aIgRQzCa5K/gVKi7fLKwofMpBEDc4qJsRa+EfkFuj2UnW5W6hXlbWwbKbfaMl6
	PjzFB0zc4nG1Z5/3YltXRp6EnLuzTQZJZ25jJjZqho9cR6L54W5Qbgu2DMUfFV28TQeb2HeRZ5D
	ZLnZW0NMlhawsmvsbgzVAimjOL7b9GUV6U+84o1/JmLvdBS7pbkOHnIiLfpTobspv9Cmk4L9XEE
	LhaNAsJuQ82zatskDKgWkCVSj9w4rm28v9CfXWWik9xJ3vi4IBRJcS6mcNkI3WyJkBbL7l48OuP
	aX1gQoHNpsuce8clt1mZzghoi25+CyToRNZxrGBi8NtVVCaXUs5mmwkXalYwVGJXalzMDGNkQ1q
	TEEibF1rzqxesMzo0t2K2LvvI69OOPlqi2mv9SqTHgtOyxa8/Hr7rg2ClyS7zacLEIzAMs+brMa
	KZiLYEvsXSAewyePB8IEs=
X-Received: by 2002:a05:600c:3b9d:b0:47e:de23:dd6f with SMTP id 5b1f17b1804b1-4805ce42a6dmr67097725e9.12.1769419327486;
        Mon, 26 Jan 2026 01:22:07 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:e270:a43a:f2fa:900a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470cf1acsm346669855e9.14.2026.01.26.01.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:22:06 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: vkoul@kernel.org,
	neil.armstrong@linaro.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ciprianmarian.costea@oss.nxp.com,
	s32@nxp.com,
	p.zabel@pengutronix.de,
	linux@armlinux.org.uk,
	ghennadi.procopciuc@nxp.com,
	bogdan-gabriel.roman@nxp.com,
	Ionut.Vicovan@nxp.com,
	alexandru-catalin.ionita@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Frank.li@nxp.com
Subject: [PATCH 4/4] MAINTAINERS: Add MAINTAINER for NXP S32G Serdes driver
Date: Mon, 26 Jan 2026 10:21:59 +0100
Message-ID: <20260126092159.815968-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126092159.815968-1-vincent.guittot@linaro.org>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253394-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2ABA985F5D
X-Rspamd-Action: no action

Add a new entry for S32G Serdes driver.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa218..888674a308a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3202,6 +3202,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
 
+ARM/NXP S32G SERDES DRIVER
+M:	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
+R:	NXP S32 Linux Team <s32@nxp.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/nxp,s32g-serdes.yaml
+F:	drivers/phy/freescale/phy-nxp-s32g-*
+F:	include/linux/pcs/pcs-nxp-xpcs.h
+
 ARM/Orion SoC/Technologic Systems TS-78xx platform support
 M:	Alexander Clouter <alex@digriz.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.43.0


