Return-Path: <netdev+bounces-91887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3F68B453A
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 10:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27908B21EA0
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C97F44C8B;
	Sat, 27 Apr 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ8um0P7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7743F4176B
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714207930; cv=none; b=LHwAYg1g7FDq95vCJKsjfIxOsEBNO4/flyls8PbQFpzqcy/3W9bmOj6bF3Z8dVGl5EoWrK/LK/JmGCpXcjEAa1/CkVxkSzMjh6NbDss5yuFzjFh1Z3CRusubC4TcKP+OxMwHap5x15c6R3TTFyi2MVPrUYk/385lmafre8PJrbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714207930; c=relaxed/simple;
	bh=tYxP2oj4RUJAuMkeDoyuju4veS/sN3CPbMuo2OCXviQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qHMFHMamLSWxMmSaUuvRRj05P8PrE41J84Zx2cKh2jNV3YJf1oRAj4a4U6AddHaVZyhzeyjpjCaLDV8UuNOG4Aho/erPpqaWqoiDuSO0JJPjq2N0Xnbb4WvM+hUmIoZR2Diiv1CoelgcS5f+aEsOfJaw8wEfWxLN6tQMJT5cwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ8um0P7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356A6C113CE;
	Sat, 27 Apr 2024 08:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714207930;
	bh=tYxP2oj4RUJAuMkeDoyuju4veS/sN3CPbMuo2OCXviQ=;
	h=From:Date:Subject:To:Cc:From;
	b=SJ8um0P7AWkeNF4GIrwbSnyPSnwqKL62uMsIbXGcQ+gv7NlOPr86/2NLnnGJSbzQz
	 fplOt9L1JhlQD8IyCqMRNNfuvH3bpjc19OLMB0ofwBlecObgTC/2+NNTlaOqyhEvis
	 5ty7V/nWqEBLYptwaUgH5VdK3ZQKqwRyv4CKf+9NH+uVFPlhbChuQR90FJSzKVaLE4
	 WAjLIjeFb58omRPw6+RMmOxzDtk2PSVht2PpvLaJdX1N28jak/BU3JUIADJb6NcZIs
	 Yfd3l3B54eG+fyEWC7JsdC+m7zN0pMH98OQQqK4zu3j33xp0nFfcrdlpyjlvo3UZhG
	 VQe3/k9AIc/NQ==
From: Simon Horman <horms@kernel.org>
Date: Sat, 27 Apr 2024 09:52:03 +0100
Subject: [PATCH net-next RFC v2] net: dsa: mv88e6xxx: Correct check for
 empty list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240427-mv88e6xx-list_empty-v2-1-b7ce47c77bc7@kernel.org>
X-B4-Tracking: v=1; b=H4sIALK8LGYC/32NQQqDMBREryJ/3V+SmFrtqlDoAbotUmzz1VCNk
 oQQEe/e4AG6fMzMmxUcWU0OLtkKloJ2ejIJxCGDT9+YjlCrxCCYkEzyCsdQllTEiIN2/kXj7Bd
 U55zJvEqddw5pOVtqddytTzDk0VD02eN+gzqlfRpOdtkvA987f+2BI8dCtqpQnJ2qprx+yRoaj
 pPtoN627QeQhDS8xQAAAA==
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Since commit a3c53be55c95 ("net: dsa: mv88e6xxx: Support multiple MDIO
busses") mv88e6xxx_default_mdio_bus() has checked that the
return value of list_first_entry() is non-NULL.

This appears to be intended to guard against the list chip->mdios being
empty.  However, it is not the correct check as the implementation of
list_first_entry is not designed to return NULL for empty lists.

Instead, use list_first_entry() which does return NULL if the list is
empty.

Flagged by Smatch.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- Use list_first_entry_or_null() instead of open-coding
  a condition on list_empty().
  Suggested by Dan Carpenter.
- Update commit message.
- Link to v1: https://lore.kernel.org/r/20240419-mv88e6xx-list_empty-v1-1-64fd6d1059a8@kernel.org
---
As discussed in v1, this is not being considered a fix
as it has been like this for a long time without any
reported problems.
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index f29ef72a2f1d..fc6e2e3ab0f0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -131,8 +131,8 @@ struct mii_bus *mv88e6xxx_default_mdio_bus(struct mv88e6xxx_chip *chip)
 {
 	struct mv88e6xxx_mdio_bus *mdio_bus;
 
-	mdio_bus = list_first_entry(&chip->mdios, struct mv88e6xxx_mdio_bus,
-				    list);
+	mdio_bus = list_first_entry_or_null(&chip->mdios,
+					    struct mv88e6xxx_mdio_bus, list);
 	if (!mdio_bus)
 		return NULL;
 


