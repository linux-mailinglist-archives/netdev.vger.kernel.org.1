Return-Path: <netdev+bounces-53601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B84F803DF6
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768C31C20B00
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453FB3158C;
	Mon,  4 Dec 2023 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="g+XrIukv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F3FA
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 11:01:02 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so658099166b.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 11:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701716461; x=1702321261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ0D/wyA9hkFzwdAxUoMggZbpJ8bxr4KljB1d44II90=;
        b=g+XrIukvP0kRCHm1wfbmqM8r0VQVu6xuEBcmVoF30BWysxs/NXepuTJ4VWFsM5KQbG
         whlC6LZMhvoNdi2k3CacicYWvF0WUQxWAIC0bKC1ThkjIkeq+qaoRWiawNzIXXByV8QX
         cXhk+nztqP6KPLMBU0az8sMelaisZxb5TSwVgc1k4UbXTjv8sSrU/rvzJMrnissiIncD
         nHphrmgqi1tLeymm7x5onw2Y6e6OTmcCsX9Ed/7+09cThzsWgEkjmqOnGhtG/aCo5408
         vsM0MbgPm7NKUEgvS/KRWxQMosh2lJNaQ87NpG/sRFbNqzZF9bcYouMjCgBFgv4Y0K5F
         NXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716461; x=1702321261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZ0D/wyA9hkFzwdAxUoMggZbpJ8bxr4KljB1d44II90=;
        b=JQMzzE7I8UiP8xh/RJ7Y42Zn3XJFlNNMtaeS8SHA+LmbVZ1aRPKjVVDKpsSuKbc08W
         8kOWnbTzeYce9uMs9h5Bbb1xFRx3doGDh+9s4xK/zHhK3Ss3ueoBaQp8+7gnNBB/g4on
         MdzYBwqy8C9K/o9MxL6a1QX4nmPF6RD4Qb/jHTLqMegJwFTrlGxhP7fC5pUXaBFlT/om
         0hyVBP13lDgAfFWXol5l3jwW1ryPFLqxA8/d8We5v5za1aM0VOUda7YUIculxLTyxNgq
         /IJ8IpZErIognuPoiDBEAhl4fbc+5eMEGcQ0MC+S+W56xL8JyvO60iNgVWWIDNfwNJ6t
         TNvw==
X-Gm-Message-State: AOJu0YwtJeiSo77DEc9pfwPZdnfS/Ul/+Zda0f3tAZzmv5sNOKUSmPXq
	ZSHH+QrJgz2y9OOMOAqYf1xrsg==
X-Google-Smtp-Source: AGHT+IEc7vGGV71ZVxCXlwrJR73WOT9vS/GY8jEInO10aGkvo+/egFEHgnMpiVqeaedADYMg7gZqdg==
X-Received: by 2002:a17:906:220f:b0:a00:2686:6b42 with SMTP id s15-20020a170906220f00b00a0026866b42mr2988048ejs.10.1701716460982;
        Mon, 04 Dec 2023 11:01:00 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id dx9-20020a170906a84900b009fbc655335dsm5577614ejb.27.2023.12.04.11.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:00:59 -0800 (PST)
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
Subject: [PATCH v5 4/5] net/tcp: Don't add key with non-matching VRF on connected sockets
Date: Mon,  4 Dec 2023 19:00:43 +0000
Message-ID: <20231204190044.450107-5-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204190044.450107-1-dima@arista.com>
References: <20231204190044.450107-1-dima@arista.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_ao.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index c8be1d526eac..18dacfef7a07 100644
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


