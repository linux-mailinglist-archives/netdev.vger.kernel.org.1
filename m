Return-Path: <netdev+bounces-189720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEDAAB357C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5E61675FE
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC97C268C62;
	Mon, 12 May 2025 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Dp+OqmMs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDBF257421;
	Mon, 12 May 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047551; cv=none; b=QSkAFx07WfrnXGLO+kL0PM08xG2IKwAfgxPJ4qYYSMaKRGAULN/P0sQxjxEHSachCPbhuUnGPhVCNHkv7V0JOBcEmge4uG/mg0+wHS02G44k0WCeIdi9wsmfLaUU+aRQ4cmKK8QhI5GchSWGuWdehdAtrgsMj70hryTv3Wv5Hhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047551; c=relaxed/simple;
	bh=4/+nYIavSGBPQsFYxBmx94FmpN+jC3OU90H56s+8yZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uEldjWMY6cb999AbynD73mMCN05IkTmAHOiqXQy2f+wczTzEYu3THYbHKpmdD2jcZ7SfQ8ZbkuXICpvp70M+1rL3yZPikv1QXh0y3VMmFAji1AqMF7Nhsafuo8yrvfYBs0/Hwp4NFcT0lDbifydob0Fy7I7qYQnWbajKjzJ7D+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Dp+OqmMs; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 14be5404c;
	Mon, 12 May 2025 18:58:58 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] ixgbe/ipsec: use memzero_explicit() for stack SA structs
Date: Mon, 12 May 2025 10:58:55 +0000
Message-Id: <20250512105855.3748230-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSklOVksdHk5LQhlLSUJMS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk9ITFVKS0tVSk
	JLS1kG
X-HM-Tid: 0a96c425df0403a1kunm14be5404c
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mz46KQw6SDJPP04JMzo5UR4B
	TDEwCxhVSlVKTE9MS09MTkhCT0xDVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFJSkJKNwY+
DKIM-Signature:a=rsa-sha256;
	b=Dp+OqmMs+HCNLUNn7YaKyh51Z9VXNrgFmexOevUqdC4v+I7o+5NW6iXKeOd9E56Jt33nFE7pmGqbE87zz7ToGaJEpHVn1rlMdAO/crSQ63BhNNxA7E3L/pJlzHucjeINp3HykJmT4xzu30FqCFXQdYz00G6wArd+HR5izBIJ43g=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=xgaKnY3N+wlSUsO6sprGPeWrMvmvHTly9bSd0D3f3gk=;
	h=date:mime-version:subject:message-id:from;

The function ixgbe_ipsec_add_sa() currently uses memset() to zero out
stack-allocated SA structs (rsa and tsa) before return, but the gcc-11.4.0
compiler optimizes these calls away. This leaves sensitive key and salt
material on the stack after return.

Replace these memset() calls with memzero_explicit() to prevent the
compiler from optimizing them away. This guarantees that the SA key and
salt are reliably cleared from the stack.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 07ea1954a276..e8c84f7e937b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -678,7 +678,7 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs,
 		} else {
 			/* no match and no empty slot */
 			NL_SET_ERR_MSG_MOD(extack, "No space for SA in Rx IP SA table");
-			memset(&rsa, 0, sizeof(rsa));
+			memzero_explicit(&rsa, sizeof(rsa));
 			return -ENOSPC;
 		}
 
@@ -727,7 +727,7 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs,
 		ret = ixgbe_ipsec_parse_proto_keys(xs, tsa.key, &tsa.salt);
 		if (ret) {
 			NL_SET_ERR_MSG_MOD(extack, "Failed to get key data for Tx SA table");
-			memset(&tsa, 0, sizeof(tsa));
+			memzero_explicit(&tsa, sizeof(tsa));
 			return ret;
 		}
 
-- 
2.34.1


