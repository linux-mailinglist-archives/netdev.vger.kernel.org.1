Return-Path: <netdev+bounces-290440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ8RLwEMD2omEgYAu9opvQ
	(envelope-from <netdev+bounces-290440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:43:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 259635A6242
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E4C731D99FE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5143EDE6B;
	Thu, 21 May 2026 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJp7UAjo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134853EDE4D
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369576; cv=none; b=IUs+S2VWcINJWx17joGyWHv/H3snxcTL6WpA5H6J56JfvaeQSo8nM6JQGTjrR3Mc/9LH1SxJSJNBYCiDg6FqDqDi4MFTraTRg9PCxObTpZkiO5esceT5cBYTyeK5hv/cspjGBcaBMxgnFF2lv5ca1OFzRZbiJ3sgb29mj/fsnLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369576; c=relaxed/simple;
	bh=7J6ID5v1+9yFhyOlQ0zzJgpNn4qUz9TCmXIBM1DvTXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BV+Ht/ev7BE2Z8WV/jQ5K4W0LtoaHybeA4yYTkNksM6sm3NIfSS0OZiip7PhVvwJA1HA0PaNwXYLYRhhs9hBbffgLQIIljssLXanRjNvPnw6v73KpsEdqqncGJ77Vtxg/jkUeIPQ7cW4iDb3PilV8buL70pJxxJql9RbBO1TIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJp7UAjo; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8b640ede74bso146937176d6.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369574; x=1779974374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PeOrV2xNoIfJ9IThDqBL5BAH25tKE3D48GiVCxbV5DE=;
        b=uJp7UAjouYcc/UY901qOvYEF8gHKHGXLK6ATLd4tVa+UTcPCr1OQlQgMjGbz9MTN6x
         K7rz9UZIHE0FcUBNM+OEV8g577IQ+S2Y8X12fqV7bqQqrtWFnr7/G6Jb7cBqkhNOtkDi
         GUKiBUgU3dnrIIeLpG0pwR6u1Pxzmt53myiCc9zNxx8t2f4wNCmXD/+BYLimDPjXLxRZ
         u2DVby2P0JeA5Uu1tiiuXot7MnIhAXU17viE5VKz8hbofwM8huSUz1DtCpYvz02pQh5o
         xmgnZ3onyL4eiPPzLhuGYIXj4/n9JMm+ETBAVc1WL+XWUmWyYtxPu5BVNlXrGhSCVDeH
         QSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369574; x=1779974374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeOrV2xNoIfJ9IThDqBL5BAH25tKE3D48GiVCxbV5DE=;
        b=a8uSf4jO/iCKMr8UWXH3OJxeuHIhVySp+EfUB7sjuAd/sXSo2iEYP9p3mJ6aYugUCY
         WqmyoNLOTwRE+8kVrRgEr2Ojif+QkUOf5yZivGjXHihp2vg6rxLzY4qbSocrNudarHBm
         j+6q+XnvxUNe5Bon5VYkhEc773dIl7V0guodSsaZcMIp/TcK1xp/vdeotUZFYFwC/nPf
         W0uP/XB+8Wo+qaGYdxH7K0lixJBv9l+5luyQ2ICPqC3hlE0y7yjg9U5VJj8p+iF45W0M
         nCunLAwYncKjH6N+YUxEyHhy8Fm6c/iKEOlZgF4Qdnwb6T6tU8urU2NGWOaU+SckzJu+
         wbmw==
X-Forwarded-Encrypted: i=1; AFNElJ897nMoA+MQHcpPrQjpEX7wj9Ht1A1/YTJbDpauhH8ylf8tWg0s5i/oxF1WxAKrOBymHHWO5Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXEYPtAaBAeyfmYKDxkYIeDF/B8ZEgjn45vs9TykQ62Kyjmbx
	VrvlAc5JYFhWsXQ/UKFzynnbW8pz7LKMFygbRIYmaRaxBble41Vg4fqtTONvW4UIm2dmWwPJGqP
	v4r3AUMP8Map6sw==
X-Received: from qvjt11.prod.google.com ([2002:a05:6214:c6b:b0:8ae:5f38:9187])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5f12:b0:8cc:611f:197f with SMTP id 6a1803df08f44-8cc6e6a1738mr44008516d6.44.1779369573738;
 Thu, 21 May 2026 06:19:33 -0700 (PDT)
Date: Thu, 21 May 2026 13:19:14 +0000
In-Reply-To: <20260521131916.3627204-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521131916.3627204-10-edumazet@google.com>
Subject: [PATCH net-next 09/11] bridge: provide lockless access to p->port_id
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,blackwall.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290440-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 259635A6242
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sysfs show_port_id() and BRCTL_GET_PORT_INFO need this.

This will be needed for upcoming RTNL avoidance in "ip link"
dumps (cf br_port_fill_attrs()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_ioctl.c    | 2 +-
 net/bridge/br_netlink.c  | 2 +-
 net/bridge/br_stp_if.c   | 4 ++--
 net/bridge/br_sysfs_if.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 2be802991f70ab3ce48ade5da6d1488e072dbec6..a017374c6e659498d98c6af3f8d8e46a8b93570e 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -257,7 +257,7 @@ int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
 		memset(&p, 0, sizeof(struct __port_info));
 		memcpy(&p.designated_root, &pt->designated_root, 8);
 		memcpy(&p.designated_bridge, &pt->designated_bridge, 8);
-		p.port_id = pt->port_id;
+		p.port_id = READ_ONCE(pt->port_id);
 		p.designated_port = READ_ONCE(pt->designated_port);
 		p.path_cost = READ_ONCE(pt->path_cost);
 		p.designated_cost = READ_ONCE(pt->designated_cost);
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 30e253ca8d0b1ec9126e576629ade5211ab066ca..7b039994d6a2df00a2fc8ca50e45e7db4f392fa7 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -267,7 +267,7 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 			READ_ONCE(p->designated_port)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_DESIGNATED_COST,
 			READ_ONCE(p->designated_cost)) ||
-	    nla_put_u16(skb, IFLA_BRPORT_ID, p->port_id) ||
+	    nla_put_u16(skb, IFLA_BRPORT_ID, READ_ONCE(p->port_id)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_NO, p->port_no) ||
 	    nla_put_u8(skb, IFLA_BRPORT_TOPOLOGY_CHANGE_ACK,
 		       p->topology_change_ack) ||
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 3524bb7e87f0586774a883720be9fa8eb60f0370..8a418f6af423ccba88fae57d2254e35e1ae4a1a0 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -34,7 +34,7 @@ void br_init_port(struct net_bridge_port *p)
 {
 	int err;
 
-	p->port_id = br_make_port_id(p->priority, p->port_no);
+	WRITE_ONCE(p->port_id, br_make_port_id(p->priority, p->port_no));
 	br_become_designated_port(p);
 	br_set_state(p, BR_STATE_BLOCKING);
 	p->topology_change_ack = 0;
@@ -322,7 +322,7 @@ int br_stp_set_port_priority(struct net_bridge_port *p, unsigned long newprio)
 	if (br_is_designated_port(p))
 		WRITE_ONCE(p->designated_port, new_port_id);
 
-	p->port_id = new_port_id;
+	WRITE_ONCE(p->port_id, new_port_id);
 	WRITE_ONCE(p->priority, newprio);
 	if (!memcmp(&p->br->bridge_id, &p->designated_bridge, 8) &&
 	    p->port_id < p->designated_port) {
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 7c55f78237d9e421ac9c3e64d71cc021ca75d1c7..af17f62e95aaff320f8407aa7b50244573ecdc00 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -123,7 +123,7 @@ static BRPORT_ATTR(designated_cost, 0444, show_designated_cost, NULL);
 
 static ssize_t show_port_id(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "0x%x\n", p->port_id);
+	return sysfs_emit(buf, "0x%x\n", READ_ONCE(p->port_id));
 }
 static BRPORT_ATTR(port_id, 0444, show_port_id, NULL);
 
-- 
2.54.0.669.g59709faab0-goog


