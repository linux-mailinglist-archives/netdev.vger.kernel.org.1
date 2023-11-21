Return-Path: <netdev+bounces-49500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2131F7F236F
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CB22810AF
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A9B14281;
	Tue, 21 Nov 2023 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="BwUvv7uK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E60CA
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:01:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40806e4106dso14669635e9.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700532083; x=1701136883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZExWn2HUbFMStGLP1W6Y7/MeyCrX5kAskFZ5sfppJnI=;
        b=BwUvv7uKuMsQtrhs3/FuJhn+wgU99uTqAWBF9cI3uv67Y7zmJPNmxPKi0Giq7eqrl7
         hHgfWQVdS5+TfbbOp67ladHgt2VJilm8JUNvdl7bySl1/vwNLEeXWvUkExdvZBg0a+kg
         yfBAOqxIuybZsz1YwMBnNIiaiISOg5ybONGvxnXwpBryWNXVsEso+ghQcqECwJPlxdkZ
         UofSjY6mqd+BImvkYXQtGO0MeBMrsSiuKCRUrP4fZzA2UfOo74W+9Henlp3dSLvUKTPW
         LqaH2vBRakc4d5ZyigWcX7cNwk4FAuna3w8MYSN4a79ym3jdqs1ON6EXnqg3lyeJOS4I
         mc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532083; x=1701136883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZExWn2HUbFMStGLP1W6Y7/MeyCrX5kAskFZ5sfppJnI=;
        b=RCuMt0TDN5/q61mzigU0sjebblIJNtvQqev1+/x1dFFZYx2s/l5fPwTqjRAHxe5/Pf
         XmD69qHSz1GRFAL9XgvE0uIBCR9bnZUg3nRX02dy4VwX3zc8ajTvrGtY064y38KmHm/N
         0BWiAvbEqfyq5i58w8P5Bas3gqsaLAUUlMuo1Jrjy/FAOxiC67dZ2zd91UhYIULs69Ip
         H8JrAfaiZxFRnbxFx2S5lSxaLh5M4YsP2uL7gPkJLHeZ3BRd3wOiq3zYKKP6IuN/fL6N
         b2ki5TOWAkVaSYVTyN69taHZHK3KMg46ZQnShPL5I61utgtTgXZw7C7smBKrSWTB+WCL
         C/7g==
X-Gm-Message-State: AOJu0YxAk9adW3tS5VRCsSi4U5+fIZLbm0JeKeu9sTxHlp4aoOv85cDQ
	aNaKIacAlgWfiR5kIXpUQVFBiQ==
X-Google-Smtp-Source: AGHT+IGwH+Jm3fhAA2Y4A+PtIJ/Xkb9mBkTjQwrh6HTcGOyrbjlcqDCPoP+VO0DQh3tKq4GMTPx0eg==
X-Received: by 2002:a1c:4c09:0:b0:407:73fc:6818 with SMTP id z9-20020a1c4c09000000b0040773fc6818mr893800wmf.2.1700532082945;
        Mon, 20 Nov 2023 18:01:22 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000184d00b00332cb846f21sm2617105wri.27.2023.11.20.18.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:01:22 -0800 (PST)
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
Subject: [PATCH 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
Date: Tue, 21 Nov 2023 02:01:07 +0000
Message-ID: <20231121020111.1143180-4-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121020111.1143180-1-dima@arista.com>
References: <20231121020111.1143180-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Listen socket is not an established TCP connection, so
setsockopt(TCP_AO_REPAIR) doesn't have any impact.

Restrict this uAPI for listen sockets.

Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53bcc17c91e4..2836515ab3d7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3594,6 +3594,10 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case TCP_AO_REPAIR:
+		if (sk->sk_state == TCP_LISTEN) {
+			err = -ENOSTR;
+			break;
+		}
 		err = tcp_ao_set_repair(sk, optval, optlen);
 		break;
 #ifdef CONFIG_TCP_AO
@@ -4293,6 +4297,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	}
 #endif
 	case TCP_AO_REPAIR:
+		if (sk->sk_state == TCP_LISTEN)
+			return -ENOSTR;
 		return tcp_ao_get_repair(sk, optval, optlen);
 	case TCP_AO_GET_KEYS:
 	case TCP_AO_INFO: {
-- 
2.42.0


