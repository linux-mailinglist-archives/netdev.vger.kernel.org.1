Return-Path: <netdev+bounces-36157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671637ADC82
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id DB0F01F24E25
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1823B219F0;
	Mon, 25 Sep 2023 15:59:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089261F95E
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 15:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A7AC433C7;
	Mon, 25 Sep 2023 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695657545;
	bh=RrtU4RECwP4yzk+K9XzYnJXLXX3xo09O9R98nMyytTY=;
	h=From:To:Cc:Subject:Date:From;
	b=Adys9/F3M27GS5RkwihTaM+15EOZe0NoXZRfBW44jWh/4iZgMZKGQiwtiLFmEFe4h
	 GrYPKAY8ly1lmpAoolOo8ypEQjWeCAqyTqwAB9Q1M9Rqu4MLN1RBSOKAdth7yokiZm
	 ZkhqrtOyVcR6oMSvDzV8b6tKxve6HsHRYALXckry1DzFgfSacu/ostOrnGliGiGbZh
	 HrNTKf2/FPad5fLLS3VSxkrlG5hbZWNAQplFDuHL5cZr+QFBEpkfMAuK5UNM/LwQJw
	 PGTA8bsbRiEdcoJ1XMIrci4AN7UEs9WLkIjNysN+wl4wqlhvqVs/6HbUcCSmNdXpCo
	 mYnAGuYGoxwkg==
From: Arnd Bergmann <arnd@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alan Brady <alan.brady@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Phani Burra <phani.r.burra@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] idpf: fix building without IPv4
Date: Mon, 25 Sep 2023 17:58:44 +0200
Message-Id: <20230925155858.651425-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added offload code fails to link when IPv4 networking is disabled:

arm-linux-gnueabi-ld: drivers/net/ethernet/intel/idpf/idpf_txrx.o: in function `idpf_vport_splitq_napi_poll':
idpf_txrx.c:(.text+0x7a20): undefined reference to `tcp_gro_complete'

Add complile-time checks for both CONFIG_INET (ipv4) and CONFIG_IPV6
in order to drop the corresponding code when the features are unavailable.
This should also help produce slightly better output for IPv4-only
kernel builds, if anyone still uses those.

Fixes: 3a8845af66edb ("idpf: add RX splitq napi poll support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 6fa79898c42c5..140c1ad3e0679 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2770,8 +2770,10 @@ static void idpf_rx_csum(struct idpf_queue *rxq, struct sk_buff *skb,
 	if (!(csum_bits->l3l4p))
 		return;
 
-	ipv4 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
-	ipv6 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
+	ipv4 = IS_ENABLED(CONFIG_INET) &&
+	       IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
+	ipv6 = IS_ENABLED(CONFIG_IPV6) &&
+	       IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
 
 	if (ipv4 && (csum_bits->ipe || csum_bits->eipe))
 		goto checksum_fail;
@@ -2870,8 +2872,10 @@ static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
 	if (unlikely(!rsc_seg_len))
 		return -EINVAL;
 
-	ipv4 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
-	ipv6 = IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
+	ipv4 = IS_ENABLED(CONFIG_INET) &&
+	       IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV4);
+	ipv6 = IS_ENABLED(CONFIG_IPV6) &&
+	       IDPF_RX_PTYPE_TO_IPV(decoded, IDPF_RX_PTYPE_OUTER_IPV6);
 
 	if (unlikely(!(ipv4 ^ ipv6)))
 		return -EINVAL;
-- 
2.39.2


