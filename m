Return-Path: <netdev+bounces-118891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1959536E9
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBE228CD6F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926D419F49B;
	Thu, 15 Aug 2024 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh2CI+ax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58817BEA5
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735170; cv=none; b=QumeUJWfNrYJBynkLcOd9DBBJla4AR0ADMYPNuSJR69vUU3gm3hxdAeQw3WDJtK5+muzkz+Ymhc+OlxRKt4OssZgId7gvUV5355CHElhEd5ZCKgwjkQzU6mx/okR81mGTI15vd4M72lXKQ4UKe+vscLiNbjT9kxZe+Hl+mIjCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735170; c=relaxed/simple;
	bh=4vcLRWMByeWTJ0HDVytdl2s5H6vbp+DVNNDCwduox0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jxqmtzstvbK8HBV5vo23Z0YFwSpgr326THFmNe9QYSHpGFyorJtqJ1EyrirU2ehbuCEM2mvl0+76a6U4ppXQR734RbSKAa2LXkRnGCK0pvE0pugvXg0x5PFanauNmzcGx8nlq5aJQrsBC3uBv8QWsuyTrrSpRbHp0eLY5DXc0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh2CI+ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996A3C32786;
	Thu, 15 Aug 2024 15:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735170;
	bh=4vcLRWMByeWTJ0HDVytdl2s5H6vbp+DVNNDCwduox0A=;
	h=From:Date:Subject:To:Cc:From;
	b=Nh2CI+axz7LGaD7Po3vfksdNEEI/NF2mwqNVew7WI6dkKdO2YPsbQ47M4B+dHmH3x
	 v0JIrwOdUzabCSWxBZY2pBlr8+Da4+ksCHjC8VXMMxONUGBbk/mm0Ug6ZX+66fJmq7
	 wsWQ5a/3gUoe/hPTVj4mYpbOiETp1z+uenySaxBwCAAU+Q3EImqWgicQ8v6XxXj8vb
	 q+x/IFb5fX8+LovI3jr80GpX2cWbqU5HcFneM9cFVjAK3t5WhTDXCc2C0wir7gmVGM
	 xE6VjitdmCTknoexxfK1wuNWE6Czf5mLeVIh0f54XxHGRHMbsGMvpPk4IYtSVBUnte
	 OGwvtMycPLDFw==
From: Simon Horman <horms@kernel.org>
Date: Thu, 15 Aug 2024 16:19:25 +0100
Subject: [PATCH] net: txgbe: Remove unnecessary NULL check before free
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-txgbe-kvfree-v1-1-5ecf8656f555@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHwcvmYC/x3MSwqAIBRG4a3EHSdoD6i2Eg3Ufu0SWGhEIO09a
 fgNzsmUEBmJpipTxM2Jj1Cg6orspoOH4LWYGtl0clC9uB5vIPbbRUBYA6kdMLYKVJIzwvHz7+b
 lfT88EkJUXgAAAA==
To: Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Remove unnecessary NULL check before freeing using kvfree().
This function will ignore a NULL argument.

Flagged by Coccinelle:

  .../txgbe_hw.c:187:2-8: WARNING: NULL check before some freeing functions is not needed.

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
index d6b2b3c781b6..cd1372da92a9 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -103,8 +103,7 @@ static int txgbe_calc_eeprom_checksum(struct wx *wx, u16 *checksum)
 		if (i != wx->eeprom.sw_region_offset + TXGBE_EEPROM_CHECKSUM)
 			*checksum += local_buffer[i];
 
-	if (eeprom_ptrs)
-		kvfree(eeprom_ptrs);
+	kvfree(eeprom_ptrs);
 
 	*checksum = TXGBE_EEPROM_SUM - *checksum;
 


