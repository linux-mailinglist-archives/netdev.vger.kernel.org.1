Return-Path: <netdev+bounces-52201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1004F7FDDC2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF80E282870
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4062A3B781;
	Wed, 29 Nov 2023 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="f9KL3HCO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC4712A
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:57:38 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c8880fbb33so412761fa.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701277056; x=1701881856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsdu422pJQjO0BqPdllEZym2Fb8ES6Mcal0EPWQmR7E=;
        b=f9KL3HCOpaCvbTPJvpOn8D0J3f1avIaNEjj+RMSuSeFUKWJAvCwHuqitcdo3qetluG
         g5HacNcFJWcDNKTuAFtv3sE+QeVR2jkC5EXJFQ7Rq633wQHwiGRTQu5ryaGLm77KmkpN
         44Vl8SmP5zgXVtzMHUNbEju9HivJ/2xZP6UE7qjYNMSODcBFIFwGeTTvvUeKKCo3YmUW
         EN85tZS/HIX9TQOGgPaoDgT3kUCD86ApRAlgpepk3b/y/nefI099bJYh3OmL2iMw7JD4
         He9igxqxABuke729glawqOj4jSQoawZLum6PpVCVCehmsAL2JKhk6ebu1dU8zt1BFaO3
         Xlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277056; x=1701881856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsdu422pJQjO0BqPdllEZym2Fb8ES6Mcal0EPWQmR7E=;
        b=A5xllVqw2re1fxlEcOaW6UKLCQM/3zDeyQG3OodvkCUSsb+fIoa1xQU6E0eFkOnfFw
         bhA+GOxdWnMxcI4KOEAUhAVMHzoBN/Wv3MK5tXWO41ExZ/cMXei89JhdEZzuSMwxO1rm
         01dxyKl/jBAubR1/PZ0C7bWuYb2u0YalkYYjR3nhqX+rLKdwJ8WJzzrKU3pFhttprV3Q
         amtKzv3Qer/yj+QRhnQGGOKgTk6Df3B/Gv8PZPand/q4uGFmbqVBraxK+//AVqQh0aqA
         H61vUwz6tt3720gojPCwq2fyA30OEeeBc5F3+RJ5VXxq9IwpaKmSAES2Jz94BEzfow1j
         iQMQ==
X-Gm-Message-State: AOJu0Yxqi7NGcc0AxgYjueiK4YSv2tfRxpB8vAOW5IpLE4nGAw08+14N
	TJscK2QrO0Mlmx3UXvgDSfcnPw==
X-Google-Smtp-Source: AGHT+IEBO3LAafujznmh7ddUReBPPzlczL2XBtI86mq9ciLp32HOOwqam9My6KHDcct7H9Y/uKljTw==
X-Received: by 2002:a2e:80da:0:b0:2c9:bfd4:28a5 with SMTP id r26-20020a2e80da000000b002c9bfd428a5mr1496955ljg.16.1701277056099;
        Wed, 29 Nov 2023 08:57:36 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b003fe1fe56202sm2876823wmo.33.2023.11.29.08.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:57:35 -0800 (PST)
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
Subject: [PATCH v4 5/7] net/tcp: Don't add key with non-matching VRF on connected sockets
Date: Wed, 29 Nov 2023 16:57:19 +0000
Message-ID: <20231129165721.337302-6-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129165721.337302-1-dima@arista.com>
References: <20231129165721.337302-1-dima@arista.com>
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

Yet, nothing restricts the CAP_NET_RAW user from trying to shoot
themselves by performing setsockopt(SO_BINDTODEVICE) or
setsockopt(SO_BINDTOIFINDEX) over an established TCP-AO connection.
So, this is just "minimum effort" to potentially save someone's
debugging time, rather than a full restriction on doing weird things.

Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_ao.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bf41be6d4721..465c871786aa 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1608,6 +1608,15 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 		if (!dev || !l3index)
 			return -EINVAL;
 
+		if (!bound_dev_if || bound_dev_if != cmd.ifindex) {
+			/* tcp_ao_established_key() doesn't expect having
+			 * non peer-matching key on an established TCP-AO
+			 * connection.
+			 */
+			if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
+				return -EINVAL;
+		}
+
 		/* It's still possible to bind after adding keys or even
 		 * re-bind to a different dev (with CAP_NET_RAW).
 		 * So, no reason to return error here, rather try to be
-- 
2.43.0


