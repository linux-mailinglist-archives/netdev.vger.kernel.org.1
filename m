Return-Path: <netdev+bounces-170041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213C1A47109
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 02:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD10C7ACB44
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 01:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C229017A2F9;
	Thu, 27 Feb 2025 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bTP2q3ej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE216F8E5
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619366; cv=none; b=IOnBIji2CPQtGJIjY5oJCS3hYWHzq3PbXnFQr8NLW/0u55U9b3CN7oFlBlHShpOAm6Erv7NLSIqjnPbPvaim0Bv/vojvm7r+bOg5B8pIrBOqEvUdjzt1Uc/pHfrAC6W6DKi+4qFT8fkG3VHutbWcGZMhUSI9Ro+lwoYmOlPUwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619366; c=relaxed/simple;
	bh=/xvou7dFKioksUHeuOvCiwiW+/ZP6NzsNB7blkKp/EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RAosef1RZxcGxYgmba+XvOrBzgTXDo50HARNC8K81omWqmAczN/f8Vp8Qirvk5o2wQg6XChzP4i5o62GyJYoP0n1GxbNy6QlMSUgc3YuFZSJJBC/Jc6nQ4hnn0Wy0bvZTaQPWDs9gNzwLNumVLI7z7PDKerNv08SsYr0bQnwG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bTP2q3ej; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394a823036so4287185e9.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619363; x=1741224163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9I2Z6bR8zx1eteSpHnDKlkOmZth6MLuc4W0LAKMNv8=;
        b=bTP2q3ejhb5ibCORIREbHYI9nyChOFnaEMi0eBVN2ckldF6QRuo2sWupPHZUikBy+y
         KR13QfQir1inq4BQaZz/MY3Csu6uius3m0tgsu/AK6vG1eOgAwKEtUHCv2joqQxyQeAF
         P/c1en4KP+TpmP6CtgTh89N5f0g4gNQ1hu0e0U0tZnvMa5WnKhjYtD2GWtxsvJWoubuD
         P+7ND9MNK+k4HqE4CKs6DHyKJNONXHxRq26kzNZwfqoRF/Cz1f1VtfksLbG51paa8KGW
         4ZjiUIe3BqX0xmV+Jg4XgQeb2NrRo+NWy7XdyRkhGbqILg26djCbvum433XVbdtT0vR7
         FLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619363; x=1741224163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9I2Z6bR8zx1eteSpHnDKlkOmZth6MLuc4W0LAKMNv8=;
        b=Q+dwpsTiakrMjjSYqG3ucnXFU/jA6ue1esDE6ddBuNl03S4rfzRYlw41Qn0bRZZ/P7
         mfYoYoiVHzVVTFPZ18PtLfNFYa5TPbAB+xQ1yqwQUgpxJELLhWw47QTk8BVKcxIETI8v
         2QqBuXa7BeAKGCv6R5YEoTz7Q1sss3qg1SBQCFVOlweE0Gkn5Tsy5nRslpEKSckn4fB1
         Fa4rPdfuMW8VN3CM5Ef7Xn8cF7HTWtxsNJSow5MB68PNRzTStHVoMmCZ8K8Yu080gVtW
         dn3M6ys6L8IubZTnxl3jqol+GcLciM1U1RCbAilPMTFa7HPFO3coI3Kp64odh+Jov/jx
         AI7w==
X-Gm-Message-State: AOJu0YzEBcH8NQtvFQRzpcPTRmyJ7ohy46JRhuUD4ihRuuS8CrewlIIZ
	urjK9llcvx43fYrxJ1leJlJ12rOzXfEQs9CWmUmOp9/1vxmo0MkyBvDL5fpASXo=
X-Gm-Gg: ASbGnctWDeYhbUvMC7md6x5V0Z+uC5p361huFSg4Dmj/hGFVaEJIL/dyArsVLsMjh00
	CxP9acZ2sQUYnsTCLpS5fHH7FXCWJzDaDjUoCpLJQEEPPoKbutfOqqydE1uDbg5ZrNYmaIbwsHU
	36G0hFp7/a9ZOnBCaIqh8XIvI4wXIwG3psmU2rv7gvd2oB0Q0J07Gph6rCQok5JwfCAsWGxQ3Qr
	Iwny4fUzyt4ECCa9YKf8WfG2Vd/PbVDwUfGQt6nzB7ysXMa89Gw/1poWrQsg58VWTNzE6/Q6mjW
	/6B2DOE0qQSHiYR9HVAeiEMTeIbCZuEbJvBtbw==
X-Google-Smtp-Source: AGHT+IFRLUDD/JOdpbzWNvpECDdSlVrGNdcjVZwvbaHqQExjq50/llPLnt+vZkb7y+W8izkVyRixtA==
X-Received: by 2002:a05:600c:1c90:b0:439:5a37:815c with SMTP id 5b1f17b1804b1-43aafab940fmr90711725e9.20.1740619362692;
        Wed, 26 Feb 2025 17:22:42 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:22:42 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:30 +0100
Subject: [PATCH net-next v20 05/25] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-5-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=/xvou7dFKioksUHeuOvCiwiW+/ZP6NzsNB7blkKp/EA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75fnpsyCwFTnzjcBjb1zy8QSEzHE73ta9V+W
 Dp3cCEdgjyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++XwAKCRALcOU6oDjV
 h7sdCACdPdoSPcr38UMh7K0g661h4eBRoeGspDeqtmchcLTRv8cCBfP7WBIYcWdyWyBL0taQ7FO
 rOeiOO7VTqo0kAHexONFd0NGl0AEUp0rGR62JaNzyw3vLD/n00r2JwghQdyvQj6f0vJ9Xynh6F0
 1inzICvNLx4cdIrEhUPE9fFlupo6B3lWUbZG2wBl/jV9LEt9qvYS2txHMSDrwGNHN5tGPlMyU2U
 YJMy8yYNFXbezA954w0FrV98WOCcUiGUWYSh4fuhNPBDn9KDI+7dIj7akHqxH8r3EeVswCDSQWt
 c9fZdtgL9Pl45gESZbfaIheLDXyD1KFxhb1Glc2McwRN5lUa
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index e71183e6f42cd801861caaec9eb0f6828b64cda9..c5e75108b8da5eabde25426c6d6668fb14491986 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -23,6 +23,15 @@
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.3


