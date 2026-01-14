Return-Path: <netdev+bounces-249831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C7ED1EBDC
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4146A30142DC
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5E5396D33;
	Wed, 14 Jan 2026 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCmyo/QL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7C397AA3
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393669; cv=none; b=PZtPzkt2nwcOSc7/sxti86/Nr7XQtXg9D4tDzRAy4AeAnFxm8tI4c/9hz32KG/uwfEGvv5A1DsqqoqNw4tzUsuRP2H5yBhs8ZXOLv9bfAjLmKYuz/UbKLwwdwlifGoFdDLlk29edHHF3F11ae9dqjkz/1av0QK+1zq6U6FYCIto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393669; c=relaxed/simple;
	bh=62vow2yG5V5F5ntWZ5qgaAjpifWJRdff8Dw4keSxGXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q37XYi5D/4Z0nbrXS98nHx6bCpRoAbpKDZj8xLB12IVmDRNhqOGckcFoLRfBMN9q6mTD7lltU5kDHbnwGcobSYg7w39jzeYYoWcqw5EeehPpYtEfwZyH1i8dxKbEb58ImjBLzUiub13vM5g+hBLS5BMf1k+6+jquxiqYmeimxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCmyo/QL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768393667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUb2WlGEItlmQZEL1pLjJRhKJG1PlwQMPmoqtM8sfI0=;
	b=JCmyo/QLrfnx9QHqWJVui2pHm2jgfTiC0XpuomQvRAv2qfep44cz7EpT9Lag5EIxuwZpRF
	DZIHrQgOm16ZnrSElD0xxLjdoC7kSJwPDCxpBQXGddc/bqTGxML92v1h27WucWjFZMJ0ZH
	eKX5BhsbdfTFKFNR1fxDPjlw8r6f+Jw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-lzc-edHNPTijpvERy4uoTg-1; Wed,
 14 Jan 2026 07:27:44 -0500
X-MC-Unique: lzc-edHNPTijpvERy4uoTg-1
X-Mimecast-MFC-AGG-ID: lzc-edHNPTijpvERy4uoTg_1768393662
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB5CC1956054;
	Wed, 14 Jan 2026 12:27:41 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABEFD1956048;
	Wed, 14 Jan 2026 12:27:37 +0000 (UTC)
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
Subject: [PATCH net-next v3 2/3] dpll: add dpll_device op to set working mode
Date: Wed, 14 Jan 2026 13:27:25 +0100
Message-ID: <20260114122726.120303-3-ivecera@redhat.com>
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

Currently, userspace can retrieve the DPLL working mode but cannot
configure it. This prevents changing the device operation, such as
switching from manual to automatic mode and vice versa.

Add a new callback .mode_set() to struct dpll_device_ops. Extend
the netlink policy and device-set command handling to process
the DPLL_A_MODE attribute.  Update the netlink YAML specification
to include the mode attribute in the device-set operation.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v3:
* fixed reverse xmas tree order dpll_mode_set()
v2:
* fixed bitmap size in dpll_mode_set()
---
 Documentation/netlink/specs/dpll.yaml |  1 +
 drivers/dpll/dpll_netlink.c           | 44 +++++++++++++++++++++++++++
 drivers/dpll/dpll_nl.c                |  1 +
 include/linux/dpll.h                  |  2 ++
 4 files changed, 48 insertions(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 78d0724d7e12c..b55afa77eac4b 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -550,6 +550,7 @@ operations:
         request:
           attributes:
             - id
+            - mode
             - phase-offset-monitor
             - phase-offset-avg-factor
     -
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index d6a0e272d7038..499bca460b1e1 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -853,6 +853,45 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
 }
 EXPORT_SYMBOL_GPL(dpll_pin_change_ntf);
 
+static int
+dpll_mode_set(struct dpll_device *dpll, struct nlattr *a,
+	      struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	DECLARE_BITMAP(modes, DPLL_MODE_MAX + 1) = { 0 };
+	enum dpll_mode mode = nla_get_u32(a), old_mode;
+	int ret;
+
+	if (!(ops->mode_set && ops->supported_modes_get)) {
+		NL_SET_ERR_MSG_ATTR(extack, a,
+				    "dpll device does not support mode switch");
+		return -EOPNOTSUPP;
+	}
+
+	ret = ops->mode_get(dpll, dpll_priv(dpll), &old_mode, extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get current mode");
+		return ret;
+	}
+
+	if (mode == old_mode)
+		return 0;
+
+	ret = ops->supported_modes_get(dpll, dpll_priv(dpll), modes, extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack, "unable to get supported modes");
+		return ret;
+	}
+
+	if (!test_bit(mode, modes)) {
+		NL_SET_ERR_MSG(extack,
+			       "dpll device does not support requested mode");
+		return -EINVAL;
+	}
+
+	return ops->mode_set(dpll, dpll_priv(dpll), mode, extack);
+}
+
 static int
 dpll_phase_offset_monitor_set(struct dpll_device *dpll, struct nlattr *a,
 			      struct netlink_ext_ack *extack)
@@ -1808,6 +1847,11 @@ dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
 	nla_for_each_attr(a, genlmsg_data(info->genlhdr),
 			  genlmsg_len(info->genlhdr), rem) {
 		switch (nla_type(a)) {
+		case DPLL_A_MODE:
+			ret = dpll_mode_set(dpll, a, info->extack);
+			if (ret)
+				return ret;
+			break;
 		case DPLL_A_PHASE_OFFSET_MONITOR:
 			ret = dpll_phase_offset_monitor_set(dpll, a,
 							    info->extack);
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index 36d11ff195df4..a2b22d4921142 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -45,6 +45,7 @@ static const struct nla_policy dpll_device_get_nl_policy[DPLL_A_ID + 1] = {
 /* DPLL_CMD_DEVICE_SET - do */
 static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_PHASE_OFFSET_AVG_FACTOR + 1] = {
 	[DPLL_A_ID] = { .type = NLA_U32, },
+	[DPLL_A_MODE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
 	[DPLL_A_PHASE_OFFSET_MONITOR] = NLA_POLICY_MAX(NLA_U32, 1),
 	[DPLL_A_PHASE_OFFSET_AVG_FACTOR] = { .type = NLA_U32, },
 };
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 912a2ca3e0ee7..c6d0248fa5273 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -20,6 +20,8 @@ struct dpll_pin_esync;
 struct dpll_device_ops {
 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
 			enum dpll_mode *mode, struct netlink_ext_ack *extack);
+	int (*mode_set)(const struct dpll_device *dpll, void *dpll_priv,
+			enum dpll_mode mode, struct netlink_ext_ack *extack);
 	int (*supported_modes_get)(const struct dpll_device *dpll,
 				   void *dpll_priv, unsigned long *modes,
 				   struct netlink_ext_ack *extack);
-- 
2.52.0


