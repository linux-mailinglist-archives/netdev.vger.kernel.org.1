Return-Path: <netdev+bounces-87533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6538A3724
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 22:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11301F22443
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 20:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECF02556F;
	Fri, 12 Apr 2024 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJeWs1Ic"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5E4C6E
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954317; cv=none; b=GSttNoN4+95Mx8fcSlSNnoaGoDiKbV/x9xMKinh3oC6SGsmjQfhHJrr+gHJ0SVr7gV+paN92SanRsTok+qgHAOjAbEPdIAI2SW8I7MSyMG88D9cTNo4s1/vVsM0bDqRY9Vkwl8CWoDMSsD5m9Upcg4A/Fm+dvXK0Rkj62uBjf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954317; c=relaxed/simple;
	bh=AgzgRk74KXDZId4KH0xeAJixKr/X5xQZUc3HsNPvF4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hv2N/Z9/5libIhAIg/aI97DMZK/octa25Ylz69A3ClhWdzLPj3tpR6uCmKzfkJN5F+vw6eZx93FKKFAvp5KUrDEC7gmrsZ+yc9E7XdklaXJC0WLgrZN4u0M7uwwkjAurAYikIaz0L5cdE1/DQ0/yR7o1TOizBHq4QDz+YSXO19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJeWs1Ic; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78d5f0440d3so78733385a.2
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 13:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712954314; x=1713559114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CK01dkOENUUDTd8rBoVUEkiepABAWB4n11EFeo8kwxI=;
        b=iJeWs1IcAGRLsXrt/vOaM0sMmJRX0e3Iph3JT3/0l0tRdLG2U13g8bmRioDbaGCjJn
         xyGo234ocr8CDl1ZVV7zbqUvcObyg+95ZhOe5Ev/D7UHQ4qp9JwMSOT3c6h8KDdaB9ko
         iMuiJRsRsKSv0Dxt67dDTO8ZtKi2yBB0iH0OWepxR3Cj1yANPFX8pxgVY3jFVtSwYhlg
         qZDer7cvC/lonr9BYBwKvDN4PRcpW8uuI2RE5Z54dBHsGcoQo4EK7TSWiYKPxMwH1uVk
         7PxYID+nhzqKaKkfuMFW6si69fgV0LNjHn6rAzeZptZZUGrXgl/+9S61iI3GUe2uW08O
         ya6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954314; x=1713559114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK01dkOENUUDTd8rBoVUEkiepABAWB4n11EFeo8kwxI=;
        b=WclEGEMN8eoCf99OcPK0nPrbjZmsSseFEwZUq7pX6CDH6ndV6JQPpPsWCmePfwap8L
         TZUrQ9zxY6UcSf1BM+XZBIcX1I2phOIvwRznjLRJAIHt+0DJz6Qm6yM7pvSw9YNyoHjL
         hpHRmHRqaP5FQa+DRM4dTIxrd6jppkxaIc+0TMUUDHC5Vm6mgcteR5VxL77Lh+gJmsoR
         4CWfHjOqDmtzkRo7oNHwNgo7WvWJUvVjP8BK1ivcB6GsyC7BTWoCiNUsmkI4jvY0xUde
         WAVXTPf+tDegfWxFlrG7AnxxGpxqZHmYQN4RhBrtPVjZGLbwo8e/e62vCs5KCR3csTzP
         Axog==
X-Gm-Message-State: AOJu0YzVGiczpkEGD+tjZhz6d01h31eOHNSe4769BE9jg+7O4yPR5aBI
	u6atdB+CByjuKUjfmAmd5l16aH7HPyWJNOxwZjdzalYb5pmIDlJD
X-Google-Smtp-Source: AGHT+IE43atYWdaaL4eHT2oZ1gaBsE1wMKkNJhhxZU6jTFtCOJ6raFzpkE6zp8J76FjOhKhpTi3Hsw==
X-Received: by 2002:a05:620a:b47:b0:78e:bd36:6dbd with SMTP id x7-20020a05620a0b4700b0078ebd366dbdmr3764014qkg.34.1712954313667;
        Fri, 12 Apr 2024 13:38:33 -0700 (PDT)
Received: from localhost ([142.169.16.165])
        by smtp.gmail.com with ESMTPSA id xy2-20020a05620a5dc200b0078d6120fad0sm2837650qkn.108.2024.04.12.13.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:38:33 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:38:30 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Message-ID: <ZhmbxntSvXrsnEG1@f4>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412151314.3365034-4-jiri@resnulli.us>

On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Allow driver tests to work without specifying the netdevice names.
> Introduce a possibility to search for available netdevices according to
> set driver name. Allow test to specify the name by setting
> NETIF_FIND_DRIVER variable.
> 
> Note that user overrides this either by passing netdevice names on the
> command line or by declaring NETIFS array in custom forwarding.config
> configuration file.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 6f6a0f13465f..06633518b3aa 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -55,6 +55,9 @@ declare -A NETIFS=(
>  : "${NETIF_CREATE:=yes}"
>  : "${NETIF_TYPE:=veth}"
>  
> +# Whether to find netdevice according to the specified driver.
> +: "${NETIF_FIND_DRIVER:=}"
> +

This section of the file sets default values for variables that can be
set by users in forwarding.config. NETIF_FIND_DRIVER is more like
NUM_NETIFS, it is set by tests, so I don't think it should be listed
there.

>  # Constants for ping tests:
>  # How many packets should be sent.
>  : "${PING_COUNT:=10}"
> @@ -94,6 +97,42 @@ if [[ ! -v NUM_NETIFS ]]; then
>  	exit $ksft_skip
>  fi
>  
> +##############################################################################
> +# Find netifs by test-specified driver name
> +
> +driver_name_get()
> +{
> +	local dev=$1; shift
> +	local driver_path="/sys/class/net/$dev/device/driver"
> +
> +	if [ ! -L $driver_path ]; then
> +		echo ""
> +	else
> +		basename `realpath $driver_path`
> +	fi
> +}
> +
> +find_netif()
> +{
> +	local ifnames=`ip -j -p link show | jq -e -r ".[].ifname"`

-p and -e can be omitted

