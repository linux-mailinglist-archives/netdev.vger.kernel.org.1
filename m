Return-Path: <netdev+bounces-36588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8000E7B0B9F
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9C7361C2083E
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7E24B227;
	Wed, 27 Sep 2023 18:09:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E65689
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:09:15 +0000 (UTC)
Received: from out-192.mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D68B4
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:09:13 -0700 (PDT)
Message-ID: <4018c0b0-b288-ff60-09be-7ded382f4a82@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695838151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G57rpo1++Zl3if+NiAqrdipXpzXF4O8DuKQxu1acs6Y=;
	b=UGSLpovy39IQoNTjV00vQzdXtByKcO1708I/wTtTwg0OrqG2knrgm8aQAaFR+aRxapBNZD
	vxMcXn3hDzXXlL8hTEK+Mtk75UQDk6uk+QSSlqrcLOVdxsH9/Ntr3E0wWIfM7+LXPCVLDC
	fFu9aRtEQyDi2wMZo8tyiSksRgcGiaA=
Date: Wed, 27 Sep 2023 19:09:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/4] dpll: netlink/core: add support for pin-dpll
 signal phase offset/adjust
Content-Language: en-US
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org
Cc: jiri@resnulli.us, corbet@lwn.net, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
 <20230927092435.1565336-4-arkadiusz.kubalewski@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230927092435.1565336-4-arkadiusz.kubalewski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27/09/2023 10:24, Arkadiusz Kubalewski wrote:
> Add callback op (get) for pin-dpll phase-offset measurment.
> Add callback ops (get/set) for pin signal phase adjustment.
> Add min and max phase adjustment values to pin proprties.
> Invoke get callbacks when filling up the pin details to provide user
> with phase related attribute values.
> Invoke phase-adjust set callback when phase-adjust value is provided for
> pin-set request.
> 
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

[...]

> +static int
> +dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
> +		       struct netlink_ext_ack *extack)
> +{
> +	struct dpll_pin_ref *ref;
> +	unsigned long i;
> +	s32 phase_adj;
> +	int ret;
> +
> +	phase_adj = nla_get_s32(phase_adj_attr);
> +	if (phase_adj > pin->prop->phase_range.max ||
> +	    phase_adj < pin->prop->phase_range.min) {
> +		NL_SET_ERR_MSG(extack, "phase adjust value not supported");
> +		return -EINVAL;
> +	}
> +	xa_for_each(&pin->dpll_refs, i, ref) {
> +		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
> +		struct dpll_device *dpll = ref->dpll;
> +
> +		if (!ops->phase_adjust_set)
> +			return -EOPNOTSUPP;

I'm thinking about this part. We can potentially have dpll devices with
different expectations on phase adjustments, right? And if one of them
won't be able to adjust phase (or will fail in the next line), then
netlink will return EOPNOTSUPP while _some_ of the devices will be
adjusted. Doesn't look great. Can we think about different way to apply
the change?


> +		ret = ops->phase_adjust_set(pin,
> +					    dpll_pin_on_dpll_priv(dpll, pin),
> +					    dpll, dpll_priv(dpll), phase_adj,
> +					    extack);
> +		if (ret)
> +			return ret;
> +	}
> +	__dpll_pin_change_ntf(pin);
> +
> +	return 0;
> +}
> +

