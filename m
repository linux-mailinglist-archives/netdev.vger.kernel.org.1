Return-Path: <netdev+bounces-218483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A42B3C9BB
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 11:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B4E1BA6289
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605D525A33E;
	Sat, 30 Aug 2025 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPwM9+0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73CA2580E2;
	Sat, 30 Aug 2025 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756545546; cv=none; b=dZT/GKg3wKGBVSqHuiBsZC2r7Gc0Bx4E2xKiCxaIO0CScMxB7GvPg7hABKzWNjW+PVX9j35mpzHgLJ2P5LlAzoeDpPvJooWkHTjG2jOn6FP81mFZl+EskO8QZqWCM5gQ3864LzMIvfcFtfRgPuQmF/GK8Rr+xb9YwiK69zO9jPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756545546; c=relaxed/simple;
	bh=wjQj2NN723j/SAiLZdQVT4vv0CxVrRicn94T4FBYcMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FeejSKSJ5DvRJS3Kq22MvZW7SnFNr03efEWmIMgdRyp6O0nDn8RGO7v7DBeo3uz6k0mOmKNYFb3t6kfluJF9AH/0XGfGw09MzrASMmB3KB1o6Rq8u3czxSMrpY+dsGdjuephmF7LkMlpMr+daO81MEPtEU1IWE+RtvOW5UG3SKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPwM9+0s; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24879ed7c17so21652165ad.1;
        Sat, 30 Aug 2025 02:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756545544; x=1757150344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swuwTOihjSF334nInAXr6n8SBY2/7NVKEbQuAYBhpKU=;
        b=aPwM9+0soMkycw9lSE0c4wf6dAoMucyerGYp5Bt/yxWPd1oCtdYWGQrTZzYLkZUIne
         6JZzADY57lkMBVU1Oft/HFEEyQ1JSUMThiV90ZknK+F+MzlW2x7JFs7Tr/Shw5ryg+Fb
         SAEku2VVsu4xWKUqGg1Ivpkx8vhVSnhLk3xxeJ40aqMDNVKlCYOGVu5H6lmih2ovmd1S
         MNDW5kyZKS3/wz3DxUWVl8NuBL5lwk8d/zm1UxlUpgN7W5Bk0XY6lmlA25EV+YAOn87n
         va6pmvXbxk9ejysLsQ2iCfVERRZn2nN9daTBityJbWSNc5qiY1V++vY3VhdI8tfwmh5n
         6SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756545544; x=1757150344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swuwTOihjSF334nInAXr6n8SBY2/7NVKEbQuAYBhpKU=;
        b=YwRiZjP7r626YW4hfx96GFURXUlN8s+cILUmO7SoOQbyqu7w25SgwUiqI9fGhXGCqb
         QMLC26t3opZbDDoLrflgJkmwJjNnCN+QcXsSHez6RsmmFvQceUHQStFzxdptT5wBtYdp
         ORxP6f78BLqjqZlxoo5CXlDwx95lE+ZUXdfJRp9Fncz5w0xUaolp5g0xQ8bNfdWMfFk6
         pEeCkVrQfyDYelyEY8AmnVeVpvHmuNQPaBV4BqXfnSJ5ANi9BP9Qbk88ZDgFcRwGt6nE
         9sAQnBHbErC6ydpJ3vmKWWfMX+sIQY8yx5ogAL2VG4Njg+khZfil5cfPaNVuTvjzIZij
         bGxw==
X-Forwarded-Encrypted: i=1; AJvYcCVgG+owAC9Q+yvrwCVSn6nq6pAjqhOTPkeS0umh24WDmGz9bUUpYWuQsJA03cVQwloaq220MI77PYJz0YI=@vger.kernel.org, AJvYcCWi3YD1jds+hqVyf+g8BRolH0d5yYQVROx+eqBPaoW7vS6R8x11b7PD4BfslM8Ky/aVfQV9Mcth@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwJVGfYoX6fX/n88u7TyueLp42Zud/jGGl/mfp6xsKTRtFMyf
	A+H8ScL0AVIQgJYKIeEt2bmReZIxqlaoATI1+r3xuVI7onVbMl1Hc713
X-Gm-Gg: ASbGncuO2sM+/8Azmfk8NeQ8m75wItnHJSFniKuwIpxNZsB0ELqpHQPOEhvsIYQdZ7m
	NEB5rPfdTX4O63w53LxX7Ivfy6U9HhzwZtBgpXfClRnPy/LJnf9KwUWSh2bCSYcylJnQkYjtyVE
	wi0ZqYiGR29wbReVFzz3WKLmTN6d1Jj7xmyGcHVc/MfmOLK3K8Psej7Wy0RmVJiNvEaWOgJJ7j+
	zrhhIfRl/6gCdT1LvdhgnYNwIyBhmIHazwy9ZRuKpcOTF7OGZ1//nPKQEbaRg2z6eTGscrlGSHB
	y+jggf/Vhp3WhMGaC6s57qF6TgcicIEbWCvo1nJMPk2lXeco78nRq8shtAsYDUFAIBgowsnZidG
	NMGZeSaW33WNH2J36ZxPYIdyNfqK3eLUeTvFHd2RxrjPTonnXM8kJnIuNrye7UvqJ/U7MG2DjWm
	HXNK4Pmyd9pXVchmYD9UKe+3EQsFgIWU/7Ix2edwuaP3rCOOZx7knxJF8=
X-Google-Smtp-Source: AGHT+IHVFhMFKNWmGcs+78QWdioehssK2kGmk59gfKYn3K0XRhTFqEdm6P/MAWoZT+AMqqLbj+C10Q==
X-Received: by 2002:a17:902:f612:b0:249:2360:6af2 with SMTP id d9443c01a7336-249448db16bmr19943185ad.16.1756545544271;
        Sat, 30 Aug 2025 02:19:04 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.22.11.164])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24903726d20sm46606905ad.36.2025.08.30.02.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 02:19:03 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] net: mvpp2: Fix refcount leak in mvpp2_use_acpi_compat_mode
Date: Sat, 30 Aug 2025 17:18:54 +0800
Message-Id: <20250830091854.2111062-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function calls fwnode_get_named_child_node()
to check for a "fixed-link" child.
It did not release the reference if present, causing a refcount leak.

Fixes: dfce1bab8fdc ("net: mvpp2: enable using phylink with ACPI")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 8ebb985d2573..1faed2ec3f4f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6801,12 +6801,22 @@ static void mvpp2_acpi_start(struct mvpp2_port *port)
  */
 static bool mvpp2_use_acpi_compat_mode(struct fwnode_handle *port_fwnode)
 {
+	struct fwnode_handle *fixed_link;
+
 	if (!is_acpi_node(port_fwnode))
 		return false;
 
-	return (!fwnode_property_present(port_fwnode, "phy-handle") &&
-		!fwnode_property_present(port_fwnode, "managed") &&
-		!fwnode_get_named_child_node(port_fwnode, "fixed-link"));
+	if (fwnode_property_present(port_fwnode, "phy-handle") ||
+	    fwnode_property_present(port_fwnode, "managed"))
+		return false;
+
+	fixed_link = fwnode_get_named_child_node(port_fwnode, "fixed-link");
+	if (fixed_link) {
+		fwnode_handle_put(fixed_link);
+		return false;
+	}
+
+	return true;
 }
 
 /* Ports initialization */
-- 
2.35.1


