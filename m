Return-Path: <netdev+bounces-189003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47543AAFD13
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614CE1C2401A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6F26FA54;
	Thu,  8 May 2025 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NkvirwbK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C622C33A
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714663; cv=none; b=VZCh5pxxG9JFQiJv2p0VZhnTtbLTP3Cmxgfq40uQ+/TXHbrxFBMZW0vk/PYr6Uown3L5GX+Yymf3R0dWe4gBlNSnfODSO7MxDJqW7mmOEhV8OP7d7gUGS/DT0Zxa3naa8ikQ5UbdrylpoeGIrk8CEuZJGH6cNK2yJUEIyzBPxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714663; c=relaxed/simple;
	bh=LLPv4mgSjIMxvNQIS9GtSCYxXegxbxnYOkExtmGrzxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CorjUG0BvDK9AFOTuyYYDvxhxK7NxH8IxpzSQGTUrAXihUof6SBub+DCQ4gwu7DoBtn35lD3B3qlLpFZh1kEcVTbcPW7oL8IzJF406JRug2iiuM4XUwtcw2ggK6z+v0vSN79VhC2uSJczqkPCRSTH3QT5lGSjbh2SIREkB4dD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NkvirwbK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so202390266b.0
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746714659; x=1747319459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=po7XCNAM5aoU4SCt2utVP9VuGZuTXpzkGFcrpMe0GG8=;
        b=NkvirwbKqbb4Zrw7dvLhi9/HbYxBksTv8/aWMyTxxEbzwRVVy86UwyeUWnstbXxzX8
         fnc8tONGp1zNnnLTUejmcVaec3ZrdB+lYpirKjIDWwbvDjY56HlcH5DRvTlrRb1F2M4x
         CdA0aw/gUZy2rsX6CPVap+amD1dJ5wNEjlLwTq5mQD8FyxMdyDAKeNRRdrJKZeRsxAjb
         qht8VnavBqGGDTRQrYJHoF+oe3IvGKF7eL31pcnzqb234Z+2sTHieB010IEYd7a9cXvC
         aEWhSfoMjCEiDpkLc/MWAQnc59Em3FUkogUc2fWDOXK+QpwhpIQCFvBzlqXJ39SbkM8c
         mdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746714659; x=1747319459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=po7XCNAM5aoU4SCt2utVP9VuGZuTXpzkGFcrpMe0GG8=;
        b=cV+6xbqeUX24aCBaYA0X8/fpF0cnudP7Lx7VEmyrnzGeGjn8/fz3PzD/YTda4ZggEh
         kI7x90nUidrl0PkqZKsRH6rNP+ck1bX8E4pGUxf/JnmeBVphYGWus7AjEUQwuqOSl+U5
         izMwGZjIBreZVWEFhImkyA5VhO+AmZzShyM8YsRpu9P63ikQpkZ+pwIWQ/pJom/ZL96D
         pduAZzgRWjPrh1BPVGH4StfoQbOlqpWYF36zhTgCZKDErTi6bqg6QbIF7RqNHvuZNpLV
         yi1mpraQZ4VG9Uz/zHBYWHfNug5M7AC6ne9GT7+uXSJ2VcTp8TO/PROjVH+uyRvtxEmd
         H0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWeNgk3LYkBzjwyxvFS1CGEeVoQWm+aYSGMdb6JY9zUS5tw6Q12eu2NmHOq6juEWojvMTjnVh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg1mNBHEXdlVCyJwGNotHun+gGyRXAskcv7ybBc/iXK3xQUyK5
	kuxc2uAOjy0Xr0w/5LQjsxmXg/YMQwAziCmZd3etPUjFiTeJh4xgzKtvzvkV4oAYn59/yImt+k6
	B
X-Gm-Gg: ASbGnctiH+6IYAbcYeCeREh4mDGjcHfwyefZKzByFxTX39uBb9xN6WS1pP8WpQi6FTk
	UR05JGxJHBOGPEQgJLMSkBgnT1KAHRaOiT9PcSA9D+3T5c7goW0ZLJT2jXxLd5yBGBug8uk/nk/
	4h5drO156fSTRI21srxA3xVlmW7tdhloCTtzfbXuy3ffsKQp22E+gmyYXwJR+O7dhNeeONyaXHC
	IXUOeAN5yV7LzBoysE9ZeHY6rPAq9U6qEJjlEuMS2LrqIo3vqIV+mNRklQgCauRV2LKyDxvPCHy
	/UUydyP+e3gPHFn5eerNu4GiqPU5iPX8heVz1K1SPkMMJyjFttZZ85dp6lCbLp1NiO7jkea1wYA
	iuOZjaUw=
X-Google-Smtp-Source: AGHT+IGIWEndgQkKTbjUKnyDkK0FcwKyffVWOR8u0As5y5IiwHlT/APkVxi1Y3XycuR8HVQF48M1qw==
X-Received: by 2002:a17:907:948c:b0:ad2:1371:6fde with SMTP id a640c23a62f3a-ad213717202mr54406166b.44.1746714659038;
        Thu, 08 May 2025 07:30:59 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891ee1f2sm1085548466b.75.2025.05.08.07.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 07:30:58 -0700 (PDT)
Date: Thu, 8 May 2025 16:30:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, 
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, jonathan.lemon@gmail.com, 
	richardcochran@gmail.com, aleksandr.loktionov@intel.com, milena.olech@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] dpll: add phase_offset_monitor_get/set
 callback ops
Message-ID: <rwterkiyhdjcedboj773zc5s3d6purz6yaccfowco7m5zd7q3c@or4r33ay2dxh>
References: <20250508122128.1216231-1-arkadiusz.kubalewski@intel.com>
 <20250508122128.1216231-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508122128.1216231-3-arkadiusz.kubalewski@intel.com>

