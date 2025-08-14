Return-Path: <netdev+bounces-213684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B48A0B2647C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222891CC2462
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E886F2F8BE8;
	Thu, 14 Aug 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoaM0Rex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAF2F39D8;
	Thu, 14 Aug 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171672; cv=none; b=A4Z8SBK7n6nmD96kX/g6VtpqAGyKH+RiRPRRHmQa8/6hB+UA+Xt/BugO5T26ARpyHGwA9rjJcCSYiuUzrPkmieHCPifrjDvBZV8StSJE2gUjpinOt2rojPTjUavqffC56OTqzIJIC4VEPhMonstCdUqitVIuJrFatiM8a8h2ntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171672; c=relaxed/simple;
	bh=jpLU+OKEQKozVDzv5dfNS6gv/Vig04JpdBFrL3kQwgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WzklJsVpaRnUWHv2FwFKz4M7/+98nYVckcb3+c2eNDL3fJ1rOaZQrgGIct5LzqI0ZoVVHetP5N9ZqK6cf/EV0sBPB38owjFKbEUW45s+/iiQJSSwjZSBn4FsavA5F/vcX75dE6aRTENbBNVzghCksiU+CK0FlSbr+aX42ETllzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoaM0Rex; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso617726f8f.0;
        Thu, 14 Aug 2025 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755171669; x=1755776469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NzhLqmeUuWaJRE/GQ9MgE/+Yn40wjerKmNWNfLVMfU=;
        b=GoaM0RexA2tRiMHgCpvXLd7SJVgBrJZt9ESoogLKyLscZUk/YbmgSyGS7hO8nUASWy
         ooZJOP0+DnZs3RHtTL6rY0E4IixZzpuHyznhlhv/x6UFN3sZf5bZdt9s1fNpjThvXO4G
         ePjdnRKiyyTWxd6cXb2mxKdB5iHqSM4iP16ZeK+H3pQShCCQ20U6O6AxaB8RVkJ6mbsc
         RED4MWTw4iDv9VgrZeSerDQ5TXgYMybODGLPizwfdBXHT3cLssLziOkpEgUwZ5OpnmN+
         Kwll3yq6MJEsV93GfB+NSqwm8SmhqppOZa+9g9+5yI2vsRdK521rMh73fNHxBpO4mOi+
         ICPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755171669; x=1755776469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NzhLqmeUuWaJRE/GQ9MgE/+Yn40wjerKmNWNfLVMfU=;
        b=QmXWVTUub6WYwF+RtYzjmxFAhM4DdE1Sz1mDWTKh878LfPbp4JL0Vr+7IG3sIL+yFX
         5EA2s1lOOvoG0gQILbTWwWrF0DRThzGh7dCUXOdkbgCVuOtASFKk5NdKu2egqP7NagaC
         VEwBQAlzBqA3FaDL74U5vqRVz+vp3k7jeT6ktlupfeDqMtaovJTHRva6Celi0lL6X9Ta
         J00/pQ/l4Um3Y1zhdeYi0mwcG5ZI77F06djIghqKSTIVHgJG5seUqsAfLQW5Wc96twSg
         I/JoA6CAP931+p6UF+gwFqD0cXGaiEtnVjvLGvx3H5lBZtWDFaOjR3ZgmEluhTIJQthW
         nDXA==
X-Forwarded-Encrypted: i=1; AJvYcCUl1Rw2ODgzChGE49/cDvJSEkgTVw5c02GeuGPBrCkm7Q17XHb5cQVg92eFpU75whhG2mbjvaJsWlpOVRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzm0AMCHIZ0sImda56MqgsixPEK8KUTgnsIaW9O9UGdsJp95ju
	dcAn/zRtIoIi6F2+3d4VHPC1+54nH5fzuHu3sEXAmwsD6rcXLEmvPW9x8s8fPDJfrY8=
