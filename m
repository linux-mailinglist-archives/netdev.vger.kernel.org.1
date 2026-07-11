Return-Path: <netdev+bounces-306856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id trJLBX5JUmo8OAMAu9opvQ
	(envelope-from <netdev+bounces-306856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:47:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56922741B44
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:47:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=a6bFz5ps;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306856-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306856-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F217F3010D99
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3368412D21B;
	Sat, 11 Jul 2026 13:47:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089CD531
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 13:47:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783777659; cv=none; b=kAV/MIJM3/ZiowqdtzidZoh8VZvDjG3SIZ4h1Aace/G7yVReLC3SUDy7ixrqVRJwgix22rz4/m1fcVjrxZHo9EDkSTAutRkHPFMLn9FcUeW1SeApy4g4aE/9NCajrBsfTEkAoYxytKyc4XyOvpNedDDjpJpgXwYABScOtKAHGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783777659; c=relaxed/simple;
	bh=dI5sz4efJ/IwhuA+ar8TvJxJWTOdMJOvEDrJnVCWieo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HK+XrpZvQVqGEX+kncLxfsfSFMfOvcLpd7QJRJ82Agt0RoIcJTVqYH5ZTWXqOCqSYmOowVJtivT2Bqo1SRsTdstchruUeQ22cZ74IYTBYwF20pVOVli/eeIgeBwbtehkCZMAqQa64pK5gUtxnvTj8TuXjtHzeR2PfsvRCMNV14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6bFz5ps; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493f431e317so15784255e9.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783777656; x=1784382456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vRsWWJteHWK3O+2yvFE1KJZgJEYSIpWRCnEwdBb+TyM=;
        b=a6bFz5ps6z1NUfNjeqAYN68pJE3TX42OTyBdHbRt4NgLTGEbOkstyQ7Du3zrO1ATev
         dxf5+yfMN2/CufYQROXsCVgeXHee2hXiPnJfMaYdIVQ93K1Zhe1QdLt3u/gQBMaG+/EB
         iJGc/ZWRbxht7gmh1hH6bYOXuTgWfTBfTQBquiVTUNTB3ZWg4uRntyvKY40Dnu0ucNsd
         8/wuHQ3QDO9MD9Z0UO27JK/W5ttcI2sLpEAIMT3XRlL+/4HGOhpJbji7Ul82i+wQ4kdI
         KhCHeJg+koy75AkIxH8B4lxsNs5sJDEiJyju3WoESSO034Yfp3/r+u0s7Sjjc6dNGmxS
         sIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783777656; x=1784382456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRsWWJteHWK3O+2yvFE1KJZgJEYSIpWRCnEwdBb+TyM=;
        b=AOA41M9YK8GFVfVOZJyCVbXcuCRSljEoXpNVl6gd/PuVuUIeMFV+zrYqcVS3mo9RBy
         ygWpnRKaSY1+Oy/E0YdgwVRTXIWjYRLOcecYO2VZZR+Wx32fumrS4OP9FaB5NGNL0Z0W
         TN6W2zG0Pe6VWEZbdDfXNhsoPvnYeViCgFiDS/pZ7VT/TQbgaG2PZOpbINvmzOBMwzr6
         E5aKyKJE0Ah7o0Ua9J5bz/kiMEmFK6FU1OFAPhRWxPBbAE/MK6vGjn0+8vprDSfC9nZZ
         tum9CIXaaqlCIjLhdgLPQgx2c/XmXTlSa+ygNGJvQjcKtG1ivzSCW75EYzGjaMz7xK9y
         wghA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/h+J8KW2GwWwczouWMid0kYVFG5E0D43MU5mXhSi2qgYEwk9PcD2evhJ89E6TsVFUFiiToFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzixcEz21dUM5B+tusuQXDynAP+EB5idi6E+CEVR4rSKnyCj2/S
	+olzjtBvAfGJ/Rcj4Rs9MauM0oCY/ZXI9pDZK+XhgIxu4M35/0qcIao=
X-Gm-Gg: AfdE7ck5lcksYWSRcqq9JROi18HHh05cIpwZ/SyPkhtRuRI51j/ZTHIJcpP2yyYkLrr
	YeV8pys4C53qw6FrwgAxAqEvUq+PgWbpv4hnt5VdFdFFsPDkE4kOi68S4yxLmRFE115Ph/KvYnF
	IUurMXpmJilOlKsaIkVbY6i9l+hlK33G2kPdm4aIEbPFBOMjZIZ7GWlvKCPlYAwe2csvdiVCPYI
	yP20owSHr2KceWn5UTE1/h8x8QEKANhUq96E7eV9yN6sdFV6eUaDK/TpAq+e5YH1NgVT6bNBRtc
	v/61/ExdyRS29jxkojV9S78dv9qKX0CKLPujC7g/78SImoVdLhTtnYr1m5BGtGl+wY3HcewP7Vd
	CGpTwdloJrb6bpb9PhqqhUEcvxBWSsvCH/CHelqY7glxk8l5fcG3jRFMMkg==
X-Received: by 2002:a05:600c:6304:b0:493:bb2e:11a5 with SMTP id 5b1f17b1804b1-493f87e4a48mr27240475e9.15.1783777655987;
        Sat, 11 Jul 2026 06:47:35 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e77c2esm104406305e9.2.2026.07.11.06.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:47:34 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mahesh Bandewar <maheshb@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] ipvlan: add xmit recursion protection
