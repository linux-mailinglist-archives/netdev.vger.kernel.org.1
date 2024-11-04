Return-Path: <netdev+bounces-141711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7518F9BC17A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CB8282B89
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9D91FE0F1;
	Mon,  4 Nov 2024 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmp314fa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF301F755C
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763187; cv=none; b=h6TKNJMyKM7jT7clCKbK0p1tX6lV+Ot9tfBJvYszh79a1ZKmyazuF180mQyQr+aP15VG9a0F7gXndsjmYzXHCITiPUIK5iYgtjFghWl8iNnjP4nyY9Tiygs2dg1yapbYyTPrVMFI2OPKhKau+klQhH8JuZrx7N840abh8ee0JMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763187; c=relaxed/simple;
	bh=3qv8JMW22uYTPLZXnnQo6RAMhkzmPsDTF9IG82SZIFg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nIfAQQAq1tlCa5TTtAcaGBHQuE5uNb4SG/AuOxVHuo4OUw0c8VwC/dPxbm9tZpR023m/bVVycNNC9ze8FIWjIUgJhGUZUIyDDMPn1xvtfUmNWP/z7frbibdr/wDmBadipaKCHqqNdSuDZPIdtHZu60U53hfhkghrjZ/WecuIkec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmp314fa; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30c7a38bd7so5832656276.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 15:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730763184; x=1731367984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=znKZ1P5WRclxgS1HKUCpsAnIfR2nUnKfJeIz2j9vSwE=;
        b=lmp314faOTqp+X6vVM29iXyM6nCaQ37BkMPMZG0QaL9J0BEEJPTNO5JwfqsbhUvEW1
         1fvBCE4gRfoTF/d4urGoRAX3BiSyU0enlplO7943J0sHRm9otcyFwGvBsjs5d+/Xskp+
         3Ar3ciaEXWmSWqjnVV16VO94rWkuTmG4j3gBETph99qVq6nc1tAYDh4vD7BjhV5US+ux
         0E8YlZDQF73+BEuNq79Xh5SSdV/dPaH7a8mb+NXr9xEzsXJ7V4ReCb+ghhSvWFAHfLLF
         v5uVjzdxT/OyiUGVD5FEec/OtY28wutJzWZrUiAvDjsd70HwkQleuJhA+8ijsWtQm2ku
         pCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730763184; x=1731367984;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=znKZ1P5WRclxgS1HKUCpsAnIfR2nUnKfJeIz2j9vSwE=;
        b=DaYMX+w+1gB0gzrrjSfih7VAVx7k/Ag8BmgwNBSe5CtZOPhZpilOz7dUturMGwJNa2
         rg+prlMr3bzJKVXpd5MAUI7H3R7MMzRvg3Ylb2aMQMB1Q/2RU3PJgPmQlHu5q8K9YRoC
         AmvmpqA6Wd5aFIdhBi6j1pKednvO5BVzd32jFAjGtqFVzCsOQrjTj+19HlyFi3X8YFxs
         48DvIsd7RwopLSc/RveQHKs5+N3yE5bYmBGsqJR8/sd1Q5mqMmjzqQGkuGrTTLW8yXWi
         8fTldqfm43+OUkTF7l2mCE26naPJiw3jxWmdKk5AVSgKza00f7WlafbUC5HvRmMZQPrA
         uYaA==
X-Gm-Message-State: AOJu0Yw+rH3a5v0kPRU4uvHHU/zfk4bZzqUW/5hElHtsTP+A7yqtoHsr
	1HZLy7I8e3bOLBBkcVqTwNe9CVOJHImq+DdtZjTog26/B938TWIKJGexYVQQAzcY9ItxuAwCaPy
	bE3z6QEVgYXT+VsuX1VllKGR0i58/vxbHrOxLeRfPcCmAfStSzkLgP5AlPOd0dEbtFGxBMhHOPW
	TIacg99l36MOz64YrrbzTKWlo4WuShlFM7
X-Google-Smtp-Source: AGHT+IF3LY+2ImgwrEmcTM9sy2dde8XqAZ1jxvQI2uHxSpbZBqNaP/K9znLbSk89HeHC/i1FgLsoDx3Q4zw=
X-Received: from wangfe.mtv.corp.google.com ([2a00:79e0:2e35:7:4cf7:d778:5c81:56cd])
 (user=wangfe job=sendgmr) by 2002:a25:8289:0:b0:e2b:cca2:69e1 with SMTP id
 3f1490d57ef6-e30e8d6b7edmr34739276.3.1730763183898; Mon, 04 Nov 2024 15:33:03
 -0800 (PST)
