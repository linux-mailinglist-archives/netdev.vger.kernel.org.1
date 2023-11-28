Return-Path: <netdev+bounces-51840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6617FC679
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC18AB24519
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAACB42A88;
	Tue, 28 Nov 2023 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GQqnu53n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8AF1998
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:58:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so19487825e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701205082; x=1701809882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1xPXn0VYaTrAb1Nt5Hiecyvp9SYb9ivj7o6hsBOhvw=;
        b=GQqnu53nPxiuqc3wQMp+V2lZtUgSOi0g+3mNyKCM1V8SDSE7PxTVxwIfazl8iRCjIL
         xF11Wge8ndNxRD6aQ5aaHbTSHnAZehAzej7r13XTzUJUSZZnfzm7k89GSL3Lp5OUjN6w
         bNGN215Sgf3azVHXwNjs6OYFeF1i1W6IuxYZB2Z9C9I7D1V2A7Bvekhfm+hahNfpQYz4
         1Lz2bpclrAcy3G2QZabStSPfUdjCMGrMY1/lV7sORLvSrV+PbXCorxMrMKeiX7DQDv9d
         R4x+zxN4Me1dbasSKhz5v7dd7B4F7ER4KBwDRWmgWO0D73pOBDTG5jtFVJSnSrKrImO1
         RhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205082; x=1701809882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1xPXn0VYaTrAb1Nt5Hiecyvp9SYb9ivj7o6hsBOhvw=;
        b=HJMXyTvWWgzvGfApQy6MXEHGUwo9CRL4Nx7HMnN/WySGFpkTS67Rl17gmMIDXRt6W+
         gqStHvss7msNYH4z7Mmq08BqFJCG9QtRQowcklutIbAO0zgTuUy1/RS+lo9hvrLizDrG
         2qHKh94cLH9Q8kTDJ747m6oDr5J32eoU8nXBiZABxcI7HcwxBDhSSzAV+Wh73PJACPnJ
         Kt+QO+msTse/oPvoKSPuJvUtoSQUFxP62pDTqF0mNq4ff3m7ONFxP8tx2JpX8biHs6dg
         NQETR+Dkwf3WFzV4Kvn7Xmw9zVhC+kshjwz6ul5V8Dz+Mh+GICpBmllTFgzvqzCl/Po+
         uVRQ==
X-Gm-Message-State: AOJu0YyM5ULqc2qFLUm1FJ5K7EPxeYPDP10XYl6OjC9FU8Cbm+fVO9qi
	xrLxSfggyxXqm+JYmh1kHb4wyA==
X-Google-Smtp-Source: AGHT+IFOwJBMZz5KpTnXbkRb6NrPG/IC/IH8dzG88Ydc9UIUlFjnbR4D5Y+Sl4qmFwxh+Y33lgZUzg==
X-Received: by 2002:a5d:6309:0:b0:333:85e:a11c with SMTP id i9-20020a5d6309000000b00333085ea11cmr3785785wru.16.1701205082440;
        Tue, 28 Nov 2023 12:58:02 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0040b45356b72sm9247423wmq.33.2023.11.28.12.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:58:01 -0800 (PST)
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
Subject: [PATCH v3 4/7] net/tcp: Allow removing current/rnext TCP-AO keys on TCP_LISTEN sockets
Date: Tue, 28 Nov 2023 20:57:46 +0000
Message-ID: <20231128205749.312759-5-dima@arista.com>
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

TCP_LISTEN sockets are not connected to any peer, so having
current_key/rnext_key doesn't make sense.

The userspace may falter over this issue by setting current or rnext
TCP-AO key before listen() syscall. setsockopt(TCP_AO_DEL_KEY) doesn't
allow removing a key that is in use (in accordance to RFC 5925), so
it might be inconvenient to have keys that can be destroyed only with
listener socket.

Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_ao.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index c8be1d526eac..bf41be6d4721 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1818,8 +1818,16 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 		if (!new_rnext)
 			return -ENOENT;
 	}
-	if (cmd.del_async && sk->sk_state != TCP_LISTEN)
-		return -EINVAL;
+	if (sk->sk_state == TCP_LISTEN) {
+		/* Cleaning up possible "stale" current/rnext keys state,
+		 * that may have preserved from TCP_CLOSE, before sys_listen()
+		 */
+		ao_info->current_key = NULL;
+		ao_info->rnext_key = NULL;
+	} else {
+		if (cmd.del_async)
+			return -EINVAL;
+	}
 
 	if (family == AF_INET) {
 		struct sockaddr_in *sin = (struct sockaddr_in *)&cmd.addr;
-- 
2.43.0


