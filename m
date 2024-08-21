Return-Path: <netdev+bounces-120664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD995A234
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446ED1F2310B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF91713A243;
	Wed, 21 Aug 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lty7B6Gr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7921C687
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255944; cv=none; b=q0StGeTAg2er6H9+7lnCn9Gcw8QRSeSIB+hrciXQXokDq9z5qlpcpxTQYMqlDpwanyg3q9VS+wduu2aSwF0jt8TOcv81P249RbpV0HvtBEA83R3RgJRozEaY8RGT+yQFlhj0loJ9AUKEijri0hTDL9HLjU6OtffzMPyITmTU56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255944; c=relaxed/simple;
	bh=qWRGfkVtYg2dfkEfl0bPOdac1iAoI/rMGEd8TXUs5Tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gLg8wfT6yWXceD/laCK4BI9sThNVQe68V6fOpT/qY915jjfwnpcipKV/S5mtEZktiaqUl+ER/IvOi4DnJYzL+QTGMyYqTBE+kPoTVYO+YscCDn0bTY4sWwVPOKRLogVLmQKZ2cKHgbMb/hio+FbY8h6yfwqAWbaMdPHUFrxsrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lty7B6Gr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22438C32781;
	Wed, 21 Aug 2024 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724255944;
	bh=qWRGfkVtYg2dfkEfl0bPOdac1iAoI/rMGEd8TXUs5Tc=;
	h=From:Date:Subject:To:Cc:From;
	b=lty7B6GryIq2GzSvkgX4PGuy0iC7tLzZ9tXw5Y1PVv7B/wzz6qQxqwfdnK/4AM3zG
	 Phzm5SgHQxZTJJ+arPEpm80cMH/ktCbOoGLyB4/LrFUIhBhmEKLC+IIvBdOpKVFKZG
	 TxDaW9JgnXdh5wQ+m6qYtS8ncD1fgkcEvT6h/EoLX22cnw1Qnp+2Q9GxobGFBlny8V
	 S9po3otZubonZeV13NtpnBPK1xOAEM+3Jr9aE3eP6pu7lqQ8pbcUtftH0MCx99zx3c
	 Xu2+qqjHiYfBBoNJ7hhy+9wWANX7j7FH4xKY8OTlOTfDnCCFLIivR8oPlOHREOxq2c
	 4ZfZcvKoX/Iug==
From: Simon Horman <horms@kernel.org>
Date: Wed, 21 Aug 2024 16:58:57 +0100
Subject: [PATCH net-next] net: atlantic: Avoid warning about potential
 string truncation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240821-atlantic-str-v1-1-fa2cfe38ca00@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMAOxmYC/x3MMQqAMAxA0atIZgNtdWi9ijiUGjUgUdoggnh3i
 +Mb/n+gUGYqMDQPZLq48CEVtm0gbVFWQp6rwRnXG+8sRt2jKCcsmnEOJqRIofN9BzU5My18/7s
 RhBSFboXpfT/wz/25aAAAAA==
To: Igor Russkikh <irusskikh@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

W=1 builds with GCC 14.2.0 warn that:

.../aq_ethtool.c:278:59: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 6 [-Wformat-truncation=]
  278 |                                 snprintf(tc_string, 8, "TC%d ", tc);
      |                                                           ^~
.../aq_ethtool.c:278:56: note: directive argument in the range [-2147483641, 254]
  278 |                                 snprintf(tc_string, 8, "TC%d ", tc);
      |                                                        ^~~~~~~
.../aq_ethtool.c:278:33: note: ‘snprintf’ output between 5 and 15 bytes into a destination of size 8
  278 |                                 snprintf(tc_string, 8, "TC%d ", tc);
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tc is always in the range 0 - cfg->tcs. And as cfg->tcs is a u8,
the range is 0 - 255. Further, on inspecting the code, it seems
that cfg->tcs will never be more than AQ_CFG_TCS_MAX (8), so
the range is actually 0 - 8.

So, it seems that the condition that GCC flags will not occur.
But, nonetheless, it would be nice if it didn't emit the warning.

It seems that this can be achieved by changing the format specifier
from %d to %u, in which case I believe GCC recognises an upper bound
on the range of tc of 0 - 255. After some experimentation I think
this is due to the combination of the use of %u and the type of
cfg->tcs (u8).

Empirically, updating the type of the tc variable to unsigned int
has the same effect.

As both of these changes seem to make sense in relation to what the code
is actually doing - iterating over unsigned values - do both.

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index 38f22918c699..440ff4616fec 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -266,7 +266,7 @@ static void aq_ethtool_get_strings(struct net_device *ndev,
 		const int rx_stat_cnt = ARRAY_SIZE(aq_ethtool_queue_rx_stat_names);
 		const int tx_stat_cnt = ARRAY_SIZE(aq_ethtool_queue_tx_stat_names);
 		char tc_string[8];
-		int tc;
+		unsigned int tc;
 
 		memset(tc_string, 0, sizeof(tc_string));
 		memcpy(p, aq_ethtool_stat_names,
@@ -275,7 +275,7 @@ static void aq_ethtool_get_strings(struct net_device *ndev,
 
 		for (tc = 0; tc < cfg->tcs; tc++) {
 			if (cfg->is_qos)
-				snprintf(tc_string, 8, "TC%d ", tc);
+				snprintf(tc_string, 8, "TC%u ", tc);
 
 			for (i = 0; i < cfg->vecs; i++) {
 				for (si = 0; si < rx_stat_cnt; si++) {


