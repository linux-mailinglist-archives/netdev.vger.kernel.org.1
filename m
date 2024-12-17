Return-Path: <netdev+bounces-152485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC079F41C4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 05:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F87B188E152
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 04:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3E714A09E;
	Tue, 17 Dec 2024 04:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="2wJmJ29F"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF3013C689
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 04:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734410390; cv=none; b=J9GKjoRnSCc9QX2VW2XlCgxiAmRI01DHjNZdB1zQsxo8ZdyQ1EeOSKS5csaHV37JQrfhGFY4BRaUNL7B+6uqDCPfOM1Ef1qKby/mkqWVHKBQLWJVE0jEtE8sACseib4uOEOnRdgx4kXE7/9DdUNvQN2zDjK3AuJi7wmmiatm9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734410390; c=relaxed/simple;
	bh=ONS2xW78R972FPmIIq4og84deIWQueVXVviERl9RP0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGAq78OpSvSvUWJ5Uuwx0IY+ANmDgUKthzX4bggyT+jjOBXdoqA1ls3ioeQjSwLphmoDxfgO55Thab5ou3Zr49DRBmf6k4yL/5L2Qs3voZebA8qpYK41gPPF0uCzJy5ePUGG4GRhqrUYZQbaJl2uw6Bpde0hLxlfNsFAdTNm0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=2wJmJ29F; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0E5972C097F;
	Tue, 17 Dec 2024 17:39:44 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1734410384;
	bh=L2N0j7JelgbHVJvdCA6XmDaiPSFotRbeW9oF1FbdIFI=;
	h=From:To:Cc:Subject:Date:From;
	b=2wJmJ29FntYydrsGJLKJ6esH0msg/AUsBNRliWxBqfBG+QCWOmkp7qezYi3GSvE/N
	 c6BTUYvV2fuMp4sT8tkUzfpyO28NBOyOS96ETdFEnOPvH7SkieH3u+WAp0gMj6YO1O
	 1nki5KVoe+6SD7PYMIG19c4dJgP30MfMkHc0i1DlJpdfKPXU4EDHB562O0b0IsP0iF
	 oY7ZPakaklO83hFQoK1wmznL8xP2mh2GlpGSQ1STpzXQmFpP2Zj9Z0jd3tvwl+fm9V
	 jHQN0vpRrP4aEjbdjDpmwNJb/Mjikb79Go0wgBc3gJNRV1cwQFapMSCcqSAslH6uaZ
	 UgMwZZ+vPT3+Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6761008f0000>; Tue, 17 Dec 2024 17:39:43 +1300
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id 7898113ED95;
	Tue, 17 Dec 2024 17:39:43 +1300 (NZDT)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id 73B163C0174; Tue, 17 Dec 2024 17:39:43 +1300 (NZDT)
From: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Hans J. Schultz" <netdev@kapio-technology.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Subject: [PATCH net] net: dsa: mv88e6xxx: Fix switchdev error code
Date: Tue, 17 Dec 2024 17:39:30 +1300
Message-ID: <20241217043930.260536-1-elliot.ayrey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=6761008f a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=RZcAm9yDv7YA:10 a=8i6-b8GgAAAA:8 a=N--7mn-ydMt7gBr8E2oA:9 a=3ZKOabzyN94A:10 a=XAGLwFu5sp1jj7jejlXE:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Calling a switchdev notifier encodes additional information into the
return code. Using this value directly makes error messages confusing.

Use notifer_to_errno() to restore the original errno value.

Fixes: 830763b96720 ("net: dsa: mv88e6xxx: mac-auth/MAB implementation")
Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
---
 drivers/net/dsa/mv88e6xxx/switchdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/switchdev.c b/drivers/net/dsa/mv88=
e6xxx/switchdev.c
index 4c346a884fb2..7c59eca0270d 100644
--- a/drivers/net/dsa/mv88e6xxx/switchdev.c
+++ b/drivers/net/dsa/mv88e6xxx/switchdev.c
@@ -79,5 +79,5 @@ int mv88e6xxx_handle_miss_violation(struct mv88e6xxx_ch=
ip *chip, int port,
 				       brport, &info.info, NULL);
 	rtnl_unlock();
=20
-	return err;
+	return notifier_to_errno(err);
 }

