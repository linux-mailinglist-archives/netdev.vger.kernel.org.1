Return-Path: <netdev+bounces-259669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKOwBGIbmGnp/wIAu9opvQ
	(envelope-from <netdev+bounces-259669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:29:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3250B165AA6
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D48C2301072B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC30336ED1;
	Fri, 20 Feb 2026 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GslRCv4C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9233556E
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576103; cv=none; b=gZ4gIoSIeZDLmnmTHmaZrIJcUTyBPpN3mBpTsZgXpz96WwaY89R0mJO1Lpbyk7lskuLbbVUdNYJ1cAhPX38zleyT5fWpAnicacj2jLTClsag18h9rhwb0YWj7iWTQhKEIzlQrj8KMVbqJL+SYE4Y8sFQMuNkDKjSnKFU5r6M9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576103; c=relaxed/simple;
	bh=4GANKwuw4Gmvjt4yzo6mJduIJtLD4oH0IHu2XPGqRsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzlXXy/wqPujWKD+mGd6FJuLMW7JD0A5ArPqB/NfucTElFZW/6U30tfSW0YAfthQyYWFPxP9ELG7dI50UjlcYsaqta3dx2SepagVQ5BUbPURZ+LO+JAq8wl8C1E/RJ2Mv1W3+mEmEM95pi6CbK44UFHJWB1o5Q+/oF/8uG+ewEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GslRCv4C; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-435f177a8f7so1702807f8f.1
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771576100; x=1772180900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mcr+ylFRvbVQSvo6VBml7OoEWOKRfpbvT57xdCCmX1Q=;
        b=GslRCv4CZ8IGt5sclvgYvqLmarB80+s//Jk0Y3cnG7PWV0d2JkFKuLm//TV4J0KXrW
         t0ycaUAh14Uq7i6k8PZBHglsDHaoKyBFdqjhA3VWjOSuSIxcLjHXrYYnmrn+PHmjiZ5U
         EyfcQh5qfTt4ls3duswSPDmoKsEQy7i61LhUCvsGMX2/6Wa/xrTxirVQlY2vVlNCA4NR
         XW+F4MwLA7QAtc484pJs5/zFTArKtBYO75wL8iSYIWaRTADIdvBi/H48fNNHLl80o+ra
         9IBElF8+Rtoe9EYO0NVGvfvHMnqL6shJfBmcbKbBfD9S2INU/wyIewQF9QyPWltkaVPO
         Eq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771576100; x=1772180900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mcr+ylFRvbVQSvo6VBml7OoEWOKRfpbvT57xdCCmX1Q=;
        b=jl0Hn42YiEZYocBtiIvqqIyhVzmYQMa28GZdzvh+LOeFu94idDPFmIqttco+FsXB3p
         Z/08iFvxT+9XhVs6mW6iisO7sJh8oY2ui7OUw/LvortwXyDNCFMrcREKbXa0nYbcpcTO
         dAt+d+NYtHAiq9rddiWjvj86dj0eboNLbGKF5x8ptNtsPJoxW+fWUP5+sL5ETHz0GIne
         xwBSRDn7mF7LTmsCvkBHS06WLSkyTFNvFoCvXj0MkGveq/4KNamkeZUVOScy8XbsYeFC
         K7BWZkYCOIzo2hsmRK/LvKl9lCKfQcWZqjKEQ7WAk6k9Os+m8bLcyIvkgGfOFWWrpBBP
         1Ktg==
X-Gm-Message-State: AOJu0Yx8PXXI596fblM9L3gpelc5nPfd2WzD9ZOpOB8ReG9VQJtxJl59
	ASyuP0xi8fhcpT4tEpuvYzHNFDwwgaXDtglkandjzQM4TClNaDIiXMB6EL1SsdiiVXA=
X-Gm-Gg: AZuq6aJQE75kI2ia03I3zpmV9giuSL7n3LKKeTciAGMFgxWTA/7URkk6ubjjBANcTWQ
	pn0yKE/pCwv7MzX7PVnP0HTApsWbcuRDMNWQG7SXXuxPnJscWtmb6GVZlXmrcKkzfj4zxr/el0V
	Fzewc1oV3/1O5Hq+gM8UBLMbZwRwuKtjw5wOtTZ/e6DskO3Mnj5Q5WCNJy7hpQCyRRfyoD98PjT
	OUsFLL/+80dlpmdVt6V9u7kxMLZyaZttMA+YSVsk0NCdbGesRmNEtZ0IL9v2KRCvkOJXSrydxwG
	P3eYagB8jYxMwTtZ3b2jh+9yW+2CWbl6vEGwFIhamBfLaBY66nnHVAeeNXaRv2brJf19iC+hesm
	iLR4HA0wDKkZG0IKycu5/G+0BcXDR2mViM9y07RKWBFT+9NnRGR+6j6SxTo8BfevjfYw8T/3DUU
	9Fc346hElLIbJESTkaJWtL
X-Received: by 2002:a05:6000:2001:b0:435:96ec:679e with SMTP id ffacd0b85a97d-4379db61cccmr37806593f8f.23.1771576099874;
        Fri, 20 Feb 2026 00:28:19 -0800 (PST)
Received: from [127.0.1.1] ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1bfsm54717688f8f.13.2026.02.20.00.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 00:28:19 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 20 Feb 2026 16:27:09 +0800
Subject: [PATCH 5/5] riscv: dts: sifive: fu740: Use correct PLIC compatible
 string
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-fu740-v1-5-c8af54130c58@sifive.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=4GANKwuw4Gmvjt4yzo6mJduIJtLD4oH0IHu2XPGqRsA=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBpmBr8A5x0AN6WLq/BdWL/ZvvVR001n1rPKS373
 hQAgd5vgOmJAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCaZga/AAKCRDSA/2dB3lA
 vUkOC/0emc5DX/XLv6NvlYCRNIsC14BaTvJqWzTvJMubMPLS86hHgd3FKQ7Uyb58051WiOLwAsz
 cZ5AXNu8PWhFfZ+5aMcENxul9NU7y/aIYoD/m7oTozg+qnQ/Auiuw+sA68uBPKrR+nloV55s2/4
 y4L0wfIX9asSx+Wx1H9rVEWCSt0F7vyAJw2ZPxe63ySqy5Xo94rukEpaYDcUb2eCyNT7bpjyiv4
 BWMESgWKFLD4SERy6CSScQ8HgNkc9cuYdPLH/28EmfXvLqeiZtlAfcCmFbdRQdUQcXCnTiw8IyU
 bHvBM5KnFqNqVI4WlO2dSppzOYM+1fUoyYNHls4yC0x3v7XZpkZUvvniJ+wfD2ySZ9SmdhwOSx9
 nlEe39EPyWVPTjorh6pmsmrTHzcdAhma1I3FuhiD4+WjzpcJYmH5mhmY4jIifqvSgffVzDRpohV
 99j6p2JFWXqHmVfIA9TtlV+Uai6/eMHYdklOUmBQQKzTSc1q0dMYAPOUoVbPxQ7Nurf7A=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259669-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[sifive.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.hsu@sifive.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sifive.com:mid,sifive.com:dkim,sifive.com:email,c000000:email]
X-Rspamd-Queue-Id: 3250B165AA6
X-Rspamd-Action: no action

Update the PLIC compatible string from "sifive,fu540-c000-plic" to
"sifive,fu740-c000-plic" to comply with the SiFive IP versioning
scheme documented in sifive-blocks-ip-versioning.txt.

The versioning scheme requires SoC-specific compatible strings for
proper hardware identification.

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
index 15e11a03582a..a44ccbf4822b 100644
--- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
@@ -182,7 +182,7 @@ soc {
 		plic0: interrupt-controller@c000000 {
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
-			compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
+			compatible = "sifive,fu740-c000-plic", "sifive,plic-1.0.0";
 			reg = <0x0 0xc000000 0x0 0x4000000>;
 			riscv,ndev = <69>;
 			interrupt-controller;

-- 
2.43.0


