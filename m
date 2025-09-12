Return-Path: <netdev+bounces-222411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B21B5420F
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 07:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54387ABF08
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 05:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAF0274B42;
	Fri, 12 Sep 2025 05:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuvnMtbo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B089927F736
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757654921; cv=none; b=vA1Cgup1nLQR+n9+qqoLIQSnqHkGnHS3Jc4kO2KkERW9Z88gduYKiGfXpuTXL24B5yQa1kItlNlYljbrMq55M7e+9p6Z080/WINcED/TnCLcRoZI83YiMOkp1OFntyeIH9GrkbfVHLKF3jZVa3CR03Fgdov09YtPr586xW755xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757654921; c=relaxed/simple;
	bh=iXk5LtD8VQud/p8QuIvkPtAyIAC7E2tqnLsWZY8OouY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Njc9JtmIWryIjzquxAblwNb86g/UZ9aBiOlDE7WJQHuZUnso7ZSTcVdS5wFsVKTSi7dd4XzJJCmODtbt7onXXA3y66E82KmhlkEo8OPA+HQ4vB81mSPze72PS6u5tgqgSfEvZZICbQSfHTH2WF9yXvk51Nlf0fgun8P+OVo14Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuvnMtbo; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d603cebd9so12631667b3.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 22:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757654918; x=1758259718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBxJ9bgU3ETsPO/br9jSR8/72uyQYfX4epNE3oPxRwc=;
        b=AuvnMtbovYW8BgT/4UfNtvBEEaYvYkdVZABqAlA726TUWkCeMlmXW6UMit0S2d7Pfi
         YbJfLRX5uU3zXeK5vUr9uz1hj76TNplY6UqXlK5eEkaSkg649iLyFFry9jee72RBwqXO
         9FU7IA6B11ZlVvmqM0IAlOaLh7qPu1ukV/RQI1Yi/9uF+gRviP4yF8EsffsfOHJn16N3
         VRngVjqCRBF2cdZzJft1ynrhzvlWK/U/SGjyFi2efkVisvB9tjm0FAY5JsGDJGg8Snto
         bF17tXBkLjkQrCOhZwzmFKplaEMTIWC9CwJsXrTWRX4dEW/evub3U+AsUSt0g8TEBLN9
         i4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757654918; x=1758259718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBxJ9bgU3ETsPO/br9jSR8/72uyQYfX4epNE3oPxRwc=;
        b=BlnM0V3zF65KLZm4Z34dwTtFeKU1Xkl2pR4rPflu/3ERXH/6Iz1VDIS4bS1NvvTzJf
         6cYVeXJOq7on/L2dUxwvDlt5ARPhSQicRVRwOMwdPs57YTBNUNJEvHj+uSjfemFXlPIT
         KuqBeZJ3K5z1GAZRo3iAYko7TpfyAJ/94qv8ge1kVdIgZRwqi2uUFv1xfRuIC6rp08N6
         ou0YV04HQpErbyMmfS/Bxbp+Ners7mKUJ7mZ9gJEnL6mgOUUq4/OaTTD91ePbb3e4Esl
         IwwpWPpcVNUSFexmrUTHP06mV45/1ITZ411ASSjJ4zgGWeCW4+vwNHLHgpiEUv+UpMeq
         FmAw==
X-Gm-Message-State: AOJu0YzpoludLEtd7rDuB49t80a02XpR8v/qdbW69S0ZuO+zhHwLCKTq
	91dfeHBd18T8JethE1+/Hh/7TNzcta8Mc4EpULW3VLeM4IE7/iIhPctb
