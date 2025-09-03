Return-Path: <netdev+bounces-219709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32224B42C10
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA857A00BEA
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92772EBB9C;
	Wed,  3 Sep 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1rMi3QZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A52EA737
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935802; cv=none; b=EBjuPcGn84xWcdBVyJZ123RrxjBAC6XATK9aVI3Pu4lj2uUNVKRXX1di4GzTzg4dSN65WPr0wmzrrYBZ466LPecHbHPnH68khkfQ6mv9gdRi6J4ysQ8pJw8GCJMIqNi9A9+yKiDWfuaJFbNEt7/I7wGkQZk7QUxiy+0iqTLXFTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935802; c=relaxed/simple;
	bh=IxJb3iWyNm3aZ4CZ8Zpa8yiyHnnFtCH09Ew4obr7C58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GobHtMix3mQU8IYixjLaZEdVW4l6iU8p7c/r+nSFWq5SfuY/YEzJqzIampFhR8pY1e6gdzquqqB0Dh77PHxSgyJ9z9BKg6Uv3gAVRh4SNrodMx0q9FPdRPeV1FrOxSnBB4t9Y6W25X8cHAfY7fSocCEq+VYToF5m2kL3XnwHpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1rMi3QZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756935798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ww7n3YYZXPx7nW2YxFf6fbAuaOV8JLd7wAKoaQ2xK98=;
	b=H1rMi3QZ31NMdQElKZLDlvvAF71G1tgaGlakOc192YqiFQim28S1lwkuC1axuHzR6dRNq8
	gZZIj+GTarJze21QLQTF0mC/IG3hfOjQvR25Swc43hNxfAOrwDA84Jv5bpi5OPfPq/lqt9
	qPl8AnVF2sNO18D1zgkEOyiPPf1UHK0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-DdNZzGHoPe6FB35L8OlZVw-1; Wed, 03 Sep 2025 17:43:17 -0400
X-MC-Unique: DdNZzGHoPe6FB35L8OlZVw-1
X-Mimecast-MFC-AGG-ID: DdNZzGHoPe6FB35L8OlZVw_1756935796
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45cb604427fso1841555e9.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 14:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756935796; x=1757540596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ww7n3YYZXPx7nW2YxFf6fbAuaOV8JLd7wAKoaQ2xK98=;
        b=DC/ldvhy4mYAYOna3tpwHgULockhVGKynIyQdg8X0MGbd5jTWXnrYDK4+bUxWDy4W6
         8kB5vFpsc5IZ6GFhj5PqM/cWR1juv9eh7wR3XxBr0JT9Bb4mAyQnjMNtdbIJQseaGxlY
         vkw4v8RDPCgnxfJPyiFLi6VjxbOD852z4WKQBygCvHxm7FVmkklYQwEtbX+BcaORQTXG
         mwF9xVH3ZBQdwtEK1opAtcJvkO76c0aWrL9oRS48MXJxGKySvkS1JO0raiaDK+d2gOfj
         petjAbj7/I1N2J6bDVnGT2wLbHKrm/tpwfRtc9OwqV2NtQ66WjPjt4i9qeB3DiSRjanA
         2oYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9SQgqFoTZt9Ya69rvpHZbxmU2fJja9x9CCzAI+x1q1TQKr3F7uxGkW8aNAVkEjuSytX3zYyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVXx0iYbwyLx4nEcodSieepLLGHo7wag3+lG6ZbZ4Nh9H2ywkv
	NxnjoA7hBiAzeFcMQ1LhNJNOdCS0UPSlb/om8kKfpLdD3e7EPGYUoocfpNZTvdKMG+Hx4vnjQLZ
	eQukmEDX0mP3RXZc9NTuQjZ7ExzGhwnqQp3gqfGvD7uG6Yjv3vsqkSv7GIRLsSq63cwoNPdE=
X-Gm-Gg: ASbGncsLQlOUXdYNN+Gqu77YsQTabxI9G1wJqvkV9MQGm6z+0AWwd/cRa8PiaX7GDnS
	Bex6XTLLcFp5FuOXd4wAGG4Ikh6lH7Apa5a9otmLfNU1cFYfvcEXJvSu08j/KT3L+obWIhMfwK0
	IuggKUEKp+QIfxMgNx4Y25gMuXWPDu6mxbs/HUfH+16kdDbXtIUvSg4b6TYJmP/XEwGUwcG9qyZ
	OizzWm5SdMnoSNQg+0vOjo8zO7PThrcxye3dhcFaQNUB3BfgFvchm6aqW2u+kw13PjN/1MHXLNG
	LcR5mwpMbYOADxPKqo+tnf+ABPP1HFy6LPUaom7ap9/U
X-Received: by 2002:a05:600c:c8f:b0:45b:7ce0:fb98 with SMTP id 5b1f17b1804b1-45b85528677mr147560835e9.5.1756935796213;
        Wed, 03 Sep 2025 14:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpptRMLCKUx66SSyYaeG55+QPu1fDBqSH17ajZCjnlYKUXh4ETIc0JSFR1AZRayU2byQD2VA==
X-Received: by 2002:a05:600c:c8f:b0:45b:7ce0:fb98 with SMTP id 5b1f17b1804b1-45b85528677mr147560695e9.5.1756935795815;
        Wed, 03 Sep 2025 14:43:15 -0700 (PDT)
Received: from fedora.redhat.com ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fbd01sm25529918f8f.13.2025.09.03.14.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 14:43:15 -0700 (PDT)
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
Subject: [PATCH net-next,v3,1/2] devlink: Add new "max_mac_per_vf" generic device param
Date: Thu,  4 Sep 2025 00:43:04 +0300
Message-ID: <20250903214305.57724-1-mheib@redhat.com>
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


