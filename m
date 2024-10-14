Return-Path: <netdev+bounces-135258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269CD99D38A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5853D1C231CF
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF1F1AAE1D;
	Mon, 14 Oct 2024 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ADSl8+Xy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74B51AC88B
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920308; cv=none; b=ngkJI7khwjMErcqIeSrYZzgm0/4i5JOfjYGgdBSeAYdesy3eaWSNzcQBK3ERoMEib5qfTo9uDbnffgtNLnletZXrKKUT/apx/4/fOdUsmUb2T5BxtGSCZkWMcQK0S+Gu0uybLegCzLLBBiEJqVUzlEwMOfUT28GoOvqrJr1BLa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920308; c=relaxed/simple;
	bh=Za6d2/ag0cx5W3bmCrv67Ur4+k+VPgr8uvsyupNoJnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZWY2nJC0SHoQ+GMq8Dvzx5P4+qoLXar0aPWmMeBcu1Z0K9yLa5z7YsjSbURPdKdrtjZqU9/jRVOCSCL0zHnlPN0QyZDrU3YtJCAHD1IHJa/h65aKXzbCniV5P2Uwl0GTxisd6LPlnMxGbgwfE8ZHRhUmww3C6wnNlx+LN/yPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ADSl8+Xy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d518f9abcso2403571f8f.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920305; x=1729525105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TINcLHJMJcRO8N8gtca7WYNoZRWtOQnWeYtX29logTQ=;
        b=ADSl8+XydpCyUMT7zL3I7Xvi1Ix5wGUH5Qfk/p+HOYeLzB30nwmpsZnljcSmMl7gL1
         f5gBFjsvjemCwOTBAn3BFfZok4/J5eKhgkR0d6LFhagydEQ9CXJVOiZeSuHbZh8IZ6Pl
         4h+6QorPYZhw6NlENAoq5NXcVoV8SDgtaQFj+jV982TyCAhFCVV6luDMEjtEs7rHKnMg
         /CmjdtmnHerbQskx0gIUQFY4YluRL9dyg1C8jsGY57vCFoUF/RbPAP4xLWAJvi0UxtMy
         XhHNJZf0yIKgG9BlSHM8EIcMrPHPEc/6RFaVJdP9/HnrpApP7NF7p0Nwpp5905fxo0n0
         jBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920305; x=1729525105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TINcLHJMJcRO8N8gtca7WYNoZRWtOQnWeYtX29logTQ=;
        b=ERLrBNT8W8qBqOjyYE/quOcXm7LRMXLyWLdGpHOhV6dc/sH7WQm0Ab5kLUVHoPY5f5
         G/F8Uz8zsN8y04HRILK/EZYPHi7+UwPyAtb4rzEUK+HFN2c8589gG4OFRN87dFhAj9fs
         nj9olKSDdvPpxB9fQYDUiQTL0PRqJgAnEj2mJUpxnu4vwVM75FePQw9p639yv0PFsZVN
         As81QpHi9CZnd3y83C8V2JIlip+vXzjm/dfQS7EwSMxFZOc44Xfm17vwyw5EgZtKrAc5
         FmsS3JwSPMLe9z4TBoDj6n9IpBBsqj9qFuteM/EpNGR4v5j6cZVv7ZnwW/v0nz7xRPKa
         GCKA==
X-Forwarded-Encrypted: i=1; AJvYcCW7F3A3KXHhKQRoA1vNMwC9l8y6MoqctbaUNHzKkeiMpdK/76sDvDOVSe07LMFn9QfXCF9FOyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRPKfbaZW0slLQDm/6sk93DqNqWdWFDxSCoAxGdt1oRHSOIMG
	cdgFpivNfpO7ALgfQx7yfRVdQosJNZmcYNe5yUCTT05/ExafGfaTLRTnD3HK0Fc=
X-Google-Smtp-Source: AGHT+IGI3bnawMCR2rBPHOoSypef3VQX2phi9r/huSmV/cqlV/2kFbNe9+Hj1byHQxm9DpEINFWl2w==
X-Received: by 2002:a5d:5c88:0:b0:37d:4ebe:1647 with SMTP id ffacd0b85a97d-37d61afacedmr5574208f8f.49.1728920305128;
        Mon, 14 Oct 2024 08:38:25 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:24 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net-next v3 2/9] Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
Date: Mon, 14 Oct 2024 16:38:01 +0100
Message-Id: <20241014153808.51894-3-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-1-ignat@cloudflare.com>
References: <20241014153808.51894-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_sock_alloc() allocates the sk object and attaches it to the provided
sock object. On error l2cap_sock_alloc() frees the sk object, but the
dangling pointer is still attached to the sock object, which may create
use-after-free in other code.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/bluetooth/l2cap_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ba437c6f6ee5..18e89e764f3b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1886,6 +1886,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
+		sock->sk = NULL;
 		return NULL;
 	}
 
-- 
2.39.5


