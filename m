Return-Path: <netdev+bounces-256765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBRjEQN2g2mFmwMAu9opvQ
	(envelope-from <netdev+bounces-256765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:38:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6349EA5BC
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A51293011F05
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766092F25EB;
	Wed,  4 Feb 2026 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7G5s6ni"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051872F12BF
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222735; cv=none; b=WPF+MOz6RR/ywbdI7DM9+w8jD7fmQSG+6TVyNf8wH8fA+Qr7XjfLN//dz83PS9tKwtMVUhthqE8T7yER2q4y516KFX5duUZGhnkeMHWLvBMYCGF8FJQUmTjjeTt0Whsr1SrsX3C4IywbaVVju3kwmwxh7LLVYsdI6ENgDArIghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222735; c=relaxed/simple;
	bh=cNOMoPICMTO7Jd/feVQ1G3OBQwG43K4Z1Ef+EsXsnu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjdYZTbXJnIgxk0UvmqVWwGvsDyC/Np7Jb4xjNQVIPMQoWaOdBfFC2kupVVuO+IlxS1GoR7Z88TjoUZloVfe6oVq6ON0aa6KctsgaA40dEthkj1WCw4Irbcf6qwIWnN8zOEXn/U7+e+s+Fg7/54XPFbfS90HNbD26gSx4K58ZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7G5s6ni; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-435a51abad1so6345f8f.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770222733; x=1770827533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FhzKPlo/o1GqrY1Xo5QLsYHf6TE8sJz/yK5MOWUEpRg=;
        b=B7G5s6nih128aQkHe/yGNNXDt8RJh5UD23KumLb6VgMGmSSvVIiv1FhlbF2bzxbufN
         9akNRgsrssziQVDzyyyoD5veddNvhf4nygkmJQnWDqrfgZvzToXFGwcCMZGpCCBTw73a
         ZIV5rfyM8EIxO9gW+RFP1P/+O+7M0XPDxBfPPb/LQ3y85PwsiDEkybXHesmyHPUmb0lP
         zkiB9bP5tc0+fJPiEf0Ksy2NWZrlMJ+IdY22HeERVH0vmtJ6WMPNXpSp/rko0+el+fl/
         iAaFw6rhWgbeXQWsapMWL0aNMtAZShD3dIi/URGECWW7neTmNNH7GWnx8VB0FkxZ+4xO
         zIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222733; x=1770827533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhzKPlo/o1GqrY1Xo5QLsYHf6TE8sJz/yK5MOWUEpRg=;
        b=igg00IbpPQKa3z4jjEqoiiyWD/i2n1Mya2nflNNpY8gnxF/Vk5uiwgfPaI4D/JIa61
         n6OK9hxN5hNDaaTaccaszimF1fkDzeokPa76FDS6WAnexXZIC0OnQ+07X3sey8zAfLMb
         XQE9NHw863yTbBDvyE1V8sgal3bI4KyWW0+6OFTUncctjwATH2SliRROhrgHbdTkPiYH
         srBxZ6PqipPaLbwI/mQvST1+qVHQt6A89DoO8i47LDlAWmb51e98LK2M1QDt2dx+A+Df
         YT5iiJAkJHhba6nNeBzgVHyZiyyyECimSsBCO5kiAtFpsYPswTOofEiKFpIBQvrCovEs
         E/uA==
X-Forwarded-Encrypted: i=1; AJvYcCVo8b85/XRTFBFFpkk/eGuGQ4fCNfFQCCD7vFDsobk5sTuoeQLyvA8DoeJ5+0WW9h7HhM2JGbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoV/Jzqp9iioc7gvR8GxTmQecXWL+Dk2i8/Ga4Ih4cJRE0XXsT
	h6sLlhMqTgUA+l32hitVoHbI2dDTKZGU2A5tNVIvt23FauHL2S+cQ9CV
X-Gm-Gg: AZuq6aJZAKeh30nD34uPWpEs2HgHFUSudnV1LXoZk6mmAzsWEs5CTzfiDm8xWijibdy
	q10j39DbjOnXF6lLXVhl7BbDOHesyfQAwCqdRkCgIs/q4eU3VPn6Yz7eWqeTTjqs0Es3A4I9gy0
	Y6CzDNhOmGejyk7xfo/NgP+AbkqczBothlWXcN8nhoWvX7/Dgxv/ZirNxrP0khOO1qDPagSemrs
	QnrGkbvU81JA58VtJYnUNTAqk+4+iWdvPLKr05EgJIFZPIVKDURbBQ5SOmYyHG7JwstdSzMYgVb
	lZ/wh5fbvOwn4yB3CQ12fHHA4IwTfmkUpP0Jw/YRb7yJXQUKMBKlWZRXrgivYYsf23UmsJ+Xogk
	29Fybf/MKWA6WnAzujZhQcDy67RutAceTuja6+70ST/l4IDDnIfl1csVOk5rJdj5nlXsqgec8ZB
	k2GTtlwrkqEci3EYlIvI4H8YKNGkxfKuMMd5+K8wh1CrjSbuGo/N1Sf4MMG7t8Lv3YoEAPaQoZ7
	VpGpJk=
X-Received: by 2002:a05:6000:4205:b0:435:91a5:1325 with SMTP id ffacd0b85a97d-43619405830mr2296210f8f.7.1770222733044;
        Wed, 04 Feb 2026 08:32:13 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-213.paris.inria.fr. [128.93.83.213])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43617e25683sm7377005f8f.6.2026.02.04.08.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:32:12 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Zhao Qiang <qiang.zhao@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()
Date: Wed,  4 Feb 2026 17:25:47 +0100
Message-ID: <20260204162548.94160-3-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256765-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6349EA5BC
X-Rspamd-Action: no action

The priv->rx_buffer and priv->dma_rx_addr are alloc'd together as
contiguous buffers in uhdlc_init() but freed as two buffers in
uhdlc_memclean().

Change the cleanup to only call dma_free_coherent() once on the whole
buffer.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index f999798a5612..59cd861d13d6 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -790,19 +790,11 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 
 	if (priv->rx_buffer) {
 		dma_free_coherent(priv->dev,
-				  RX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
+				  (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
 				  priv->rx_buffer, priv->dma_rx_addr);
 		priv->rx_buffer = NULL;
 		priv->dma_rx_addr = 0;
 	}
-
-	if (priv->tx_buffer) {
-		dma_free_coherent(priv->dev,
-				  TX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
-				  priv->tx_buffer, priv->dma_tx_addr);
-		priv->tx_buffer = NULL;
-		priv->dma_tx_addr = 0;
-	}
 }
 
 static int uhdlc_close(struct net_device *dev)
-- 
2.43.0


