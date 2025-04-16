Return-Path: <netdev+bounces-183530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF76A90ED9
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485A4447CA8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B502459DA;
	Wed, 16 Apr 2025 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RJpjurMy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1BC245019
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843706; cv=none; b=Mn11qiXbrBqOvcqtAKz1Tcz/Rln10s+rt0RjYoV0zX21cCFrPvM/MW4j2dD9ArI05UZ6arv+nrt2gDWdzwmE2yZJw0PM0MsvtMbWhTmtcrqmAVmlDGiaxrby04L7og8u356o5638zPlaQfzbnHlhqnxmo0tbh3+6ULyK+XmtzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843706; c=relaxed/simple;
	bh=syPYbJ+CX3gQ/ZgE9xnZGvED4BvjLmu9SzN8FBkVmno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HuR2n8flgPYuR4LX0aGXDgaieL6y7EDpwdnPtKSM7i/B7t2l10CeHvP74Z2kDK45N/ISB4AM07rJmlSOUl73lAvNa7Bk9wiK/1AaiwmdArPvUWHPzY3KH7JDEl/Ak73dBnZLBGHI5wFiEE9ML/uunTezLWoGNi1bCe5NC0V1TMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RJpjurMy; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2c2c754af3cso49588fac.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744843703; x=1745448503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRArN1ZnNcOw2VZXjNArOLq67cYsKNI+dicz2oX9MdE=;
        b=RJpjurMyw9n3ma1Iag7Us8o9PwkJMdUvB8dI6kmbCI6aH3rUWBzQlPyXhJnGnM/On2
         I02IrrpJ1LG7yzFRFHtnIWeaMdXAIV8XgRKJP15BgTaM0ZRpelE/QOp1wGu6CawgaI0D
         fanau6sjq07QUvWGlCKHew4CPM9yxBAo0emDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843703; x=1745448503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRArN1ZnNcOw2VZXjNArOLq67cYsKNI+dicz2oX9MdE=;
        b=RTeaB3LJwAYMPjyuqV7+UMFMGbJyo/tWkKm8CIrQSevvz6CYEoXl9WaS1zHjsnInNw
         RbUYZSRxbDmEDDVfBH9NK1kzOlD1xMzLZZbR1GpGqoSF+192K8rEhBCXuoFHvBZCb+nC
         X/7KVYF9JjRl7mr+OKaQRD0KLCBzr+PZ/14by5iEBqa9pVY3nk0sSYUOO8j8/JLLuDTX
         e/EOEvPLq0Yl4WUrujX+N5Wmch/iwwzTMFwZlFul9DhEJgj9gomcqnF5U5hnaQjLaVcZ
         nPKNai0OcR552ls6bAtKXGipVdI+K0EmYcdOCk/nci9Osw8YKfL0HhxVjTWIesTJaeDt
         hq/Q==
X-Gm-Message-State: AOJu0YxHb1N4XUQoONHFjzG8PkRCrZC4XK+78o7w/h4tM4satyv+erZ2
	1gQjFNjaofLsnNahV8oJ/5Ms9HDBlFutRkkb2V6PG+UQ+VM4vHeKyJRzeJy7K9UaYMRYrUDMV9Y
	XhSRwBwZ8icWNyvSsZnhpjUhuYh+ntRF2AmckFO/AOPxb7PzOmNnOjMOiA7DsgpAJrhXJoPkkXc
	qz0bWUfZk98nyW5fZTFJ2X41zReGg7SCF/ykiVsvQ=
X-Gm-Gg: ASbGnctagk661uMrbkDjXhZJk3o1ROhGeLkKOlhR3oC+I5haodv+zZcJqpxfkLJv1ha
	0ZRE+8BpSkKwAmHS4z9xhBTU/8BF1tZTK0ji2tEPPD4gJSKx8iJTTNZPDvwFT/3kOZBcsXzrIKP
	j8uWNuc4ycvAa78npSRpt+w9tIcPJwIWIPeHVzUBMruE68/yThBW/CgJBB5/2jrJV/R5UP2SFgM
	6I73w4OUpLw/HGg7FvMfghoZd2ccnxFSxi1eiZB9MRix4ihiulLkux+klo4OsfxN+Kq5TfgKTmn
	EsAEwl4TNnCtTaEfKUTRfm3YLtMpcNZHqRti0n9BZ8U22NIuRxy4d/tQoNlufklzRwTD4RksRfy
	qQKO+7HdYvdHiqYgL6g==
X-Google-Smtp-Source: AGHT+IFwNrdhL9eULNQPTOZG27V5rGgoZCtv7V3NntsURdza/jYLsRlk7JL2rxw9Rp/yg1njK7EUWg==
X-Received: by 2002:a05:6871:4106:b0:2b8:e6f2:ba7e with SMTP id 586e51a60fabf-2d4d2a9239bmr2266278fac.12.1744843703581;
        Wed, 16 Apr 2025 15:48:23 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73d71813sm3015956a34.26.2025.04.16.15.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 15:48:23 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: rafal@milecki.pl,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	opendmb@gmail.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next 2/5] dt-bindings: net: brcm,unimac-mdio: Add v3.0 and remove v2.0
Date: Wed, 16 Apr 2025 15:48:12 -0700
Message-Id: <20250416224815.2863862-3-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416224815.2863862-1-justin.chen@broadcom.com>
References: <20250416224815.2863862-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The asp-v3.0 Ethernet controller uses a brcm unimac like its
predecessor.

Remove asp-v2.0 which was only supported on one SoC that never
saw the light of day.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml b/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
index 63bee5b542f5..43516dd357b8 100644
--- a/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
@@ -22,9 +22,9 @@ properties:
       - brcm,genet-mdio-v3
       - brcm,genet-mdio-v4
       - brcm,genet-mdio-v5
-      - brcm,asp-v2.0-mdio
       - brcm,asp-v2.1-mdio
       - brcm,asp-v2.2-mdio
+      - brcm,asp-v3.0-mdio
       - brcm,unimac-mdio
       - brcm,bcm6846-mdio
 
-- 
2.34.1


