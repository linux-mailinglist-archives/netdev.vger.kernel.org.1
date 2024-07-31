Return-Path: <netdev+bounces-114414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798094279B
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71A81F250C0
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 07:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BBE1A4B49;
	Wed, 31 Jul 2024 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnWgghF/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD113D393
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410071; cv=none; b=fZMgL65ZHD+gfRlWBKOOGZOIX1oC+glTZBaxJFkoCy7MvXGd90rximJdq7KkPFkmquYc6kCLEGTI8O0+8Wsz6Ex9kBxMfUEcNWFehr/xP6zu5ze5AS49LbCrfvzG2BRttpf0q3VA8TqOU8Y7dCRVQcY7xaeWGJtAJe4rRkUaDM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410071; c=relaxed/simple;
	bh=7lXMhx5fIqWBLe3k/V2HO/fXXALVstWTZI+5WRi0Wko=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aC2pPyDd66nMtFt0wTvVKAk5HD0KC8vC1cDDxN8ojUYSDOuFVGc6/pRWBhARDa/N6EFpsiVAJ5qf7q8IMuDHTsaUvyPmtzAW/uQ+tlDVa7LSf/GEwyTUIuideztDOcibWMGkzSjczfBA+u+D+PLOORCN5QIq8J5tarylznm1FDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnWgghF/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722410068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wrhtXgfSncqISOPR73ry/daCovNTLSYB18z/1de++Qs=;
	b=JnWgghF/4Ssjo6Cr5jsYqH49IaK+sQi2k6/IlcJiTKtt5MtT936qBRzU5KoTXNtFhNbfmk
	xjrPe8GA2liY7eevlMNC3GL3OkpZiE0CE/PGGYBplVBxA1cymNuD8FQdTvJGFdoEETdt7E
	RVnDnCJ16qlucxto2dmpkId+V/qlZ40=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-Nszda0nUN0SyBHmZEzo_Hg-1; Wed,
 31 Jul 2024 03:14:21 -0400
X-MC-Unique: Nszda0nUN0SyBHmZEzo_Hg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC5271955D4F;
	Wed, 31 Jul 2024 07:14:20 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.168])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02EBC1955D47;
	Wed, 31 Jul 2024 07:14:16 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	netdev@vger.kernel.org
Subject: [PATCH v3] vdpa: Add support for setting the MAC address and MTU in vDPA tool.
Date: Wed, 31 Jul 2024 15:14:06 +0800
Message-ID: <20240731071406.1054655-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add a new function in vDPA tool to support set MAC address and MTU.
Currently, the kernel only supports setting the MAC address. MTU support
will be added to the kernel later.

Update the man page to include usage for setting the MAC address. Usage
for setting the MTU will be added after the kernel supports MTU setting.

The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**

here is example:
root@L1# vdpa -jp dev config show vdpa0
{
    "config": {
        "vdpa0": {
            "mac": "82:4d:e9:5d:d7:e6",
            "link ": "up",
            "link_announce ": false,
            "mtu": 1500
        }
    }
}

root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55

root@L1# vdpa -jp dev config show vdpa0
{
    "config": {
        "vdpa0": {
            "mac": "00:11:22:33:44:55",
            "link ": "up",
            "link_announce ": false,
            "mtu": 1500
        }
    }
}

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 man/man8/vdpa-dev.8            | 20 ++++++++++++++++++++
 vdpa/include/uapi/linux/vdpa.h |  1 +
 vdpa/vdpa.c                    | 18 ++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/man/man8/vdpa-dev.8 b/man/man8/vdpa-dev.8
index 43e5bf48..718f40b2 100644
--- a/man/man8/vdpa-dev.8
+++ b/man/man8/vdpa-dev.8
@@ -50,6 +50,12 @@ vdpa-dev \- vdpa device configuration
 .B qidx
 .I QUEUE_INDEX
 
+.ti -8
+.B vdpa dev set
+.B name
+.I NAME
+.B mac
+.RI "[ " MACADDR " ]"
 
 .SH "DESCRIPTION"
 .SS vdpa dev show - display vdpa device attributes
@@ -120,6 +126,15 @@ VDPA_DEVICE_NAME
 .BI qidx " QUEUE_INDEX"
 - specifies the virtqueue index to query
 
+.SS vdpa dev set - set the configuration to the vdpa device.
+
+.BI name " NAME"
+-Name of the vdpa device to configure.
+
+.BI mac " MACADDR"
+- specifies the mac address for the vdpa device.
+This is applicable only for the network type of vdpa device.
+
 .SH "EXAMPLES"
 .PP
 vdpa dev show
@@ -171,6 +186,11 @@ vdpa dev vstats show vdpa0 qidx 1
 .RS 4
 Shows vendor specific statistics information for vdpa device vdpa0 and virtqueue index 1
 .RE
+.PP
+vdpa dev set name vdpa0 mac 00:11:22:33:44:55
+.RS 4
+Set a specific MAC address to vdpa device vdpa0
+.RE
 
 .SH SEE ALSO
 .BR vdpa (8),
diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
index 8586bd17..bc23c731 100644
--- a/vdpa/include/uapi/linux/vdpa.h
+++ b/vdpa/include/uapi/linux/vdpa.h
@@ -19,6 +19,7 @@ enum vdpa_command {
 	VDPA_CMD_DEV_GET,		/* can dump */
 	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
 	VDPA_CMD_DEV_VSTATS_GET,
+	VDPA_CMD_DEV_ATTR_SET,
 };
 
 enum vdpa_attr {
diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
index 6e4a9c11..15deab94 100644
--- a/vdpa/vdpa.c
+++ b/vdpa/vdpa.c
@@ -758,6 +758,22 @@ static int cmd_dev_del(struct vdpa *vdpa,  int argc, char **argv)
 	return mnlu_gen_socket_sndrcv(&vdpa->nlg, nlh, NULL, NULL);
 }
 
+static int cmd_dev_set(struct vdpa *vdpa, int argc, char **argv)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&vdpa->nlg, VDPA_CMD_DEV_ATTR_SET,
+					  NLM_F_REQUEST | NLM_F_ACK);
+	err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
+				  VDPA_OPT_VDEV_NAME,
+				  VDPA_OPT_VDEV_MAC | VDPA_OPT_VDEV_MTU);
+	if (err)
+		return err;
+
+	return mnlu_gen_socket_sndrcv(&vdpa->nlg, nlh, NULL, NULL);
+}
+
 static void pr_out_dev_net_config(struct vdpa *vdpa, struct nlattr **tb)
 {
 	SPRINT_BUF(macaddr);
@@ -1027,6 +1043,8 @@ static int cmd_dev(struct vdpa *vdpa, int argc, char **argv)
 		return cmd_dev_config(vdpa, argc - 1, argv + 1);
 	} else if (!strcmp(*argv, "vstats")) {
 		return cmd_dev_vstats(vdpa, argc - 1, argv + 1);
+	} else if (!strcmp(*argv, "set")) {
+		return cmd_dev_set(vdpa, argc - 1, argv + 1);
 	}
 	fprintf(stderr, "Command \"%s\" not found\n", *argv);
 	return -ENOENT;
-- 
2.45.0


