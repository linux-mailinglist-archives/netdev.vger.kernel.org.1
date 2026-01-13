Return-Path: <netdev+bounces-249357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F459D171F6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C62AC3019692
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B1C30E0D2;
	Tue, 13 Jan 2026 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/WgJlmV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4121E2FDC30
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290882; cv=none; b=LhSeTWT7bL+lHzCRsrldoAtcUOOuq74GwAHhnAlrIzeOdIjcAHW2tVCjDCQK3yeDl0uj7E709M8Pclsqvxjsp9SXSPSJDFL//MzG8WTEBGA7jVU+4awemFiAHWWtxlSNvhqLtpp19UJcHIqYcQPUXg4D44Cg8ht/9jh3rqK1LrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290882; c=relaxed/simple;
	bh=mS/ImxgTIPtYHtUdYa5+DcwmvWKqjwrkf785uukIzKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtAEf1vh+5J7pqFJBx+j4MgaUd+oM2Fo8s6TW1IXPEJHHoq47U1OcqSMOcl4ct1Qvvvx0ZfAE8/Xk9nukAOR7zISndP+6NtzbsZcE2tCaWOyWj4kn+sLsvOweWCVxg8p/DsYt0Kb8Rh80QT29trAyskBLyzQ6u73sBzBXtTidCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/WgJlmV; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-11f3a10dcbbso6564645c88.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 23:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768290880; x=1768895680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuO0PG+ZQzuLZ5RUQqnVTS6xiXIubFViGec4PWXsLyo=;
        b=m/WgJlmVH308WcAftwEuRQIGwuzST+vETpxtJb6ZxlGHnI/HqRBEmz6ywZBvTtt6Q5
         0RUhwSOl6YrNcfl/IcO16UsY/31fknf3cyo7gcW9L4ryG3LR/wmCewBzpJCSdESZr4Ji
         +M0EbXKNpZqpr4D68qeXw2s630LQA84damqoF5YXsgG6KCXtnOpik8/1kLXeq/iQvQ+M
         JVbkxSUj6pAzz0I+B/UmWy265JhaidTTu7+sQGSKSLEq9t0ZDPAfpY6VrWmqRZ5khwit
         T92RDnx5v6KVuPlbF142/9MhcvVZlcmJUQgKwswEQheTbJoy7Q9pnR4v7se60tT0tg1I
         j4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768290880; x=1768895680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuO0PG+ZQzuLZ5RUQqnVTS6xiXIubFViGec4PWXsLyo=;
        b=vLKitYledAysJZlbrLNCPzwOEhp5qmXlZKcSdQZN3cKThaMnUUz7zahmHp09zVrBLo
         UIlz4TpxuexjELc/5fIJ5uodVtkknZMQURiPUlHqeZOeXm/afaI5bCAV37+Dx9eR/g2C
         SMiR3ain3sLcfyP6DoBKKL4fY1XJPW8A1myfGpPgvj95THk7XkZc2Wp0vhla1Ypudo90
         DhiuLwiHXmhhqRRvWYmZLPYlZgW5QhXW6EPg5L/SKDqw4RC004sGCDwCrlX1Qw1Oxa+i
         08oewahz3GzJW+14Aeqzj9H/LBmylF4pJrp7sfNA1p6FcbSanTJdEMJkCV5lcliDzPDv
         kMCA==
X-Gm-Message-State: AOJu0Yz1Tp0GVkyqqJLQEDJAyUHa+EMrCxBv+jX0xlimsRRj9CzdtoRu
	zT9dN9aOP8+1zxBj+vyQQF+VPxi3wj7ZHN0V+oDc32PzqlROe5W549z0SdGIUL9I
X-Gm-Gg: AY/fxX7ZonwG/ch9gfol7CqQdCK5v+lAAJ1XPwDrbKyCjiPxsZNJZJfsqoxEXB4woZS
	KUbpo5rCKl0Ud7cOsLnaOdcpt6zjnu6azV5iOiF8BoL+m2iSpt+XLfiKRpbUkoelkKZELySaBGB
	O44noGZibfQIdME1uKuUTvD2xic52jCn039kVYgEp93GBA4+T9Y4V26q+Vfza+03tW49mSV/Q5U
	MOWmqUKKiu7SjSwVLWBGFMwqsM0hTC5iCG0f3SaM3ekiSlGS52Dm2uS48ez9QyJcBoKCTRdAflw
	c8c537qQfKySZ9CskLc+DSGMQT5EzwLUpPMXU9/an4C8gBXKv5qLxSVEne3mBeIF4XKcuTzjDav
	90PHRJRPnqIlElHYhZ98zc3GpFoMmrWQ329JSj5w7eWCoRwHalmcf4aksOHv6bNW04sHaYfCvGQ
	GlGuMf4cXRi03wzegGv8OgQaqzaI2RIWOz4xqQmJdu5Bhbta0nhN7nK/Y/Jx7n1XUNcou8JFjc8
	lfA8UxIoamMbe+4kq16z72wqWusZlr9SzkBRlDP8vKVWwVEPNQ3pDWF+htECnySA6maKbP9Zajh
	Ecm/
