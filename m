Return-Path: <netdev+bounces-90245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898938AD45A
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F28BB2652E
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B9E15530C;
	Mon, 22 Apr 2024 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCiPjSgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D1154C16
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811662; cv=none; b=pPDsd91vBGr8817lo4sFqd0buANfhq6IBgU0+QWk5uPvUqqsrP5AXrpq+Hx6mySDSimlxqBRiAZGR6lSlJcaS0E/0JGmYD7i1uazK8//+Hk0cAbfBeYODhOfCCTf4cZfZNDxjWwVdOL0tHRrmdh5+cMvyxmDEsMDcEnCdEtY93g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811662; c=relaxed/simple;
	bh=RjC+01ZDFE6MNxd2eykgAq+nbbFDAvXeRdNuyVLRIsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGSFW6ZHd7Xm5jSePnUfhH2hBqnWnLzSGUi6/CNhm4paQ/ruzDtW99u2qi59Nq3G0lSm9qN8zd/TUMzBKsHlhnQe4oxglX8+NSoz+IKUB+NXmPlNbM9QLVQz3KEHGAuNlAIb2SwzmyyAPemxoGER4qUc9Y3Z51dblWo1sAnAixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCiPjSgM; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa1b7a37b5so2941974eaf.2
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713811660; x=1714416460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=owEYz5PcX2V/77HEBhhtfv3jinwHJK/SDFDfp/Sqt3w=;
        b=aCiPjSgMgyuxUc64ZaKAB4171D1FMmReEwkzq/78PYeahbdJ5eHnrnIF8eis64TwR7
         nR86RWgC0aad12+ziYl3QrMSZ/EZAyiXMCMpJFFtSPifA44ua/1D1oZamzKEt0yjgEXG
         4Ei026Jz6SGzvfibV5BOvXVn7t615jZrkm13hUgyEujeKecC2iiSm3v2Rb5VrB6ekEi2
         TaME8yrkXC0Hfqi0mGD9QO/3ywhiwn0YzzKsZ2SP4/6b2ezx1nZQW2B8wl/ljKxSt2QD
         bD1cqTUnUTlh6rbhGIBEHBK5T1Ank0Ot0jApPVAJPglZxtrMrCnp1eHy4TDlsZVZUF9w
         IDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713811660; x=1714416460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owEYz5PcX2V/77HEBhhtfv3jinwHJK/SDFDfp/Sqt3w=;
        b=BzOI1If76nqOJtpKhBMc3KW1XKu/Gk6X5DEYwOrEA7Zies6Q7keckoh45xSUxN3tJj
         65JvO4RQM7Re76C4MwGoLx1wMLDbP2EAbrQjPNV0SJC7lHglvsdj6JHDHg9IA9UiESrb
         uF0leKOvqOR2f/0tFt4Eo43ZoL+9bf6EnS6j5gywf87Fd1HShHsGpv9Ih1L9xuSMZF0K
         6XG0kPvZfIN3AxEw0cVZfp7otzEBV+IvjVMTHuGIvzzG0n9oYzU7STAenOzqztQNGH87
         AjAeqrziGZ3TRqHDrJ9BCHJasW4h5aAPGzCHI5jVz1p2EL7rxN+YULXoEDYoD/hZpLur
         QTtw==
X-Gm-Message-State: AOJu0YxSCQpJspVxwYE8aPYY7fFGAbolS0qQxoYhQohBXuGIHiaHc+ff
	ig+1/FTmxbMHWzKDiqmdqgi2n/1+PE+9RLj+IDFKuztyjxrW10v4
X-Google-Smtp-Source: AGHT+IEjbIqLnAxfDcJjgknmPb5GWL+5HQ/C36pYtthEjpOFT0Ql7t5dq/2XIjAVrzgHR4C5YbOq5g==
X-Received: by 2002:a05:6359:760d:b0:18a:9bba:972a with SMTP id wg13-20020a056359760d00b0018a9bba972amr5822611rwc.32.1713811660340;
        Mon, 22 Apr 2024 11:47:40 -0700 (PDT)
Received: from localhost (24-122-67-147.resi.cgocable.ca. [24.122.67.147])
        by smtp.gmail.com with ESMTPSA id j18-20020ac86652000000b00437392f1c20sm4467829qtp.76.2024.04.22.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 11:47:40 -0700 (PDT)
Date: Mon, 22 Apr 2024 14:47:39 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v5 3/5] selftests: forwarding: add
 check_driver() helper
Message-ID: <ZiawyyOY-6radvXV@f4>
References: <20240418160830.3751846-1-jiri@resnulli.us>
 <20240422153303.3860947-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422153303.3860947-3-jiri@resnulli.us>

On 2024-04-22 17:32 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add a helper to be used to check if the netdevice is backed by specified
> driver.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 9d6802c6c023..00e089dd951d 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -278,10 +278,17 @@ check_port_mab_support()
>  	fi
>  }
>  
> -if [[ "$(id -u)" -ne 0 ]]; then
> -	echo "SKIP: need root privileges"
> -	exit $ksft_skip
> -fi

Why is the check being removed entirely? This change was not in v4 of
this patch. Did it happen unintentionally when removing "selftests:
forwarding: move initial root check to the beginning"?

> +check_driver()
> +{
> +	local dev=$1; shift
> +	local expected=$1; shift
> +	local driver_name=`driver_name_get $dev`
> +
> +	if [[ $driver_name != $expected ]]; then
> +		echo "SKIP: expected driver $expected for $dev, got $driver_name instead"
> +		exit $ksft_skip
> +	fi
> +}
>  
>  if [[ "$CHECK_TC" = "yes" ]]; then
>  	check_tc_version
> -- 
> 2.44.0
> 
> 

