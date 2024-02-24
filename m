Return-Path: <netdev+bounces-74683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCC9862393
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 10:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131611F23B15
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 09:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97471A702;
	Sat, 24 Feb 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="eI8XeX+w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35219179AA
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765487; cv=none; b=sWwdJkEe53rOTZ6fV/alxSXA9dCLnytsaXUMdKBJsn7MdJKUCsyV4RWMrWYHFf64covqgQ3RkstvSGVTgwpqeqy8cYtyTQinD1ISwLTpaJnGcmcCFAn4RWx+ANwh9RELQFUOQ6qOERL7vykHNL2ECbSfLmfnEF6vlseBJYU0GgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765487; c=relaxed/simple;
	bh=ZnGxdQGJy1ClaaFcPFlryVbb4hGecUZML2DaP2kkzLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmngIZmjZb6Lq/wkSRB88RS51lM2HZztHjM10u1KHXAz4tZqWB8dSIa+O69BiyLlgqV6VDLOtG7y53Zv2j6UZfTysvbIpboOCs/nQOg+TdWobPoF6KJ9RU9tM/UTX7u7FWuTsN5gxsryZV4bU0WxbQlM+1qTECuUtX899gogiDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=eI8XeX+w; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4129ed6f514so644145e9.1
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 01:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765483; x=1709370283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHrQr/XJfBtNje1BbDqA25SZP6hUvJlYF/SVh1AtKWc=;
        b=eI8XeX+wRqalUFQitMgR1L6d2VjXQSZ1tPvZas+cPzBwtLoIx+IULGFFduuUVL8fnz
         zKXLxO5/OIAsQQTMiCHvIa1DFIyQSVTRN3h65jE1DbicXJwmo1YILfNcgK5fmRAcXNef
         rmhxndqrnOksZLIBBGSxBFVBh0mWueMNxl4QUPcy7uQz70Cuxi1m2NqXpXPmq9va9td0
         2NnWd/mAp8BeLSVcrS0PzRtGBzxpwhzMaj3wHib87U8dRZMJwcd0Ixr5VWsrrew39EFy
         3PAE5cqX2IyMnj2YH7rwo9lb7jJyF0b5kaTifLDunHjiG+N9vV4E/eG6VoLb0S6TycP8
         BMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765483; x=1709370283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHrQr/XJfBtNje1BbDqA25SZP6hUvJlYF/SVh1AtKWc=;
        b=H5hsjc7CdyGMKbeYoIEglCVgTUECNgecdPu17EqHbRTxDUt+bISNEn8qGLAcx/PZGe
         pB41ACiO0fGExOX6sVnYiIS+61gsilLjK/C78d1QVsbCsV3Hlei7cn+mvnMIv5UePphs
         bhR0VAca0Ba4FPpoLmNpBCALET4OroEUui9VNonj6ggSieeUthYw3FFfGYflEeiB6xI2
         7BzGOETM6OT1Vs6tmjdpLxZ0Gq5kjWDfgV8wEeezOm5E1jkFdNYg6oTRjbTe7cPzbIP6
         K+4YhQ4C5N00CX8RHwfikP14cfVYbC4f58oxEEwJnLH3nt0TWj8rMO0vS8g0WxA9bUmk
         hL6A==
X-Forwarded-Encrypted: i=1; AJvYcCWMOGBmNBB8BF7H9HyR0cfsPIRkYHFrbxY0byg3gYLaS0pXiElYyqjqn/RdQIEFmqwrKWE4vF/Zp8MJnW7IUQYKGK//+bhB
X-Gm-Message-State: AOJu0YwyDqJYJep1EoawLXXLKXztKC0SkEAQwO1JL553kde7P4w4X8At
	aBGNtrMWXNzh5aa4H8dA29IvCG35pFazzP+AqlYakFCek0V4d+eYv2cBzw+xZQ==
X-Google-Smtp-Source: AGHT+IHzc6qo+/osCEweqq/ftRcXkWVdH0DBlbOnEDsN3aOfXaqN9RZnuvJwsrGdKEIUTGWViyIiEQ==
X-Received: by 2002:a05:600c:5109:b0:412:610f:c2e7 with SMTP id o9-20020a05600c510900b00412610fc2e7mr1544855wms.41.1708765483493;
        Sat, 24 Feb 2024 01:04:43 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:42 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net-next 01/10] net/tcp: Use static_branch_tcp_{md5,ao} to drop ifdefs
Date: Sat, 24 Feb 2024 09:04:09 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-1-15f31b7f30a7@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=2366; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=ZnGxdQGJy1ClaaFcPFlryVbb4hGecUZML2DaP2kkzLg=; b=YSWRW5wa+c4zamP9YG0WiY8b3kvQg+Hs5tBhsFDlmGdWW+fFHBs58d2MLzy98VPbD0bMlZuKP 7VdCGuaclWIDZ9N+RulWTS1iDcO0YMqwrD005kHZ5vXbl8FA7sDewrN
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

It's possible to clean-up some ifdefs by hiding that
tcp_{md5,ao}_needed static branch is defined and compiled only
under related configs, since commit 4c8530dc7d7d ("net/tcp: Only produce
AO/MD5 logs if there are any keys").

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp.h   | 14 ++++----------
 net/ipv4/tcp_ipv4.c |  8 ++------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 33bf92dff0af..c1fff9207e2d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2369,21 +2369,15 @@ static inline void tcp_get_current_key(const struct sock *sk,
 
 static inline bool tcp_key_is_md5(const struct tcp_key *key)
 {
-#ifdef CONFIG_TCP_MD5SIG
-	if (static_branch_unlikely(&tcp_md5_needed.key) &&
-	    key->type == TCP_KEY_MD5)
-		return true;
-#endif
+	if (static_branch_tcp_md5())
+		return key->type == TCP_KEY_MD5;
 	return false;
 }
 
 static inline bool tcp_key_is_ao(const struct tcp_key *key)
 {
-#ifdef CONFIG_TCP_AO
-	if (static_branch_unlikely(&tcp_ao_needed.key) &&
-	    key->type == TCP_KEY_AO)
-		return true;
-#endif
+	if (static_branch_tcp_ao())
+		return key->type == TCP_KEY_AO;
 	return false;
 }
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0c50c5a32b84..56dfae81c671 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1050,12 +1050,10 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 #else
 	if (0) {
 #endif
-#ifdef CONFIG_TCP_MD5SIG
-	} else if (static_branch_unlikely(&tcp_md5_needed.key)) {
+	} else if (static_branch_tcp_md5()) {
 		key.md5_key = tcp_twsk_md5_key(tcptw);
 		if (key.md5_key)
 			key.type = TCP_KEY_MD5;
-#endif
 	}
 
 	tcp_v4_send_ack(sk, skb,
@@ -1124,8 +1122,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 #else
 	if (0) {
 #endif
-#ifdef CONFIG_TCP_MD5SIG
-	} else if (static_branch_unlikely(&tcp_md5_needed.key)) {
+	} else if (static_branch_tcp_md5()) {
 		const union tcp_md5_addr *addr;
 		int l3index;
 
@@ -1134,7 +1131,6 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 		key.md5_key = tcp_md5_do_lookup(sk, l3index, addr, AF_INET);
 		if (key.md5_key)
 			key.type = TCP_KEY_MD5;
-#endif
 	}
 
 	/* RFC 7323 2.3

-- 
2.43.0


