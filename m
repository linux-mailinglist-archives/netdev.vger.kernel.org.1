Return-Path: <netdev+bounces-146352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C59D303E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 23:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6602839DF
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 22:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF43B19C54E;
	Tue, 19 Nov 2024 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zzD99eGD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030A1482F3
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732053859; cv=none; b=ZvgqpKMFwlfOLVOT9ZCjV49B7c/K371Hmaara9yVc8ucOHeeukpdsORbesjj814Bso2PRSjfNMPsPzLVUYrrJQS64MjOekpWsXnyYzmXtH3PZEA+aNBvnUUj4iFm3Jtb13CycydvIQyeRnB26Xa+pB6gsofHZBcYSl7WU6C1cyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732053859; c=relaxed/simple;
	bh=IJ87ax9qAPU3D31dmjMLth6iWt4p1Nk0Criypexxh+w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MsL4JXIGd7y5kn0JCtnI645S+/4XpQyvMgTSVBXnn0zlVYaM9rEJGrw7XHkcyIXvRN2KukVDeFfPsGfaxx+RHLbSujdYW5asgxjoiTyYKYTQsYj2G2MgErRD2k4MKzE+Xk02akRECBSNN3wMXTBWBYHTu5WTkL7ijS3LUYeYW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zzD99eGD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee484ec18aso28626077b3.2
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 14:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732053857; x=1732658657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XLdtJKtuQDQUD4XtHahQ8HwJm9I/m1lN1eDeTfrLoNo=;
        b=zzD99eGDFenXNBq6fvFTpg2/m0ReoAk99rwERjHJSDRptEzz5JKsDN4/y3jXITKMzg
         OPCs+VBgH4sWjBs6ztR4+RHQWp8EE1iwSiqpAJn97b8oCPGRc1NZFf99FKZaD4Hg5CRf
         HwiEMvdUSJ6nDkVAPDRYwLRlYcMvagt8MTc4boqIsiQ06iBAsSRmau7LEEx8bUS46u/O
         AUu6y5Jov1pKg6SbfnaCba/7M3wFrrsGbEpX0rxn20CUGwBm9Y+Lw4KMfCfLs8oh1h1n
         76jz4ZtxrH4abr8KLlPpAipf1v238RgjikMlNfg9VaJ2ESB3jJBgibNM/u6Kp8x9xpvo
         WSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732053857; x=1732658657;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLdtJKtuQDQUD4XtHahQ8HwJm9I/m1lN1eDeTfrLoNo=;
        b=YrE5xaWOtZIS1bERuGvE7a8q978NcTx1IyVEvleQF8hA1oBdf2dUHJwafBEHtLhAOp
         7XAeR/ictPtAyCtHSf3It9d0iN4GlNVG7fxc7jCgxiDC+bugZWShpCGsKgQvDN/1o6CE
         Mo1AjBbteUrpVSG2fdwUy0gDvZ+xB+9F+AdG8ceMmFzSRdD8FccboRi7KvMvefnDa3fu
         tIk1F23OBLQFhM/Z6uo6RhT3adKpnUXprN9klsj2Dwq55mj8G2gtpp1RldYDt+wrXV0G
         2QTX3C4wORlb7VulNb1yBKHCmF0ahiEUxFQKhi51P5CuZdhBgoHV8XS3+P8rsG7xgdsZ
         +s5A==
X-Gm-Message-State: AOJu0Yz6vB8CGRy2Qcu6rr0WhpdAsKfSeEdzt8WN1G31j9M/c1fjPKn6
	yf+0Pj7Ptjq1YzucG56UXgjbD7dWvSEk6cDgqH1M3s6hNGUPBUeGDmf9jAUb4nBbNSvs4McE1Nb
	f4fGVVsFGYYo4jLPuorpfKGYw3KIv5e3xU56THMWbQ9ImRn08w/kc1VSRqGi5nUJMPzV8Tm7/sJ
	squX0ymjdYDkSDE3ruV9NYURTGlCWx/re9
