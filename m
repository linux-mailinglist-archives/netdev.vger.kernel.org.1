Return-Path: <netdev+bounces-199755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4606AE1BB4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B800F170F98
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9F9293B46;
	Fri, 20 Jun 2025 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqkWog/L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408F292936;
	Fri, 20 Jun 2025 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425003; cv=none; b=ac9unfhZwHdKRx10EOc3bgAVuxODf6kfn9f1rt1Yac8Zf2f1QjiRfRxCDLk0//2hI956F1ki74mB666l8NoYc26Ownpxcy66T7KeKeCbb0xcvDtVhzcqsCpDvgqUz5N3fQzvp+5Ej1pOBxPYRAjpFMuIc1z+DkZJlZtDFhnVlp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425003; c=relaxed/simple;
	bh=WbCME8fESr+rlhYeTNtW17nAZ6PIIOdd7ebJuruuPdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lyM7hFJapiC+NwclDxIl0RbBSqfZKk1G7Ziof3aEj98mQHRb1F3x7SS/5K+2NctPrLkR2Srb1xsfIRHZRJhdTqYRfOu3P/cxhtpT5Cx/QgCdTfJkHboTOgTUD0zTnhYX//ti/pqYvw9GJQegZ4rbt7HCTDGJMMCl4JMQXG0NY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqkWog/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90F8C4CEF0;
	Fri, 20 Jun 2025 13:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750425003;
	bh=WbCME8fESr+rlhYeTNtW17nAZ6PIIOdd7ebJuruuPdw=;
	h=From:To:Cc:Subject:Date:From;
	b=sqkWog/LXRIoTG+6CAObPN3i3f1RKdPcOeYJRccWks74n8Vx2zKxhE2JSnT8opqaJ
	 johHEBFLTigRkx/270JkYouoqbEeyqQzOdVsLkRkuvs2WVOwQEceDk+v4guWL4qloq
	 /ZZWOwx0NAd2w2rwJN6IcLH43mtGbsZTMzLuIiHWg5R4FznUoRNLLwuMSWstCTuUFX
	 4E21BBuBBQreYEFq9oXix9fxd4EldtRa6DX7hfMEu5nMRmBpLSuwFMRFCLhvEyhIWZ
	 qkGf+zKIyfU63c9iIOno1EMzPNEQzWYEmLfZ1uY6dYsaR1hDgmBTfBbMjYv+JD+X7c
	 TAcSw3sbPMKBg==
From: Arnd Bergmann <arnd@kernel.org>
To: Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] net: qed: reduce stack usage for TLV processing
Date: Fri, 20 Jun 2025 15:09:53 +0200
Message-Id: <20250620130958.2581128-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang gets a bit confused by the code in the qed_mfw_process_tlv_req and
ends up spilling registers to the stack hundreds of times. When sanitizers
are enabled, this can end up blowing the stack warning limit:

drivers/net/ethernet/qlogic/qed/qed_mng_tlv.c:1244:5: error: stack frame size (1824) exceeds limit (1280) in 'qed_mfw_process_tlv_req' [-Werror,-Wframe-larger-than]

Apparently the problem is the complexity of qed_mfw_update_tlvs()
after inlining, and marking the four main branches of that function
as noinline_for_stack makes this problem completely go away, the stack
usage goes down to 100 bytes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
If anyone feels adventurous and able to figure out what exactly goes
wrong in clang, I can provide preprocessed source files for debugging.
---
 drivers/net/ethernet/qlogic/qed/qed_mng_tlv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mng_tlv.c b/drivers/net/ethernet/qlogic/qed/qed_mng_tlv.c
index f55eed092f25..7d78f072b0a1 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mng_tlv.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mng_tlv.c
@@ -242,7 +242,7 @@ static int qed_mfw_get_tlv_group(u8 tlv_type, u8 *tlv_group)
 }
 
 /* Returns size of the data buffer or, -1 in case TLV data is not available. */
-static int
+static noinline_for_stack int
 qed_mfw_get_gen_tlv_value(struct qed_drv_tlv_hdr *p_tlv,
 			  struct qed_mfw_tlv_generic *p_drv_buf,
 			  struct qed_tlv_parsed_buf *p_buf)
@@ -304,7 +304,7 @@ qed_mfw_get_gen_tlv_value(struct qed_drv_tlv_hdr *p_tlv,
 	return -1;
 }
 
-static int
+static noinline_for_stack int
 qed_mfw_get_eth_tlv_value(struct qed_drv_tlv_hdr *p_tlv,
 			  struct qed_mfw_tlv_eth *p_drv_buf,
 			  struct qed_tlv_parsed_buf *p_buf)
@@ -438,7 +438,7 @@ qed_mfw_get_tlv_time_value(struct qed_mfw_tlv_time *p_time,
 	return QED_MFW_TLV_TIME_SIZE;
 }
 
-static int
+static noinline_for_stack int
 qed_mfw_get_fcoe_tlv_value(struct qed_drv_tlv_hdr *p_tlv,
 			   struct qed_mfw_tlv_fcoe *p_drv_buf,
 			   struct qed_tlv_parsed_buf *p_buf)
@@ -1073,7 +1073,7 @@ qed_mfw_get_fcoe_tlv_value(struct qed_drv_tlv_hdr *p_tlv,
 	return -1;
 }
 
-static int
+static noinline_for_stack int
 qed_mfw_get_iscsi_tlv_value(struct qed_drv_tlv_hdr *p_tlv,
 			    struct qed_mfw_tlv_iscsi *p_drv_buf,
 			    struct qed_tlv_parsed_buf *p_buf)
-- 
2.39.5


