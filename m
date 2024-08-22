Return-Path: <netdev+bounces-120910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5C695B2D0
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCB81C21223
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D23117E00E;
	Thu, 22 Aug 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DNO+yn7H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852E4F881
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322131; cv=none; b=RFYgB1tvtjjpTSscP/XF5oei7mAJ1E2w9ejK70baY2Ce3iAV7fNmIKwj56y2ZWimWcSNE0BhwEXesWombrKy2cXznLgZKUqe32eaYEVUcydDvdAlhVo/ZH28/g6AZEPPyU56JFtYueVF1Z31MpZPmYH0hfT8r+zOOouYzkVqzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322131; c=relaxed/simple;
	bh=6BgcG/qsN2UK0IXNa+QQKqRPkY6VVHrPMNL2ktjEJ70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFWUt1EagGV4vgSxxGB3aFGKYE0meyF26eH84YacjEoVhy6Ogh+riz8Uegf5Fbtb5jSo1NcO3LFxdNpAAzj71VjZSPEYC35wvvUJllR0/JyHT/VlfeUsqet+0bGyoWiGlLrFrZ8TDbuACY83uC7FB7WT+cabZSfiZqWuv6tlrto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DNO+yn7H; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso1057341a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 03:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724322126; x=1724926926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pOBZ7Whc9pH5INV6IqLXuAkz+SPdxv7znSmmHW29ow=;
        b=DNO+yn7HbbTuxqjWLio1X6R8zvxd3pHEcqd26qdyRgZgRJC+4Q185iGHnYqvYPwcnQ
         MmSDtEZQKF1+V+2t/JJw+gud8dJesafsYYT2WBWo7UpWDsvftonBHY8pXDkSKduvh+Px
         thU68mYSUnMsUXT7OtcqyUjIljgV3o82A7TMv/az0Q7idn/4EMXKItA5J+3iEwzH120D
         Bvaa7YprrcH3EmId71JH2GAbN+t/34gmb/f3sA+5JLrMpFDDaOAos/gEhuGzQ0h0CC0S
         f2KDgyda04WsLTlruXMs8FAN+sg5qFpNOiVofGzIaiPGw2s2gcdrwLfytN9FtrWURTh9
         2UvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322126; x=1724926926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pOBZ7Whc9pH5INV6IqLXuAkz+SPdxv7znSmmHW29ow=;
        b=Tce8voSOFzMzgHDzgTDyPO/hDZHkHDTCGbe/v8lWjhmj0nTvitc9XdOGkduWxjwY1/
         It5ss5SLbuqBXt7gQ0KjEArnY5245QSRisoBseWCC+gj0fFyYSm3CfzBN0KGdN1z1TcY
         J7dBXnLzws2iXKadgAIpX8mZg2RizfYw0kqW8uhZjji/twcuYvkI6GKlrz2UzYQZejdv
         midFro4iM2KGsTmYlTVaE7+u5ADqfqvU7v5WNvC02QYZHgTl/0sK5pOtgz+bMxwL/vV6
         f64+2kHZvqyBsFhcb6AoiX1dRyDq28i/jOpWnu+BfT4d88ObOAbAKD+TxCDuC3rjLy9o
         lvbQ==
X-Gm-Message-State: AOJu0YzhCAQ78WQCdMR1CqfABr7wRWfQfJN+EPUiFqBmQWv9fH6aHlAT
	KeWuRzq1c5GthyfTnmeuSD5qB6EfBEke2CS3nhO0U6gFPNBOmhGbrbOqtAhHo3Q=
X-Google-Smtp-Source: AGHT+IEqdkIkuFDE3mb84fFjSU+15UXG/VRiWdlvxJLEvaNuZV0B0OnxVkzES+RQ7+iQihhj+4CRRg==
X-Received: by 2002:a05:6402:5255:b0:5be:fb2e:d334 with SMTP id 4fb4d7f45d1cf-5bf2c04bbcdmr2542310a12.12.1724322126143;
        Thu, 22 Aug 2024 03:22:06 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3c8615sm746406a12.23.2024.08.22.03.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:22:05 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:22:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v2 1/2] dpll: add Embedded SYNC feature for a pin
Message-ID: <ZscRTKu6bFMm0VkQ@nanopsycho.orion>
References: <20240821213218.232900-1-arkadiusz.kubalewski@intel.com>
 <20240821213218.232900-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821213218.232900-2-arkadiusz.kubalewski@intel.com>

