Return-Path: <netdev+bounces-234600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 866CDC23C17
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 09:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49B334F3E32
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0442E3387;
	Fri, 31 Oct 2025 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="l0Vt9XNQ"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59186283FD9;
	Fri, 31 Oct 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898523; cv=none; b=HFy1EXoATbrzGnM7aOoQdh55aN8kb7NoNLZ6Rf7Fiagp8NVD2qejpZelffvhAUY6e14N2E+SxKeiMN9Cg5bT79SHe4O9iLca9FWNzottyhCgzQl7BcMbsXzAdw4MUuUSoLQCTWiE0mp0iHMDNQySlrr3WoufeDeEfg4ecTHfhv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898523; c=relaxed/simple;
	bh=TkuW446e07aVvRNoD/2OBW7hiIMfiCZOhDLN5PcO/ww=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZ9Zp8vX0LpniCPe6/9UAqdy2TpU9NeVIYGQVkHjTXa3I+PVx/Y9ojg9rQztIgcgNPWotIYAnmNRI9kFnw02HucuMHMC90FtGAnMeYKa7PAIBy9nP5MRsttwSV/dFihv/Tuxydxcg3gAi+N1tjYBuZ5kz7vEEqNg3QCW+p0yVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=l0Vt9XNQ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7C4D7A06F4;
	Fri, 31 Oct 2025 09:15:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=fNyFuLbHFHMnPQduFVhMqMv+ss2KCFXTeDgcG6D6th0=; b=
	l0Vt9XNQYUiIPK2wKMwxgMw9z/Z91aKTGxWlMQHOddJGGCpwasn1GG9Zz0vjzGDn
	N/7WVP7ckHvAykxlppOV1ISG68ueyldIZMqtovHatCX6/ZrqQiru0Q+GpMX7Y5YY
	e6cv3vP617seQAs2G1Gl0j0LERfVM6omd/kj0Pl3WYu9irB2Y6yHnLVeAlPiNyRb
	A8vhHLDqemMHSTbiOmiI/SqI5LjMjQDwg07p2lXZjYvUCamcuATpYu/fknazebnG
	RHEEuXIqXpe6TaKgeuLT6NuNmJf0jKVXOIPHFYG5Py41nwXXC2qm8WfXMNsWv/F0
	0mGCpc34MStwQ49+2ntArb08CAb/q0xc0aSGvFbWyITcJBJNyEOnjVAORN5zM21V
	PBzcwkZ6Ru48TjHlywu3MGsVyI+svfGQWPglawFx0HCXq824htU1+M59h7DBvCoi
	WK5MgaR/ZAb/XqIHuhysIyVUcY3JpIZNT6B4D0zqPqL6ihexkijZA7jGDX+4C5Jp
	IASkZ4SEqmDGP62RLZjXF6j5NnPyVQ/0zBA82/o5hPEO+u+nJdnar9HVClyoWOyO
	EpET8Fg8oiCUtg3ta/9zjbLlyfNKGklqyxbfiXNjwqnid9bplaZDbaJkpWzKn+rS
	+D0P9w0nS8pwqoUDSp5GGtpv2dpGAbY8qZOlUqnYg34=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH] dt-bindings: net: ethernet-phy: clarify when compatible must specify PHY ID
Date: Fri, 31 Oct 2025 09:15:06 +0100
Message-ID: <b8613028fb2f7f69e2fa5e658bd2840c790935d4.1761898321.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761898508;VERSION=8001;MC=3880224194;ID=191218;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677D62

Change PHY ID description in ethernet-phy.yaml to clarify that a
PHY ID is required (may -> must) when the PHY requires special
initialization sequence.

Link: https://lore.kernel.org/netdev/20251026212026.GA2959311-robh@kernel.org/
Link: https://lore.kernel.org/netdev/aQIZvDt5gooZSTcp@debianbuilder/

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 2ec2d9fda..6f5599902 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -35,9 +35,10 @@ properties:
         description: PHYs that implement IEEE802.3 clause 45
       - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
         description:
-          If the PHY reports an incorrect ID (or none at all) then the
-          compatible list may contain an entry with the correct PHY ID
-          in the above form.
+          If the PHY reports an incorrect ID (or none at all), or the PHY
+          requires a specific initialization sequence (like a particular
+          order of clocks, resets, power supplies), then the compatible list
+          must contain an entry with the correct PHY ID in the above form.
           The first group of digits is the 16 bit Phy Identifier 1
           register, this is the chip vendor OUI bits 3:18. The
           second group of digits is the Phy Identifier 2 register,
-- 
2.39.5



