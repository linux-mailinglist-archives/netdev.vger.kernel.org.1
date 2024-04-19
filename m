Return-Path: <netdev+bounces-89684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86798AB2E6
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 18:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB53281C99
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F891130AEB;
	Fri, 19 Apr 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lO+zm+wQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4A12F5A7
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543061; cv=none; b=fRj9Uu+KymVmM6zkOzm+eqrclMV/tlVoV7m4WRnLa29BFy6l1zGEReLqb0Gg47LaXYwhURCVUs2WPYsMeZ4cYBEx+kiLf5YHf89K0wCa587DZMZNFUdXZPtxYwDUQkxdZtPsBUFdo6QckbLwvH6AyQFGMyd07p4h0l8LPtv9iBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543061; c=relaxed/simple;
	bh=eehnBh85z63Z0xcgChT284gGFYhR6pCi5rFEzm5r/6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgGlLuSnoz8bylptNRD0rDwlciIc6irj2PzXs9CJybnI7S7dzg+EP7OW39+nY4MqnRrcKIRvip7WnEh8vcHRzZwUydmwp684iN1sOkqtoQi43XHhqTbULbQxhd2rUHpyLwCmA2Xgmh9pX9/bP5OZgXyJ3pzAUrLtyILYGQnWwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lO+zm+wQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-518b9527c60so2505030e87.0
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543058; x=1714147858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvZWY6oOIREGJOabaKvGrU4sw1NszHWyxny0cVSevBo=;
        b=lO+zm+wQXDhXc5xNwrZdqvYZhatH1WYuIvVqb21jPowpBuQPyy4+BDmRnRu8OFyMWJ
         VlTGUAwj0O0Iy2XZj43ImCpok2oprYjxpajxW1Cfdrz4IWGUKsZxbBYP+TuB93LP4T5O
         kJ4D/Tq1B493GnU/ceG3IG2Io01psJc1Xqn6CaCv2RL3l7XvT0TfH3tG+1+WVWXaDTB4
         Ej7z0kgGXm6Hv5DeDradDWVdX5nQyMI9H344yREYH/kzqQf2zN7HyhUb9d0+lghnYPgb
         eDU36mQDbRFh9wzAUWcYpiRS0ohVi4fGKwvrxgsjutmpxxSjBtTYBApJrTejo5mfkVnk
         9P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543058; x=1714147858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvZWY6oOIREGJOabaKvGrU4sw1NszHWyxny0cVSevBo=;
        b=Q/+W3X7NkJtI5w1rsoRUhJ0+RKQs6CSyRpk9N1IZcgPpNkT+b1HYFZLG3WqqWUXO1O
         hfsXx/E81UXKAcy5kjVYjJZMoebyBuMLcR9GcdHuyuIP2c9GKysF5kOBjREh1oUGjVwa
         t7TXuoDRqlgvXDmxwxG66TCq43X7ndVJ+ghYboGIIIsmwzm/tw+88QniTUF2HAxlObMX
         1TErm7wTxYin/pjjFyvKHwHy0LugVTJRCSNgcg/zaYBteDd4MH2LOfOZy+46CcvKokg7
         TlS4uJMFgH1P+i7KRLlew63tD+bntvshnxMD5a+cDukMVrRQ6qLYZ3GEX4RQwoSI8/CS
         1AHA==
X-Forwarded-Encrypted: i=1; AJvYcCVxeaduJAk0V1M+yVZo/B+Ik8kG+vdrwzSMRkH3I/hs4U6Sbi1TLxdaLbKP/S+EJAgVGhWkWKsLf+jsuKvVjSiM0SpSZKDL
X-Gm-Message-State: AOJu0YzGKSZYkXbB5WN/wyv+QBf+tZttbiEyfTGK09EYmsfVIrAlK+yw
	OF3E+a5Owx9IAAlumiale5fqn3ADluu0iz1p1F+dsfj60Ws6EmFv48bUmhsrfHeRHQ/OR2HnAy5
	YNX7eNPIIXvoFLUMfgc260khnHuEeMIEVnbVE
X-Google-Smtp-Source: AGHT+IGWGilLzy12Dv8VAke4188rPAQ0OKFvfkHiWvvb18jJsL6vHdLpif5ti5Rm1G+CqcDwXu04/IlUPjEMRABYurU=
X-Received: by 2002:a19:5e1d:0:b0:51a:da5f:ef89 with SMTP id
 s29-20020a195e1d000000b0051ada5fef89mr232134lfb.62.1713543057665; Fri, 19 Apr
 2024 09:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com> <20240418195159.3461151-10-shailend@google.com>
 <20240418184851.5cc11647@kernel.org>