Wed, Aug 21, 2024 at 11:32:17PM CEST, arkadiusz.kubalewski@intel.com wrote:
>Implement and document new pin attributes for providing Embedded SYNC
>capabilities to the DPLL subsystem users through a netlink pin-get
>do/dump messages. Allow the user to set Embedded SYNC frequency with
>pin-set do netlink message.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
>v2:
>- remove enum for pulse-ratio, instead use plain u32 value,
>- provide e-sync-frequency attribute and value only if esync was
>  enabled,
>- rename: e_sync/E_SYNC -> esync/ESYNC,
>- refactor .esync_get to allow multiple esync range values,
>- define and use struct dpll_pin_esync for getting esync related info,
>- rename esync -> freq to better align with existiong code,
>- remove unneeded line break,
>- respect 80 chars per line rule,
>- fix typos,
>
> Documentation/driver-api/dpll.rst     |  21 +++++
> Documentation/netlink/specs/dpll.yaml |  24 +++++
> drivers/dpll/dpll_netlink.c           | 130 ++++++++++++++++++++++++++
> drivers/dpll/dpll_nl.c                |   5 +-
> include/linux/dpll.h                  |  15 +++
> include/uapi/linux/dpll.h             |   3 +
> 6 files changed, 196 insertions(+), 2 deletions(-)


Looks fine. 2 nitpicks below:


