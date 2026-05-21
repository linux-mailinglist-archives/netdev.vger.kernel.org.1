Return-Path: <netdev+bounces-290422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ny3C6IGD2qFEQYAu9opvQ
	(envelope-from <netdev+bounces-290422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:20:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C45705A5A19
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C3AA30F58A9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F0B3EDAB8;
	Thu, 21 May 2026 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYEULBhT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C13ED103
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368768; cv=none; b=VBk7dW/q3YlALoNaDqP/zYD/dGMpTG0IK/6Te3Ot4tD3fl3nqwbLQUi5rR/ZgqbTKXUGQyZ/mkTEN013/YMbzznawnQdmP8QFA+dry+rEN8eJWgjdyWpBhwC+tD9FF7he9+pm3S2pmsbc/XcIgX8UipZty6Fu3EDMywJ7wWgUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368768; c=relaxed/simple;
	bh=qY+plYrHUjyEKlEwdjvB+Ilsps0ZT2pjPeZqXaLCeD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKagogrpbusK8e2P+2Cjmqm+4UUeSXZWWMBbGejiMDMHTX0IgsZ/mJUaOufGOwqyq/kJtnN2Kdl8G6iNNaK1S//MheO8kLcNHSkb4mVXCehiUyG+q71nweQPgqxuMuHxB7ECP+EkbAa6OBsG3k7i09qPncZgnGD8l+xP9wn2lbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYEULBhT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so4263167b3a.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368766; x=1779973566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7dYXWxYJ/dsjCJq8MPbJ/YlkTALMLc3dGOHkkHfnHE=;
        b=lYEULBhT41yP7oCnoZ984Au+TwRDfq10EG7j7JJ5w76Tjw+kkVQP1hwacrLoifpiAn
         IrDM5GrH2/UC9DorpTiP7V4UFNkmWuro6oTB0nEHRCIYMJtz02JDh+9efF/w46x/xbID
         HYXrytq9WlDGC/KslYIKc8pMSkbM+cj7EetJYg1uMoVKrqSCSoOcZKtKmSDfAgLdCpXO
         GMQIBzi/Bee8cgTYjioVciVBvK/hELmliGHQoaBTPytuIOf5J19nAH+scEHjFb4od+c7
         6lv4Ebjhok5bHFQjARCTtVxbWoLH52iwCh6rVzykNWQFrNbAgZBbex9kgYJXUsUTXwgV
         lt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368766; x=1779973566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7dYXWxYJ/dsjCJq8MPbJ/YlkTALMLc3dGOHkkHfnHE=;
        b=mR6sSOnFz5Obiw5yUSJKicQgM+XG8+OWYVy01XtncUa8hFLDy/7n/6+WbflOs1M5ys
         N5Ey+Z2IS3aJNIznQnCKUsQbLHEPOl/DI4kzoTKFsXOrKIlA9tCQIRp48QDV4pd/Zgg1
         sZA8s1TzeYkVMwDligJe4vbDd2YoSOc3VjlByRbx7CAQSnwnUXt0i0sGAB0RaQMrMx/J
         NO9qVtPaXucWffIIPhfmmxjCqTIOsSNK3h6Lm05sHRZY0ZgWifpy5KOOE6/ljD43d7Da
         MCLsCjhWO1pQvVe0F+EC0dWgY2/2C0Jk04YYSpAhj43z2EbAevFrlHCHqZlxHjrD7OU3
         WRFw==
X-Forwarded-Encrypted: i=1; AFNElJ8NNHuQl0WISAWphk/nHzDV2D8rylf446Oxx10PVOLB/g49sWd48QrHNO/Bx/994PNKHX0DuT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5deG1RO+BjbASL71QpRiRIiouVD/xUfW646SCnhyobbQKBal
	L9ozxSuU4LvxkG1+tV5B0yHqU3/ccBBELfeL+hChKuaHgY2i/Ub6CbQPDV4SNQ==
X-Gm-Gg: Acq92OE8CkLUzsX6ipK6vt0IqVUC+Exkn2FN8+ecylGZL5F2+u7RIDQv/yeKB2O+smV
	lv0v7uV1kJH8DArihR/p0GzRY6gS3dXzRxyWf7dY7COWn+W3wn+kAQ0LANNrUynx/McJEfmZKNu
	58RvhvkfNI6fl0uQwrt9PbDCl/5zAUpiQZwBzwJ66U1rxi2Lzg83AFxACotahKTFUDwGGfmQWIj
	P+bsPNSiQecFAZWmXjmQNKQbyJKDAGmA3v8c2+QFPRNbwvg/OHkAtnokYtJWDNltjMDCjsk4Zcx
	xYZZ9oeff+gWIN5wGxxa1yWFExbg92RdDjnsdWO1h8b7oJaRRcq+IvS/Ts4oh6T7EeQfesvzxsH
	O6DTzQK1fAx2H2sE7yyDrw1uem051T3QOS3YgEK5bNFXdnSOkP5pzOoH3DeqTLyy3R06zcngCVr
	q68BYf6EoBoJEoMfNUCWuW+W+BpJsCycuWXojXGVgJ/loKubL1
X-Received: by 2002:a05:6a00:419b:b0:82f:1369:7268 with SMTP id d2e1a72fcca58-8414adf69admr3131200b3a.30.1779368766276;
        Thu, 21 May 2026 06:06:06 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841549be20fsm1693993b3a.12.2026.05.21.06.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:06:05 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/2] ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
