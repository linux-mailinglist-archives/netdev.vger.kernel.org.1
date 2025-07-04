Return-Path: <netdev+bounces-204099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BDCAF8EBF
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D5BB65CE9
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905252E9EC7;
	Fri,  4 Jul 2025 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Pq2h8jR9"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B222EA494
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620699; cv=none; b=RmMMcq1dU+KqtGIF4vwKg/l64WjR/ZEfq8mPTFf6Aush8QArOgMkqC+nxY+vrrhXWxg0f5w/PJLFwgrO8B5VxysFu+uBK6sewV4owU9Lf35HeK7BWNlwn39FciLesoID4Kcr5EX0tl475bgIlgc0rDMp0AmPCiq4neJY2y2M8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620699; c=relaxed/simple;
	bh=0zuS3RWBtUBodtvkf/ojgcQxdAESeriLKOF0Zsh0LuY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=d268uJEphWmCZJAPL6cwPCE8CSX/MNt15X09UBMINfc4Y5cA+HwyGin8u8vLGnDmhaIXi4t85n0j+CR60RpPYLDJvS6IH/ZgUZFxZRfWg4LA7hwrHmC3QYD5YkS/PkdNevSXY73QPYwEMvqN3ef9JS2HaB970K/ISBQl+TiXh8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Pq2h8jR9; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1751620690;
	bh=TmZzzFDNWWd+HL9IKxavp2on0YiqSG6V5RQgmiQWl38=;
	h=From:To:Cc:Subject:Date;
	b=Pq2h8jR9FtAiClHIuBqLCbZp8HdH53ngCqY2l7c5QN3Zc/z0g6n9ts8NTMP5d1Wrs
	 vE+5kYQ25s4RldjFQS3QXv60liRodgbXhsTeBQ8L+XXwexNr316YD0pNQzZ58p3xxJ
	 Aqp3B5q3Ph+rwXTFKBaD5FLxhZS5XhWr+Kexdv2Q=
Received: from leon-ssd.. ([2409:8762:315:25:f201:17a2:7f4f:c156])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 2A736660; Fri, 04 Jul 2025 17:10:39 +0800
X-QQ-mid: xmsmtpt1751620239tg1xl9jxa
Message-ID: <tencent_87F4A935227D7FACE9A05E681FC13882F40A@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XodI9PW+wxkOMr+IvwK49eI2hQONPfw0xcFsTGuhN1VbZLgSues
	 P1AaFSrJ6yLtqeQz8WAdShrbfLpR/8zTKQ+13RzxpTcmjcZ+CRaF54jjuh2tuxkHjU2CqgWSUoDf
	 X3+cckEKq8QfUukLt4a0tI02vP6EHwyymd2a+xQh8edjB/0HepEcwe8chn4Di9FYEm1fj04uCogT
	 K0uE5Ql3EHPPzidjEtfAgkNXZKUNeeod7OEwa6TJ0RglWHcSBgEZ2ST32zTVTQGjFOrxrM+9P7iA
	 PHsyM74qr4Iuj3cKcMzahIiXyyQUysmF45EeyIAVCT1e6vlPfv8OjpdWjAwli91ehLi0/UCHn6o6
	 /Ed88H+nmSmx0o5P8FfzYeUoKD81Rz9e7AHvoJ/gEjrltFBSPYzl/VcrVE5YcD9Tu2p2YdGXqSdG
	 XvqwSztJApVLWaoE8Obe7hl091BxoMsfYns5KFjG2HwJ//ysGm6OIDNu82vH+i5UCnsT1X1QGYvn
	 5Z5jqJvsWYw57ogX7HDGBOO/STqOUr7sdHBjXmEduRkYNbXM5YPDP1pRtee+wBDIN0srmfpq9xD2
	 3uh17AMifUq2WI7No9R5X3UrJQzixrvYLH+8OnUFWlXDH+ZiHqRXru9uMihLLhpVokulpuEqVPd2
	 cwZ0JPePaL124wxE5yrNRDi+QWZ4S1GDPgpCuFw1yLHnRZZj89tII41ly/PV25kUIu/HyfQ0TvE2
	 AWiTKzSxA7RxLPI9PqL8VCdlQyU3Q28oEy5xJJ9W4C89yJLRJagmkSDlRXfgtbywjLXMRJYNK61W
	 0u7N+aT0x4/xvQbS7IehEsdK5Th83iuxt8KWajAnYoDv0ZqIfYHIOK+pToB7KkIu5kZyTwOc5hba
	 KcXT67u10sL/KZDq8lkVERcZ5Mv/pfT1SDWw/fZm/V22YaOOt/AiiAKtbqsVjBQlDUPaq6uwX1kv
	 3rxrqNfrF1HvCs1QypZ9cTHDd22k7xFpZjR2JcdUzU+jIXdyVsL9bdRpXpbTnaFxbFVA+40AAlzg
	 XNZaX42AAkxs2Z2EE6YfhP6WTaosVXljxFd0iScNiEbpH5iyWd0O3t3VZso4Y3S6SU5zq6D6r8uo
	 uTc9vcTcuEroY15J/MktDnUs12uw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Liangming Liu <liangming.liu@foxmail.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	Liangming Liu <liangming.liu@foxmail.com>
Subject: [PATCH] net: ipv4: fix mixed tab and space indentation in af_inet.c
Date: Fri,  4 Jul 2025 17:10:11 +0800
X-OQ-MSGID: <20250704091011.1342429-1-liangming.liu@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes mixed use of tabs and spaces in af_inet.c to comply with
Linux kernel coding style. This change does not affect logic
or functionality.

Signed-off-by: Liangming Liu <liangming.liu@foxmail.com>
---
 net/ipv4/af_inet.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092cd8a..5a5aabb962d8 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -501,7 +501,7 @@ int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 	 */
 	err = -EADDRNOTAVAIL;
 	if (!inet_addr_valid_or_nonlocal(net, inet, addr->sin_addr.s_addr,
-	                                 chk_addr_ret))
+					 chk_addr_ret))
 		goto out;
 
 	snum = ntohs(addr->sin_port);
@@ -1167,23 +1167,23 @@ static struct inet_protosw inetsw_array[] =
 		.prot =       &udp_prot,
 		.ops =        &inet_dgram_ops,
 		.flags =      INET_PROTOSW_PERMANENT,
-       },
+	},
 
-       {
+	{
 		.type =       SOCK_DGRAM,
 		.protocol =   IPPROTO_ICMP,
 		.prot =       &ping_prot,
 		.ops =        &inet_sockraw_ops,
 		.flags =      INET_PROTOSW_REUSE,
-       },
-
-       {
-	       .type =       SOCK_RAW,
-	       .protocol =   IPPROTO_IP,	/* wild card */
-	       .prot =       &raw_prot,
-	       .ops =        &inet_sockraw_ops,
-	       .flags =      INET_PROTOSW_REUSE,
-       }
+	},
+
+	{
+		.type =       SOCK_RAW,
+		.protocol =   IPPROTO_IP,	/* wild card */
+		.prot =       &raw_prot,
+		.ops =        &inet_sockraw_ops,
+		.flags =      INET_PROTOSW_REUSE,
+	}
 };
 
 #define INETSW_ARRAY_LEN ARRAY_SIZE(inetsw_array)
-- 
2.43.0


