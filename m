Return-Path: <netdev+bounces-110081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C77192AEAC
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 05:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67E81F228BE
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 03:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1F842AA6;
	Tue,  9 Jul 2024 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRdkrdiU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA657CA7
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495422; cv=none; b=ItNek4aYbRGcCTbj9POZgs3iacCZ6WozsaB5Cge+8gSbEt3edgxneiM3c1N8VTZgk1SxFajL0BH7ebEltGX/nztkkNCOsDC81Aprj6ZSw6IWNn9XdCBttufEeWOYvEjjBKP4lcpp2lNrHnP/e4ZDhA6VXv0S86Sjwm0utL8BzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495422; c=relaxed/simple;
	bh=6fXOBQr7fGcGCysnLPrvm1cxCeplWJS4pv5hbMGtl4k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=abflBgKVbLxc5klXaXQGzZtMLyTBgSXB8rjUxNJUl1CjUGbiydNkJBeo2oYDnYrL3txg6ypH6/WwV4a1IhiTHmps/jvtzLLxtBAzC/cpsqPMmXYt1E04WwsO6Q4nEMQ6NmQpblnCQtV4h9YFWMtfQTNMOLxzKoP74HtAVMw66QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRdkrdiU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720495419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OVqkwNpzonq2Git7WgBWfR06hJYlThiRe77ygjOmU3A=;
	b=KRdkrdiUBNjiZdXxsGaGoKAeTYfI9SZ7/Mpjm6ejrhWmsxv2ye3HqG0ST8bCteyIuwOxno
	q65gOrRUf6kLBMbrTdnh0Hqs7oTrn7jicZI+R3bj9uvmmOuVv9/TNTdBf761jgeuemMNs5
	kO5PViXXGhTWepOKYY3lMSrbxOwYlfQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-MEvjMg00PP27t5o_PYlNgw-1; Mon,
 08 Jul 2024 23:23:36 -0400
X-MC-Unique: MEvjMg00PP27t5o_PYlNgw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CD121892312;
	Tue,  9 Jul 2024 03:23:35 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.123])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 96BB01955DC4;
	Tue,  9 Jul 2024 03:23:31 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	netdev@vger.kernel.org
Subject: [PATH v2] vdpa: add the support to set mac address and MTU
Date: Tue,  9 Jul 2024 11:23:26 +0800
Message-ID: <20240709032326.581242-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add new function to support the MAC address and MTU from VDPA tool.
The kernel now only supports setting the MAC address.

The usage is vdpa dev set name vdpa_name mac **:**:**:**:**

here is sample:
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
 vdpa/vdpa.c                    | 19 +++++++++++++++++++
 3 files changed, 40 insertions(+)

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
index 6e4a9c11..4b444b6a 100644
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
+				  VDPA_OPT_VDEV_MAC|VDPA_OPT_VDEV_MTU);
+	if (err)
+		return err;
+
+	return mnlu_gen_socket_sndrcv(&vdpa->nlg, nlh, NULL, NULL);
+}
+
 static void pr_out_dev_net_config(struct vdpa *vdpa, struct nlattr **tb)
 {
 	SPRINT_BUF(macaddr);
@@ -1028,6 +1044,9 @@ static int cmd_dev(struct vdpa *vdpa, int argc, char **argv)
 	} else if (!strcmp(*argv, "vstats")) {
 		return cmd_dev_vstats(vdpa, argc - 1, argv + 1);
 	}
+	else if (!strcmp(*argv, "set")) {
+		return cmd_dev_set(vdpa, argc - 1, argv + 1);
+	}
 	fprintf(stderr, "Command \"%s\" not found\n", *argv);
 	return -ENOENT;
 }
-- 
2.45.0


