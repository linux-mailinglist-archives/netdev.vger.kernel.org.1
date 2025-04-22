Return-Path: <netdev+bounces-184916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D480A97B18
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9387A363C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EF321ABB4;
	Tue, 22 Apr 2025 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KJgpv+Mf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72DB219317
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365020; cv=none; b=awx3QkHL1jnXVg6cirjZFSmVfcMGjb2kGC9kyNQkk3hyor40eqd65hUY6kyTM0p71XSgCHu24C2AcSBqAq0JP/2s12+a+2BSapE59SXh0Ngzwwa2VSBTdQdUCyXsUphEEZxJUxuVED705XniMuKqGa8f8N0Q1lTmJgMSeiU/A04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365020; c=relaxed/simple;
	bh=6j9S53xpyZA2YvaFLv7oAI4t9prIzRjPnuNZ7YXlQ4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAJYjVCzXG79dc5sVpE2mSRw9lN/Mqi5ff+jTfBpiG7s7BZJybz67wuRjSkC6rGQAsQLuKUe5Jl260N+q6+pA9TeWb2ykgCTqM0Bkz8dD2xmPVvqu9j4U9slIPt7jQNCQrnj5Lln7IDINqdGquw/FIVIDhklu7EZECucDxxD1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KJgpv+Mf; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72ecc30903cso3294372a34.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745365018; x=1745969818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aC7aZSOIYYrhp9wP2gWtTrG5J3EW6XZ4IF3852eWLcs=;
        b=KJgpv+MfcesV7MIhNNJ/MR3GDVDrl67t0gvycc9QzjVAlfOqKLpInz9szHL2IbMFdL
         LkBdLcw0ie5a/InXxLwI1bFlCluI7fK8dB3Fy1amD/m/Pypaa/zxWoHBii56ZuzpgtrA
         Z0sx4q1OMOi+vHtgg0CByZVxOmSafKHqwa68c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365018; x=1745969818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aC7aZSOIYYrhp9wP2gWtTrG5J3EW6XZ4IF3852eWLcs=;
        b=sqvGdgwRoRhxhFMWtQBVjIo/6qYetDvVOD6uLtRBY6Mx3h47UrAX74uOYYvlVr68ly
         wThGIKVP2n7ZmJfxS/AHXqWijiL9J3OO7hSkvVxX0Hgt2O8Y88iVWxYYKynntpYYR5pK
         cE6iaxr9hxf1gxx9FujpB29RqwkJpNIN0t7ONy0UhYolbmlx7nrmhYb69999ZSHPPa4J
         SiwXzU5A8rAyJQhuZ3n07QmL5yeL+J6PBKDNAlIXBDvYgMJFbUVJ7e418XYNLr/cG9bL
         EBgJ1PgOnWuvO2TEC0XinNoLYluDqtCy6eAufvtueJuPycwvzg7oPhW2Yj1IuI4G8Kk2
         4D+g==
X-Forwarded-Encrypted: i=1; AJvYcCVec2sd/YqjsUuZcxpYmV2RAxKIqhFh9HFgkMdxdlt6wK03cDLvNF8RktD7qR8rad3U5Rnb3ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDrClGaz0eXwRe2nPLOAF/UrIeMJd9siTsy9uYzli/+Ylqbei
	10KewqyIzzrXhx2FS4t2C6emqPlBMaAaEldSvFjM6dgDUmebcxZ9mG53SGiB2Q==
X-Gm-Gg: ASbGncvu6lorcOEW5f7hL6vtgfcn4JOHsDTZ9VMpHK1r+CdNjQVjKKXq9FiFaxF+Ea5
	gZy9+zHTx1Szd/38G/Hco0bmnkshyR37l8OIWvDVOtoPt6kvqFoIrARJaAX3TLpvAAQUT0VHLW4
	ADryN2AGyfpVZdqcZuY73qHUYA1y5UMk+UTMuCOLO9M0YRHui8OgBu94qFr/ECJETYvQxCTaHX1
	1T1kT87nqy8S2Cr91jXbnsO5bRXGVBTH4ppPYneOcLJnKjiSfwOX74vCPbNnxYi+mqhwJHqEK99
	gkUUkEZr9Ktn32Nfzo20YIXn9Zt2ulqnHKjbGQVGk7KwXisNUMLEqvrY4/sKhC/R4iia2uFarz4
	aPicmbDmshhiV4EXXgnlJW+K80bHV
X-Google-Smtp-Source: AGHT+IEkfpYa9fRkS73u6nm/pvwQFHGyQje4Cw7zxAxtZCJFzs1yCyUJMlorBcANLHpmY6Dki3x4Sw==
X-Received: by 2002:a05:6808:80c1:b0:401:16e:b692 with SMTP id 5614622812f47-401c0c3d025mr11266125b6e.26.1745365017732;
        Tue, 22 Apr 2025 16:36:57 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeaf403sm2333582b6e.7.2025.04.22.16.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:36:57 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: devicetree@vger.kernel.org,
	netdev@vger.kernel.org
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
Subject: [PATCH net-next v2 5/8] dt-bindings: net: brcm,asp-v2.0: Add asp-v3.0
Date: Tue, 22 Apr 2025 16:36:42 -0700
Message-Id: <20250422233645.1931036-6-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422233645.1931036-1-justin.chen@broadcom.com>
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add asp-v3.0 support. v3.0 is a major revision that reduces
the feature set for cost savings. We have a reduced amount of
channels and network filters.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
        - Split removal of asp-v2.0 into a separate commit

 Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
index 1efbee2c4efd..a3db6d594c8c 100644
--- a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
+++ b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
@@ -15,6 +15,10 @@ description: Broadcom Ethernet controller first introduced with 72165
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - brcm,bcm74110-asp
+          - const: brcm,asp-v3.0
       - items:
           - enum:
               - brcm,bcm74165b0-asp
-- 
2.34.1


