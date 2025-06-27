Return-Path: <netdev+bounces-201955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FBEAEB931
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E65189AE67
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1DA2DBF54;
	Fri, 27 Jun 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwtnV7uD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2122DA75A
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751031904; cv=none; b=gb5Zl1BMJJon9LVgDJKiUomlczmtzaPwgWHFKP2wZMUBzfWORNGgQ/3YXrYZnGLy8QQ+DBiHMRYCut0D4Xn6uCFDPQuNDleKqOHOy2Vue5gc0skD4RTmUV+beNz2BLMa0OrqwuTpOjGqhrKXgiost8Lvz7Eppa/LE27ejhiBK/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751031904; c=relaxed/simple;
	bh=8bG3o5gRZA5FwgazcAq8PDL3/TF2VFfzR2zlNp78oD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0RbfAgv1cDEPgUQg+HjmNaNX/9uMJ0cpH7pSrzznXq9WwfYesJ36Z+6/xGhRFB1P5QMTboacEjXltkW8p+8RKcTUUpG/vOnpKL4xeJtIvSSuhbX6p2BmQgt3Z4ZrnJN4qQEJFbYIl4HyRxTr3Oi3pvxrUuRXS88p3BtI+2gHyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwtnV7uD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751031901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sfCzCKZHgavpsXvy8TlJ0gEXh9QhrZFiByLFjuD7+iA=;
	b=GwtnV7uD1KwppUiNHkxloz5KOJbLNR5eX9naqbTzqoIZt1+H+2Ap6Fc/GRWN6bgIUSvopQ
	O4YSGx8ucSUdlC1LDD1DdiODVkYVXHkfN+45KLFwHAWmdiRdb038S3rZrnLN5c6QNuiInh
	fe2xGXwVt0lD0ZAfjXqWmKb5iwHWqdA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-IdqhVuwoMAeL8WFubcjiDw-1; Fri, 27 Jun 2025 09:44:58 -0400
X-MC-Unique: IdqhVuwoMAeL8WFubcjiDw-1
X-Mimecast-MFC-AGG-ID: IdqhVuwoMAeL8WFubcjiDw_1751031898
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-453018b4ddeso12652935e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 06:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751031897; x=1751636697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfCzCKZHgavpsXvy8TlJ0gEXh9QhrZFiByLFjuD7+iA=;
        b=NPYi78lNIaH5avWUfqNN48TXqMm38mx6zOK6qKUEyVQ1SlsHwQ7At4iYfkPcgja+/l
         uv4/YyqdUyP+wE4gcsae5WHdnwHe+c0Ud/BBiSsOvAL2pR3kPAkT3FSvWeNak9QRf8is
         cdbq950zWIjP0ErTfBettDvItwvmw9bOYlUoFxDFfFhmG+PORplIdS3jVrGqxV4SE3zu
         6hcFT5aCz/PmqyAG9Gv5uLXiMhQXQlcxqQqOOikf2OzxWuZQKpthjtMl2QK7hO2si6yd
         dS9ImA+v+0eaIJTpbwc9MbtnYOwKG8wcsKhhiMUagYSV+DrtMDeqOKuCzfnYxaaaNRCx
         covg==
X-Forwarded-Encrypted: i=1; AJvYcCV276BVSKzv0FDtm3bm/WcFXPl2GB7XrY4b1IH/7Skq19O5Z75XNmP3lLelPCNTOaUVEITcUJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/EHShl43FCmXw2ET4k6e8zRMC9W6kMFkZyOqEHCvb1XrCoCw
	h57R+oAj0owyFAY4kRzNF5g7TK4Ntt9kJEowjO3htbvzCPMVSxxlE2ELlfblSJjRu6DzXikZxjs
	qDJE3+Sr80X/NDrbfEWNl2PDj7jIdlIBe/0+jNPpWXCDYfGyLYn1McKVeTA==
X-Gm-Gg: ASbGncv/aF3X3u+Y+E/JIbWPpCq+EIvUrpdkb95BpPPflLz/Y4cBGBnwYjFwQJ/p0Op
	AeicBXoNCZXZ0WKU+ztKFPNngzXU91SNAQpUdloewZI+ttS4o2/xIAm/YlCzRtzxoeN7LWw3ZcC
	icVesCsS3u2R6eApWK/c1a/xs7riqrZtJ/Lwo5Xr+pRlBW0T8WIi5TVnmTOcKW/3KReO5hzpt72
	WrdnPAxqEtF66sDvO+VGnwXzpFftxW2Pexbdpz/tz6tAk2wwpCptW1NB3iQW0l4JiGJbY48hQEx
	El3H8m1kUQUly1y2ubG54fRlqRNk4ug58TNz56gInjtV99wAfSuYgJ8y3YVa3+yzrWG2
X-Received: by 2002:a05:600c:1e0d:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-4538edeb1e3mr43906695e9.0.1751031897509;
        Fri, 27 Jun 2025 06:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5wO7lBzKmrbrRtSD3MlBN7myKwo/CLhGpeObS/nJo2QfYJbjf/v98tsfeefUPIC/qB8O98A==
X-Received: by 2002:a05:600c:1e0d:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-4538edeb1e3mr43906355e9.0.1751031897103;
        Fri, 27 Jun 2025 06:44:57 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233bd14sm83028885e9.2.2025.06.27.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 06:44:56 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry after renaming rzv2h-gbeth dtb
Date: Fri, 27 Jun 2025 15:44:53 +0200
Message-ID: <20250627134453.51780-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit d53320aeef18 ("dt-bindings: net: Rename
renesas,r9a09g057-gbeth.yaml") renames the net devicetree binding
renesas,r9a09g057-gbeth.yaml to renesas,rzv2h-gbeth.yaml, but misses to
adjust the file entry in the RENESAS RZ/V2H(P) DWMAC GBETH GLUE LAYER
DRIVER section in MAINTAINERS.

Adjust the file entry after this file renaming.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d635369a4f6c..bff9651a9a94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21271,7 +21271,7 @@ M:	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
 L:	netdev@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/renesas,r9a09g057-gbeth.yaml
+F:	Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
 
 RENESAS RZ/V2H(P) USB2PHY PORT RESET DRIVER
-- 
2.50.0


