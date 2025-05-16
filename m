Return-Path: <netdev+bounces-191182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E43ABA564
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412501C0196F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881E3280313;
	Fri, 16 May 2025 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gqkp5IOm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4322DFBB
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431402; cv=none; b=G29liRqywVyss3dHnBhuUsqgDBszxJBWAqNnm+lyC0xQU1e5xgKXdgrVeblKEhZc/fR58pwWRiKJBxhZ9Bczr7/KFqXDxLNVgttR5CstVVesc5EY+vZu7AsI6dwn9o6XaSghR1GEAQvgoDVBPc/9DYd3CC7FsmWUIVftQqEOjms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431402; c=relaxed/simple;
	bh=EBPNCS65V8PG2N3rCayq0uVzTJVCY4qBErJdVvNV0bA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pzsJtgtKeLrdaajVCaIW2AlSZm3XFnKK3ZO0x7K7f3WMfDoCTXqvSrOBWsmbUfPT5NZNSs04c6ehk6TXFPXiB15EYtnJ24VOeErkFoJZWexMleE7NM3a83y9z6+8LF7y/6Dn0lJNLYcN8Ama5rp9wr/0f29UOMSPe14MioH/PI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gqkp5IOm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e9e8d3e85so350201a91.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 14:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747431400; x=1748036200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wVResVTxeYTVMSiSfPp3db7ZOrQ96OObutHTVT5Vcr4=;
        b=gqkp5IOmDNRiDlUV2OtnxQkp7C34BkK6g6UTiznnIfMKJNQe8ViTLKKMQ/Dzhepic9
         VUpkIqQRlRyAKQ/hzu/JviQjnIsz1IxM1iPgn+MFOQoU6us0LOcD9Gh9Fnsdc3vZ1/FA
         zt/8qqXlWOdgyXbqo90ot4BzfDbrjWwu2hm0uKO/8q17TTnPe6a3oErEAE5uxd49xC+l
         APhlIOHGyMxR4eTyKwGBmqDdNKyuWICPx65J2mohooPLgjVtfNFbMkA+iJhHTIov6JAY
         bROcgZfpxMw63RkTCWSOi+kqU16yj4UGwdvP/qvMf2VGAUku6/MQHg5BK5hXulmPq097
         /7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747431400; x=1748036200;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVResVTxeYTVMSiSfPp3db7ZOrQ96OObutHTVT5Vcr4=;
        b=jt39DDiKaJNFdMVZVMmpQrpvcbaE0dD7M23x0c17QVFUq5wavq+VrPzW2Di7Pl9+lY
         bFMXWasEe8QrKHFqvobrHZ/mkWnqnd9EgopoVLe3EU0/6MlaS7nQ0qVU6SXRPLy3bR37
         TQKhGyUJ8xb2PSf/YBNTDLATCrKj7LqVh4nfaj3QYoDNyfMnoThMDH2bDi0iFClvfdjm
         BluHEyJr5TeUj1zNk36LcUdPD0PA8RcWUXQES/XhvRkW/YB7ltlWuQvK/RNsSHSBV9q3
         khyH3WS4cn/yL8B3FQ4X8kU8z0JKbZC9HCOpNI/B0nYZx8oCuS1CJUcaIPbzwZTNXDD0
         Y+Lw==
X-Gm-Message-State: AOJu0Yz8IwyQI3dUL5XMYzFdMz1vA6xKaVmMAWFzdTeUUN1Vr8JEh3Cq
	uit83FQEzHVIDLonh9js94ewp49H4tX/lrjx9t/o2EbJXJs9Cl2kY4o3ft+16HWIauwh9vqeKKS
	eRCo+KiZfLfZGSQ==
X-Google-Smtp-Source: AGHT+IEl92XupC3T/jWnyDo0/vkLtTx4XZX2s/qUZmfK5Npzhn+L4NLIaZpPHuINyTC7yKsf1FcsA8bYlbZ1fg==
X-Received: from pjbsy8.prod.google.com ([2002:a17:90b:2d08:b0:30e:65cf:2614])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f4c:b0:2ee:5958:828 with SMTP id 98e67ed59e1d1-30e7d522155mr8111221a91.9.1747431400270;
 Fri, 16 May 2025 14:36:40 -0700 (PDT)
Date: Fri, 16 May 2025 21:36:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516213638.1889546-1-skhawaja@google.com>
Subject: [PATCH net v2] xsk: Bring back busy polling support in XDP_COPY
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, stfomichev@gmail.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Commit 5ef44b3cb43b ("xsk: Bring back busy polling support") fixed the
busy polling support in xsk for XDP_ZEROCOPY after it was broken in
commit 86e25f40aa1e ("net: napi: Add napi_config"). The busy polling
support with XDP_COPY remained broken since the napi_id setup in
xsk_rcv_check was removed.

Bring back the setup of napi_id for XDP_COPY so socket level SO_BUSYPOLL
can be used to poll the underlying napi.

Do the setup of napi_id for XDP_COPY in xsk_bind, as it is done
currently for XDP_ZEROCOPY. The setup of napi_id for XDP_COPY in
xsk_bind is safe because xsk_rcv_check checks that the rx queue at which
the packet arrives is equal to the queue_id that was supplied in bind.
This is done for both XDP_COPY and XDP_ZEROCOPY mode.

Tested using AF_XDP support in virtio-net by running the xsk_rr AF_XDP
benchmarking tool shared here:
https://lore.kernel.org/all/20250320163523.3501305-1-skhawaja@google.com/T/

Enabled socket busy polling using following commands in qemu,

```
sudo ethtool -L eth0 combined 1
echo 400 | sudo tee /proc/sys/net/core/busy_read
echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
```

Fixes: 5ef44b3cb43b ("xsk: Bring back busy polling support")
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---

v2:
- Mark Napi ID in xsk_bind for XDP_COPY.

v1:
https://lore.kernel.org/netdev/Z-Lby6WMFkHaaJxB@mini-arch/T/#mdd713c1e2b0caf3bb5f625884709af95e30ccc4d

 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 4abc81f33d3e..72c000c0ae5f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1304,7 +1304,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	xs->queue_id = qid;
 	xp_add_xsk(xs->pool, xs);
 
-	if (xs->zc && qid < dev->real_num_rx_queues) {
+	if (qid < dev->real_num_rx_queues) {
 		struct netdev_rx_queue *rxq;
 
 		rxq = __netif_get_rx_queue(dev, qid);
-- 
2.49.0.1112.g889b7c5bd8-goog


