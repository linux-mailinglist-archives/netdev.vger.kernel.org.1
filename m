Return-Path: <netdev+bounces-116815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A956494BC91
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363981F21CBD
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822CD18C327;
	Thu,  8 Aug 2024 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ovBnGy4Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A818A6A1
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118045; cv=none; b=vDsXRMxcgMnPxX8dZ12oLNG4bctV4RYv7Dz5JpnZIk0euq/deXCQH6V5xmT/e83Lma31BplJpbGxWy4/DLg6B84yE6+/W0K4Yz5kqzTXfc+/YrFeRcGZS1cK1cBr0bjBwjxuzLSxFz+ZGnseudYk7O+A1QzIsdxHrAh9bgLmk6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118045; c=relaxed/simple;
	bh=qORwyzZNVy+LEfLQUhKyUT6dDm8Pd+lt5k8zjI+Wak0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shzuVbhZGFOoWTykPOnGDhpuwzIPeuFPfoWBXfYUc3tFPVTwing3TlWVl5gBLBwWrgTg9FYS+DueUOMToj/uQIcA+1UImlNisZOvHA2Mlp2EXhRUezVUCQDZthbfipllHFauoHk2kJNpPXtOnzoRVybqIC1MopD++Dex8wsHtOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ovBnGy4Q; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-368380828d6so471655f8f.1
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 04:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723118041; x=1723722841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWpv6IdB+ZSBfOKheCIDI4o/Rhh1iSvNP7j21IpVm2Y=;
        b=ovBnGy4QfvxjOSGjItaR+QtNT+VMNsDk93owP/b/KxRxIklaImK2lzC62Gsa7PbK6j
         SCugvA4h+3cuqFSRKCP6sSKSyijXm9FfArVQfGWdJaW0BWOm2yUMNhrl/wzJbX2Z7ajB
         zd162fFirG9k/2nFj2fbOcAwPOXiLQZn+7bhJip1vEi5sBRkZ9XX8p6cgebhtjdkDjL1
         AcMB4CHc2+hYfAAI/vnw43NpsvsUnuwxr6+hySR4WkaCaoi5EVMRY4dDYIRREywICYlS
         Ozktk5qvP7Ghxe7s5Zjmig4Y7tzdYP58Vf3JbtDmt4SMBXMkgsNRWIWzX7+o9lEWbXVb
         mLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723118041; x=1723722841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWpv6IdB+ZSBfOKheCIDI4o/Rhh1iSvNP7j21IpVm2Y=;
        b=mLGgnM/TivWbjkt6UH95beb+/pxZfNc4jQWsTMSeHj7T7N3WlqsO0/U6wjKh7qYgts
         Vdk7ISXBUh4lO9svvuwv01kk/IuVSjtU7UlIw8f8mB3RMVGq/XVJTlYXAenEfITAycim
         OISr3Jkot76lj9ne/mmF3IgCkVGd36XUkezspWd/0lY8KeWO0cN2WxFf6iDtTS1vB7Ce
         hsJiRfp7o3Gmp5pcZG6ovFVFeypHKth+nC6qNlic7G6CFecNVxSxg6s0psipnyGXDF+K
         BQULNbY8drS7F06aDMu4AZ0kmDinsEmAw/R0d/1a60HSy1INEPS9PyNICcKwNl6Kufw8
         vl+Q==
X-Gm-Message-State: AOJu0YwNPGSG+Ku7wV7bGJtfo7mhw7g+tuYJ/9UdXj1H6aay0Q56g4jV
	C4kx69EVRaUdjM3sqAlZ87N38qZBTqEQyif7NlxhWd1QEHERB1qBmTbBgrb0SQE=
X-Google-Smtp-Source: AGHT+IFbwV1ZgK3TfeFhHW45tmFI2J0yflhWdJBEw/KQZN0Y2AF+Ufz9gZ31TJyAL/7pee3t219e8g==
X-Received: by 2002:a5d:4f11:0:b0:367:96a0:c4b7 with SMTP id ffacd0b85a97d-36d27582bf5mr1231300f8f.62.1723118035463;
        Thu, 08 Aug 2024 04:53:55 -0700 (PDT)
