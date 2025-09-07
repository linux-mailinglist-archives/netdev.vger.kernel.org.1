Return-Path: <netdev+bounces-220667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C86B47A57
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 12:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AF614E0F55
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2123AB90;
	Sun,  7 Sep 2025 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e18QRpIj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8B221294
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239528; cv=none; b=A8ZYRd0fud/JxGrKHTr8UpDd39+G1GlpzqI8cCEHeXgvqzt/HBbw9dp1Gh7Lj9Z1IfgjYr/BBKqfc1xEjn3KUVm6W2Jrlg0nU0J+1bi4D9e5oMy43+/9EFpIque50L/MrW9F8yoX3kZv9QT/E+TeF+aXK9jbuGoNi6qAnNrRuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239528; c=relaxed/simple;
	bh=EV0oiyXl5Xtij7zpbaO7S62LO5bBMVmR61ZsEOKJ17Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfIRPBn9ZGTBtTa6dYVAgg0XPpELIKYSphJ/410FKYvKIZKb90DPqaOPgU9YedNWMlFyGbgFL9zEzDKkcfMmbHdlzOdps0RsCZSeDTGhwvOmXJqL645Vn+4e71UDKcql8sRBUYPJZY7RzpjhD4KeQwaH7b1u1RwqB21ApjySmyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e18QRpIj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757239525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nGGRZIccDnooD20o9KF2Pmvo27vaja4lvG3g76RUK6Y=;
	b=e18QRpIjpkZ1q0Syjrr9Rcxfr7UepTpnYM29ZMbIJFdRjd+EYOmuoaCe7kNfTZA+2WhCfs
	2Lrkt8MCeq0Iz/dGZEEwn8xkSfu0Vsn7l1dladaLG4pPta+OCh9mxAN8iUPjjrCBOF+3Pg
	j3a2UZhTyN42u5OJFmnXtNqCaXMRQzU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-fU4doIbdM3SweeMcevylqQ-1; Sun, 07 Sep 2025 06:05:24 -0400
X-MC-Unique: fU4doIbdM3SweeMcevylqQ-1
X-Mimecast-MFC-AGG-ID: fU4doIbdM3SweeMcevylqQ_1757239523
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b9912a07dso22658835e9.3
        for <netdev@vger.kernel.org>; Sun, 07 Sep 2025 03:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757239523; x=1757844323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGGRZIccDnooD20o9KF2Pmvo27vaja4lvG3g76RUK6Y=;
        b=do57CqMTXwTjUmiqWDFaA7t+4N1LduoschwGLiiUW6Bjt/GTkfdLV+ZCAOsNRk2wKv
         zmlLOOX+9P/78EVDxGI1U0q1y+8ssygf8BaOHJ8aaXC2wimIgOfmQnIZBqSKfsIqI4UO
         Sh0Yam/53Xz7ZzSl3+izAiEKuGpoNaGqQBEWM36EwD5l7tsLj0cG6RKARIfNEuBxQmB8
         pD83HhQWDPyVuzIdp6Yvp3Ilq8wApyEeg+iX7Zsuc7k3XR3Bgqkkxu0Y0ONGi1H0qo9m
         mpKPb/J7TCy8wCEpfa85Aq4fR6DV02igXBCD5j3k8wrPj7IJ9Rq02XfkCIWjA/RqxIBC
         0IRA==
X-Forwarded-Encrypted: i=1; AJvYcCXE08Ucv2u10HJmzTRDV6xfzmEiiJZ4GYExeV0JsoaQiySm+DofRCi+RZtkIZenvFjEapgxlFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvIIiTJOVag4/t3jc/TxKeQMQx0uHcKaBa7aUQhds0STdzJtr+
	c+LV5UZmw7L6RcfRmv3UuMhRJcyZTTZV0j23e3XvVP2kl/7iDXZgMxiIPGqT8RYi4Dpc+PhF7jA
	u6aaMLCSWw8hR+ebpzqR/yx9NIBPOd+0qW8EkX3xqmWFiU+NFn13iCwbwbw==
X-Gm-Gg: ASbGncsip+iEt2wB964OOHczi8DrlTV9FW3K2dwhlzwDJOFaPUUSUSbMkqKNrD+zsFW
	yQg3VKnB6c3oGHpCXWzZr1M1hXdYDdYzKTy2D+611BQ9Hspxnm+WC/zR60RcyyTQ2FNwg3O5GOT
	F07CRCakIWoSxox+uGCGi07LZFKSRAHSdWy3J7bc2MNYfzG1LCYPFVY+pbzIf3C1FylgsDMeJ7E
	sPmFgfQaTtOTQvNRTF8ZxfMAQqbUjXWEH6q0AoKug25r02moY95G0y4WG7hjeLXVDAJU6pwzG7O
	M2+ioAdQitp29+qimKpa/3Exu3RSlUC2u1+tprUsbF8R
X-Received: by 2002:a05:6000:2dc9:b0:3e5:25c2:9635 with SMTP id ffacd0b85a97d-3e64c3aebe5mr3707361f8f.56.1757239523147;
        Sun, 07 Sep 2025 03:05:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy78tM0pUm983bEUmFh4QtO1D/4cF7xG7JMTEeRcr/FG0Xk/vXwOqZBNkRnYDcI3Pqok0ACQ==
X-Received: by 2002:a05:6000:2dc9:b0:3e5:25c2:9635 with SMTP id ffacd0b85a97d-3e64c3aebe5mr3707337f8f.56.1757239522692;
        Sun, 07 Sep 2025 03:05:22 -0700 (PDT)
Received: from fedora.redhat.com ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3db72983560sm19323344f8f.1.2025.09.07.03.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 03:05:22 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: przemyslawx.patynowski@intel.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net-next,v4,1/2] devlink: Add new "max_mac_per_vf" generic device param
Date: Sun,  7 Sep 2025 13:04:53 +0300
Message-ID: <20250907100454.193420-1-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

Add a new device generic parameter to controls the maximum
number of MAC filters allowed per VF.

For example, to limit a VF to 3 MAC addresses:
 $ devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
        value 3 \
        cmode runtime

Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 Documentation/networking/devlink/devlink-params.rst | 4 ++++
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index 211b58177e12..74a35f3b7c9a 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -143,3 +143,7 @@ own name.
    * - ``clock_id``
      - u64
      - Clock ID used by the device for registering DPLL devices and pins.
+   * - ``max_mac_per_vf``
+     - u32
+     - Controls the maximum number of MAC address filters that can be assigned
+       to a Virtual Function (VF).
diff --git a/include/net/devlink.h b/include/net/devlink.h
index b32c9ceeb81d..dde5dcbca625 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -530,6 +530,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
 	DEVLINK_PARAM_GENERIC_ID_CLOCK_ID,
+	DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -594,6 +595,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_CLOCK_ID_NAME "clock_id"
 #define DEVLINK_PARAM_GENERIC_CLOCK_ID_TYPE DEVLINK_PARAM_TYPE_U64
 
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME "max_mac_per_vf"
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE DEVLINK_PARAM_TYPE_U32
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 41dcc86cfd94..62fd789ae01c 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -102,6 +102,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_CLOCK_ID_NAME,
 		.type = DEVLINK_PARAM_GENERIC_CLOCK_ID_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
+		.name = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME,
+		.type = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
2.50.1


