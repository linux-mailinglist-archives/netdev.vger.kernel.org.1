Return-Path: <netdev+bounces-87793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A08A4A89
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 399D9B21564
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E47381C2;
	Mon, 15 Apr 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qTsuYU89"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4239FCF
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170448; cv=none; b=jkNN/aagQOQtHNB8B+Ys4GvDk6AK7HJpu112fpa1HooZnjdjN/TMirbhZKJsWuRQI/eM1blpw5Y+JszjchhA/pi/rDsBCeYLGlBhP2gVKmLzcy44yUZR4PWwptrFUK3IuLSLXEM9IpNvJkHJ3KJ8AUh7rncd/mH7sj2Ym8FQlSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170448; c=relaxed/simple;
	bh=7Qg+Cc85pc+w+f2K+Ou2xfL1RJ9qFFxcGgIDOESjcoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVcK1013EKgidR/6PcOhsM91zQrv6vxLz0j+NnkXlAfGw5kADZLgvgGm0xQ5BgmOTjGC6VldWh6HPUFX4Us4tONtks1To4Uv+ncUrOmQ3o7tnVoSKPZiVr/MLbfJvbp9HXAWRAHYcgTsa9odfomhmozeTBc/kAwYiUTHQ2LrC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qTsuYU89; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2da888330b2so8070561fa.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713170444; x=1713775244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=giKkTelfq3BYsAFGZhixira6GIq9vSuoB3MA1iZ83Kk=;
        b=qTsuYU89zCgh/hywO7mhtCHpUWtlPSetuYGZ+CooNjemaKniS5f6ZWeLMayOuZUCnH
         CVydRTtDzx0UyQ2EL5W+LfKlRqQwNGLldU2yuvnRMkMNCBTh7frfutdU9hlIpOQoaB7u
         41iMRcEsTAVnKRp3I8nEm/5+Yc757EmDXQcV0fBustkovLIwP6Re3Of6JdmR8CC3PUaE
         r7jrcHJrcEkI6u8ido/8S2PyqjxtzLU5H2N38cb7lm1x6fRnQBJ4SP8OaH3fRCXHuw+G
         hpw3/6hl37GdwM1MjADNddnRqz96zbCQDsTmK+aIGxaZ1QMZt6QN2Lkx/mUx0KYj/BLC
         M9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170444; x=1713775244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giKkTelfq3BYsAFGZhixira6GIq9vSuoB3MA1iZ83Kk=;
        b=pHhSop6ngLWvn1d8cfl7goUGOgAV7fkVNQ/+REQEXM6DVuwEDm6pHrRnlNNmQu0z5P
         oAXgs4ML1UJE9lsX9kwVJ55/KXXgtOLhdTfG8wZcrcy/CQWddjpWU3y1Wgof68vEjO1a
         98PuAE5CqSq8PqUZZdtwiz9M4yYyImr3nA61vSEFQ7zQ8N8p49/ZRyiarJJqkmIerkpi
         X9bKoSDN5eSHXayRvWiX5Tmnt7HoPSkVikyLgQRr0y5ji2Y/Vy+ZJTdBzbdgVM7+RUMQ
         0u58sjb63ZmFTxfvhzYwn1mPLls021PvQdhTm6gMZ3UM8d47YfHQllXs1QZ729IUhRWL
         XaNg==
X-Gm-Message-State: AOJu0Yyqz3IKc7Y9cr88Ke4jnbFXIrF+rBm0TV81NTj2fZrCuF/42XP6
	bXKaAIfhsIdC6d6kNJcp3SfpT6rrbpVsE4qs4HjgmBF9XZGQCGkr3kHAiG3wAJs=
X-Google-Smtp-Source: AGHT+IEouBsRvNsGw2BBII7zCSX4R6hyekzhRCRfz+XWQvsollf7R1Urp0JmU2pLaPzlOmGbrP8bKg==
X-Received: by 2002:a05:6512:4014:b0:518:7df6:d9e1 with SMTP id br20-20020a056512401400b005187df6d9e1mr8528376lfb.10.1713170443564;
        Mon, 15 Apr 2024 01:40:43 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170906e95800b00a51adace6ebsm5216634ejb.79.2024.04.15.01.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:40:43 -0700 (PDT)
Date: Mon, 15 Apr 2024 10:40:39 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Message-ID: <ZhzoB3x3cEAEyIXD@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-4-jiri@resnulli.us>
 <ZhmbxntSvXrsnEG1@f4>
 <ZhqIXZYnHA0MZT3L@nanopsycho>
 <ZhwvXgxEnHN8oJ5f@f4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhwvXgxEnHN8oJ5f@f4>

Sun, Apr 14, 2024 at 09:32:46PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-13 15:27 +0200, Jiri Pirko wrote:
>> Fri, Apr 12, 2024 at 10:38:30PM CEST, benjamin.poirier@gmail.com wrote:
>> >On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Allow driver tests to work without specifying the netdevice names.
>> >> Introduce a possibility to search for available netdevices according to
>> >> set driver name. Allow test to specify the name by setting
>> >> NETIF_FIND_DRIVER variable.
>> >> 
>> >> Note that user overrides this either by passing netdevice names on the
>> >> command line or by declaring NETIFS array in custom forwarding.config
>> >> configuration file.
>> >> 
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> ---
>> >>  tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
>> >>  1 file changed, 39 insertions(+)
>> >> 
>> >> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> >> index 6f6a0f13465f..06633518b3aa 100644
>> >> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> >> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> >> @@ -55,6 +55,9 @@ declare -A NETIFS=(
>> >>  : "${NETIF_CREATE:=yes}"
>> >>  : "${NETIF_TYPE:=veth}"
>> >>  
>> >> +# Whether to find netdevice according to the specified driver.
>> >> +: "${NETIF_FIND_DRIVER:=}"
>> >> +
>> >
>> >This section of the file sets default values for variables that can be
>> >set by users in forwarding.config. NETIF_FIND_DRIVER is more like
>> >NUM_NETIFS, it is set by tests, so I don't think it should be listed
>> >there.
>> 
>> Well, currently there is a mixture of config variables and test
>> definitions/requirements. For example REQUIRE_JQ, REQUIRE_MZ, REQUIRE_MTOOLS
>> are not forwarding.config configurable (they are, they should not be ;))
>
>Yes, that's true. If you prefer to leave that statement there, go ahead.
>
>> Where do you suggest to move NETIF_FIND_DRIVER?
>
>I would make NETIF_FIND_DRIVER like NUM_NETIFS, ie. there's no statement
>setting a default value for it. And I would move the comment describing
>its purpose above this new part:

Ok.

>
>> +
>> +if [[ ! -z $NETIF_FIND_DRIVER ]]; then
>> +	unset NETIFS
>> +	declare -A NETIFS
>> +	find_netif
>> +fi
>> +
>
>BTW, '! -z' can be removed from that test. It's equivalent to:
>if [[ $NETIF_FIND_DRIVER ]]; then

Ok.