Date: Thu, 21 May 2026 21:05:55 +0800
Message-Id: <20260521130555.3421684-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521130555.3421684-1-maoyixie.tju@gmail.com>
References: <20260521130555.3421684-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290422-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,secunet.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C45705A5A19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After patch 1/2 in this series, vti6_update() unlinks and relinks
the tunnel through t->net. vti6_siocdevprivate() still uses
dev_net(dev) for the collision lookup. For a tunnel moved through
IFLA_NET_NS_FD, dev_net(dev) is the new netns, not t->net.

SIOCCHGTUNNEL on a migrated tunnel then runs:

  net = dev_net(dev)                    /* migrated netns */
  t   = vti6_locate(net, &p1, false)    /* misses target in t->net */
  ...
  t   = netdev_priv(dev)
  vti6_update(t, &p1, false)            /* mutates t->net's hash */

A caller in the migrated netns picks params that match a tunnel
in the creation netns. The lookup in dev_net(dev) finds nothing.
vti6_update() prepends the migrated tunnel at the head of the
creation netns hash bucket for those params. Later lookups in
the creation netns resolve to the migrated device. xfrm receive
delivers the matched packets through a device the caller controls.

Reachable from an unprivileged user namespace (unshare --user
--map-root-user --net). Cross tenant scope on container hosts.

Switch the SIOCCHGTUNNEL path on a non fallback device to use
t->net for the lookup. The lookup now matches the netns
vti6_update() operates on.

Also add ns_capable(self->net->user_ns, CAP_NET_ADMIN) before
the lookup. The check at the top of the case is against
dev_net(dev)->user_ns, which after migration is the attacker's
netns. A caller there can pick params absent from self->net,
the lookup returns NULL, t becomes self, and vti6_update()
inserts the device into the creation netns hash. The new check
requires CAP_NET_ADMIN in the creation netns user_ns too.

SIOCADDTUNNEL and SIOCCHGTUNNEL on the fallback device keep
dev_net(dev), which equals init_net there.

Fixes: 61220ab34948 ("vti6: Enable namespace changing")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Xiao Liang <shaw.leon@gmail.com>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_vti.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index dcb257411d6e..df793c8bfffb 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -835,17 +835,24 @@ vti6_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data
 		if (p.proto != IPPROTO_IPV6  && p.proto != 0)
 			break;
 		vti6_parm_from_user(&p1, &p);
-		t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
 		if (dev != ip6n->fb_tnl_dev && cmd == SIOCCHGTUNNEL) {
+			struct ip6_tnl *self = netdev_priv(dev);
+
+			err = -EPERM;
+			if (!ns_capable(self->net->user_ns, CAP_NET_ADMIN))
+				break;
+			t = vti6_locate(self->net, &p1, false);
 			if (t) {
 				if (t->dev != dev) {
 					err = -EEXIST;
 					break;
 				}
 			} else
-				t = netdev_priv(dev);
+				t = self;
 
 			err = vti6_update(t, &p1, false);
+		} else {
+			t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
 		}
 		if (t) {
 			err = 0;
-- 
2.34.1


