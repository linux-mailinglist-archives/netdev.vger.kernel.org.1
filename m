Return-Path: <netdev+bounces-45939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB227E0744
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08431C21085
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84880200AA;
	Fri,  3 Nov 2023 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7DG3s2W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186691D6AA
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:17:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD44D50
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699031861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVS2kk0D6Tt1PgwcrwV42T54QxmIjT+wF7r94StjHU4=;
	b=X7DG3s2WrH2LjyfRjHHMdSxr6yYpCAL0dGNyCQYx+Dswa+tytPV4mTnYwoVukdAZYFZsLh
	9zo/AQdioMhQZwRaRgCFDlUCkWIXOwzInHjjV3P74z2s/i1mKSvlTwql4YYiiUgybNop/H
	s9AwBBY0imxdaEo7n0MiCRWLLz2s6lg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-lM2HJKEnOZCxb--cVZ2jKw-1; Fri,
 03 Nov 2023 13:17:40 -0400
X-MC-Unique: lM2HJKEnOZCxb--cVZ2jKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EFB8282478F;
	Fri,  3 Nov 2023 17:17:36 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A404C1290F;
	Fri,  3 Nov 2023 17:17:32 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	yi.l.liu@intel.com,
	jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [RFC v1 7/8] vp_vdpa::Add support for iommufd
Date: Sat,  4 Nov 2023 01:16:40 +0800
Message-Id: <20231103171641.1703146-8-lulu@redhat.com>
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
 drivers/vdpa/virtio_pci/vp_vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 281287fae89f..dd2c372d36a6 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -460,6 +460,10 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
 	.set_config	= vp_vdpa_set_config,
 	.set_config_cb  = vp_vdpa_set_config_cb,
 	.get_vq_irq	= vp_vdpa_get_vq_irq,
+	.bind_iommufd = vdpa_iommufd_physical_bind,
+	.unbind_iommufd = vdpa_iommufd_physical_unbind,
+	.attach_ioas = vdpa_iommufd_physical_attach_ioas,
+	.detach_ioas = vdpa_iommufd_physical_detach_ioas,
 };
 
 static void vp_vdpa_free_irq_vectors(void *data)
-- 
2.34.3


