Return-Path: <netdev+bounces-172997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B602A56CCD
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684EB178B16
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9596221710;
	Fri,  7 Mar 2025 15:57:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111A221547;
	Fri,  7 Mar 2025 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363051; cv=none; b=AE/8DekubAr0iG943akUzWgbtEHrKaXwRw4DGF6SsOgP3v5otjJl61o2X80SAlJJwmtbexxDDq3q1Q+1IjnvQTY01OLsjXqu+PNmFcUxV4iqiJuqRUUg1m5z+3dE0lCNsDak90pdO2tJbd7DcOCBHnkn17xeWZEi613vBmdScKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363051; c=relaxed/simple;
	bh=JniLJibKpEppVkt3pfDVBslPwEadXmwWbzGIt0QUQWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX4YIZ6R0rYpiOZn8GsGlM5nZ1wGdLYavOrfTKq6nhVMeEI7PSAzM3FRQZqjMyr1Qm8HKAHI4ezedk4X79kv8u3eKIAFPY1mNEiar3D/tz9Ens7kS+C1GRJe+vngwbCEGJPKH5CaYnl5NxFgwE4oC0iAPAT58ng3l3KJSNSdMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2241053582dso11716365ad.1;
        Fri, 07 Mar 2025 07:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363049; x=1741967849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNf+k9hhNyVSY2O3O8aKeeb+5wxc5hlSdDGv1HkARCE=;
        b=RehljJckTmUGPW1BLm65w4RifRg6kdAVu5byLN5p8iugQPxYLO5xR+kY1ScpRjIt9T
         VyhJo/ly8gNBfUPBIx9z17kv55gpuCgFNxN8GwB881BHyMd6wFjwv6s0M13gK7O22Ym2
         LVBbT0k3bhe3BIYRLtnDZYjqNzIO/syXxWihoYZF/wq1y6Jh7b4chd5fFw6/VZQt1/4q
         Twk9bXhsMCzChFDABKXJcd10PnsmTMSjD/cWPLvWT22L2R0AyxLGRzlS23aJUJB+tFlq
         N6DTf2Xxdf8JqNrjs2SBcP38DL8XiSxKGkuLJ/KkQCRG8NNjbt3dzBUDicmQHvhXhumq
         am1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6dOp+PLoyYUAo5rPD+f5QHn4KYdXf0sYBdSb5NlNic5gIpItTNEseJVauUwFS3MYn30GC7RtqNYQLjbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6MrKppWyhHC7iGmWu0twhUSxMkbCbS8Rl1J3/xXxn2F1uM+1s
	s6sg/bB6Tp39X3wBssUE032KJPebD6ipBvgiV+uKSTqjKdBj5QoW9lPN
X-Gm-Gg: ASbGnct4ogE0wQIpvys8xgiISZ1njH6BsF4xl3y7MfOMRWN7VCDYJlQMz9xEg+fRmOM
	MnTWwKxf2txByBLYOuq34wSoHPXAxrLET2gJmnCjsfFCkW1zvxwSrJixKPEAcres2deap66sr5v
	tC8bC0qfiw9awm9T0VhmkMaCcwqiB4Dxdo7+wgkUvwjc/BZA6jXLVPG9nmcIwa8dD4cXr5eSiBL
	AvUIhEWF7kShSFTJ4pO5WajGju7asTk5Oz23A9PIEuUz6GS81bz4N7iwble3Djpu3GN3MvWU2Yg
	SXinZUq/z0JjTLXf6bIuUo/DwshyPJp7L/yFX2u3uXbx
X-Google-Smtp-Source: AGHT+IHIlEarVBMAmVMhYTsCxYZWZDmie8Syv0Q2HhlZf5ejT//6e8OjZ/bByE+MuJvWYL1wxcP4Zw==
X-Received: by 2002:a17:902:f54e:b0:224:7a4:b32 with SMTP id d9443c01a7336-2242888b350mr60240155ad.20.1741363048785;
        Fri, 07 Mar 2025 07:57:28 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109e99dfsm31733925ad.91.2025.03.07.07.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:57:28 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	jdamato@fastly.com,
	sdf@fomichev.me,
	xuanzhuo@linux.alibaba.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk
Subject: [PATCH net-next v1 2/4] net: protect net_devmem_dmabuf_bindings by new net_devmem_bindings_mutex
Date: Fri,  7 Mar 2025 07:57:23 -0800
Message-ID: <20250307155725.219009-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307155725.219009-1-sdf@fomichev.me>
References: <20250307155725.219009-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the process of making queue management API rtnl_lock-less, we
need a separate lock to protect xa that keeps a global list of bindings.

Also change the ordering of 'posting' binding to
net_devmem_dmabuf_bindings: xa_alloc is done after binding is fully
initialized (so xa_load lookups fully instantiated bindings) and
xa_erase is done as a first step during unbind.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/devmem.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 7c6e0b5b6acb..c16cdac46bed 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -25,7 +25,7 @@
 
 /* Device memory support */
 
-/* Protected by rtnl_lock() */
+static DEFINE_MUTEX(net_devmem_bindings_mutex);
 static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
@@ -119,6 +119,10 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	unsigned long xa_idx;
 	unsigned int rxq_idx;
 
+	mutex_lock(&net_devmem_bindings_mutex);
+	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+	mutex_unlock(&net_devmem_bindings_mutex);
+
 	if (binding->list.next)
 		list_del(&binding->list);
 
@@ -133,8 +137,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
 	}
 
-	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
-
 	net_devmem_dmabuf_binding_put(binding);
 }
 
@@ -220,24 +222,15 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	}
 
 	binding->dev = dev;
-
-	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
-			      binding, xa_limit_32b, &id_alloc_next,
-			      GFP_KERNEL);
-	if (err < 0)
-		goto err_free_binding;
-
 	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
-
 	refcount_set(&binding->ref, 1);
-
 	binding->dmabuf = dmabuf;
 
 	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
 	if (IS_ERR(binding->attachment)) {
 		err = PTR_ERR(binding->attachment);
 		NL_SET_ERR_MSG(extack, "Failed to bind dmabuf to device");
-		goto err_free_id;
+		goto err_free_binding;
 	}
 
 	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
@@ -305,6 +298,14 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 		virtual += len;
 	}
 
+	mutex_lock(&net_devmem_bindings_mutex);
+	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
+			      binding, xa_limit_32b, &id_alloc_next,
+			      GFP_KERNEL);
+	mutex_unlock(&net_devmem_bindings_mutex);
+	if (err < 0)
+		goto err_free_chunks;
+
 	return binding;
 
 err_free_chunks:
@@ -316,8 +317,6 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 					  DMA_FROM_DEVICE);
 err_detach:
 	dma_buf_detach(dmabuf, binding->attachment);
-err_free_id:
-	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
 err_free_binding:
 	kfree(binding);
 err_put_dmabuf:
-- 
2.48.1


