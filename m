Return-Path: <netdev+bounces-132861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E8499395C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E13E282DE3
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 21:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B0B18C90D;
	Mon,  7 Oct 2024 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Oaqv1Zpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1EE1DE2C7
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336953; cv=none; b=erl98DKcjqS3xV762fksxhSvTojay9NS2w4llvGqu3HjifIC6cq244RiPLhsw3sIHGlnwzwFAA5ngXljGrTvPXPHDUE800pGvwCbkxb+jH0rMpau8s9SzJxj5V9wVn6JFgxrItpQqnub4riNBArwL9wtJPho4tPu4+SR8dggknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336953; c=relaxed/simple;
	bh=q1wcm6mMQ7h4EZDUMr6oUmN6x8BUBq/PxsPoaXApW48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrB614bwtcLwS3aXuPlWFp+qJiVcd6ntArzJbjEKclIyeTqJaoywslE8/uhLQbKNRPr7NIfhBxSv2h+94rgOizMuCBNjKT29EV/eQEUMn+v8AslPyLCVKmj9ve+f28jPYYOiaGOuMS0t24snQQH5YIa3xjA5FfbFavumpdbtJzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Oaqv1Zpi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42f56ad2afaso66348085e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336950; x=1728941750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lghPtxWNb8lEoXQFFkVieItQmyHsjS0TFzxCTFvvuyY=;
        b=Oaqv1Zpi86KsYxEMz3895xcVAIn490Gdf5Q5Ysovi+UQcqedpVaTDjKZBFlGvzlN82
         vGBc8j/jSI0NlPY4EQ7Hk5RPzrYg8U7qO+nOPRSGbuw9HNp3NPlj1W2L7r0g9AIQqYrH
         XDkZAY9oAbFKK9jnZMAnDJZIfuv0mWlGjEStSuOXaE2FpYw9csEF5/38XK6hs4qaDOBv
         B9SjRp/AGxSXRh61EyPsQulwK66ulFeACiSP3/7uY1+wEUGNwfqIbPhI4/c7omdCscVe
         yX3qMLZwu5hWLam7RROCRlcJthM/D6joP9XYyd465/jz112OXkBNNt6DOBE9DmZ2WiAC
         H+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336950; x=1728941750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lghPtxWNb8lEoXQFFkVieItQmyHsjS0TFzxCTFvvuyY=;
        b=g2dV/YPIAITOclb4d5qMonHj6p8IJw7YrGxngES9xmPM9CHo84q5Yyz1J769yD+S7n
         HOw5/5preTEN5QSuWv4vxdScADm1Jl2d1cX0M/3vuL/chiahyoPRBJ5zHKIiqKIAqcHO
         FX+k90jJ6548nAwCgm2sBPz4HcDx1gbpb1vmixQ5/d4ArJLeqHorjCyLzwSTLazW8Iob
         Ga42rGau8M3qIiRl9kbO5uFuxiu6n+Qlg+Ou81sFkxJvLgqOl3LgN6qMnf9x4DM+xUAC
         VHjzwv6x7xHUhyd2gdG3ilsfgjQtse5kWFUojsrG4av33b5LTtyr69vM3JdDREI4Gszn
         umuA==
X-Forwarded-Encrypted: i=1; AJvYcCUE8hE6h+vvM81bDiU0rC3kNUSkOwVSF3js5WtTGROUuqwWjx3v/lMxKCYYFEJF8/jMNv6l7jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRT2E53I+hFnyIKYt84iEvyTvfc2nrxyTfuryRhgSo5HDmPbfq
	0+9cijDRXJHd5yUbDnDO7St7EAw775ST/5oD4OLX3985e/Z5lDICdy8+fq57/ck=
X-Google-Smtp-Source: AGHT+IGIEgvlVQ63MN8px9sXGIB6rH0PaHc0x2aiS2t9bCm+0YE6s5XpgSiahpjGOCaDNGfNsSEswQ==
X-Received: by 2002:a05:600c:5494:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-42f85aef6e2mr143742535e9.29.1728336946921;
        Mon, 07 Oct 2024 14:35:46 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:46 -0700 (PDT)
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
Subject: [PATCH v2 5/8] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Mon,  7 Oct 2024 22:34:59 +0100
Message-Id: <20241007213502.28183-6-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241007213502.28183-1-ignat@cloudflare.com>
References: <20241007213502.28183-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On error can_create() frees the allocated sk object, but sock_init_data()
has already attached it to the provided sock object. This will leave a
dangling sk pointer in the sock object and may cause use-after-free later.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/can/af_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 707576eeeb58..01f3fbb3b67d 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -171,6 +171,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 		/* release sk on errors */
 		sock_orphan(sk);
 		sock_put(sk);
+		sock->sk = NULL;
 	}
 
  errout:
-- 
2.39.5