Received: from localhost ([213.235.133.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2718bfb9sm1676883f8f.54.2024.08.08.04.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:53:54 -0700 (PDT)
Date: Thu, 8 Aug 2024 13:53:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v1 1/2] dpll: add Embedded SYNC feature for a pin
Message-ID: <ZrSx0QRXUXB53UFr@nanopsycho.orion>
References: <20240808112013.166621-1-arkadiusz.kubalewski@intel.com>
 <20240808112013.166621-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808112013.166621-2-arkadiusz.kubalewski@intel.com>

Thu, Aug 08, 2024 at 01:20:12PM CEST, arkadiusz.kubalewski@intel.com wrote:
>Implement and document new pin attributes for providing Embedded SYNC
>capabilities to the DPLL subsystem users through a netlink pin-get
>do/dump messages. Allow the user to set Embedded SYNC frequency with
>pin-set do netlink message.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> Documentation/driver-api/dpll.rst     |  21 +++++
> Documentation/netlink/specs/dpll.yaml |  41 +++++++++
> drivers/dpll/dpll_netlink.c           | 127 ++++++++++++++++++++++++++
> drivers/dpll/dpll_nl.c                |   5 +-
> include/linux/dpll.h                  |  10 ++
> include/uapi/linux/dpll.h             |  23 +++++
> 6 files changed, 225 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
>index ea8d16600e16..d7d091d268a1 100644
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
>+and HW capabilities. The user is provided a range of embedded sync
>+frequencies supported, depending on current base frequency configured for
>+the pin.
>+
>+  ========================================= =================================
>+  ``DPLL_A_PIN_E_SYNC_FREQUENCY``           current embedded SYNC frequency
>+  ``DPLL_A_PIN_E_SYNC_FREQUENCY_SUPPORTED`` nest available embedded SYNC
>+                                            frequency ranges
>+    ``DPLL_A_PIN_FREQUENCY_MIN``            attr minimum value of frequency
>+    ``DPLL_A_PIN_FREQUENCY_MAX``            attr maximum value of frequency
>+  ``DPLL_A_PIN_E_SYNC_PULSE``               pulse type of embedded SYNC
>+  ========================================= =================================
>+
> Configuration commands group
> ============================
> 
>diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
>index 94132d30e0e0..0aabf6f1fc2f 100644
>--- a/Documentation/netlink/specs/dpll.yaml
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -210,6 +210,25 @@ definitions:
>       integer part of a measured phase offset value.
>       Value of (DPLL_A_PHASE_OFFSET % DPLL_PHASE_OFFSET_DIVIDER) is a
>       fractional part of a measured phase offset value.
>+  -
>+    type: enum
>+    name: pin-e-sync-pulse
>+    doc: |
>+      defines possible pulse length ratio between high and low state when
>+      embedded sync signal occurs on base clock signal frequency
>+    entries:
>+      -
>+        name: none
>+        doc: embedded sync not enabled
>+      -
>+        name: 25-75
>+        doc: when embedded sync signal occurs 25% of signal's period is in
>+          high state, 75% of signal's period is in low state
>+      -
>+        name: 75-25

It is very odd to name enums like this.
Why can't this be:

    name: e-sync-pulse-ratio
    type: u32
    doc: Embedded sync signal ratio. Value of 0 to 100. Defines the high
    state percentage.

?


>+        doc: when embedded sync signal occurs 75% of signal's period is in
>+          high state, 25% of signal's period is in low state
>+    render-max: true
> 
> attribute-sets:
>   -
>@@ -345,6 +364,24 @@ attribute-sets:
>           Value is in PPM (parts per million).
>           This may be implemented for example for pin of type
>           PIN_TYPE_SYNCE_ETH_PORT.
>+      -
>+        name: e-sync-frequency
>+        type: u64
>+        doc: |
>+          Embedded Sync frequency. If provided a non-zero value, the pin is

Why non-zero? Why the attr cannot be omitted instead?


>+          configured with an embedded sync signal into its base frequency.
>+      -
>+        name: e-sync-frequency-supported
>+        type: nest
>+        nested-attributes: frequency-range
>+        doc: |
>+          If provided a pin is capable of enabling embedded sync frequency
>+          into it's base frequency signal.
>+      -
>+        name: e-sync-pulse
>+        type: u32
>+        enum: pin-e-sync-pulse
>+        doc: Embedded sync signal ratio.
>   -
>     name: pin-parent-device
>     subset-of: pin
>@@ -510,6 +547,9 @@ operations:
>             - phase-adjust-max
>             - phase-adjust
>             - fractional-frequency-offset
>+            - e-sync-frequency
>+            - e-sync-frequency-supported
>+            - e-sync-pulse
> 
>       dump:
>         request:
>@@ -536,6 +576,7 @@ operations:
>             - parent-device
>             - parent-pin
>             - phase-adjust
>+            - e-sync-frequency
>     -
>       name: pin-create-ntf
>       doc: Notification about pin appearing
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index 98e6ad8528d3..5ae2c0adb98e 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -342,6 +342,50 @@ dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
> 	return 0;
> }
> 
>+static int
>+dpll_msg_add_pin_esync(struct sk_buff *msg, struct dpll_pin *pin,

This is "esync", attributes are "E_SYNC". Why can't they be named
"ESYNC" too? Same comment to another "e_sync" names (vars, ops, etc).


>+		       struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
>+{
>+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>+	struct dpll_device *dpll = ref->dpll;
>+	enum dpll_pin_e_sync_pulse pulse;
>+	struct dpll_pin_frequency range;
>+	struct nlattr *nest;
>+	u64 esync;
>+	int ret;
>+
>+	if (!ops->e_sync_get)
>+		return 0;
>+	ret = ops->e_sync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
>+			      dpll_priv(dpll), &esync, &range, &pulse, extack);
>+	if (ret == -EOPNOTSUPP)
>+		return 0;
>+	else if (ret)
>+		return ret;
>+	if (nla_put_64bit(msg, DPLL_A_PIN_E_SYNC_FREQUENCY, sizeof(esync),
>+			  &esync, DPLL_A_PIN_PAD))
>+		return -EMSGSIZE;
>+	if (nla_put_u32(msg, DPLL_A_PIN_E_SYNC_PULSE, pulse))
>+		return -EMSGSIZE;
>+
>+	nest = nla_nest_start(msg, DPLL_A_PIN_E_SYNC_FREQUENCY_SUPPORTED);
>+	if (!nest)
>+		return -EMSGSIZE;
>+	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN, sizeof(range.min),
>+			  &range.min, DPLL_A_PIN_PAD)) {
>+		nla_nest_cancel(msg, nest);
>+		return -EMSGSIZE;
>+	}
>+	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX, sizeof(range.max),
>+			  &range.max, DPLL_A_PIN_PAD)) {

Don't you want to have the MIN-MAX here multiple times. I mean, in
theory, can the device support 2 fixed frequencies for example?
Have it at least for UAPI so this is easily extendable.



>+		nla_nest_cancel(msg, nest);
>+		return -EMSGSIZE;
>+	}
>+	nla_nest_end(msg, nest);
>+
>+	return 0;
>+}
>+
> static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
> {
> 	int fs;
>@@ -481,6 +525,9 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
> 	if (ret)
> 		return ret;
> 	ret = dpll_msg_add_ffo(msg, pin, ref, extack);
>+	if (ret)
>+		return ret;
>+	ret = dpll_msg_add_pin_esync(msg, pin, ref, extack);
> 	if (ret)
> 		return ret;
> 	if (xa_empty(&pin->parent_refs))
>@@ -738,6 +785,81 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
> 	return ret;
> }
> 
>+static int
>+dpll_pin_e_sync_set(struct dpll_pin *pin, struct nlattr *a,
>+		    struct netlink_ext_ack *extack)
>+{
>+	u64 esync = nla_get_u64(a), old_esync;

"freq"/"old_freq". That aligns with the existing code.


>+	struct dpll_pin_ref *ref, *failed;
>+	enum dpll_pin_e_sync_pulse pulse;
>+	struct dpll_pin_frequency range;
>+	const struct dpll_pin_ops *ops;
>+	struct dpll_device *dpll;
>+	unsigned long i;
>+	int ret;
>+
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		ops = dpll_pin_ops(ref);
>+		if (!ops->e_sync_set ||

No need for line break.


>+		    !ops->e_sync_get) {
>+			NL_SET_ERR_MSG(extack,
>+				       "embedded sync feature is not supported by this device");
>+			return -EOPNOTSUPP;
>+		}
>+	}
>+	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
>+	ops = dpll_pin_ops(ref);
>+	dpll = ref->dpll;
>+	ret = ops->e_sync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
>+			      dpll_priv(dpll), &old_esync, &range, &pulse, extack);

