Return-Path: <netdev+bounces-250239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E4D25912
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D2EE30F21AF
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F203B8D4C;
	Thu, 15 Jan 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oq+phQkh"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19293A8FFF
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492646; cv=none; b=DJk+H9DxAmge6iJKPpcG1JJPGePV2z15KyoGkEP3OAqe+D5VfXr9VRndbCsIw/benqTHZ2Y+z/FvbTtJVJV+DPcgFlxxKEaou5HiNmIBTxYAkpS0Y3c4iQ3AvyjaFWNePcbyfCIiVjUDL8g+WmA86rbBJZUywAKXyJC30ufxhpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492646; c=relaxed/simple;
	bh=F3x7ujt23LH7Hzb/IBaAvxfIn3ywNtT91s3EJRLMZe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFBGMnJC6tecTk713FUubrtH70UTNqC2O172ozF0FJ767taQLLoOZC/+sDEJnFtMYUBPy7S2ynvjCCkNe+wfiEiaQbHcScs/cUzF30v4ZhG+GU9kH5A/Akasc9rwqi6+mHehPHFzAym63QgyXls+UebqeGXJfRTefQMDHa1OM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oq+phQkh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C0B5EC1F1E6;
	Thu, 15 Jan 2026 15:56:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8013E606E0;
	Thu, 15 Jan 2026 15:57:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AEDB310B686B7;
	Thu, 15 Jan 2026 16:57:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768492642; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5JUfVn7/HeLWZy5Qd02a6wIWBDQq2NcAA2klS+MsO1s=;
	b=oq+phQkhXMMfEyCwWmZYheKUH1kbyF8FkR5nwOXB0nDq+pYa+JgXWWDVQu8GCKnAtz3qkF
	o62zSKfjJZ0mhrG31vxc+AiLxZv9m1WcWKiRIIZ8sArwzUj9CfNNAnh3pk6GU0aIdME5hV
	UtpM8gFNq0NddNoX4+3Y6qrSSe9WM5+XM6ZJfsP1XwMv1TBtbvHX9lXYL+wgsGgJ694fst
	MDLQTT+G9I0vg39oImGwCOttpx14lMouxyMvqUmVprMRobPZstr+BnaEMUjUrLdLU058DE
	YwzQ+cWrIaHRCZFPykZhtSGMhDYqxOWqwAatWtezf/mBFjkjK1nBy3Zz0RX3cA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 15 Jan 2026 16:57:06 +0100
Subject: [PATCH net-next 7/8] net: dsa: microchip: Adapt port offset for
 KSZ8463's PTP register
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-ksz8463-ptp-v1-7-bcfe2830cf50@bootlin.com>
References: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
In-Reply-To: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

In KSZ8463 register's layout, the offset between port 1 and port 2
registers isn't the same in the generic control register area than in
the PTP register area. The get_port_addr() always uses the same offset
so it doesn't work when it's used to access PTP registers.

Adapt the port offset in get_port_addr() when the accessed register is
in the PTP area.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index c354abdafc1b542a32c276ef939a90db30c67f55..a05527899b8bab6d53509ba38c58101b79e98ee5 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2020,6 +2020,9 @@ u32 ksz8_get_port_addr(int port, int offset)
 
 u32 ksz8463_get_port_addr(int port, int offset)
 {
+	if (offset >= KSZ8463_PTP_CLK_CTRL)
+		return offset + 0x20 * port;
+
 	return offset + 0x18 * port;
 }
 

-- 
2.52.0


