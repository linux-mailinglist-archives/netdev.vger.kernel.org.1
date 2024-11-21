Return-Path: <netdev+bounces-146733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0CE9D550D
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCEC2815C8
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 21:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117871C8773;
	Thu, 21 Nov 2024 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJg44jqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D51885A4
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226028; cv=none; b=tC1yLzo4X7Lc+LAB7dnv80BNh/qtYmcHPOfxBTn8KiB2pS1w2hnFWIl96F7tQ8qAMeEQ+6xHZ46Vn4popdn/JMbtViYAZeGE46mxl6TMkQeuRZ8WzYcSLPyMbiB8pzSKGM/mZpLgrrBziZ33RoqARK+E4GQJ6y/WstHX7gSIzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226028; c=relaxed/simple;
	bh=aniN2kGh4TGbbeeewyXPMFIsybFhUTcAz4e1HUnawrI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p1G5sM9Ctx1ChSdcsbGfLLkgpsQSEUJlDFR5jU8+ToUlyIg9/zZy5mWB48BJX1BHg2Nyx33nmjmeIkCNz4J6U0nY8vNVt5P6Z3X3xJg4TckPuaLi2EvB+ugfjuWtjnXlRI37bfmNRCwpT5d8x4ahCaNXSOfo0NMwEaYXc9KFW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJg44jqr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3891b4a68bso2395941276.2
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 13:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732226025; x=1732830825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=veac82IN0K/eJO5pUylc2ml3CNv5+i43YGiBlfAj0Ek=;
        b=AJg44jqrI3BHXekbXenb//O7p2kDjDW3GmRQF02i26Trc3aXWJOXJ9EPISCXUTk9XD
         t+lmPvWcTQhHvnaOEaqWRH1NmkU4UigUrtOzP49h7/MAZa0HCJnOlWVE8YJAfJ4TetR0
         HwAC9U4sMhgtdymD3NcojLy4esepYpimAvbE2mzKjhNtj4lGebEbcqMMAiLSRts/AviK
         JPyfTS+jgDcUa18GbsIw3xJOV8T7SGfxlmlZfiwtoaJpwZ2ZhHz4FKJLYm9hIqIKlQse
         sQal6XUsKRyl20BfFE1VS3idqZ0isE8sDRF/+XEoXFiOfqCylHOQihWYEatCgRB4Lhzd
         7faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732226025; x=1732830825;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=veac82IN0K/eJO5pUylc2ml3CNv5+i43YGiBlfAj0Ek=;
        b=JWgwULzjfL2YLrWltZ27LKYXrDtUHKNtSyA4Fyrrldawht1FEMlbP5IBjvCvFT0sxN
         +rNEGrxXf3WhxphOqKvGdu4DdqrKLxWt2XTp0L4hKnu6AR7QHFTeAymJZGBoMO8tTt8Q
         hn58bPLn10KxgHpKqDT2oH408mrL0POXWJmTb2vEItTR7X1qnuvswoXVtJvm/OwuuabO
         7u6caLwZ2Uwa+RiUgkwH+jUG2860bDF+32XvkXqwxhcCDNNav9sa0uDEVdRHKpfiaA98
         cDzAdTHttSK3lZI1IhR7ba2rZCAe84GyoYLkviEguVnim8KhN8g2iWbqhCmXevyqi+lo
         zWRg==
X-Gm-Message-State: AOJu0YwUU4z1H/2MXW1/MfvAoWjjvNEUirK+HltFS4b1x//RXKgN6ek7
	pFTaqpJ3QkAME4PmS9FWQQacghvKKN7HnuksFUPKmpmS/krnGFf7pVGjay4RW1LCNjL+SVJAAG4
	olgVyAlTMTvtnB6OKuVZycOuLW8O850ItqTM1pzTuriIb3LPM1dR/Dr94LStvL5jpZm43IWYWGs
	iuCeJxN3q2aU27AQbk9xQNSj+dfKP1sDkB
X-Google-Smtp-Source: AGHT+IGNx6c/ihJ46aTTr2ZFvSRG/zwjM21JP0npLC+U51jvlRHwIIRDkQVMEchCESOpeHmWscvFSEmi5KM=
X-Received: from wangfe.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:145a])
 (user=wangfe job=sendgmr) by 2002:a25:7456:0:b0:e30:d445:a7c with SMTP id
 3f1490d57ef6-e38f8abe9a4mr178276.1.1732226024843; Thu, 21 Nov 2024 13:53:44
 -0800 (PST)
Date: Thu, 21 Nov 2024 21:52:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121215257.3879343-2-wangfe@google.com>
Subject: [PATCH v6] xfrm: add SA information to the offloaded packet when
 if_id is set
From: Feng Wang <wangfe@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, leonro@nvidia.com, pabeni@redhat.com
Cc: wangfe@google.com
Content-Type: text/plain; charset="UTF-8"

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
v6: https://lore.kernel.org/all/20241119220411.2961121-1-wangfe@google.com/
  - Fix code style to follow reverse x-mas tree order declaration.
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
index 88187dd4eb2d..5677b2acf9c0 100644
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
@@ -227,16 +229,31 @@ static bool nsim_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
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
 {
 	struct sec_path *sp = skb_sec_path(skb);
 	struct nsim_ipsec *ipsec = &ns->ipsec;
+	struct xfrm_offload *xo;
 	struct xfrm_state *xs;
 	struct nsim_sa *tsa;
 	u32 sa_idx;
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
index e5722c95b8bb..3e9a1b17f37e 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -704,6 +704,8 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb_dst(skb)->dev);
 	struct xfrm_state *x = skb_dst(skb)->xfrm;
+	struct xfrm_offload *xo;
+	struct sec_path *sp;
 	int family;
 	int err;
 
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
2.47.0.371.ga323438b13-goog


