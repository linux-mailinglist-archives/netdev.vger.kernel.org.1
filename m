Return-Path: <netdev+bounces-141826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C9D9BC70C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEF0283CB7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 07:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5046A1FF051;
	Tue,  5 Nov 2024 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UW+mkX5g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081C1FE10C
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791714; cv=none; b=k+8EKPseQjlR+7Kq1w+Xvq0MxOb8/SWDTsi7XvaoW+U7ZETwPsDoC1ALj2m3d1k9pw9Ht+9cSdOhX5Elcm4tUOan9SeeRahco4W2Ufm7DzWxSIpm+vG8bA0/xM5C4m4HiP1AOWvUWlKSElSkPFbAMfMrQ5eIiPsN8h4HXSQT2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791714; c=relaxed/simple;
	bh=MX5FZQA4EmsLL2pOoIXNJm9EOZkEs7x6Q7BAjrZW4D4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHJ6ofPku7JR/sKmBI9QM/RD2HubrJJt93DnLx+g9n+WVBaLwAAWC5tbWCKRNcnC6z8XQdhHkP+/ofLhf16Diup2QqDtiTHgpdDmjek+KNbj3E0yagpFZd8ipukuQfxlWpBD1JUFAgFzei/mHfn9wMzdFQJcRAk9xA2f7ZHhOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UW+mkX5g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waOIJYR/uf8lM72gcE+nfFRZp8HYpeFxyDV384TmS5E=;
	b=UW+mkX5gKp13qtB//km6gwi1pl/sXu8tZITIZ3Pchm5Ctk8+9/rsh5o2/+4bXBveoN+C61
	rNKljNknM5GSWbDtWcIpygHBdQVBnusrv4lXF12znJj/neMo1qcxhZl1Ju/hBkv9qkGd1d
	p9IjsrolyikmSrSvI6LP2vBFc/OaYuc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-JVDKDcsiOTSUpOOxeo5f5g-1; Tue,
 05 Nov 2024 02:28:28 -0500
X-MC-Unique: JVDKDcsiOTSUpOOxeo5f5g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A897C1955EAA;
	Tue,  5 Nov 2024 07:28:27 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00BD119560A3;
	Tue,  5 Nov 2024 07:28:22 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 8/9] vhost_scsi: Add check for inherit_owner status
Date: Tue,  5 Nov 2024 15:25:27 +0800
Message-ID: <20241105072642.898710-9-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-1-lulu@redhat.com>
References: <20241105072642.898710-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The vhost_scsi VHOST_NEW_WORKER requires the inherit_owner
setting to be true. So we need to implement a check for this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/scsi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 006ffacf1c56..05290298b5ab 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2083,6 +2083,11 @@ vhost_scsi_ioctl(struct file *f,
 			return -EFAULT;
 		return vhost_scsi_set_features(vs, features);
 	case VHOST_NEW_WORKER:
+		/*vhost-scsi VHOST_NEW_WORKER requires inherit_owner to be true*/
+		if (vs->dev.inherit_owner != true)
+			return -EFAULT;
+
+		fallthrough;
 	case VHOST_FREE_WORKER:
 	case VHOST_ATTACH_VRING_WORKER:
 	case VHOST_GET_VRING_WORKER:
-- 
2.45.0


