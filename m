Return-Path: <netdev+bounces-139813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7983F9B4470
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CA51F23EAA
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EE42040AB;
	Tue, 29 Oct 2024 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K34lDHzF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D252040B5
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191331; cv=none; b=DPg85EDLMYuCJSNjcd9Wza8uwcLTx3tuxYu1V3vop4tW5WOP/jPFu/zzhFZg0xk8Qb5+nnxFaRkg4plv1rZ3A3MKGnyjipaOxBziC53Re/KPJTJo+/PqxehBvf9T/7uDBbSXH1o+tBR+EPjHnII4i/ZTmpNOCJjQyViQ5NOna7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191331; c=relaxed/simple;
	bh=/t4l07x03lIbf7FJLOKkYI0MijTHEWNTEtlRIaIxrJY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFPvbS9HoCb2IKhuF3WEBox5v/JtRvcDNj38V0PpeMTx36Pkt2YG3/SGflDQ8EAYbIAPjOHb0dNN0X7jsSxbPO6wfmfjCGXURCKQrxM0YoDnyzguZWK+NbbUK0un/55JwTvIzbkOeZIWD+if0Kkwklf0wIeLhzqdNHohX1r7jpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K34lDHzF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730191326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROLgbTnxd9doekduw+GD4CkJQNhqibX/usOA/Zu9ioQ=;
	b=K34lDHzFV5aHFKEA1ISW+7Fn7Ea+OBYXEAICaWfnecSjBev4AqbU0MA69WWI5ctJr6qFTE
	XE3vRylcYGMGU1j1cn5YblGjXKcjG8VBjqgrGnz2C3t5GbkRxQtkkCmggzcBtTYcOGDT4i
	mWP0/FvBuQBak3CU0gJzH/N4tNYvqpA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-QkaB_ZlxNd-21EI4xNCg9Q-1; Tue,
 29 Oct 2024 04:42:03 -0400
X-MC-Unique: QkaB_ZlxNd-21EI4xNCg9Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02F7D1955D80;
	Tue, 29 Oct 2024 08:42:02 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C53C319560A2;
	Tue, 29 Oct 2024 08:41:57 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	dsahern@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] vdpa: Add support for setting the MAC address in vDPA tool.
Date: Tue, 29 Oct 2024 16:40:07 +0800
Message-ID: <20241029084144.561035-2-lulu@redhat.com>
In-Reply-To: <20241029084144.561035-1-lulu@redhat.com>
References: <20241029084144.561035-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a new function in vDPA tool to support set MAC address.
Currently, the kernel only supports setting the MAC address.

Update the man page to include usage for setting the MAC address.

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
 man/man8/vdpa-dev.8 | 20 ++++++++++++++++++++
 vdpa/vdpa.c         | 18 ++++++++++++++++++
 2 files changed, 38 insertions(+)

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
diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
index 43f87824..e2b0a5b1 100644
--- a/vdpa/vdpa.c
+++ b/vdpa/vdpa.c
@@ -759,6 +759,22 @@ static int cmd_dev_del(struct vdpa *vdpa,  int argc, char **argv)
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
+				  VDPA_OPT_VDEV_MAC);
+	if (err)
+		return err;
+
+	return mnlu_gen_socket_sndrcv(&vdpa->nlg, nlh, NULL, NULL);
+}
+
 static void pr_out_dev_net_config(struct vdpa *vdpa, struct nlattr **tb)
 {
 	SPRINT_BUF(macaddr);
@@ -1028,6 +1044,8 @@ static int cmd_dev(struct vdpa *vdpa, int argc, char **argv)
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


