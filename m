Return-Path: <netdev+bounces-174620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 866DDA5F8D8
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088B6189D995
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C63D268681;
	Thu, 13 Mar 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="RGpANJYa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="gYEBeokD"
X-Original-To: netdev@vger.kernel.org
Received: from mx.wizmail.org (mx.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3C42AA6
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877202; cv=none; b=UL66lcssEC6+IffVxINVZ4Rf5C914EGwt+cCha0buVut+tHB7j1vg38cyi/vUfIsc01tVh4nY8lGhSMzJddbyXrHPuWtuy4qziPWVYlaNpNZHDy7NsykBixcE+YmJCq/Ho2ktbU6xO4OnJPSQDJUWxTNQBKtwmcD8M2XPYTlxVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877202; c=relaxed/simple;
	bh=Fsc+vMz8I3RqN5mlBV6YHe57SmdMQaJpXVW3XHPoT0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqsSRBEdV4x9LCgKyac3JTurH+WBD82o9tsw7zvrUO67ExHhkYq+ZF5G0Ha0FxsaxsNhXAhDjBID3lwoGJskM4PnWpaKbstqdIrdnfhUmRYo+qzVbn40EsASf6p9SO1O/qTdi+aWWGVaIdynsrBzYkFQyEOBWjiRA8V5jbU3V1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=RGpANJYa; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=gYEBeokD; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=F23AVpItGdOUEfO2vSwM2bznFZqro9XqN8NxL85gzL8=; b=RGpANJYaGtpLyC8
	qpErP2nqmkCIEQyjkdcV+CJ1N7iAxUeLkBaHz3NKyeziN4Pw6ucp4d31oiaQRO4TTDvQOBQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=F23AVpItGdOUEfO2vSwM2bznFZqro9XqN8NxL85gzL8=; b=gYEBeokDdIOKi6g
	0e7ct++STf+KZLLQUeeR9cdGESiUFPCnDIKgCs8nbTTTmU6gly5buTq3iN6Ckf2anHJBfQzl2N8sl
	+vwfsLhaklC3OKG7T87yYFK7BzUdGozzLNzDlac1Fyt0HoC4GpYWVEaYCyBgGjhnpOtbbNc7vkXko
	rUCDH8RvfZ6xZzNa3WUuUfQI7M1GLYE/OuN1XEa1krLe9UqttNECezKU3tSCGBa53qfm7EQq8BBzg
	jHxNtYky9Yp0R5+2+d+bijHJV7H3UkAPimcNNridOAqD4+ZnAHJA1Bv2ct4shBvUc5gKlamxcZal+
	yvBSnQ8BcbvhJJd0rcw==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by wizmail.org (Exim 4.98.114)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1tsjpU-00000002LY6-1fTi
	(return-path <jgh@exim.org>);
	Thu, 13 Mar 2025 14:46:36 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: Jeremy Harris <jgh@exim.org>
Subject: [RFC PATCH net-next 1/2] TCP: note received valid-cookie Fast Open option
Date: Thu, 13 Mar 2025 14:45:50 +0000
Message-ID: <93b4b95893b9cdd1afc06f22db7f9389a9c906e5.1741877016.git.jgh@exim.org>
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
 include/linux/tcp.h     | 3 ++-
 net/ipv4/tcp_fastopen.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 159b2c59e..c32c8ba59 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -382,7 +382,8 @@ struct tcp_sock {
 		syn_fastopen:1,	/* SYN includes Fast Open option */
 		syn_fastopen_exp:1,/* SYN includes Fast Open exp. option */
 		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
-		syn_data_acked:1;/* data in SYN is acked by SYN-ACK */
+		syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
+		syn_fastopen_in:1; /* Received SYN includes Fast Open option */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 1a6b1bc54..004d0024c 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -401,6 +401,7 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
 				}
 				NET_INC_STATS(sock_net(sk),
 					      LINUX_MIB_TCPFASTOPENPASSIVE);
+				tcp_sk(child)->syn_fastopen_in = 1;
 				return child;
 			}
 			NET_INC_STATS(sock_net(sk),
-- 
2.48.1


