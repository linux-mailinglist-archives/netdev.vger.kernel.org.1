Return-Path: <netdev+bounces-249830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C966D1EBCD
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE5E1300B8BE
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D36397AD2;
	Wed, 14 Jan 2026 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKALJJ6O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231D397AAF
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393664; cv=none; b=OxT5HGDL8v9jMqE6Vfl7JJbWhJ9WGZ4f4Z8+HircfJpU/luhzuJzSLaXGsyASAUseWhgYAyaQJXJuWr3lS1OJqvM+7asIRgJbHhAWK7ZwMAyGzhs1iXy3tJ+dMjEglMxQj/GgukXYVOGRPXiau/ORajQoLffVoywoNdBB8jiaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393664; c=relaxed/simple;
	bh=bVuF1P85qk2nIVFQAduEGeybJ3EoyK4Df4J67c8h6Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1BaGSzA4WGUh3OhBHHtwJJEGJgmxN6tOR3tqbx5SMp0FvchWLFt/U5K6fnReFzHy0rWqz1AYkmx6+VvyO+wVzou0EH8rH2yrIBtDovvOl6fwgikRSwmCKck4SNGllAp7xXo2E1gYwQ6n27H7A15JX4nxWPyXDYBIRuBlA8FkNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKALJJ6O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768393662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4QFbR+Fv3opz6CX9XGah80QyrpW4c2Rsa1dj3PoBEs=;
	b=bKALJJ6OVXScDFQRKZWqeIacq75jJXQ3W8RsdLlyjJJ2Yoqjw3FWixf4nhKvF1h8pTIn3K
	bQqQDMZ+7tfFhdjMxFGFzovDAN7GgrNx8jpW8p/VuHTsBRlZ9M4P7EcUcwGq3zVHNqvrgz
	aBjyCC654iGbvJQxjQtZpg3wAYm1AJM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-AfgWGdrgOd2byTkbKYESow-1; Wed,
 14 Jan 2026 07:27:39 -0500
X-MC-Unique: AfgWGdrgOd2byTkbKYESow-1
X-Mimecast-MFC-AGG-ID: AfgWGdrgOd2byTkbKYESow_1768393657
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 435BC19541A7;
	Wed, 14 Jan 2026 12:27:37 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03F8E1955F43;
	Wed, 14 Jan 2026 12:27:32 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH net-next v3 1/3] dpll: add dpll_device op to get supported modes
Date: Wed, 14 Jan 2026 13:27:24 +0100
Message-ID: <20260114122726.120303-2-ivecera@redhat.com>
In-Reply-To: <20260114122726.120303-1-ivecera@redhat.com>
References: <20260114122726.120303-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently, the DPLL subsystem assumes that the only supported mode is
the one currently active on the device. When dpll_msg_add_mode_supported()
is called, it relies on ops->mode_get() and reports that single mode
to userspace. This prevents users from discovering other modes the device
might be capable of.

Add a new callback .supported_modes_get() to struct dpll_device_ops. This
allows drivers to populate a bitmap indicating all modes supported by
the hardware.

Update dpll_msg_add_mode_supported() to utilize this new callback:

* if ops->supported_modes_get is defined, use it to retrieve the full
  bitmap of supported modes.
* if not defined, fall back to the existing behavior: retrieve
  the current mode via ops->mode_get and set the corresponding bit
  in the bitmap.

Finally, iterate over the bitmap and add a DPLL_A_MODE_SUPPORTED netlink
attribute for every set bit, accurately reporting the device's capabilities
to userspace.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_netlink.c | 27 +++++++++++++++++++--------
 include/linux/dpll.h        |  3 +++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 64944f601ee5a..d6a0e272d7038 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -128,18 +128,29 @@ dpll_msg_add_mode_supported(struct sk_buff *msg, struct dpll_device *dpll,
 			    struct netlink_ext_ack *extack)
 {
 	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	DECLARE_BITMAP(modes, DPLL_MODE_MAX + 1) = { 0 };
 	enum dpll_mode mode;
 	int ret;
 
-	/* No mode change is supported now, so the only supported mode is the
-	 * one obtained by mode_get().
-	 */
+	if (ops->supported_modes_get) {
+		ret = ops->supported_modes_get(dpll, dpll_priv(dpll), modes,
+					       extack);
+		if (ret)
+			return ret;
+	} else {
+		/* If the supported modes are not reported by the driver, the
+		 * only supported mode is the one obtained by mode_get().
+		 */
+		ret = ops->mode_get(dpll, dpll_priv(dpll), &mode, extack);
+		if (ret)
+			return ret;
 
-	ret = ops->mode_get(dpll, dpll_priv(dpll), &mode, extack);
-	if (ret)
-		return ret;
-	if (nla_put_u32(msg, DPLL_A_MODE_SUPPORTED, mode))
-		return -EMSGSIZE;
+		__set_bit(mode, modes);
+	}
+
+	for_each_set_bit(mode, modes, DPLL_MODE_MAX + 1)
+		if (nla_put_u32(msg, DPLL_A_MODE_SUPPORTED, mode))
+			return -EMSGSIZE;
 
 	return 0;
 }
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 562f520b23c27..912a2ca3e0ee7 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -20,6 +20,9 @@ struct dpll_pin_esync;
 struct dpll_device_ops {
 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
 			enum dpll_mode *mode, struct netlink_ext_ack *extack);
+	int (*supported_modes_get)(const struct dpll_device *dpll,
+				   void *dpll_priv, unsigned long *modes,
+				   struct netlink_ext_ack *extack);
 	int (*lock_status_get)(const struct dpll_device *dpll, void *dpll_priv,
 			       enum dpll_lock_status *status,
 			       enum dpll_lock_status_error *status_error,
-- 
2.52.0


