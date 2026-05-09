Return-Path: <netdev+bounces-286208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O8kK62G/2nn7QAAu9opvQ
	(envelope-from <netdev+bounces-286208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 21:10:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E8C501295
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 21:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A7EC301ABBA
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505053C9EEE;
	Sat,  9 May 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="JIyIYh3D"
X-Original-To: netdev@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5914A3E;
	Sat,  9 May 2026 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778353799; cv=none; b=tkXfYepuO7/aiVfe5WsqJzwFaaJp6KJ27go/Kj4Tcn306OrVUIl+ATBwAiwlemQC22OaVeOr9uMj6BEEPUPHYSCrX3SyhAkfDuNPrCB82Orl5gl9vExMRsl3N8MXg/uv2z6WV48zmkWwGWuoICjZFPOEqKlOye9N9DtQfBrcPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778353799; c=relaxed/simple;
	bh=JHZnWGqI6eiIxQuCB5+UHtBR+e2s1h2INqrc+YWSsH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cIBdTNkNJF8lhzgkzsuI1Q7VQMofsFljtbW+m3ZD1oFPdJx0gWT2OAJh3FVSr4tfGkbF4T7+qxMcm0csomqTMjSBB645czmFZn2Q+8VtIfKFrL/XeePekfoH/y/jVXZ4HIX+w2YjpWH8z1aAPsPyMZtDAmDulmHASAbzTz6y2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=JIyIYh3D; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id AEA365FC5A;
	Sat,  9 May 2026 19:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1778353786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EKnlnckxkADslXtJokLa5AGNX78GYEKcN/BuvSjY7yo=;
	b=JIyIYh3D0cLYIYGhraKVBwFzRh30NYLao4sogDADXfU7YlttF96e8Omu2P7gRpxhDksry2
	2GevANviVXcmwOO/KBtufa7gO9ogC8xErua3A2IaH6xZ5thuk48eZKxFK7AktD9h96gH6e
	XHmy2V00CQMKy1sJxnyj05aN1GzYUOE=
Received: from frank-u24.. (fttx-pool-217.61.152.172.bambit.de [217.61.152.172])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 707611226E6;
	Sat,  9 May 2026 19:09:46 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Mason Chang <mason-cw.chang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: [net-next v8 0/3] Add RSS and LRO support
Date: Sat,  9 May 2026 21:09:29 +0200
Message-ID: <20260509190938.169290-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16E8C501295
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailerdienst.de:s=routing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286208-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[public-files.de,vger.kernel.org,lists.infradead.org,mediatek.com,makrotopia.org];
	DMARC_NA(0.00)[fw-web.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@fw-web.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailerdienst.de:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.986];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailerdienst.de:dkim,fw-web.de:mid,mediatek.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,public-files.de:email]
X-Rspamd-Action: no action

From: Frank Wunderlich <frank-w@public-files.de>

This series add RSS and LRO hardware acceleration for terminating
traffic on MT798x.

patches are upported from mtk SDK:
- https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/999-eth-08-mtk_eth_soc-add-register-definitions-for-rss-lro-reg.patch
- https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/999-eth-09-mtk_eth_soc-add-rss-support.patch
- https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/999-eth-10-mtk_eth_soc-add-hw-lro-support.patch
with additional fixes

changes:
  v8:
  - fix more sparse errors, should be all touched lines now

  v7:
  - fix u32 vs. be32 reported by patchwork check
  - add L4 PSH check
    https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/7521c42b0bd5be20d52e20b110daea8c756fc069%5E%21/#F1
  - Add HW LRO max 4-depth VLAN support including switch special tag.
    https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/35490cec6a2e5982532935fb0a1c884f7c4efdb0%5E%21/#F2

  v6:
    - no RFC
    - rebase on netnext (7.1-rc1)
    - drop unused MTK_CTRL_DW0_SDL_MASK
    - e33bd8dd7f1f ("net: mediatek: convert to use .get_rx_ring_count") moved
      ETHTOOL_GRXRINGS handling from mtk_get_rxnfc to mtk_get_rx_ring_count
      move changes to this new function too
    - fix some Macro argument '...' may be better as '(...)' to avoid precedence issues
  v5:
    - fix too long lines after macro changes reported by checkpatch
  v4:
    - drop unrelated file
    - rss-changes suggested by andrew
    - fix MTK_HW_LRO_RING_NUM macro (add eth)
    - fix MTK_LRO_CTRL_DW[123]_CFG (add reg_map param)
    - fix MTK_RX_DONE_INT (add eth param)
    - fix lro reverse christmas tree and LRO params suggested by andrew
    - drop mtk_hwlro_stats_ebl and unused IS_HW_LRO_RING (only used in
      properitary debugfs)
  v3:
    - readded the change dropped in v2 because it was a fix
      for getting RSS working on mt7986
    - changes requested by jakub
    - reworked coverletter (dropped instructions for configuration)
    - name all PDMA-IRQ the same way
    - retested on
      - BPI-R3/mt7986 (RSS needs to be enabled)
      - BPI-R4/mt7988
      - BPI-R64/mt7622 and BPI-R2/mt7623 for not breaking network functionality

  v2:
    - drop wrong change (MTK_CDMP_IG_CTRL is only netsys v1)
    - Fix immutable string IRQ setup (thx to Emilia Schotte)
    - drop links to 6.6 patches/commits in sdk in comments

Mason Chang (3):
  net: ethernet: mtk_eth_soc: Add register definitions for RSS and LRO
  net: ethernet: mtk_eth_soc: Add RSS support
  net: ethernet: mtk_eth_soc: Add LRO support

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 828 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 177 +++--
 2 files changed, 792 insertions(+), 213 deletions(-)

-- 
2.43.0


