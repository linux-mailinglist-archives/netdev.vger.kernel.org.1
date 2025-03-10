Return-Path: <netdev+bounces-173452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD3DA58F41
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117D818876E6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD8A221F13;
	Mon, 10 Mar 2025 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pweCGbV2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56432206A4
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598202; cv=none; b=Or+Z4ABxYH7Qjk6t4BjGMb3fRbntTfGBO946FA6LO+QkrCqJNpmaNOMecsI95YDaSxAwZ09/8ZyTSEq7ry+nVpWGj33Glxeuq+XFJCdFT1wMsdGh6VUBcAjgNVwYcppSPUOUc7TBHH7T2rUVniR+rdr7D1K1qlkLMtuseFDZga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598202; c=relaxed/simple;
	bh=m6Hj03745IExRWTV0910B2G8jRGtXaxWl9KIO6Pemr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qFcb5HHckBWuZLR0Z3VdiffS74pPioUo1i7YJX03/VfoAooWuHs/gk53XD8YCgVIudQcJ93gcnvAHKM11yUQsQ0lA+lfL2ZOg9YZDyhNcPrrPq2+/v7dIdTwcIjogQ9NgBe1UxXs8hORlE9kC5TeTEwqi7EX7uREyAOe2ajEf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pweCGbV2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22406ee0243so52432145ad.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 02:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741598200; x=1742203000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTY2XFn7NVk6fJzb7PfqDb/O7d/Kg7T/tWMPISTqR+c=;
        b=pweCGbV2GeYh/h9UwsRupEQ1bHMx5rym7KlnjZ8xsWPmwMzg/FdvWSOSKq7nL1d/ly
         c0JH9te1bmchp7ld2DnUmKVXjjm8vcgaw8qT7PXVmxgOBpqj3+v8TkEN7wnbvLDlARgD
         O0C4FUWME554NVEllZSGj/9Eg5z0f6a5YZKnnu1AItOHUIwSsS8CRnA3McnfowyGdVyW
         vT1Vwm3ozsOAJVzLufBJqJY6/JI+UYRlnNI/SwPJQIkqbWsH1a4c7otbhV68nRiyeVEz
         mu8oCZQ6EDUmJp43yiNrqVTFOVKujsNg8URrDFHlzIPGRr9OWm7NESVlzgUDYohXkEah
         MYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598200; x=1742203000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTY2XFn7NVk6fJzb7PfqDb/O7d/Kg7T/tWMPISTqR+c=;
        b=lSgYDpr7MlrjA77Sl1/77G1iTMtXRjQBprnPIYhL2xbF/5eIIt/Mf5SCwe+IYZUebb
         oWeZ265gpsbDqcGjJ88fXMO/RvlIMpcEEQ04Ylq948vFVK7YNPAPDRo0SxA7JzercFq2
         7fkHKFANRar/ig3mEcVOYIA3Rr4vchnBXaZ60gy6OG1qN4GVPY4VuYm75gu8tXIxHvRb
         AGprmZIIFAg5REn1ZsjQLIyuFym83G4z8MqYlwgoVtOs6IliZa6mygEwuGvrtL81X9DL
         c9FHJfBUCexTuOjIgffE+QawImVLGOsFYs6P/LxbPe/vkC6ZX0nUENymGtXKnC+Dg9IC
         rITg==
X-Gm-Message-State: AOJu0YzFJl9YMiXU4jWfWsW2oYv4KOMnxw7o/i/HuU2ro8Xxbw67UdGY
	Eiao8WJOPY9hQcZaaHKTp1E8PEt4xmjn0F9HtoymbEQK7VVvOnlETFd3tcO6CcFFdb6tgtx3ZxJ
	S+1VWx0pvFhObZQUaj+/hprNukk2XSaX6SGSewkn8lZGHZYe/WbxunOX+3bG1jUYHO47EQRlie4
	+/ufFakumRNAMk3RO7NNvSo9pKVUzTESs0IIPibUXjpwVcdbvxeZqvLzZgGBVytovCBEnkuA==
X-Google-Smtp-Source: AGHT+IFkOVO9u8blAVd7Q43UfcTnoCweRZ4poWWGA+ptoZkeddHsv8MEI5ZuPRZ/4DQ9uO4BuIcdQpPvAg9aNQPX2O7y
X-Received: from pjur16.prod.google.com ([2002:a17:90a:d410:b0:2fc:2b96:2d4b])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32c2:b0:224:1074:6393 with SMTP id d9443c01a7336-22428bffe92mr172980815ad.43.1741598199933;
 Mon, 10 Mar 2025 02:16:39 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:16:19 +0000
