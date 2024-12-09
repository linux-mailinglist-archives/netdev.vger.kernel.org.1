Return-Path: <netdev+bounces-150372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FB79EA045
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 21:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F0D16651F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864E198A11;
	Mon,  9 Dec 2024 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H634pKOq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21C137930
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776165; cv=none; b=Q5KIvDYfwA+CKNRBmCe8SjTh65IglhwvDr8lqQeA0PQ7t4cTBleEfYBsKbNd0KJuJ5yFH+fOvxZU6GC5OLXAwEkpsYCW3RidCtk1iVzenSHqbEuRy1Das+dxid0kPDgaYwv1F0c45FbDuThDtHzSZZSEXpYkOiQJUse5uM/1N9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776165; c=relaxed/simple;
	bh=v5+B/OQJFpS7sDTSLVLRCbthyGGExUOp2oilaIXWbDg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fulPMLLaifUAX0wb1DfA0Ku+xJKCl6vF+9DelBzmZ/ecA0KKnjLxgAdjFBNCmYWI3NRmVwAHUObAhn//GxFvm1+Tk7MzHtu9xEKX2IgkzqSLoLLc92UTvTiI8d9GuMqggc/ZdwZ6y8T9+W1KdLxWm0uulZuy4IJvDd9CnLndnDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H634pKOq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wangfe.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef6ef9ba3fso3232018a91.2
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 12:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733776163; x=1734380963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AGhhEAsLZrxVX1am0DE4bMjNtRC/jzKGQ0aztfEBgBE=;
        b=H634pKOqOO0UFyiBffpPmSIGqnr00bI4oleyk9UGCz0hBYT/tVZiLGnPlGiixq3xnY
         Ii+o6gvzXNnRwxCmajvkaMJm6YoUkiBjpOjpcFs9es/bbfNggzwdIBczf4o3c0It1Uwq
         CapnY0hBmA6ozsu6ZMgj3LcE7mpIOONsVusoXjzZ4ZJ8iYVSFdvLEUU5H7Lm8a5ohqLy
         PiHjBzufyUjcRGbkxn/E00v3/3CVnwYSf4K9cmdl6tC5yeSpnYn1Vv8N/uqMHfOhQrfu
         J5hS87XD+13zEu6qKqgzPEKLIRDaS7NTxZ1IzeM0vJNTEa+2L3+3yTAGqz1VjIJzqFg2
         2nMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733776163; x=1734380963;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGhhEAsLZrxVX1am0DE4bMjNtRC/jzKGQ0aztfEBgBE=;
        b=pzacrEmXl14KrOuH92JRv45s8q7lSipkKQ3A0OAu5W8K4I050FcTiFdZgnceny4psg
         h4LJHvlpJ03SWeusc5JmSkMZVRANGpYC/5W12tsV2U61clNHw1lT+NEH7NNzUFRyix2L
         anVnOVq8R4apW5xwo1aWHtBNPEzSk0VUj/QTnN6VAhy6s3T+0hdLtEH8Qq+4cBzwWj1t
         EJnSP7TCinOccXOjPP9TSRNXl6O8Hvy5SjtU5PNeMZkp2gtx2Kmu2tSdXsg6F00fhoev
         2WEYozsttOHXIxECB0i0MZpt+boXtjD7SlX/ymkcyuuOSe4LYdBeKa2Qxl1NK0CHVAm8
         qIvw==
X-Gm-Message-State: AOJu0YzdMp20Ooxr9xF/41L0/kfJI8k3HMI3sKU3bcBeQV1qgd++WJOb
	XdcYbNAA3UZU3GB01yg4t80mFYa5axRDVFHKXVJYnKpd22jrPI8Z004r/v4cgsd8PuEzjDo2uQe
	yPaK9miZRu+kYCxSgsyoZjNs10gPLbldLDPZWoS78EqrgcCs0246QVBRE8LCw0gYPux0Vjq8gA6
	Z/JJacQNjYZ8KuxZwpMKwHAYRUtOSD+fQE
X-Google-Smtp-Source: AGHT+IGpZS63ZPpa5+AL89f86F7lkHQFr2/tuT46CQMeplzPC+Y+k2w0A0FYsOMAF/q4UT1ETbW3Zbutwow=
X-Received: from pjbqx13.prod.google.com ([2002:a17:90b:3e4d:b0:2ef:d136:17fc])
 (user=wangfe job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d52:b0:2ee:f22a:61dd
 with SMTP id 98e67ed59e1d1-2efcf26e18fmr2549282a91.32.1733776163446; Mon, 09
 Dec 2024 12:29:23 -0800 (PST)
Date: Mon,  9 Dec 2024 20:28:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209202811.481441-2-wangfe@google.com>
Subject: [PATCH v7] xfrm: add SA information to the offloaded packet when
 if_id is set
From: Feng Wang <wangfe@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, leonro@nvidia.com, pabeni@redhat.com
Cc: wangfe@google.com
Content-Type: text/plain; charset="UTF-8"

In packet offload mode, append Security Association (SA) information
to each packet, replicating the crypto offload implementation. This
SA info helps HW offload match packets to their correct security
policies. The XFRM interface ID is included, which is used in setups
with multiple XFRM interfaces where source/destination addresses alone
can't pinpoint the right policy.

The XFRM_XMIT flag is set to enable packet to be returned immediately
from the validate_xmit_xfrm function, thus aligning with the existing
code path for packet offload mode.

Enable packet offload mode on netdevsim and add code to check the XFRM
interface ID.

Signed-off-by: wangfe <wangfe@google.com>
---
v7: https://lore.kernel.org/all/20241121215257.3879343-2-wangfe@google.com/
  - Fix the commit message to explain the reason of adding SA.
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
2.47.0.338.g60cca15819-goog