Line over 80cols? Didn't checkpatch warn you?


>+	if (ret) {
>+		NL_SET_ERR_MSG(extack, "unable to get current embedded sync frequency value");
>+		return ret;
>+	}
>+	if (esync == old_esync)
>+		return 0;
>+	if (esync > range.max || esync < range.min) {
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
>+		ret = ops->e_sync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
>+				      esync, extack);
>+		if (ret) {
>+			failed = ref;
>+			NL_SET_ERR_MSG_FMT(extack,
>+					   "embedded sync frequency set failed for dpll_id:%u",
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
>+		if (ops->e_sync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
>+				    old_esync, extack))
>+			NL_SET_ERR_MSG(extack, "set embedded sync frequency rollback failed");
>+	}
>+	return ret;
>+}
>+
> static int
> dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
> 			  enum dpll_pin_state state,
>@@ -1039,6 +1161,11 @@ dpll_pin_set_from_nlattr(struct dpll_pin *pin, struct genl_info *info)
> 			if (ret)
> 				return ret;
> 			break;
>+		case DPLL_A_PIN_E_SYNC_FREQUENCY:
>+			ret = dpll_pin_e_sync_set(pin, a, info->extack);
>+			if (ret)
>+				return ret;
>+			break;
> 		}
> 	}
> 
>diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
>index 1e95f5397cfc..ba79a47f3a17 100644
>--- a/drivers/dpll/dpll_nl.c
>+++ b/drivers/dpll/dpll_nl.c
>@@ -62,7 +62,7 @@ static const struct nla_policy dpll_pin_get_dump_nl_policy[DPLL_A_PIN_ID + 1] =
> };
> 
> /* DPLL_CMD_PIN_SET - do */
>-static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_PHASE_ADJUST + 1] = {
>+static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_E_SYNC_FREQUENCY + 1] = {
> 	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
> 	[DPLL_A_PIN_FREQUENCY] = { .type = NLA_U64, },
> 	[DPLL_A_PIN_DIRECTION] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
>@@ -71,6 +71,7 @@ static const struct nla_policy dpll_pin_set_nl_policy[DPLL_A_PIN_PHASE_ADJUST +
> 	[DPLL_A_PIN_PARENT_DEVICE] = NLA_POLICY_NESTED(dpll_pin_parent_device_nl_policy),
> 	[DPLL_A_PIN_PARENT_PIN] = NLA_POLICY_NESTED(dpll_pin_parent_pin_nl_policy),
> 	[DPLL_A_PIN_PHASE_ADJUST] = { .type = NLA_S32, },
>+	[DPLL_A_PIN_E_SYNC_FREQUENCY] = { .type = NLA_U64, },
> };
> 
> /* Ops table for dpll */
>@@ -138,7 +139,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
> 		.doit		= dpll_nl_pin_set_doit,
> 		.post_doit	= dpll_pin_post_doit,
> 		.policy		= dpll_pin_set_nl_policy,
>-		.maxattr	= DPLL_A_PIN_PHASE_ADJUST,
>+		.maxattr	= DPLL_A_PIN_E_SYNC_FREQUENCY,
> 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> 	},
> };
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index d275736230b3..137ab4bcb60e 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -15,6 +15,7 @@
> 
> struct dpll_device;
> struct dpll_pin;
>+struct dpll_pin_frequency;
> 
> struct dpll_device_ops {
> 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
>@@ -83,6 +84,15 @@ struct dpll_pin_ops {
> 	int (*ffo_get)(const struct dpll_pin *pin, void *pin_priv,
> 		       const struct dpll_device *dpll, void *dpll_priv,
> 		       s64 *ffo, struct netlink_ext_ack *extack);
>+	int (*e_sync_set)(const struct dpll_pin *pin, void *pin_priv,
>+			  const struct dpll_device *dpll, void *dpll_priv,
>+			  u64 e_sync_freq, struct netlink_ext_ack *extack);
>+	int (*e_sync_get)(const struct dpll_pin *pin, void *pin_priv,
>+			  const struct dpll_device *dpll, void *dpll_priv,
>+			  u64 *e_sync_freq,
>+			  struct dpll_pin_frequency *e_sync_range,
>+			  enum dpll_pin_e_sync_pulse *pulse,
>+			  struct netlink_ext_ack *extack);
> };
> 
> struct dpll_pin_frequency {
>diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
>index 0c13d7f1a1bc..2a80a6fb0d1d 100644
>--- a/include/uapi/linux/dpll.h
>+++ b/include/uapi/linux/dpll.h
>@@ -169,6 +169,26 @@ enum dpll_pin_capabilities {
> 
> #define DPLL_PHASE_OFFSET_DIVIDER	1000
> 
>+/**
>+ * enum dpll_pin_e_sync_pulse - defines possible pulse length ratio between
>+ *   high and low state when embedded sync signal occurs on base clock signal
>+ *   frequency
>+ * @DPLL_PIN_E_SYNC_PULSE_NONE: embedded sync not enabled
>+ * @DPLL_PIN_E_SYNC_PULSE_25_75: when embedded sync signal occurs 25% of
>+ *   signal's period is in high state, 75% of signal's period is in low state
>+ * @DPLL_PIN_E_SYNC_PULSE_75_25: when embedded sync signal occurs 75% of
>+ *   signal's period is in high state, 25% of signal's period is in low state
>+ */
>+enum dpll_pin_e_sync_pulse {
>+	DPLL_PIN_E_SYNC_PULSE_NONE,
>+	DPLL_PIN_E_SYNC_PULSE_25_75,
>+	DPLL_PIN_E_SYNC_PULSE_75_25,
>+
>+	/* private: */
>+	__DPLL_PIN_E_SYNC_PULSE_MAX,
>+	DPLL_PIN_E_SYNC_PULSE_MAX = (__DPLL_PIN_E_SYNC_PULSE_MAX - 1)
>+};
>+
> enum dpll_a {
> 	DPLL_A_ID = 1,
> 	DPLL_A_MODULE_NAME,
>@@ -210,6 +230,9 @@ enum dpll_a_pin {
> 	DPLL_A_PIN_PHASE_ADJUST,
> 	DPLL_A_PIN_PHASE_OFFSET,
> 	DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
>+	DPLL_A_PIN_E_SYNC_FREQUENCY,
>+	DPLL_A_PIN_E_SYNC_FREQUENCY_SUPPORTED,
>+	DPLL_A_PIN_E_SYNC_PULSE,
> 
> 	__DPLL_A_PIN_MAX,
> 	DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)
>-- 
>2.38.1
>

