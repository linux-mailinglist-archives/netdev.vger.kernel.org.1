Return-Path: <netdev+bounces-257493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIlWG3GshWkRFAQAu9opvQ
	(envelope-from <netdev+bounces-257493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 09:55:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFC4FBB09
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 09:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0A9130072B9
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB4E34DCEE;
	Fri,  6 Feb 2026 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjSjQicO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38875314B95
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368108; cv=none; b=DcDAJCnjv3W0vkWZh5gNNQqhdcompL4EPYLxYFl1kwfniTpWA8o4/E/ZK5icH3UXW0bXACPUgIWNVdq3yXuDXThgSvPpGGs94u0KOQROiIlDUrSPKUXKICEp0q/f7i9vC08h7oqEirytiXiuCHq+f7P/witk05dDWri2UwimZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368108; c=relaxed/simple;
	bh=8gJloZSI1GQcrUYIaj8I3nBQOZEH48jxJXr5qkX/U14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzxqB8igtmUx7Wmcey0eZCVGx9scrNEmERPm/Mf0lMkqxxl0F40nqMHDIMU47jSD+nFiVzJLp+Z2+tIrPp0zdTFCqtF19FaWOhyW/2qRoS/pHLALJcrV1WpWTy6YlwpTXg+l7cjZNSHKzDCVV6poSARoYhu54bHRIeNnKmkh6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjSjQicO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee66dab14so732405e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 00:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770368106; x=1770972906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4CfwKcayH4xDR1+iMb7IfsfcQiFBuBvxK6Im43iVvY=;
        b=gjSjQicO5T3W/iqPuXAXKIxzqqgcdFdaQMz1jXcI6cGcv/qsXESXyfVwl2zJ0+WXIs
         LrVhLZjAm5NZ/J6AlDKm4aJIU3NcIuha8o8k4eBBQQjXlIcu8+P8BCCRverJplUylxC0
         eFQLb2mfnqd46takk8AklbPgxqcQGX4+H+F+MpKZlyCdJvwoX3SZjhyF7OqKpObLx/PH
         dqZiJ0YF3YaHFdx5GQJyIqhvpNqen5BhpcIDTfwzXBzHQuLZIt4f78brZu/iqMOiu66Q
         TqP/Xsd0/GrMP53Xi9DvXCmOCRYWfGBR/eYOWc51tU/UVvcwiDp4HPgOikkk9+L5/jFL
         bIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770368106; x=1770972906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4CfwKcayH4xDR1+iMb7IfsfcQiFBuBvxK6Im43iVvY=;
        b=bnWBvDPuKTYCeXHm4oRmscE+XJgy16xOFr/H4+P/47Rr2KvCWaO0Gp3hfoIOJpu3Q+
         G7OgOutsv1SUBT9udsGk3jr5STy9Pc9LU560yrQgEviMlJ8gc1LnWLYxauFtajLwRwfe
         8NA7DPsRwH/dk+afU00QDD7kl/bmZqfiUKoYzx87sHNZhRfcxlFF+rkRT+UDl7tarNiq
         HxTh62bmn9BXFgG3N/0EpCsn30rEU3e0qs2MzTjgwKDI7eG8UkbHgotmvAP5g+Ak6Kva
         qrM7TmKkfoI5rL4YkUXMt+/vvmnntNj8MdP05HP/ezOBy2XSO0AxuavfpB6Hjq4rh3AQ
         fRcA==
X-Forwarded-Encrypted: i=1; AJvYcCXZEDVM5pZZBde5SuMyFX3Irupvq7OUfi/0ywJj8mR45mv1U1t1UrgWg1COPcakh9ZM2HElrmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxvm+aiSp0ClLuVWIqaZlAFHoJCWZ8aRrDQtmrlYdUJlCAyWQR
	w4q7+t1ws2cjnMsi6KNdCRJ8UtJX0KeDEtDyuW+okDOpIxX/2IevgvKr
X-Gm-Gg: AZuq6aLmAIOrM8UyCg34Jhg1bmWvk3Lj4YD9043vqu+ei9cdf1bxUYSyWDZYPFPaj0e
	n/Zsm+Cyz2VcmDvO0r0SeJRvEFCxrYaYet9EKZmoElOiVEIPgE3y+y+DbiaXP386j9L4RqYIk09
	qv6DTuXWtLmESvW/ptKbuMh4sKnj47LISvdPk3ZJq/eZbW/kpZWoTeoxABxcftQc9qsaOzqwMyy
	j9ggPgGcW/LnSERml4TxBCKMAryLfY1tED+/7xsVNelait8srJQuwOziBF+rEDtvmm/IiErmle0
	XS8nKZ383iN6I6NscHAxJOwL7uNPr9DSZZhAPnZBCuyqJqAT+ajL7tAlYSpLBlnmm/MD6G224JI
	vvTWQhH3phGAaM2D20a5GMK0M+rvORVqO1Vbhbg1GM2nkWf0g8XcFTDsotP9WMMhjVwc9F5PItD
	SJGRmxSRXSuccjLZsxrIwK9jHRvZcgfcUjkyN40S8VdRIPSaMmaYm/msBz5H2vMWpbZul7JFHZY
	EwzWJZX
X-Received: by 2002:a05:6000:22c4:b0:431:8f8:7f2a with SMTP id ffacd0b85a97d-4362933ec57mr1767057f8f.1.1770368106350;
        Fri, 06 Feb 2026 00:55:06 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-213.paris.inria.fr. [128.93.83.213])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43629744ec6sm4878270f8f.35.2026.02.06.00.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:55:05 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
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
Subject: [PATCH net,v2] net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()
Date: Fri,  6 Feb 2026 09:53:33 +0100
Message-ID: <20260206085334.21195-2-fourier.thomas@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257493-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CFC4FBB09
X-Rspamd-Action: no action

The priv->rx_buffer and priv->tx_buffer are alloc'd together as
contiguous buffers in uhdlc_init() but freed as two buffers in
uhdlc_memclean().

Change the cleanup to only call dma_free_coherent() once on the whole
buffer.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - Cleanup priv->tx_buffer and priv->dma_tx_addr
  - Fix buffer name in commit message

 drivers/net/wan/fsl_ucc_hdlc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index f999798a5612..dff84731343c 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -790,18 +790,14 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 
 	if (priv->rx_buffer) {
 		dma_free_coherent(priv->dev,
-				  RX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
+				  (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
 				  priv->rx_buffer, priv->dma_rx_addr);
 		priv->rx_buffer = NULL;
 		priv->dma_rx_addr = 0;
-	}
 
-	if (priv->tx_buffer) {
-		dma_free_coherent(priv->dev,
-				  TX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
-				  priv->tx_buffer, priv->dma_tx_addr);
 		priv->tx_buffer = NULL;
 		priv->dma_tx_addr = 0;
+
 	}
 }
 
-- 
2.43.0


