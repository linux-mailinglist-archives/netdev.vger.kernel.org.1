Return-Path: <netdev+bounces-277283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKF0Hn6p2Gm3gggAu9opvQ
	(envelope-from <netdev+bounces-277283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:40:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6E43D3746
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90015301D4D2
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DE33A4F5D;
	Fri, 10 Apr 2026 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="lTaVXfNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2B3A0EA5
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806825; cv=none; b=XFqea67zDQ02tlrFvvtdXjlbSmYL58rBxr4JCs7yxm2f1PWjOvfm5OvQJpyTy6K5aQGpYw/xRgI857t8txBFs791rLCusJeT6dko8B0KGPDhYCcYnQjeVTYOH/XPJJ5dAicWFzb1FKjAX2Dfaxzi0aJjEn48uR5XPRow2DR3Ljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806825; c=relaxed/simple;
	bh=y7kF1wWPK+6FLzptGcrgDYcOJoYLZeLuaC+ADv6HIu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ruAzGpvZsR+l8LOqXz7FoFyrxqoHE6WJZ7duVozx3rHz+PxlT27QzGgwyIH7C/z5ZnlQ/nhD2W1oqArLtAjtguHM6nKFdF/bFICAX30e3mD572x1K+Zy0nJjnJLYea5h/44S6QVvxTAG9Frin19wSNevS7dD1tS8wkuoIcO4goo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=lTaVXfNi; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66fb5f2183fso3056788a12.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775806822; x=1776411622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRX6BcXCk5F+FCLA9LCH0VsqPR+RFElb0bC7cHHOd3Q=;
        b=lTaVXfNi43hwgps480WK0yRwWJJa9uKJW8qzbEyMQBm/ZGGyQfMEyvT7sAzCi0ZLPu
         wGyUy/REAvPwnlCCkd7qPIpuBXxerkbbKbxwBW+3GZTSPFfuND5cR0RbeFVSArNLzitu
         /14Dr0RebizlLtrwNVlsn1zjbJG6yyNtave+e6Jo4IzwBgewYDsEvTFclVcRsRiRVD4T
         +3zFByWV+J6sFKE8deMZ9mcUnvoF8aFuG9Jqs61sVNXACFzTdaC3QZjYeudK1p1M903I
         ma0zCE31MeRKzzx24S/FKcWrFlxiSX39IWE6A9vIwrtneO3aFJFF7TxNUgAI0jL9vaKH
         3+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806822; x=1776411622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZRX6BcXCk5F+FCLA9LCH0VsqPR+RFElb0bC7cHHOd3Q=;
        b=NnUPjvqO6MtT8RuJitPv5EFf0QdJxx0lRWuR1OlDO5iSv7ipmIFEumKz5topBewL3Z
         XB+Y+s3GUj8VWklWrLwG/TVDmQuCaB7FSzyo3ifWmN6n1yWkjfJzvl/uKLJwdn3LRHeG
         cttULRnpjuh4pAZExO/9UoS5s+W4glpJq5pzfju+9Ql4iM8ujqb0oRy97kQld08zO/D1
         tMhuulbztOU1DvBI1OHgMBGioYXfkNSF9P1YnAl2HIz42/iM3v/sHGjoFRFbiqwiIWl/
         lgwuyH55Xf27BcETmITX3dZKki40qlgefnIxG9czvkkgrDIJz/UC5xl+Plf1L/Yq+az9
         alSw==
X-Forwarded-Encrypted: i=1; AJvYcCX/JJrvaeW+PQUOzD44Hm8lqR2qAKg1TJ9HM3eRyO8u7hGrVcWZDKYrkTgw9A9KTk1GMne38/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiovOU31NoSjGDdUnM9yZngBOpSFNwfEXuRF8U8Ebzq+1wHrF0
	GO8VBIHg5ly3KIIlUpMZmb1nAlA+sMhbcHZHrPHKmca6ztZWrHfvKuCjpffBmEefdWs=
X-Gm-Gg: AeBDievdARjJmqEbNHcHIyegmogL5NrDuv/PjJsEbNa+mL3tQUTqIxCZ3McAN73idxb
	GPVzT5W6+hj7yC4i4Unrfb5QRS4KdFrTIfLfG5yweajqw4RWXS97MkujqELV5kP6cHyLR0FtwKC
	j7Bzj39asalhPAFyCrCQ3aTvkGLOrgNd+QWA4ZUEP4XCj3Ug1SRjUkfOSz8wJKEsG3i3/0vvjIF
	h+aRudATENZ2pxsMTbrXCeixrXAaTzHdHA21aSzgoO3H94OLnpwi4pKnDCEnMCtiEXf4UYRh2Ki
	qyUj+Lojw8aouHuLaAYV9y5RIbbKdvpA/77BnxbQLuUQ7trdp2GgmmDGgboP9tKzgSfRHXl9aQ/
	R1BGBlLYqsYSBcQ2k+yq18fQYqHLQdvoaSn9rbNpHAcnKMLP4tWT+qRDtYs42vyXj9h//Fr/Hyh
	+wTIImAf1fsQuimWQ8JfUmzyYYTwtjSV0KpK0JnuTFIUYfpGzMRglINenxlSz1tM6+ucZBIPfrb
	JkuJhW2BO18irOA
X-Received: by 2002:a05:6402:2486:b0:66f:9480:c1e6 with SMTP id 4fb4d7f45d1cf-6707b1066d4mr850626a12.26.1775806821580;
        Fri, 10 Apr 2026 00:40:21 -0700 (PDT)
Received: from [172.16.240.100] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67070815a1dsm400310a12.22.2026.04.10.00.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 00:40:21 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 10 Apr 2026 09:40:07 +0200
Subject: [PATCH net-next v2 1/2] dt-bindings: net: qcom,ipa: add Milos
 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-ipa-v5-2-v2-1-778422a05060@fairphone.com>
References: <20260410-ipa-v5-2-v2-0-778422a05060@fairphone.com>
In-Reply-To: <20260410-ipa-v5-2-v2-0-778422a05060@fairphone.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775806819; l=769;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=y7kF1wWPK+6FLzptGcrgDYcOJoYLZeLuaC+ADv6HIu4=;
 b=aZP3u9u4aF/aWtgstnRFKd1QY1+rp53fkEgNZq0mSVHNE8yfSTsbH43s+yGXWMRCEHxhU8h6g
 iVCA+OBQwlRDn2JtYK5XKW3+D1YJw+fF7dxECHyHVhmNzIeL192zbYY
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277283-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:dkim,fairphone.com:email,fairphone.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 0F6E43D3746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the Milos SoC, which uses IPA v5.2.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index e4bb627e1757..fdeaa81b9645 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -44,6 +44,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,milos-ipa
           - qcom,msm8998-ipa
           - qcom,sc7180-ipa
           - qcom,sc7280-ipa

-- 
2.53.0


