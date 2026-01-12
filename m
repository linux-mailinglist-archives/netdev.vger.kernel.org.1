Return-Path: <netdev+bounces-248950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 610ACD11C26
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0361530454BE
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF3129B78D;
	Mon, 12 Jan 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvVLyLnD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499229D294
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212869; cv=none; b=XkQXGXxAvLSF8O4UN1DRCgpW+x23mmDtA/3Zw9ktBZU1n4NBgVjdo9YWxvPcYq4I/OltlWs8IMl0zhlZpIKgZbhP76HdZzycI5GYLYokdQC7k18ENqjHMqT/wB5auY0Lox538YOaV5bUPB1VQDHHmSFUXgS8FIeGrDyE3N9l8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212869; c=relaxed/simple;
	bh=sU5K5hcXTa4o6eQuCTfla84bPf+52jnqSx3MVZTwGMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GB5DD1BMbzkjZNggBUZoRhCIfHVkexr8kE8PhOiwS5orR4Dz+ptj5n52qwQaW5mSTzoiQDkWE5E6EALZJXsaPkvFKUQebaL2j7BIN/X6pWyHgVtplmZkVRLzeBEvK5G/2trEpTLhS5EP+C7hZkl+dcNZYP3fPIJ7YseasELsWjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvVLyLnD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768212866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFurCOq7m06qYdTncSUSeHZ26rBTB4/HSXWqKkQxEiM=;
	b=LvVLyLnDUYmHfFqLETd888sd9GMgtl/ZaiadlPl00idTVA+CrCeCn9LbakgRh2iNjaqaca
	vkuGcLGcblm/pAsYKCBCzc4iacaMCcogOxhVwGrzmHV4xTciLGXEygKAaL774/MuYibtC6
	z8Zlk58ENT9hIs1ptJrpIcxgOmjkQ/Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-7wUBYKvvNyScNtYTSq3CoQ-1; Mon,
 12 Jan 2026 05:14:23 -0500
X-MC-Unique: 7wUBYKvvNyScNtYTSq3CoQ-1
X-Mimecast-MFC-AGG-ID: 7wUBYKvvNyScNtYTSq3CoQ_1768212861
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC0BE1800359;
	Mon, 12 Jan 2026 10:14:20 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.44.32.158])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B81A18004D8;
	Mon, 12 Jan 2026 10:14:16 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH net-next 1/3] dpll: add dpll_device op to get supported modes
Date: Mon, 12 Jan 2026 11:14:07 +0100
Message-ID: <20260112101409.804206-2-ivecera@redhat.com>
In-Reply-To: <20260112101409.804206-1-ivecera@redhat.com>
References: <20260112101409.804206-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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