X-Gm-Gg: ASbGnctaotlREs99esUEZdBcnA85XrDvMCfxbT/Pe4rKiMbArq7AW2V1VWLCre/Sjme
	eptaSuHUmXxHMLXRoprDbkRyMjEF2gCer2uuyhVjWqcLL2GjfRrkOD0fx6d+3YPG8yYqF/hpXri
	mq8MepuvQuazlYB+g8XGuzhv3Loynz4xCn0i92dKeo8N56YZwbwNztWOyyaYy5i0Fc8vGoU8uxX
	wR9wt/NLf1TER0ffgdSoI6KdngIPhcyvqNhrvbCSSWKn9HYhHTCnj4K8grdmQJiEWACZAnJFOfa
	0yV3N/8/56ofx+Zethnh80S0guLaixaD5TCKN6jNRxNB/WYHff11AwMHRwcRSgsY7oJ5IE1UC7U
	rkhGMVbQ84duztnXXrdtaPDxVUdmUey8d4Q==
X-Google-Smtp-Source: AGHT+IF1F/U90gimi4Mu85AEgSJjQPFSucr76wX1Lk85qADC6JxJ6soSsKJUNasfd1kjjZNaPGxk/A==
X-Received: by 2002:a05:6000:2dc8:b0:3b7:88f5:eaae with SMTP id ffacd0b85a97d-3b9edfe2b3amr2272020f8f.39.1755171669005;
        Thu, 14 Aug 2025 04:41:09 -0700 (PDT)
Received: from localhost ([45.10.155.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf970sm50362372f8f.25.2025.08.14.04.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:41:08 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	ecree.xilinx@gmail.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Date: Thu, 14 Aug 2025 13:40:26 +0200
Message-Id: <20250814114030.7683-2-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814114030.7683-1-richardbgobert@gmail.com>
References: <20250814114030.7683-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove is_ipv6 from napi_gro_cb and use sk->sk_family instead.
This frees up space for another ip_fixedid bit that will be added
in the next commit.

udp_sock_create always creates either a AP_INET or a AF_INET6 socket,
so using sk->sk_family is reliable.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      | 3 ---
 net/ipv4/fou_core.c    | 8 ++++----
 net/ipv4/udp_offload.c | 2 --
 net/ipv6/udp_offload.c | 2 --
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index a0fca7ac6e7e..87c68007f949 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -71,9 +71,6 @@ struct napi_gro_cb {
 		/* Free the skb? */
 		u8	free:2;
 
-		/* Used in foo-over-udp, set in udp[46]_gro_receive */
-		u8	is_ipv6:1;
-
 		/* Used in GRE, set in fou/gue_gro_receive */
 		u8	is_fou:1;
 
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 3e30745e2c09..efd3bf6ec3ae 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -254,7 +254,7 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 	/* Flag this frame as already having an outer encap header */
 	NAPI_GRO_CB(skb)->is_fou = 1;
 
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
+	offloads = sk->sk_family == AF_INET6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
 	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
@@ -281,7 +281,7 @@ static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
 
 	proto = fou->protocol;
 
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
+	offloads = sk->sk_family == AF_INET6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete)) {
 		err = -ENOSYS;
@@ -450,7 +450,7 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	/* Flag this frame as already having an outer encap header */
 	NAPI_GRO_CB(skb)->is_fou = 1;
 
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
+	offloads = sk->sk_family == AF_INET6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
 	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
@@ -494,7 +494,7 @@ static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 		return err;
 	}
 
-	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
+	offloads = sk->sk_family == AF_INET6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
 		goto out;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 5128e2a5b00a..683689cf4293 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -891,8 +891,6 @@ struct sk_buff *udp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 		skb_gro_checksum_try_convert(skb, IPPROTO_UDP,
 					     inet_gro_compute_pseudo);
 skip:
-	NAPI_GRO_CB(skb)->is_ipv6 = 0;
-
 	if (static_branch_unlikely(&udp_encap_needed_key))
 		sk = udp4_gro_lookup_skb(skb, uh->source, uh->dest);
 
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index d8445ac1b2e4..046f13b1d77a 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -154,8 +154,6 @@ struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 					     ip6_gro_compute_pseudo);
 
 skip:
-	NAPI_GRO_CB(skb)->is_ipv6 = 1;
-
 	if (static_branch_unlikely(&udpv6_encap_needed_key))
 		sk = udp6_gro_lookup_skb(skb, uh->source, uh->dest);
 
-- 
2.36.1


