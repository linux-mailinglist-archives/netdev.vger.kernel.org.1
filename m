Return-Path: <netdev+bounces-174618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB37A5F8D7
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58B67A5696
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B6A266F03;
	Thu, 13 Mar 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="BM1Mm/Y3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="IUP/1JAD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50623BD13
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877200; cv=none; b=FOjTOQueIRJNufWSFp3m3KNjYEkCRwD2NZNjxv4Ns1LAUIxfOXNrUySI5Y0qTyykm/71n0yCGl5JpwR6u7tymQ27IE7etGLXXKH0wKDAw5MoYDfG1YdX4gyiTOolz4c6kQF5JlH4MM96EGuYsYIUVNeNN/cqGmB0Wf3DvPdjmEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877200; c=relaxed/simple;
	bh=I1IeQ3eOXuWo1Koz+4tC5CMTNtvDWBowb/FldwOpw5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEyh2SZSNybN+adJm5DyPruTM3LwuIi0tqu9EQ7m4fzZ7mPKdtiR7Qo9XurlkN3SB5f3jLgeRkuYvwdF2Xl9LbdaExlf7eWHJouIAFTOzuL3NTneAtkwd1EYxcGLBaNFkfm4KBsYSLlCggX5K/6lJuSbwSFYGL6QFfYa0VJ0yVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=BM1Mm/Y3; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=IUP/1JAD; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=tPvGIJIyPV9aObwYTmTs464VPbIIZSjvl5woqjoKk4w=; b=BM1Mm/Y3lpDG2un
	313hi3KkxH0BYFEaXXQp53laVSc0vJ7mS7eP2W+MIWQriX+JfJiq0UE9UeU52xlf1hFWGBw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=tPvGIJIyPV9aObwYTmTs464VPbIIZSjvl5woqjoKk4w=; b=IUP/1JADWrul2sI
	RCIuxdYlJv3zfS7Qi/XG7FdSMkm9TDtXVIDNbPO7L+V23N4GDYc0VJZHEQ1O771rcoKsvctqJ+5ak
	nXtRzo/WGIDTlswsXn8Ic1+vUMYECD7h/wXMvsHXYoT4dWXNO8vy1GRVSkMAlrNZC2t7zE+Weu6aY
	uAPEt0jbUTgf0DyMucanMD6PubRDesu7C8Xn19IGmhsJuirb2mCGAk25QLsO07tn8XWHETYZkci7z
	CwGpHPWouEXA4n6jYMIn6mpEmiyxPpiL1lU2KZnsglPR2gnw4rx9l86QSquBitvBnTGbUmQ+jLAEJ
	HDRXYGUTDI9yD99Bnbg==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.114)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1tsjpU-00000002LY6-2HXc
	(return-path <jgh@exim.org>);
	Thu, 13 Mar 2025 14:46:36 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: Jeremy Harris <jgh@exim.org>
Subject: [RFC PATCH net-next 2/2] TCP: pass accepted-TFO indication through getsockopt
Date: Thu, 13 Mar 2025 14:45:51 +0000
Message-ID: <3e9b638ad6846aff954a590dd87f764684a4ec8f.1741877016.git.jgh@exim.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741877016.git.jgh@exim.org>
References: <cover.1741877016.git.jgh@exim.org>
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
index 32a27b4a5..e958a145d 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -179,6 +179,7 @@ enum tcp_fastopen_client_fail {
 #define TCPI_OPT_ECN_SEEN	16 /* we received at least one packet with ECT */
 #define TCPI_OPT_SYN_DATA	32 /* SYN-ACK acked data in SYN sent or rcvd */
 #define TCPI_OPT_USEC_TS	64 /* usec timestamps */
+#define TCPI_OPT_TFO_SEEN	128 /* we accepted a Fast Open option on SYN */
 
 /*
  * Sender's congestion state indicating normal or abnormal situations
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 46951e749..407bdfb12 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4146,6 +4146,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_options |= TCPI_OPT_SYN_DATA;
 	if (tp->tcp_usec_ts)
 		info->tcpi_options |= TCPI_OPT_USEC_TS;
+	if (tp->syn_fastopen_in)
+		info->tcpi_options |= TCPI_OPT_TFO_SEEN;
 
 	info->tcpi_rto = jiffies_to_usecs(icsk->icsk_rto);
 	info->tcpi_ato = jiffies_to_usecs(min_t(u32, icsk->icsk_ack.ato,
-- 
2.48.1