In-Reply-To: <20250310091620.2706700-1-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250310091620.2706700-1-chiachangwang@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310091620.2706700-2-chiachangwang@google.com>
Subject: [PATCH ipsec-next v4 1/2] xfrm: Migrate offload configuration
From: Chiachang Wang <chiachangwang@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: chiachangwang@google.com, stanleyjhu@google.com, yumike@google.com
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
Signed-off-by: Chiachang Wang <chiachangwang@google.com>
---
 v3 -> v4:
 - Change the target tree to ipsec-next
 - Rebase commit to adopt updated xfrm_init_state()
 - Remove redundant variable to rely on validiaty of pointer
 v2 -> v3:
 - Modify af_key to fix kbuild error
 v1 -> v2:
 - Address review feedback to correct the logic in the
   xfrm_state_migrate in the migration offload configuration
   change
 - Revise the commit message for "xfrm: Migrate offload configuration"
---
 include/net/xfrm.h     |  8 ++++++--
 net/key/af_key.c       |  2 +-
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  |  9 ++++++++-
 net/xfrm/xfrm_user.c   | 15 ++++++++++++---
 5 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 39365fd2ea17..f80cdef43ed5 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1893,12 +1893,16 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
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
diff --git a/net/key/af_key.c b/net/key/af_key.c
index c56bb4f451e6..efc2a91f4c48 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -2630,7 +2630,7 @@ static int pfkey_migrate(struct sock *sk, struct sk_buff *skb,
 	}

 	return xfrm_migrate(&sel, dir, XFRM_POLICY_TYPE_MAIN, m, i,
-			    kma ? &k : NULL, net, NULL, 0, NULL);
+			    kma ? &k : NULL, net, NULL, 0, NULL, NULL);

  out:
 	return err;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6551e588fe52..82f755e39110 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4630,7 +4630,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_migrate *m, int num_migrate,
 		 struct xfrm_kmaddress *k, struct net *net,
 		 struct xfrm_encap_tmpl *encap, u32 if_id,
-		 struct netlink_ext_ack *extack)
+		 struct netlink_ext_ack *extack, struct xfrm_user_offload *xuo)
 {
 	int i, err, nx_cur = 0, nx_new = 0;
 	struct xfrm_policy *pol = NULL;
@@ -4663,7 +4663,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		if ((x = xfrm_migrate_state_find(mp, net, if_id))) {
 			x_cur[nx_cur] = x;
 			nx_cur++;
-			xc = xfrm_state_migrate(x, mp, encap);
+			xc = xfrm_state_migrate(x, mp, encap, net, xuo, extack);
 			if (xc) {
 				x_new[nx_new] = xc;
 				nx_new++;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 7b1028671144..9cd707362767 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2120,7 +2120,10 @@ EXPORT_SYMBOL(xfrm_migrate_state_find);

 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap)
+				      struct xfrm_encap_tmpl *encap,
+				      struct net *net,
+				      struct xfrm_user_offload *xuo,
+				      struct netlink_ext_ack *extack)
 {
 	struct xfrm_state *xc;

@@ -2136,6 +2139,10 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	memcpy(&xc->id.daddr, &m->new_daddr, sizeof(xc->id.daddr));
 	memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));

+	/* configure the hardware if offload is requested */
+	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
+		goto error;
+
 	/* add state */
 	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
 		/* a care is needed when the destination address of the
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 784a2d124749..85383d15d003 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3069,6 +3069,7 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int n = 0;
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_encap_tmpl  *encap = NULL;
+	struct xfrm_user_offload *xuo = NULL;
 	u32 if_id = 0;

 	if (!attrs[XFRMA_MIGRATE]) {
@@ -3099,11 +3100,19 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
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
 	err = xfrm_migrate(&pi->sel, pi->dir, type, m, n, kmp, net, encap,
-			   if_id, extack);
-
+			   if_id, extack, xuo);
+error:
 	kfree(encap);
-
+	kfree(xuo);
 	return err;
 }
 #else
--
2.49.0.rc0.332.g42c0ae87b1-goog


