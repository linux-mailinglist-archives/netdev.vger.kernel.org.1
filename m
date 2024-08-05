Return-Path: <netdev+bounces-115648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32277947582
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CD21C20F74
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 06:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162A514A4FC;
	Mon,  5 Aug 2024 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="leducTY+"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-213.smtpout.orange.fr [193.252.23.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AF14A097
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722840157; cv=none; b=FSNN0skhyJtaX80zYRIIHkL2P+DgCe/gLYK+egidzLrsEg7RlI6jHo3v1AAh45vp1tPwhQh3liHwR4XXY8RaAUmiR4TbhVGUnP+d5152JtdWzimEJX6fVg1Oi1gLTk0xbCQCRGPsK7cA3kh39AykenbYaONJHTK3PqkNtehwT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722840157; c=relaxed/simple;
	bh=mYdDauKLkFehc0PPjkbY+QSlVdHIA1mUlEQXWR7Yk6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MddEFY/lHePIsCviJ3BzeEh2emEzTkV31f5UaQDPSMWEeMR/ZNFYegFn4+pbFa09Jv4MYjj5E9b3U+KPL9Ua0kTdncAYJDN1UYZKqrDVeSXshOthpO2493VI8nSozP51ugIImZr1s19YHZK6wgKAd7JaaiswgG2K0K3wCUeWUwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=leducTY+; arc=none smtp.client-ip=193.252.23.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id arOns5eD41n2IarPJsUUkH; Mon, 05 Aug 2024 08:41:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722840085;
	bh=fZnfV4gskIqv87dNYmFTGpAnTyJ6Dtl1w8GxFk9Ipsc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=leducTY+nH174RYYnTi12fdGoxirXsmTUaoCHwknPPZws/E+6h0HBDwuc1Mtkcqjw
	 C7U6juRV53WE3+xrABBaxXptE2+ZzEyMiII2Gp3cn/GTVvv3sN3LDuKlDbyX4jKHA5
	 aGgDFHBbyTyGmGUPWY1YDoGz8vmVtoD6nNIr6p5VBCpCKJsLRR+gfl8gkg9WB6NaLe
	 u8qUjB4ULngW2vz6aSxZTrunRjI7xEWb+xqznSPk11OQWaocEzZ0VpDPAfVPV8Rwur
	 Q59OTLkzCtflgywuy296JcDEzY58E6o44Hy4ASu3RNnlt4Dz26olSGTxBSlXTHzofu
	 EyL6pslWfeUXw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 05 Aug 2024 08:41:25 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: stas.yakovlev@gmail.com,
	kvalo@kernel.org,
	gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-staging@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 3/3] staging: rtl8192e: Constify struct lib80211_crypto_ops
Date: Mon,  5 Aug 2024 08:40:39 +0200
Message-ID: <dfda6343781ae3d50cd2ec7bbdcf76a489b6922a.1722839425.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722839425.git.christophe.jaillet@wanadoo.fr>
References: <cover.1722839425.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that functions in lib80211 handle "const struct lib80211_crypto_ops",
some structure can be constified as well.

Constifying these structures moves some data to a read-only section, so
increase overall security.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

Changes in v2:
  - No changes

v1: https://lore.kernel.org/all/81be9eb42a2339eaa7466578773945a48904d3b5.1715443223.git.christophe.jaillet@wanadoo.fr/
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 2 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 2 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index 639877069fad..138733cb00e2 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -378,7 +378,7 @@ static void rtllib_ccmp_print_stats(struct seq_file *m, void *priv)
 		   ccmp->dot11rsna_stats_ccmp_decrypt_errors);
 }
 
-static struct lib80211_crypto_ops rtllib_crypt_ccmp = {
+static const struct lib80211_crypto_ops rtllib_crypt_ccmp = {
 	.name			= "R-CCMP",
 	.init			= rtllib_ccmp_init,
 	.deinit			= rtllib_ccmp_deinit,
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index dc0917b03511..74dc8326c886 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -678,7 +678,7 @@ static void rtllib_tkip_print_stats(struct seq_file *m, void *priv)
 		   tkip->dot11RSNAStatsTKIPLocalMICFailures);
 }
 
-static struct lib80211_crypto_ops rtllib_crypt_tkip = {
+static const struct lib80211_crypto_ops rtllib_crypt_tkip = {
 	.name			= "R-TKIP",
 	.init			= rtllib_tkip_init,
 	.deinit			= rtllib_tkip_deinit,
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_wep.c b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
index 10092f6884ff..aa18c060d727 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_wep.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
@@ -209,7 +209,7 @@ static void prism2_wep_print_stats(struct seq_file *m, void *priv)
 	seq_printf(m, "key[%d] alg=WEP len=%d\n", wep->key_idx, wep->key_len);
 }
 
-static struct lib80211_crypto_ops rtllib_crypt_wep = {
+static const struct lib80211_crypto_ops rtllib_crypt_wep = {
 	.name			= "R-WEP",
 	.init			= prism2_wep_init,
 	.deinit			= prism2_wep_deinit,
-- 
2.45.2


