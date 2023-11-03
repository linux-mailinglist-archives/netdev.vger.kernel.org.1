Return-Path: <netdev+bounces-45938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 288687E0743
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675BBB2134B
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B8E1F92C;
	Fri,  3 Nov 2023 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ft82Hqy/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E921D6AA
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:17:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147DA13E
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 10:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699031858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZcijrBkenJpJgKIh5nn77fb44ksEJ9Uwp/HPtluVaY=;
	b=Ft82Hqy/4WcFtuAeWR38lbEEwAPOyA/quiH5giIYxxcDMo5tl7Bos2aVqET45nbIrknDUt
	vVPN9HdYAKv9Afz6KKIaqg1gKJLIXf0h+9r7h69ks2/r64nGBwP6KDsc6u6mNjCHM9SVc/
	0Xbjcrp6Nn6i+p0ekDvRlG1ewN47q2k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-WVF19FtuOU6EB2xsKppuQQ-1; Fri, 03 Nov 2023 13:17:34 -0400
X-MC-Unique: WVF19FtuOU6EB2xsKppuQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B31B6101389C;
	Fri,  3 Nov 2023 17:17:28 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8A0CFC15983;
	Fri,  3 Nov 2023 17:17:25 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	yi.l.liu@intel.com,
	jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [RFC v1 5/8] vdpa_sim :Add support for iommufd
Date: Sat,  4 Nov 2023 01:16:38 +0800
Message-Id: <20231103171641.1703146-6-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Add new vdpa_config_ops function to support iommufd

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 76d41058add9..9400ec32ec41 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -762,6 +762,10 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.bind_mm		= vdpasim_bind_mm,
 	.unbind_mm		= vdpasim_unbind_mm,
 	.free                   = vdpasim_free,
+	.bind_iommufd           = vdpa_iommufd_emulated_bind,
+	.unbind_iommufd         = vdpa_iommufd_emulated_unbind,
+	.attach_ioas            = vdpa_iommufd_emulated_attach_ioas,
+	.detach_ioas            = vdpa_iommufd_emulated_detach_ioas,
 };
 
 static const struct vdpa_config_ops vdpasim_batch_config_ops = {
@@ -799,6 +803,10 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.bind_mm		= vdpasim_bind_mm,
 	.unbind_mm		= vdpasim_unbind_mm,
 	.free                   = vdpasim_free,
+	.bind_iommufd        = vdpa_iommufd_emulated_bind,
+	.unbind_iommufd        = vdpa_iommufd_emulated_unbind,
+	.attach_ioas           = vdpa_iommufd_emulated_attach_ioas,
+	.detach_ioas           = vdpa_iommufd_emulated_detach_ioas,
 };
 
 MODULE_VERSION(DRV_VERSION);
-- 
2.34.3


