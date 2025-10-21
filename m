Return-Path: <netdev+bounces-231258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C79BF6B14
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96683BED83
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4AE334C1C;
	Tue, 21 Oct 2025 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcsqL+/D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B72334C0F
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052348; cv=none; b=o8oWi3p4wNIUJ1zKkxeKZ1UeLx7gHfoD8ERV9vaQC49RU4JbOsxcEqHyrNurC7XBf+9GDZmcPwQCDU8+8JYfBYfTHE9lnsmtH16PdkLOz4I05uokZki2CEhGSLD20TV2LExCKV/AJk5bXLrzoh8ZE7+Q/7psCSBQibEWquIEa3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052348; c=relaxed/simple;
	bh=OalRNjUbwogRdEZGkYjFYCPbwuw+lvhcwqs4I3EUtkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JXe5LQ8BACZ1pay/liG9H8blXhL2/w8JRA8EBNBfpHxLrQnf0eOip8SJhMhDlB7RgUqCygX+TCGQ0HeXHpO1eBKgIoEA3zkuwi0o3trO4jfLhSS/6PBSgaXrV4PGZ7lwm1ya8nxQUsbO7o9DGNzuGx/PcD8ILGHxwDKlzXcq80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcsqL+/D; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so5106315b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052346; x=1761657146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfT6R8DUz6iGvUEZdMZ9t6TvFyv6jslwQUFkkPxFNUU=;
        b=BcsqL+/D+tGMQpP10bzCTIltncDtRf40YD4ZAqccrJ9oK2W2/hruG9elp4+sQgH3nX
         qDrmJ8X4Va+3EqKHoE8/kZ6r3WfnF/76IiE2xMcAXRqECSu/9yUrW8rxxa/bw729xf66
         IWZNLigBfiJoe3hDmJo8Zj/Hr1phtk4zlUS0j+K1JaHq6vOxOCCr9td5m2BitcdSufjZ
         U1CmqQATZV3udSSi4K6x/PikQXj7YIWJBae9XcVqrxMbpr9F6r7LtLxXeqWavTs2xvVR
         clSQbeC/+ggBzx+zC0kc1StdGVjyYEh+ZEFdbNNCUPeKy182fF2Im+K4I9dTrVp3Cm4T
         irQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052346; x=1761657146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfT6R8DUz6iGvUEZdMZ9t6TvFyv6jslwQUFkkPxFNUU=;
        b=jWYnrIPdrTU6MTd2DapdcRlMKQNeljwVAze92TQzY44vnKrqusLSgG2luDtEpyFGfT
         YYsKqJGdaBWzYpumxyV+fGIIcCECGV3dFakXsdIE9g/Xloo7qxfYjuu38Ohu/ND3cZl4
         TwjZjkZYEHdZUygSp9XdB5X8AGA+bkAq0gst0Hh0dg/t8MTsw0k7F+Zt1x5/cyUKxojU
         4siYpYbwNVU0xjiuuBdH6rqwMxZHwdXRB6p6s1hEdWXyCWitdThA1+7K8DnPRLKI8Y5x
         I+befYIN/wySTRBMDq3+0IO1ZOjEa6SXoCFEwwR8dyLC6zvXFe7NWbxnf3CxFHPK8wXu
         ZkoA==
X-Forwarded-Encrypted: i=1; AJvYcCWGnuCX4tFM/vuZ/5L0iqG2gUKIHSd8B3ZKnBp0pIKkd/07ygdKYK8C7VAGumHCGCYKySriyLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6GMvMewuIFuEnwhGmeP5fZ2CxBzPb34T2+LEB8hNidVqStoP
	5VTIgYL5sAtymVQgsI8UJzLaWGa6Gy/EO2Jw9T4TkaoF2PHLGhCAx1Sc
