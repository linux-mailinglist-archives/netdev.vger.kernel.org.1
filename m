Return-Path: <netdev+bounces-198672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE13ADD066
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCF8402AF3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDBA2E8888;
	Tue, 17 Jun 2025 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6uEXX8Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D972E3B1C
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171361; cv=none; b=K8CzP86b/FKkkdeJLDkzPIbwN+3Q/X0nNfdfYH6iPzhiJwwnK6RPVYbrP2u+kJKffVfHxpWWRckhsH85n+YuZ6pfr95L334KMcgirX/KqPh5Dx5fcl8FTUYo4hik/xA9eHoF4iPcrNwSh6sSUvwPmKjBM5ZimeqEvtfWSJ6j7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171361; c=relaxed/simple;
	bh=bPbcWBQ6LGkUtSu+j8YgPbg/hhoT+d+ajsg3IwNLBpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e66hs2vK/4k1BUUEt7iM/gyn82yUhzC5T2+kv5DOKN4NFEMeaRxniz5LpTjWTXWtR9NJOczbw7SkCqlZI4/22DcwvsIwcg8K7fzWLFdvM9y2cOfBOz2qXVtUjQn0TidubnrXR9Zg12FuDFsb7HDSKV7Af//VpnOENpuodbhn/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6uEXX8Q; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6084dfb4cd5so13178601a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171357; x=1750776157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2fsm4iE8GN7Qt7wHZ//ZPkjmFcgUKGsiSREYHDl0B8=;
        b=Y6uEXX8Q5x5rsfNS58pzDIHQxoaLzyy5uwwgJJFZKNLMynAZxZNBFiHqOAtrYW0MzR
         v8TvswYQHanoVZ9z6A3CIEXz4o2jjY/dDvGCgS2kMS0+M76k5vMwsZxA//MlZzNIfnAu
         5Xgn0G1lpx1C2djnVjiYUa1DxnnW17Zr+oz75Jfex1eLg08q3mbKj0QBCLgYRaAiG1N1
         Uhu4ATyZ9LoiCgplRsB0fQ9gU4zj9K6aG6LzYKASXrtbhHA0PTFP+FGSXua/wTBjDVIf
         vwlxUJs4Aurt5GN6TalkLurNHOM8ylAzCxGg6GYcR9DJytu9L+jUHQDmv52LdDljQQ/H
         iBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171357; x=1750776157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2fsm4iE8GN7Qt7wHZ//ZPkjmFcgUKGsiSREYHDl0B8=;
        b=iadM8kghueO+TzaoM+eb04tpCDN7hoOZoBtUZOMPURt4dvh1ZFcPRj8hqat2Cqi8s6
         NrWn15mobSMoKU5wPi4tbIOXnpbWIzeq+egrnFmPAb4tc4JoFtP5hLYUYWBbb/3WQ2bs
         BzbVRg5SCm5NKESmD4/n+Ug05Z986QEtIKp7Jk8QXSSSU4/rVzfJmfbc/v9DKrt48cD4
         94wOPHsAmrdhO3XBjkgajZJYzOqjTLHNEuI1igkdMvG8xPrqdoiHh9XXkrht57JFjjB6
         8t6ydD6gM5m/sljckI30KjE4rr2866EOdc8VkBmwCVFHFYQNQRm3IGv+dYnPLYlvGCkC
         XOYg==
X-Gm-Message-State: AOJu0Yw82PhIgzAl4qhix74oHyXdMu8Ho/xcsNH8HCjwatx6ad5M7Jm0
	hokyMtDz7+AilhJBOhWD6vdFIokWOxitKOYGo1zEDkA9ulpQct5mdAPa
X-Gm-Gg: ASbGncuNEbKAuor+4BnzfHGjexEe1ozU5K6HApgygy4TvuVnIxdFNH50qV5dTbAhVfv
	ezpVlvyWefnrH1M04Zi2k2KQETmgRj8WRrsepCUPUbAW5XCXyIlfXPXOuFrgghmRbVrMPaHz9Cl
	e7/3belAyWGQACjDzBdzkMPy0q3IhCBmfqpwsxgEgEjWS3sxYpQ3o/b0jF+BRLsvCfpi22Vdsz7
	qwpwkl3h8qkYh6r/V5GqMz+46LYuNTqmsMlLNxnn9qYJeu6CKi0EONMEpIaDQjko6aAktsRQbq6
	CbIjA9Enf6vEqm9b5FGsNJsTxjpAVIVsNoXbN27/lABx89l/SqW3uPHzI2/gmopK8j5W7DxDcej
	xLAQ8HzXgufrY
X-Google-Smtp-Source: AGHT+IGQnNTmNnT3+1VOvRZY9yyRDIcp3dBFpVYdN488ucRxH0aDnCHr3Jm0fCHpzM82VOjSWWL6Og==
X-Received: by 2002:a17:907:1ca7:b0:ad8:908d:20f3 with SMTP id a640c23a62f3a-adf4fa902e5mr1583940466b.28.1750171357330;
        Tue, 17 Jun 2025 07:42:37 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec81c0157sm866903066b.48.2025.06.17.07.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:36 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 04/17] net/ipv6: Remove jumbo_remove step from TX path
Date: Tue, 17 Jun 2025 16:40:03 +0200
Message-ID: <20250617144017.82931-5-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the GSO TX path, that used to check and remove
HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 net/core/dev.c         | 3 +--
 net/ipv6/ip6_offload.c | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5baa4691074f..925ae7cb7f36 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3882,8 +3882,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
 		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
-		    !ipv6_has_hopopt_jumbo(skb))
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
 			goto sw_checksum;
 
 		switch (skb->csum_offset) {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 2b1f49192820..f9f47d25b18f 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -110,7 +110,7 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	struct ipv6hdr *ipv6h;
 	const struct net_offload *ops;
-	int proto, err;
+	int proto;
 	struct frag_hdr *fptr;
 	unsigned int payload_len;
 	u8 *prevhdr;
@@ -120,9 +120,6 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
-	err = ipv6_hopopt_jumbo_remove(skb);
-	if (err)
-		return ERR_PTR(err);
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;
-- 
2.49.0


