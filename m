Return-Path: <netdev+bounces-232769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F06E7C08B9F
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 07:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C48C94E1DD5
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 05:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0E22C21DE;
	Sat, 25 Oct 2025 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g9XQ36Hf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591931CAA7B
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761371102; cv=none; b=K0VIcbH3iFoiGTNqG33/rksUGnHgMWaGx3LDG1TIuAyu9n1pTzrhKRMMMQ7+Te6mH+dGpYzcDSUJ8f3eXskNflR23AUX1e9SjF3IbLzgFz2WX0LkRFPJlP04eCVqc8l+qquoetilErPd2pFMuQ1UBbdXP5ntirxPfKNPGKm421w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761371102; c=relaxed/simple;
	bh=z+60HUCThz8rs62/eMtfSJpsS6s+6ahM5AbCboWurh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=swpz0IuP90fVUvCQTK7MAeuId/0PI8sYWEQQI+2YItL22p1GtgRL5t6jz5rbvU8C9mHpTR8YbLVJHuSx1GkMA/MKkrtPXyHkApCbLD6F9652q7SmZtSLhxwpDUpveaqRxfsNtFBMumQSUwPb9PzxwLzwgvxeML6v2dhFwX7lipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jinliangw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g9XQ36Hf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jinliangw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so4310915a91.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 22:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761371101; x=1761975901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2ylm5lDxZdWcq2dZySkzTXA46K65qL8WrTs8EJDdbA=;
        b=g9XQ36HfjACmo1lx8DVmkIHs+uI7A3nRAXCNWW0737va28g3buMJ3WwTEBuC1Ib9aB
         dk9xbYMCZH2GEtjtvowKAt37FdLq+rqrdV2c6D0DGGFAGbpH8lY3a0F0lBwhiPvCkXmH
         3Dv4acl+TfN1dKzecK7xCp8fGfvL6kwDNBPx++Mix2aiIoA6lJfHze2BxS9hdo+aPtLg
         pyozNGjGu/0YVq192f4XRv0je8wIjoQ/O+dB4surt/Jhtg1Vv7V8DpWvvr795j9a0wLh
         /uU7O/1K0DkBThSOE1c47VzcQGioE5SlfirKjyjuuB0RdgQZ2Qx8T9adVF9LifIl5V1v
         xH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761371101; x=1761975901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2ylm5lDxZdWcq2dZySkzTXA46K65qL8WrTs8EJDdbA=;
        b=Q7EUGhr0US4rMJOvOBWyIpE29c74P+xC+KpHorGzAG/bELVQRbey2w9S+jqF4KfpGg
         MgF369Ym+YwzsNgcTBWx8M6KrMrCnzgKPtz3yUMjd+jJeCXmYPvK4kZ7jB8qJfQJM7JM
         sv+I6BjcUHAyaIFihDCe09qzhlURrZQb6L/gEhDLhd4pzT4bjf29O5+rO2VHRMV0g1kS
         gIeFNmicT0DYPBXA+AP7GRfa6nlxpu0JyOqpEhvxE9dPptHllvufp1wH7N5x44HM16gP
         x4j3S1zHwxqOoHtrsRjHRemsUEPDZvu9+T8ty9cYMxixnHht143JKY2xL31D/3zrv5SV
         GZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCViV51358o58uRmB3sZT1HpLMFKpyBIIlFo3UqMZ6Nbj6X4JIy+BKtxZcC3bDPqjZnJHMavOvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtqDx/0EUI19KUsf3wbMU/sVUq8PNcXIyEv8HlPuZvFrinjiWy
	yFzTHdZOWadK06Yx0vRprJ/svLnP9VwyARwd9kai6Yjjv+zML1mZ0DnbFJ0nX/bN1aqqvUhWe08
	3ij6goH+3odFFx3MIOg==
X-Google-Smtp-Source: AGHT+IEQSsP/qsCbYJ7wLWUWJdrRrb8F1nw3wCRb93kC7DoAkPCiEMvUYxt5cwnvpuoBZl9bDE2h4ZLZw3Y2HQ4=
X-Received: from pjvj4.prod.google.com ([2002:a17:90a:dc84:b0:32e:aa46:d9ab])
 (user=jinliangw job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d87:b0:33b:b020:595e with SMTP id 98e67ed59e1d1-33bcf8f78cfmr37172395a91.25.1761371100710;
 Fri, 24 Oct 2025 22:45:00 -0700 (PDT)
Date: Fri, 24 Oct 2025 22:44:52 -0700
In-Reply-To: <20251025053048.1215109-1-jinliangw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251025053048.1215109-1-jinliangw@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251025054452.1220262-1-jinliangw@google.com>
Subject: [PATCH v2] net: mctp: Fix tx queue stall
From: Jinliang Wang <jinliangw@google.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, Jinliang Wang <jinliangw@google.com>
Content-Type: text/plain; charset="UTF-8"

The tx queue can become permanently stuck in a stopped state due to a
race condition between the URB submission path and its completion
callback.

The URB completion callback can run immediately after usb_submit_urb()
returns, before the submitting function calls netif_stop_queue(). If
this occurs, the queue state management becomes desynchronized, leading
to a stall where the queue is never woken.

Fix this by moving the netif_stop_queue() call to before submitting the
URB. This closes the race window by ensuring the network stack is aware
the queue is stopped before the URB completion can possibly run.

Signed-off-by: Jinliang Wang <jinliangw@google.com>
---
 drivers/net/mctp/mctp-usb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 36ccc53b1797..ef860cfc629f 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -96,11 +96,13 @@ static netdev_tx_t mctp_usb_start_xmit(struct sk_buff *skb,
 			  skb->data, skb->len,
 			  mctp_usb_out_complete, skb);
 
+	/* Stops TX queue first to prevent race condition with URB complete */
+	netif_stop_queue(dev);
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
-	if (rc)
+	if (rc) {
+		netif_wake_queue(dev);
 		goto err_drop;
-	else
-		netif_stop_queue(dev);
+	}
 
 	return NETDEV_TX_OK;
 
-- 
2.51.1.821.gb6fe4d2222-goog


