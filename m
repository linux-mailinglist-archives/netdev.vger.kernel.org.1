Return-Path: <netdev+bounces-298794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1ybLEGFzLGreQwQAu9opvQ
	(envelope-from <netdev+bounces-298794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:00:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 918C967C693
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:00:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=0tzVjt0c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298794-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298794-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61D3C3183C1A
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB53E3793A2;
	Fri, 12 Jun 2026 21:00:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F0375ABE;
	Fri, 12 Jun 2026 21:00:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781298008; cv=none; b=atjfj/G7LwaByqJysKJlej89l+jbH6fbG94qmVpafRcFCw5gnC4Zy3cjN2orbzsTl2jBiCmaTcczUq9dC9rRftjH2i8iC6EDITPhVHrx9oEr7PK/yYvh2eF6GbTTPz1pn8AAehiah3/u1Yje423N3RWwQehUYZS9XbB2G9qRkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781298008; c=relaxed/simple;
	bh=KdHRTSDxsxSxKMGly9FdQAnP5B/pxArlmfPuJWSp5ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ+XkHsIkQXOJLc8xENMAadrcpqGA2IpnnuO5cBeqFUVjv6J/Z0twp1xtl7KJKS+drZPRULzIZhqfNOHgYvmzJVROmbaK9lOxLXREeo2Nyzlqtf9WUaZ8I7zfItSsMEBZypEKaSaf3S8Ys2goBikUfKCRvgONYOx24XWy+aDjkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=0tzVjt0c; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F27BAA4F62;
	Fri, 12 Jun 2026 23:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781298002; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=QsLxA9Nj3hnIcCion65GXLKmwk+sracnvV53FIRar9A=;
	b=0tzVjt0cRH71qmClu2Hcc5521f6FhvSdqjvB2cTpIUnNwJL3wN/Jhe7HbBKYPbh8kJvc6y
	Ri+WJZrZBsp+Yu2jvbfHoNa9WiOzeERd2j2vidkOYXf0jjhjKkLbIC5qhuaBiy9AsAEWcE
	O8tH1E15K7WEPfGYAKwQmi9lPODWrW453m2cGMPgKv2XVcggIotUH8UhN/i2NUiY8Q3GYB
	r8o+W52Cv7tkl1Qdca8eKsEBQlVpQ5aw7quPy0TitZGbeUFwT+e17Cr39T+Mm7kIpPksLp
	odt2sHt1WqwBu4NRpYO52C6Un/e8TihHzhxkhTnuTENL8Jabbn7GfWk6S8DM2g==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 1/3] net: bcmgenet: collapse TX priority queues to a single queue
Date: Fri, 12 Jun 2026 22:59:13 +0200
Message-ID: <20260612205915.3156127-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612205915.3156127-1-nb@tipi-net.de>
References: <20260612205915.3156127-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:justin.chen@broadcom.com,m:ovidiu.panait.rb@renesas.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-298794-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 918C967C693

The strict-priority TX queues can starve under multi-queue load and
trip NETDEV_WATCHDOG. Justin's earlier series [1] worked around the
symptom but kept the design.

The multi-queue design was originally used for STB use cases that are
no longer needed, as confirmed by Justin. v1 hw_params already
exercises a single-queue path. Point v2-v4 at the same configuration:
ring 0 takes the full BD pool, every per-ring loop collapses to one
iteration, and netif_set_real_num_tx_queues drops to 1 via the
existing tx_queues + 1 arithmetic.

Tested on Raspberry Pi CM4 (BCM2711). The baseline kernel trips
NETDEV_WATCHDOG within seconds under iperf3 UDP saturation
(-u -b0 -P16 -t60). After the change the same test completes
without a watchdog, and a single-stream 60 s UDP run sustains
956 Mbit/s with 0/4952890 datagrams lost. Single-stream TCP
throughput is unchanged at 943 Mbit/s.

[1] https://lore.kernel.org/netdev/20260406175756.134567-1-justin.chen@broadcom.com/

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index ca403581357d..c892734b4cd0 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3751,8 +3751,8 @@ static const struct bcmgenet_hw_params bcmgenet_hw_params_v1 = {
 };
 
 static const struct bcmgenet_hw_params bcmgenet_hw_params_v2 = {
-	.tx_queues = 4,
-	.tx_bds_per_q = 32,
+	.tx_queues = 0,
+	.tx_bds_per_q = 0,
 	.rx_queues = 0,
 	.rx_bds_per_q = 0,
 	.bp_in_en_shift = 16,
@@ -3769,8 +3769,8 @@ static const struct bcmgenet_hw_params bcmgenet_hw_params_v2 = {
 };
 
 static const struct bcmgenet_hw_params bcmgenet_hw_params_v3 = {
-	.tx_queues = 4,
-	.tx_bds_per_q = 32,
+	.tx_queues = 0,
+	.tx_bds_per_q = 0,
 	.rx_queues = 0,
 	.rx_bds_per_q = 0,
 	.bp_in_en_shift = 17,
@@ -3787,8 +3787,8 @@ static const struct bcmgenet_hw_params bcmgenet_hw_params_v3 = {
 };
 
 static const struct bcmgenet_hw_params bcmgenet_hw_params_v4 = {
-	.tx_queues = 4,
-	.tx_bds_per_q = 32,
+	.tx_queues = 0,
+	.tx_bds_per_q = 0,
 	.rx_queues = 0,
 	.rx_bds_per_q = 0,
 	.bp_in_en_shift = 17,
-- 
2.53.0


