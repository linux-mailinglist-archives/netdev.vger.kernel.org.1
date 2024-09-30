Return-Path: <netdev+bounces-130577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159898ADD8
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C391C21D9D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC9C1A0BC7;
	Mon, 30 Sep 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMeak+gm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7519994A
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727226; cv=none; b=bscbDuUqoArZropWoj4ERU1eyikkNFCbhn/b0h/8tc99WjrmzkPS1U2XozBtJKBcw1hDYgDptI3v6/T4bJcZcAdLwyUBMCK43ixI9UYkiWNi1gIknLABlsmVd1qKJ7Bex0YGtZiDWPFLMogctex4QV09pB47YropgyM8E/Z5UD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727226; c=relaxed/simple;
	bh=NLsBTy+bcv4pI2HiJjd7u/CFuPoasgF91UA3EXm64Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evK+g6VdJUx7LmWL66aLtnoD/QVJGUAEZ/4EcoUkOiQrwcY1bXOVT88A9TLJWiLTzuo9Lv5w4iWNDo4l6X/GyaCF8zAsnWuU4uDvpG3GSPUqF14ijJrAMKBAflJ++cud3BCEuX0Z5inToR9r7sddW6b47pjCA1XGhE6dp2/d3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMeak+gm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727727223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqrvHKCp/tNNkz57D8OOtSU9teDeybtDBbPcG0l7M2w=;
	b=RMeak+gm2WIY0oJs5cop060Uyr3qUeC1LAbVjHjH756az5WAW4yiqUPJ6xKwEyss14Ljbf
	st400YOti0zI0ImFul/JSh0I7YzKymZxgSfQ+9BjpR1VWZs7lglwHILA6tYDOhZxYuwKDX
	ey0h3omxfihcFTTCMD4QaYG2TcfihfI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-j6L5Ks4APkSLL_-vB7Matg-1; Mon,
 30 Sep 2024 16:13:40 -0400
X-MC-Unique: j6L5Ks4APkSLL_-vB7Matg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFF4F1953940;
	Mon, 30 Sep 2024 20:13:38 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.45.224.53])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7C4F19560AD;
	Mon, 30 Sep 2024 20:13:35 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Manish Chopra <manishc@marvell.com>,
	netdev@vger.kernel.org
Cc: Caleb Sander <csander@purestorage.com>,
	Alok Prasad <palok@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/4] qed: allow the callee of qed_mcp_nvm_read() to sleep
Date: Mon, 30 Sep 2024 22:13:06 +0200
Message-ID: <20240930201307.330692-4-mschmidt@redhat.com>
In-Reply-To: <20240930201307.330692-1-mschmidt@redhat.com>
References: <20240930201307.330692-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

qed_mcp_nvm_read has a loop where it calls qed_mcp_nvm_rd_cmd with the
argument b_can_sleep=false. And it sleeps once every 0x1000 bytes
read.

Simplify this by letting qed_mcp_nvm_rd_cmd itself sleep
(b_can_sleep=true). It will have slept at least once when successful
(in the "Wait for the MFW response" loop). So the extra sleep once every
0x1000 bytes becomes superfluous. Delete it.

On my test system with voluntary preemption, this lowers the latency
caused by 'ethtool -d' from 53 ms to 10 ms.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index 00f0abc1c2d2..26a714bfad4e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -3079,20 +3079,13 @@ int qed_mcp_nvm_read(struct qed_dev *cdev, u32 addr, u8 *p_buf, u32 len)
 					 DRV_MB_PARAM_NVM_LEN_OFFSET),
 					&resp, &resp_param,
 					&read_len,
-					(u32 *)(p_buf + offset), false);
+					(u32 *)(p_buf + offset), true);
 
 		if (rc || (resp != FW_MSG_CODE_NVM_OK)) {
 			DP_NOTICE(cdev, "MCP command rc = %d\n", rc);
 			break;
 		}
 
-		/* This can be a lengthy process, and it's possible scheduler
-		 * isn't preemptible. Sleep a bit to prevent CPU hogging.
-		 */
-		if (bytes_left % 0x1000 <
-		    (bytes_left - read_len) % 0x1000)
-			usleep_range(1000, 2000);
-
 		offset += read_len;
 		bytes_left -= read_len;
 	}
-- 
2.46.2