X-Gm-Gg: ASbGnct3dEQ+YHv1D1UfajSzJgbY3SPaEdUYi88ylwo4BSr8hb25eETi9KuowzEWKlN
	hBg5Feps8zPNDrk6LZxiIx/B5wFW1LAvp+080eU89DWytNYyMLJxzYgzW0oOLAXc2XNOza2ubSF
	bCsjXXQxVJiZth9Q2dmPlfdUVs0SsRaLHMTIE90ChG5RS9+DfN23bU3C+6wfald3eXMKryBR6f2
	mVwkMD7wVhbygKDqRuADD79yUqx7e+RZcFyF8TWV9UlZj51rMsQoSnDz4E5p+ectlD3AmYjm7Ds
	R6nW5Rv9RkIj1brOQFDKFqw6f+Eyniw2LB5JbkRC9RAi2x2j7H0gnOGvSUZpSKe36bAJmncTx+w
	/2weI5UwBs5m8liC4W9gOEzrawL5igCvFZjVlD2uUSV4=
X-Google-Smtp-Source: AGHT+IEvNdoERnjqUX3gWMOkOVdUpABgLqadOZKxTupu5VHNH+oEciO0ODN2lDoQyjjHn43fJYnwgg==
X-Received: by 2002:a05:690c:a96:b0:726:697b:9e1f with SMTP id 00721157ae682-73065abe03amr15986057b3.54.1757654918519;
        Thu, 11 Sep 2025 22:28:38 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76238482sm8652877b3.12.2025.09.11.22.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 22:28:37 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 11 Sep 2025 22:28:17 -0700
Subject: [PATCH net-next v2 3/3] net: ethtool: prevent user from breaking
 devmem single-binding rule
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-3-c80d735bd453@meta.com>
References: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com>
In-Reply-To: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Prevent the user from breaking devmem's single-binding rule by rejecting
ethtool TCP/IP requests to modify or delete rules that will redirect a
devmem socket to a queue with a different dmabuf binding. This is done
in a "best effort" approach because not all steering rule types are
validated.

If an ethtool_rxnfc flow steering rule evaluates true for:

1) matching a devmem socket's ip addr
2) selecting a queue with a different dmabuf binding
3) is TCP/IP (v4 or v6)

... then reject the ethtool_rxnfc request with -EBUSY to indicate a
devmem socket is using the current rules that steer it to its dmabuf
binding.

Non-TCP/IP rules are completely ignored, and if they do match a devmem
flow then they can still break devmem sockets. For example, bytes 0 and
1 of L2 headers, etc... it is still unknown to me if these are possible
to evaluate at the time of the ethtool call, and so are left to future
work (or never, if not possible).

FLOW_RSS rules which guide flows to an RSS context are also not
evaluated yet. This seems feasible, but the correct path towards
retrieving the RSS context and scanning the queues for dmabuf bindings
seems unclear and maybe overkill (re-use parts of ethtool_get_rxnfc?).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/sock.h  |   1 +
 net/ethtool/ioctl.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c      |   9 ++++
 net/ipv4/tcp_ipv4.c |   6 +++
 4 files changed, 160 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 304aad494764..73a1ff59dcde 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -579,6 +579,7 @@ struct sock {
 		struct net_devmem_dmabuf_binding	*binding;
 		atomic_t				*urefs;
 	} sk_user_frags;
+	struct list_head	sk_devmem_list;
 
 #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
 	struct module		*sk_owner;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b2a4d0573b3..99676ac9bbaa 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -29,11 +29,16 @@
 #include <linux/utsname.h>
 #include <net/devlink.h>
 #include <net/ipv6.h>
+#include <net/netdev_rx_queue.h>
 #include <net/xdp_sock_drv.h>
 #include <net/flow_offload.h>
 #include <net/netdev_lock.h>
 #include <linux/ethtool_netlink.h>
 #include "common.h"
