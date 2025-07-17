Return-Path: <netdev+bounces-207835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71050B08C34
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA47D1A6397C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75A429E0F8;
	Thu, 17 Jul 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+0nAcmy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DF29B792;
	Thu, 17 Jul 2025 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753285; cv=none; b=LonsxT6/i0owKWah+tmMfYXuJoClwmwUO2wkO2AQfZY4vUSA6l0SQ+8QmftRlPW1O9DcHQmGNxx/JQOGdXna6H4RqubeRFW8/wbr/RvGqCLrVz+P4y1cMPjOd03n9GtFk7vpTveHW2DNfQf46TcrE0pQ3aT5vTxwZPGZSCdz4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753285; c=relaxed/simple;
	bh=+KnzwoKbA1GtBdrTr//kfdTYJsbn0oZ8P1T5y+ypoxk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1k1rW5W6v8QN8owrmEnuRaCcL/N1/3aNV1Lmvw/wfgSktSSHU4N2uivbLv12YGPXm2PI1SxxnUHC6OkD8OzMwjt76uP/P115ZeJ+Z7ThZ5VTUT6TxdSvHHglJgzCayAkyM0IbmfqTafRmVzMuiTSKZKLH2vjJ0rXGVzI64kZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+0nAcmy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4555f89b236so7937675e9.1;
        Thu, 17 Jul 2025 04:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752753280; x=1753358080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJmbqKfhPmGmgPRu3RIwXN3mEJ4fXgB708Rx4HkKDQU=;
        b=g+0nAcmySIGbOtGC6kNQZpjGfFADTXayie60AHaRpCGckTZU5IYoqfv3+Upx3xBtnX
         tWhYDor0v807lCwJHG/12qpR1t2YN6vjym5BLPdkmaLnbCiVDilhU3YTpLbrZ7UFExkj
         HYpdAdddgx3ccv/+m3XE3c1D21Ix7tuKGXKH9EQjWMZNunCfw0+lp1xVwW493QscYgrK
         OLfoSqfiNB8jB7p83NqKhATeJdjm43ex/l2JZbLJuRi8ZH5vAuP7XQTRMkBhm8kkXtV2
         MKMbEZ+g/Q44jQ5KQlGMXSNUyytfNNyYNOPH4cE984EH2QUMX9x7oC5546/oOFvIl6Hx
         9aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753280; x=1753358080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJmbqKfhPmGmgPRu3RIwXN3mEJ4fXgB708Rx4HkKDQU=;
        b=UkN5AvTsMD6CoftuG7g0ioVfHb8uHma0DQwsXYeHwQquddV1JW4SX5Ox5HusUhHG1D
         QzM4VX17TeszHK+PUfN/udaE51KB3NKTlPFF5tUu624wBCh14lUhpnZLmvcx2DC4sLHD
         IygXwL8I6s3byWD8tqwgKvrGzX1mAW+fY7k36uDotAD3fd01mAJZIFEHNm3MWOrfkmtS
         8zAPtMLoZal4kyWQ3xgjsDoYY0uRZoYb3VZWkD2P+QqEBUWvx5UEfTKBRfK8Gnt0cr+6
         qTc33aRU7EASWju/Cb9q/PIa5vv28bFPRGql1tkC3Tk3M9l0OqD9qK+A9bjSBdmudaN3
         yjFw==
X-Forwarded-Encrypted: i=1; AJvYcCWl60ZAsUa+S3aBnP8ZVy/aX/zgwnsaKgHvTLKVl5zh1Rna6uUHn9rYVL/i3b20JawOUbro8PBa@vger.kernel.org, AJvYcCXkZHptDO1qYyEpfVH66N4l7jboGXyqUiy911xzdIkBv/R4hFe5K3FIq+IAiVpnqPXhVfIxzHrM+xN4EMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KZzA6EZOKsQMFS8QqdnX/+IJMYncZMBfXiCoiK85sz+EUC6k
	/cVIyD8rHMGa8kaIIGjmXlzGvap/qpIcs502lIYDq3pogMQCh3sYiv0q