Thu, May 08, 2025 at 02:21:27PM +0200, arkadiusz.kubalewski@intel.com wrote:
>Add new callback operations for a dpll device:
>- phase_offset_monitor_get(..) - to obtain current state of phase offset
>  monitor feature from dpll device,
>- phase_offset_monitor_set(..) - to allow feature configuration.
>
>Obtain the feature state value using the get callback and provide it to
>the user if the device driver implements callbacks.
>
>Execute the set callback upon user requests.
>
>Reviewed-by: Milena Olech <milena.olech@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
>v3:
>- remove feature flags and capabilities,
>- add separated (per feature) callback ops,
>- use callback ops to determine feature availability.
>---
> drivers/dpll/dpll_netlink.c | 76 ++++++++++++++++++++++++++++++++++++-
> include/linux/dpll.h        |  8 ++++
> 2 files changed, 82 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index c130f87147fa..6d2980455a46 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -126,6 +126,26 @@ dpll_msg_add_mode_supported(struct sk_buff *msg, struct dpll_device *dpll,
> 	return 0;
> }
> 
>+static int
>+dpll_msg_add_phase_offset_monitor(struct sk_buff *msg, struct dpll_device *dpll,
>+				  struct netlink_ext_ack *extack)
>+{
>+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
>+	enum dpll_feature_state state;
>+	int ret;
>+
>+	if (ops->phase_offset_monitor_set && ops->phase_offset_monitor_get) {
>+		ret = ops->phase_offset_monitor_get(dpll, dpll_priv(dpll),
>+						    &state, extack);
>+		if (ret)
>+			return -EINVAL;

Why you don't propagate "ret"?


>+		if (nla_put_u32(msg, DPLL_A_PHASE_OFFSET_MONITOR, state))
>+			return -EMSGSIZE;
>+	}
>+
>+	return 0;
>+}
>+
> static int
> dpll_msg_add_lock_status(struct sk_buff *msg, struct dpll_device *dpll,
> 			 struct netlink_ext_ack *extack)
>@@ -591,6 +611,9 @@ dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
> 		return ret;
> 	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
> 		return -EMSGSIZE;
>+	ret = dpll_msg_add_phase_offset_monitor(msg, dpll, extack);
>+	if (ret)
>+		return ret;
> 
> 	return 0;
> }
>@@ -746,6 +769,31 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
> }
> EXPORT_SYMBOL_GPL(dpll_pin_change_ntf);
> 
>+static int
>+dpll_phase_offset_monitor_set(struct dpll_device *dpll, struct nlattr *a,
>+			      struct netlink_ext_ack *extack)
>+{
>+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
>+	enum dpll_feature_state state = nla_get_u32(a), old_state;
>+	int ret;
>+
>+	if (!(ops->phase_offset_monitor_set && ops->phase_offset_monitor_get)) {
>+		NL_SET_ERR_MSG_ATTR(extack, a, "dpll device not capable of phase offset monitor");
>+		return -EOPNOTSUPP;
>+	}
>+	ret = ops->phase_offset_monitor_get(dpll, dpll_priv(dpll), &old_state,
>+					    extack);
>+	if (ret) {
>+		NL_SET_ERR_MSG(extack, "unable to get current state of phase offset monitor");
>+		return -EINVAL;
>+	}
>+	if (state == old_state)
>+		return 0;
>+
>+	return ops->phase_offset_monitor_set(dpll, dpll_priv(dpll), state,
>+					     extack);

Why you need to do this get/set dance? I mean, just call the driver
set() op and let it do what is needed there, no?


>+}
>+
> static int
> dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
> 		  struct netlink_ext_ack *extack)
>@@ -1533,10 +1581,34 @@ int dpll_nl_device_get_doit(struct sk_buff *skb, struct genl_info *info)
> 	return genlmsg_reply(msg, info);
> }
> 
>+static int
>+dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
>+{
>+	struct nlattr *a;
>+	int rem, ret;
>+
>+	nla_for_each_attr(a, genlmsg_data(info->genlhdr),
>+			  genlmsg_len(info->genlhdr), rem) {

Hmm, why you iterate? Why you just don't parse to attr array, as it is
usually done?


>+		switch (nla_type(a)) {
>+		case DPLL_A_PHASE_OFFSET_MONITOR:
>+			ret = dpll_phase_offset_monitor_set(dpll, a,
>+							    info->extack);
>+			if (ret)
>+				return ret;
>+			break;
>+		default:
>+			break;
>+		}
>+	}
>+
>+	return 0;
>+}
>+
> int dpll_nl_device_set_doit(struct sk_buff *skb, struct genl_info *info)
> {
>-	/* placeholder for set command */
>-	return 0;
>+	struct dpll_device *dpll = info->user_ptr[0];
>+
>+	return dpll_set_from_nlattr(dpll, info);
> }
> 
> int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index 5e4f9ab1cf75..6ad6c2968a28 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -30,6 +30,14 @@ struct dpll_device_ops {
> 				       void *dpll_priv,
> 				       unsigned long *qls,
> 				       struct netlink_ext_ack *extack);
>+	int (*phase_offset_monitor_set)(const struct dpll_device *dpll,
>+					void *dpll_priv,
>+					enum dpll_feature_state state,
>+					struct netlink_ext_ack *extack);
>+	int (*phase_offset_monitor_get)(const struct dpll_device *dpll,
>+					void *dpll_priv,
>+					enum dpll_feature_state *state,
>+					struct netlink_ext_ack *extack);
> };
> 
> struct dpll_pin_ops {
>-- 
>2.38.1
>