+#include "../core/devmem.h"
+
+extern struct list_head devmem_sockets_list;
+extern spinlock_t devmem_sockets_lock;
 
 /* State held across locks and calls for commands which have devlink fallback */
 struct ethtool_devlink_compat {
@@ -1169,6 +1174,142 @@ ethtool_get_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
 
+static bool
+__ethtool_rx_flow_spec_breaks_devmem_sk(struct ethtool_rx_flow_spec *fs,
+					struct net_device *dev,
+					struct sock *sk)
+{
+	struct in6_addr saddr6, smask6, daddr6, dmask6;
+	struct sockaddr_storage saddr, daddr;
+	struct sockaddr_in6 *src6, *dst6;
+	struct sockaddr_in *src4, *dst4;
+	struct netdev_rx_queue *rxq;
+	__u32 flow_type;
+
+	if (dev != __sk_dst_get(sk)->dev)
+		return false;
+
+	src6 = (struct sockaddr_in6 *)&saddr;
+	dst6 = (struct sockaddr_in6 *)&daddr;
+	src4 = (struct sockaddr_in *)&saddr;
+	dst4 = (struct sockaddr_in *)&daddr;
+
+	if (sk->sk_family == AF_INET6) {
+		src6->sin6_port = inet_sk(sk)->inet_sport;
+		src6->sin6_addr = inet6_sk(sk)->saddr;
+		dst6->sin6_port = inet_sk(sk)->inet_dport;
+		dst6->sin6_addr = sk->sk_v6_daddr;
+	} else {
+		src4->sin_port = inet_sk(sk)->inet_sport;
+		src4->sin_addr.s_addr = inet_sk(sk)->inet_saddr;
+		dst4->sin_port = inet_sk(sk)->inet_dport;
+		dst4->sin_addr.s_addr = inet_sk(sk)->inet_daddr;
+	}
+
+	flow_type = fs->flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
+
+	rxq = __netif_get_rx_queue(dev, fs->ring_cookie);
+	if (!rxq)
+		return false;
+
+	/* If the requested binding and the sk binding is equal then we know
+	 * this rule can't redirect to a different binding.
+	 */
+	if (rxq->mp_params.mp_priv == sk->sk_user_frags.binding)
+		return false;
+
+	/* Reject rules that redirect RX devmem sockets to a queue with a
+	 * different dmabuf binding. Because these sockets are on the RX side
+	 * (registered in the recvmsg() path), we compare the opposite
+	 * endpoints: the socket source with the rule destination, and the
+	 * socket destination with the rule source.
+	 *
+	 * Only perform checks on the simplest rules to check, that is, IP/TCP
+	 * rules. Flow hash options are not verified, so may still break TCP
+	 * devmem flows in theory (VLAN tag, bytes 0 and 1 of L4 header,
+	 * etc...). The author of this function was simply not sure how
+	 * to validate these at the time of the ethtool call.
+	 */
+	switch (flow_type) {
+	case IPV4_USER_FLOW: {
+		const struct ethtool_usrip4_spec *v4_usr_spec, *v4_usr_m_spec;
+
+		v4_usr_spec = &fs->h_u.usr_ip4_spec;
+		v4_usr_m_spec = &fs->m_u.usr_ip4_spec;
+
+		if (((v4_usr_spec->ip4src ^ dst4->sin_addr.s_addr) & v4_usr_m_spec->ip4src) ||
+		    (v4_usr_spec->ip4dst ^ src4->sin_addr.s_addr) & v4_usr_m_spec->ip4dst) {
+			return true;
+		}
+
+		return false;
+	}
+	case TCP_V4_FLOW: {
+		const struct ethtool_tcpip4_spec *v4_spec, *v4_m_spec;
+
+		v4_spec = &fs->h_u.tcp_ip4_spec;
+		v4_m_spec = &fs->m_u.tcp_ip4_spec;
+
+		if (((v4_spec->ip4src ^ dst4->sin_addr.s_addr) & v4_m_spec->ip4src) ||
+		    ((v4_spec->ip4dst ^ src4->sin_addr.s_addr) & v4_m_spec->ip4dst))
+			return true;
+
+		return false;
+	}
+	case IPV6_USER_FLOW: {
+		const struct ethtool_usrip6_spec *v6_usr_spec, *v6_usr_m_spec;
+
+		v6_usr_spec = &fs->h_u.usr_ip6_spec;
+		v6_usr_m_spec = &fs->m_u.usr_ip6_spec;
+
+		memcpy(&daddr6, v6_usr_spec->ip6dst, sizeof(daddr6));
+		memcpy(&dmask6, v6_usr_m_spec->ip6dst, sizeof(dmask6));
+		memcpy(&saddr6, v6_usr_spec->ip6src, sizeof(saddr6));
+		memcpy(&smask6, v6_usr_m_spec->ip6src, sizeof(smask6));
+
+		return !ipv6_masked_addr_cmp(&saddr6, &smask6, &dst6->sin6_addr) &&
+		       !ipv6_masked_addr_cmp(&daddr6, &dmask6, &src6->sin6_addr);
+	}
+	case TCP_V6_FLOW: {
+		const struct ethtool_tcpip6_spec *v6_spec, *v6_m_spec;
+
+		v6_spec = &fs->h_u.tcp_ip6_spec;
+		v6_m_spec = &fs->m_u.tcp_ip6_spec;
+
+		memcpy(&daddr6, v6_spec->ip6dst, sizeof(daddr6));
+		memcpy(&dmask6, v6_m_spec->ip6dst, sizeof(dmask6));
+		memcpy(&saddr6, v6_spec->ip6src, sizeof(saddr6));
+		memcpy(&smask6, v6_m_spec->ip6src, sizeof(smask6));
+
+		return !ipv6_masked_addr_cmp(&daddr6, &dmask6, &src6->sin6_addr) &&
+		       !ipv6_masked_addr_cmp(&saddr6, &smask6, &dst6->sin6_addr);
+	}
+	default:
+		return false;
+	}
+}
+
+static bool
+ethtool_rx_flow_spec_breaks_devmem_sk(struct ethtool_rx_flow_spec *fs,
+				      struct net_device *dev)
+{
+	struct sock *sk;
+	bool ret;
+
+	ret = false;
+
+	spin_lock_bh(&devmem_sockets_lock);
+	list_for_each_entry(sk, &devmem_sockets_list, sk_devmem_list) {
+		if (__ethtool_rx_flow_spec_breaks_devmem_sk(fs, dev, sk)) {
+			ret = true;
+			break;
+		}
+	}
+	spin_unlock_bh(&devmem_sockets_lock);
+
+	return ret;
+}
+
 static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
@@ -1197,6 +1338,9 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 			return -EINVAL;
 	}
 
