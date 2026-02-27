Return-Path: <netdev+bounces-261727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKbMCnwyoWlPrAQAu9opvQ
	(envelope-from <netdev+bounces-261727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 06:58:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE551B3001
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 06:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 707AB30457F8
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 05:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F243DA7F3;
	Fri, 27 Feb 2026 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cslKWjM0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D803D9047
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772171896; cv=none; b=UIcvfraj91SNMUXyoIceM2P9sKndHKBSSXlO6z+tr6Z2wsgBVdfQteaEJYYFI+gewIRHfDO8JN7vxgSAKM9fzfGYD2SXzImtbOGrlxY/VV+31ZhEp6eUgNiRw3CSOOLD+3K3ncGp0epBuPNMqHR17DvI5rs7jRoxmDyaU/eACt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772171896; c=relaxed/simple;
	bh=GIP6Hx5ALYlEWDpAXrizxOK/bC9x0nsblfW8kxQDdT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5KhUqTuLhbW75NGCO5taKaPawFYxhRy3JmWPfc7CH1F1u3syK32UzaIBSySbWg65YpUgBnz1y6Xl9iZbFeZMg7yYY9cTGaKxDFciEOXH+As08RA5RzbI5YF6shyEFqSsDG6/XNdf+ENH4xJW0cs6s+r7bHN5AWuPZEXer9576k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cslKWjM0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2adae92249eso18555455ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 21:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772171894; x=1772776694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/K4ic4WB59VRhZZLcJDmWZdxWKRXFIHSngOTIlT4bbE=;
        b=cslKWjM0rsMQn79IquCKF+ByCCjZJmHv3PHuL34J7DgVJhuSIJL0SSLEdx2mhE+fkW
         +e9aispQAptIt6TgHJ8H5mEvvxh2rWoJaACxJFW8A2KQhkFCHndOlLSrmwFv91OYihi1
         EG7bbO4dVS5Odm0064ig/lapBZ6DD7HCqCV//1rgtOYhPs4r/PC7+dLaZIgQVGnj8AZ6
         wqCU4w2K6PZe51LTxQVvLu+z/sW3XRYz9TzMnZrKB7IASW84m4s0NgA46IM+wNF5MlT4
         mHKW8n4+Ip6FQJLmK9IOuokymkQVoJQ4OMvvkIumKAJAjjmzFHKt7H+Z2MZiCxiVzfUU
         jkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772171894; x=1772776694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K4ic4WB59VRhZZLcJDmWZdxWKRXFIHSngOTIlT4bbE=;
        b=DcgQgrKydpTFh3YKo5fJIgorl9tdKg5wkaHYU8C6Fv9xee+V7RGMCDoJ15IY6LWJU6
         TBHYegMapbFhyNXUa1PimLfh9aaYQ//LoCDKBFbPNGPsBMaNdhlt63Id0FuMFyQqnsZE
         LAbUqFYVKwvcQFmvd4S1UhlhyASFCr051g4UnqFP1T1DITjulVV69K/4yqkLMbMkzBTP
         QCnj2xsavaui8BlxrmLStA/0r6iTyYEmS3+mok7rD+zNUAKSZ0ARJOJsR2b6BGV7gz6y
         J7Uyoim/LOy1iqRwoNMal9yl9QBK8n/hqdcWL41tjglsacpc7cLrAy6QSAPRR0TGLa5s
         baSA==
X-Forwarded-Encrypted: i=1; AJvYcCV9hr9XSoBmTFyYnRcDsbQzoURMe+gpSkF2WeUhRYtC48s1UpitFdcuGLkeHOpv+RUSAMtAU+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqKBsLmO2HHwsqxlYC/SPntGjQZjAlJzz6hVVzliAb2aznXWJ
	3l/wp/8MgwP38EdwcvE5iZmxxHFLL7oJR2y70Nop0pfvwnp3Ick4TMr7
X-Gm-Gg: ATEYQzySRhzeHZaEotNKAqQWf503OqnJK4C8WlLk4klbNtnLl3cWXFjH9DQDfA6nBJS
	3HQH+YTzJUD90ysXwitlB6x4flMPTUTFwm6KKVZ0/uwyw1KOg1svGo+CNyU5i88EsY6BCKIJREJ
	hAHdgC1BINeHtneJgDFKAKLxl0mCgQuczu7CRYLYs0Yp23Ozpn++DVjt10cJinfkJRKDqcIOSfa
	B49aa74W1NMkA6eFwGUcnmJ29K9HymWNxkGZD4oAjCORO+CuSe/h5rUFesTOYKzGaJp3SGw1KTQ
	E42Zhsuo8w2kn2nMUit3h5T6eXRqF5NBg+6D2Sg8K6Q4UHZwxESUCuNdc9/MpK/u19kNUP5SOe4
	ohA/JBemnPXjMXN61ftk0u5zgVOdrWkiAG+8r7C3QS+dT6ERte6YK3DUAuUXOtCWGA9YBEMGqVv
	4ED2jRFxRK8Nsxzrl/QWzzWlwIi01diCtnAZbjHnanuN6uGVg=
X-Received: by 2002:a17:903:4b07:b0:2aa:e574:c9f7 with SMTP id d9443c01a7336-2ae2e4fd80bmr13544725ad.57.1772171894244;
        Thu, 26 Feb 2026 21:58:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d1ba9sm48366095ad.76.2026.02.26.21.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:58:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Junrui Luo <moonafterrain@outlook.com>
Subject: [PATCH] dpaa2-switch: Fix interrupt storm after receiving bad if_id in IRQ handler
Date: Thu, 26 Feb 2026 21:58:12 -0800
Message-ID: <20260227055812.1777915-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261727-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,roeck-us.net,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.988];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,roeck-us.net:mid,roeck-us.net:email]
X-Rspamd-Queue-Id: 8BE551B3001
X-Rspamd-Action: no action

Commit 31a7a0bbeb00 ("dpaa2-switch: add bounds check for if_id in IRQ
handler") introduces a range check for if_id to avoid an out-of-bounds
access. If an out-of-bounds if_id is detected, the interrupt status is
not cleared. This may result in an interrupt storm.

Clear the interrupt status after detecting an out-of-bounds if_id to avoid
the problem.

Found by an experimental AI code review agent at Google.

Fixes: 31a7a0bbeb00 ("dpaa2-switch: add bounds check for if_id in IRQ handler")
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Junrui Luo <moonafterrain@outlook.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index def2dd231d1f..b70a232a217e 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1533,7 +1533,7 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 	if_id = (status & 0xFFFF0000) >> 16;
 	if (if_id >= ethsw->sw_attr.num_ifs) {
 		dev_err(dev, "Invalid if_id %d in IRQ status\n", if_id);
-		goto out;
+		goto out_clear;
 	}
 	port_priv = ethsw->ports[if_id];
 
@@ -1553,6 +1553,7 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 			dpaa2_switch_port_connect_mac(port_priv);
 	}
 
+out_clear:
 	err = dpsw_clear_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				    DPSW_IRQ_INDEX_IF, status);
 	if (err)
-- 
2.45.2


