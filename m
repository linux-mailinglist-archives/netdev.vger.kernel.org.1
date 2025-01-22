Return-Path: <netdev+bounces-160265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4DCA1912B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662E97A02D4
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E381E211A1F;
	Wed, 22 Jan 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3X0nJZV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577C212B2F
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547809; cv=none; b=pzmOWOJkVtpLLPCxAh34ABjxe1KrrcCDqAAFBrbDfqaL/+1nGNDjSqlD1Bzz7y1qYzTQ5Y9pN8pqD+ZsSRGU2s5o4c3izU14tjoWqMkpkXnVbkXJ2EXBAsQDg1zdDovtHJ6YoJbEWpMATfeO44tPgSPGyng3kFfRxGjp4fa5E5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547809; c=relaxed/simple;
	bh=Hps69/IS2HkOWr8gqmXzaSwlR4Gw7DaBy9JYLGn2kXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YW1wtzfH8iNFgujZenboSm/uAgSW6dbA01Zzr/dwmEvw3vJai80TdFCWtAVC9W54tW+mfa4RDkv655/0p4gywAhdcWZfLNZ3k8TEoXvYviAVOdulgdq0JdNvkPkKFiAHm/uHNutaxa1sD5tcE4NrpWZW1qXcJoeUeXIIsVow5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3X0nJZV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21681a2c0d5so124966175ad.2
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 04:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737547808; x=1738152608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RGCAkzJUCKIA/A/I7FRqDQ8jZW+LutmOvzFJmI3KsrI=;
        b=q3X0nJZVVuPT4JJKrxbkd6GKTNONCS4lS3eJV3Nje7LgBf8ticyf0go9zJsgzQyO0s
         ub9OcRiJaphFyFTC4P+X4fOF92vz7ErnRxRYs3CeTMoZwrYYfOXsr9tYjN14uyMqOKWk
         zRV2+7o0CvQiigpyIHLxza83GAk5tMjEKVtNjPJcbErkrMWq/9Uj+yUkbgXj1wW27gnG
         pqzhtbuwR2OSrbURQAFbmfxD+FtQScx/SjMHozvEfCigd0a1IYmNZcryZcgsChx9FD+Q
         iWJQpKAzMI8aQmmhX51NrP838b0L8H7M4NO4KDUmbt8V3kt5DStEF2lZ8jogqAyPZo2P
         Gpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547808; x=1738152608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGCAkzJUCKIA/A/I7FRqDQ8jZW+LutmOvzFJmI3KsrI=;
        b=kCZ9g0m5mF97kdOFFxS+9bOuIYrMQk1TEFrnPeD07XKdf6wKPP0xKsPwqjvcgZFliV
         wtw7vKGt6xEo4cXgch7VbJ/V3KHqA/yT6H+G5DA52iMrylbLISHOk/Snmq8IQqpLTNN3
         v0HPU4TCf2f3netfxTxhCE5FV7qhPSEdyK3BTFsg8I7SFv+QqerOdY6e28KSr6gqSHIy
         w0q0caqHXMVDkIr28D21izJbHJwG/rT76H4kjndNHjVjRrBOvG5sQ0QBq9euguTSwmT6
         k9k6G8i9Uztx00PPP41UIp5yFGMqnukYcjDV8FbpdJTfo3EVAIFOUaicR05ZIE3KF5Vh
         +2/g==
X-Gm-Message-State: AOJu0YwvE/L48B49h1Bd/kTudqqA/ygVQ9AbjhWsc5evOgZ2Mi2ZaXUl
	7NuPcAf8UJsdT+cZoF3tVo3jjFCMlF5J8BYqgErmLWjrbXvQrrULG1al+gUqOSroWm6wR077zCn
	x2ui4pvB2VouN4nm3YqYgRnA0PBYLWr/793vAeGfqhwVgfNv9AoS6kZdpjj2xWUSvqZXV2d/xzn
	XUgYsvln4lbn8Ai/BNCHTotrNFv0dT1XKv5oBBu02ri/eMhg+4u4ZBqvYN5DMxIHeHHC1D0A==
X-Google-Smtp-Source: AGHT+IHjQUTdi6rs7qCNVsG2ci/YrJttEgNBRKMRECoAafvCPWu/CvL6397zg6CWolHgnFJStsq9B521mlakQsbEZ6zg
X-Received: from plgk16.prod.google.com ([2002:a17:902:ce10:b0:216:eefe:2c35])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2a88:b0:215:9894:5679 with SMTP id d9443c01a7336-21c34ccef5fmr315335595ad.0.1737547807728;
 Wed, 22 Jan 2025 04:10:07 -0800 (PST)
Date: Wed, 22 Jan 2025 12:09:41 +0000
In-Reply-To: <20250122120941.2634198-1-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122120941.2634198-1-chiachangwang@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250122120941.2634198-3-chiachangwang@google.com>
Subject: [PATCH ipsec v1 2/2] xfrm: Migrate offload configuration
From: Chiachang Wang <chiachangwang@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: yumike@google.com, stanleyjhu@google.com, chiachangwang@google.com
Content-Type: text/plain; charset="UTF-8"

