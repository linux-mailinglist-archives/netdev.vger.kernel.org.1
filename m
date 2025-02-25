Return-Path: <netdev+bounces-169607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C36CEA44C12
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9DA17CE06
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30F120E6EA;
	Tue, 25 Feb 2025 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUju4poL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83720DD75;
	Tue, 25 Feb 2025 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514170; cv=none; b=j7C8xqoW9YeH1LS16ultitqUtfxfkGrlMV2JMQIjgEFp+nWHeAyuPfOsfbAOryMs2LYzNRpmg885F0WV2KjAfuxkWE7FcvlO7xVk7nli83MuXaTWXcUKFXChlGIZOgNAjy+VUgVL+UIGwnSDgYNgwEOFnfQBvqGuK30ECAtXBmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514170; c=relaxed/simple;
	bh=v8YED1uXtPIzed3xcqm8lNSETlB2B2EtR243as9ZzjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RntwCRBxUfwFSd/msSRoBoP3yEWHOHNd5WyNQlvl8qlV9QvhjmXjwxQvjtStGNJJLUp2dF+K7DHLU58aR+1hgFs9duqIjl1cAaGP+NLRw5VCFvCXyPrE6/Grn8TTf4KQg3/Ds9k96Gvc+Sunn9ulxNIrP+tCKm1vnQhJaTAgsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUju4poL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B82DC4CEE2;
	Tue, 25 Feb 2025 20:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740514170;
	bh=v8YED1uXtPIzed3xcqm8lNSETlB2B2EtR243as9ZzjA=;
	h=From:To:Cc:Subject:Date:From;
	b=cUju4poLsGVFL8f0aPa877dzFlwkKDcXMncn7DPdKhYU0RT2GeuLTu8prmcathKpI
	 j8duCw3/SyV5Mo44NaCrz+Vux4xgMablK2eRS0Htacd/j6bGSxsjNsG1jG1spuCL2F
	 6mqUHX2jpVrtTpmxFelJ9ZgjhHxBVAT+405wx2DhYERz6rb3+nPkY5JZP/aRGPXDjs
	 NakYEUqzmdsmelPsAP1+pB7cG3JyKaoaq/0aESBkp2dxa7zq5en/jREy4FiiRomUqa
	 cZRHZbqteDmMkP88masPKHdlXT5NLOyQWt8IY/7GrfXxaizfGBH9tQk4LG923r82pC
	 a0cG+NmkxVeMw==
From: Arnd Bergmann <arnd@kernel.org>
To: Manish Chopra <manishc@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: qed: make 'qed_ll2_ops_pass' as __maybe_unused
Date: Tue, 25 Feb 2025 21:09:23 +0100
Message-Id: <20250225200926.4057723-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about unused const variables even in header files when
building with W=1:

    In file included from include/linux/qed/qed_rdma_if.h:14,
                     from drivers/net/ethernet/qlogic/qed/qed_rdma.h:16,
                     from drivers/net/ethernet/qlogic/qed/qed_cxt.c:23:
    include/linux/qed/qed_ll2_if.h:270:33: error: 'qed_ll2_ops_pass' defined but not used [-Werror=unused-const-variable=]
      270 | static const struct qed_ll2_ops qed_ll2_ops_pass = {

This one is intentional, so mark it as __maybe_unused to it can be
included from a file that doesn't use this variable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/qed/qed_ll2_if.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/qed/qed_ll2_if.h b/include/linux/qed/qed_ll2_if.h
index 5b67cd03276e..aa29ac53b833 100644
--- a/include/linux/qed/qed_ll2_if.h
+++ b/include/linux/qed/qed_ll2_if.h
@@ -267,7 +267,7 @@ struct qed_ll2_ops {
 int qed_ll2_alloc_if(struct qed_dev *);
 void qed_ll2_dealloc_if(struct qed_dev *);
 #else
-static const struct qed_ll2_ops qed_ll2_ops_pass = {
+static __maybe_unused const struct qed_ll2_ops qed_ll2_ops_pass = {
 	.start = NULL,
 	.stop = NULL,
 	.start_xmit = NULL,
-- 
2.39.5


