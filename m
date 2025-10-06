Return-Path: <netdev+bounces-228035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFE8BBF8CD
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 23:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C909234B973
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 21:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD2E1D54FE;
	Mon,  6 Oct 2025 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="ndCA0rAE"
X-Original-To: netdev@vger.kernel.org
Received: from out1.tophost.ch (out1.tophost.ch [46.232.182.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB235972;
	Mon,  6 Oct 2025 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785486; cv=none; b=NSYEmb1eEEA1f2ugj7GeMIrtMTnb91o62mQAGjSKCbBN/TG9QkMxYLDezr3HTplS80+qLEC7xMHV2y1L/++f8Mbj8oMeAhjTb/Y+iks+EhYo8tc5yDUyGxprmQ3bDaAxa4efObY221WPlAFb7QGATXmhwiMj0q8IRP9svbNWQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785486; c=relaxed/simple;
	bh=nPn7FjLRXqfJfGFGDsbikH+R6eT3Ck5i4jCMpioja3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pCOvfhnpC6ryJW6MnER9S4P5YhqqMkVNtaUoQK45ruLkJaKgjv38dowJx4Reltcq0PTyFIGXztIhj1pKx92wSZgRg10pWdkh9vRiojh29IRMbqXwmvwuhhAyVn3UlMWAj2vcMKsXiWHAybxNg1pCPLWE1N9WuXZwjQOWkw5JR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=ndCA0rAE; arc=none smtp.client-ip=46.232.182.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter3.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v5s68-0025dF-Ip; Mon, 06 Oct 2025 22:46:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RumxY3aFj6skdkcuJ1JgCSEv9n428HB982PZhKMEVRY=; b=ndCA0rAETTo+jYEi0e361QV8+8
	M3StH2KetgupcIYEW4E7eM0N3WVKmkgpFHSdTDA+TjGWsX9U66qYXt+el1dL8m+Sk+FO2FoJVYY3q
	rEPXCKx/uswvHXu1JWi5JdUrpmO9urJafMfvP+UJrQFVk3Mbt2w4GWtYcdNnQqUOIXWI1myI8Sh7g
	qTuhsPLDX+IPHLyWtzQbnbsRmxA0cCga9FA1hQAHVsfHxJikU+ubB20HLMnxg/Dh6AIJHPDGXAmVc
	YP3E5valu2zu44vb3HaDY40dtUqia+5PMDgpDKwjpHqLsOPhYQ+6JpsRIWZknHR9EOG280091F7A4
	wzhDodeQ==;
Received: from [213.55.237.208] (port=11651 helo=pavilion.lan)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v5s66-0000000D8Lu-2SR5;
	Mon, 06 Oct 2025 22:46:17 +0200
From: Thomas Wismer <thomas@wismer.xyz>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Wismer <thomas.wismer@scs.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: pse-pd: tps23881: Fix current measurement scaling
Date: Mon,  6 Oct 2025 22:40:29 +0200
Message-ID: <20251006204029.7169-2-thomas@wismer.xyz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: srv125.tophost.ch: authenticated_id: thomas@wismer.xyz
X-Authenticated-Sender: srv125.tophost.ch: thomas@wismer.xyz
X-Spampanel-Domain: smtpout.tophost.ch
X-Spampanel-Username: 194.150.248.5
Authentication-Results: tophost.ch; auth=pass smtp.auth=194.150.248.5@smtpout.tophost.ch
X-Spampanel-Outgoing-Class: unsure
X-Spampanel-Outgoing-Evidence: Combined (0.50)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuV5syPzpWv16mXo6WqDDpKEChjzQ3JIZVFF
 8HV60IETFiu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zPwM
 CX+G0l2LDwwfWqS1/5xwGYjbvhzWX8Co+5c+eruaCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYsG4jVZi5Tfop5qjCZejidXzthz0vNkOX8Em4cj6D/wddIY3ooDH3xmALJ0KCcsszI9W7vD
 6C469DIPe8wH3iOJ3xyMg3et4b3PQUopDmbZCssYHNuxAmlPRpR5yzngsxCROUzReCS8EpKh0It9
 L25JS816nuiE0t5pG6MLXGczoanVmeCF7bI0BP7dENKtPTBPq+vGO3Vx+SwwWschmkdvs376y2A4
 OBi1/UyqO7jQnnICeA+KlS7G8xqewTcs6w6HLg3eq1lKkYVFbZT99AeINpdbOTIWFiLv1jhppNXa
 xS6MN8xFxlxHZge6OlcoYA//qN5p5dmu6xjQN9nmCfj7VmpmZJyx9iy0UVkVD75IgLollI+8fg4q
 Ktu8I/h2Z0dHZM6qE0STp2v0JiRE8jhamJNIkblvt3tmDvgtmN4H4BUM9bndab3XlnlqHqi4QKnn
 k14/ADuPHCWFyNV2T+avjL9wVRCXwYDpBqMLHNY9B2Ak8LmqWByQuE4NgLCNvMovQedDpDK2Sljn
 CNAO7NpcpxuVcnpyy186dygqpmiD9OtONQZ4S919qVAB9i6zlzTjcVXthHorhNpu23mgOZsC6pUL
 aCdNIXkTykmnK/9/QX3JlnOAYOwvgs4sv7ykOBxKEjX2P24wm2Xm0Zxro1P7++DuIQUs/5JJj4C/
 n4CILsmQ0SO9CeLTQh8bH8PiEW8VzQXZLKJLLJ+MXl97QI/szR3pGeJ3+NFYWeVN08G7+dHxL8fL
 MkT6TDHnwvPD+cRl6DbasrEImAe+fJfqFuhNsSc9CgHJcMu7KTfBvyswr4sEMysPur9wmiDBurOy
 6iQJ5124E1ny/UQRZHHLkqd13aH9Eyp21gmT7cyCAVA5VGQFTlUUrbhtdw7TpEqzn1z+TxrIwdSN
 c8JmHiS0PW9yExAHlwca76VdLw2GWIYs+ljrnXdo8M1GW0TnoMpI3UJ+pvlHhV6a5QjptwQBGybQ
 vv1ToHZWNpcnifjzWnmjtnV75K45oykd3VjIUdJS/eyxyfnoc8x6re2H7v/VN3foTPbrWOwDJFM1
 LKpMibQ88o0ORb/rEGGznznyI8PFeRBLZ0Kc+vvfWass5t8K0zA0uhq/IGZ0cCvl49xdmzHJuw==
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

From: Thomas Wismer <thomas.wismer@scs.ch>

The TPS23881 improves on the TPS23880 with current sense resistors reduced
from 255 mOhm to 200 mOhm. This has a direct impact on the scaling of the
current measurement. However, the latest TPS23881 data sheet from May 2023
still shows the scaling of the TPS23880 model.

Fixes: 7f076ce3f1733 ("net: pse-pd: tps23881: Add support for power limit and measurement features")
Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
---
 drivers/net/pse-pd/tps23881.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 63f8f43062bc..b724b222ab44 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -62,7 +62,7 @@
 #define TPS23881_REG_SRAM_DATA	0x61
 
 #define TPS23881_UV_STEP	3662
-#define TPS23881_NA_STEP	70190
+#define TPS23881_NA_STEP	89500
 #define TPS23881_MW_STEP	500
 #define TPS23881_MIN_PI_PW_LIMIT_MW	2000
 
-- 
2.43.0


