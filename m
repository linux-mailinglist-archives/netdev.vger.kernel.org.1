Return-Path: <netdev+bounces-305775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y0eoElE2TmplJAIAu9opvQ
	(envelope-from <netdev+bounces-305775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:36:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 798FD725EA0
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:36:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ijaMb2bP;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305775-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305775-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA63C304AA39
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 11:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C743F4CA;
	Wed,  8 Jul 2026 11:19:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD343E9CD
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 11:19:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509542; cv=none; b=fTN1sin9uMITt6ccs/wU/04F7olOEg4AlHEEGnzqjVuK30ymhKQDNG3uGJuSb6zP+ncvVlnzb05Nm1xySoCL7xe37wNdu3reFKLMsYVEynIuUs3d+JfRFVGN0t0nEncT6IhLgNHWfwpi1hE//apWCvd/JQotC2TifWz8mG+CT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509542; c=relaxed/simple;
	bh=Fh52x4Vt0BpyOjAih35iTF09I10Gnxn7njczCHjHsis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXMkGa39/ujw4G63i7bi6RAzgPlrMWiYEfHbuWL+1NdzbICmNg6XBfYEfGnxPuwlibgR7ryWM2Ackn3k1SDtKWpTiKu5YsXBmaN7j1I5eXwCFLObK63oj/b2J/sCCkGluSlU/AFOc+o7/Ux58NTraKRF1K41ykhhFmFtQVb4DY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijaMb2bP; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caea3f742bso9738435ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 04:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783509541; x=1784114341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dtrnVdmp8xU1FJJT2ghOauXbPCWLYJ7jSo2ML1ydzG0=;
        b=ijaMb2bP+G8IIYtBQype3Fe+aurN7UpK3wHD9cHr+erL3A4qFPgUHKmzoCaY33QpqQ
         L6I+JdgYgPxkPt4Xk67wG0TLkq8t7PXSpeF2JIlAOW295HiKVFmUVjoqtYDgh0yFlWc6
         vNAu7O0Uw4q26QaDTO/+shdA8lGLtx/eaCe1qwCJ6E7X3LryhdsmbZMYVQX1QMnt+Z11
         Q2iSOe6bLsCV2OLEn08RXdMY5qo1eEylQHQelw1Muc80/jbPAwqOb86iO+keGgaLWW6Q
         m0LGX/KRESOf7RUuEd/oRsP8xmJMvjJZtevMSo9eqy5oGGccGsADxhsOpfJH2WFSNetl
         vYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783509541; x=1784114341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dtrnVdmp8xU1FJJT2ghOauXbPCWLYJ7jSo2ML1ydzG0=;
        b=bwfNzo+pQSrtQfxs2geWnvapX6NxZGGk7Mt7GSaxYFUIUFaqylsaCzgN8RnOAhAD8z
         jyDzSffn8oIEauHBl7SnixU6kyDTKg5azI4mnS09MMRnjPxRxPYSk5nrBVS9rY/aZGMI
         Th9i7rOd8mPgaN2fvgQnDx3JnlkiY37DaxLUk2J0W462Mv+RNECHrhxFBW3LuPajnwSB
         pVcp8k2IuKbgNrbchAhfhCKR3QFBQeklCsMV4RKOdnSIxFkCd8G5jJEOEasAr8xVGLUv
         FCzSzU7Ag3yrNSgIVV5RG2tUKuvtK03Nz7IAWkJ/qrUivMUmHQRDPLLtmp3hs1HM9lKq
         Eigw==
X-Forwarded-Encrypted: i=1; AHgh+RqopDwAE4wGYj3Ce/k8f657V805q09CmGHxymfbDNKg60i/fn/6Yq8mK3hUVjRM8WtpSWivwbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJgGxup+p0NCkQuk4R7lUa/KLBra1/L7+VgVaMkwUQMamn64u
	fQDYKdereXzgaMFugLiT4+Iln7K1pFc8PYFcYozr2p7Yeye/89I4I1Hi
X-Gm-Gg: AfdE7cm6PPTKVeRHGEbuHg+Tm93+D4pacbS7y62hmiMBrSoaSX+8EWTXW3KK+r5ZnZU
	xj4T+EBZrpeuwBDU0TMDu1A0HIbXFV4/Kf2ApRWt7vudsv0DV7iysVWhyZ9fyalOTRjK4mwni0O
	QpiVNPrjQjYzOBZBZl0Cmua1cT5P4wz11dXhK3rk74N5hTqLPr9mGiykLUiEAeDbbxpxC2/aO6y
	vLgAnQrF7WcKq98bBiiVIeBzpX7pWHiV9KyKcZg2qxSmb3DLhPGE7eXo1yN9PAHkYwHbs2HVDBh
	bO0xce4hO2AJBt/JYdIjYHmILpk9NWbrkhlsGTAq9uDnvcIwH4VnLvDdJgxYYcC8vItpJc/jnw6
	eu0eSdkT5Z24bfyLTCMXr1AcX5TRG7xLpJWFuZafi4fZeL9O+7crLIwhzZxsj/JmRaYgCxb/hcw
	bOqNawZfvxGRS/PX9yc8lW
X-Received: by 2002:a17:902:f547:b0:2c9:cf41:adf9 with SMTP id d9443c01a7336-2ccea5aecd4mr24313285ad.47.1783509540668;
        Wed, 08 Jul 2026 04:19:00 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d968sm26108005ad.60.2026.07.08.04.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:19:00 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] dpaa2-eth: put MAC endpoint device on disconnect
Date: Wed,  8 Jul 2026 19:17:37 +0800
Message-ID: <20260708111738.750391-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305775-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ioana.ciornei@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lgs201920130244@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 798FD725EA0

fsl_mc_get_endpoint() returns the MAC endpoint device with a reference
taken through device_find_child(). The Ethernet connect path stores that
device in mac->mc_dev and keeps it for the lifetime of the connected MAC
object.

However, the disconnect path only disconnects and closes the MAC before
freeing the dpaa2_mac object. It does not drop the endpoint device
reference stored in mac->mc_dev, so every successful connect leaks that
device reference when the MAC is later disconnected.

Drop the endpoint device reference after closing the MAC and before
freeing the dpaa2_mac object.

Fixes: 719479230893 ("dpaa2-eth: add MAC/PHY support through phylink")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 9335703768a9..764d2a09668f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4732,6 +4732,7 @@ static void dpaa2_eth_disconnect_mac(struct dpaa2_eth_priv *priv)
 		dpaa2_mac_disconnect(mac);
 
 	dpaa2_mac_close(mac);
+	put_device(&mac->mc_dev->dev);
 	kfree(mac);
 }
 
-- 
2.43.0


