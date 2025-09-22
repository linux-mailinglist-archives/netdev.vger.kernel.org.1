Return-Path: <netdev+bounces-225263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01870B91547
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759823AAEFF
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38FB30CB5C;
	Mon, 22 Sep 2025 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdVfyIXV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6130ACF8
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546779; cv=none; b=FxAutG6T3B/2m3l3LTue/zgs6t6K9H/o8w6Ajt++Pl2gfNeRAqs1NGC14SdNbTu4rVHz/f9JCFVzCLwER4RK+Ed+/kj3NiwxizjkE/Ks597QlH+Rlvaxg8Fl1SM75ljBEzBXL17RG8LciPeNw9i1Fx7kJE3LovXVF4oIL5MfEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546779; c=relaxed/simple;
	bh=SAyUnJhCwMKSbhb7U5p01vudm4sy13VmR4oxIBmj0nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZQdRmrlcDUzOj3vn9+Oa1PmPRpctGlkVfQu2oScwfMLmfMRKyPzFw/HGCb7A9pCrCOC94QBwyxIiIK9/6FlAAMhVC8IsHBmIPFF9uz53Yhb40fF9juakESOONVUcm/8bx7eXmVLQ4Js068Uvb34Ux5THiogPL73eHH9t0xTxoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdVfyIXV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so3900450a12.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758546778; x=1759151578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2cvRp1weqffRPvbmfOkQaVMZbMjAj/UHkPXTSQ25jI=;
        b=QdVfyIXVQgD8V8yNhNeo9v6DKyeuWl+MgNnxdDCSczYNxeL/ujp2p8PjCvFb+z9BB+
         RU8S21IyMa1tELKR2JYFTyhZiveOq0wt5vxuJh7n9agTjeBjntrIo3YcGfuhFqL6R14w
         eKunBNbsYuhzmkoPdsWEHDU4ccRKK+DGBweWYAxd4gW4OBNH85s+m+UJq5QEYCXVYTUN
         zbz1EP7XEiLxGiyfyJGuopoeg/6hC4v69Xf7Svxg2D3YlXHVbdU+4u+2I/nKkZXKFABB
         0BXbhY32YHxRzEEh+5MfKbdankBKagm68E2tPIPCbo7/p3F1KE9KhXXATjAVJXoiMDNN
         tlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546778; x=1759151578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2cvRp1weqffRPvbmfOkQaVMZbMjAj/UHkPXTSQ25jI=;
        b=IrlgaaCAijoX1k5uAZj+i3pbx8Rx6EY24KWSkmW8ogOvmle/466xuWw26a9Q33K35s
         CcdvueleflxkLO2N7GwlhYhT0I/GdgxxvHemdbxJQeTTuCNoYfTmZXpJ2S7eI5JHARn1
         7gtkT1go/NApAbMZFCtyroZL0vFMlDa9DZFjf4/MPHahYW+6QQxDCwuowwb07ZOlRvAj
         VSsflole4zLkrceOSsENJlEXjkpblaAQ9dF0iAGKofnSrAHDNTGt8Vo0//I4CGJjCKV6
         n8v1VByLbTme/7avxNAMcajGBWU9UCf8SXiFYmZNOfeQYT6LvMoQPoIQVLWLBIgAcJg1
         08bA==
X-Gm-Message-State: AOJu0YxKBwQeX8T7PDppaIIVnVC9dKK8OLvavaYA+xtuHXoCWcU+GYOD
	n0xARNjq0+h/Yp+W/6FshRaRyqBX6qBk1/tk93A0N00LVkZ6Wm6wbgE9sAE6OEru3qE=
X-Gm-Gg: ASbGncvw0++z/gfWr45zNEur8r1TQVwq8+UBnWlpAsH0QERotnCM3JaKxqcmfbZlKS/
	aMDVyaqXWqJVTO/Ywzkb3A6EWYpTo+toWBBAXJIaM3pV+l09JErct+dLbXq5nZqohYUSpOfd2RR
	DKQlWJUytvGiRmfvJWvScDYBk8Nc8mqNZFN0mWBVrQo1M6gRuJdfMB21TN+eiefh6dCMvR/Dzbc
	75brkCgN3lDd+yOnRdlY/hqbrR/rhogNhD5a2YOeMzCdyTUIdVPmSW/WsTA6um6n4J63g2yqO3I
	nnsMJt+ZwlTxbgzU3DdcrRndfMvun3WcBx4Advxz4jkY9vR29PEJSZysj4mCsrGvdtmi4rFrwim
	vL0ui3gE4D8OCGMOfSvG1lQmcjfLBng==
X-Google-Smtp-Source: AGHT+IH6Ot1LK9QjB6FeC20glUfGDL/Gnk3tPXUiEAOeZtENxIjiU3TXsAP1et3k8LlFBwpL34RbSw==
X-Received: by 2002:a17:903:1a0d:b0:264:f3ed:ee10 with SMTP id d9443c01a7336-269ba40abc9mr164331725ad.11.1758546777656;
        Mon, 22 Sep 2025 06:12:57 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bff2sm130200055ad.35.2025.09.22.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:12:57 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v11 1/5] dt-bindings: ethernet-phy: add reverse SGMII phy interface type
Date: Mon, 22 Sep 2025 21:11:39 +0800
Message-ID: <20250922131148.1917856-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922131148.1917856-1-mmyangfl@gmail.com>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "reverse SGMII" protocol name is a personal invention, derived from
"reverse MII" and "reverse RMII", this means: "behave like an SGMII
PHY".

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 2c924d296a8f..8f190fe2208a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -42,6 +42,7 @@ properties:
       - mii-lite
       - gmii
       - sgmii
+      - rev-sgmii
       - psgmii
       - qsgmii
       - qusgmii
-- 
2.51.0


