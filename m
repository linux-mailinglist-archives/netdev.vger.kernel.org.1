Return-Path: <netdev+bounces-168026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E75A3D269
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757183AAEF7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAF51E883A;
	Thu, 20 Feb 2025 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VCwu+M8D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4BF249F9
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036944; cv=none; b=nlPwwA+m96JTEw9EHeiRr0MOD5J3j0xS8y0JqNpIhfXuW54V8gdZOgAR8o3sgzBGNkIgin3+/yUMBc1J9sGHAse2MQMQVbBDypYDUBKXugfUCC3BoDwQRvsV2wiY2RrFM1HjQclHDA6JCuDDA1rfmcZ7k6RUxKg3HS8kYnWZV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036944; c=relaxed/simple;
	bh=9nR1Yagh3uct4NV65BaEftvGXQbZgjlfm9ZKvqGMeJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b3LmunkYxkdoKLI993R66yGtdsmlsGqwPveNY5ttjwAgs0skK0UrQ0KPAyCw0ECkRV/yfXM18HknJMha+wtZ2HsKDZ6d9kS+QY6YSIhSQAVumHE5b9islPdz8LaoOEjPXsvw+HW9Gul76U3glchBsNvQbuIO6uYbTj88kV9ew0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VCwu+M8D; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2bc72df8fa5so747982fac.3
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740036940; x=1740641740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5c9U2doIIAifTXpktRo1pmFPxk61sTx0Yuk7i05Dc4=;
        b=VCwu+M8Dg97EF7BumC0cctXFsfYIJHmErQlpIb8FHDMJhhAP/XgJykWjrWkIL4eU5N
         8PxfDNT5a6g07LSnPT6MDc2MZLVYrzBYDKn4fW06eNrBl+QnMMGABD4nyowlKN7aNKmD
         jDKU/kXRaO7wIQjk7jOjHuDXYdcx20CSoFCIYz901OvboR1BGvgNRXuXnNy87tLOGgag
         9mkkbMlO2Pm2FCvvM5gac97ofo4LSYNlu8I3R7lkCeE5FcC+GrZHxwGEyP1n4vBqgLoQ
         OStajjYg//o0TFs0bJnP3RTLujkR3G3dEwJUHJ2qFk8Rv3Gfe3uRIOsI8pnfvmKnpQWF
         d33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036940; x=1740641740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5c9U2doIIAifTXpktRo1pmFPxk61sTx0Yuk7i05Dc4=;
        b=Dk0ZqbJWZh10zPVrxpvu2Ea/rJHf6r65x/CN8iH6SStGxWVogP+VettWXorqMxyare
         iUQ1IkWyAR6zadD5QLChgqv18aBrxKavxdvBp5k83mGo1iqUTJidUne2LeYodX9MbatM
         Y6AJWjXLtYHJ6wn/dNIYqK+PT7ZGjHwpGbrVPo+9lB1ARhBDFWTYaempAXbkKuk/QG0s
         EVNR+jnisFz+fWXwkuWwVsLvm89C6AVxlhkUvjcztLVpya2CZgCXBVaEH8MNHOdf3NSe
         HZKgZfsfKfWi0ec6WNm0++B0fc6KeokLfq29JfF86u4xpKe41hO4KZKFqkRZaqS55a8B
         Bl9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoPgOK/l5g5y1z61aSF/GWSbWIgRjHOV8cIRw7KqH2WzcpcKpC/LCA7V/VsQbqMHe+BmRPS44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN26ZHkuujHIMmhtC1VcJ8qwpl4vRshQEz+m9sEiGhHQh4tWWH
	ifQY9qP9WczY/6j5fkKqf5IgCKqMvTSzZSbsa6d9695Sgzlrk4Ng1laO8L2fRHAWZlo+wN0bV/K
	dkJYi/4K+q1NnQLoTNCVmgZXLoOKqkg==
X-Google-Smtp-Source: AGHT+IFZhLhhwhYi9quybzKtbhOJSqBF0vtiDiw1ZzCRZs9JfHeXt8XZ/7L+89iTR17q6nCjDe6a5tYegBHuc02xyL+L
X-Received: from oabuw19.prod.google.com ([2002:a05:6870:ae93:b0:2aa:1a59:56d1])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:c0d0:b0:29d:c624:7c3d with SMTP id 586e51a60fabf-2bd1045f9c8mr5414808fac.32.1740036940153;
 Wed, 19 Feb 2025 23:35:40 -0800 (PST)
Date: Thu, 20 Feb 2025 07:35:15 +0000
In-Reply-To: <20250220073515.3177296-1-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122120941.2634198-2-chiachangwang@google.com> <20250220073515.3177296-1-chiachangwang@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220073515.3177296-2-chiachangwang@google.com>
Subject: [PATCH ipsec v2 1/1] xfrm: Migrate offload configuration
From: Chiachang Wang <chiachangwang@google.com>
To: chiachangwang@google.com
Cc: leonro@nvidia.com, netdev@vger.kernel.org, stanleyjhu@google.com, 
	steffen.klassert@secunet.com, yumike@google.com
Content-Type: text/plain; charset="UTF-8"

Add hardware offload configuration to XFRM_MSG_MIGRATE
using an option netlink attribute XFRMA_OFFLOAD_DEV.

In the existing xfrm_state_migrate(), the xfrm_init_state()
is called assuming no hardware offload by default. Even the
original xfrm_state is configured with offload, the setting will
be reset. If the device is configured with hardware offload,
it's reasonable to allow the device to maintain its hardware
offload mode. But the device will end up with offload disabled
after receiving a migration event when the device migrates the
connection from one netdev to another one.

The devices that support migration may work with different
underlying networks, such as mobile devices. The hardware setting
should be forwarded to the different netdev based on the
migration configuration. This change provides the capability
for user space to migrate from one netdev to another.

Test: Tested with kernel test in the Android tree located
      in https://android.googlesource.com/kernel/tests/
      The xfrm_tunnel_test.py under the tests folder in
      particular.

v1 -> v2:
- Address review feedback to correct the logic in the
  xfrm_state_migrate in the migration offload configuration
  change.
- Revise the commit message for "xfrm: Migrate offload configuration"

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
index 67ca7ac955a3..87d5e17b0498 100644
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
+	if (offload && xfrm_dev_state_add(net, xc, xuo, extack))
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
2.48.1.601.g30ceb7b040-goog