X-Gm-Gg: ASbGnctxjSS6Di0iSE+/m0SxGkUGooMT/phqZx9QQOAhzFipL0foTwzp8CbM0Bgc52S
	M8du7QNzd7IoMW9Bh83P0pk7p4g7b/cEywJePX5hdNH9OMmXer1CG/Vb2gZXHPo8yipRzBRscut
	VT0s9BUO14e8bG3WrWwVIgKvSpGOPuy0yB/d3YTPk+juREaRl2WG+VtcIg2qHSgDpuZp5KLvFv2
	2uKvdFyv0pQ7i/QlpL2ZvNdPy73gmafAv8Be61GK/rioh3QJeYdXGXvmiI2RLt7FFoDBh4Msc1K
	NzFmYfIODPTVw2ABRNou6fWy+qLcQy4SjvsHuV3EqiDqG+e4rK4yJgFpQ2Kp0lx09eY53hnS+Y5
	4n7dETDW/tbvh+ZgjdbdOkW0sP0ZNeXPnunqgSM4Pd9tqd4PC7fo6znp6NYKJK6gFbS6l0gDqj3
	zXZuFMjp8XDnZ+Ih452fyfsJuCzE6q+QdGQhQwGPHSsF0USrV2oAvyiQd6AXhtAu/20BKw
X-Google-Smtp-Source: AGHT+IHHHL9U+nD1VYobHrqUIbr9Ge8ylqi/izQYBJI4A4Bi6BhEpKUifMO+u2HRQOt/Dz66Z0TaAg==
X-Received: by 2002:a17:902:d2c6:b0:290:c0d7:237e with SMTP id d9443c01a7336-290caf831cdmr243944045ad.39.1761052346173;
        Tue, 21 Oct 2025 06:12:26 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:25 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 2/9] xsk: extend xsk_build_skb() to support passing an already allocated skb
Date: Tue, 21 Oct 2025 21:12:02 +0800
Message-Id: <20251021131209.41491-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251021131209.41491-1-kerneljasonxing@gmail.com>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

To avoid reinvent the wheel, the patch provides a way to let batch
feature to reuse xsk_build_skb() as the rest process of the whole
initialization just after the skb is allocated.

The original xsk_build_skb() itself allocates a new skb by calling
sock_alloc_send_skb whether in copy mode or zerocopy mode. Add a new
parameter allocated skb to let other callers to pass an already
allocated skb to support later xmit batch feature. It replaces the
previous allocation of memory function with a bulk one.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  3 +++
 net/xdp/xsk.c          | 23 ++++++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index f33f1e7dcea2..8944f4782eb6 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -127,6 +127,9 @@ struct xsk_tx_metadata_ops {
 	void	(*tmo_request_launch_time)(u64 launch_time, void *priv);
 };
 
+struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
+			      struct sk_buff *allocated_skb,
+			      struct xdp_desc *desc);
 #ifdef CONFIG_XDP_SOCKETS
 
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ace91800c447..f9458347ff7b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -697,6 +697,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 }
 
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
+					      struct sk_buff *allocated_skb,
 					      struct xdp_desc *desc)
 {
 	struct xsk_buff_pool *pool = xs->pool;
@@ -714,7 +715,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	if (!skb) {
 		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
 
-		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
+		if (!allocated_skb)
+			skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
+		else
+			skb = allocated_skb;
 		if (unlikely(!skb))
 			return ERR_PTR(err);
 
@@ -769,15 +773,16 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	return skb;
 }
 
-static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
-				     struct xdp_desc *desc)
+struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
+			      struct sk_buff *allocated_skb,
+			      struct xdp_desc *desc)
 {
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
-		skb = xsk_build_skb_zerocopy(xs, desc);
+		skb = xsk_build_skb_zerocopy(xs, allocated_skb, desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			skb = NULL;
@@ -792,8 +797,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 		if (!skb) {
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
-			tr = dev->needed_tailroom;
-			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
+			if (!allocated_skb) {
+				tr = dev->needed_tailroom;
+				skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
+			} else {
+				skb = allocated_skb;
+			}
 			if (unlikely(!skb))
 				goto free_err;
 
@@ -906,7 +915,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 			goto out;
 		}
 
-		skb = xsk_build_skb(xs, &desc);
+		skb = xsk_build_skb(xs, NULL, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			if (err != -EOVERFLOW)
-- 
2.41.3


