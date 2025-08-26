Return-Path: <netdev+bounces-216961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3132AB369E9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DAB56379A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C455635691B;
	Tue, 26 Aug 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0X7S72p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A934F49D;
	Tue, 26 Aug 2025 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217871; cv=none; b=VFAj40bwQ7oy397npDa7ZV/B6EYHeu+D47TGD0xTqbUgzYa6t1mIMP1LF8YW4J014HrQ5zDp1T7zLmkR/FhaNh204rA3abxDINYWXODHZJ2NitKMwbbylS/+Pl9wzj2P7+bjPjVPVT4gz/Ua43mDA8Bi+PGy2gXi7qIquBeuAUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217871; c=relaxed/simple;
	bh=ZvhL4mM5O7RcKKgdV5IEIL28EGhE4mqTAjWjo4eUjmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tcPudNkjO4nKwoWhvcFICfZ2iKsTQ623mTtYJoixIBYyNAZPMvli1YccmJ8GIPahYSUnEaPNQhDR8eAuAk/8zgGyja0ha0mL3MYV3iEdQXOjX8Y43Sv0o1GxrdzI6AlRgZtZcrUBhonenVKJvtZaO2t8N3c267aiSVlQ0JmmaaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0X7S72p; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-770530175b2so2132640b3a.3;
        Tue, 26 Aug 2025 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756217869; x=1756822669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BymyHutB1XKcchz9Bb/SXorAOZz+b/iEchUrFWQbsM8=;
        b=g0X7S72pfOXIGczH7sUbT+KJ32yy2eKa6RFs2ecxS51R9/lgUz3XPKrAh7+pMd0518
         CSdcHz2M27/yIrgAhyA4i8aBF+XWP0e6p7UfLKgxcAtUVcMBSSMCGlPM3LymBn6dQZX8
         dsPL0iNNswKxgSaz9hAZMdKYivtlbLKcfGYDFiy7spGTlXNxJaK/V1iZJndvGovV50I+
         XizsxBiSmfbDezdphVQ6nUM+EpUpetkF/NeQm9Jw4rQC5BLvCOSk5/lRmArlAHr4ZTTo
         aFKtwVmxAewfym1/vC/ZW5QkG6pn+HX9mvMReZhRJEaEL65mxnJzeYDxFM6eJE6ciWv7
         8H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756217869; x=1756822669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BymyHutB1XKcchz9Bb/SXorAOZz+b/iEchUrFWQbsM8=;
        b=Wf2i5bEbf4lvD8B+lb+DylXezVl9TtG5QhG1Jgjkiud5Xg3AlC3ElKA4D7rQf1PO2e
         LaahBe++gSmcjqJKJu0Wh1MseVWGJG0cwYUMwuqhAB1fpQ6CLzFPznCAVfURwSNpWQNL
         uABRXTtKg+AklKtuwRciCKU58En5QCY84EjJ7zdDqHQmiEjeuC4ZX9gd8ISq8n2PyMCW
         sOeC1aixglUBYcVnqe+8uqTiFFvw5gB0pJvgK3dbB7cdrut9lFObbYSY1vALV6kxxo30
         0T9k8dv9cfq39I1Hjrq7r+hW0Vu7rLQn05m/UoDRsNJnZ/WhvM1GfPvpf9LTfwn/F48R
         MO5A==
X-Forwarded-Encrypted: i=1; AJvYcCVdJle8k1a2Eq2xU1dxCBm6f62QgtCxznTP4RH7Rr6yq5ziau39+1jnS5R0UCFS0PQn5aZ+Qxm/@vger.kernel.org, AJvYcCW6yrJS6Kgh/iNvXo/J6F9Yo9Jz/gHhpLVFiLiyow0wd87cIlzcQeIOnov1549JFcfCfZ/4otWEGqTO@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8tWo14yR1uvD0HbjzOlYh2tTUaCPv09mRe23ql4xNSdDUDTH
	4voZzKKYnphkvRDCugf1wFCH92zlGOPqtDlHW440IF4t4sgTIa21WEjJ
X-Gm-Gg: ASbGncsp77fZ8wMGefuzMzROFcBY5ir/0FSnAN12BdgwimZLmiYnE9lSy5tsv0HQE1R
	7OeUW58StIEkMasyq8qskGwnrsJ/sxnJbrngDIdIw75YmzGXOjfrSdvXIOvw+pRqHuDIgTBSJxK
	0XGBqffV6/7EzH+3H3MHleNMjdNq2qEfSRN7IuIrS03wDhL6JAi6R7tvQR4ujClm2+U8jSsI/2P
	z1RjL5owR71l6O92LKj4iZ2IL7aDA1JqIolRZmtwuNtVVQHS2RWX/MK1WUxwsyLVnsHiyRc3qtw
	Frsl1gY3D7N2Pi3tGYBns8xK9ocuDTk2NelG0bJrSjjm09Um/gKs28q9wYiivOpzcrQxOKiMiC0
	r1iLgYuX/4ZSUmEVL5SzY24v6c4UBsegHOEQ=
X-Google-Smtp-Source: AGHT+IHBZf7nP/IklGTBlmzviWZdGdZZuwqs2Fz/jpEJAsBWmh94iU322L0qGtfQ+MGPMXD9RvAi4g==
X-Received: by 2002:a05:6a21:6da8:b0:218:96ad:720d with SMTP id adf61e73a8af0-24340b7c601mr21735141637.1.1756217868851;
        Tue, 26 Aug 2025 07:17:48 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:e9f:3f15:20cb:c34f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb9ce58sm9250854a12.40.2025.08.26.07.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:17:48 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: krzk@kernel.org
Cc: mgreer@animalcreek.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 net-next] dt-bindings: nfc: ti,trf7970a: Restrict the ti,rx-gain-reduction-db values
Date: Tue, 26 Aug 2025 11:17:36 -0300
Message-Id: <20250826141736.712827-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of stating the supported values for the ti,rx-gain-reduction-db
property in free text format, add an enum entry that can help validating
the devicetree files.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v1:
- Added net-next prefix. (Krzysztof)
- Collected tags.

 Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
index 783a85b84893..7e96a625f0cf 100644
--- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
@@ -58,7 +58,8 @@ properties:
   ti,rx-gain-reduction-db:
     description: |
       Specify an RX gain reduction to reduce antenna sensitivity with 5dB per
-      increment, with a maximum of 15dB. Supported values: [0, 5, 10, 15].
+      increment, with a maximum of 15dB.
+    enum: [ 0, 5, 10, 15]
 
 required:
   - compatible
-- 
2.34.1


