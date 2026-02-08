Return-Path: <netdev+bounces-257828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF2LLDSfiGlAsgQAu9opvQ
	(envelope-from <netdev+bounces-257828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 15:35:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D298A108EB7
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 15:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEB6330028DC
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947CF30BBB6;
	Sun,  8 Feb 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SddQec9Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4776330AADB
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770561307; cv=none; b=fftYTMcDyHwUblDpre10uiAG56NobIKCSBfTdTr4VeguhEn/kCB+wGrGwDjeCGR1xvgFcZicEtFFtLaoj0SRqq5XbSf1Hj45aWIqW+YvcTRs30XxZhC5WizIj02+GcvjbXLRG5fV1Lw2cgDQCt8Aygui4d5qHRbj1/fUxV8UR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770561307; c=relaxed/simple;
	bh=jbLiVAKMhESJ8+i8oOV5pM46x7SY1sE0iQGT/xEUVFU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXq4gvN1jXomfmmQSJnkkqefi5BbRB1bPur1Lt2Fd8KGBbGDJw7Op4NTG6b2YF56LHiuBiBJakVnNWm24XgXOoC7ALZ87m0KKoxMJkRa+DgUZhA9ZFXFyujprnPtu3/9H+Yty7c8tWTjaBR+xaBDn1oUz7g7o2PeImro6xnYZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SddQec9Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770561306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVev9RGq9dVMgOhnEQZeZI8sYWkDO4xwFAo1DRJbKV4=;
	b=SddQec9Yv6lo6RG5rI/64Yv1f0NxJ1Psabv9fDy7cfGaEw3WmDkaHezZsxG+0EHLDNO/li
	KB+sx+46e/apc4jkfVNCrPRn3pH3gpHOXPU9txluAIJC00EcC+0W3YO8J3RnfpEN8RSE60
	KrQSk9nEZ9cjALNGkw8NskVZaf6v+sY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-YIOmSm6KMder5mDp-5P10g-1; Sun,
 08 Feb 2026 09:35:03 -0500
X-MC-Unique: YIOmSm6KMder5mDp-5P10g-1
X-Mimecast-MFC-AGG-ID: YIOmSm6KMder5mDp-5P10g_1770561302
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D34AC1956089;
	Sun,  8 Feb 2026 14:35:01 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CC2C18004BB;
	Sun,  8 Feb 2026 14:34:57 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 1/3] uapi: vhost: add vhost-net netfilter offload API
Date: Sun,  8 Feb 2026 22:32:22 +0800
Message-ID: <20260208143441.2177372-2-lulu@redhat.com>
In-Reply-To: <20260208143441.2177372-1-lulu@redhat.com>
References: <20260208143441.2177372-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lulu@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-257828-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D298A108EB7
X-Rspamd-Action: no action

Add VHOST_NET_SET_FILTER ioctl and the filter socket protocol used for
vhost-net filter offload.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/uapi/linux/vhost.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index c57674a6aa0d..d9a0ca7a3df0 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -131,6 +131,26 @@
  * device.  This can be used to stop the ring (e.g. for migration). */
 #define VHOST_NET_SET_BACKEND _IOW(VHOST_VIRTIO, 0x30, struct vhost_vring_file)
 
+/* VHOST_NET filter offload (kernel vhost-net dataplane through QEMU netfilter) */
+struct vhost_net_filter {
+	__s32 fd;
+};
+
+enum {
+	VHOST_NET_FILTER_MSG_REQUEST = 1,
+};
+
+#define VHOST_NET_FILTER_DIRECTION_TX 1
+
+struct vhost_net_filter_msg {
+	__u16 type;
+	__u16 direction;
+	__u32 len;
+};
+
+
+#define VHOST_NET_SET_FILTER _IOW(VHOST_VIRTIO, 0x31, struct vhost_net_filter)
+
 /* VHOST_SCSI specific defines */
 
 #define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
-- 
2.52.0


