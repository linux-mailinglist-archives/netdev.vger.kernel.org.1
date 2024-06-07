Return-Path: <netdev+bounces-101623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481A88FF9E5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 04:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C89E1C2223B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 02:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20FC171AD;
	Fri,  7 Jun 2024 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="X8wpzBCj"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FCD134B2
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717726143; cv=none; b=RmoMxvZMU/6Y8GT3z2bEolMigvQ0wMxZYftDA/6PSxjdnHoIOMPPmIhNAHlgbNyNoVS3SuGhAkHVzHbbRtxmlaDcvBp6+C2Os3c6t2Vyg+t9anDdzXKyGT1A3GkgLYsNyZ3JbOonZnWy8ttQqrn0Ht6qxAF9IEqxgWMUUeqEYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717726143; c=relaxed/simple;
	bh=owCDEYgpAWc0l0JdKFsdcT9L6Xwepv77DIO9mIUrx4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ow59emnT2TAg/zNYrhKbIV+7pVEzJAot2XQ6f5Vb2GoOUtk3y/4pqeavnUBmdXuLDCo+/6iJBDltgEBIjGnP6ZvvwAtDOrMei1IPosrlKLMrWy1XuRblZHpebb6Zoo/tkwQ3PywXO4/ewZFjQ1WRasVLbM7MwTR6vf3aZah3J4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=X8wpzBCj; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C05D12C00C1;
	Fri,  7 Jun 2024 14:08:50 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1717726130;
	bh=yr7OuagPNfYHTGXTYvStJk5e/5jIJ2plGQ91spVGzuo=;
	h=From:To:Cc:Subject:Date:From;
	b=X8wpzBCjaLo11AYVxkeNV0Um9D2NhY5jxDwwHHK+SBTuQJw+i0WH+pPQB24EyAlsm
	 6k5zehG791UhxBUHMH3gLCg4hbcSPA4sXmC/Dw48N/9tKRr8OmKwQOED8PN8X08VuP
	 adSNMnLSoQWjtqw/mBWG9XeYfs84RU4tU7PHkt7EhQDFdk380EbrHUgZ6lJwpDH6Zf
	 gnk9ACUlClTDCZCskrTq1i10kzWWysNHzZQSkwYyL2SeR1PuN+cujZUphHN1L80jwu
	 d0pSBWrvnqsjEi0Zns3xLPP7ar99pUdAwToj01wTdhlDA++Nike2imQUM5DqMfNuZX
	 pHfa32GvdnrHg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66626bb20000>; Fri, 07 Jun 2024 14:08:50 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 8BFB013ED0C;
	Fri,  7 Jun 2024 14:08:50 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 8653A280B5B; Fri,  7 Jun 2024 14:08:50 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] net: dsa: Fix typo in NET_DSA_TAG_RTL4_A Kconfig
Date: Fri,  7 Jun 2024 14:08:43 +1200
Message-ID: <20240607020843.1380735-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=66626bb2 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=T1WGqf2p2xoA:10 a=c7lDi4tbbdk9oVSNy0EA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Fix a minor typo in the help text for the NET_DSA_TAG_RTL4_A config
option.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 net/dsa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 8e698bea99a3..8d5bf869eb14 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -129,7 +129,7 @@ config NET_DSA_TAG_RTL4_A
 	tristate "Tag driver for Realtek 4 byte protocol A tags"
 	help
 	  Say Y or M if you want to enable support for tagging frames for the
-	  Realtek switches with 4 byte protocol A tags, sich as found in
+	  Realtek switches with 4 byte protocol A tags, such as found in
 	  the Realtek RTL8366RB.
=20
 config NET_DSA_TAG_RTL8_4
--=20
2.45.2


