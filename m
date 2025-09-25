Return-Path: <netdev+bounces-226400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12013B9FE4E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859CA562107
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF252D320E;
	Thu, 25 Sep 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWuWl3JO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33109221FC8;
	Thu, 25 Sep 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809188; cv=none; b=LBHQjGJ3+Fhg4AyP+uYBboGPY/vjaJzQqcB/dA9jyLKPwionyHcsypoNftQur5kywAuHZ3vmLYbxQNDYOW8WFr5dfpm+1bMy/D9XRTF0r5U5cMvJusxGXNZ/xJYS3yoAUMz9BeHvNEbw09pXQZw0tp9I4OnJ5PDRHS/KZ5s2JJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809188; c=relaxed/simple;
	bh=JZaRkLJomBSdsRDEvpNByeOgtyybOCR1lGmXJvP8BFY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LUn7+fXnFauH2nfMCclX1xlJlouWWfyT79vgEmPSDL21p89VyDvzYFGDKr0NLi8S4WK69IkmVmWtMq3xxx/+QtedJsVFdk/hingW2NGEW1OrIYCgT9kexZ79zVjb4Juty4RPsTRIYVhqrkxxIV67TwLTDVVXEcyBaaAkEMKK2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWuWl3JO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B97C8C4CEF0;
	Thu, 25 Sep 2025 14:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758809187;
	bh=JZaRkLJomBSdsRDEvpNByeOgtyybOCR1lGmXJvP8BFY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=UWuWl3JO3I1hyQnyCuRFoMUj1Qt8daxDMicwUYK9zZCern+4HLS9pUwbsfmRVCf4n
	 GjCaYCks8GPJgvmd6J/+r9b/xwQ3Pdm5ik8Vj0lWbax/1ffxb/0DbR/AUWu2izkGzK
	 qztRMiBw0wJasoBpeN1Trc3sHxB7dCSa2pKDqGYcV1NwtS9PJuG+sMCtZE40ZmJpoF
	 JQMpAQ5uQSYjT5gAJCjt+HVqn6OTTcGloysWtzlR886x1zl/hbazGZtLFoF/JiYAqr
	 SEjPJ0uJt/HQ8JMHXmWI5+0UBbhWj2aophDg3QgaZTV8zsDmI2kpi9sPzTTB1f6H86
	 baxi76HXACwhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAABCAC5B1;
	Thu, 25 Sep 2025 14:06:27 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Subject: [PATCH net-next v3 0/2] net: stmmac: Drop frames causing HLBS
 error
Date: Thu, 25 Sep 2025 22:06:12 +0800
Message-Id: <20250925-hlbs_2-v3-0-3b39472776c2@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFRM1WgC/12OQQ6CMBBFr0JmbQ0dLFBW3sMY08IgTbCYtmkwh
 LvbdGHU5c+f9/5s4MkZ8tAVGziKxpvFplAdCugnZe/EzJAyYImilJyzadb+hkyMwyDo1FZjiZC
 On45Gs2bRBSwFZmkNcE3NZHxY3CsvRJ77f1nkjLNe10JQK6XQzVnNgZw69ssjOyJ+c+LDYeKww
 brWqNJD8ofb9/0NjG7N9t8AAAA=
X-Change-ID: 20250911-hlbs_2-5fdd5e483f02
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758809186; l=1247;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=JZaRkLJomBSdsRDEvpNByeOgtyybOCR1lGmXJvP8BFY=;
 b=cjIvuKTzoFGnXBwe3ISNMpVhnpZwew0JHYG4Cg3JIILuwsqz/31E73x5REcfTS+HOiIBAxP40
 5LpEvSW8hGRBsW89XRb0Ndgdh0Hd8lnVPVPYxTf5ljE4KsOiQFCMIH5
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

This patchset consists of following patchset to avoid netdev watchdog
reset due to Head-of-Line Blocking due to EST scheduling error.
 1. Drop those frames causing HLBS error
 2. Add HLBS frame drops to taprio stats

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
---
Changes in v3:
- Split commit into 2 and add this cover letter
- Updated the commit messages with expansion for HLBS and DFBS
- Link to v2: https://lore.kernel.org/r/20250915-hlbs_2-v2-1-27266b2afdd9@altera.com

Changes in v2:
- Removed unnecessary parantheses
- Link to v1: https://lore.kernel.org/r/20250911-hlbs_2-v1-1-cb655e8995b7@altera.com

---
Rohan G Thomas (2):
      net: stmmac: est: Drop frames causing HLBS error
      net: stmmac: tc: Add HLBS drop count to taprio stats

 drivers/net/ethernet/stmicro/stmmac/common.h     | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c | 9 ++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c  | 7 +++++--
 4 files changed, 13 insertions(+), 5 deletions(-)
---
base-commit: 12de5f0f6c2d7aad7e60aada650fcfb374c28a5e
change-id: 20250911-hlbs_2-5fdd5e483f02

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



