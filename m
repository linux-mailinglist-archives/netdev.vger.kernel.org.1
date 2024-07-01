Return-Path: <netdev+bounces-107997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4682391D752
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788651C20E74
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 05:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBA02BB0D;
	Mon,  1 Jul 2024 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpZ8qU9B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084D2AE97
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 05:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719810788; cv=none; b=ksfZuCDss5SgIlRgJK25NRtntvIW8hJlUZiNDG/YPj/OL80rFNkkhQWp1IPw7tVL+g1EzeRN1BW/GCHPD57npmLb2xcwFWe2P2S4vH3LSLgKLselzqTF7RGjA4V1WX+L71Xv30eozZomu5vJbrZFUpBSZnAe+6jMLYDvFGtWiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719810788; c=relaxed/simple;
	bh=brfhiu6ntj00ML6jGkq8E2RS/ZNTUFaRSFbIt9Otofc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RL7TSDUwmT1pokf75tMzfmRmuoO03/XqtHe0Uk7omN0+EIbj6BMR7XUiqLKN3+5ubICwE2/YMhQsjHd8xrewzacmxCkpMhfDiHbt3jrUxU6P1kdbVkb+BTXhgfcC30RcdeI9BnVkTZAm4G618DqmtkoXXZnrU7MIqKL/oRGFJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NpZ8qU9B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719810785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0AcedEQrhQ0TeNO54X9R+D8X0+JxK/RnWpt3B7rYpso=;
	b=NpZ8qU9B3QYy6quUf5lhaRoTLXzHNOeRqusDvP6fMbCQuele/M/vsDoqltBxarasUA5N8a
	P38OZeEgCgIQ+MUYfBlKqJBSWrdo/bEycrfJyRERz8WmaChGurigLFs1ECyUDbNf2rvMLn
	jEo+zepdSMAZtWPkKcCKw3eYlgY48LU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-WNstEQ8rMjKxg7UqBqHt6w-1; Mon,
 01 Jul 2024 01:13:02 -0400
X-MC-Unique: WNstEQ8rMjKxg7UqBqHt6w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 506AB195608B;
	Mon,  1 Jul 2024 05:13:00 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E690E1956089;
	Mon,  1 Jul 2024 05:12:56 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 2/2] vdpa_sim_net: Add the support of set mac address
Date: Mon,  1 Jul 2024 13:12:03 +0800
Message-ID: <20240701051239.112447-3-lulu@redhat.com>
In-Reply-To: <20240701051239.112447-1-lulu@redhat.com>
References: <20240701051239.112447-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add the function to support setting the MAC address.
For vdpa_sim_net, the driver will write the MAC address
to the config space, and other devices can implement
their own functions to support this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index cfe962911804..e1e545d6490e 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -414,6 +414,21 @@ static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
 	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
 }
 
+static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
+				struct vdpa_device *dev,
+				const struct vdpa_dev_set_config *config)
+{
+	struct vdpasim *vdpasim = container_of(dev, struct vdpasim, vdpa);
+
+	struct virtio_net_config *vio_config = vdpasim->config;
+
+	if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+		memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
 				     const struct vdpa_dev_set_config *config)
 {
@@ -510,7 +525,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_dev *mdev,
 
 static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops = {
 	.dev_add = vdpasim_net_dev_add,
-	.dev_del = vdpasim_net_dev_del
+	.dev_del = vdpasim_net_dev_del,
+	.dev_set_attr = vdpasim_net_set_attr
 };
 
 static struct virtio_device_id id_table[] = {
-- 
2.45.0


