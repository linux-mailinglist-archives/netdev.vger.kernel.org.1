Return-Path: <netdev+bounces-250923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 442C2D39A38
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 23:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E34293007EEF
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 22:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315C2EBBB2;
	Sun, 18 Jan 2026 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnBC5PZL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009D23B63C
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 22:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768774063; cv=none; b=P1NgSo6hq+emUlazb6R2AkMaQJQiSkcBlIqBy7tQwg6cNx9BTwOrkgxTSaKems7dYaTEmnNArVSPzjxhsU10higlIFK7liITRNDkCSorqn1+3Cw9FwSKjsB5H5SNDSnRejMCCG8geE2uZDncMWQd/s0xF4Qm2WboJ2cQhKSzjSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768774063; c=relaxed/simple;
	bh=Zqhf7mxOpodHgtwMA8qOtboqSQQbHGPoc0V+PepX+EQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CaAfBNV0NEyal0L5GE9zi3nhrWP/+aU+Kmd1VCm8YhD2jUhjOA7JCFkbpQjKGZU1NHarDg+eMRm8kDOCfisjQEYToDgEnZBJ4gY6djSXYJdJ7ERwmJEdtzYhgEApFopJARFw3N8OqBS4ge0gpDt6mkphbCuzUrnal7yJMDAShKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnBC5PZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE1AC116D0;
	Sun, 18 Jan 2026 22:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768774062;
	bh=Zqhf7mxOpodHgtwMA8qOtboqSQQbHGPoc0V+PepX+EQ=;
	h=From:Subject:Date:To:Cc:From;
	b=MnBC5PZL3COgNcUT/u6BCczE1qLjR5BKkLLfM4vPkhW8hjlLkzRs//hqrH6H66aXD
	 wJoTXmMfeFdS83qpU10Aueqdaf3eId/vOVHjT9c/jrn6EjfpMsoQDWlhafuL5mzGMp
	 j6AMKFHyGX6mMnFAZcOVyJ1WIzagJmvUcC5ruo74I3JQi6lVF+k6mSRbkkEb9TQ81+
	 PoMLJbGq0ZhgTAzgR+R6r5gL/QymlfC1bMRGY8kb27HuhAF3lGHV7H4TMu+VbYWOPT
	 IB2I2m/e9pXGnLLnJO7OrDwwjsaDhrg4KC3p/g0WgqTFeKuU3WksrmIKvNyEOxqq0V
	 zBeKKVhXhe4sQ==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next 0/4] net: dsa: ks8995: Post-move fixes
Date: Sun, 18 Jan 2026 23:07:30 +0100
Message-Id: <20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G2jrVv2KeBBNNQhVmiqC+HeLx
 2GYeUAoMAl02QOBLhbefQKdZzCto18IeU4MRplaaW1xE9u2FTq+z0PQls5U41S4UjWQmiNQMv+
 vB08RPd0Rhvf9AJp2mARpAAAA
X-Change-ID: 20260118-ks8995-fixups-84f25ac3f407
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

This fixes some glearing issues in the Micrel KS8995 driver
pointed out by Vladimir.

This patch series implements some required functionality
and strips the driver down to just KS8995 deeming the other
"micrel" variants to be actually handled by the Microchip
KSZ driver.

If the KS8995 should actually *also* be managed by the Microchip
driver and this driver deleted remains to be seen. It is clearly
the origin chip for that hardware: it is very close to the
"KSZ8 family" but there are differences.

It definitely has a different custom tag format for proper DSA
tagging, but I have implemented that: I now have to figure out
whether to do that on top of this driver or the KSZ driver before
continuing.

In the meantime, this patch series makes the situation better.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (4):
      net: dsa: ks8995: Add shutdown callback
      net: dsa: ks8955: Delete KSZ8864 and KSZ8795 support
      net: dsa: ks8995: Add stub bridge join/leave
      net: dsa: ks8995: Implement port isolation

 drivers/net/dsa/ks8995.c | 329 ++++++++++++++++++++++++++++-------------------
 1 file changed, 197 insertions(+), 132 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260118-ks8995-fixups-84f25ac3f407

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


