Return-Path: <netdev+bounces-228646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2463BBD0BE5
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 22:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1CDD4E1517
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AED205ABA;
	Sun, 12 Oct 2025 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceYVgSEK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5931547E7
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760299250; cv=none; b=fvOvZoQ8TtpxnY7H/wBVNcWnAAebDYzXZvlG0KwOIOiKvV0lhCUpJ7SymXUlCtSVsD5KlfDTFqb1l+gi9zOFRHYxsUirSfbcqPM1pFvbOfw1iMCZiJVTKAVlwghPZxbce51fPw8GGIeENH/tssM6uJm6FaH+JplVReayufgfmaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760299250; c=relaxed/simple;
	bh=gsR6VLtEWh7Ep7Ju4BrPFAE2zcsW59Ip654xHVUfQTo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HsvTLKG63/Tiz/fnLlkoeE44xDCYBgePGwYXb3eArFEzQcJgOLHwFilAhGTV6eIvunq/J2xfgu5IcZ+knVe8KrPfq7HhQDbgYl9XDuYf2hM5R72tM3gaFcoN89gFSLmQS8ilmq6jn00IfW9f04+1sf0oKVrltcyPoq3nxdpRhVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceYVgSEK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-639df8d869fso6744892a12.0
        for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760299247; x=1760904047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qhBizdbTK0z+OclNT8Vb7bFkHGH494w/g8TAfLl99kc=;
        b=ceYVgSEKYo9HQ2EpicwV4tUvownrShgL9CFnw7TjLMqZVb4cVGmmsfXJ3ZL5hQ9EJ6
         UHOU7t1y9Pstw4nMMzD1Az7YfwdtZTJevI+DoAF0s4JA4hIZ7ud7p6I9N/G0pbUEvImr
         orpryvnIZB0VwJYvM2ku7dnLgH6KfuMkAKqaRyJ0EEX7TrSE7YEDgG6LEoMmlUE4MeZM
         m6Uhfrp+lbu//GPKKRqg/opq/KfJp3jJtgrZ7O/9FsN6yiRVCiiKnLjJq0BaAiUytpbG
         RuRP1T/r+rTiXTa8NS7VORrQLBMyyfdIk9FambNx+GtjBT3sydNVGLWZOTmqFMdxfljl
         dVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760299247; x=1760904047;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhBizdbTK0z+OclNT8Vb7bFkHGH494w/g8TAfLl99kc=;
        b=B9jVC28e2AcHf8hY7Oe/KbNA32vxx8CQFe75EIEkDzpzqGAhuquPxgbmdOYW50sq/o
         ubka+nB9KGo657QiJDLTM7JYPurQ1f74jNuASiciOgHcA9w4YgaU46pgbiaJL/+aNZYW
         GCMc5NHbLbBiJxMXRSkJvDZ6KdUGiqNircdLONtzRWzziQU1+Q5nuqtZMz0t4dW33ZF8
         rm0JznYK3jscSAHyRk2GKG2aTWklSKa2JPOPkOK8Hjio4pt0+DhC3VpKFb9y1ZwEmEdo
         t47vO0KbYOTM/bEwJDXVXMDpNlWdr8l87ObFcJeJx2bNEUGsbLkIbYV0UcsCoI/M2McJ
         FF7g==
X-Forwarded-Encrypted: i=1; AJvYcCWUZ0BR4O1Y7A6ST7665Crb+M0JkExqjsDh/NI8KastHwumd1BFqzkp3zSSXKP0BWdUs2TepwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhAk2OZvBtrwpctrnIgoVosV++hBv7RCYBMTR5w0LaMjQCLflh
	QyiWwPeplv14L4xRo1jDiihz/MLgEyRO5DJP8SqMwFbYeIKVOPJuN4O0s0sIyg==
X-Gm-Gg: ASbGncsU3icmM2DLdR1MAmPPgaFqxR2oGf+EzVDwWLg/s2wVbBHk+0ePYIP6UnRZLEZ
	F3sud7iSgAKu+ZatF0/xaaT6SKKYwj68SwYdQmtFtcEy/QiUHEIwvOCccyUNw+KD+q0LJDWLpaN
	aQ++Lhhm91FU8xIZJpRxQxSQtxF3XuSxuZarq7Meu3/mr9uMmQ3amF429ahIDu6pQ5oc/TnL8w3
	dCUMta/0huaq4KE/o3J/ys7GjegzIbjpilRhGuuiQIQrdJZUtQsdC7R7GsjxucKLkRj0BLrK86C
	RQ78GZ59WNWtEqMQnFvLrQ1jU8uE2ICnJlkaEhSFxKSKlQWfgPt+5lenw8tWt4GFg+xB7kPGzp4
	aHTOO1yWg1cHB4PrIwwhR2bwTpZO8/t2szywpZdSXHUF6tGAcNLH4sw==
X-Google-Smtp-Source: AGHT+IEuMwBGN8leVN09ZBnD48z+ZF3LbUxEgujm4n8TM9fKLeko+pSXEDUltw4QDk+L+Sj011ZL+w==
X-Received: by 2002:a05:6402:3510:b0:634:c4b5:5d7 with SMTP id 4fb4d7f45d1cf-639d5c6fadamr17675616a12.34.1760299246552;
        Sun, 12 Oct 2025 13:00:46 -0700 (PDT)
Received: from foxbook (bff184.neoplus.adsl.tpnet.pl. [83.28.43.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c1348b2sm7454711a12.37.2025.10.12.13.00.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Oct 2025 13:00:46 -0700 (PDT)
Date: Sun, 12 Oct 2025 22:00:42 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Petko Manolov <petkan@nucleusys.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net] net: usb: rtl8150: Fix frame padding
Message-ID: <20251012220042.4ca776b1.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

TX frames aren't padded and unknown memory is sent into the ether.

Theoretically, it isn't even guaranteed that the extra memory exists
and can be sent out, which could cause further problems. In practice,
I found that plenty of tailroom exists in the skb itself (in my test
with ping at least) and skb_padto() easily succeeds, so use it here.

In the event of -ENOMEM drop the frame like other drivers do.

The use of one more padding byte instead of a USB zero-length packet
is retained to avoid regression. I have a dodgy Etron xHCI controller
which doesn't seem to support sending ZLPs at all.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/net/usb/rtl8150.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 92add3daadbb..d6dce8babae0 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -685,9 +685,14 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 	rtl8150_t *dev = netdev_priv(netdev);
 	int count, res;
 
+	/* pad the frame and ensure terminating USB packet, datasheet 9.2.3 */
+	count = max(skb->len, ETH_ZLEN);
+	if (count % 64 == 0)
+		count++;
+	if (skb_padto(skb, count))
+		return NETDEV_TX_OK;
+
 	netif_stop_queue(netdev);
-	count = (skb->len < 60) ? 60 : skb->len;
-	count = (count & 0x3f) ? count : count + 1;
 	dev->tx_skb = skb;
 	usb_fill_bulk_urb(dev->tx_urb, dev->udev, usb_sndbulkpipe(dev->udev, 2),
 		      skb->data, count, write_bulk_callback, dev);
-- 
2.48.1