+	if (ethtool_rx_flow_spec_breaks_devmem_sk(&info.fs, dev))
+		return -EBUSY;
+
 	rc = ops->set_rxnfc(dev, &info);
 	if (rc)
 		return rc;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 438b8132ed89..3f57e658ea80 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -311,6 +311,12 @@ DEFINE_STATIC_KEY_FALSE(tcp_have_smc);
 EXPORT_SYMBOL(tcp_have_smc);
 #endif
 
+struct list_head devmem_sockets_list;
+EXPORT_SYMBOL_GPL(devmem_sockets_list);
+
+DEFINE_SPINLOCK(devmem_sockets_lock);
+EXPORT_SYMBOL_GPL(devmem_sockets_lock);
+
 /*
  * Current number of TCP sockets.
  */
@@ -5229,4 +5235,7 @@ void __init tcp_init(void)
 	BUG_ON(tcp_register_congestion_control(&tcp_reno) != 0);
 	tcp_tsq_work_init();
 	mptcp_init();
+
+	spin_lock_init(&devmem_sockets_lock);
+	INIT_LIST_HEAD(&devmem_sockets_list);
 }
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 68ebf96d06f8..a3213c97aed9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -92,6 +92,9 @@
 
 #include <trace/events/tcp.h>
 
+extern struct list_head devmem_sockets_list;
+extern spinlock_t devmem_sockets_lock;
+
 #ifdef CONFIG_TCP_MD5SIG
 static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 			       __be32 daddr, __be32 saddr, const struct tcphdr *th);
@@ -2559,6 +2562,9 @@ static void tcp_release_user_frags(struct sock *sk)
 	sk->sk_user_frags.binding = NULL;
 	kvfree(sk->sk_user_frags.urefs);
 	sk->sk_user_frags.urefs = NULL;
+	spin_lock_bh(&devmem_sockets_lock);
+	list_del(&sk->sk_devmem_list);
+	spin_unlock_bh(&devmem_sockets_lock);
 #endif
 }
 

-- 
2.47.3