Date: Mon,  4 Nov 2024 15:32:51 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241104233251.3387719-1-wangfe@google.com>
Subject: [PATCH 1/2] xfrm: add SA information to the offloaded packet
From: Feng Wang <wangfe@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, leonro@nvidia.com
Cc: wangfe@google.com
Content-Type: text/plain; charset="UTF-8"

From: wangfe <wangfe@google.com>

In packet offload mode, append Security Association (SA) information
to each packet, replicating the crypto offload implementation.
The XFRM_XMIT flag is set to enable packet to be returned immediately
from the validate_xmit_xfrm function, thus aligning with the existing
code path for packet offload mode.

This SA info helps HW offload match packets to their correct security
policies. The XFRM interface ID is included, which is used in setups
with multiple XFRM interfaces where source/destination addresses alone
can't pinpoint the right policy.

Enable packet offload mode on netdevsim and add code to check the XFRM
interface ID.

Signed-off-by: wangfe <wangfe@google.com>
---
v3: https://lore.kernel.org/all/20240822200252.472298-1-wangfe@google.com/
  - Add XFRM interface ID checking on netdevsim in the packet offload
    mode.
v2:
  - Add why HW offload requires the SA info to the commit message
v1: https://lore.kernel.org/all/20240812182317.1962756-1-wangfe@google.com/
---
---
 drivers/net/netdevsim/ipsec.c     | 24 +++++++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h |  1 +
 net/xfrm/xfrm_output.c            | 21 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index f0d58092e7e9..1ce7447dd269 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -149,7 +149,8 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
 		return -EINVAL;
 	}
 
-	if (xs->xso.type != XFRM_DEV_OFFLOAD_CRYPTO) {
+	if (xs->xso.type != XFRM_DEV_OFFLOAD_CRYPTO &&
+	    xs->xso.type != XFRM_DEV_OFFLOAD_PACKET) {
 		NL_SET_ERR_MSG_MOD(extack, "Unsupported ipsec offload type");
 		return -EINVAL;
 	}
@@ -165,6 +166,7 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
 	memset(&sa, 0, sizeof(sa));
 	sa.used = true;
 	sa.xs = xs;
+	sa.if_id = xs->if_id;
 
 	if (sa.xs->id.proto & IPPROTO_ESP)
 		sa.crypt = xs->ealg || xs->aead;
@@ -224,10 +226,24 @@ static bool nsim_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	return true;
 }
 
+static int nsim_ipsec_add_policy(struct xfrm_policy *policy,
+				 struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static void nsim_ipsec_del_policy(struct xfrm_policy *policy)
+{
+}
+
 static const struct xfrmdev_ops nsim_xfrmdev_ops = {
 	.xdo_dev_state_add	= nsim_ipsec_add_sa,
 	.xdo_dev_state_delete	= nsim_ipsec_del_sa,
 	.xdo_dev_offload_ok	= nsim_ipsec_offload_ok,
+
+	.xdo_dev_policy_add     = nsim_ipsec_add_policy,
+	.xdo_dev_policy_delete  = nsim_ipsec_del_policy,
+
 };
 
 bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
@@ -272,6 +288,12 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
 		return false;
 	}
 
+	if (xs->if_id != tsa->if_id) {
+		netdev_err(ns->netdev, "unmatched if_id %d %d\n",
+			   xs->if_id, tsa->if_id);
+		return false;
+	}
+
 	ipsec->tx++;
 
 	return true;
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index bf02efa10956..4941b6e46d0a 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -41,6 +41,7 @@ struct nsim_sa {
 	__be32 ipaddr[4];
 	u32 key[4];
 	u32 salt;
+	u32 if_id;
 	bool used;
 	bool crypt;
 	bool rx;
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index e5722c95b8bb..a12588e7b060 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -706,6 +706,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 	struct xfrm_state *x = skb_dst(skb)->xfrm;
 	int family;
 	int err;
+	struct xfrm_offload *xo;
+	struct sec_path *sp;
 
 	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
 		: skb_dst(skb)->ops->family;
@@ -728,6 +730,25 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 			kfree_skb(skb);
 			return -EHOSTUNREACH;
 		}
+		sp = secpath_set(skb);
+		if (!sp) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			kfree_skb(skb);
+			return -ENOMEM;
+		}
+
+		sp->olen++;
+		sp->xvec[sp->len++] = x;
+		xfrm_state_hold(x);
+
+		xo = xfrm_offload(skb);
+		if (!xo) {
+			secpath_reset(skb);
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			kfree_skb(skb);
+			return -EINVAL;
+		}
+		xo->flags |= XFRM_XMIT;
 
 		return xfrm_output_resume(sk, skb, 0);
 	}
-- 
2.47.0.199.ga7371fff76-goog