>
>diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
>index ea8d16600e16..a212b94ad52c 100644
>--- a/Documentation/driver-api/dpll.rst
>+++ b/Documentation/driver-api/dpll.rst
>@@ -214,6 +214,27 @@ offset values are fractional with 3-digit decimal places and shell be
> divided with ``DPLL_PIN_PHASE_OFFSET_DIVIDER`` to get integer part and
> modulo divided to get fractional part.
> 
>+Embedded SYNC
>+=============
>+
>+Device may provide ability to use Embedded SYNC feature. It allows
>+to embed additional SYNC signal into the base frequency of a pin - a one
>+special pulse of base frequency signal every time SYNC signal pulse
>+happens. The user can configure the frequency of Embedded SYNC.
>+The Embedded SYNC capability is always related to a given base frequency
>+and HW capabilities. The user is provided a range of Embedded SYNC
>+frequencies supported, depending on current base frequency configured for
>+the pin.
>+
>+  ========================================= =================================
>+  ``DPLL_A_PIN_ESYNC_FREQUENCY``            current Embedded SYNC frequency
>+  ``DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED``  nest available Embedded SYNC
>+                                            frequency ranges
>+    ``DPLL_A_PIN_FREQUENCY_MIN``            attr minimum value of frequency
>+    ``DPLL_A_PIN_FREQUENCY_MAX``            attr maximum value of frequency
>+  ``DPLL_A_PIN_ESYNC_PULSE``                pulse type of Embedded SYNC
>+  ========================================= =================================
>+
> Configuration commands group
> ============================
> 
>diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
>index 94132d30e0e0..f2894ca35de8 100644
>--- a/Documentation/netlink/specs/dpll.yaml
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -345,6 +345,26 @@ attribute-sets:
>           Value is in PPM (parts per million).
>           This may be implemented for example for pin of type
>           PIN_TYPE_SYNCE_ETH_PORT.
>+      -
>+        name: esync-frequency
>+        type: u64
>+        doc: |
>+          Frequency of Embedded SYNC signal. If provided, the pin is configured
>+          with a SYNC signal embedded into its base clock frequency.
>+      -
>+        name: esync-frequency-supported
>+        type: nest
>+        multi-attr: true
>+        nested-attributes: frequency-range
>+        doc: |
>+          If provided a pin is capable of embedding a SYNC signal (within given
>+          range) into its base frequency signal.
>+      -
>+        name: esync-pulse
>+        type: u32
>+        doc: |
>+          A ratio of high to low state of a SYNC signal pulse embedded
>+          into base clock frequency. Value is in percents.
>   -
>     name: pin-parent-device
>     subset-of: pin
>@@ -510,6 +530,9 @@ operations:
>             - phase-adjust-max
>             - phase-adjust
>             - fractional-frequency-offset
>+            - esync-frequency
>+            - esync-frequency-supported
>+            - esync-pulse
> 
>       dump:
>         request:
>@@ -536,6 +559,7 @@ operations:
>             - parent-device
>             - parent-pin
>             - phase-adjust
>+            - esync-frequency
>     -
>       name: pin-create-ntf
>       doc: Notification about pin appearing
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 98e6ad8528d3..fe1a00ad84d1 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -342,6 +342,51 @@ dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
> 	return 0;
> }
> 
>+static int
>+dpll_msg_add_pin_esync(struct sk_buff *msg, struct dpll_pin *pin,
>+		       struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
>+{
>+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>+	struct dpll_device *dpll = ref->dpll;
>+	struct dpll_pin_esync esync;
>+	struct nlattr *nest;
>+	int ret, i;
>+
>+	if (!ops->esync_get)
>+		return 0;
>+	ret = ops->esync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
>+			     dpll_priv(dpll), &esync, extack);
>+	if (ret == -EOPNOTSUPP)
>+		return 0;
>+	else if (ret)
>+		return ret;
>+	if (nla_put_64bit(msg, DPLL_A_PIN_ESYNC_FREQUENCY, sizeof(esync.freq),
>+			  &esync.freq, DPLL_A_PIN_PAD))
>+		return -EMSGSIZE;
>+	if (nla_put_u32(msg, DPLL_A_PIN_ESYNC_PULSE, esync.pulse))
>+		return -EMSGSIZE;
>+	for (i = 0; i < esync.range_num; i++) {
>+		nest = nla_nest_start(msg,
>+				      DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED);
>+		if (!nest)
>+			return -EMSGSIZE;
>+		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN,
>+				  sizeof(esync.range[i].min),
>+				  &esync.range[i].min, DPLL_A_PIN_PAD))
>+			goto nest_cancel;
>+		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX,
>+				  sizeof(esync.range[i].max),
>+				  &esync.range[i].max, DPLL_A_PIN_PAD))
>+			goto nest_cancel;
>+		nla_nest_end(msg, nest);
>+	}
>+	return 0;
>+
>+nest_cancel:
>+	nla_nest_cancel(msg, nest);
>+	return -EMSGSIZE;
>+}
>+
> static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
> {
> 	int fs;
>@@ -481,6 +526,9 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
> 	if (ret)
> 		return ret;
> 	ret = dpll_msg_add_ffo(msg, pin, ref, extack);
>+	if (ret)
>+		return ret;
>+	ret = dpll_msg_add_pin_esync(msg, pin, ref, extack);
> 	if (ret)
> 		return ret;
> 	if (xa_empty(&pin->parent_refs))
>@@ -738,6 +786,83 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
> 	return ret;
> }
> 
>+static int
>+dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
>+		    struct netlink_ext_ack *extack)
>+{
>+	struct dpll_pin_ref *ref, *failed;
>+	const struct dpll_pin_ops *ops;
>+	struct dpll_pin_esync esync;
>+	u64 freq = nla_get_u64(a);
>+	struct dpll_device *dpll;
>+	bool supported = false;
>+	unsigned long i;
>+	int ret;
>+
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		ops = dpll_pin_ops(ref);
>+		if (!ops->esync_set || !ops->esync_get) {
>+			NL_SET_ERR_MSG(extack,
>+				       "embedded sync feature is not supported by this device");
>+			return -EOPNOTSUPP;
>+		}
>+	}
>+	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
>+	ops = dpll_pin_ops(ref);
>+	dpll = ref->dpll;
>+	ret = ops->esync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
>+			     dpll_priv(dpll), &esync, extack);
>+	if (ret) {
>+		NL_SET_ERR_MSG(extack, "unable to get current embedded sync frequency value");
>+		return ret;
>+	}
>+	if (freq == esync.freq)
>+		return 0;
>+	for (i = 0; i < esync.range_num; i++)
>+		if (freq <= esync.range[i].max && freq >= esync.range[i].min)
>+			supported = true;
>+	if (!supported) {
>+		NL_SET_ERR_MSG_ATTR(extack, a,
>+				    "requested embedded sync frequency value is not supported by this device");
>+		return -EINVAL;
>+	}
>+
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		void *pin_dpll_priv;
>+
>+		ops = dpll_pin_ops(ref);
>+		dpll = ref->dpll;
>+		pin_dpll_priv = dpll_pin_on_dpll_priv(dpll, pin);
>+		ret = ops->esync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
>+				      freq, extack);
>+		if (ret) {
>+			failed = ref;
>+			NL_SET_ERR_MSG_FMT(extack,
>+					   "embedded sync frequency set failed for dpll_id:%u",

Missing space after ":".


>+					   dpll->id);
>+			goto rollback;
>+		}
>+	}
>+	__dpll_pin_change_ntf(pin);
>+
>+	return 0;
>+
>+rollback:
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		void *pin_dpll_priv;
>+
>+		if (ref == failed)
>+			break;
>+		ops = dpll_pin_ops(ref);
>+		dpll = ref->dpll;
>+		pin_dpll_priv = dpll_pin_on_dpll_priv(dpll, pin);
>+		if (ops->esync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
>+				   esync.freq, extack))
>+			NL_SET_ERR_MSG(extack, "set embedded sync frequency rollback failed");
>+	}
>+	return ret;
>+}
>+
> static int
> dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
> 			  enum dpll_pin_state state,
>@@ -1039,6 +1164,11 @@ dpll_pin_set_from_nlattr(struct dpll_pin *pin, struct genl_info *info)
> 			if (ret)
> 				return ret;
> 			break;
>+		case DPLL_A_PIN_ESYNC_FREQUENCY:
>+			ret = dpll_pin_esync_set(pin, a, info->extack);
>+			if (ret)
>+				return ret;
>+			break;
> 		}
> 	}
> 
>diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
>index 1e95f5397cfc..fe9b6893d261 100644
>--- a/drivers/dpll/dpll_nl.c
>+++ b/drivers/dpll/dpll_nl.c
>@@ -62,7 +62,7 @@ static const struct nla_policy dpll_pin_get_dump_nl_policy[DPLL_A_PIN_ID + 1] =
> };
> 
> /* DPLL_CMD_PIN_SET - do */
>-static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_PHASE_ADJUST + 1] = {
>+static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_ESYNC_FREQUENCY + 1] = {
> 	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
> 	[DPLL_A_PIN_FREQUENCY] = { .type = NLA_U64, },
> 	[DPLL_A_PIN_DIRECTION] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
>@@ -71,6 +71,7 @@ static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_PHASE_ADJUST +
> 	[DPLL_A_PIN_PARENT_DEVICE] = NLA_POLICY_NESTED(dpll_pin_parent_device_nl_policy),
> 	[DPLL_A_PIN_PARENT_PIN] = NLA_POLICY_NESTED(dpll_pin_parent_pin_nl_policy),
> 	[DPLL_A_PIN_PHASE_ADJUST] = { .type = NLA_S32, },
>+	[DPLL_A_PIN_ESYNC_FREQUENCY] = { .type = NLA_U64, },
> };
> 
> /* Ops table for dpll */
>@@ -138,7 +139,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
> 		.doit		= dpll_nl_pin_set_doit,
> 		.post_doit	= dpll_pin_post_doit,
> 		.policy		= dpll_pin_set_nl_policy,
>-		.maxattr	= DPLL_A_PIN_PHASE_ADJUST,
>+		.maxattr	= DPLL_A_PIN_ESYNC_FREQUENCY,
> 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> 	},
> };
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index d275736230b3..3baa196d7000 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -15,6 +15,7 @@
> 
> struct dpll_device;
> struct dpll_pin;
>+struct dpll_pin_esync;
> 
> struct dpll_device_ops {
> 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
>@@ -83,6 +84,13 @@ struct dpll_pin_ops {
> 	int (*ffo_get)(const struct dpll_pin *pin, void *pin_priv,
> 		       const struct dpll_device *dpll, void *dpll_priv,
> 		       s64 *ffo, struct netlink_ext_ack *extack);
>+	int (*esync_set)(const struct dpll_pin *pin, void *pin_priv,
>+			  const struct dpll_device *dpll, void *dpll_priv,
>+			  u64 esync_freq, struct netlink_ext_ack *extack);

s/esync_freq/freq/


>+	int (*esync_get)(const struct dpll_pin *pin, void *pin_priv,
>+			  const struct dpll_device *dpll, void *dpll_priv,
>+			  struct dpll_pin_esync *esync,
>+			  struct netlink_ext_ack *extack);
> };
> 
> struct dpll_pin_frequency {
>@@ -111,6 +119,13 @@ struct dpll_pin_phase_adjust_range {
> 	s32 max;
> };
> 
>+struct dpll_pin_esync {
>+	u64 freq;
>+	const struct dpll_pin_frequency *range;
>+	u8 range_num;
>+	u8 pulse;
>+};
>+
> struct dpll_pin_properties {
> 	const char *board_label;
> 	const char *panel_label;
>diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
>index 0c13d7f1a1bc..b0654ade7b7e 100644
>--- a/include/uapi/linux/dpll.h
>+++ b/include/uapi/linux/dpll.h
>@@ -210,6 +210,9 @@ enum dpll_a_pin {
> 	DPLL_A_PIN_PHASE_ADJUST,
> 	DPLL_A_PIN_PHASE_OFFSET,
> 	DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
>+	DPLL_A_PIN_ESYNC_FREQUENCY,
>+	DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED,
>+	DPLL_A_PIN_ESYNC_PULSE,
> 
> 	__DPLL_A_PIN_MAX,
> 	DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)
>-- 
>2.38.1
>

