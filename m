Return-Path: <netdev+bounces-135264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6980A99D3FE
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58EEEB2AE1E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478F1CC892;
	Mon, 14 Oct 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gHmxVmqE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D381CACF8
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920321; cv=none; b=RrNp35bRQiuTQbRxdsOhuxg+aNnuuCMU1QCs1zsegVDEbizkvkZonX8M15732xhUhUnPd0WZyKNMQE7xBUCS+B3lwkD6jUH4xVg3VqRwmDVEt1tAVs+MmtGIj5hSkWT2Wv08SATtX2EHHdA3f3zIwHqe+MbT4SEdiSTg8jlCoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920321; c=relaxed/simple;
	bh=tpRnxtvyDHesMuGsYGGagBR2XeIwxtaApq6sfrvnYrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGN0R08nHI4IxfGRHODXI9Rl3pm+ZDcZBPXOpABGpWoQA1cxOMVY0n8bUe6YA9WDQP0H/waEjr4kayx4Gx1lg0WFrwsh7CCA4u4TivCRSZPQFadFc/xsDU8ID7roI9h32fNThGvqiOL5B9ZQudOPMLrQmHGEPOpc0GlUuHZl5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gHmxVmqE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d518f9abcso2403738f8f.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920318; x=1729525118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRdyGf4lfZr6TznDuyWqYCBTl3G4Nizl8+blfyYvkoE=;
        b=gHmxVmqEAq2H3WSZdMhuCmkb7TtWIvdeoxB74oty9UCExauTw/LyGcw1zxvAxXy+dl
         atl6R+YmvG/iOTONZWptqoYAvtsk18MOlOEoxma5Wm9/yUeJwdWl2m7eHekbakfFlNsp
         3WRnxaf09V5yQcY4IoY6C+Cn9sYW+fDiuUm5RphdLf0PVLs2lzP1O8RgC/9rKGMfn7MT
         V6zcXMCuSi4hB+mipouR6I9AqQY03la+55wgk4ESopEG5IFPB6HGn4BzXSeHR5OS1/ef
         25NRI8f0N7QtIu4fS/wpbbzKeoqkr8TXRr5iXDmJam0flodQyZ9ydnUGbxvSGqVh0tS8
         iGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920318; x=1729525118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRdyGf4lfZr6TznDuyWqYCBTl3G4Nizl8+blfyYvkoE=;
        b=LTtK4RzEtAqzU1c1h0hbZu3HdKjm/V8nbGPxTK2pknpHTK5XkirqvwGABnnH2mvwj0
         tT0sQsztaY+gE+/aJ9JgbvxTNzpOOxfhrixM43y/fiiKgH1q7NbNlpBIh0fkyEu/zftP
         tpYmxQXV2W9A4FWsfwnNI3RnFoamWMBWganMORCWBH/K7oCDbsjzNmcwAAAkW/BItsVY
         mL+EDTfZHurCVfhObY+qf1Lzv8S1xmDaYT+xpwjtwKMV6lahsHBriNQ4dpP27e3sRwr1
         xiPgtSZqQE2H/yLoebDzOGEbhmGHebjpQsNnMgQQDf3USIiLsdZnrO7wAXwjpvF/5Hqt
         mqcw==
X-Forwarded-Encrypted: i=1; AJvYcCXS/9nJx1LkE0IBEr2S8LuEV/yjCPsRWr9jKevaltK+HXbX8lzdUwODvfFr5CtintB2GNnYewc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2mpxvX4nGKX4XatBwSzZ1MNbkXjIfwkmNHCN73V0j5dXm6eC
	uYaX66eZJBzYNXL9mBZk3Ql/zhdvPt5QHKlp9w5psus3JE0zgsUd8+1VK84a1No=
X-Google-Smtp-Source: AGHT+IEvSESGNKtr3mfQllscjnvWPixVZXXYDJK2VErqCT7tUm2cqjBB5hZh+pW+OcOgTVIOFBIPag==
X-Received: by 2002:adf:e908:0:b0:37d:3def:2a82 with SMTP id ffacd0b85a97d-37d5529acb1mr9092817f8f.36.1728920318048;
        Mon, 14 Oct 2024 08:38:38 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:37 -0700 (PDT)
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
Subject: [PATCH net-next v3 8/9] net: warn, if pf->create does not clear sock->sk on error
Date: Mon, 14 Oct 2024 16:38:07 +0100
Message-Id: <20241014153808.51894-9-ignat@cloudflare.com>
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

All pf->create implementations have been fixed now to clear sock->sk on
error, when they deallocate the allocated sk object.

Put a warning in place to make sure we don't break this promise in the
future.

Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 24b404299015..9a8e4452b9b2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1576,9 +1576,9 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	err = pf->create(net, sock, protocol, kern);
 	if (err < 0) {
 		/* ->create should release the allocated sock->sk object on error
-		 * but it may leave the dangling pointer
+		 * and make sure sock->sk is set to NULL to avoid use-after-free
 		 */
-		sock->sk = NULL;
+		DEBUG_NET_WARN_ON_ONCE(sock->sk);
 		goto out_module_put;
 	}
 
-- 
2.39.5


