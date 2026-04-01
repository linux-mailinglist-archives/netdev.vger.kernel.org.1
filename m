Return-Path: <netdev+bounces-273999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP6mKRTjzGmjXQYAu9opvQ
	(envelope-from <netdev+bounces-273999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:19:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE5377733
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42C0E311AFEE
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A9B3CBE7D;
	Wed,  1 Apr 2026 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igMggy2d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A833C1991
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034783; cv=none; b=oIJ86GmKx1/3SKpX/IqnmWelNH9lGphWuCitq2LMyXID0Z4SByC8UROzHpjyteQerxcVCII0dqe1s5/LNsmW6qp1aoYN7YdCA3UkACRlwksvi5YzCrhKP08Efthe9O3PXo3nvWIn6sG5neaR/03n5oj5+20dbw5RQT3IvtQC0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034783; c=relaxed/simple;
	bh=FfmH3dxHcLfYRPYmUEYCmSB3fNGK4nNnH0WPIv/V50c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouMvvmL/TW3CsvLecEEGeJbZeKirCD4mhu+e81oQb3+SzofB3Pxlx1Hcf5H8cNzbLwNnrA6xemMLdORF2ic9+j6gHT0hhlMlLBVGzifsrklaPDzzW+412LGzF27Fgk6K/DtxjZLvY5BujjbTwTPDxaYjZ7MD5CL57uKIkKBcd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igMggy2d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775034781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhekxNKPnvZH9+6ShSlDYmZ7VsVsnq78Ozj5baBPZ8w=;
	b=igMggy2dBp4p5XQ+FY0wDf8ciSj1Nwj2zmMQojqEiAJ1xEvFSM6uBh6/WXiGxh/z6Wxss4
	yO9vc2fkAFmyGIMHsEzdwc86hU6OrkVzXE0k2I8e3z5afEgZWmEG0BxZMsBEzFWmpDRjtW
	laVvw9vDbWBdNAY8t/lSLg/gH0GOkn0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-inGLJeptNme__U-FMVB4JA-1; Wed,
 01 Apr 2026 05:12:57 -0400
X-MC-Unique: inGLJeptNme__U-FMVB4JA-1
X-Mimecast-MFC-AGG-ID: inGLJeptNme__U-FMVB4JA_1775034776
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94FD818005B3;
	Wed,  1 Apr 2026 09:12:55 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.175])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B50C819560AB;
	Wed,  1 Apr 2026 09:12:50 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/3] dpll: add frequency monitoring callback ops
Date: Wed,  1 Apr 2026 11:12:36 +0200
Message-ID: <20260401091237.1071995-3-ivecera@redhat.com>
In-Reply-To: <20260401091237.1071995-1-ivecera@redhat.com>
References: <20260401091237.1071995-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273999-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CAE5377733
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add new callback operations for a dpll device:
- freq_monitor_get(..) - to obtain current state of frequency monitor
  feature from dpll device,
- freq_monitor_set(..) - to allow feature configuration.

Add new callback operation for a dpll pin:
- measured_freq_get(..) - to obtain the measured frequency in mHz.

Obtain the feature state value using the get callback and provide it to
the user if the device driver implements callbacks. The measured_freq_get
pin callback is only invoked when the frequency monitor is enabled.
The freq_monitor_get device callback is required when measured_freq_get
is provided by the driver.

Execute the set callback upon user requests.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes v2 -> v3:
- Made freq_monitor_get required when measured_freq_get is present (Jakub)

Changes v1 -> v2:
- Renamed actual-frequency to measured-frequency (Vadim)
---
 drivers/dpll/dpll_netlink.c | 92 +++++++++++++++++++++++++++++++++++++
 include/linux/dpll.h        | 10 ++++
 2 files changed, 102 insertions(+)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 83cbd64abf5a4..576d0cd074bd4 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -175,6 +175,26 @@ dpll_msg_add_phase_offset_monitor(struct sk_buff *msg, struct dpll_device *dpll,
 	return 0;
 }
 
+static int
+dpll_msg_add_freq_monitor(struct sk_buff *msg, struct dpll_device *dpll,
+			  struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	enum dpll_feature_state state;
+	int ret;
+
+	if (ops->freq_monitor_set && ops->freq_monitor_get) {
+		ret = ops->freq_monitor_get(dpll, dpll_priv(dpll),
+					    &state, extack);
+		if (ret)
+			return ret;
+		if (nla_put_u32(msg, DPLL_A_FREQUENCY_MONITOR, state))
+			return -EMSGSIZE;
+	}
+
+	return 0;
+}
+
 static int
 dpll_msg_add_phase_offset_avg_factor(struct sk_buff *msg,
 				     struct dpll_device *dpll,
@@ -400,6 +420,40 @@ static int dpll_msg_add_ffo(struct sk_buff *msg, struct dpll_pin *pin,
 			    ffo);
 }
 
