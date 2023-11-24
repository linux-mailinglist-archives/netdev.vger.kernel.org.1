Return-Path: <netdev+bounces-50676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4335B7F69D0
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 01:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F00D281752
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 00:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7F1394;
	Fri, 24 Nov 2023 00:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kNX70Na8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C310E0
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:27:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so931571f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700785654; x=1701390454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1xPXn0VYaTrAb1Nt5Hiecyvp9SYb9ivj7o6hsBOhvw=;
        b=kNX70Na8pKjSa3xGst8Rpujm+GWUhvSGTclIDfRRCyNe8VAGiC0kCFDs2LgBC6QAsi
         PWMlwGHQjC3/9UhgOpfCnlPzbv5+NDyJY3iVHirdie19HeFLHKsh9i8zgZ4eHaSPHSSs
         6LQjHDwNHnX+P0JXGGG2Rfx/NqwuN/9fxgwmMaGq1aruqptUAM6zZM2Mt6IrXe51po3q
         6coH0/w8jZrLHxlulDYTy6OLgTPJ4zjybVb6atjr3bOoiIXxlFbTktzWj4cV4v3DWXIw
         9JwVYh0yZhKk0cUt0NhoYd8alsx5EMEy4yKs16bvC9Wsmg8wsDazytOou2f5CqFFrC2D
         DuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785654; x=1701390454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1xPXn0VYaTrAb1Nt5Hiecyvp9SYb9ivj7o6hsBOhvw=;
        b=MhMGq0pvnjWDH0JUayNF887RJxA3FunJ9m+RUT5TEd67BXadIKQ6NWvbNs787vs0By
         GkfSD9pLKDn8Aw33lA3KKJidVTwndPR0BzIgPK7NnuZVcA32EmLDj2MA6Nr+8kFJFWGf
         D7tCZkgyU1PyNqmc+2ftskGEarPiBDsbqgeYQyMCBbUEeKK1t3tJbk6U4YkOF0+lL+C5
         hNeQ5UKNDJK2FfPe0noBlVVwdE9z5mzK7z6tri4dhV7eIzuYGerV5cpOtfywpEGz9Lyw
         dOdEXYwNFCIP2NgaOS32FdTC1AeZuO6TsEAFxwP/j2dAAJZVjP+jo82r8NDCG6ISAndd
         d12A==
X-Gm-Message-State: AOJu0Yx52H/6ksO8WrherTojsibXZV2QPOfl03eFtc54L70tBgOm3ViG
	DSjNVHSe7gdMONpfyvI7x3yDxw==
X-Google-Smtp-Source: AGHT+IG6PXq1iNo8Vk7aSZGEmmqJsJVa5x8rz0czmMerFM1PyZtMnYrAhUZ5YJhqhvDh+LrGls+v7w==
X-Received: by 2002:a5d:5488:0:b0:32f:83e4:50e7 with SMTP id h8-20020a5d5488000000b0032f83e450e7mr596208wrv.12.1700785654680;
        Thu, 23 Nov 2023 16:27:34 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm3453230wmo.23.2023.11.23.16.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:27:34 -0800 (PST)
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
Subject: [PATCH v2 4/7] net/tcp: Allow removing current/rnext TCP-AO keys on TCP_LISTEN sockets
Date: Fri, 24 Nov 2023 00:27:17 +0000
Message-ID: <20231124002720.102537-5-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124002720.102537-1-dima@arista.com>
References: <20231124002720.102537-1-dima@arista.com>
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


