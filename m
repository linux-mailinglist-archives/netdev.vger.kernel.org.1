Return-Path: <netdev+bounces-283931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCNfDmnC+Gky0gIAu9opvQ
	(envelope-from <netdev+bounces-283931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:59:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE884C10D6
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 625243043690
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E863E1207;
	Mon,  4 May 2026 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="UcNWnWRG";
	dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="AqAm4Pmw"
X-Original-To: netdev@vger.kernel.org
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54D392C32
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.144.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910252; cv=none; b=U5vwAt2QXvfayXMcFkGaGzue/pbmSHvEJ0cm8awRnPKAvZVV3wI34aLCbarJEr6hBIFC0/X+WPt1Qitt//Pyvj5gSgG03PzVlpA6OhrNh/CTJtlQNT+dl47L52RPgp8HcqtcHG8CK0p3sWDYUwmQoQw+1vB6oFa9F5armGmxRlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910252; c=relaxed/simple;
	bh=BSeaDRxu/DNoh9sUU//JOSdBs4r1u9B18KOKx2Q1Jrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVzv5MlybW8LAWgniSjrHKQGTYgRZQZBqNhVEPivt44TNpIGYBVUhXHor1TFZi4asmBDnlbmcxDxyX4RGhKSnqXeJa+9Rgvl6y1Q2qvioFqslRwkYGQXbQz1R3C1Ac1cqIc3HKSMZXzjYH8Iem2yLAPHe/oAEk0GkO9gF5G+EoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=UcNWnWRG; dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b=AqAm4Pmw; arc=none smtp.client-ip=18.158.144.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=0BKXpo1u7lWawTu7f0xL5Pp283L9bUuja2ZdCCoXRl0=;
	b=UcNWnWRG+c22hXO4F4jZv9oUJ9rhKREP9HlPbNozXMvB2BLDDFxV+anwHmyyuQksk6JiAehbS2u7v
	 +tFU/l68uGThizi+osq7tT/60u0LnjXQvTTtfBAAM5IVpWxavJmogP0ujTlM9Pmt9LQZZqyY7YMqzl
	 370c5MQskp1kXZ5o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=0BKXpo1u7lWawTu7f0xL5Pp283L9bUuja2ZdCCoXRl0=;
	b=AqAm4PmwEoaWdiYQlw0+Ci3WhB1ntWnBYaADb4ZrqR4zlhv7Yvswm+l12e/W74lDK8gL2oxnGAFYj
	 C3wEaMiLbcSLJGIBLbdjchK0cFUIC92TaCzK0jo+CsWxh47KSse4CM7WhN+yNPZlAvAQar3Rhd6hcc
	 TTbDbdzBKXRhieSgkC4k04US97Dy5G7douAwPHGT41p8r6x2adkdasiLhyZ2jj22TCt3lTQzBqVo0z
	 CeiPgzY4R12ayZz+DVnRmLjTblF/mYeU5xSe/IcS2aKMUC4KyZHPsShD7TPe4wt+xKXzEjPEMe6f8l
	 YKIK9/8Vog6xL42gJ74RhtCzkTDlEuA==
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: eb4e0fb5-47d1-11f1-8ef3-f54febe22707
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: eb4e0fb5-47d1-11f1-8ef3-f54febe22707:13
CFBL-Address: prvs=058485b737=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000534.corp.hitachi-powergrids.com (unknown [20.62.140.138])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id eb4e0fb5-47d1-11f1-8ef3-f54febe22707;
	Mon, 04 May 2026 15:57:16 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000534.corp.hitachi-powergrids.com (Postfix) with ESMTP id 541C9402502;
	Mon,  4 May 2026 15:57:14 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id CB2EF60B7D47;
	Mon,  4 May 2026 17:57:13 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH net] net: wan: fsl_uhdlc_hdlc: fix dma_rmb usage in hdlc_rx_done
Date: Mon,  4 May 2026 17:56:42 +0200
Message-ID: <20260504155642.2216040-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.52.0.120.gb31ab939fe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9EE884C10D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hitachienergy.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hitachienergy.com:s=duo-1630306886989-947ac67a,outbound.mailhop.org:s=dkim-high];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[holger.brunck@hitachienergy.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283931-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[hitachienergy.com:+,outbound.mailhop.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outbound.mailhop.org:dkim,hitachienergy.com:email,hitachienergy.com:dkim,hitachienergy.com:mid]

If dma_rmb is used it has to be done after reading bd_status and checking
if R_E_S is zero. Therefore we need to move it into the while loop.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 15bfb78381d4..09081f128a98 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -523,12 +523,12 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
 	u16 length, howmany = 0;
 	u8 *bdbuffer;
 
-	dma_rmb();
 	bd = priv->currx_bd;
 	bd_status = be16_to_cpu(bd->status);
 
 	/* while there are received buffers and BD is full (~R_E) */
 	while (!((bd_status & (R_E_S)) || (--rx_work_limit < 0))) {
+		dma_rmb();
 		if (bd_status & (RX_BD_ERRORS)) {
 			dev->stats.rx_errors++;
 
@@ -610,7 +610,6 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
 
 		bd_status = be16_to_cpu(bd->status);
 	}
-	dma_rmb();
 
 	priv->currx_bd = bd;
 	return howmany;
-- 
2.47.3