X-Google-Smtp-Source: AGHT+IHF6pyhWS1qnqG/CtPjV9Di2/JMgajV5REj4gmmEowzH1wkAD0Jaqi8a3m9kVGgFqDkuBwJu4mHKnE=
X-Received: from wangfe.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:145a])
 (user=wangfe job=sendgmr) by 2002:a05:690c:3193:b0:6e6:38:8567 with SMTP id
 00721157ae682-6eebd2f76c3mr3277b3.8.1732053856235; Tue, 19 Nov 2024 14:04:16
 -0800 (PST)
Date: Tue, 19 Nov 2024 22:04:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241119220411.2961121-1-wangfe@google.com>
Subject: [PATCH] xfrm: add SA information to the offloaded packet when if_id
 is set
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
v5: https://lore.kernel.org/all/20241112192249.341515-1-wangfe@google.com/
  - Add SA information only when XFRM interface ID is non-zero.
v4: https://lore.kernel.org/all/20241104233251.3387719-1-wangfe@google.com/
  - Add offload flag check and only doing check when XFRM interface
    ID is non-zero.
v3: https://lore.kernel.org/all/20240822200252.472298-1-wangfe@google.com/
  - Add XFRM interface ID checking on netdevsim in the packet offload
    mode.
v2:
  - Add why HW offload requires the SA info to the commit message
v1: https://lore.kernel.org/all/20240812182317.1962756-1-wangfe@google.com/
---
---
 drivers/net/netdevsim/ipsec.c     | 32 ++++++++++++++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h |  1 +
 net/xfrm/xfrm_output.c            | 22 +++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index 88187dd4eb2d..fd460f456ab7 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -153,7 +153,8 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
 		return -EINVAL;
 	}
 
-	if (xs->xso.type != XFRM_DEV_OFFLOAD_CRYPTO) {
+	if (xs->xso.type != XFRM_DEV_OFFLOAD_CRYPTO &&
+	    xs->xso.type != XFRM_DEV_OFFLOAD_PACKET) {
 		NL_SET_ERR_MSG_MOD(extack, "Unsupported ipsec offload type");
 		return -EINVAL;
 	}
@@ -169,6 +170,7 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
 	memset(&sa, 0, sizeof(sa));
 	sa.used = true;
 	sa.xs = xs;
+	sa.if_id = xs->if_id;
 
 	if (sa.xs->id.proto & IPPROTO_ESP)
 		sa.crypt = xs->ealg || xs->aead;
@@ -227,10 +229,24 @@ static bool nsim_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
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
@@ -240,6 +256,7 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
 	struct xfrm_state *xs;
 	struct nsim_sa *tsa;
 	u32 sa_idx;
+	struct xfrm_offload *xo;
 
 	/* do we even need to check this packet? */
 	if (!sp)
@@ -275,6 +292,19 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
 		return false;
 	}
 
+	if (xs->if_id) {
+		if (xs->if_id != tsa->if_id) {
+			netdev_err(ns->netdev, "unmatched if_id %d %d\n",
+				   xs->if_id, tsa->if_id);
+			return false;
+		}
+		xo = xfrm_offload(skb);
+		if (!xo || !(xo->flags & XFRM_XMIT)) {
+			netdev_err(ns->netdev, "offload flag missing or wrong\n");
+			return false;
+		}
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
index e5722c95b8bb..59ac45f0c4ac 100644
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
@@ -728,7 +730,27 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 			kfree_skb(skb);
 			return -EHOSTUNREACH;
 		}
+		if (x->if_id) {
+			sp = secpath_set(skb);
+			if (!sp) {
+				XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+				kfree_skb(skb);
+				return -ENOMEM;
+			}
+
+			sp->olen++;
+			sp->xvec[sp->len++] = x;
+			xfrm_state_hold(x);
 
+			xo = xfrm_offload(skb);
+			if (!xo) {
+				secpath_reset(skb);
+				XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+				kfree_skb(skb);
+				return -EINVAL;
+			}
+			xo->flags |= XFRM_XMIT;
+		}
 		return xfrm_output_resume(sk, skb, 0);
 	}
 
-- 
2.47.0.338.g60cca15819-goog


