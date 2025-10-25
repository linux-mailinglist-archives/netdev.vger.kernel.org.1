Return-Path: <netdev+bounces-232766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8171C08B6F
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 07:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B843A7BC0
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 05:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D8329BDB4;
	Sat, 25 Oct 2025 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PI6ESIHa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA5273809
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 05:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761370274; cv=none; b=oFmbm3344QruaGNcet0kB+SZ0xn20RemAY8vKS2mPMqy9DK5mE5518G6rOKtMr1OfQsg3eX3gG1BggGCjrakopTQkQhOaydGAqN9CRNYznRKONJ3NPSVkV64ziFtEh6hrDs9OVvMiTrbsAumC2GFOBTgcHppRFrPoEFnW0/s/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761370274; c=relaxed/simple;
	bh=9JE2eCMrAgawkxif50jJeP7o3Z5b2pWA2skUK5+w4D4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WDwL+dKx0GNn/oyIQ7WEZ0ffN7kcr1fpGqdhc7gvDIuz3MTTM2rHkrx3rAgiIZUdNi3y9Worhwgs3EOtO6tSffW+zgYURBZnzOx6Zsx7dY/sYgnVKwNOSQkYS6fKRWamqndBnDzd7UykeuMYsv3uXaYR3Iz0HCcpDQMHzeWg944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jinliangw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PI6ESIHa; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jinliangw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befbbaso2965152a91.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 22:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761370271; x=1761975071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8NdnolLUdHl3mpDQYuEMQXoeCxai/uBAjvQ/iRwUs5A=;
        b=PI6ESIHaUSKxXKUq1mSVrCLiwuzGSaiG5UjHDZ1MOSeQJPBjl8/030FJD2Ccg4kRzz
         +0ew+FbMzUEC+oqmeTgVS3DyNaMWntYJ4Ad0JtOz2XqA67VVbNGRB/0oM81qn6xoCi6p
         giMdRxTtocago6Y+32I+4zFcjMBJQ3egRfG6SrL1dghPyhUvXL45JirCZjmGNtFE6POk
         AQ+DqCftFU6aW312Ctfo7MKOpp5hk3v5eyDg7CVqj70/XMh4rKflRSlJx1DwHs4GFmaU
         uhViD9aF9faJRFpmBlg+WbcEmBIzJsJhh+UnlzL3RlPIU2pHXtOVSPwF7KueGSABPW0e
         UjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761370271; x=1761975071;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NdnolLUdHl3mpDQYuEMQXoeCxai/uBAjvQ/iRwUs5A=;
        b=s3i/W0ZHEPDUGQ9c4jbQrIMa49MR3PjhRfTkBTtgVxKe5uV8w1MjDFdwRXEc3SPipT
         BHKZ7qHNJ4brRXPQ+O/u3ayY5LjJzhEcx/jdNmemsSIGfY0YmpPCa//9yQO6JozdvvDP
         FIGHsW3i6ppNNYl8vr3UIzrxuThp7Wm1C6wyrOovWf8/W/nYgUNxSrgHPKfgGvjvB/jX
         s+Rr6xf3Avfi2kbA/HOjzle04OMuX9yMu5X1jvVP58VsPuMR13z/c3Loan+6cc4dl0qE
         LPelXeVWmuSMMzQAMUQ9w3km/cDIY3XnKODELQLNvTzfUnN71cQQAMJQ6FhnNpQqQvbo
         SZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWAiBFQA1IDIyTKX8yHnQxKk3kQ2/TIEGI1VvGRZJ6xvbcacPlJwqEGz0aMFZWz0V4NbBPM6zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKeC2SM7OCgCn3EjJxnCh/SdkonpkRB6BWZc1Klg0TN+qCgZy
	TpR8EwGBp4UR9xNjVlMkeaCOddOIlg8/e1c1eINDxpSUWHiVdJqIr40GjxWQBpf4JJKvVlA8pr0
	+W904/m/Tg1lmMcRnfg==
X-Google-Smtp-Source: AGHT+IHgtsqZdUn8D9T3AbJjXEiFeH3zkFnhWbJDkVgQbOy5b56bF/rNyyiSFoyny/XMnKfD8yg8F4iqLez9bnI=
X-Received: from pjxd23.prod.google.com ([2002:a17:90a:c257:b0:33e:2cf7:70ed])
 (user=jinliangw job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f85:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-33bcf8e5ebfmr38655974a91.23.1761370271473;
 Fri, 24 Oct 2025 22:31:11 -0700 (PDT)
Date: Fri, 24 Oct 2025 22:30:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251025053048.1215109-1-jinliangw@google.com>
Subject: [PATCH] net: mctp: Fix tx queue stall
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

We found one error case: the tx queue is hold on stopped state forever.
The root cause is that URB complete callback may be executed right
after usb_submit_urb and cause tx queue being stopped forever.

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


