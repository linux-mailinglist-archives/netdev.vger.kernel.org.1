Return-Path: <netdev+bounces-198211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D322ADBA5D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767707A3FFC
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 19:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457EF1FAC50;
	Mon, 16 Jun 2025 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frT9NA0L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC141DDC28
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750103730; cv=none; b=fKYl2iMkHasbrAl9r7SX4dD/mnTAGBTPugK1B5sVrrPj2o/KJPYFHLuN4F0DJLArS8TCI5hvDjOYKFr41tXyy8+lVq26Td+exemEQk0JDB/Q/+bfiniQfNF1QfkLCfaKvG4l6XteFkBbKf80za0XHJh5VOFCnj48J8JbvZ175GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750103730; c=relaxed/simple;
	bh=+Wg+woV9xGAfvb417/hijkpcw5BPjg7y+cazlNkarmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUsMEhrEC4gC5EJf6tBDLXTIBov8rx3+Sz8yHDPn+IAYoyIzRp+72P7GuXC2vcm4FJEViLyTJna7Pjd8+JmncwcCfA4g+Wc+foy0rtq0GrhM6RShfump715hW49YMdzVjrKmg9lZD7VFzuXpXTC3p1sLysnsgUi24GNHfu6d2uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frT9NA0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55368C4CEEA;
	Mon, 16 Jun 2025 19:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750103729;
	bh=+Wg+woV9xGAfvb417/hijkpcw5BPjg7y+cazlNkarmE=;
	h=From:To:Cc:Subject:Date:From;
	b=frT9NA0LRjK6Eaor39Gy2nxrc4T+7xUiZP0+JvL2hcq8Kd8hkSpG+jOBiPyQtpyh5
	 A0UFOTNxJ1TR1aGp8qQ/54Pj9xbpbwk2iZ7/sebtNhP1sloHgIS4YuroDaEPp3Agr1
	 OVJj4Mbd/2gGVBRcpPrPfcEOZ36WolPFnFPF8mX3VIi7Leo7drgtjsQ2jUDt1W9ZZs
	 1fQC5xIt3kMixPCWg3ymlQmYsLfFJczGc4ikdDWtev53elzkIy0q861DLhAiqk0Mtf
	 nk4j9dEN53cHqDhFJPUH2VVLdcSHiPWaMn2sFU0Y79j59in5bMXPCT/4h90diiUTO6
	 hTHAbFrnT349g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	lee@trager.us,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: [PATCH net] eth: fbnic: avoid double free when failing to DMA-map FW msg
Date: Mon, 16 Jun 2025 12:55:10 -0700
Message-ID: <20250616195510.225819-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The semantics are that caller of fbnic_mbx_map_msg() retains
the ownership of the message on error. All existing callers
dutifully free the page.

Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index edd4adad954a..72c688b17c5b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -127,11 +127,8 @@ static int fbnic_mbx_map_msg(struct fbnic_dev *fbd, int mbx_idx,
 		return -EBUSY;
 
 	addr = dma_map_single(fbd->dev, msg, PAGE_SIZE, direction);
-	if (dma_mapping_error(fbd->dev, addr)) {
-		free_page((unsigned long)msg);
-
+	if (dma_mapping_error(fbd->dev, addr))
 		return -ENOSPC;
-	}
 
 	mbx->buf_info[tail].msg = msg;
 	mbx->buf_info[tail].addr = addr;
-- 
2.49.0


