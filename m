Return-Path: <netdev+bounces-228742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 090A1BD3861
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AED94F35CD
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955D21D5CEA;
	Mon, 13 Oct 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+2jrUVF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3219E97A
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365801; cv=none; b=iwhStS+FPr49EFlnasFXESS+mwtXYIHfpNKiCFRB4LbTfYD8zLTWHJkjvlp4vQSwcND382ZJFOvcS0xXVKPmhd0kUcAw4W/DlrZA63obkNfIR0wErKS4U8xFfryQQzSfN6bB0x32uBk1GADIHvt3f+e0FBfBeVa6bRwfcDVHPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365801; c=relaxed/simple;
	bh=zI9bFSUeY3dtnEd65ff1VHq7zZSXobEN1YFQJ+AIM20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGtiFnjuIrFPdf29vlGzXfbhequp5+l+/E4WTYi+TjYXz/ftoEiZ2yStskNHIUI021AjD2W/FEPG2oyqR1eNathfvlV/yqgoSsf58K0RAhgg6h9uFPyTRaGEAgfxe5YYFKDv4xVc+4zeh7v/u+aokricBgQQUfmp1AOrOibwu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+2jrUVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B723C4CEE7;
	Mon, 13 Oct 2025 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760365801;
	bh=zI9bFSUeY3dtnEd65ff1VHq7zZSXobEN1YFQJ+AIM20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O+2jrUVF6R6K0l/0SyCj2ZE3aQPZY4WLSRiT8IpegNQqKHrXhhxzyw9kXy2pH9ba2
	 idtZaEfytKl3kI5haLyxvgn2G8SYEs5umbAXQDff8Aihvg9YN/z4iFOTM3U8+f4GSH
	 gA/CHiZa/jV4dYZYdrH6nARaKiwqZkpg4aaeHrFIy2OGfYtAalOZ6p9wONQ1xGQUUc
	 j+QMbQp2C/1XXmPgBSHxJKBqeLVQ1pxUOLsTRVyL+SqAtNwSB+pDtQo/t5QMzFMEns
	 eHOI7VF86MO92sWtEQJE8QFYaWTysiNnuHBbwB5H3Bv22COdHZOMCjVgHS4Ws5Z3ZS
	 ew0kZX5GDrbcQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 13 Oct 2025 16:29:42 +0200
Subject: [PATCH net-next 2/2] net: airoha: Add get_link ethtool callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-airoha-ethtool-improvements-v1-2-fdd1c6fc9be1@kernel.org>
References: <20251013-airoha-ethtool-improvements-v1-0-fdd1c6fc9be1@kernel.org>
In-Reply-To: <20251013-airoha-ethtool-improvements-v1-0-fdd1c6fc9be1@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Set get_link ethtool callback to ethtool_op_get_link routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 2fe1f39558b80926439cc2f765eb5057464dd76e..6effdda64380bf72ce3c5b6b2f551f560f2ee097 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2770,6 +2770,7 @@ static const struct ethtool_ops airoha_ethtool_ops = {
 	.get_drvinfo		= airoha_ethtool_get_drvinfo,
 	.get_eth_mac_stats      = airoha_ethtool_get_mac_stats,
 	.get_rmon_stats		= airoha_ethtool_get_rmon_stats,
+	.get_link		= ethtool_op_get_link,
 };
 
 static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)

-- 
2.51.0


