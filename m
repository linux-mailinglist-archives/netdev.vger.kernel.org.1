Return-Path: <netdev+bounces-252957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFtlNZPRc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:52:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3377A558
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97B8A303C61D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854B2652A4;
	Fri, 23 Jan 2026 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbHzRo+A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A672D0C7B
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197883; cv=none; b=i8FKVF5bHJZzWeje2Jq17IYVO6cCLOev0+P0jaCwvgGXxu1dVMW30rDywIUeZ4zjtbz9o8Hmx26UMMtGH1aHLHf/FSf38K6nAjh/X13q8dp59wpnc1F0VcNvOMfHdWhGlTwPwnoTEmITz2urXjooE27kPFfWW9/0/iCpCdz1lcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197883; c=relaxed/simple;
	bh=3FJVyYwjibioE8z0FaIQLQU4wiVDMFUqETc6LkpUfIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBCK65nmd71ESL/+qiWiHLK/7VHFukqTbhtks9RlcRCaHK3iG99RoHlLkBrDz8iKYYIQOgdt9vUQAyv+gkOUyzaYE+ke/Od/Fpbq+RxOwxTCQHbtqaeTZYYWdnE3+P0Svl1niknR7ha4Q/SeoeM0JJQqZ8oCQbqRVg4jFqY6SWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qbHzRo+A; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so21712275e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769197880; x=1769802680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RoxIu9OjLLVMlN1bgKytG1gii/pxvwu01d+fCwz2YnE=;
        b=qbHzRo+Avo0zgYpMH+LaaSpiUuWcgtz2xcCMEFd2dfzzzf/H/eofhWBntj/zC++N8w
         dNw1bdV9iA7y0Nb/REr8miqc4BIA11QurtQvu+l0JUcHc3WmUVGmX14tap4yw+NKEz8Z
         9j+5vaVXjEcwljSPQ69Jx5HS+sILwKq8ZaONNOGlrELH0A9GrWnIrRrP6SbVv5ZMkp5j
         JA3/gsY1e1fJTJ3JZCu5g6fDifruQqnULmfy+s49FUUsnEQ02TyQk8xfUD3NUvRmIYn4
         JIdE4nJ5SJ+EktOLf89k/LyL3afSNRRzq92kMKsuQFOQDUfuUVbE1/ZqYZlp49sfdAbu
         a+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769197880; x=1769802680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoxIu9OjLLVMlN1bgKytG1gii/pxvwu01d+fCwz2YnE=;
        b=LqWJcnIOCEuIBZ1KMBw7Zdz+2scn0x7O7T+IrIde+S9vIMupNRXr/SXQEqrva+JBUU
         c6slrn0WYFYjfLe1W/U0S5lekTouDF6CJTYuxhin9cV92VampLD/flVSvgstPYabTvyf
         HRuxaI2WfcoN/c3sdA2RBkViLh7hRoMIW/wpQQG5h27vDb4D5/lbfXlcMLisbIBHD2WD
         yI4iSw3sA0F1LNEMR2QVJtLo9iEMYRE4j0tn1HZPl2GmBvseUMiWXJerPHOEwsUynWoE
         PyWrhtgLrw7SkSf2btrMNyuG07CLJEc3IP8Y0b23l/FHvA+TI1GFwCj2qD46OXDeJ1KV
         9Hxg==
X-Forwarded-Encrypted: i=1; AJvYcCUTF34yD3kLGvQ351J9NHyArpMMV1+7QbP0T7AgrdlvsND6ZpP9wK9oSUPuETuCff0Zwv4ES64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+HV8fw4uEpjg5q0+zEOZFtTXdnW8v3fgx0zdaUL41HUL8GarG
	uPlCcwrT4SxhQ0toFw8EqItvc6rjqODggkeOpzeSFZG2CFtXVaEuTWw2wlojEFqsrk4=
X-Gm-Gg: AZuq6aK4xWTBIuRSKH064MVvsimmEHBzZ3PFH7IXGNd6TU8YndLUFG/90enBkc4SIgA
	YIY2rrmH4T6Hh8YmT8+fGW+mbo6Rc4XfAmionfdhmlm7krmCv2tDNfmSpj0rJ5VyxoTArdhIAYO
	fTLsvXoA0NO+Fq5CE7eLyZHz/jUgG1XEAEwyO1fscYyARJOQD+NC2upy2cwj+cfOvZeOZWxMsfe
	xCydQvgQY6hAxlCYmaq2RI2YsZvzdk1+jMhLpRp46n1vIT3uX1QB98byNI0DDkyjholUiJY+Jne
	Zei/7BX8gLsgSat/3/N/m2z5uDeBbwYIsSUhF7FBTSj1YcIIvGrcI0fVtr0rHEMvqNaI9QLb/5W
	fX11szUoSStqXLqSFj9nJlVEqRUb4ZGj360WSgTW/aGIXYhWDo7+gVpNTMkTwaSyx55IMgvIxhw
	p9l/bYvxefJNK1m1Xm
X-Received: by 2002:a05:600c:c10b:b0:477:1bb6:17e5 with SMTP id 5b1f17b1804b1-4804d65ebbcmr49706635e9.30.1769197879697;
        Fri, 23 Jan 2026 11:51:19 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470bfe88sm148591545e9.11.2026.01.23.11.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:51:19 -0800 (PST)
Date: Fri, 23 Jan 2026 22:51:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jan Petrous <jan.petrous@oss.nxp.com>
Cc: s32@nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Li <Frank.li@nxp.com>, linaro-s32@linaro.org,
	imx@lists.linux.dev
Subject: [PATCH v4 2/3] dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
Message-ID: <63369be0ec8a49294462f7ec061a7066b8ce9425.1769195864.git.dan.carpenter@linaro.org>
References: <cover.1769195864.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769195864.git.dan.carpenter@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252957-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3A3377A558
X-Rspamd-Action: no action

The S32 chipsets have a GPR region which has a miscellaneous registers
including the GMAC_0_CTRL_STS register.  Originally, this code accessed
that register in a sort of ad-hoc way, but it's cleaner to use a
syscon interface to access these registers.

We still need to maintain the old method of accessing the GMAC register
but using a syscon will let us access other registers more cleanly.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v4: Fix the formatting issue Rob pointed out
v3: Better documentation about what GMAC_0_CTRL_STS register does.
v2: Add the vendor prefix to the phandle
    Fix the documentation

 .../devicetree/bindings/net/nxp,s32-dwmac.yaml      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
index 2b8b74c5feec..65633b10e49e 100644
--- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
@@ -32,6 +32,18 @@ properties:
       - description: Main GMAC registers
       - description: GMAC PHY mode control register
 
+  nxp,phy-sel:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the GPR syscon node
+          - description: offset of PHY selection register
+    description:
+      This phandle points to the GMAC_0_CTRL_STS register which controls the
+      GMAC_0 configuration options.  The register lets you select the PHY
+      interface and the PHY mode.  It also controls if the FTM_0 or FTM_1
+      FlexTimer Modules connect to GMAC_O.
+
   interrupts:
     maxItems: 1
 
@@ -74,6 +86,7 @@ examples:
         compatible = "nxp,s32g2-dwmac";
         reg = <0x0 0x4033c000 0x0 0x2000>, /* gmac IP */
               <0x0 0x4007c004 0x0 0x4>;    /* GMAC_0_CTRL_STS */
+        nxp,phy-sel = <&gpr 0x4>;
         interrupt-parent = <&gic>;
         interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-names = "macirq";
-- 
2.51.0