X-Google-Smtp-Source: AGHT+IEtGVA2RgxpZWzfCl72bC4LOBfDTppM9kYSwY0A/WyalYIfn7eXGCw5y6PKJ586/rRp9GZkYg==
X-Received: by 2002:a05:7022:3d88:b0:122:1e3:5356 with SMTP id a92af1059eb24-12201e35552mr8557633c88.29.1768290880248;
        Mon, 12 Jan 2026 23:54:40 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f2434abesm26901889c88.4.2026.01.12.23.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 23:54:39 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: usb: sr9700: fix byte numbering in comments
Date: Mon, 12 Jan 2026 23:53:21 -0800
Message-ID: <20260113075327.85435-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comments describing the RX/TX headers and status response use
a combination of 0- and 1-based indexing, leading to confusion. Correct
the numbering and make it consistent. Also fix a typo "pm" for "pn".

This issue also existed in dm9601 and was fixed in commit 61189c78bda8
("dm9601: trivial comment fixes").

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/sr9700.c | 42 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 820c4c506979..bd90ac40acdd 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -391,20 +391,20 @@ static int sr9700_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	int len;
 
 	/* skb content (packets) format :
-	 *                    p0            p1            p2    ......    pm
+	 *                    p1            p2            p3    ......    pn
 	 *                 /      \
 	 *            /                \
 	 *        /                            \
 	 *  /                                        \
-	 * p0b0 p0b1 p0b2 p0b3 ...... p0b(n-4) p0b(n-3)...p0bn
+	 * p1b1 p1b2 p1b3 p1b4 ...... p1b(n-4) p1b(n-3)...p1bn
 	 *
-	 * p0 : packet 0
-	 * p0b0 : packet 0 byte 0
+	 * p1 : packet 1
+	 * p1b1 : packet 1 byte 1
 	 *
-	 * b0: rx status
-	 * b1: packet length (incl crc) low
-	 * b2: packet length (incl crc) high
-	 * b3..n-4: packet data
+	 * b1: rx status
+	 * b2: packet length (incl crc) low
+	 * b3: packet length (incl crc) high
+	 * b4..n-4: packet data
 	 * bn-3..bn: ethernet packet crc
 	 */
 	if (unlikely(skb->len < SR_RX_OVERHEAD)) {
@@ -452,12 +452,12 @@ static struct sk_buff *sr9700_tx_fixup(struct usbnet *dev, struct sk_buff *skb,
 
 	/* SR9700 can only send out one ethernet packet at once.
 	 *
-	 * b0 b1 b2 b3 ...... b(n-4) b(n-3)...bn
+	 * b1 b2 b3 b4 ...... b(n-4) b(n-3)...bn
 	 *
-	 * b0: rx status
-	 * b1: packet length (incl crc) low
-	 * b2: packet length (incl crc) high
-	 * b3..n-4: packet data
+	 * b1: rx status
+	 * b2: packet length (incl crc) low
+	 * b3: packet length (incl crc) high
+	 * b4..n-4: packet data
 	 * bn-3..bn: ethernet packet crc
 	 */
 
@@ -488,14 +488,14 @@ static void sr9700_status(struct usbnet *dev, struct urb *urb)
 	u8 *buf;
 
 	/* format:
-	   b0: net status
-	   b1: tx status 1
-	   b2: tx status 2
-	   b3: rx status
-	   b4: rx overflow
-	   b5: rx count
-	   b6: tx count
-	   b7: gpr
+	   b1: net status
+	   b2: tx status 1
+	   b3: tx status 2
+	   b4: rx status
+	   b5: rx overflow
+	   b6: rx count
+	   b7: tx count
+	   b8: gpr
 	*/
 
 	if (urb->actual_length < 8)
-- 
2.43.0


