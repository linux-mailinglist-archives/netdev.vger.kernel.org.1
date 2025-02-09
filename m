Return-Path: <netdev+bounces-164519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC57DA2E195
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2371F1886613
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 23:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D431991A9;
	Sun,  9 Feb 2025 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="UrF0Q3j6"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AF190072
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739144884; cv=none; b=rzxe/WKZmHd4BZauv6FuTggNarjJcdmqPc/ci6XwUGSfzyo/A4OkamPXmp/bUkR5fKjawQxQiuxGRy/Jp6/YXQuofGZ1hWvD7QYIbtXIBP96RoKcGKLQc3nclMPeCDhSFRYpjgInSuQKkV7SlxRDjwWcDrAKjM4y0Ee4Mfu5DLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739144884; c=relaxed/simple;
	bh=9ovPTmcz3r5Z+SxqJ+uSZAzBU52u2lOiu6lP7nJBR68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXfMzItCNN6plTIUs0NX5B8AIIBsE5Kh1yrBi2gHTtq0WlnsnwTSORXkREG7ajP5B6r4di3F2OGZ7cXErtRZIYf1163LSDPcxJUl5QbU9B8RilHA8hTWzaxcOgte8cLxGJgN82Sxa4PyNrMFUGODJ6Ju0iRm5QmgHoUus559Mr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=UrF0Q3j6; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9B2E02C03DE;
	Mon, 10 Feb 2025 12:48:01 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1739144881;
	bh=qtQSybJN4jzTBTh2b1fTYdZXFDPv02QDw6AL0pSDuEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UrF0Q3j6kpZoMHOiFQbo+RC8O3UiGBZmuZmdhsjySmYySbtk3XE/yFdPTGN1gq/Z5
	 5xqbxPnnQ1y+ZQlIVvydbTHRsZuWVnEIsuqZmwg4/8cg80H5CHHG9rf+nfaqq3MWzK
	 AB/wYxABivBrHSebzYqrNz6LoaQ2OKISfKacUnvJx6K0vqPbAlqg9Pr81ITGYOacKL
	 0TkN/lO2/wZ7BgZm+3keVLLciV/Ve0FNvr6RPOvqEkuNSzYdQ6cDqrVZaZgAVFBR98
	 bkAYbw6yZ6s587ZycD5V3zESz7mB9Ftn/cw1BYsZkT3UI/9ZFTg4ELDRFLMK3f9slV
	 v/elj2JkuwlsA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67a93eb10000>; Mon, 10 Feb 2025 12:48:01 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 3287413ED4A;
	Mon, 10 Feb 2025 12:48:01 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 21E4F280789; Mon, 10 Feb 2025 12:48:01 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tsbogend@alpha.franken.de
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH net-next 1/5] dt-bindings: net: Move realtek,rtl9301-switch to net
Date: Mon, 10 Feb 2025 12:47:47 +1300
Message-ID: <20250209234751.460404-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209234751.460404-1-chris.packham@alliedtelesis.co.nz>
References: <20250209234751.460404-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=QNvLRRLL c=1 sm=1 tr=0 ts=67a93eb1 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=T2h4t0Lz3GQA:10 a=gEfo2CItAAAA:8 a=58PV4f5cLMXd0nVRbvoA:9 a=3ZKOabzyN94A:10 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Initially realtek,rtl9301-switch was placed under mfd/ because it had
some non-switch related blocks (specifically i2c and reset) but with a
bit more review it has become apparent that this was wrong and the
binding should live under net/.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    It would probably be simplest for this to come in via net-next with a=
n
    ack from Lee.

 .../bindings/{mfd =3D> net}/realtek,rtl9301-switch.yaml           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{mfd =3D> net}/realtek,rtl9301-=
switch.yaml (97%)

diff --git a/Documentation/devicetree/bindings/mfd/realtek,rtl9301-switch=
.yaml b/Documentation/devicetree/bindings/net/realtek,rtl9301-switch.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/mfd/realtek,rtl9301-switch.=
yaml
rename to Documentation/devicetree/bindings/net/realtek,rtl9301-switch.ya=
ml
index f053303ab1e6..d0a93d5f03aa 100644
--- a/Documentation/devicetree/bindings/mfd/realtek,rtl9301-switch.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-switch.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mfd/realtek,rtl9301-switch.yaml#
+$id: http://devicetree.org/schemas/net/realtek,rtl9301-switch.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
 title: Realtek Switch with Internal CPU
--=20
2.48.1


