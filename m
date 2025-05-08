Return-Path: <netdev+bounces-188876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FB1AAF228
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 06:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18BAD7B6691
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 04:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368B13C3F2;
	Thu,  8 May 2025 04:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Wb5vANw1"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A7B79F2;
	Thu,  8 May 2025 04:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746679594; cv=none; b=huGTRA3kqEvCgsMZTvPUbmTwkWFaeBRQMRNCzQVOE+wQIIaVNzQkN8QGQxXVELzlzQzb2MNtjo0+ipVq10buZZqAg+gdgSd6d52+8Z/voYczmQ6NRmbpwC30DYLrg7BB624On1RW1yZ++OvC1R6F16+fgyOOilgOz2R0F1Yf6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746679594; c=relaxed/simple;
	bh=iOwBhF2jWfxSznFO3EGfXN7A2okZzkQPd4jElYKwvcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f0yhJDw3jDzNvdvi+NTayliU0WrlUh1uwz/2XPR9HUWkjp42hf5ogJnUEZ8t2alv0wmcrbY4xSlmt0v5gf5J0X/bQ4PtAAXMu62KHXHmCdUBFvtLO8+6YfxNzxTVXjZZl0HBJg9yr2l59RY9VJKlAn7ej76PSIEBrmBJT431WbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Wb5vANw1; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1746679583;
	bh=GMmUu/KwVYsXb2KtVn2/87+3MnBtGMcwkJMD5WiBllY=;
	h=From:Date:Subject:To:Cc;
	b=Wb5vANw1Ixzb/5PMbBiXMONaNULgnMNSVK6SM5bai/5pIV6ahRj3ou4emXCAxRTPF
	 WQ8AvM+IQCBD2LcrD0SqQ9ecj0Vd22IRYow91mTAVVPx5E9HWMqCcEMJQljM2BQHDn
	 JB9GhcWWtEqz6jMsxjqtdjH9qH6qbrhXoF/SMp5g2DgG84iOnAerTcwORPAbDTJWV6
	 x36JAtGAEerrPEKftOi+kIJjvXdOerKKgVGORbS7qqdtBGayIHfF8h2rH2W0vjlvat
	 LHCB16tS+JbC5VujFSU2GY6uLdcN43AZlGygkiwtYo0a58EXoPIbWE8tJiDKT/HKH8
	 9uGzMXoV9eJxw==
Received: from [127.0.1.1] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E602F6449A;
	Thu,  8 May 2025 12:46:21 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 08 May 2025 14:16:00 +0930
Subject: [PATCH net] net: mctp: Ensure keys maintain only one ref to
 corresponding dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-mctp-dev-refcount-v1-1-d4f965c67bb5@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAAc3HGgC/x2MQQqAIBAAvxJ7bsEMS/pKdAhdaw9pqEUg/T3pO
 AwzBRJFpgRTUyDSzYmDr9C1DZh99Rsh28oghVRCCY2HySdaujGSM+HyGWkYjZPaCaV6qN1ZDT/
 /cwZPGZb3/QC6QLrlaAAAAA==
X-Change-ID: 20250508-mctp-dev-refcount-e67cf28f0553
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.2

mctp_flow_prepare_output() is called in mctp_route_output(), which
places outbound packets onto a given interface. The packet may represent
a message fragment, in which case we provoke an unbalanced reference
count to the underlying device. This causes trouble if we ever attempt
to remove the interface:

    [   48.702195] usb 1-1: USB disconnect, device number 2
    [   58.883056] unregister_netdevice: waiting for mctpusb0 to become free. Usage count = 2
    [   69.022548] unregister_netdevice: waiting for mctpusb0 to become free. Usage count = 2
    [   79.172568] unregister_netdevice: waiting for mctpusb0 to become free. Usage count = 2
    ...

Predicate the invocation of mctp_dev_set_key() in
mctp_flow_prepare_output() on not already having associated the device
with the key. It's not yet realistic to uphold the property that the key
maintains only one device reference earlier in the transmission sequence
as the route (and therefore the device) may not be known at the time the
key is associated with the socket.

Fixes: 67737c457281 ("mctp: Pass flow data & flow release events to drivers")
Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
Exercising the USB MCTP transport under qemu via usbredir surfaced this
issue on disconnect. Devices on other transports such as I2C and serial
tend to be disconnected less often and so the bug remained hidden for
some time.
---
 net/mctp/route.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 4c460160914f0131f3191ca24dd51ec7a3fb8cc0..d9c8e5a5f9ce9aefbf16730c65a1f54caa5592b9 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -313,8 +313,10 @@ static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev)
 
 	key = flow->key;
 
-	if (WARN_ON(key->dev && key->dev != dev))
+	if (key->dev) {
+		WARN_ON(key->dev != dev);
 		return;
+	}
 
 	mctp_dev_set_key(dev, key);
 }

---
base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
change-id: 20250508-mctp-dev-refcount-e67cf28f0553

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


