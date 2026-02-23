Return-Path: <netdev+bounces-260090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBm5ORp0nGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:36:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F5D178D1A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74832306C7E1
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFB52EDD62;
	Mon, 23 Feb 2026 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtlH1UpX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6589B2EBDFA
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860828; cv=none; b=I+aeko2RSpU+4kWXBcMmGLJ0CjJrDwsbFJ8z2lrqkPh9OYdEq/80XbZcHrviwoogOHTMT6D4uEc91XIgDkyLRANZ2NOKK/AD1jJnEZ4jzEIW9EtRbHwCHaYGsu6r7x1vB067qqMS9rFGgUnjcRB3+zeBl4swwcRXcrmmxjd94oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860828; c=relaxed/simple;
	bh=Sc0XsRa+h7CvkAcGaDuEVcGGe//df3h1SOHqA+KmVao=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j+dYRf73aRwH5QIfxk1TrWgE4vBIvbueItc2F21PXELinVwcptEK8y/Kb1x0Q+JHRCQNN90soqZD6i4EGp3YqELz65NcqRzNdVhWjd/ugoPpIPnB/V2jkx3SUsjMU/qAlxr3xltVNWA4/0dPZ6bliujthXAwDAVcCbFs/+eWk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NtlH1UpX; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb42f56c4aso4614803185a.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 07:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771860826; x=1772465626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=reEsQNCsHhMMYdE402juGxmSaDkIn8JuSJVax7fdHQw=;
        b=NtlH1UpX5LTkaa/bhCK38yDSP0n5IHzdrIpJcjbKYs/dE27HalCq5/FcHOqLrKHZo3
         kZLzH+/Xvt450R8v1WaDeIj6V0iXuXitN5OqDPkv5C0LllnYDKH/f9uAyf+Tc0EOMnAK
         j8IPm1ZUWv2vHTtC02a+MPvDSr2jMh5TGoAle/qF/Fs/s+uXant6GBxmYXeCeMnYN06K
         aEFGLQsh6pBnuWqKWGH/37WRqBqX05O99PEsi6VRqjO2KObxEfCOcTWvPedtEqCeSKIP
         Ml2K/YQLlggClmhT9M2YWikErp+ZmwzFH2dGlLctHAiqWkJt1M/dxfYtZHwQCKb2m06t
         Wb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771860826; x=1772465626;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reEsQNCsHhMMYdE402juGxmSaDkIn8JuSJVax7fdHQw=;
        b=DmiMxCgDsHismyy9jyjxqS9d+tQraLmqCVuY5NzsMgpbyZWmag8W6edlt+nB03buwW
         pcdOfjQpBE2EGfUULPFEnzUOP53a+uAZuQnyN6z2ApOggbmliv+3xL/er5og6xlKan6f
         2pm8UginPZ6IztI9JH462kKXSPcV6jz2gVYoz88Iie6L1cUmfEK6QJ4KfQ2cH8Zw1Wl6
         4IBUy6Zc4VwS3oWUBIVZbEqKRIT7ocsoiAay/IIqOAeyIppMFo6xFd6uWYyG4nhKXvlV
         GLW4bYlFIxx9tPRq+jqbha0s5kQIp5PbCqckx6vFFXR36pMpTcE7MvNVMcNvgnjmV0dT
         ab1w==
X-Forwarded-Encrypted: i=1; AJvYcCWwlxKXBNv7RblhLArflIJGPmHBRVsV/KdQb3VXO8LXrX6ito56V6jQGHjbZly3XfLxsfcfMvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8cVa8rfz00O4Prvh0U4wtxxTK32bSuPPoWHtkQKa917RNMmaP
	vS6QjGhzh9hMxIg1sAVGZy1PDpItuyotAiGtdCDN2YJ+pkQmVu6H45mRkXcWPqIo2CuVVzi7Jm9
	nWV101h6DlsLpkA==
X-Received: from qkof22.prod.google.com ([2002:a05:620a:4096:b0:8cb:3af6:4fe2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a25:b0:8ca:2baa:6658 with SMTP id af79cd13be357-8cb8ca88767mr1179936785a.70.1771860826034;
 Mon, 23 Feb 2026 07:33:46 -0800 (PST)
Date: Mon, 23 Feb 2026 15:33:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260223153342.892477-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: move ip6_dst_hoplimit() to net/ipv6/ip6_output.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260090-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 63F5D178D1A
X-Rspamd-Action: no action

Move ip6_dst_hoplimit() to net/ipv6/ip6_output.c so that compiler
can (auto)inline it from ip6_xmit().

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 1/0 up/down: 47/0 (47)
Function                                     old     new   delta
ip6_xmit                                    1481    1528     +47
Total: Before=25076476, After=25076523, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_output.c  | 21 +++++++++++++++++++++
 net/ipv6/output_core.c | 23 -----------------------
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 769c39fed1f38dd507d907a43ca21a2023245999..b5f2a3881a3fcd1d680f8914725ba2a6ca9e2b26 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -259,6 +259,27 @@ bool ip6_autoflowlabel(struct net *net, const struct sock *sk)
 	return inet6_test_bit(AUTOFLOWLABEL, sk);
 }
 
+int ip6_dst_hoplimit(struct dst_entry *dst)
+{
+	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
+
+	rcu_read_lock();
+	if (hoplimit == 0) {
+		struct net_device *dev = dst_dev_rcu(dst);
+		struct inet6_dev *idev;
+
+		idev = __in6_dev_get(dev);
+		if (idev)
+			hoplimit = READ_ONCE(idev->cnf.hop_limit);
+		else
+			hoplimit = READ_ONCE(dev_net(dev)->ipv6.devconf_all->hop_limit);
+	}
+	rcu_read_unlock();
+
+	return hoplimit;
+}
+EXPORT_SYMBOL(ip6_dst_hoplimit);
+
 /*
  * xmit an sk_buff (used by TCP and SCTP)
  * Note : socket lock is not held for SYNACK packets, but might be modified
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index cba1684a3f30ff98517d873ddb8e97f32adc9791..64b1eeb79b572b8b412c60f832c4a7984ac8276f 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -100,29 +100,6 @@ int ip6_find_1stfragopt(struct sk_buff *skb, u8 **nexthdr)
 }
 EXPORT_SYMBOL(ip6_find_1stfragopt);
 
-#if IS_ENABLED(CONFIG_IPV6)
-int ip6_dst_hoplimit(struct dst_entry *dst)
-{
-	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
-
-	rcu_read_lock();
-	if (hoplimit == 0) {
-		struct net_device *dev = dst_dev_rcu(dst);
-		struct inet6_dev *idev;
-
-		idev = __in6_dev_get(dev);
-		if (idev)
-			hoplimit = READ_ONCE(idev->cnf.hop_limit);
-		else
-			hoplimit = READ_ONCE(dev_net(dev)->ipv6.devconf_all->hop_limit);
-	}
-	rcu_read_unlock();
-
-	return hoplimit;
-}
-EXPORT_SYMBOL(ip6_dst_hoplimit);
-#endif
-
 int __ip6_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	ipv6_set_payload_len(ipv6_hdr(skb), skb->len - sizeof(struct ipv6hdr));
-- 
2.53.0.345.g96ddfc5eaa-goog


