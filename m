Return-Path: <netdev+bounces-192798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B9AC11A4
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BFB1188D79D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4C42BD01D;
	Thu, 22 May 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+F+QziP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F0299ABD;
	Thu, 22 May 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932836; cv=none; b=ikWnoNtEZc2gvfXezT9/MrElSoKmn/lb5OXcCPaL4BJrjHy7fcaghj/zNjCfWLHIV4MAaZ4t01EDRKQzSGzSERM0KwVJHvbG//aj5f3b5pP0f3T4Ly0xuhPiMufjJ8Xim9BsfCHjeJy3IITUbuJhUL0Pvs1hBkdR5Oo7Gc4cEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932836; c=relaxed/simple;
	bh=GACcImWdLii1drO2xNq+st+RuNhAQeLtrtHc57YPjUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6NvfeYk51INUDyHEUSTFwpfSpk8YqVVrnRZ7KNf7Z21QTLQQb0UVoNlqUO6fgvMkq3pRMTPxT68Bd7ToSRcc4HMdqCb5bv3eYgpz6+9v0vdqWHjasitegF429guNuxpNxz1i5sjcOEFlzuiUbXnGpzMotwed7EREFbLGbACyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+F+QziP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442ea341570so58284535e9.1;
        Thu, 22 May 2025 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747932833; x=1748537633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtV9SMxOKB7GoV+djrIvJpFf2SMA0j+XNe47HtIbik4=;
        b=m+F+QziPv4KJdEhCDH8+ZF+ttGEbfhNN8vDL2011mJ5ZiQxF2OfTrSPx9CkCKwIXvo
         3puM4CzpumiBlfbmb2IRppMni2l4/Dspa67DvOQDdDvxt78JagwZjpERym0njspQUIBB
         zwmJMgGSLBbxHmmWrKI9xxUlSJbKnnSSFmQyN9Zi/XYYbb3iOYqklRr1SXY8h5fD8l/T
         eD2g30Fu140dzXOuNvcHyWUch7pfGFSs4HhU5WfaUh+OrC0V7TSPuPhtpu1RLHmCNWUS
         iVy0U8dHZ0EK/wGDoewaOc880eQZ8b3fW5+YJa6+mQmkMm9M1VgCxeAwD5w2m5r1wOsQ
         khcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747932833; x=1748537633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtV9SMxOKB7GoV+djrIvJpFf2SMA0j+XNe47HtIbik4=;
        b=BKXyosCPbu3AiGnXbhJI7H7ioPxjmgryd4WDTsgzHXf1KKH9szopg2wRiGlco63lv8
         tA+1Bb8IuiGd3O7zAMhKcBcGZWVINnBNKUUrd+yHn4CKjDg85RnSP8ECGqEbg7Gd7dPv
         ODbZJv9zywZ5RuqmkykVcTI1DTrSk+C2wkxc3QIqwa31MRAJeYxYS4z72AAqZMAj2DBs
         Eeq0sz1ASVBJLDATw6EL7ZUdul+ipMk4+DE/Id0qw8ifTQ5S2EZzCb/PeET9ciazEvLX
         SnvUm4C4pnyW9UX74WfzlV85mwYa0B5ph05d0N3oeGva60UV0Q1rVEVfaJEpRkTmk2+u
         Jm8g==
X-Forwarded-Encrypted: i=1; AJvYcCW6dYvFzZekmOZtXzoNcS3Bfu4qVup1LFkDsKQjXSJ6GsWVSj+KvCjwjHStiqVQldEd1Obssy7x4o1o@vger.kernel.org, AJvYcCXA9VnRszJdRKtfctw3jzlhyluJotYEnJlht+V1a9LJEO2dbFu6W54jf6XA/z3NVeC4fVO+u5Uz@vger.kernel.org, AJvYcCXMFbIuOoxS0YZpfM2vu6kb6zjqduL/95y4JcQIjbYvv9jGZmHavbFtQGZUrVitBi91Qx5fUlCn/fZNTqgw@vger.kernel.org
X-Gm-Message-State: AOJu0Yykw1HO0BfnpGB4FxwHsUiAmHZFVUZJ1bZb0HEPWM7Bhw/oKD19
	7kc5MIDWjLlDCACybGGz+qQUIH9POklx7MhgWapB400j/bQYfr8cVveW
X-Gm-Gg: ASbGnctmnX1i8WdRUH9mhWZD665SjMcAEkLyu1G5tS2qNcjlYj3k2OOMRi3GOBNGIId
	LroYLDsMFAwWXYXrOBUq8A/tuf3TtnEMJxDhwelIqqxUsfqjv9+TCLeUNttzgxVRD5mAuRdZ1sL
	BEzE4i3UpPj2cvEbcnoE/mX0TnI4asauvp3AeH2ZS1ukTYJCzC57AmqoFBCqd63Dq3FMA4FgGs7
	SZyMmoEVZskf7T4qDp8mmZedVB1BW+5DlZgS1KbnYP2IMi64FATVfN2+eYlDVnOORmDNYYD7HLG
	1mKEN5DsK9iJvalXsnzoxQaEr1sRwLMTGVFNkaeoqagyWI1d/TgDGnys2PEMnV/AXXUhHr7HeEs
	4cFh+TWMPoF1X4k9o67790I9pSqUqDmE=
X-Google-Smtp-Source: AGHT+IG1T0G5yH1FK1thK1fMxhgoOJ3qYtDlQkaBu0K+RUy9jpWdeT6ZDqtYAcPVISb4W8cXirC8OQ==
X-Received: by 2002:a05:600c:8207:b0:44a:b9e4:4e6f with SMTP id 5b1f17b1804b1-44ab9e44edcmr33448105e9.16.1747932832294;
        Thu, 22 May 2025 09:53:52 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-447f6b297easm118737525e9.6.2025.05.22.09.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 09:53:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 1/3] dt-bindings: net: dsa: mediatek,mt7530: Add airoha,an7583-switch
Date: Thu, 22 May 2025 18:53:09 +0200
Message-ID: <20250522165313.6411-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250522165313.6411-1-ansuelsmth@gmail.com>
References: <20250522165313.6411-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add airoha,an7583-switch additional compatible to the mt7530 DSA Switch
Family. This is an exact match of the airoha,en7581-switch (based on
mt7988-switch) with the additional requirement of tweak on the
GEPHY_CONN_CFG registers to make the internal PHY actually work.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index ea979bcae1d6..51205f9f2985 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -96,6 +96,10 @@ properties:
           Built-in switch of the Airoha EN7581 SoC
         const: airoha,en7581-switch
 
+      - description:
+          Built-in switch of the Airoha AN7583 SoC
+        const: airoha,an7583-switch
+
   reg:
     maxItems: 1
 
@@ -291,6 +295,7 @@ allOf:
           enum:
             - mediatek,mt7988-switch
             - airoha,en7581-switch
+            - airoha,an7583-switch
     then:
       $ref: "#/$defs/mt7530-dsa-port"
       properties:
-- 
2.48.1


