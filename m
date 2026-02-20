Return-Path: <netdev+bounces-259666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFgdDfYbmGnp/wIAu9opvQ
	(envelope-from <netdev+bounces-259666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:31:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD19165AF2
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB8B43061AD8
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C7A3358BE;
	Fri, 20 Feb 2026 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aUEdXTD+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFB32C939
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576083; cv=none; b=RuRLoxQhLdiq1y+U042pdx8TDAOdk2HzxuIcoYcv1v63jo0zahXfmY5hAS6iCTxYNRjO4YjzD375NIx7D36RF1W5oOKRqYzrjEbZnYb4PnXuwRytC0zTT8u1gQL3ML8HwFzJDXTjQjh96cPcu0QJ3VdmEhQ8XX34J1TSwhz6t9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576083; c=relaxed/simple;
	bh=+TEwwtm2PIIgCWLeUnV15+Q2Dgy5dOcAStHu0XOpeeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dDMX0pLSHadxANWXOZId4DMxIHF0YHlebqq0YF42KelpwjMxr4SD14flpupulZAISs6F4+eeCSanLwUxbYAHVXyTcu35tqH6lmhV4z9ZP5T5uB/09KA0BzGn5HQQ25yg8XFZrFOwkZKKvVl6o+16Ffd0slsZ3G7u/mZ/uEd/AUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=aUEdXTD+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43622089851so1760808f8f.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771576080; x=1772180880; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5eLGfJrbtVWLlMPc5LreUV+HmegSvmbmdOtuZdLViE=;
        b=aUEdXTD+t7z0oNu6iNwoQbHKp68ttGqMd10+WmhrBHwh23j2pVpcQqLPQxxVEPUBDK
         eNSTlEjUq/Mx+mLCHnBBNkWqPIkAUQrblDPWgo/m1hMFE0JNSFKN4hyPck8y1th59jvv
         SVXfUIC182HlkhFqluxi1DV+c5n9OHvxjKcnrOvM2dBVA217hzd/vwDoPdowY94HAmH9
         Xtq7cFdTtsj8d80MWEIYcA6WCPvF0Hl8HrJ/+vqsaYjOGCK1Ot8MPiQbFHBNB+gPekCp
         ojcWPjEiB5Xjhw/p9ERiqJeONLKaEntqQXxo+GkNd6jjfSR7wkyBst/BqvgFCd17dXYC
         Q56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771576080; x=1772180880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C5eLGfJrbtVWLlMPc5LreUV+HmegSvmbmdOtuZdLViE=;
        b=SQozxIhZ3dgkha+yOSZctD5DK4LcGzXSht8Y086QkdH2F4KufMA4poVTaOJFPErr7H
         wpo2wSu7Ue6qkmi1pwVjOHMFoVOlKU36q5WY+Hsimnj5cqZKEs00dB2ZvfUfGa0vkPHg
         3wwJfF63vwhaJYuYm/KKoBDN0vTm/qDfh70iTc/I8WdLY4YDWa6Gf6Yxu9s+wHQD9dqN
         EJvDgMX5MOv9OdeZC6ESxhDNzjtuTt4Kyj87wkuslKRC68FHeI/uDIwF2vduQJ59M2nd
         qOWQ3WR6dVR+ZPLd6fqkHEGtmVtvYMNTidNP0Re7qbhPVunLRy+tbz8kQAfzu6GBe0fG
         6M1w==
X-Gm-Message-State: AOJu0YxHh75TsrHdzCMx3QmYRF+zhJSX1FbndrO454AFaNjtcCvWi3hR
	rMC1XeW3Yjb3hcJ0G+91pDGcO9eAOnTPWsMp+OFn0buzb8S+8epD1ou4SP29SVVb7mc=
X-Gm-Gg: AZuq6aJa56gS3gLGS4RD2M/P7ONBvQiMiNkEe90w4ZTHXvBzLiViC+PGJFHCKtYE/iE
	e5vibq5kqDwccTRYtfOFjnFQ4oAbll4U5hMGnXd0XChglO7VeWPDjVnY9h53e9Rkkxo+HPgXpx9
	Mj5cb83AB1aGaK7fcKd1UORYsG44FDgVYo8o8YsNQgVblWV0dnzIdKWK5S+JlnlXzT0vdyBbuX1
	fd1ukJn73n9Siqt+HM/0ny10bn9qS4IxpXnz8H7No8RY+7MSVmYRRwTEVUiLzPx7UA72nfV3iMm
	5rx6zZW1bkaYqzCPlF+YW6eSkcxqplcZmeoMKl4pDaITWz3jyoyOcE7ci3osrTvRtzerOMmM2l3
	tSLMxpkT4RCBMaP6bFW3X3XzaqHPNDiiGP81Zcgn9UatjgHzw9Tu6vMNLbhZNtJgBVqtTnXCj9V
	bTumtil5v2jMIPWNirPAbJ
X-Received: by 2002:a05:6000:208a:b0:437:4872:fc83 with SMTP id ffacd0b85a97d-43958e40264mr16112584f8f.33.1771576080263;
        Fri, 20 Feb 2026 00:28:00 -0800 (PST)
Received: from [127.0.1.1] ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1bfsm54717688f8f.13.2026.02.20.00.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 00:27:59 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 20 Feb 2026 16:27:06 +0800
Subject: [PATCH 2/5] dt-bindings: interrupt-controller: Add SiFive
 FU740-C000 PLIC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-fu740-v1-2-c8af54130c58@sifive.com>
References: <20260220-fu740-v1-0-c8af54130c58@sifive.com>
In-Reply-To: <20260220-fu740-v1-0-c8af54130c58@sifive.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Thomas Gleixner <tglx@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Conor Dooley <conor@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, Max Hsu <max.hsu@sifive.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=+TEwwtm2PIIgCWLeUnV15+Q2Dgy5dOcAStHu0XOpeeI=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBpmBr8cO7VEZscQY0zwzt3wIUXXTtpZ7n9utbAR
 BIceK0tIVCJAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCaZga/AAKCRDSA/2dB3lA
 vacmDACN3HpL09hYqpED9ADdDNvaGs2XPvXqwYYTw4Q8Gi2omOHC6ANk2+p4FIhtZGNWF1DCAXW
 39uj6PCsaAmKbD0AlImrsZehkQstr8ZxWWGSyF/A8lHHiUo72DALiy0f9Le5/Q7lFP1WHxEKJUD
 ZB/tvXmGE1zaH8Xd9zyDy+Y+TtCzTSjsS7TJIDvWWI5ty1XBDwgu74OIl/Oj4mNYXsuLRMQhs+o
 kIFTfsAkwm3m69y8ehbu/866xrxHAwczikLK7CJKOC+yz8Nuh6TiiFxtkhIJhyglChhwP4Omg/R
 mBRwMMWjgrZzJrja9MRKAKqz7McqQ9klazip2tG+OqdK1A+I9ohjvjSDUYv7WHeuTYLppErpejq
 JgjnKzhh5jHNt0eCX8LimCCjkAMKZU17YdierhFwYY2/WHBZIWTT0U66retiUgH7QJLo0AUwCHu
 1jQYUohMD0CTJtilFGYcx7r/3kBgSXpUhuPyuxLFvU2Mks8SEjk3cI+0d6YRBC6L9eR8w=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259666-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[sifive.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.hsu@sifive.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:mid,sifive.com:dkim,sifive.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBD19165AF2
X-Rspamd-Action: no action

Add the SiFive FU740-C000 PLIC compatible string to the binding
documentation.

This follows the SiFive IP versioning scheme which requires SoC-specific
compatible strings for proper hardware identification, even when the IP
blocks are functionally identical.

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index e0267223887e..351d26ab1956 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -63,6 +63,7 @@ properties:
               - eswin,eic7700-plic
               - microchip,pic64gx-plic
               - sifive,fu540-c000-plic
+              - sifive,fu740-c000-plic
               - spacemit,k1-plic
               - starfive,jh7100-plic
               - starfive,jh7110-plic

-- 
2.43.0


