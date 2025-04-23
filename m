Return-Path: <netdev+bounces-185218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F309A9952A
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0CF1885F34
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4E228467A;
	Wed, 23 Apr 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVFLZIh9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03652281505;
	Wed, 23 Apr 2025 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425713; cv=none; b=aQ9x1I95aillalbYJCyIsnrL8mclVCbTi1jdC/FocyI+qi4c4jIycYSMsqBKPPkScxE59NGC1GpevZ/9Pwl2KxQE3z4NmGDGBJgvpZJgNw4J1DjdCokE9zc455AgLvJTt9gVFE1wWGZU2cLK7OgMQjsnL2rEM1Z051exjqP0vMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425713; c=relaxed/simple;
	bh=XqbIyBSbckVdHR66rMzkQIFKQS9/k2Bz5tPgSGbLto4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=icy2pHVSThjFiGklJRuKqrbKWIuA9MoKB9IyhCKQolqnal7cNot2WtqAhlt/BLnR3aWHWYy9FYm0wvmqxn9mQ5Wv459Jv0yTID9z+ft5KzvJaZ4YmwgzVHaCNWAbE7lmJ1C5DaQ9ft6kBFC99dV07ee8iQ2ch3XDVG+E+AryjZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVFLZIh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBB1C4CEE2;
	Wed, 23 Apr 2025 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745425712;
	bh=XqbIyBSbckVdHR66rMzkQIFKQS9/k2Bz5tPgSGbLto4=;
	h=From:To:Cc:Subject:Date:From;
	b=OVFLZIh9mxtzsR2cQPWe4aE1PYvdVqKvFboIdPbYCKIJSerNhFB/wGR8nQVTUou9U
	 EO4s8cqNxW4IFwtPH+RBdc0aES2mjvEgEIjDtGfxHEmtkG/CtsjKnjwFMNxYR4WRvu
	 z80KwfINYJ1p+KBrHKn1s/19q5bQKQF4Ut3oW2Fzk9tQUMI1NyTvD0y+Pi1QLbE4HM
	 A1LfL0d2ABsRK9Llonr6oLrJ3SBKn1I3n0yCGbge9NHaByrU8TF4sIDD4kPHCFlugs
	 U+W6QqT8cMJbNKqIIWxy/DubhchmMBqdZmcghYBG+NX8PhrcnXps9+xAwqPYlXvxZq
	 5x8vfabnXoktA==
From: Arnd Bergmann <arnd@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Taehee Yoo <ap420073@gmail.com>,
	David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bnxt_en: hide CONFIG_DETECT_HUNG_TASK specific code
Date: Wed, 23 Apr 2025 18:28:21 +0200
Message-Id: <20250423162827.2189658-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The CONFIG_DEFAULT_HUNG_TASK_TIMEOUT setting is only available when the
hung task detection is enabled, otherwise the code now produces a build
failure:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:10188:21: error: use of undeclared identifier 'CONFIG_DEFAULT_HUNG_TASK_TIMEOUT'
 10188 |             max_tmo_secs > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT) {

Enclose this warning logic in an #ifdef to ensure this builds.

Fixes: 0fcad44a86bd ("bnxt_en: Change FW message timeout warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm not really happy with my version either, but could not come up
with a better approach. This may need a larger rework.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ad30445b4799..18359fabe087 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10184,11 +10184,13 @@ static int bnxt_hwrm_ver_get(struct bnxt *bp)
 	if (!bp->hwrm_cmd_max_timeout)
 		bp->hwrm_cmd_max_timeout = HWRM_CMD_MAX_TIMEOUT;
 	max_tmo_secs = bp->hwrm_cmd_max_timeout / 1000;
+#ifdef CONFIG_DETECT_HUNG_TASK
 	if (bp->hwrm_cmd_max_timeout > HWRM_CMD_MAX_TIMEOUT ||
 	    max_tmo_secs > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT) {
 		netdev_warn(bp->dev, "Device requests max timeout of %d seconds, may trigger hung task watchdog (kernel default %ds)\n",
 			    max_tmo_secs, CONFIG_DEFAULT_HUNG_TASK_TIMEOUT);
 	}
+#endif
 
 	if (resp->hwrm_intf_maj_8b >= 1) {
 		bp->hwrm_max_req_len = le16_to_cpu(resp->max_req_win_len);
-- 
2.39.5