+static int dpll_msg_add_measured_freq(struct sk_buff *msg, struct dpll_pin *pin,
+				      struct dpll_pin_ref *ref,
+				      struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *dev_ops = dpll_device_ops(ref->dpll);
+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+	struct dpll_device *dpll = ref->dpll;
+	enum dpll_feature_state state;
+	u64 measured_freq;
+	int ret;
+
+	if (!ops->measured_freq_get)
+		return 0;
+	if (WARN_ON(!dev_ops->freq_monitor_get))
+		return -EINVAL;
+	ret = dev_ops->freq_monitor_get(dpll, dpll_priv(dpll),
+					&state, extack);
+	if (ret)
+		return ret;
+	if (state == DPLL_FEATURE_STATE_DISABLE)
+		return 0;
+	ret = ops->measured_freq_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				    dpll, dpll_priv(dpll), &measured_freq,
+				    extack);
+	if (ret)
+		return ret;
+	if (nla_put_64bit(msg, DPLL_A_PIN_MEASURED_FREQUENCY,
+			  sizeof(measured_freq), &measured_freq,
+			  DPLL_A_PIN_PAD))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int
 dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
 		      struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
@@ -670,6 +724,9 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	if (ret)
 		return ret;
 	ret = dpll_msg_add_ffo(msg, pin, ref, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_measured_freq(msg, pin, ref, extack);
 	if (ret)
 		return ret;
 	ret = dpll_msg_add_pin_esync(msg, pin, ref, extack);
@@ -722,6 +779,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
 	if (ret)
 		return ret;
 	ret = dpll_msg_add_phase_offset_avg_factor(msg, dpll, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_freq_monitor(msg, dpll, extack);
 	if (ret)
 		return ret;
 
@@ -948,6 +1008,32 @@ dpll_phase_offset_avg_factor_set(struct dpll_device *dpll, struct nlattr *a,
 						extack);
 }
 
+static int
+dpll_freq_monitor_set(struct dpll_device *dpll, struct nlattr *a,
+		      struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	enum dpll_feature_state state = nla_get_u32(a), old_state;
+	int ret;
+
+	if (!(ops->freq_monitor_set && ops->freq_monitor_get)) {
+		NL_SET_ERR_MSG_ATTR(extack, a,
+				    "dpll device not capable of frequency monitor");
+		return -EOPNOTSUPP;
+	}
+	ret = ops->freq_monitor_get(dpll, dpll_priv(dpll), &old_state,
+				    extack);
+	if (ret) {
+		NL_SET_ERR_MSG(extack,
+			       "unable to get current state of frequency monitor");
+		return ret;
+	}
+	if (state == old_state)
+		return 0;
+
+	return ops->freq_monitor_set(dpll, dpll_priv(dpll), state, extack);
+}
+
 static int
 dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		  struct netlink_ext_ack *extack)
@@ -1878,6 +1964,12 @@ dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
 			if (ret)
 				return ret;
 			break;
+		case DPLL_A_FREQUENCY_MONITOR:
+			ret = dpll_freq_monitor_set(dpll, a,
+						    info->extack);
+			if (ret)
+				return ret;
+			break;
 		}
 	}
 
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 2ce295b46b8cd..b7277a8b484d2 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -52,6 +52,12 @@ struct dpll_device_ops {
 	int (*phase_offset_avg_factor_get)(const struct dpll_device *dpll,
 					   void *dpll_priv, u32 *factor,
 					   struct netlink_ext_ack *extack);
+	int (*freq_monitor_set)(const struct dpll_device *dpll, void *dpll_priv,
+				enum dpll_feature_state state,
+				struct netlink_ext_ack *extack);
+	int (*freq_monitor_get)(const struct dpll_device *dpll, void *dpll_priv,
+				enum dpll_feature_state *state,
+				struct netlink_ext_ack *extack);
 };
 
 struct dpll_pin_ops {
@@ -110,6 +116,10 @@ struct dpll_pin_ops {
 	int (*ffo_get)(const struct dpll_pin *pin, void *pin_priv,
 		       const struct dpll_device *dpll, void *dpll_priv,
 		       s64 *ffo, struct netlink_ext_ack *extack);
+	int (*measured_freq_get)(const struct dpll_pin *pin, void *pin_priv,
+				 const struct dpll_device *dpll,
+				 void *dpll_priv, u64 *measured_freq,
+				 struct netlink_ext_ack *extack);
 	int (*esync_set)(const struct dpll_pin *pin, void *pin_priv,
 			 const struct dpll_device *dpll, void *dpll_priv,
 			 u64 freq, struct netlink_ext_ack *extack);
-- 
2.52.0