If the SA contains offload configuration, the migration
path should update the SA as well.

This change supports SA migration with the offload attribute
configured. This allows the device to migrate with offload
configuration.

Test: Endable both in/out IPSec crypto offload, and verify
      with Android device on both WiFi/cellular network,
      including:
      1. WiFi + offload -> Cellular + offload
      2. WiFi + offload -> Cellular + no offload
      3. WiFi + no offload -> Cellular + offload
      4. Wifi + no offload -> Cellular + no offload
      5. Cellular + offload -> WiFi + offload
      6. Cellular + no offload -> WiFi + offload
      7. Cellular + offload -> WiFi + no offload
      8. Cell + no offload -> WiFi + no offload
Signed-off-by: Chiachang Wang <chiachangwang@google.com>
---
 include/net/xfrm.h     |  8 ++++++--
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  | 14 +++++++++++---
 net/xfrm/xfrm_user.c   | 15 +++++++++++++--
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 32c09e85a64c..a1359f912298 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1822,12 +1822,16 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 						u32 if_id);
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap);
+				      struct xfrm_encap_tmpl *encap,
+				      struct net *net,
+				      struct xfrm_user_offload *xuo,
+				      struct netlink_ext_ack *extack);
 int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_migrate *m, int num_bundles,
 		 struct xfrm_kmaddress *k, struct net *net,
 		 struct xfrm_encap_tmpl *encap, u32 if_id,
-		 struct netlink_ext_ack *extack);
+		 struct netlink_ext_ack *extack,
+		 struct xfrm_user_offload *xuo);
 #endif
 
 int km_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr, __be16 sport);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 4408c11c0835..3f5a06f3f0d2 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4622,7 +4622,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_migrate *m, int num_migrate,
 		 struct xfrm_kmaddress *k, struct net *net,
 		 struct xfrm_encap_tmpl *encap, u32 if_id,
-		 struct netlink_ext_ack *extack)
+		 struct netlink_ext_ack *extack, struct xfrm_user_offload *xuo)
 {
 	int i, err, nx_cur = 0, nx_new = 0;
 	struct xfrm_policy *pol = NULL;
@@ -4655,7 +4655,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		if ((x = xfrm_migrate_state_find(mp, net, if_id))) {
 			x_cur[nx_cur] = x;
 			nx_cur++;
-			xc = xfrm_state_migrate(x, mp, encap);
+			xc = xfrm_state_migrate(x, mp, encap, net, xuo, extack);
 			if (xc) {
 				x_new[nx_new] = xc;
 				nx_new++;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 46d75980eb2e..2fdb4ea97844 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2007,22 +2007,30 @@ EXPORT_SYMBOL(xfrm_migrate_state_find);
 
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap)
+				      struct xfrm_encap_tmpl *encap,
+				      struct net *net,
+				      struct xfrm_user_offload *xuo,
+				      struct netlink_ext_ack *extack)
 {
 	struct xfrm_state *xc;
-
+	bool offload = (xuo);
 	xc = xfrm_state_clone(x, encap);
 	if (!xc)
 		return NULL;
 
 	xc->props.family = m->new_family;
 
-	if (xfrm_init_state(xc) < 0)
+	if (__xfrm_init_state(xc, true, offload, NULL) < 0)
 		goto error;
 
+	x->km.state = XFRM_STATE_VALID;
 	memcpy(&xc->id.daddr, &m->new_daddr, sizeof(xc->id.daddr));
 	memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));
 
+	/* configure the hardware if offload is requested */
+	if (offload & xfrm_dev_state_add(net, xc, xuo, extack))
+		goto error;
+
 	/* add state */
 	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
 		/* a care is needed when the destination address of the
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index b2876e09328b..505ae2427822 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2989,6 +2989,7 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int n = 0;
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_encap_tmpl  *encap = NULL;
+	struct xfrm_user_offload *xuo = NULL;
 	u32 if_id = 0;
 
 	if (!attrs[XFRMA_MIGRATE]) {
@@ -3019,11 +3020,21 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (attrs[XFRMA_IF_ID])
 		if_id = nla_get_u32(attrs[XFRMA_IF_ID]);
 
+	if (attrs[XFRMA_OFFLOAD_DEV]) {
+		xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
+			      sizeof(*xuo), GFP_KERNEL);
+		if (!xuo) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
 	err = xfrm_migrate(&pi->sel, pi->dir, type, m, n, kmp, net, encap,
-			   if_id, extack);
+			   if_id, extack, xuo);
 
+error:
 	kfree(encap);
-
+	kfree(xuo);
 	return err;
 }
 #else
-- 
2.48.1.262.g85cc9f2d1e-goog