X-Gm-Gg: ASbGncvojh6C+b8mXaHjv/1o66ILk+mzBj+Eiw32M+vKDa09gXZObZ1Ssx9reXEzeQj
	5/x5HQOeEEBnPkJL25ENURoAawRJfnIv1mc06YDuF/amlpVyHoBqjs4YZyk8Ugeljp3veNlJTTH
	p8CY07pZUHkCP9Gy7zygYStB4L5qqbPfS4Wkr81tmNFEBg1qhdDjaTo4EfU31rIpSv9YNKXfM5H
	WsmjTU8yBCp8fbUcnPx6J9XuWAbNA+ju41+lc+v9Szm1bgSokK++l7UxNZ6bEydd3WmoP78+H+N
	iHDNiND0whtAl/n+a4AEtwZq3/yepnRhcugh2l41cLsjetHyB8WMw8SsqXauNmwh
X-Google-Smtp-Source: AGHT+IGWrPQzGiDdX0wG60SM5rZE5oC7xzLcgSv0XPdx+0D3l5a9RscQO3V10lmbQ1ehLAI+6EcAfA==
X-Received: by 2002:a05:600c:45d1:b0:456:1204:e7ec with SMTP id 5b1f17b1804b1-4562e372643mr78763665e9.10.1752753280096;
        Thu, 17 Jul 2025 04:54:40 -0700 (PDT)
Received: from localhost ([45.84.137.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d727sm20720317f8f.51.2025.07.17.04.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:54:39 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com,
	petrm@nvidia.com,
	menglong8.dong@gmail.com,
	richardbgobert@gmail.com,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/4] net: udp: add freebind option to udp_sock_create
Date: Thu, 17 Jul 2025 13:54:09 +0200
Message-Id: <20250717115412.11424-2-richardbgobert@gmail.com>
In-Reply-To: <20250717115412.11424-1-richardbgobert@gmail.com>
References: <20250717115412.11424-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_sock_create creates a UDP socket and binds it according to
udp_port_cfg.

Add a freebind option to udp_port_cfg that allows a socket to be bound
as though IP_FREEBIND is set.

This change is required for binding vxlan sockets to their local address
when the outgoing interface is down.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/udp_tunnel.h   | 3 ++-
 net/ipv4/udp_tunnel_core.c | 1 +
 net/ipv6/ip6_udp_tunnel.c  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 9acef2fbd2fd..6c1362aa3576 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -34,7 +34,8 @@ struct udp_port_cfg {
 	unsigned int		use_udp_checksums:1,
 				use_udp6_tx_checksums:1,
 				use_udp6_rx_checksums:1,
-				ipv6_v6only:1;
+				ipv6_v6only:1,
+				freebind:1;
 };
 
 int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index fce945f23069..147fd8ff4f49 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -28,6 +28,7 @@ int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
 	udp_addr.sin_family = AF_INET;
 	udp_addr.sin_addr = cfg->local_ip;
 	udp_addr.sin_port = cfg->local_udp_port;
+	inet_assign_bit(FREEBIND, sock->sk, cfg->freebind);
 	err = kernel_bind(sock, (struct sockaddr *)&udp_addr,
 			  sizeof(udp_addr));
 	if (err < 0)
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 0ff547a4bff7..65ff44c274b8 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -40,6 +40,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 	memcpy(&udp6_addr.sin6_addr, &cfg->local_ip6,
 	       sizeof(udp6_addr.sin6_addr));
 	udp6_addr.sin6_port = cfg->local_udp_port;
+	inet_assign_bit(FREEBIND, sock->sk, cfg->freebind);
 	err = kernel_bind(sock, (struct sockaddr *)&udp6_addr,
 			  sizeof(udp6_addr));
 	if (err < 0)
-- 
2.36.1