Date: Sat, 11 Jul 2026 13:47:32 +0000
Message-ID: <20260711134732.1385563-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maheshb@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306856-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[tristmd@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56922741B44

From: Tristan Madani <tristan@talencesecurity.com>

ipvlan devices can enter infinite transmit recursion when combined with
packet forwarding configurations (such as IPVS) that route traffic back
through the same ipvlan interface.

The recursion path is:

  ipvlan_start_xmit -> ipvlan_queue_xmit -> ipvlan_xmit_mode_l3
  -> ipvlan_process_outbound -> ip_local_out -> netfilter hooks
  -> dev_queue_xmit -> ipvlan_start_xmit (recurse)

The existing per-CPU xmit recursion counter in __dev_queue_xmit()
(XMIT_RECURSION_LIMIT = 8) does detect the loop, but fires too late:
each recursion level consumes roughly 2KB of stack space through
ip_local_out and netfilter, and at 8 levels the cumulative usage
exceeds the 16KB kernel stack on x86_64. The resulting stack overflow
hits the VMAP_STACK guard page and causes a kernel panic.

Add a per-CPU counter that prevents any re-entry into
ipvlan_queue_xmit() while it is already executing on the same CPU.
This mirrors the approach used by tunnel devices (see
IP_TUNNEL_RECURSION_LIMIT in ip_tunnels.h) but with a stricter limit
appropriate for ipvlan.

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 835e04835..ab99eb624 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -9,6 +9,8 @@
 
 static u32 ipvlan_jhash_secret __read_mostly;
 
+static DEFINE_PER_CPU(int, ipvlan_xmit_depth);
+
 void ipvlan_init_secret(void)
 {
 	net_get_random_once(&ipvlan_jhash_secret, sizeof(ipvlan_jhash_secret));
@@ -676,6 +678,7 @@ int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_port *port = ipvlan_port_get_rcu_bh(ipvlan->phy_dev);
+	int ret = NET_XMIT_DROP;
 
 	if (!port)
 		goto out;
@@ -683,18 +686,32 @@ int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(!pskb_may_pull(skb, sizeof(struct ethhdr))))
 		goto out;
 
+	if (this_cpu_read(ipvlan_xmit_depth)) {
+		net_crit_ratelimited("ipvlan: xmit recursion detected on dev %s\n",
+				     dev->name);
+		goto out;
+	}
+
+	this_cpu_inc(ipvlan_xmit_depth);
 	switch(port->mode) {
 	case IPVLAN_MODE_L2:
-		return ipvlan_xmit_mode_l2(skb, dev);
+		ret = ipvlan_xmit_mode_l2(skb, dev);
+		break;
 	case IPVLAN_MODE_L3:
 #ifdef CONFIG_IPVLAN_L3S
 	case IPVLAN_MODE_L3S:
 #endif
-		return ipvlan_xmit_mode_l3(skb, dev);
+		ret = ipvlan_xmit_mode_l3(skb, dev);
+		break;
+	default:
+		WARN_ONCE(true, "%s called for mode = [%x]\n",
+			  __func__, port->mode);
+		kfree_skb(skb);
+		break;
 	}
+	this_cpu_dec(ipvlan_xmit_depth);
+	return ret;
 
-	/* Should not reach here */
-	WARN_ONCE(true, "%s called for mode = [%x]\n", __func__, port->mode);
 out:
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
-- 
2.47.3


