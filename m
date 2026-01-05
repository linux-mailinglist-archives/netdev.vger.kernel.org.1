Return-Path: <netdev+bounces-247055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1FBCF3BD2
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2823030215D5
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 13:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244729AB1D;
	Mon,  5 Jan 2026 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H46ayQbX"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664B288C2D
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618518; cv=none; b=q7oEmlpHTA1YdW+D9ktTaoLEUZhxPBpwBuqS5djgOuy6IHYdALHqvJw+sETpsgQpGxlH3aVXtG5xB63gOOaiO5E2JmHWFCzT9YLh/ynrVRUwAs4g3eu+zXAPkm4b+ZbfwWJjslRvXaBhiMHMguVLPo75RLuVUKgGrwgXdasPsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618518; c=relaxed/simple;
	bh=9QcjWnONpAVaP+Tie1zlDsm+KSktyvQl0mlt6LXj6hM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UANdM6TOBA4JaAVCNZN/SsreC3OfZ/Y0lTak0uSUphg3qdPV+WHb1HtaDpDEb/YvLNqYjFdCLxBZ9BjdakFJ26oU1nFt2s6vleSDhYXcaqEc+XuRFhRU4PFDwos3/u7VHQj1IjX2M/fapxUYMZvEe2HGigECDPFpM5OZHQWXKe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H46ayQbX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 15A84C1E48A;
	Mon,  5 Jan 2026 13:08:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D15C60726;
	Mon,  5 Jan 2026 13:08:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B28F4103C8531;
	Mon,  5 Jan 2026 14:08:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767618514; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=25UrBuweM9vQ3iWdNpe4Hggb89zhueLdPDwP/UNaNP0=;
	b=H46ayQbXqGWdPqKFRz/PZiA9RYL5dQL2gpTuSa6Dcm35cVMAhqpCRuCVOzJsjv4ft53DZo
	ntXYJoEjti4XgVb0Qe5Dq4nLJsrgdxh+3ro0FMdeLUpKKxvo7qc8KftXcGv6dkDVs4F4zc
	j9oM0V4dR9xXIKUF1BPNLNBamP1RKBSiVItsu2fVkxjEMmAf/IdsmnFIUoE7FjwcAglkMa
	o4Rk+8EU8i07qgZJ6bYLUzcqbJ0yDX7D/IVzsBe5Xvm/dBm3DeMN+E0xU0ZeAxL+ma2XVR
	JvypfKkN3DCufknO2kbxbJN4JgZAa6J3BSXkIbApZ01RfHXRv8XvQwSCGVPZ2Q==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 05 Jan 2026 14:08:08 +0100
Subject: [PATCH net-next 9/9] net: dsa: microchip: Wrap timestamp reading
 in a function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-ksz-rework-v1-9-a68df7f57375@bootlin.com>
References: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
In-Reply-To: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Timestamps are directly accessed through a register read in the
interrupt handler. KSZ8463's logic to access it will be a bit more
complex because the same interrupt can be triggered by two different
timestamps being ready.

Wrap the timestamp's reading in a dedicated function to ease the
KSZ8463's integration in upcoming patches.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index b3fff0643ea7a63aec924ec1cd9b451ecfeeab3d..4a2cc57a628f97bd51fcb11057bc4effda9205dd 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -967,6 +967,11 @@ void ksz_ptp_clock_unregister(struct dsa_switch *ds)
 		ptp_clock_unregister(ptp_data->clock);
 }
 
+static int ksz_read_ts(struct ksz_port *port, u16 reg, u32 *ts)
+{
+	return ksz_read32(port->ksz_dev, reg, ts);
+}
+
 static irqreturn_t ksz_ptp_msg_thread_fn(int irq, void *dev_id)
 {
 	struct ksz_ptp_irq *ptpmsg_irq = dev_id;
@@ -980,7 +985,7 @@ static irqreturn_t ksz_ptp_msg_thread_fn(int irq, void *dev_id)
 	dev = port->ksz_dev;
 
 	if (ptpmsg_irq->ts_en) {
-		ret = ksz_read32(dev, ptpmsg_irq->ts_reg, &tstamp_raw);
+		ret = ksz_read_ts(port, ptpmsg_irq->ts_reg, &tstamp_raw);
 		if (ret)
 			return IRQ_NONE;
 

-- 
2.52.0


