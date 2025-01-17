Return-Path: <netdev+bounces-159415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F003A1572D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A201621D3
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BE01E0B80;
	Fri, 17 Jan 2025 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1dSRLEL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327011E0B7C
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139049; cv=none; b=NmxtPzlm8JgknX4Iv5dc5p1NA24fVGDT+h4Awv+mUHLjVmlDGpD6VghB2Kshbhmdkl1riPBifTSV3n9aRU4dyM/yXQvJIE1RuphKvFyNoTQmkofzTA4A39/oYlxV+umhrCubXP0/26tu7puJYVGZF8zpz2tkBZh9ilvCR1qfqeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139049; c=relaxed/simple;
	bh=l+nz8xkxsiWSzzT8l7gVtxCih4qgZhIsv1z4ibKvQik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XKrBW0xCnO1K5HZL48hMNVjdViSDYQvC+W1Quepyp2SW59Ss56dyMR1deSJZNtS/atGKfuxhgMIa8qLXap2Vv6Pxpmqk0akGIG6VMgrwGX+F1kj5tmFAdZPEuJZ+Ze/Yoj/tJpdQ9jn2uKghl/AJ34ltpJ54ZFBKIKGHiGWBHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1dSRLEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C2CC4CEE0;
	Fri, 17 Jan 2025 18:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139048;
	bh=l+nz8xkxsiWSzzT8l7gVtxCih4qgZhIsv1z4ibKvQik=;
	h=From:To:Cc:Subject:Date:From;
	b=X1dSRLELjFGeoyBUPVs2JmchVPcDVyVo4fqIA74X7BJyGMRqGg6aYlUvSoUCtW2xi
	 DAPu80yvfdcYujqRCvu8y4Ixih1FLpKQHXh/es4RCDL4OJ0/8kjcxvP+fwGvZpx2zX
	 qa3oAxXQ4RtRCdhQJ0uxIcoOqL0njVtaOQDwihILlF0i0pvNs/jzzkFVZu/7HzHvXN
	 SHgVx1kGux0f2nAQpi+JyCYBl3UKAGCOlPNKAnGxKKergx+eqgQ6rd2d0fpWSyrEAN
	 ZP5Mb8JNksotF70pNGQCZCIBnSF5+oso+4wuwtMK3Y/3yOZIZG9t42ipg/f/dLdblm
	 9TswTpNWvnZjQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next] eth: bnxt: fix string truncation warning in FW version
Date: Fri, 17 Jan 2025 10:37:26 -0800
Message-ID: <20250117183726.1481524-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

W=1 builds with gcc 14.2.1 report:

drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:4193:32: error: ‘%s’ directive output may be truncated writing up to 31 bytes into a region of size 27 [-Werror=format-truncation=]
 4193 |                          "/pkg %s", buf);

It's upset that we let buf be full length but then we use 5
characters for "/pkg ".

The builds is also clear with clang version 19.1.5 now.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 540c140d52dc..65a20931c579 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4184,7 +4184,7 @@ int bnxt_get_pkginfo(struct net_device *dev, char *ver, int size)
 static void bnxt_get_pkgver(struct net_device *dev)
 {
 	struct bnxt *bp = netdev_priv(dev);
-	char buf[FW_VER_STR_LEN];
+	char buf[FW_VER_STR_LEN - 5];
 	int len;
 
 	if (!bnxt_get_pkginfo(dev, buf, sizeof(buf))) {
-- 
2.48.1


