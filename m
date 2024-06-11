Return-Path: <netdev+bounces-102456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7BF90315D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8F7B285CC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 05:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85907171644;
	Tue, 11 Jun 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2/udEqR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEBD170857
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718084219; cv=none; b=quMFHJ2y5aQxDOp9WP7p9yTKpj6r1n47ncAQfie70BkVOZx7fHRPQ0I4L2ki5WJZ5KeQITQC8fEEE+KE1FNnnce2iki9WDH7W9uH+B8hCGzRmaVsg0AhJl8tXA/RNN1S7XDzdf9rqyrC86HgEDeQWzzHOCzF4PyJW8viaNYYsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718084219; c=relaxed/simple;
	bh=sdgl58idDHaSqPpaHTfV+LyvPm1mW8emJBfw+l8n+7o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aSgfbCSFRWzxgCwgGstTdjPypevGTE9NVTDJ257xscs5gtYcOdm8t3mxwU6KDF/ihvioxDRg9r9t+wF7Gyx5tXruo7QQD35ZA4oadjuNP2W35Z6k7fhM/4m/cHvSREPzgj3hqBMyIZVIWkk0lw7U1JbWvpdQ8b/sa3ftd/Xz3WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2/udEqR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718084216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ncNr8lyqGp4nZC00h993EcudAe0NoYbySBzTBuT3Ryo=;
	b=d2/udEqRhn0sOpqUPIzpOLphyOibE8JlIpny3iBWi8IhftpZ+AfNL360wlbRurETO86AYt
	dIjcywvl83Ma9rkERtN+xFLjUXt0EEekzUes2/KFTCdW3bjFmOgpnq7UGmICh9FEZVU8dE
	PVCVGaf5xJ83W9ZdrPwatiF/GVQCvtE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-BsADoHowP3Wrp5QVdpLzQg-1; Tue,
 11 Jun 2024 01:36:53 -0400
X-MC-Unique: BsADoHowP3Wrp5QVdpLzQg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54F4A195609D;
	Tue, 11 Jun 2024 05:36:52 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.77])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3C131955E80;
	Tue, 11 Jun 2024 05:36:47 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	netdev@vger.kernel.org
Subject: [PATCH] vdpa: add the support to set mac address and MTU
Date: Tue, 11 Jun 2024 13:36:10 +0800
Message-ID: <20240611053643.517135-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
 vdpa/include/uapi/linux/vdpa.h |  1 +
 vdpa/vdpa.c                    | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
index 8586bd17..7bd8d8aa 100644
--- a/vdpa/include/uapi/linux/vdpa.h
+++ b/vdpa/include/uapi/linux/vdpa.h
@@ -19,6 +19,7 @@ enum vdpa_command {
 	VDPA_CMD_DEV_GET,		/* can dump */
 	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
 	VDPA_CMD_DEV_VSTATS_GET,
+	VDPA_CMD_DEV_CONFIG_SET,
 };
 
 enum vdpa_attr {
diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
index 6e4a9c11..72328a13 100644
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
+	nlh = mnlu_gen_socket_cmd_prepare(&vdpa->nlg, VDPA_CMD_DEV_CONFIG_SET,
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


