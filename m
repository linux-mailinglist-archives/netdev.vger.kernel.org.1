Return-Path: <netdev+bounces-120810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F224A95AD11
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6D9B21D2E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 05:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2527347D;
	Thu, 22 Aug 2024 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3pMlWgg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE75589C
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 05:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305944; cv=none; b=hBzFVW7AIt/TLlLAMKYhqlNXd5FPPiSwzRPFqaFgMZPojBYaQ1gS+xEKyw6FnSHvIdpS3fwL2n+F2/W+r34KD6IipVJ52vQO9/NsXEQ8Cs6z/ejzYxts8FuNhf+2YXOGwxsCItw+l+rxBKPxKyzmcXe5MoT6e/aEshkMC/hMAmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305944; c=relaxed/simple;
	bh=ZDPRDTlLhRB8Ca5AowgVDx3jfAvGtbwAcPsMhXtWWrw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TDzaeKOONxc1lmHcCqhtdLo9wXsVHZ3SQm127pPCnOci1l02lyWElVsQ3ewFrxwz+9VidNrfb4iUihM7URQr5LIPI7tHc5qB3Io4gi1R4m8vgQpitRHqmiq2P9Qu7T3unalkAfwlx/R8P+8fwe4kaX2ez+kpFDDlwcp+ekWnM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3pMlWgg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so847554276.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 22:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724305941; x=1724910741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=04JaEmUuzFfbKL4CGnL5ZC4xtx6kxsSTreaHJ5A6DDg=;
        b=U3pMlWggtRE4AjLO2WvUhyfWMSX5BadmYCADPoZ+t9FX5BK8DN0xwd5sttY3g+qv3G
         MKTa+AtPxSELwZoNkLCHPXkyD5lWaCcxcfcGVKKBNXz9pSj8OsybUBSafOOPy+/YF4iR
         rJ7m3tUC2aSS0qsLJ3NckU1H8n1Fr07piNgysdxbQlP5al5vCvu+Uws6lCbn1OZvWmfz
         Gx3xLDI+2Mmlvb41JpiT/MAoH73tkNuv+LGxC0o3KYEVqFQJPIF+9U9M3P4gUWRl4lLs
         BvQ5Bjv7RHrROUh9MoF27RlsFdMp4voQCIkjQIG9D3Iv0E+asD9c1MwbAHsOLcyYpBqP
         IQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724305941; x=1724910741;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04JaEmUuzFfbKL4CGnL5ZC4xtx6kxsSTreaHJ5A6DDg=;
        b=mhbzqUbs0toWTaigLBx+lavOcVHUtdr4HNdEUGcHsce9eNabSSnysGig+SF523ndkI
         PMC1GdaTPvY3vxYveLro8fBT3mQHwizshFqp/30fRqGhSYK3hjfZ+epeSmyZLoVbg51m
         ANo3evxYzP6HRsn7QEVxrwdT3Ss9QxzD+Xf1eS+RPRNatAjRHk5i+OPU+K8M1gjlRf2L
         68bCSDhOEvGl+w0kJL7H9eI0glphyTjeYkbryAzuLOe9Vp5xC/5l1Gc5Gn+W53Kp1E5/
         KsLZ6cbw403xmyrAK2LKuBpbbxEOtsKFy5/onEdYe6qgCF7biYEoAGyLlCj9BgQ+LN0h
         NHUg==
X-Gm-Message-State: AOJu0YxLap41Lr3Qgpm2OFPQtI5SWlZNogv7CDRvQutJeTAeSEXTNUeQ
	/h+Kubw9LM+1IoPwb/Hu+VJzH9wu3mwcoqcTOKHZv+t+zS7DLlfVVOCXEEteNfsFkD499H9+JT2
	5Shn4YS+So0Iqc6vM6qGF8qQg3QjCeNa+3ZdplrkN0U6piKdckWOPC6IBmk+C81XjsLATdZrhuj
	NfB7LAxwXTqxVpCKzkQUJsUDiZTolhTC0hLOETS4w5kjwPu8VyM4mgsJwH7as=
