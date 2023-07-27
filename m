Return-Path: <netdev+bounces-22044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200C7765BE1
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B341C2167A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EFF1AA9D;
	Thu, 27 Jul 2023 19:07:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4FB198A0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 19:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC840C433CB;
	Thu, 27 Jul 2023 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690484853;
	bh=uuo+iodU9GdYrj9OWYBXKAKESr5q716lMo/Zkxt7KAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FS5Yk4/SyjEfewszsdXsL/L+YLvz8EHgrrSW83RcjXCAS3P5ZfnQZWHo8U3Ni3wOv
	 XAPVkGeBhpNdwZo3ORhpPPcM0ilIwotc1jkW5q5+FYANZuGZ/yRXUnRqKgmBYWfAjt
	 +D0RDB0J2IGcjVNipW5GlqBLa/nYMcCWQ/yyIRNmN/wtdhvqtZfPPNmKIeK6eGrPd3
	 I+NLnEW4WNKqDKv0+Xn/6q4ECVWtjK392OHfZcB9duAIotWYvqC50k46Ga8c1YnYHN
	 QjiXQGU5OirjaGzlR9CbE49i4pnV4xnbml2dA4gSVlRPK5Yrr/1FKOvGyHWNQaGHH1
	 8r0sP73/+Vkmg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] eth: bnxt: fix warning for define in struct_group
Date: Thu, 27 Jul 2023 12:07:26 -0700
Message-ID: <20230727190726.1859515-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727190726.1859515-1-kuba@kernel.org>
References: <20230727190726.1859515-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix C=1 warning with sparse 0.6.4:

drivers/net/ethernet/broadcom/bnxt/bnxt.c: note: in included file:
drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h:30:1: warning: directive in macro's argument list

Don't put defines in a struct_group().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h
index 716742522161..5b2a6f678244 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h
@@ -27,11 +27,12 @@ struct bnxt_cos2bw_cfg {
 		u8		queue_id;
 		__le32		min_bw;
 		__le32		max_bw;
-#define BW_VALUE_UNIT_PERCENT1_100		(0x1UL << 29)
 		u8		tsa;
 		u8		pri_lvl;
 		u8		bw_weight;
 	);
+/* for min_bw / max_bw */
+#define BW_VALUE_UNIT_PERCENT1_100		(0x1UL << 29)
 	u8			unused;
 };
 
-- 
2.41.0


