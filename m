Return-Path: <netdev+bounces-273128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CnWI0FYymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:02:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C7B359DBF
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAFBB308D100
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ABC3C13FC;
	Mon, 30 Mar 2026 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3pXEHgz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6903B7756
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868131; cv=none; b=Sd9Be5wsDLui7W/0DQuMTtSgJTSNAMhGV84TOxr7dgQ+H/zi7VxBXBIK+bN4KnKmd14Y2vziDUEi1lmyPYJlYnnV5X2DA9czegpyEzYgkdpkNhJ6M4zrMk3H8bpCC6uPWYTJ5D4rIA3WhQiL0EVmnfBZ0Cgty0Bql3QrRg/0dHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868131; c=relaxed/simple;
	bh=h3gQws7Rb7Lndz46+PD5BCjuM2Wg6YMIGI1KcuinoaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiXAOonOzqKwqhkVzo4gDe2c1h1titQEykME/V4NzbsxSdzGYwCu/VOcpXx5K7OdJa8OwZkyjAX1jgxovmd+sZtkSsOxU/NQoIB2joo/axiOqbMS+umykSPlXD8pqxadbkarFAtUyxpN9YvvP6t+nzeV98azB8SnTaD0G0J7Q3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3pXEHgz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774868128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2LOGUAsYfmjUTZI9m+g2vVqeWUch1Frg3pW8bK5vfM=;
	b=D3pXEHgzDwst0qXj2Z6AlIOGxPgudlnaidHHgwyLnlRq34jCqCP/i06dE51XdwnPJ8uMLN
	X1UEq0rLlEGQUjq6ya4VBW4Wo53W0HQ5piwWA1Q8FsBy33UxSLTxWuRxLAPJynGS+k1PPS
	zZ5GBizRIkPrKU5FpO6B/1rDCsOuWB0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-3vFFx5CfMd2RhAaqBigSEA-1; Mon,
 30 Mar 2026 06:55:25 -0400
X-MC-Unique: 3vFFx5CfMd2RhAaqBigSEA-1
X-Mimecast-MFC-AGG-ID: 3vFFx5CfMd2RhAaqBigSEA_1774868123
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 150911956089;
	Mon, 30 Mar 2026 10:55:23 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3688430001A1;
	Mon, 30 Mar 2026 10:55:17 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Petr Oros <poros@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] dpll: add frequency monitoring callback ops
Date: Mon, 30 Mar 2026 12:55:04 +0200
Message-ID: <20260330105505.715099-3-ivecera@redhat.com>
In-Reply-To: <20260330105505.715099-1-ivecera@redhat.com>
References: <20260330105505.715099-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,intel.com,resnulli.us,lwn.net,linuxfoundation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,microchip.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273128-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08C7B359DBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add new callback operations for a dpll device:
- freq_monitor_get(..) - to obtain current state of frequency monitor
  feature from dpll device,
- freq_monitor_set(..) - to allow feature configuration.

Add new callback operation for a dpll pin:
- measured_freq_get(..) - to obtain the measured frequency in Hz.

Obtain the feature state value using the get callback and provide it to
the user if the device driver implements callbacks. The measured_freq_get
pin callback is only invoked when the frequency monitor is enabled.

Execute the set callback upon user requests.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_netlink.c | 90 +++++++++++++++++++++++++++++++++++++
 include/linux/dpll.h        | 10 +++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 83cbd64abf5a4..abddcd4de28b6 100644
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
@@ -400,6 +420,38 @@ static int dpll_msg_add_ffo(struct sk_buff *msg, struct dpll_pin *pin,
 			    ffo);
 }
 
+static int dpll_msg_add_measured_freq(struct sk_buff *msg, struct dpll_pin *pin,
+				      struct dpll_pin_ref *ref,
+				    struct netlink_ext_ack *extack)
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
+	if (dev_ops->freq_monitor_get) {
+		ret = dev_ops->freq_monitor_get(dpll, dpll_priv(dpll),
+						&state, extack);
+		if (ret)
+			return ret;
+		if (state == DPLL_FEATURE_STATE_DISABLE)
+			return 0;
+	}
+	ret = ops->measured_freq_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				   dpll, dpll_priv(dpll), &measured_freq, extack);
+	if (ret)
+		return ret;
+	if (nla_put_64bit(msg, DPLL_A_PIN_MEASURED_FREQUENCY,
+			  sizeof(measured_freq), &measured_freq, DPLL_A_PIN_PAD))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int
 dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
 		      struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
@@ -670,6 +722,9 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	if (ret)
 		return ret;
 	ret = dpll_msg_add_ffo(msg, pin, ref, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_measured_freq(msg, pin, ref, extack);
 	if (ret)
 		return ret;
 	ret = dpll_msg_add_pin_esync(msg, pin, ref, extack);
@@ -722,6 +777,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
 	if (ret)
 		return ret;
 	ret = dpll_msg_add_phase_offset_avg_factor(msg, dpll, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_freq_monitor(msg, dpll, extack);
 	if (ret)
 		return ret;
 
@@ -948,6 +1006,32 @@ dpll_phase_offset_avg_factor_set(struct dpll_device *dpll, struct nlattr *a,
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
@@ -1878,6 +1962,12 @@ dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
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


