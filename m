Return-Path: <netdev+bounces-303852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pQa0LtyKRWrwBgsAu9opvQ
	(envelope-from <netdev+bounces-303852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:47:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1984C6F1ED7
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=m3TrjW5v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303852-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303852-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDBBE312CFB3
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAAF3C1414;
	Wed,  1 Jul 2026 21:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096C3BCD2F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:43:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942234; cv=none; b=eleRplD/d2S4imbn2DS2HwIoQT17IBNtnbrOx03twKXA8sC6iwansRiv1Ld3giZRkLkj9l+VLuRGjla3TBAVGd7qaOBnUVfy4ZrRTYMdFTOQMor/d3OBtSTLtJMY2SPeldZrHIKPJ8fRgsrScBBfmkGbbHKMokrpLbhZEMPcHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942234; c=relaxed/simple;
	bh=IYgyf0KqpKjVqq12Gxt0gyZGoIKXjBisxXbbYhjUsPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pxM1opmTd1N6U6AZxR9l7WRZqHh/5uxAsyY9f9l4esbO9ELVEABBF7Jw+nFhWq0sbjjR8Ikmbphz14CqNjg0JIXcpXRlkOx18OHkM93fB3mgELGMtKP1Gh3fqrv9juSXAoPl5gkXptx7x76vASz9geiyM1I2b42uwIET+QdW4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3TrjW5v; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f3e4728so1072923b3a.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942233; x=1783547033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABfcvkc3904kpVhvCIerwaPJWoNtS22NaEck/GhxlgE=;
        b=m3TrjW5v2jrEYiqqKSgx2qDyB1BwfcCMEWXeaFg/VfhgdXk3luebKntZBlrDUhQzHI
         eHOsN8zUIARn6OkCBy9pxt4Ac4NAlKu2sVlb0VcejQolUb7KY+eOk4TTCTosFNrVnmup
         n/r1DIra3iE1a/fsZoKZyMzH+P575cOosCmJwxw+xM8c/LPqwHmn/tI4eXZU30il9UqC
         wIF/I0mXe7x2aKQlGd5f15QBEUSAXK30EoJm/MRaT0Bg5GxtlatK8Cx8MqJPP9Hv2cAu
         vD2iGevQAUUNHDPGjsNegVlLDcQFbfzqVhPI581JFbpmElvEgJxltV4fWJFEYsgFI9tF
         MqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942233; x=1783547033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABfcvkc3904kpVhvCIerwaPJWoNtS22NaEck/GhxlgE=;
        b=YuwJjlpkIBl87WdxkiN/fqnA+uhEQZXVFxoOLhMOSfjwqj8cr2+BTjVChXaZg/EWab
         ChMVKzctRGmePtAxqiy48z4TiubuzCmOuGL6UGtuC6o4bBa6zYnuUW3b0dshfsipCgYD
         QQnp2VB7KP3t5hWUH30t4Nl1eNOy1DUeV4rpdhfox9H60/UR7NgofvjDZYer9qo+j8jt
         XgVPZ9XGvdy7zNfsf2ulRKnRzbEmBPbs/EXrqhGUxqGZLgbygXLRWavOI7AMFb+BiCrS
         0ldgfFg4g0kuCdVQ/0FiLHJRWsrLRq6k2GrDt8iDeD4E+7uwuD2JA6ma2GEqOr9VMBYD
         HjEw==
X-Forwarded-Encrypted: i=1; AFNElJ+DIZI2xyLsG78dGV/e+XWiY2sOZWtMBJfstBRwCl9UnKrkhPWxNDuitUrxOVr/eD8xQkKVR7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxuBKHgGdqfB7lqGQc8wYuqL5lpYmj4urnb5J42qrtB9eZIot
	xU9UWYpfkOnalz08EhqVSgINVufWnYg8oH87bjfHHUm9tlKq2NLC3PuRkFu6lt2DvLRMGBJRWNK
	GNEpGXg==
X-Received: from pfnd7.prod.google.com ([2002:aa7:8147:0:b0:847:95a8:7282])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:299a:b0:847:8971:87bb
 with SMTP id d2e1a72fcca58-847c070521emr3066825b3a.21.1782942232661; Wed, 01
 Jul 2026 14:43:52 -0700 (PDT)
Date: Wed,  1 Jul 2026 21:41:50 +0000
In-Reply-To: <20260701214334.266991-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701214334.266991-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701214334.266991-13-kuniyu@google.com>
Subject: [PATCH v1 net-next 12/14] ipvlan: Synchronise ipvlan_init() and
 ipvlan_uninit() for the same lower dev.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303852-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1984C6F1ED7

ipvlan_uninit() for the last ipvlan device resets the lower device's
rx_handler_data to NULL.

Once RTNL is removed, ipvlan_init() would race with ipvlan_uninit(),
which could leak a newly allocated ipvl_port.

  ipvlan_init()                   ipvlan_uninit()
  |                               |- if (refcount_dec_and_test(old_port))
  ...                                |- ipvlan_port_destroy(old_port)
  |                                     '
  |- refcount_inc_not_zero(old_port) <-- fails
  |- ipvlan_port_create(phy_dev)        .
     |- new_port = kzalloc()            |
     |- phy_dev->rx_handler_data = new_port
                                        |- phy_dev->rx_handler_data = NULL
					...
					`- kfree(old_port);

Let's synchronise the two by holding the lower device's netdev_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index b4906a8d24ef..7adad781e9b5 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -177,9 +177,12 @@ static int ipvlan_init(struct net_device *dev)
 	if (!ipvlan->pcpu_stats)
 		return -ENOMEM;
 
+	netdev_lock(phy_dev);
+
 	if (!netif_is_ipvlan_port(phy_dev)) {
 		err = ipvlan_port_create(phy_dev);
 		if (err < 0) {
+			netdev_unlock(phy_dev);
 			free_percpu(ipvlan->pcpu_stats);
 			return err;
 		}
@@ -190,6 +193,8 @@ static int ipvlan_init(struct net_device *dev)
 		refcount_inc(&port->count);
 	}
 
+	netdev_unlock(phy_dev);
+
 	ipvlan->port = port;
 
 	return 0;
@@ -198,9 +203,19 @@ static int ipvlan_init(struct net_device *dev)
 static void ipvlan_uninit(struct net_device *dev)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	netdevice_tracker dev_tracker;
+	struct net_device *phy_dev;
 
 	free_percpu(ipvlan->pcpu_stats);
+
+	phy_dev = ipvlan->phy_dev;
+	netdev_hold(phy_dev, &dev_tracker, GFP_KERNEL);
+	netdev_lock(phy_dev);
+
 	ipvlan_port_put(ipvlan->port);
+
+	netdev_unlock(phy_dev);
+	netdev_put(phy_dev, &dev_tracker);
 }
 
 static int ipvlan_open(struct net_device *dev)
-- 
2.55.0.rc0.799.gd6f94ed593-goog


