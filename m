Return-Path: <netdev+bounces-257998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPM2A+RkimmiJwAAu9opvQ
	(envelope-from <netdev+bounces-257998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:51:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C664B115428
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09397300C001
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 22:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AF731691A;
	Mon,  9 Feb 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkcDSlXt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2E30F543
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770677471; cv=none; b=S7ZaK0TCwPN6phxDaRRMp8n0J2GMQxE9qPEDvSYjXK+rdJ8JqIorX7LgQnF3b5BcHikV1vBl3afdBDabo3gXNEJypFwMRKLQ+X3LBD+g2jxZ+WiEE0UoicFI6mQ5xG7XK43+j6dkV2/7GmEwvGov17+hZ7rzzS/fNti+/MnQSXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770677471; c=relaxed/simple;
	bh=6FoVXBBm/8Wo4jxEKVSL8pT+WGiQu5KbjsXqUY2KhD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQgXNtVT0JY8vI45bLayIyYGm2mq+Ia6ChYYbzRcrCvoeHSKxpgDIV9hxfAsa6Xc8SY4cvG6rW6sdf1iAFi2YZ6w3p+a4tDW+/Fkub9Dfpmd3sQRDo1+vEDcOnZNaTLeJhKs2jWn+E5Xq32UzO4/BsIgraytrX7ba26BHZVQLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkcDSlXt; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50146483bf9so53904291cf.3
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 14:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770677469; x=1771282269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+TvrkNSZE9ym2PFZpW4r5uQoR0rtxBqbUzuUkdsCDo=;
        b=UkcDSlXt3M1ZYjc0FnBVksKU/+dPvTkVng9foZT99Y8J33zBtV2jLNVM1O3VRG6ITH
         E0D26OkM8t0ISKGYNwpj0O2kVmSQGPN8GnNFReUyRsU3qN74GjtATiPRtTzehuTeh2B9
         5pZS5hfeaTXgHL5SQUzeK0Ey+zRjfLG2SKn1CdnEnKbVEXwdDY3rM0Tkf2MSkuRjcg5I
         YspoARCOE8vRhX/JvAMtVvcAHdx4MZ7h87Umflo9VAoNYU49ecs1MDrExpGJPDGUbg2/
         Wv/rylguQy/D2y0+Or7BUZEn+wqwgAsPmAcKuHPmvHHTSyqTJYb0Z+ykIphAVvfZtz7A
         w5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770677469; x=1771282269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+TvrkNSZE9ym2PFZpW4r5uQoR0rtxBqbUzuUkdsCDo=;
        b=sAP6Q7MRtwfuN0WUI6QON8yyPcKq8RHowVW3600t0I4/HxsG/p1qyN7lh227VXzZLf
         cQEsk1onXS2AEHDabSif/baiIGJcZfHQ7z0F2WWFCwVXgl5GitjUxUXAZtXg8d/UIAO5
         eHLOZDid9nPaJdbHagAqp/auKKa1WeuBVDQWSUkVYnsyjlrmTN/7/RxogjkaisdTkW75
         eiwpAr+KMnRcXOZbCc44YtF+GzekXw3XVDOsLe5GJBh0osOeCBbB2oviEI1lKb1JT28X
         D0ObJwdBJNw1FkHv983ZtNNOl14a1jsMThbFhnCQLmgT1pUkruDntM5jK5bcOByjoyoR
         eVJg==
X-Gm-Message-State: AOJu0YyJa2oZXa7t6vEJOV3YAfF4UBsLHt4s5GKfeFC3MZSuorOrcecb
	3Qnk1Dl71DKDzAXvU7SogDYO4I6XiDdZbxn5cza2hiJs+sQX9Cgkg2h5oSc71A==
X-Gm-Gg: AZuq6aIiBoRmRWGBuPNrBWmRWogpwvLl6i65MS32glfVqk5HQZRDCw5oXaJXnC6xGl8
	15tMCWWpU0Sg7e3GB1xXyTckX7QH4fOLAkx5fY34/iNRGLojoHvyGjyQ8VuiGAfPsTBTEsZ7S5A
	6lrqgb8UVFmk3179EbISrl5mU1pKjguF1HXJoriEDgstVGERgQDwvrVOJq/5rP8CmamaaKrj9/1
	9oiwjKp2qnyC5djLXv+UawvWj6HPbO8QQpSVDHifZXewkxNosCflyFR68brBEPLE6Z3t/jua0KA
	ovNwccekP9iywjsHwALZigDry1C/Fb/qnHaYaFVF66Q+6G6S33ycfokqX1ScD13Dnyh5FPsTcy4
	iW3MaFIJDtgTsJNLSOv+kGuhwtKIsMPIZn6UteJcRHsx+S2WgIoPlngc5CAeNzTyEZh4gO/9U4K
	E1hlvdU536SfIjr14DGVG4SC111Cud92N081lwohEFzbankL3pbwx1uqQfWbunONNbCDwvSyfGh
	3w=
X-Received: by 2002:a05:622a:314:b0:4ee:4a8b:d9f6 with SMTP id d75a77b69052e-50639999b38mr165019831cf.59.1770677469375;
        Mon, 09 Feb 2026 14:51:09 -0800 (PST)
Received: from localhost.localdomain (h69-131-24-92.cntcnh.broadband.dynamic.tds.net. [69.131.24.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50640c60b3csm87021861cf.8.2026.02.09.14.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 14:51:08 -0800 (PST)
From: Jie Zhang <jzhang918@gmail.com>
X-Google-Original-From: Jie Zhang <jie.zhang@analog.com>
To: netdev@vger.kernel.org
Cc: jzhang918@gmail.com,
	jie.zhang@analog.com,
	horms@kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: stmmac: fix oops when split header is enabled
Date: Mon,  9 Feb 2026 17:50:32 -0500
Message-ID: <20260209225037.589130-1-jie.zhang@analog.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257998-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,analog.com,kernel.org,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,foss.st.com,armlinux.org.uk,bootlin.com,nxp.com,synopsys.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jzhang918@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,analog.com:mid,analog.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C664B115428
X-Rspamd-Action: no action

For GMAC4, when split header is enabled, in some rare cases, the
hardware does not fill buf2 of the first descriptor with payload.
Thus we cannot assume buf2 is always fully filled if it is not
the last descriptor. Otherwise, the length of buf2 of the second
descriptor will be calculated wrong and cause an oops:

Unable to handle kernel paging request at virtual address ffff00019246bfc0
...
x2 : 0000000000000040 x1 : ffff00019246bfc0 x0 : ffff00009246c000
Call trace:
 dcache_inval_poc+0x28/0x58 (P)
 dma_direct_sync_single_for_cpu+0x38/0x6c
 __dma_sync_single_for_cpu+0x34/0x6c
 stmmac_napi_poll_rx+0x8f0/0xb60
 __napi_poll.constprop.0+0x30/0x144
 net_rx_action+0x160/0x274
 handle_softirqs+0x1b8/0x1fc
...

To fix this, the PL bit-field in RDES3 register is used for all
descriptors, whether it is the last descriptor or not.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jie Zhang <jie.zhang@analog.com>
---
v3:
1. Fix build error
v2:
1. Update for the latest net HEAD
2. Reduce crash dump message in commit message
3. Add Fixes tag
v1 link: https://lore.kernel.org/all/20251202025421.4560-1-jie.zhang@analog.com/
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a379221b96a3..f98fd254315f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5023,13 +5023,27 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 	if (!priv->sph_active)
 		return 0;
 
-	/* Not last descriptor */
-	if (status & rx_not_ls)
+	/* For GMAC4, when split header is enabled, in some rare cases, the
+	 * hardware does not fill buf2 of the first descriptor with payload.
+	 * Thus we cannot assume buf2 is always fully filled if it is not
+	 * the last descriptor. Otherwise, the length of buf2 of the second
+	 * descriptor will be calculated wrong and cause an oops.
+	 *
+	 * If this is the last descriptor, 'plen' is the length of the
+	 * received packet that was transferred to system memory.
+	 * Otherwise, it is the accumulated number of bytes that have been
+	 * transferred for the current packet.
+	 *
+	 * Thus 'plen - len' always gives the correct length of buf2.
+	 */
+
+	/* Not GMAC4 and not last descriptor */
+	if (priv->plat->core_type != DWMAC_CORE_GMAC4 && (status & rx_not_ls))
 		return priv->dma_conf.dma_buf_sz;
 
+	/* GMAC4 or last descriptor */
 	plen = stmmac_get_rx_frame_len(priv, p, coe);
 
-	/* Last descriptor */
 	return plen - len;
 }
 
-- 
2.47.3


