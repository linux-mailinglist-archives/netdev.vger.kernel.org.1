Return-Path: <netdev+bounces-51839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C767FC678
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52954B24640
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A9944397;
	Tue, 28 Nov 2023 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HmmdyVic"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D791988
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:58:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3316d09c645so4118961f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701205081; x=1701809881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH55LyAvyZzawnq9+CybIblcEgwIvM5k9Dss3KgMZik=;
        b=HmmdyVicb+Gio2HiMJd3tUHpYD3UtHGuqKbmpQVFPS0yO3lwH9qDwS44Q400nL4smB
         GOM1kyxi5Xp8PCCvvGSCxj2c1Qcoeg6n1a78/oazpyYTV6+/4238Mf7D4t3edqVf0Y4x
         UDzrcnzq/Ebg3G40kFNWjevQ1eYwBZP60A9b0ENrNMzFHCxnyhjg7jj66duuQdtiIf7/
         j2mljug07ay4d53v+pyLlDvINSHD8vPIDXvV5UB8u1us6fxGTX5w0BDVu01Nvh1g6ia4
         /OUW9QIR4UlJC52wpTTEQPVXpaj24E3H7xE0yjD+q1FYx0zs6v6wsWbFdsD/XiFx7gdg
         EPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205081; x=1701809881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH55LyAvyZzawnq9+CybIblcEgwIvM5k9Dss3KgMZik=;
        b=Cx8laG1ZZU0A5ZEip4ZJKzrHKl+cgLngl9/Lp1lXD5QaYPQMY+DKNTNQ1x5/70Y+rW
         qdMKAgMa4o+1EEb1tqU2jEbDiUbblsNJckuiV0JEKcZ2EzRBaKTJ8cS1R9yQ1+Qj/BWO
         +sSmRFCJYP2QG2jTZkPMiuhSaUHXdionP31ICNsbf7NkUMCgCyG5idB7n760wo7I961W
         nRXlmU8U/Zf9h/PRAWHTEMVNCCORO6hzRGIVALi6Xm+SQ7LF0Ivbf93+no6Ve0XGZaQX
         X8HdLcB4GEWIziP3D43Li7pp2Lgv9xkAOEwuKF2y2U89/4AqK5HSRTXYRSaE3zreuKww
         lVJQ==
X-Gm-Message-State: AOJu0YzCPadBLvPZY5T3mQy7vhOqja/FfkUwBDaHyjKUGuPu3qh4vwmT
	iniPWmXM1gKYqIpFt+MOeMSWoA==
X-Google-Smtp-Source: AGHT+IEEw9yaLxtyh/n9vNZ50WJjGGVyxYA3jZ7C+dAdpxv6LW5qIRnZ1+iYhFS7TM0h/xhRc489sg==
X-Received: by 2002:a5d:638d:0:b0:332:eeba:ee8f with SMTP id p13-20020a5d638d000000b00332eebaee8fmr9647295wru.11.1701205081195;
        Tue, 28 Nov 2023 12:58:01 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0040b45356b72sm9247423wmq.33.2023.11.28.12.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:58:00 -0800 (PST)
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
Subject: [PATCH v3 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
Date: Tue, 28 Nov 2023 20:57:45 +0000
Message-ID: <20231128205749.312759-4-dima@arista.com>
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

Listen socket is not an established TCP connection, so
setsockopt(TCP_AO_REPAIR) doesn't have any impact.

Restrict this uAPI for listen sockets.

Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53bcc17c91e4..b1fe4eb01829 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3594,6 +3594,10 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case TCP_AO_REPAIR:
+		if (!tcp_can_repair_sock(sk)) {
+			err = -EPERM;
+			break;
+		}
 		err = tcp_ao_set_repair(sk, optval, optlen);
 		break;
 #ifdef CONFIG_TCP_AO
@@ -4293,6 +4297,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	}
 #endif
 	case TCP_AO_REPAIR:
+		if (!tcp_can_repair_sock(sk))
+			return -EPERM;
 		return tcp_ao_get_repair(sk, optval, optlen);
 	case TCP_AO_GET_KEYS:
 	case TCP_AO_INFO: {
-- 
2.43.0


