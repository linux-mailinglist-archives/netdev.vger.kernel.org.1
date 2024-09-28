Return-Path: <netdev+bounces-130189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5150988FA9
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 16:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827812817E4
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 14:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53419171C2;
	Sat, 28 Sep 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="QAM6i8Cg"
X-Original-To: netdev@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F06FB9
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727533814; cv=none; b=XpUCeyOYPRkjXYGbcceuoGjBcauLqMyLDqEFzIO0Yt7U9NWZOVj4sm9LjwlpsmRaZPF7gr2eReAfQ1M5uRlB5+KMcZSz7CirZicv9Z/8hgyMBiKkFFjG77aUkKdpVsU5Q4Wy+tLsMA4jJTmpm4Ujg78hcWwKytHfQlbUCxgmZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727533814; c=relaxed/simple;
	bh=ttKcZFr/8sdP9TiuXTUu6pdooXISSDx0ykud/QmX5xk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AMBVnLnTdHQUgNVtbFJpIJWONOhH0OrZ2TrzH2qu+IBqLUIQTLVkZ2f9haWDs3ywPokCpsQ8OJzazhhuz5X9Gw9cjytCvXTI7V5STlQKuamRnNlWGFes1ESoD+/GXdr2ihXQykcoQBdPvcDQkt/x/7seXpq6PcEEjat9qj5oqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=QAM6i8Cg; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 576B71C1696
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 17:30:04 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1727533803; x=
	1728397804; bh=ttKcZFr/8sdP9TiuXTUu6pdooXISSDx0ykud/QmX5xk=; b=Q
	AM6i8Cgy4mgyr2kQ5WUrvaUCyjBUPTHN3MscMv2cx34BDOT7OAbaqRwO3JVvQ3nh
	A5qPRulqG3RvahStxzgyvXBHJh/jBdczkyuK03ZZ8rVnyGFBbZc3sIILcrpIu1d2
	X6jJw2bPl3U4RDhqShmb8sR0Mz3fKDVuBvOhfRj/0g=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l1JK_qbnWCCp for <netdev@vger.kernel.org>;
	Sat, 28 Sep 2024 17:30:03 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
	by mail.nppct.ru (Postfix) with ESMTPSA id 5B66F1C05F7;
	Sat, 28 Sep 2024 17:30:02 +0300 (MSK)
From: Andrey Shumilin <shum.sdl@nppct.ru>
To: Chas Williams <3chas3@gmail.com>
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	khoroshilov@ispras.ru,
	ykarpov@ispras.ru,
	vmerzlyakov@ispras.ru,
	vefanov@ispras.ru
Subject: [PATCH 3/3] horizon: Casting type 32 to 64 bits.
Date: Sat, 28 Sep 2024 17:29:57 +0300
Message-Id: <20240928142957.99143-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In one of the 3 cases, 1<<30 is passed as the second
parameter to the make_rate() function.
In the expressions "c << (CR_MAXPEXP+div-br_exp)"
and "c<<div" a shift of 14 is possible.
The INT type may overflow.
To fix this, it is suggested to cast the type.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
 drivers/atm/horizon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/horizon.c b/drivers/atm/horizon.c
index 4f2951cbe69c..6f3e65e65225 100644
--- a/drivers/atm/horizon.c
+++ b/drivers/atm/horizon.c
@@ -631,7 +631,7 @@ static int make_rate (const hrz_dev * dev, u32 c, rounding r,
 	// d == MIND and (c << (MAXPEXP+MIND)) < B
 	while (div < CR_MAXD) {
 		div++;
-		if (br_man <= (c << (CR_MAXPEXP+div-br_exp))) {
+		if (br_man <= ((u64)c << (CR_MAXPEXP+div-br_exp))) {
 			// Equivalent to: B <= (c << (MAXPEXP+d))
 			// c << (MAXPEXP+d-1) < B <= c << (MAXPEXP+d)
 			// 1 << (MAXPEXP-1) < B/2^d/c <= 1 << MAXPEXP
@@ -645,7 +645,7 @@ static int make_rate (const hrz_dev * dev, u32 c, rounding r,
 					pre = DIV_ROUND_CLOSEST(br, c<<div);
 					break;
 				default: /* round_up */
-					pre = br/(c<<div);
+					pre = br/((u64)c<<div);
 			}
 			PRINTD (DBG_QOS, "B: p=%u, d=%u", pre, div);
 			goto got_it;
-- 
2.30.2


