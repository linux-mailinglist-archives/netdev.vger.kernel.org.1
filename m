Return-Path: <netdev+bounces-259668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO+tCV8cmGnp/wIAu9opvQ
	(envelope-from <netdev+bounces-259668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:33:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 700B8165B12
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A04A308C2D4
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68AD335BBB;
	Fri, 20 Feb 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U4eTyjwO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B34D3358BE
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576096; cv=none; b=WFDy38TIdK6cTiRb2a/dHPOuWVHmJ9/fUN30EEN7ZSjdoo8T1crTEjUEW2yYaXVBUIJl+mMfMapPjZrWMK/ncI4jp5UVhaaUcJgGp5Gs8QGdHUbQ+Ut/xxd6mWdWhjM8ohpnx2smOO4P/b+hvo0pB6MDpd3+jGtbiXF5sXvmKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576096; c=relaxed/simple;
	bh=A1K63zp8qaSu12/rz2C04BAncHqq+vlSUPdPl98mUA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7uTLxAeXVRHMIKznXzyfwt5zZmu33Lnn5nQUcwpOcJ2D3MIkiDVKrmb8tE4TpD9tQ7YeVaOsSWNIUrSxpBa0xIMzwP6o34OxoSbd1f8wewRb7rfJu/PjOWMCcYl9B37oOuP2ULnvk74btcA4tqcjFDPs7EcgcEO9DSf34tNHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=U4eTyjwO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-436e87589e8so1800724f8f.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771576093; x=1772180893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZV5sUmW06PeMcEouxXRCwFu2jwo5fAowFeT/xqFkYvY=;
        b=U4eTyjwO50qL56+enRA3hMn4fSFzqXwxYWFhepB1Y+P8HPDDpU1e6LTeOetzg5cnhd
         I2uzIEp3xwiHi775xU2fwWQ10xNNLRfFA8PweR9utGPQURRPV/AO6ubBHIBRzZbx9Ma5
         9KzfX1aFwjfLOz+HyEdHUIUQRCVzltzFSuG/ULjaA2PLhnB4UizED9r7rE29cqVFWx+9
         E25wPN3sjpV6XTwDCB+nb0VVlyy66LRrvBRxPwcMcBqxVRsXUKgSEjeYNtp7KNdHEqVC
         eBCY6UVSikfjmoPiLvNVHBc6VTLnYEWF9dd7ACG6KQoX7o4SgEkJxcyRzKSNVLuLuYX8
         viQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771576093; x=1772180893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZV5sUmW06PeMcEouxXRCwFu2jwo5fAowFeT/xqFkYvY=;
        b=FxQQovp2a9mOK0NITxV2/J4JG5zGXSTmLlzFqQVerNdtO/IAsyk77J0RQn+pc0pLwA
         U2HLQpIjPsNPYeB3DG9KrVx7lmFY1dDig1NHUnZNF68DgCpZDsLxWGIpIDIqFUUu7UYO
         Pzk11TusVz/2mLC/K1pL0FMNI7TnI3QpH4K/RfZJzXIW8WZCgjzC5thljzdO5esYGv62
         pe45EeXlLHlohGhRvc4MzN+gmUUdbfPLvVGPY0SY+6yOms4zd6T/lt0cpcnVF1C8A1Yx
         JONnw3tM8oD56wARO+LCpOzWAX6P52iwWjRPMfWUMJsOGwEvHx/v+mJYV3DGE+e62Rfr
         wlMQ==
X-Gm-Message-State: AOJu0Yx3T3Kj1aRi+u102Enow/8SJ7Gr9WvF6wQq5nA+JkR+p3KXxB26
	/fRu963cCQduO3mSjm3kPTeIPIwRlBrjznOVqwENkufqkmhITTvvgeo+MIBAzTxU4Ek=
X-Gm-Gg: AZuq6aLLkmbNTOIPyiRzSQJZIWOCmxytmaKHAAiNTgOqPvds0mu300BKtwsic65kAyF
	5BiAbI8qTkSoYcS4pUjXRnNihfLt4ElR1EH9cxnx9mvazwV9c0ZerV/w8gUpCKKNFUI6lsXq5SK
	fDw0nd6L8nLxcJNeFFW5Yr6wJ9E86+rTIZFVmCj8rWnkLNXjdPZBlgR5IKVMGQithY7n3beLuBW
	jyx36/BFBuF4ubPiY6JlF610sKbbirSGa5D8zgGw80YnKr6iCQ90PRSBEKxidc1ZLLWiYP5DUwd
	vVYbxUeMXbYekRsdKHa3HCjBv4ApxiUq2YlitwmtJvXDLT32TMwb6f0mvyr4maTN16PeLIciktB
	J8x3pqpxUzlhb7BPgHZ0VjZ/QouEKQiKxq1DSdscopEt33uPFkl3uujQNSlzbgqwG5woelGrZ8w
	Osjd/VX0syB6BoGscka+zx
X-Received: by 2002:a5d:5846:0:b0:436:684:b94a with SMTP id ffacd0b85a97d-4396b02fef8mr1388893f8f.4.1771576093346;
        Fri, 20 Feb 2026 00:28:13 -0800 (PST)
Received: from [127.0.1.1] ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1bfsm54717688f8f.13.2026.02.20.00.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 00:28:12 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 20 Feb 2026 16:27:08 +0800
Subject: [PATCH 4/5] riscv: dts: sifive: fu740: Use correct ethernet
 compatible string
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-fu740-v1-4-c8af54130c58@sifive.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=A1K63zp8qaSu12/rz2C04BAncHqq+vlSUPdPl98mUA8=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBpmBr8b2XrUrBxDXHt5A67Hwwa7ka+Ty9EZgdkQ
 7WSQEVEN1eJAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCaZga/AAKCRDSA/2dB3lA
 ve0TDACsrXUlZYiA3LTQB96Ic/SvGiR39+u7jjo1RB8zDPY1fFcdIlM9ICXPe+VMcFkE0MJlwSz
 eSI4zgllduH5jMJBLGiVlFzhCkKG7r8LyrHyB+j+U+MY12Jioy7EGWP7uEdzokTTZBEABG6ft48
 OP7yapHigO+rIauXOp0snpDXnPRS4cA23v5t1/bGBeYWjJtrcpxDEfCIXHn0gcraFlWLAL11Pzh
 TMos7QkH9T1+whYSbQn6Ne8Pa2XfYaDbXynLLQCOptWUYRugy2DyTkYaaoKxFCRqFZUlHh38PJr
 DeXHrbyE3PpDPnS4PY0X+O3HCDFkiCfUyWe7rinj7YwZtte+BzrP1JAAzO5/n/pIsYS4CgPfw81
 3fxEBh0OY6uFUXTwj+FE8Uq1ZYko4KmaI9WBuSIQ00+nn/bijbxhRF3Aj2FIVv1bY/aCr2vDhfG
 UuoKrPQGX6nNz2NXw/tTQP4LXv/sV2yA0xGGYmNbapDjDybxtl9CFyahUAByOTbNPO5x8=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259668-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[sifive.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.hsu@sifive.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_PROHIBIT(0.00)[0.153.246.16:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:mid,sifive.com:dkim,sifive.com:email,0.153.89.208:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 700B8165B12
X-Rspamd-Action: no action

Update the ethernet node compatible string from "sifive,fu540-c000-gem"
to "sifive,fu740-c000-gem" to comply with the SiFive IP versioning
scheme documented in sifive-blocks-ip-versioning.txt.

The versioning scheme requires SoC-specific compatible strings even when
IP blocks are functionally identical.

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
index 6150f3397bff..15e11a03582a 100644
--- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
@@ -273,7 +273,7 @@ spi0: spi@10050000 {
 			status = "disabled";
 		};
 		eth0: ethernet@10090000 {
-			compatible = "sifive,fu540-c000-gem";
+			compatible = "sifive,fu740-c000-gem";
 			interrupt-parent = <&plic0>;
 			interrupts = <55>;
 			reg = <0x0 0x10090000 0x0 0x2000>,

-- 
2.43.0