In-Reply-To: <20240418184851.5cc11647@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 19 Apr 2024 09:10:42 -0700
Message-ID: <CAHS8izO=Vc6Kxx620_y6v-3PtRL3_UFP6zDRfgLf85SXpP0+dQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 9/9] gve: Implement queue api
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 6:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 18 Apr 2024 19:51:59 +0000 Shailend Chand wrote:
> > +static int gve_rx_queue_stop(struct net_device *dev, int idx,
> > +                          void **out_per_q_mem)
> > +{
> > +     struct gve_priv *priv =3D netdev_priv(dev);
> > +     struct gve_rx_ring *rx;
> > +     int err;
> > +
> > +     if (!priv->rx)
> > +             return -EAGAIN;
> > +     if (idx < 0 || idx >=3D priv->rx_cfg.max_queues)
> > +             return -ERANGE;
>
> A little too defensive? Core should not issue these > current real num
> queues.
>
> > +     /* Destroying queue 0 while other queues exist is not supported i=
n DQO */
> > +     if (!gve_is_gqi(priv) && idx =3D=3D 0)
> > +             return -ERANGE;
> > +
> > +     rx =3D kvzalloc(sizeof(*rx), GFP_KERNEL);
>
> Why allocate in the driver rather than let the core allocate based on
> the declared size ?
>

Currently the ndos don't include an interface for the driver to
declare the size, right? In theory we could add it to the ndos like
so, if I understood you correctly (untested yet, just to illustrate
what I'm thinking point):

diff --git a/drivers/net/ethernet/google/gve/gve_main.c
b/drivers/net/ethernet/google/gve/gve_main.c
index 7c38dc06a392..efe3944b529a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2579,11 +2579,16 @@ static void gve_write_version(u8 __iomem
*driver_version_register)
  writeb('\n', driver_version_register);
 }

+static size_t gve_rx_queue_mem_get_size(void)
+{
+ return sizeof(struct gve_rx_ring);
+}
+
 static int gve_rx_queue_stop(struct net_device *dev, int idx,
-      void **out_per_q_mem)
+      void *out_per_q_mem)
 {
  struct gve_priv *priv =3D netdev_priv(dev);
- struct gve_rx_ring *rx;
+ struct gve_rx_ring *rx =3D out_per_q_mem;
  int err;

  if (!priv->rx)
@@ -2595,9 +2600,6 @@ static int gve_rx_queue_stop(struct net_device
*dev, int idx,
  if (!gve_is_gqi(priv) && idx =3D=3D 0)
  return -ERANGE;

- rx =3D kvzalloc(sizeof(*rx), GFP_KERNEL);
- if (!rx)
- return -ENOMEM;
  *rx =3D priv->rx[idx];

  /* Single-queue destruction requires quiescence on all queues */
@@ -2606,7 +2608,6 @@ static int gve_rx_queue_stop(struct net_device
*dev, int idx,
  /* This failure will trigger a reset - no need to clean up */
  err =3D gve_adminq_destroy_single_rx_queue(priv, idx);
  if (err) {
- kvfree(rx);
  return err;
  }

@@ -2618,7 +2619,6 @@ static int gve_rx_queue_stop(struct net_device
*dev, int idx,
  /* Turn the unstopped queues back up */
  gve_turnup_and_check_status(priv);

- *out_per_q_mem =3D rx;
  return 0;
 }

@@ -2709,6 +2709,7 @@ static const struct netdev_queue_mgmt_ops
gve_queue_mgmt_ops =3D {
  .ndo_queue_mem_free =3D gve_rx_queue_mem_free,
  .ndo_queue_start =3D gve_rx_queue_start,
  .ndo_queue_stop =3D gve_rx_queue_stop,
+ .ndo_queue_mem_get_size =3D gve_rx_queue_mem_get_size,
 };

 static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent=
)
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 337df0860ae6..0af08414d8eb 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -75,6 +75,7 @@ struct netdev_stat_ops {
  * @ndo_queue_stop: Stop the RX queue at the specified index.
  */
 struct netdev_queue_mgmt_ops {
+ size_t (*ndo_queue_mem_get_size)(void);
  void * (*ndo_queue_mem_alloc)(struct net_device *dev,
         int idx);
  void (*ndo_queue_mem_free)(struct net_device *dev,
@@ -84,7 +85,7 @@ struct netdev_queue_mgmt_ops {
     void *queue_mem);
  int (*ndo_queue_stop)(struct net_device *dev,
    int idx,
-   void **out_queue_mem);
+   void *out_queue_mem);
 };

 /**
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 01337de7d6a4..89c90e21f083 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -60,7 +60,8 @@ static int net_devmem_restart_rx_queue(struct
net_device *dev, int rxq_idx)
  void *old_mem;
  int err;

- if (!dev->queue_mgmt_ops->ndo_queue_stop ||
+ if (!dev->queue_mgmt_ops->ndo_queue_mem_get_size ||
+     !dev->queue_mgmt_ops->ndo_queue_stop ||
      !dev->queue_mgmt_ops->ndo_queue_mem_free ||
      !dev->queue_mgmt_ops->ndo_queue_mem_alloc ||
      !dev->queue_mgmt_ops->ndo_queue_start)
@@ -70,7 +71,11 @@ static int net_devmem_restart_rx_queue(struct
net_device *dev, int rxq_idx)
  if (!new_mem)
  return -ENOMEM;

- err =3D dev->queue_mgmt_ops->ndo_queue_stop(dev, rxq_idx, &old_mem);
+ old_mem =3D kvzalloc(dev->queue_mgmt_ops->ndo_queue_mem_get_size(),
+    GFP_KERNEL);
+ BUG_ON(!old_mem); /* TODO */
+
+ err =3D dev->queue_mgmt_ops->ndo_queue_stop(dev, rxq_idx, old_mem);
  if (err)
  goto err_free_new_mem;

@@ -79,6 +84,7 @@ static int net_devmem_restart_rx_queue(struct
net_device *dev, int rxq_idx)
  goto err_start_queue;

  dev->queue_mgmt_ops->ndo_queue_mem_free(dev, old_mem);
+ kvfree(old_mem);

  return 0;


I think maybe if we want to apply this change to mem_stop, then we
should probably also apply this change to queue_mem_alloc as well,
right? I.e. core will allocate the pointer, and ndo_queue_mem_alloc
would allocate the actual resources and would fill in the entries of
the pointer? Is this what you're looking for here?

--
Thanks,
Mina

