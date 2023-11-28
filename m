Return-Path: <netdev+bounces-51841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924F67FC67A
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F209287620
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2587544377;
	Tue, 28 Nov 2023 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="elzW+7nH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217FDDA
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:58:05 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b5155e154so2092185e9.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701205083; x=1701809883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1zqOorwszBSy7715/FfAd+B6Hz5TxCnBSal1fxWdU4=;
        b=elzW+7nHN98jC6ZJZMIqiLsFfmXCX42bi2ai1Y4bS/09yKYcU6wF9dk4lhpsrX5KgI
         V0Y9omLOT+CvFthG444zGkNllvn5FqXuw0tZh79L1inaTsGIaaShV4UvMViWoR4DIKCZ
         CwvbeML3MKMLybJeF34nxXOvaezU+VGRXxoXeuVlPx4LLeU4oQ81TfPfjoJtRWukXBjd
         Iwr11MpHFokR5J4xK77NOJxPoseJyL/VwyQ8sZVgRCOw6uJAAh0pLoUwVwSDiGoQNL8O
         uFLPljZsFoyAvKbG8++Vo5wQDFopMfeAEAqwMJzdvLjHCnQ9NNsvNmTJDHS3y9MrDEFV
         byaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205083; x=1701809883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1zqOorwszBSy7715/FfAd+B6Hz5TxCnBSal1fxWdU4=;
        b=Ktuf8yrxK54KU4/W8wIWAlZjPrQz5Tx1v8IicKunk3mFGy3/QVsEO21AC2YaLWUkGq
         MwZsexYVRdtOgPg2ttQafJxtFh9HDDYy5f38pJRqyQrpkVWgIcYsY6iZXEYiaorqzE03
         xsNpVYGkeKUlsINRa+iaxKAAXWLRlMR9yt9Sa/td36xMgWc+Ha6aEWMCbKoAqVAguDdp
         7Fvk3C5WaXMBaVxOJpL8OWyuf5uepEc6Kn6Wlv5D1BGCqCXrkICsDyptR7sFq685F7im
         b/vwS441Dg99fhuIKZqRgyc+pU95DKKfvBZaoBY+FA49yKMQpn2U0b9Hbqgc9zlzkhRX
         Dorg==
X-Gm-Message-State: AOJu0Yw27rJtvgSQeAy3QgLrdPLg82uTHh698Lp/F9LWo2KXA9vLJd5m
	8x5lmgifu7eG+m+sH1kpWO05nA==
X-Google-Smtp-Source: AGHT+IFrXyrxI2DheRUy2qRVidUrN3TX/h847BSafti/fP2chMfRtHxz+JkNhBcBQeK9NEeeMi1vGQ==
X-Received: by 2002:a05:600c:1d89:b0:407:4944:76d1 with SMTP id p9-20020a05600c1d8900b00407494476d1mr10794865wms.17.1701205083659;
        Tue, 28 Nov 2023 12:58:03 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0040b45356b72sm9247423wmq.33.2023.11.28.12.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:58:03 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 5/7] net/tcp: Don't add key with non-matching VRF on connected sockets
Date: Tue, 28 Nov 2023 20:57:47 +0000
Message-ID: <20231128205749.312759-6-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128205749.312759-1-dima@arista.com>
References: <20231128205749.312759-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the connection was established, don't allow adding TCP-AO keys that
don't match the peer. Currently, there are checks for ip-address
matching, but L3 index check is missing. Add it to restrict userspace
shooting itself somewhere.

Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_ao.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bf41be6d4721..2d000e275ce7 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1608,6 +1608,9 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 		if (!dev || !l3index)
 			return -EINVAL;
 
+		if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
+			return -EINVAL;
+
 		/* It's still possible to bind after adding keys or even
 		 * re-bind to a different dev (with CAP_NET_RAW).
 		 * So, no reason to return error here, rather try to be
-- 
2.43.0


