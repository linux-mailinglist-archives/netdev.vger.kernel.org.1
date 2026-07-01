Return-Path: <netdev+bounces-303642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1MqVDEUPRWrG6AoAu9opvQ
	(envelope-from <netdev+bounces-303642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 14:59:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 916796EDBD2
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 14:59:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=O3ke+wHs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303642-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303642-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E75C0309BE99
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33BE481AB2;
	Wed,  1 Jul 2026 12:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27056480DF1
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:50:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910221; cv=none; b=Tcsxb7etJNa9rSZ7iOwSVDhOYcjalgSJL0ZBTIzywMbSCHV6+Va5oZSFE7FnGIO6iKUBRRoncKy4wYluBsFtwgMtIxc4ggauYzZXdF3Bs4fMXw9yzhGe+DRUGAUPuDzOSwcVianBOv7KyyxYSthzuUMfnOJLjCc1+MOCjcalwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910221; c=relaxed/simple;
	bh=4/5hZ9cbmrsQ4k5Z/epZV6QVjMC1Uf9ZkMtLN1bLuIs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=acnky2KgMRrNnJR+FpnL/6Y2NvNSmgOGsw4wP7YtA3QNjizco561gcDRk+84CC5qAR7XniVgYk/nwePwJG/8iUjrZA1myWPSYMefyylLqUVGODU2FaSUepV6eKfjdIHBNM9P4b1ej9ReO9nnHo5z6nf8T3xK4cH1ULHdu5i9EsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3ke+wHs; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8f08560ea44so8120256d6.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 05:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782910219; x=1783515019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BwxDAKe+w0NZdPsfTmKtfLvYJwM6S2oD4n9yV7QHkhU=;
        b=O3ke+wHsYf3OwI8r2VwOHtBMtdDYLCxCOtVzey8EOJ+60h4MUu/LzuC5245AUnaj2X
         EeGJAcuGpEpH6ZalsoJaDwZbdUxmLV1btuBjHwykdERHjBu9ryALLjZE3pKZ7WfCN6Pe
         r9o/NYaNUbcqOQvr43CZgHhDzroPO2PkgSFiwmokhOIWb0r21WMShahoIMhxRhNzzf4+
         cehJR8LVFveRYb2XoO4mvpMA8i2CBM4oOdRRxcjxdsV/rKHPX0Xoq90sIU5G2xQp6VrQ
         9GOm8By0mL/yy+dr8MX+s9DVdDnjS1ns9wddflqLviQUuGxT9jvtxyOejr/Xmz9KsWmR
         30aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910219; x=1783515019;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwxDAKe+w0NZdPsfTmKtfLvYJwM6S2oD4n9yV7QHkhU=;
        b=Co8zEw9MegAVeGN8mxtG1x3KorIMqkNX57MvNaDuCUl5qYev4ZUz/ICuA+rhuw/f9R
         MSOv1teE+k4Z4Z5RNX4YZDcETjvRVsRgLLdZXfS/A6uA2DQPjhUHZmzDrD9z9r8/SMyM
         W4xRiYUXyNa/95+4usSQrOzJEZ+L5b25znN2YPjbiMHlueT++vaSVh2XahmR8ukOUCOi
         J53Eu96E0+8PPFUQfX0VmzbzmhlpukaiTXYXkTMQ33SHHlcc9B55YS9bO0HguVIy2oEF
         bB6/lTlncZ9g+uk3uxsXTGWDpRoyluemJW1O8FufJ8ggW/KOYXTD7S1tVFmTNCgW8Tgo
         Smzw==
X-Forwarded-Encrypted: i=1; AHgh+RoT9FPKAfrY1YIcxvoF2sBm4dXaYVSdPpWR95ckKhxx10y502Sv6nh1RYUiXPvbQ+O011RkWkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJBDz14SRVpdjT4kXGp0FSjJmkiTN7HvUo9XwA7YJRnDCdr6f
	CYEXe5QICyc3TgwkpkMngLkzWrKTtOyL8W1323vNI68OzxULdPLHjeHpsBQrTA6dXZay99wwEoZ
	aR9MhknRE1p36Qw==
X-Received: from qvbge9.prod.google.com ([2002:a05:6214:27c9:b0:8cc:c97:1de3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:4ee3:0:b0:8ef:e3c9:533e with SMTP id 6a1803df08f44-8f421ca879bmr7786746d6.9.1782910218549;
 Wed, 01 Jul 2026 05:50:18 -0700 (PDT)
Date: Wed,  1 Jul 2026 12:50:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701125016.3650708-1-edumazet@google.com>
Subject: [PATCH net-next] amt: no longer rely on RTNL in amt_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303642-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lunn.ch,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 916796EDBD2

Update amt_fill_info() to run under RCU read lock instead of RTNL.

The AMT device configuration fields (mode, relay_port, gw_port, local_ip,
discovery_ip, max_tunnels) and stream_dev pointer are initialized during
device creation (amt_newlink) and are immutable. Accessing them locklessly
is safe. The stream_dev net_device structure is protected from being freed
by RCU.

The only field that can change concurrently is amt->remote_ip, which is
updated in the packet receive path (amt_advertisement_handler) and
workqueue (amt_req_work). Add READ_ONCE()/WRITE_ONCE() annotations
around amt->remote_ip to prevent data races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/amt.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 724a8163a5142a6835950abb63d80f29417b2654..5cf97c65576fc23b6faac1d686b0fd90b0e05433 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -708,11 +708,13 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	struct iphdr *iph;
 	struct rtable *rt;
 	struct flowi4 fl4;
+	__be32 remote_ip;
 	struct sock *sk;
 	u32 len;
 	int err;
 
 	rcu_read_lock();
+	remote_ip = READ_ONCE(amt->remote_ip);
 	sk = rcu_dereference(amt->sk);
 	if (!sk)
 		goto out;
@@ -721,7 +723,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 		goto out;
 
 	rt = ip_route_output_ports(amt->net, &fl4, sk,
-				   amt->remote_ip, amt->local_ip,
+				   remote_ip, amt->local_ip,
 				   amt->gw_port, amt->relay_port,
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
@@ -762,7 +764,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	udph->check	= 0;
 	offset = skb_transport_offset(skb);
 	skb->csum = skb_checksum(skb, offset, skb->len - offset, 0);
-	udph->check = csum_tcpudp_magic(amt->local_ip, amt->remote_ip,
+	udph->check = csum_tcpudp_magic(amt->local_ip, remote_ip,
 					sizeof(*udph) + sizeof(*amtrh),
 					IPPROTO_UDP, skb->csum);
 
@@ -773,7 +775,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	iph->tos	= AMT_TOS;
 	iph->frag_off	= 0;
 	iph->ttl	= ip4_dst_hoplimit(&rt->dst);
-	iph->daddr	= amt->remote_ip;
+	iph->daddr	= remote_ip;
 	iph->saddr	= amt->local_ip;
 	iph->protocol	= IPPROTO_UDP;
 	iph->tot_len	= htons(len);
@@ -962,7 +964,7 @@ static void amt_event_send_request(struct amt_dev *amt)
 		amt->qi = AMT_INIT_REQ_TIMEOUT;
 		WRITE_ONCE(amt->ready4, false);
 		WRITE_ONCE(amt->ready6, false);
-		amt->remote_ip = 0;
+		WRITE_ONCE(amt->remote_ip, 0);
 		amt_update_gw_status(amt, AMT_STATUS_INIT, false);
 		amt->req_cnt = 0;
 		amt->nonce = 0;
@@ -999,6 +1001,7 @@ static bool amt_send_membership_update(struct amt_dev *amt,
 				       struct sk_buff *skb,
 				       bool v6)
 {
+	__be32 remote_ip = READ_ONCE(amt->remote_ip);
 	struct amt_header_membership_update *amtmu;
 	struct iphdr *iph;
 	struct flowi4 fl4;
@@ -1018,13 +1021,13 @@ static bool amt_send_membership_update(struct amt_dev *amt,
 	skb_reset_inner_headers(skb);
 	memset(&fl4, 0, sizeof(struct flowi4));
 	fl4.flowi4_oif         = amt->stream_dev->ifindex;
-	fl4.daddr              = amt->remote_ip;
+	fl4.daddr              = remote_ip;
 	fl4.saddr              = amt->local_ip;
 	fl4.flowi4_dscp        = inet_dsfield_to_dscp(AMT_TOS);
 	fl4.flowi4_proto       = IPPROTO_UDP;
 	rt = ip_route_output_key(amt->net, &fl4);
 	if (IS_ERR(rt)) {
-		netdev_dbg(amt->dev, "no route to %pI4\n", &amt->remote_ip);
+		netdev_dbg(amt->dev, "no route to %pI4\n", &remote_ip);
 		return true;
 	}
 
@@ -2272,8 +2275,8 @@ static bool amt_advertisement_handler(struct amt_dev *amt, struct sk_buff *skb)
 	    amt->nonce != amta->nonce)
 		return true;
 
-	amt->remote_ip = amta->ip4;
-	netdev_dbg(amt->dev, "advertised remote ip = %pI4\n", &amt->remote_ip);
+	WRITE_ONCE(amt->remote_ip, amta->ip4);
+	netdev_dbg(amt->dev, "advertised remote ip = %pI4\n", &amta->ip4);
 	mod_delayed_work(amt_wq, &amt->req_wq, 0);
 
 	amt_update_gw_status(amt, AMT_STATUS_RECEIVED_ADVERTISEMENT, true);
@@ -2773,6 +2776,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct amt_dev *amt;
 	struct iphdr *iph;
+	__be32 remote_ip;
 	int type;
 	bool err;
 
@@ -2783,6 +2787,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 		kfree_skb(skb);
 		goto out;
 	}
+	remote_ip = READ_ONCE(amt->remote_ip);
 
 	skb->dev = amt->dev;
 	iph = ip_hdr(skb);
@@ -2807,7 +2812,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (iph->saddr != amt->remote_ip) {
+			if (iph->saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -2818,7 +2823,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			else
 				goto out;
 		case AMT_MSG_MEMBERSHIP_QUERY:
-			if (iph->saddr != amt->remote_ip) {
+			if (iph->saddr != remote_ip) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -3000,7 +3005,7 @@ static int amt_dev_open(struct net_device *dev)
 		return err;
 
 	amt->req_cnt = 0;
-	amt->remote_ip = 0;
+	WRITE_ONCE(amt->remote_ip, 0);
 	amt->nonce = 0;
 	get_random_bytes(&amt->key, sizeof(siphash_key_t));
 
@@ -3045,7 +3050,7 @@ static int amt_dev_stop(struct net_device *dev)
 	amt->ready4 = false;
 	amt->ready6 = false;
 	amt->req_cnt = 0;
-	amt->remote_ip = 0;
+	WRITE_ONCE(amt->remote_ip, 0);
 
 	list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
 		list_del_rcu(&tunnel->list);
@@ -3244,7 +3249,7 @@ static int amt_newlink(struct net_device *dev,
 					    "gateway port must not be 0");
 			goto err;
 		}
-		amt->remote_ip = 0;
+		WRITE_ONCE(amt->remote_ip, 0);
 		amt->discovery_ip = nla_get_in_addr(data[IFLA_AMT_DISCOVERY_IP]);
 		if (ipv4_is_loopback(amt->discovery_ip) ||
 		    ipv4_is_zeronet(amt->discovery_ip) ||
@@ -3308,8 +3313,10 @@ static size_t amt_get_size(const struct net_device *dev)
 
 static int amt_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct amt_dev *amt = netdev_priv(dev);
+	const struct amt_dev *amt = netdev_priv(dev);
+	__be32 remote_ip;
 
+	rcu_read_lock();
 	if (nla_put_u32(skb, IFLA_AMT_MODE, amt->mode))
 		goto nla_put_failure;
 	if (nla_put_be16(skb, IFLA_AMT_RELAY_PORT, amt->relay_port))
@@ -3322,15 +3329,19 @@ static int amt_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		goto nla_put_failure;
 	if (nla_put_in_addr(skb, IFLA_AMT_DISCOVERY_IP, amt->discovery_ip))
 		goto nla_put_failure;
-	if (amt->remote_ip)
-		if (nla_put_in_addr(skb, IFLA_AMT_REMOTE_IP, amt->remote_ip))
+
+	remote_ip = READ_ONCE(amt->remote_ip);
+	if (remote_ip)
+		if (nla_put_in_addr(skb, IFLA_AMT_REMOTE_IP, remote_ip))
 			goto nla_put_failure;
 	if (nla_put_u32(skb, IFLA_AMT_MAX_TUNNELS, amt->max_tunnels))
 		goto nla_put_failure;
 
+	rcu_read_unlock();
 	return 0;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


