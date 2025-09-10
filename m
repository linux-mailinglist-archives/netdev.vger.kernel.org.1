Return-Path: <netdev+bounces-221651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D60B51701
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419173BB08D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A4B3164A7;
	Wed, 10 Sep 2025 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aTz+KXze"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962E313E08
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507667; cv=none; b=THzUNsmo8+z8N+nPuewQhEIakUWEeYuPsBzuraTQvtX5Rb6EN14BpRLxOqak1d/4+5dn34hhe8ZRWTK05KSxjAoAC3FLGsICeho+FIjwaXCDNk3RF0kgCtbt7AEAbf/0rtJNoE8DZtFXzYDg6a7mflKz5N+/5xbTee2Pq8oDLAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507667; c=relaxed/simple;
	bh=PH1OhdAk96d7r6DmGIu/QDgVDTaYv6kWsYOttjtZBtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mb29YT6lWIA9am5RCKt0153gNm3wfvWscpVtnKYq0+YoCGeClXSNxrz5/X1ky7XwdSseSw7sxkb9EYJ3ZEIZsBFWZpgdpWF+817l1SrhlkHWEQrla+2yC3Af+Qa45vVb3CcujnrzBslgRDxLGQXG9R+lOPHCDljcw9Ty3nr3p3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aTz+KXze; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ca46c45-96c3-4ad8-b00a-2494ae12d88b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757507661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59RkyYqfgn92AF1xoKOrRdETeifx4VHGvz5jW/w0Voc=;
	b=aTz+KXzekajOQSl76becVf9an60BVAogUCTg/zq6pBp1srEuFfzw8NOCs0rrXFUovElYW+
	4UFxM31w7KtE7XBaKMPjo6hJ8GBy/MVQ43qNwdSLbjq5gToPfnda17lKMMRFn/MzlcYgmJ
	6xBDI+WxS9HQhGClzVg4zfRRUkGqoKg=
Date: Wed, 10 Sep 2025 13:34:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] dpll: zl3073x: Allow to use custom phase measure
 averaging factor
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250910103221.347108-1-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250910103221.347108-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10.09.2025 11:32, Ivan Vecera wrote:
> The DPLL phase measurement block uses an exponential moving average,
> calculated using the following equation:
> 
>                         2^N - 1                1
> curr_avg = prev_avg * --------- + new_val * -----
>                           2^N                 2^N
> 
> Where curr_avg is phase offset reported by the firmware to the driver,
> prev_avg is previous averaged value and new_val is currently measured
> value for particular reference.
> 
> New measurements are taken approximately 40 Hz or at the frequency of
> the reference (whichever is lower).
> 
> The driver currently uses the averaging factor N=2 which prioritizes
> a fast response time to track dynamic changes in the phase. But for
> applications requiring a very stable and precise reading of the average
> phase offset, and where rapid changes are not expected, a higher factor
> would be appropriate.
> 
> Add devlink device parameter phase_offset_avg_factor to allow a user
> set tune the averaging factor via devlink interface.
> 
> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

[...]

> +static int
> +zl3073x_devlink_param_phase_avg_factor_set(struct devlink *devlink, u32 id,
> +					   struct devlink_param_gset_ctx *ctx,
> +					   struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dev *zldev = devlink_priv(devlink);
> +	u8 avg_factor, dpll_meas_ctrl;
> +	int rc;
> +
> +	/* Read DPLL phase measurement control register */
> +	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, &dpll_meas_ctrl);
> +	if (rc)
> +		return rc;
> +
> +	/* Convert requested factor to register value */
> +	if (ctx->val.vu8 < 15)
> +		avg_factor = ctx->val.vu8 + 1;
> +	else
> +		avg_factor = 0;
> +

This looks like avg_factor = (ctx->val.vu8 + 1) & 0x0f;
The same logic can be applied for get() function assuming we are aware of
unsigned roll-over...

