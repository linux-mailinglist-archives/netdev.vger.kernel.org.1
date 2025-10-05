Return-Path: <netdev+bounces-227893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECB8BB98A0
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 16:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 190A04E2DD2
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 14:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07EF289802;
	Sun,  5 Oct 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtuPAUHZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787342874E0
	for <netdev@vger.kernel.org>; Sun,  5 Oct 2025 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759675992; cv=none; b=d9seJEJdclkphNEGbMq01kctjuewWuCe821QhBkwHggzw5nMspQP62RKdpJKJ2qsGXPJy6/I1WL1rKvIOd8lEyUnK4I17lOXnzF4sob6ip4eVrr0dgmPuCzE/SQIItiyEiUkAuQLpUkgpGguMKbqLlTRPLaf3R5KDmJBr2rbD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759675992; c=relaxed/simple;
	bh=n+5x1+BhZNh9Sjay4G/MP109HsZfr8HIll6s6iC4eEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XYOJRztph8UgR5xzeucmTLdKnpbWOr6mCn0YGlzqSvXjTj+ume3BjDvIgB+hQQsAdDpmbt9x0d/pPZecgnbmDQzpucagy9Kc8G4YrwnKRP0GLU6b6m6Fx5eTdsoINdi4ksHWw2MeLIrxKosnt/8d7j8bXikfj4yEXsbIhjgdZnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtuPAUHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7283C4CEF4;
	Sun,  5 Oct 2025 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759675990;
	bh=n+5x1+BhZNh9Sjay4G/MP109HsZfr8HIll6s6iC4eEM=;
	h=From:Date:Subject:To:Cc:From;
	b=WtuPAUHZAsMq0UjpxaUl2Q9UAnS4Q6Ot5TBWB1SG2mFl53fSoM+PzoZk+Dls5J4Sp
	 yT2x4jVnZNIcav7CleThxajLuMg4HHkirJyptTnnnOSmvZkbw5mW4Nu6NKOsXvRhVx
	 lQb02ENUPJW+MoEv7attr1mstDTGvYtz6vyK1k4MI9hyKptMOHqOjw8JogtEZo7Xqh
	 fA1wC0gZyPz6MAOey2Ywz3Xb2WSBvVpNPNwm1ljLDp84w3vkA50oSwZ7WNeyMMwVmV
	 rf3EpalxykjdmoI+2JJ/IhB8vQ41QZQAhvFikyrKfXs1RkdHXBI3Zz+BjQWr3L4RWV
	 LjpVEpy2Dk+pg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 05 Oct 2025 09:52:09 -0500
Subject: [PATCH net] net: airoha: Fix loopback mode configuration for GDM2
 port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-airoha-loopback-mode-fix-v1-1-d017f78acf76@kernel.org>
X-B4-Tracking: v=1; b=H4sIABiG4mgC/x2M0QqDMAwAf0XyvECqqGy/MvYQa7RhaqQFEUr/f
 WWPd3CXIUlUSfBqMkS5NKkdFdyjAR/4WAV1rgwttb0j6pE1WmDczM6J/Rd3mwUXvbHjpyfqBnK
 jQM3PKFX/1+9PKT9bJfJragAAAA==
X-Change-ID: 20251005-airoha-loopback-mode-fix-3a9c0036017e
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Add missing configuration for loopback mode in airhoha_set_gdm2_loopback
routine.

Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 81ea01a652b9c545c348ad6390af8be873a4997f..abe7a23e3ab7a189a3a28007004572719307de90 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1710,7 +1710,9 @@ static void airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	airoha_fe_wr(eth, REG_GDM_RXCHN_EN(2), 0xffff);
 	airoha_fe_rmw(eth, REG_GDM_LPBK_CFG(2),
 		      LPBK_CHAN_MASK | LPBK_MODE_MASK | LPBK_EN_MASK,
-		      FIELD_PREP(LPBK_CHAN_MASK, chan) | LPBK_EN_MASK);
+		      FIELD_PREP(LPBK_CHAN_MASK, chan) |
+		      FIELD_PREP(LPBK_MODE_MASK, 7) |
+		      LPBK_EN_MASK);
 	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(2),
 		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
 		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |

---
base-commit: 1b54b0756f051c11f5a5d0fbc1581e0b9a18e2bc
change-id: 20251005-airoha-loopback-mode-fix-3a9c0036017e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


