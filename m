Return-Path: <netdev+bounces-32168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D747932A9
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 01:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E681C20971
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 23:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4659D101F3;
	Tue,  5 Sep 2023 23:42:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F319FC1E
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 23:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71269C433C7;
	Tue,  5 Sep 2023 23:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693957332;
	bh=OgBZ7RPSURVVGqwAf8IN0IfSOUfH/yG4izWOToAHFpg=;
	h=From:To:Cc:Subject:Date:From;
	b=qI2sM4x13s6ihd0c/HVBfQYK0mgsZkCwpgVtZYfxJLYyekPOESCnEsmlRiHQ2vjxE
	 ZhNh+TCR9O+r8uqJwXh3BqNfWUh9boA72ViCpAMLhkonG5eHS83VlnaohLodxtIpfH
	 Cv8VeoUX1vZSeAvNGgSXPqUfi0hhRwvM9H+xQJRk9fluIbwZIWeooWVfZU8f8ACsx0
	 3iaDCgcaBisLlRKCO6W8tVQGah7ZlTov48VZyaOC6ubIBdBSDaj8Ih4xFqOJ72I1qu
	 n5Up92w1kwKk+d0NJMDxQ/cG85pgrjoBETZgUP7YJd3CFkw/gnttewvfBqU/aRUoau
	 wyUBTyIXyiDHg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux@armlinux.org.uk,
	rmk+kernel@armlinux.org.uk
Subject: [PATCH net] net: phylink: fix sphinx complaint about invalid literal
Date: Tue,  5 Sep 2023 16:42:02 -0700
Message-ID: <20230905234202.1152383-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sphinx complains about the use of "%PHYLINK_PCS_NEG_*":

Documentation/networking/kapi:144: ./include/linux/phylink.h:601: WARNING: Inline literal start-string without end-string.
Documentation/networking/kapi:144: ./include/linux/phylink.h:633: WARNING: Inline literal start-string without end-string.

These are not valid symbols so drop the '%' prefix.

Alternatively we could use %PHYLINK_PCS_NEG_\* (escape the *)
or use normal literal ``PHYLINK_PCS_NEG_*`` but there is already
a handful of un-adorned DEFINE_* in this file.

Fixes: f99d471afa03 ("net: phylink: add PCS negotiation mode")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/all/20230626162908.2f149f98@canb.auug.org.au/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: linux@armlinux.org.uk
CC: rmk+kernel@armlinux.org.uk
---
 include/linux/phylink.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 7d07f8736431..2b886ea654bb 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -600,7 +600,7 @@ void pcs_get_state(struct phylink_pcs *pcs,
  *
  * The %neg_mode argument should be tested via the phylink_mode_*() family of
  * functions, or for PCS that set pcs->neg_mode true, should be tested
- * against the %PHYLINK_PCS_NEG_* definitions.
+ * against the PHYLINK_PCS_NEG_* definitions.
  */
 int pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	       phy_interface_t interface, const unsigned long *advertising,
@@ -630,7 +630,7 @@ void pcs_an_restart(struct phylink_pcs *pcs);
  *
  * The %mode argument should be tested via the phylink_mode_*() family of
  * functions, or for PCS that set pcs->neg_mode true, should be tested
- * against the %PHYLINK_PCS_NEG_* definitions.
+ * against the PHYLINK_PCS_NEG_* definitions.
  */
 void pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		 phy_interface_t interface, int speed, int duplex);
-- 
2.41.0


