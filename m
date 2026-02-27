Return-Path: <netdev+bounces-261874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOvXMTC0oWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:11:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 241991B97B5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 392813092084
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B37436343;
	Fri, 27 Feb 2026 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="QH80glPb"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC342EEC3;
	Fri, 27 Feb 2026 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204929; cv=none; b=Qx139c0MyH7qCH/gxNGcyyolIuMYn/omajrRAqB6ozu/kRjLH/0ZWsOn5Ixm90PEBeiKih6LqeUetAUKFNjjTwZeONSJ4bnOVBgomVYVRKsnycT1c+zV3XuYxxXW0YxrWAX6IeXv7SBjAEHEOe5XrXo/aVzYUopxLQzK2dPmgLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204929; c=relaxed/simple;
	bh=ZPK0Z3oJzLp5z+yIV5jrJ30aG+zF/bTYYWFChZzHvlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2qjHjknYNFgPFi7bLQJqUmttXWBs9C4hv6BWeCBCqIc7L/mTUr1+C6ZBf/3BCZVnourOvtYyxwQAS69jrJKD6PH9CQzo79S7p3u8hSDYjaHO/n7eMVq7ghM0E7OQj6zaZoMwaJp/himi2I9XpZcsuhm0/+mKjtUhErnf3Q9zEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=QH80glPb; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55F5BA5007;
	Fri, 27 Feb 2026 16:08:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772204925; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XUWlS3K11Yw45ldTqgq8qbaqscSO6wYBy4epMkSa2kU=;
	b=QH80glPb/jUHmBW6icYjEpABRJYcW6se1Af4WhGbMPCB3O06v9tOrBcCJUv5byq/ZBApr2
	HDpue/lI0/XO9JcgkLGt+uiN47/j4zyfOVckj4Sa/gf3XsUT4+3vxbraOCNL9wKc4/1z0j
	K/uGhtNBPcF6ZEjin0GsuQGbx1hIyqIvcjKZCKBF1zPqTmBHcGjNnkEYw/xWhfxvFyCU7W
	MSA8gLcjVUXOhrp7n3zYNWVBs791tmWEKnsppVVOXXZ69cfpXBPz4WfW+IfDYmIKaJUL7j
	w4a/GLMjBjvB6ueqKE3jxzsS9ZfUrJGhLPcLicEtrI6MPxbq264guCTFFaqqPA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com,
	linux-kernel@vger.kernel.org,
	theo.lebrun@bootlin.com,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v5 4/5] net: cadence: macb: enable EEE for Raspberry Pi RP1
Date: Fri, 27 Feb 2026 16:06:09 +0100
Message-ID: <20260227150610.242215-5-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227150610.242215-1-nb@tipi-net.de>
References: <20260227150610.242215-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261874-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email,bootlin.com:email]
X-Rspamd-Queue-Id: 241991B97B5
X-Rspamd-Action: no action

Set MACB_CAPS_EEE for the Raspberry Pi 5 RP1 southbridge
(Cadence GEM_GXL rev 0x00070109 paired with BCM54213PE PHY).

EEE has been verified on RP1 hardware: the LPI counter registers
at 0x270-0x27c return valid data, the TXLPIEN bit in NCR (bit 19)
controls LPI transmission correctly, and ethtool --show-eee reports
the negotiated state after link-up.

Other GEM variants that share the same LPI register layout (SAMA5D2,
SAME70, PIC32CZ) can be enabled by adding MACB_CAPS_EEE to their
respective config entries once tested.

Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3e724417d444..0196a13c0688 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5529,7 +5529,8 @@ static const struct macb_config eyeq5_config = {
 static const struct macb_config raspberrypi_rp1_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_EEE,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-- 
2.51.0


