Return-Path: <netdev+bounces-286666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKKALcvhAWrolwEAu9opvQ
	(envelope-from <netdev+bounces-286666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:03:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5F350F983
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5EF43076D66
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3938E3FBEC3;
	Mon, 11 May 2026 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTVG2x2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AF73FADE9
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507865; cv=none; b=MlI7TjgeknCZF64ebZayqcH9hLHq0EJGrnMuZ2gu3DgsrIoLcybD70mjVyDgeF9klpjCU7jGmdfppK5t9SrQA8nEOuRxJA+nC4xhUcwhxaGOvs4sy+WFXjdLkRTc190lFSR0ixYurUlg7xY03G/aDXKb4dLBfMMfLMtMvRhjjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507865; c=relaxed/simple;
	bh=Xp/TUYJI1eAs/D+9Nq+dELgCqu+Ss/welMktAjHcpbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjgeAq5hM3zPYP28vHfSGdyO9WwPB5CWBQmEHJZhieLgte9iahNt/z64oUDL7H0uztwNbi/OhW9E2Ma1vaBJbvI4EFBfq6WYsXTHcfF2oJo4YyKpBRj3XUGGSyxsuhUI85omR6FFLcDt2oRwZMnzURPU6kRyKqfNccgxmmsd2/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTVG2x2U; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67b6a6bd7b8so8987261a12.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507855; x=1779112655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnjnB0/XPfthXcOXqkhM1htDcff/BGb30MwU7TWoKRg=;
        b=jTVG2x2Uzv7Dt8V8cSlP4y777+8Umg8UZR4qC4X5tWhuFi4FWQFNdi99gObVcIVWYh
         oLpRMdYIKJRz+zUeMBhJnJe+itGJ90THEwF47hQ+KNBpGdZB6q5rFu9bf59ndsOdvCvM
         Pe+W8fTkPch001mxqd1ckVyc+AHxBBIQgZcEF0IqMap+LmMV52rvWEiXhqKR8Xn2SgxS
         SKuwV96wcJpgR+Ocjcc01yCZT91wqWZFCUf7QMF33+IHkiuZWvgV3uA5qGPksBook4i5
         2BuxZcWbQ9hMYGsLBMuuKGCerc0YwGOI6q9KSl4wRVofStDZ6PQBX7nYY3DJtUeE0fdq
         t1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507855; x=1779112655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BnjnB0/XPfthXcOXqkhM1htDcff/BGb30MwU7TWoKRg=;
        b=nkIlPDRTlTlJn9ZXauyTbSr+E8KCDumzhEnaGnS/30RCGNtX03j5u+ZP5xvMsivNuw
         Cu53SD5oAVR9R9P+360ANSWWQ9Ai7gEp26adlV3906/11+b0y6LdDoynDuwT0jcwjJ/O
         yPyIGPWNfrrp9wXu8QgZXjhf/8q1FYolZgvcc5aQfcO95XpQQjIbX70It6sDinuQA00m
         oyKKRgfGGdPyf3zNh2dwgnmGG5EAH+pEWimPzen0v5q74yARhaBNbFpuMrZ37Pef1ZIF
         W8DEPqYh+8DR3sdMyVZdqtj2F0fTeqE6jxS+WsJpJU5AhSj6026LxZbAnCFtSMBJksR9
         tdfg==
X-Gm-Message-State: AOJu0Yyq8luds3qCYSXP6gADOFHlJOMwi5549Zw/eNzZR5FdMXJmV1OC
	FrDQ6wFtHK1nqoLCBq4hPTvT8Se7EdQw2JDfhZkZ/l5Rnd4x/r1H/kV6
X-Gm-Gg: Acq92OEURaYVsWRNsL4TQA70Uwl8hJVJjjMtWXehTuxZjhsLDHtE/jReOQ8W4jNbGBd
	OVFsEULWdrUhhfZ48mp2BXSUe7ynPYx2bTBqKxTFacem5J2ShTnDtsnbYV6sbFBm+QBL9JpOEEV
	nef/SrVL4AJX3WnlEyMDX1T1Tg4oX4i1DqwgI/SZeZFlW09fVCfvtQrycioB6/Li0MAdz4Ml61l
	hqDXqPB2MT9IzvaQ4ZvjzEwv0JY0EiDA1ekGLyCxFmo4FQnynqFst418ewgOFlg0iqldsOclWAF
	lR2rkCEpFbgoxjZix6hS57PLu/7SkYe9FHKab0SGnGOdaIbhs3ax1ehnvPkxw0GoHR1kAhfJcJo
	jGWgVGRaAJnN5kisy0Lix9ASbjQznTnusHsnavrvo4bQD425RqIDKkBtD3NCj47O2il9GhuA2tt
	43miGsyTsyObLE
X-Received: by 2002:a05:6402:b8a:b0:671:9dec:ba3 with SMTP id 4fb4d7f45d1cf-67e0ee9abb2mr5590673a12.13.1778507854968;
        Mon, 11 May 2026 06:57:34 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b3b904sm3685357a12.1.2026.05.11.06.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:57:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Chen <peter.chen@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v1 5/6] dt-bindings: phy: tegra: Document Nvidia Tegra XMM6260 PHY
Date: Mon, 11 May 2026 16:57:00 +0300
Message-ID: <20260511135703.62470-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511135703.62470-1-clamor95@gmail.com>
References: <20260511135703.62470-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D5F350F983
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286666-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,nvidia.com,linuxfoundation.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.965];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Action: no action

Document the XMM6260 PHY used by various devices based on the Nvidia Tegra
SoC, describing its usage

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/phy/nvidia,tegra-xmm6260.yaml    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml b/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml
new file mode 100644
index 000000000000..0346433c9772
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/nvidia,tegra-xmm6260.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvidia Tegra PHY for XMM6260 modem
+
+description:
+  A hardware configuration used in Tegra SoCs to provide proper interaction
+  between the application processor and the modem, as well as control over
+  one of the SoC's USB lines for the modem.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra-xmm6260
+
+  enable-gpios:
+    description: GPIO connected to the EINT1 pin
+    maxItems: 1
+
+  nvidia,usb-bus:
+    description:
+      Contains two phandles; the first is pointing to the Host's USB controller
+      and the second linking to the controller's PHY.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 2
+    maxItems: 2
+
+  phy-supply:
+    description: Supply powering the PHY.
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - nvidia,usb-bus
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    phy {
+        compatible = "nvidia,tegra-xmm6260";
+
+        enable-gpios = <&gpio 165 GPIO_ACTIVE_HIGH>;
+        phy-supply = <&vdd_3v3_vbat>;
+
+        nvidia,usb-bus = <&hsic_usb>, <&phy2>;
+        #phy-cells = <0>;
+    };
-- 
2.51.0


