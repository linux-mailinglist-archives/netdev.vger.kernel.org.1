Return-Path: <netdev+bounces-185133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336DAA98A0F
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EF73BEC3C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C164266EF8;
	Wed, 23 Apr 2025 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="2g+ZW6Ul";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="DXYVAglg"
X-Original-To: netdev@vger.kernel.org
Received: from mx.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CD326F464
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745412247; cv=none; b=BCY4p2nwTcr1i4WhVdyQrP4nSiXnXI04YasXmGzilU+6zp7a/4jx7qO+5ZncvGREjROwI4y2mDNybv8z3Y/LfOV8U7Lb/+rXQkGy8m8HFzfwPGq9LmBWgAL3vHAYmy+atTIQup1lF9QYyvN+aNzkyBTvpuv60AGgiZsJb6+r2Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745412247; c=relaxed/simple;
	bh=K8FCxOk6a+Z11NsgzUXXL8or439Oqf2e3At0ed3gKs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuaF/0erwWNVXMhcFxqAKm+fW6stqbhosYHLiZB2pagEG/C56TptL9Hn5s4qpRqQ/kT8IFVXSHtZ2yG2fbsSyRQZlfpFC1Ua2O12GC4e7Syj/7cCJU9S0I8mtcYZ0u7fJkDIjUzsUA8Tx+dQWDKgktVo9EpiS4vXZ/v8e3gcdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=2g+ZW6Ul; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=DXYVAglg; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=8xXBdYs6HbRn4bsgu8EGHUJCOwSmtMVKQY8Hhk0eRpY=; b=2g+ZW6Ulh0oo4cF
	FtbBjGSY6iriKxLS60L1udpORhtu6lGIq+JOqQw5BiExtM/8ubhsQblN+2g90/aK2VcF8DQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=8xXBdYs6HbRn4bsgu8EGHUJCOwSmtMVKQY8Hhk0eRpY=; b=DXYVAglgmwMY8Zc
	+IUbNcoqjjsL7QAfZvO6XZs3aTYrP6GLchpigS++pOgQJMbcGyxb/RlUb+QLK0tVNR6vGbUjS4y8q
	k7+bvw5Aa7NtK5WqZqypcO6xfNx3zNpPiGZNgFTIuEQIhjNcbTJEUdb9NB6nizX/vBHXs0X9MN6Fh
	+dg6sO+kTh421YW/YwJENHWp1ej0TUauVMMjHWwz5JdTQhFoFQG72bMGxwwwtKLlYv8F8RyD4BPI8
	9mNXbLWtHDt6Vi700Y6xjGykZV3GiVqfF1DbBESCb8Mm1zFRDwZSGAMWIYKbcMbprJdnZC2YfXlp/
	a8IahNuNg+F5wPzIU2Q==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1u7ZSN-00000001iTg-072j
	(return-path <jgh@exim.org>);
	Wed, 23 Apr 2025 12:44:03 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH v2 2/2] tcp: fastopen: pass TFO child indication through getsockopt
Date: Wed, 23 Apr 2025 13:43:34 +0100
Message-ID: <20250423124334.4916-3-jgh@exim.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423124334.4916-1-jgh@exim.org>
References: <20250423124334.4916-1-jgh@exim.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

tcp: fastopen: pass TFO child indication through getsockopt

Note that this uses up the last bit of a field in struct tcp_info

Signed-off-by: Jeremy Harris <jgh@exim.org>
---
 include/uapi/linux/tcp.h | 1 +
 net/ipv4/tcp.c           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dc8fdc80e16b..bdac8c42fa82 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -184,6 +184,7 @@ enum tcp_fastopen_client_fail {
 #define TCPI_OPT_ECN_SEEN	16 /* we received at least one packet with ECT */
 #define TCPI_OPT_SYN_DATA	32 /* SYN-ACK acked data in SYN sent or rcvd */
 #define TCPI_OPT_USEC_TS	64 /* usec timestamps */
+#define TCPI_OPT_TFO_CHILD	128 /* child from a Fast Open option on SYN */
 
 /*
  * Sender's congestion state indicating normal or abnormal situations
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index df3eb0fb7cb3..86c427f16636 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4165,6 +4165,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_options |= TCPI_OPT_SYN_DATA;
 	if (tp->tcp_usec_ts)
 		info->tcpi_options |= TCPI_OPT_USEC_TS;
+	if (tp->syn_fastopen_child)
+		info->tcpi_options |= TCPI_OPT_TFO_CHILD;
 
 	info->tcpi_rto = jiffies_to_usecs(icsk->icsk_rto);
 	info->tcpi_ato = jiffies_to_usecs(min_t(u32, icsk->icsk_ack.ato,
-- 
2.49.0


