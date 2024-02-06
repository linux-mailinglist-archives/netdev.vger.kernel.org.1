Return-Path: <netdev+bounces-69524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADA384B866
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BF11C22DC0
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180A4132C38;
	Tue,  6 Feb 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3GtIuNc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B34131E53
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231125; cv=none; b=gFg75QvRRbsfTdEMIwVPYczVDKADYAxGeZb3fEzyZEuq8oS49VGuvBHo/jyWtoMWWsBpFTLGPzRCbWhM9NO3NSUHNIC1x03MzkMc8d5lwOOYBhh/pKR33vy4MkdRKI9k2XiYHCcFRlLjHqXpffqoDNI9gEbScU3fbCJywidgY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231125; c=relaxed/simple;
	bh=R/o5EP7C+JnoxFgZaYwDA4ls6GyyKFxMVhJAZddFp0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=cMvYoZlqMceF1fjrgUdZfGHv/Nht4v3YyVcdtoXPLRdcySiHqQlY49dVKyBE6myvXyvrnadNjYmwePyn7kf9LzBlmVFZltyKK9VARIxBN7LMnIZxuo2TTc4/TwK3U3iWxILxZETrP6nzrMe0P9cBILEaJs5W9blyb/hOlOoIfdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3GtIuNc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707231121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dQIKoNOJmX8VRVk5/I0n1vx+OMQlaoxl3aigw5zkfn8=;
	b=M3GtIuNcrkaLuuKbLsufc6LHzmQaCS1Vng0oR0emc4pYP4QmdfgBquDU3joazvUwgIBFjO
	c6Le4uvu9V0j4CDfQVaw6anOuOh0WPfCK2ABKCjS0FPXxp2T+J+CWj00rKwNNObJumnmPm
	nWJQUv4WyRCxwKPnxkTLN10MnHNa/ho=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-SMeT-244PmqEXS_DZOrPJA-1; Tue, 06 Feb 2024 09:51:59 -0500
X-MC-Unique: SMeT-244PmqEXS_DZOrPJA-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2195a9a8efaso3588872fac.2
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231119; x=1707835919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQIKoNOJmX8VRVk5/I0n1vx+OMQlaoxl3aigw5zkfn8=;
        b=P+HSkkA8Jsxkp8uItI6j/2/Hq3CSn5WnrajJTx5ZsJLWXlUT9lG6JjKxWmOpF5RS+G
         qsllnLa+cPiwjUMs36PHBGdhmy+Hmh0TudcgsrvHmonnc/eZpMQ4vLnchUGt+0xdT2h9
         7X5lDFqlLiGtMQTvQBls0FL2TxhHZrCXF6rSDOnFDVat307Zwu43axuJvb2yb0L10kxo
         T+A6rsI2xMdNOo3bHDDbi4VPeVwS1LvqUqex0OwuhioFZyzcKCmZRdy48UCzbx5H7Zbh
         /1FWsfwEO+pugydh3JLqdm9CSs6ba0vzwZSWHoRjvG+/5Za17aqV49TaPLRZr8DO+cBO
         p59A==
X-Gm-Message-State: AOJu0YxTIRmqGtd07T3vQFgipPzZTb2kAlzHJs6uRJwT60yuyGtLlczP
	4SEDkBsp9BlfUEBHOTPHB4s/CJdNqmUjgio0h448SsOgC9c2sy94kRF9c9lLMTnl30W8CNhXsXx
	6UIZRkqW/SewKWZW0tAzqoyOC/JwA267zcTjk+tsO98EkChgaBfZ98A==
X-Received: by 2002:a05:6870:164d:b0:210:8802:786a with SMTP id c13-20020a056870164d00b002108802786amr3275746oae.53.1707231118965;
        Tue, 06 Feb 2024 06:51:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLCyho5u5y4dZMOsWQV1AaVbjSFpDdh6YZMYgsdjNzX2ck/ywfHH/5T/kc/2KHsZrayoPM0A==
X-Received: by 2002:a05:6870:164d:b0:210:8802:786a with SMTP id c13-20020a056870164d00b002108802786amr3275728oae.53.1707231118721;
        Tue, 06 Feb 2024 06:51:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV6YVTF3BXfxD7oGuNc/5i4fJi9lzUP0v2EuV9vQ2uYj3WVgVJCvsEX8TROSCzAqDs5ebrmUOfU/S/j7kp3jXPim8rxZSbJKSJVXStktmV2oqMTXILCaFK8Q7/Dm4SdzEV1oi2ax7XvIFESMcCV8iCOJSstM1x0ffCK9wzkBPAe4UiZZyES5vihMsa0sRYoqZu0wDySrdl+bWTxhpQjZZsre7Rw5ZHednIiXPP1W399e2EE8jsT8XU9D+7TeQhQE87br0/am75tATSNqLHpbPwm+dZTE8klIcCGRw==
Received: from step1.redhat.com (host-87-12-25-87.business.telecomitalia.it. [87.12.25.87])
        by smtp.gmail.com with ESMTPSA id k19-20020ac84793000000b0042a9b28733fsm930742qtq.89.2024.02.06.06.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:51:58 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux.dev
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Kevin Wolf <kwolf@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost-vdpa: fail enabling virtqueue in certain conditions
Date: Tue,  6 Feb 2024 15:51:54 +0100
Message-ID: <20240206145154.118044-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

If VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated, we expect
the driver to enable virtqueue before setting DRIVER_OK. If the driver
tries anyway, better to fail right away as soon as we get the ioctl.
Let's also update the documentation to make it clearer.

We had a problem in QEMU for not meeting this requirement, see
https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redhat.com/

Fixes: 9f09fd6171fe ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature")
Cc: eperezma@redhat.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/uapi/linux/vhost_types.h | 3 ++-
 drivers/vhost/vdpa.c             | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index d7656908f730..5df49b6021a7 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -182,7 +182,8 @@ struct vhost_vdpa_iova_range {
 /* Device can be resumed */
 #define VHOST_BACKEND_F_RESUME  0x5
 /* Device supports the driver enabling virtqueues both before and after
- * DRIVER_OK
+ * DRIVER_OK. If this feature is not negotiated, the virtqueues must be
+ * enabled before setting DRIVER_OK.
  */
 #define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
 /* Device may expose the virtqueue's descriptor area, driver area and
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bc4a51e4638b..1fba305ba8c1 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -651,6 +651,10 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	case VHOST_VDPA_SET_VRING_ENABLE:
 		if (copy_from_user(&s, argp, sizeof(s)))
 			return -EFAULT;
+		if (!vhost_backend_has_feature(vq,
+			VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) &&
+		    (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
+			return -EINVAL;
 		ops->set_vq_ready(vdpa, idx, s.num);
 		return 0;
 	case VHOST_VDPA_GET_VRING_GROUP:
-- 
2.43.0


