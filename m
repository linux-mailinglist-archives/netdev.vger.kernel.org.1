Return-Path: <netdev+bounces-156235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1055A05AF0
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267871887B58
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D031FA151;
	Wed,  8 Jan 2025 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ejmp3rcB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807EA1F941E
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337772; cv=none; b=mh9My5fq6eYzFECStw4MiC+qnnZVLKnOTPumzVTB5ZFS8HZr4bItYLNtnSFRiks7Ks0TzQ8j4KAmu3+ZGWniFxQqZFKvUdYZjxOGZ8Oya1CLi832QHJ/E/hfPVKMIViiK6T9PFOB3LlixJzgCTKQtmVV/IZNSWBU/i7K2/2DKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337772; c=relaxed/simple;
	bh=tf5tt0BwsPCPSLPP0H73t4FU8k2JMKXfyoSUw91MxX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n7d4MnV52VPB1/EmXEWTYqbo87fr5CiiZDPnoQUPG/W87Ury9pUln/Kj0ZO2hUHCxRGWYFGH/u/h4KBldTOtFT2r64rHNj5BkRndeKg+NF2Kf8xKX3X2WeWIT2QbV2lfNYoYwPw7mzxPTC6UPKyzDnMVdDOgTDvWTa5GdeFIoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ejmp3rcB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3c1f68f1bso2994360a12.3
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 04:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736337769; x=1736942569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Fu/J7aLcA/6JcanW9gRS4vVtHfaRVS9VuYzk8LT6DQ=;
        b=Ejmp3rcB4sCcsaFIErGIy30v0gbfdg3YxxgCHl6gffuTfFBm3rxIlm35HB10ulskyb
         MhFR5xklpiy57oMFQycrDIZ9vixzQrobKlwKHg9g4Nwmpj+VXfBMLAsH0r98IPJ+/DrR
         iYKEvcGWl1v6voFrNqi/ZzrIH5UNp3/ZKAifhUgMaQWhyjkdQXRAoTIH1WxS89EUfh3/
         8ln9MWgRnnhzg9ZLds11otGsSUnHs4Tcv8sphVLn+23Qo4QytBlEvPoNvQHS+jd5iZrx
         UzmXVmylkdCfYqhVTnbHb9VY50hH7XY3DIOrOzu1OrXav89LJpkc9/kHFhsoR9Ajn5X0
         ZhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337769; x=1736942569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Fu/J7aLcA/6JcanW9gRS4vVtHfaRVS9VuYzk8LT6DQ=;
        b=Xz2CNOV2YtpBOPTcxp7gDtXDSE5Ep7Ur69CAx36Co/ENcWUJZpEMlE85ZXgSZiuJEW
         0N3LbDsp7u0W7BLWe5grBhMwIh6TdFukuZ0QBApGsMt1rDZMvUygiK0yXbfaAfLxXCrI
         kGInelizRu1Bu3LMJGJjWDm3Lc5uXTR13hWMb5y8GZYKPXH19MJ2eivuwOos/NUlXo6u
         EY0Q/NBdbXNsbLLetAZOs3sP9xnkj4lmkkNOykJoOneWA6Udo+odaCJrwXTNcHK97EtZ
         X3K5z++9EpFnFnr8F4/pBiOi4a9QIT6goz8uQSXwe8a0dJnoFY5/k2HCvy0o7OMXLYFa
         xkmg==
X-Forwarded-Encrypted: i=1; AJvYcCWPCBCyP4yakLYfCCnr8ww/YmZY2s2IHCWogksmtWtH62pHeWwqAyWxinNevMtlXCNu8ijFPiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSc4sIv5jTz5LCcJqy9CE7PB4IWVIRAsn9cUZGhy4RoMgR7ZIS
	oeKc/AVhzLb8HhGQqOVXrESYmBthTbdEXlthPoQECsiyOqcla5cvi71gAQ8YLwY=
X-Gm-Gg: ASbGncuhOb5o+Qk0MMmk6Yz7uh9OXdaFaRhkQRj1k7BfXzi4dNCJ9DUbSnLhfcWI4//
	inFa9V8IhLVAwpPnr/TpbHOwPA8o78afLeq9GoDvSnTOypcVVtoyHaPcQXuiTGB4TW0uSKD5WyV
	Jb7K06ojyS291IZxPEVwW5WXh3p661MwSdkCeDUwW6X5o6F2yjOMo61hQCUp+d+BLW3ZOAL04Kw
	uCsftk60HrWR8oyWdHUqMiXrBS9lmxlyXhDophmJAbgly3E1MNn9hD+jqPF7S4sCvFDYh0=
X-Google-Smtp-Source: AGHT+IHxvLCzAIC3B4tsUuo5mheGbuKfSphHrdU5pFDT/pfFnaWpUoIrvtESSJfsRkrVx8FBwhrfkQ==
X-Received: by 2002:a05:6402:2687:b0:5d3:ba42:e9f8 with SMTP id 4fb4d7f45d1cf-5d972e47d23mr814405a12.7.1736337768837;
        Wed, 08 Jan 2025 04:02:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675ab3bsm25281427a12.5.2025.01.08.04.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:02:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Elder <elder@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dt-bindings: net: qcom,ipa: Use recommended MBN firmware format in DTS example
Date: Wed,  8 Jan 2025 13:02:42 +0100
Message-ID: <20250108120242.156201-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All Qualcomm firmwares uploaded to linux-firmware are in MBN format,
instead of split MDT.  No functional changes, just correct the DTS
example so people will not rely on unaccepted files.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 53cae71d9957..1a46d80a66e8 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -239,7 +239,7 @@ examples:
 
                 qcom,gsi-loader = "self";
                 memory-region = <&ipa_fw_mem>;
-                firmware-name = "qcom/sc7180-trogdor/modem/modem.mdt";
+                firmware-name = "qcom/sc7180-trogdor/modem/modem.mbn";
 
                 iommus = <&apps_smmu 0x440 0x0>,
                          <&apps_smmu 0x442 0x0>;
-- 
2.43.0


