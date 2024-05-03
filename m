Return-Path: <netdev+bounces-93366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E08BB4DE
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CA21F23FEC
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDDA28DC9;
	Fri,  3 May 2024 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W93gt274"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F341CD29;
	Fri,  3 May 2024 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768303; cv=none; b=c/LcFmFRhLBima+QYnzXHpKtuOcyj+LVX/Z9GnCqckonQGSoChLkis6Q/DvcS2UBQDXnBiXSSWrcqhGWOcAvr1+iVQ6nDKJK+zDFdZ/jDVSCBeQ7XqpsP6GrfO8+qwZSA554hDcn+wHP1E2kY7JeZVmmS5io/6hQ+UTY+G5hg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768303; c=relaxed/simple;
	bh=bcTauFkomv1VILEJF41wZk4z7dvbXuYeoULUQhP2zZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzGWSVaqVvkD87KgXVU0yxtbHATt23tg0ttZ7griZ0mskep6+NLP41u8JbA7qUUkp2a+BT0y9PSfLvKGutky9vPF6ukK5RLY2rB8YRVjlokOR+iVsP/NLXtk+BIKgGs68Az93bhOQVk8vI03+TGx17PnJrpsYKKt/LzPegtmVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W93gt274; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528CCC4AF18;
	Fri,  3 May 2024 20:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714768302;
	bh=bcTauFkomv1VILEJF41wZk4z7dvbXuYeoULUQhP2zZk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W93gt274PAHvzNxwsBcJ3CCeVDGGGfNF+yeyVwqj0nN0wXYGYqVna7KqLAsylNFM0
	 cWQGae7LwjrM1ci3bTzUYNHoL7jWx1Hw+WkuFHEHNPvWZP9gzf2tbgbxDjHVRYa9IN
	 9I/m1sgvuzYp7hqBoWtvNARPS0Ic0zo/xsTbAUuULtmV4Hj5vBOQ8GdvAKQgcXh+ZT
	 SGQfYDPbhnxU9PuYBJkJYkoYy9W84itMv7Axb84bjWhqZIPUCzMXtP8sQYsRdq4yn4
	 CYOPqlUeJNsg9/yaQQepyOKhXHjBEgb+IigK/aFc4Nso/Igq0UuTULNKce+PQCjL4p
	 aB0H6BXJmgCqA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 03 May 2024 21:31:27 +0100
Subject: [PATCH net-next 2/2] gve: Use ethtool_sprintf/puts() to fill stats
 strings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-gve-comma-v1-2-b50f965694ef@kernel.org>
References: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
In-Reply-To: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
 netdev@vger.kernel.org, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.12.3

Make use of standard helpers to simplify filling in stats strings.

The first two ethtool_puts() changes address the following fortification
warnings flagged by W=1 builds with clang-18. (The last ethtool_puts
change does not because the warning relates to writing beyond the first
element of an array, and gve_gstrings_priv_flags only has one element.)

.../fortify-string.h:562:4: warning: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
  562 |                         __read_overflow2_field(q_size_field, size);
      |                         ^
.../fortify-string.h:562:4: warning: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]

Likewise, the same changes resolve the same problems flagged by Smatch.

.../gve_ethtool.c:100 gve_get_strings() error: __builtin_memcpy() '*gve_gstrings_main_stats' too small (32 vs 576)
.../gve_ethtool.c:120 gve_get_strings() error: __builtin_memcpy() '*gve_gstrings_adminq_stats' too small (32 vs 512)

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 42 +++++++++++----------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index bd7632eed776..31563eeb0a41 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -89,42 +89,34 @@ static const char gve_gstrings_priv_flags[][ETH_GSTRING_LEN] = {
 static void gve_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	struct gve_priv *priv = netdev_priv(netdev);
-	char *s = (char *)data;
+	u8 *s = (char *)data;
 	int num_tx_queues;
 	int i, j;
 
 	num_tx_queues = gve_num_tx_queues(priv);
 	switch (stringset) {
 	case ETH_SS_STATS:
-		memcpy(s, *gve_gstrings_main_stats,
-		       sizeof(gve_gstrings_main_stats));
-		s += sizeof(gve_gstrings_main_stats);
-
-		for (i = 0; i < priv->rx_cfg.num_queues; i++) {
-			for (j = 0; j < NUM_GVE_RX_CNTS; j++) {
-				snprintf(s, ETH_GSTRING_LEN,
-					 gve_gstrings_rx_stats[j], i);
-				s += ETH_GSTRING_LEN;
-			}
-		}
+		for (i = 0; i < ARRAY_SIZE(gve_gstrings_main_stats); i++)
+			ethtool_puts(&s, gve_gstrings_main_stats[i]);
 
-		for (i = 0; i < num_tx_queues; i++) {
-			for (j = 0; j < NUM_GVE_TX_CNTS; j++) {
-				snprintf(s, ETH_GSTRING_LEN,
-					 gve_gstrings_tx_stats[j], i);
-				s += ETH_GSTRING_LEN;
-			}
-		}
+		for (i = 0; i < priv->rx_cfg.num_queues; i++)
+			for (j = 0; j < NUM_GVE_RX_CNTS; j++)
+				ethtool_sprintf(&s, gve_gstrings_rx_stats[j],
+						i);
+
+		for (i = 0; i < num_tx_queues; i++)
+			for (j = 0; j < NUM_GVE_TX_CNTS; j++)
+				ethtool_sprintf(&s, gve_gstrings_tx_stats[j],
+						i);
+
+		for (i = 0; i < ARRAY_SIZE(gve_gstrings_adminq_stats); i++)
+			ethtool_puts(&s, gve_gstrings_adminq_stats[i]);
 
-		memcpy(s, *gve_gstrings_adminq_stats,
-		       sizeof(gve_gstrings_adminq_stats));
-		s += sizeof(gve_gstrings_adminq_stats);
 		break;
 
 	case ETH_SS_PRIV_FLAGS:
-		memcpy(s, *gve_gstrings_priv_flags,
-		       sizeof(gve_gstrings_priv_flags));
-		s += sizeof(gve_gstrings_priv_flags);
+		for (i = 0; i < ARRAY_SIZE(gve_gstrings_priv_flags); i++)
+			ethtool_puts(&s, gve_gstrings_priv_flags[i]);
 		break;
 
 	default:

-- 
2.43.0


