Return-Path: <netdev+bounces-298530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +KDSHlDKK2pFFAQAu9opvQ
	(envelope-from <netdev+bounces-298530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:58:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC34678010
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:58:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=KQIgUEjl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298530-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298530-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E943131590
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EC23750C4;
	Fri, 12 Jun 2026 08:58:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77389371043
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 08:58:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254694; cv=none; b=l8BdkfesfIORPdZLAF/mbEzewNVqBmomLNhcu3CdUL3x4poNGzaCfsHpeVE6lzLSgtU+hQRceWRAk8Tek/sxgrTgoekCYp1+MZF+UwnKSpzhujz/9mAGxZJSBd3mnm8qYpJPRw1ac/uZkefXmdyATWzN0i4bF1m4Xsge+4dlBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254694; c=relaxed/simple;
	bh=YyxatfTtlbsqlrw5V/DZdQbEXqOeFOFhkfd6t5wI/I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=el5Q47c8Gs9mgxN5z5Vu+kUVYzouANhwuN4XkSFF82ql4pnIgH6PcJe1JAz25otX9Xdq2tv4A33tgDBCS0Uy1dZ8bCqecOD+uNplAJDOy5BhqoPlTgBs1nqELEhc7RVA4HaRdrl0yGyoQJ4DLWZgbYfVkV1SosNFPr+szvsUE9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KQIgUEjl; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1135333f8f.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781254690; x=1781859490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+NwWNik0A4yQLnEFTlSBrclx3QN6Ei0fyFFruwyw1I=;
        b=KQIgUEjl9/1IA4O/pmX/iZkJ12iCsoSxytAD5Mj31I1CpLnQm6zSvonqSvtO1Yt6de
         tb46jaiVnyVnCfRnruHAJScQAxiWwr5YNgz8BmkSxF4R/QWdliWzphNEaEFAlaDwemKL
         llPqwENjQm7K2lcI116Y9SVxywt4B/aLbQ48mTh93RGy4Au8+ZS+FYG2tOigwfysh/Lb
         GSjw0lrl2sZBSb3CNyR/UMXbiDGS/NSNEv4gazKEOLqQ+l4FiurBtKu/M33RHenIwMBJ
         bVIru+TzoJwIW6nokZFCYYECOHEe/Gbcw1M+jnG0DzBEfrkaDvPs1fLrCHkaU8vWZbja
         b+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254690; x=1781859490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+NwWNik0A4yQLnEFTlSBrclx3QN6Ei0fyFFruwyw1I=;
        b=Js7YrlBrHYU7nMznN5HonTOTvIZDU45vnrA9vTXkUYtP7NZIt64u1dsP+/GSY3PFM0
         AtDaj93HYcXBRm0TWO+qIj/v4iY2ca2oPXM5rCDKp2IvLdQHtcEu1dpYBzd4oas1GO4t
         HBWc8TSjM1dny9rJvyxF0/bwp0L5HGKLgmCWNIkeW1Fh9I5+afXTRZmp1MqeFD+B56Bl
         au4yhLICzEbpO0Dx6s01akLCxt+KvKRLcXmsV+HLb/jhnE+jM6CiN8zXO9cx1Ed0fGtg
         GJvaJAhyF0puiFflC3Mob7WuICyZUuhd7t89FrYEgmqt+XZ5Q+rCSyv83u41lFCtSfsu
         ed6g==
X-Gm-Message-State: AOJu0YwDeU84NBAXXEG8cWc5UOtgdbvTPdBPQkVaQXXZWvx+tJ18xyxb
	l4JCLkfDwQ0Esi3io0qN8Vlh0uDBlGfqZ+nQlibVtHyfpQ2jIq9x9fnyD8hencJj+YiNLqRMO6I
	aQhsJFRo=
X-Gm-Gg: Acq92OFbKu+bdZ8qfpOnsR7a9zIOW6Ni1dHNpKq6uPB7z/UullOgVFTmGAMJT/o/meC
	Pr5WtjAV9mFUvN7B/Qi4A1PqdO6w3XcZSE2NF7Humk5Dj1x8zWW28FaScsOzKtRxr56U2Je0Nup
	rCloR9f8nCyFmMiSNcXLcrY9BOc58O0rNlQ8xQj6sjS9nKJImEkS62IpQy/ST27Vl+LszSJnFrB
	aGbgPwGKlspHPxYQ9CVMP+iCIpt+AB1MzV/msZ1Qu/gXGflRIiiYKZO5MISgzuKjmaEWzVQdX1T
	oczq90x7AhlH++4lmOZufkR0dxERLgjedOZxZ5Wv16X7mk0kvZYaQCJkjiUxhG2EDaEMSDR3EGp
	HM84xDCyEIiMBNVgcY4oU820Pf93pi5XZaF9gS0VDFEhnKKvxWcNM6nDJy4h+N5x1ZP2FvYL7gY
	tBShPp6h9+utEZA/vIjBaZ
X-Received: by 2002:a5d:5848:0:b0:460:1c93:6eb6 with SMTP id ffacd0b85a97d-4606d0239femr2743763f8f.20.1781254689774;
        Fri, 12 Jun 2026 01:58:09 -0700 (PDT)
Received: from localhost ([195.94.146.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0bbfsm3828193f8f.23.2026.06.12.01.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:58:09 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: netdev@vger.kernel.org,
	Theo Lebrun <theo.lebrun@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org
Cc: Lukasz Raczylo <lukasz@raczylo.com>,
	Steffen Jaeckel <sjaeckel@suse.de>
Subject: [PATCH] net: macb: add TX stall timeout callback to recover from lost TSTART write
Date: Fri, 12 Jun 2026 11:01:26 +0200
Message-ID: <771b8faeaee1fce4a84a5ba2661d60b35a65a6d5.1781253818.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
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
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298530-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:theo.lebrun@bootlin.com,m:andrea.porta@suse.com,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rpi-kernel@lists.infradead.org,m:lukasz@raczylo.com,m:sjaeckel@suse.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAC34678010

From: Lukasz Raczylo <lukasz@raczylo.com>

The MACB found in the Raspberry Pi RP1 suffers from sporadic stalls on
the TX queue.
While the exact root cause is not yet fully understood, it is likely
related to a hardware issue where a TSTART write to the NCR register
is missed, preventing the transmission from being kicked off.

Implement a timeout callback to handle TX queue stalls, triggering the
existing restart mechanism to recover.

Link: https://lore.kernel.org/all/20260514215459.36109-1-lukasz@raczylo.com/
Fixes: dc110d1b23564 ("net: cadence: macb: Add support for Raspberry Pi RP1 ethernet controller")
Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
Co-developed-by: Steffen Jaeckel <sjaeckel@suse.de>
Signed-off-by: Steffen Jaeckel <sjaeckel@suse.de>
Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a12aa21244e83..615da65d5d68d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4522,6 +4522,16 @@ static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	}
 }
 
+static void macb_tx_timeout(struct net_device *dev, unsigned int q)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	if (net_ratelimit())
+		netdev_err(dev, "TX stall detected, re-kicking TSTART\n");
+	dev->stats.tx_errors++;
+	macb_tx_restart(&bp->queues[q]);
+}
+
 static const struct net_device_ops macb_netdev_ops = {
 	.ndo_open		= macb_open,
 	.ndo_stop		= macb_close,
@@ -4540,6 +4550,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_set	= macb_hwtstamp_set,
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
+	.ndo_tx_timeout		= macb_tx_timeout,
 };
 
 /* Configure peripheral capabilities according to device tree
-- 
2.35.3


