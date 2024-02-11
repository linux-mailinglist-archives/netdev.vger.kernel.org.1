Return-Path: <netdev+bounces-70837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29005850B08
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 20:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4796F1C20BEB
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204545D474;
	Sun, 11 Feb 2024 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIynIXBG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B03DBBB
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707678700; cv=none; b=pYvVwvhQXdiiB8+QHiC/jVZ0XnlpGuC+TJsJyScvj4QB9wbt0qPv6qNfHDiZcDSmcNCyzHZkVXAcVSCgFoWCGvF2NNY14fzEiuUA87KQhy0kpJB/35qy07FQOuF304N2j1IJyqGBUF9USvxhGi8ur6w+/KDUmfL+gmUkk8Mzp7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707678700; c=relaxed/simple;
	bh=F0bd2n9ppPgwCdpz5vELPhZ7yJjUn8K3SSylenUzW/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dF0UJyZZiVOFJBAU1/8C5jlw+K5lLBReXPidyD82WJkLSpM35kwSMkJHxqCtZ3iM8t+Cl0ykF/i2tjK9hIm26ssx/am05jaEu+TPz9J/W13MuZCrfVtWKTnDumxgQLvw7aWhBzbC7ZhSiOUc37fy9w5nnxI44KlwAxe0AUQe9DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hIynIXBG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3c8365c9fcso51308666b.1
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 11:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707678696; x=1708283496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jG0TdlUBg4bPqUyK6YAoywmuGTwbfP2V+QZZe7P406I=;
        b=hIynIXBG5q7cU5wD32s/wo10Gk6oFuZA/U6//BcZdgOw/GI05cJzUh3riQ7x+3Nz88
         M9bPQwnF3f0+MTsWGcbJnXTwWo1wpezK0j/ZFx3Xra4aklvfk5EwkjABucIHYqBOtyVk
         9nz6+/6qavPG63MKeCB3hWrqRxGyNpQCYFnf9mhL+OEhr6NWqUMgzMMV2xmck6gg2wm1
         /ng+HFBkJQOryWFCTbv3VIl3aiO9J3OgXokHt4bLyE+lPhCnoYR3n3/7bylEvi+DA2Oi
         voViVMsmx0PBPlrUPvAKix4GYaKM9pFCu0wZl2TW8SUaAro0NBWjmE0ZMRks5KvDevsD
         k6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707678696; x=1708283496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jG0TdlUBg4bPqUyK6YAoywmuGTwbfP2V+QZZe7P406I=;
        b=tA2IG8Mb06nxCsFSPicRw9mrb9+WmF6raBmfaskgJ/j8xgymfsKCFJJx/BzmnGORII
         dDsFT8hAJy4nxq38pRdoLg8rQKg2aaWFYAyyvw7xZCd4blOrBsxFXpz5VeelrI17UY4i
         sl8Xzk938MFWqRbhRGQvuto5sVk8rL/jqkvkqDjJ1jqK4lug8ZQ+BdTl2G/EvK34je+f
         /2nGQ9oKzQ4HEZszocdFqa55QEL/XPFkFPNO7GJaeqqHdQQ/+CNE8TeZ485FXYjYFKHh
         51rx5F4lG5eN7iUh+gkCLz9+tWGHKI30st1ItweFwgHNra2aEctxs3Cp+cNAwDSbrPpS
         7sBA==
X-Gm-Message-State: AOJu0YwdEyzCSNJ5IkFcTvrRcx0tHI59SyMXr33rVnH+NUDphD8l+3VT
	J5xdFpY/sU5qvWy7txJ2yOier8GKegpkaoa+bDQbHlckQdSKHYJpyG/mWcsw4mUVtmnrx+/OV8O
	fF5dSfyBU2oTh+nYSohiTTfl+Ov8V8h1qMWcO2g==
X-Google-Smtp-Source: AGHT+IEj9RROH1TEBcxg7m97NBjGxPg93qBmjDgH7LpAAhCu7W1LwUtyP7It6THnLjTuD8tnzzMjrRbvkgg/852PWV0=
X-Received: by 2002:a17:906:1909:b0:a3c:a3eb:6109 with SMTP id
 a9-20020a170906190900b00a3ca3eb6109mr283606eje.14.1707678696111; Sun, 11 Feb
 2024 11:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205102230.89081-1-songjinjian@hotmail.com> <MEYP282MB26972B38E198B163EE7094DEBB472@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB26972B38E198B163EE7094DEBB472@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Sun, 11 Feb 2024 20:10:59 +0100
Message-ID: <CAMZdPi9-OCucMxPBTqBc4xTe_LgOiNd13tVVzeVBg8aim_M+ng@mail.gmail.com>
Subject: Re: [net-next v9 1/4] wwan: core: Add WWAN fastboot port type
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, alan.zhang1@fibocom.com, angel.huang@fibocom.com, 
	chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com, 
	danielwinkler@google.com, davem@davemloft.net, edumazet@google.com, 
	felix.yan@fibocom.com, freddy.lin@fibocom.com, haijun.liu@mediatek.com, 
	jinjian.song@fibocom.com, joey.zhao@fibocom.com, johannes@sipsolutions.net, 
	kuba@kernel.org, letitia.tsai@hp.com, linux-kernel@vger.kernel.com, 
	liuqf@fibocom.com, m.chetan.kumar@linux.intel.com, nmarupaka@google.com, 
	pabeni@redhat.com, pin-hao.huang@hp.com, ricardo.martinez@linux.intel.com, 
	ryazanov.s.a@gmail.com, vsankar@lenovo.com, zhangrc@fibocom.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 11:23, Jinjian Song <songjinjian@hotmail.com> wrote:
>
> From: Jinjian Song <jinjian.song@fibocom.com>
>
> Add a new WWAN port that connects to the device fastboot protocol
> interface.
>
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>

AFAIR, I already gave my tag for this change, please carry the tag
along versions.

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>



> ---
> v2-v9:
>  * no change
> ---
>  drivers/net/wwan/wwan_core.c | 4 ++++
>  include/linux/wwan.h         | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 72e01e550a16..2ed20b20e7fc 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -328,6 +328,10 @@ static const struct {
>                 .name = "XMMRPC",
>                 .devsuf = "xmmrpc",
>         },
> +       [WWAN_PORT_FASTBOOT] = {
> +               .name = "FASTBOOT",
> +               .devsuf = "fastboot",
> +       },
>  };
>
>  static ssize_t type_show(struct device *dev, struct device_attribute *attr,
> diff --git a/include/linux/wwan.h b/include/linux/wwan.h
> index 01fa15506286..170fdee6339c 100644
> --- a/include/linux/wwan.h
> +++ b/include/linux/wwan.h
> @@ -16,6 +16,7 @@
>   * @WWAN_PORT_QCDM: Qcom Modem diagnostic interface
>   * @WWAN_PORT_FIREHOSE: XML based command protocol
>   * @WWAN_PORT_XMMRPC: Control protocol for Intel XMM modems
> + * @WWAN_PORT_FASTBOOT: Fastboot protocol control
>   *
>   * @WWAN_PORT_MAX: Highest supported port types
>   * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
> @@ -28,6 +29,7 @@ enum wwan_port_type {
>         WWAN_PORT_QCDM,
>         WWAN_PORT_FIREHOSE,
>         WWAN_PORT_XMMRPC,
> +       WWAN_PORT_FASTBOOT,
>
>         /* Add new port types above this line */
>
> --
> 2.34.1
>

