Return-Path: <netdev+bounces-183186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA0EA8B4F9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E975A1903F98
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC8A22B8CC;
	Wed, 16 Apr 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="oSA3Wpq2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="RJR9c9Fi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.wizmail.org (mx.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737D8224B15
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794948; cv=none; b=m4dstr739//ifkQyc1euZJXela96WXrat4zWulvWjtIXh4v/Z1D639SYpgWR4RBTiJFGIq38/scYMjtfO+dmVaGg52Mk7kP6BYMQWQ78hagETSw/gH7XUqU0V7Hh/D2nPxpSTO6Tvqvc8O/+0Qc97gHj66jDop7KB15oHIufhzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794948; c=relaxed/simple;
	bh=dCHsigpWEMo4NQUu9LJsK4GAoIsxCwsxl2i25EfGpI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQ4ocM+9GH3Js/XU3G7VK5iM1mPc/WvUt0miHFEZ3iH5r8T9ADWKspDFbpzfeZ8c1HEdlBRoaeNwYwfBDENiDgVk2XfuKDMGuWvpjTOco4ijWhjI+uXh4vD9849L+YET7ZxmmpdADmjf/ZL8CDfrxgKXi49TTigHXBMX+UB4ojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=oSA3Wpq2; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=RJR9c9Fi; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=+Fje1hVgwZymfbF+F31f4OQHszreUDjMcAVGc9dCiHQ=; b=oSA3Wpq2T1AC4Nr
	FwxAzZk6ugMbweLZq/2o0v93CXPX7fdqTmD/16ruPKinSj5ZX+FswN22+BUUuW8lIfhHpBg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=+Fje1hVgwZymfbF+F31f4OQHszreUDjMcAVGc9dCiHQ=; b=RJR9c9Fijp1ntlx
	yAvzU9uwtrL1cFWCtTPh4Qdt7cQW3p9SI2WWwijg2iWZ4mMSz0NZH01fUPQhMY/EsXpWhEuZ4ktLo
	7T+WzRlKVpwLzvk0vM+o1eu2Wg0cLUeZkgFapGCGIrTJUgIDLdNXTYkrB/EFCgPckC81HFBqLfGFZ
	Y04OwWgQOpq6TJmC9YK7al4csrYS8yTe3fqYLRP6d3ifSotVbnw63nk9BwIpCZpR3a5wF36w9ULlo
	ZKhYNYKkrNPfGk5XiS+mzQFKF8tX4ZpSai6MuraVBm9wprKvC7ntAVQWjak1+uga2q3QVDafsbQyZ
	JVOB8JpAUoBSm9VjZvA==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.114)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1u4yrv-00000001gvc-1P1S
	(return-path <jgh@exim.org>);
	Wed, 16 Apr 2025 09:15:43 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [RESEND PATCH 2/2] TCP: pass accepted-TFO indication through getsockopt
Date: Wed, 16 Apr 2025 10:15:38 +0100
Message-ID: <20250416091538.7902-1-jgh@exim.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416090836.7656-1-jgh@exim.org>
References: <20250416090836.7656-1-jgh@exim.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

Signed-off-by: Jeremy Harris <jgh@exim.org>
---
 include/uapi/linux/tcp.h | 1 +
 net/ipv4/tcp.c           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dc8fdc80e16b..ae8c5a8af0e5 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -184,6 +184,7 @@ enum tcp_fastopen_client_fail {
 #define TCPI_OPT_ECN_SEEN	16 /* we received at least one packet with ECT */
 #define TCPI_OPT_SYN_DATA	32 /* SYN-ACK acked data in SYN sent or rcvd */
 #define TCPI_OPT_USEC_TS	64 /* usec timestamps */
+#define TCPI_OPT_TFO_SEEN	128 /* we accepted a Fast Open option on SYN */
 
 /*
  * Sender's congestion state indicating normal or abnormal situations
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e0e96f8fd47c..b45eb7cb2909 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4164,6 +4164,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_options |= TCPI_OPT_SYN_DATA;
 	if (tp->tcp_usec_ts)
 		info->tcpi_options |= TCPI_OPT_USEC_TS;
+	if (tp->syn_fastopen_in)
+		info->tcpi_options |= TCPI_OPT_TFO_SEEN;
 
 	info->tcpi_rto = jiffies_to_usecs(icsk->icsk_rto);
 	info->tcpi_ato = jiffies_to_usecs(min_t(u32, icsk->icsk_ack.ato,
-- 
2.49.0