X-Google-Smtp-Source: AGHT+IETrPBlj0Tv3ojSIAQFzaGbRbQ3B+XAZxSguR7Lp9ncSuSBoJfqKynKHzdekC+vdVaJRzY63BBhLOJMi+USHg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1370:b0:e16:5303:7bcc with
 SMTP id 3f1490d57ef6-e166553ae90mr12157276.10.1724305940891; Wed, 21 Aug 2024
 22:52:20 -0700 (PDT)
Date: Thu, 22 Aug 2024 05:51:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240822055154.4176338-1-almasrymina@google.com>
Subject: [PATCH net-next v2] net: refactor ->ndo_bpf calls into dev_xdp_propagate
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Jay Vosburgh <jv@jvosburgh.net>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When net devices propagate xdp configurations to slave devices,
we will need to perform a memory provider check to ensure we're
not binding xdp to a device using unreadable netmem.

Currently the ->ndo_bpf calls in a few places. Adding checks to all
these places would not be ideal.

Refactor all the ->ndo_bpf calls into one place where we can add this
check in the future.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2:
- Don't refactor the calls in net/xdp/xsk_buff_pool.c and
  kernel/bpf/offload.c (Jakub)
---
 drivers/net/bonding/bond_main.c | 8 ++++----
 drivers/net/hyperv/netvsc_bpf.c | 2 +-
 include/linux/netdevice.h       | 1 +
 net/core/dev.c                  | 9 +++++++++
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f9633a6f8571..73f9416c6c1b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2258,7 +2258,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			goto err_sysfs_del;
 		}
 
-		res = slave_dev->netdev_ops->ndo_bpf(slave_dev, &xdp);
+		res = dev_xdp_propagate(slave_dev, &xdp);
 		if (res < 0) {
 			/* ndo_bpf() sets extack error message */
 			slave_dbg(bond_dev, slave_dev, "Error %d calling ndo_bpf\n", res);
@@ -2394,7 +2394,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 			.prog	 = NULL,
 			.extack  = NULL,
 		};
-		if (slave_dev->netdev_ops->ndo_bpf(slave_dev, &xdp))
+		if (dev_xdp_propagate(slave_dev, &xdp))
 			slave_warn(bond_dev, slave_dev, "failed to unload XDP program\n");
 	}
 
@@ -5584,7 +5584,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			goto err;
 		}
 
-		err = slave_dev->netdev_ops->ndo_bpf(slave_dev, &xdp);
+		err = dev_xdp_propagate(slave_dev, &xdp);
 		if (err < 0) {
 			/* ndo_bpf() sets extack error message */
 			slave_err(dev, slave_dev, "Error %d calling ndo_bpf\n", err);
@@ -5616,7 +5616,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		if (slave == rollback_slave)
 			break;
 
-		err_unwind = slave_dev->netdev_ops->ndo_bpf(slave_dev, &xdp);
+		err_unwind = dev_xdp_propagate(slave_dev, &xdp);
 		if (err_unwind < 0)
 			slave_err(dev, slave_dev,
 				  "Error %d when unwinding XDP program change\n", err_unwind);
diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index 4a9522689fa4..e01c5997a551 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -183,7 +183,7 @@ int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)
 	xdp.command = XDP_SETUP_PROG;
 	xdp.prog = prog;
 
-	ret = vf_netdev->netdev_ops->ndo_bpf(vf_netdev, &xdp);
+	ret = dev_xdp_propagate(vf_netdev, &xdp);
 
 	if (ret && prog)
 		bpf_prog_put(prog);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 614ec5d3d75b..f0ff269ce262 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3923,6 +3923,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
+int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);
diff --git a/net/core/dev.c b/net/core/dev.c
index e7260889d4cb..165e9778d422 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9369,6 +9369,15 @@ u8 dev_xdp_prog_count(struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
 
+int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
+{
+	if (!dev->netdev_ops->ndo_bpf)
+		return -EOPNOTSUPP;
+
+	return dev->netdev_ops->ndo_bpf(dev, bpf);
+}
+EXPORT_SYMBOL_GPL(dev_xdp_propagate);
+
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
 	struct bpf_prog *prog = dev_xdp_prog(dev, mode);
-- 
2.46.0.295.g3b9ea8a38a-goog


