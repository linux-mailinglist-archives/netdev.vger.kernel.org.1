Return-Path: <netdev+bounces-144221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA14C9C615D
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 20:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A965D28236F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8268F218D69;
	Tue, 12 Nov 2024 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvTBIVOe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6272218946
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439383; cv=none; b=fs5V7vQO/x2CvxR65Oflj62X46MG6805dQW/V3w0b9jSGV5S3o7qvZbdaMrFOGhU1blHvWEnfuYMGs7Xu3dL22e6D+UySC8OzmhDUse93ToC13Pj+owvOCaNZYNfVDJzqEgG4kulbEYzaKsPYfNR3pBX/2pj5y/9XyZl9UZxCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439383; c=relaxed/simple;
	bh=xOqlMQnk2rMtGePeMD/oUmgMacy9v38tHqFdnKQoROw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dTUvO1KSP0bdamq2aoihPcv2oZxpPQxVLmOFwRg57JFs8wcU25aETlacSkhadH1Kgfv1D+wSvPE6uBOUZf6hAUa4ZQsw/eLnvTnEQBEgY3HTBp/YtBpr0HXaRnHO2JPgLDIHvvrRUQSUU0Fs7toauvJlC+XDLksWBRuvqvo4yiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvTBIVOe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3c638cc27so111213987b3.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 11:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731439381; x=1732044181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=buBXyNLKz1ZpfH9v2t9soerUFvP0k3OHnGLOML1Esxo=;
        b=dvTBIVOesIHk3Bf75BE6t/c6X1t+Ai1IOjgcTtPGH8aY5wFM8HcuCKJE0J7QWpxQYh
         +VZalkbePuiaZcbBAB+gWvr49ntcwxkDeCSOMwrYYza5ksINncgTGY366XURVArHuikN
         2v0/0Rmt5QlyY95vqDGHomV1ZM+nj2Py3dQep7wouzYrSptHz5By5pi8Ki3SznpMF0iQ
         CO7pCTeHmSAS2+PZjwj3K1efQuUYCCdhrZTHNhiEoaCCVDmjTud9tn0wS1FIUeyIr/Ng
         dzhSGSq4mbUcUe3OTQ6N1A1gRGVC9EcKI6ollSOiDpTkS3Oe3AGV6Dbk9XJWKjNWiHHA
         391w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731439381; x=1732044181;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=buBXyNLKz1ZpfH9v2t9soerUFvP0k3OHnGLOML1Esxo=;
        b=t1946mzdnpa6DpK/RSYPKynoJ+4UsWNzpkXTeC8JT11HeeivjQ9A1+IX+IKirvbl9k
         HJ/0FWHiVN/PPhk1A5UvAgXQ+b6Ird0wTBfZEfXCYEUUDpE1fu27iRszPJvaS/nM4TXy
         9yYsfpSQcMSsDB3i2QiMNiXgFhnn7+kVGKEmbOD85ILuSlYO0418VUGoT0nndOyzGigv
         ipobpbhddCirN8yuDX2sOLJo49QmCAHHKUQQa3AzkXjgCx7CKSGqsQ11RXqlC6hSeFWC
         NdJzh5AxLNkKIrc5zqjXDdSU8T6RNlsMu03e2pjfY+Zsx2GG/4NOEz1Zi+3y6j7O71ZB
         XCeg==
X-Gm-Message-State: AOJu0Yy1QdU/sgXuKpNkuPSuimVeRntyGDvG6yI3SPZcU4Ml/xCkjfUh
	znvotjs/YSSSu8JTwnP6Ibkt0V/yyyF1MknNT6WXnq2EGCThUFgK69WtBCMLlPdv0cZbYhx+VY7
	JCjKsX2CIiQMjdN2baTRJkLFLTfEPwr6NnWgEo7EKu47BgtwlDUMZCbmEhc8VkYReWuvVWQBeNA
	ABZjnAFFncMWbr+oQtgydSu/xww0AHLuSd
X-Google-Smtp-Source: AGHT+IEC8iX5gdjEbhHCVh7QjsqFV7ZQBYxo7nRqF2s6iqUjiztaAj/xLtcBBRZ78PIAJvHVoXcradBg8Fw=
X-Received: from wangfe.mtv.corp.google.com ([2a00:79e0:2e35:7:20f2:1d53:89de:b7db])
 (user=wangfe job=sendgmr) by 2002:a81:a782:0:b0:6e3:1023:3645 with SMTP id
 00721157ae682-6eaddfcc819mr1116147b3.8.1731439380751; Tue, 12 Nov 2024
 11:23:00 -0800 (PST)
Date: Tue, 12 Nov 2024 11:22:49 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112192249.341515-1-wangfe@google.com>
Subject: [PATCH] xfrm: add SA information to the offloaded packet
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
 net/xfrm/xfrm_output.c            | 21 ++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index f0d58092e7e9..afd2005bf7a8 100644
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
@@ -237,6 +253,7 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
 	struct xfrm_state *xs;
 	struct nsim_sa *tsa;
 	u32 sa_idx;
+	struct xfrm_offload *xo;
 
 	/* do we even need to check this packet? */
 	if (!sp)
@@ -272,6 +289,19 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
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
2.47.0.277.g8800431eea-goog


