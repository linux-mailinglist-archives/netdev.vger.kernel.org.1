Return-Path: <netdev+bounces-89171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E63268A999F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49A55B24351
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F29A15FA70;
	Thu, 18 Apr 2024 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="c3oQ2VLl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1F15F3FD
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442470; cv=none; b=K5QwD4VLOqYeVsm4v5aaN3hj5G0I7FFEyFvMZo8JJfq+4F5yYrGyQj1JnzhlicQHdLT6cbPie6lWhg5y5qilRND0qGe5JEFR+pCSYUUcsdJ843i4acwjL074wuv/4aWIObMTi/8+Mi4KaVRTd7IJdmxoSzyEYzarWif2jpf826M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442470; c=relaxed/simple;
	bh=ARDKhUMyorB3Kv9r/SkCvfmQXbsY+zsxPmXEiMW0iLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7+ZhZCezBGy9VzCTGNhAma7d3levLveYr2q32Vkstdv4lodRMT2UjqvcjNFsnlDWwxMI+eroWz+kuoGDVv7/B3NZ+aUe29NSTkqSvIfC4wYE/J6H6pwLVj7YmKMfNHB9sHk0uKvK0nywtPKkTS7Y0pnyn5scnLEbR39F/gnf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=c3oQ2VLl; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so15151511fa.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713442466; x=1714047266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8I73lkdTXjzUlQb3r+JVz+alI3Ct3G5CCb+F55/1Q4=;
        b=c3oQ2VLlQ1uPJiynmGEeFTUaTm2knpS0oBQnMnTUhSfWblJpABWGGttySbNoI+PKgj
         dYPsLkQhckGC7o853n8p8OgAN1WgJs7CgQSTf4OsVXqU4LNUdMPk5aZEgllWkxvAvOuk
         WHQlp5F1xOff6TP52r9GtAO/BGMPK7hDIxv3oDpSaS2L6ZkzLL9Oy7j7zTiO84zgOhsT
         8LJyfrRtGd/dTPotkmZho91MKoX3tHQMMhT25kZ+JQwoXkxIxpcpRayqWcj4Bn7F+2YK
         t3Aegdcp5736DL1iGHqLi/ciRp9e2CklvdoJK/nCxsfFC4MQUZePgofRR854gtqU08Pc
         Y8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713442466; x=1714047266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8I73lkdTXjzUlQb3r+JVz+alI3Ct3G5CCb+F55/1Q4=;
        b=NuzctEQh6DDinPKjHpRwfIILT2KUKUcxOMzpHST5p9emnaqJzbsWqKt1e758EokjoI
         ZxWzYe4eBVzrfIfzKdwJmYjx5ZTnIl4CGorCv5Le6SqY9+H54SroPv6P3op7Sj0+ruBg
         yCMUcJoZ0eKpd+MJYWIr1JzZlMd3qLp/lOkXDS7KlJkMobgob6eWnAOKXtGg5o8tHT4q
         SWEoVGgoNUSRsnHbpZvJV50AXtHGlLB8Yc3PU7rgnw3gIAGX56OnL4ub/tmkI4Art8X4
         WvXOAzm8lpE2PHqPPfJHcxQahDtbWiYdHB7FNdG9unBv9Ha0TzfnZq71xqcZqGdMpV9r
         7oUw==
X-Gm-Message-State: AOJu0Yz3A20cCrb14Lg80eNdUQjX3RcZ8Jjmc4iBLRA6ewH39EY/+nNL
	udexRqA0DU9ZfmZh7fm0khY0Cft7xXw8GS19z9fMYwVJ7nJLB4qMyqYNtK4ao+I=
X-Google-Smtp-Source: AGHT+IGpPgt4PAoJXQCAEuvUwqMXEOjcT4P3uK8NQz4SSFByhPpqHL3h7sY69rapnfoIi9Bl7b9ZCg==
X-Received: by 2002:a2e:a71f:0:b0:2dc:ae50:d890 with SMTP id s31-20020a2ea71f000000b002dcae50d890mr82985lje.26.1713442466022;
        Thu, 18 Apr 2024 05:14:26 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id j18-20020a170906051200b00a51ba0be887sm806927eja.192.2024.04.18.05.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:14:25 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:14:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v3 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Message-ID: <ZiEOn1GyZhyDfr25@nanopsycho>
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-4-jiri@resnulli.us>
 <87bk67cbuc.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk67cbuc.fsf@nvidia.com>

Thu, Apr 18, 2024 at 10:11:12AM CEST, petrm@nvidia.com wrote:
>
>Jiri Pirko <jiri@resnulli.us> writes:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Allow driver tests to work without specifying the netdevice names.
>> Introduce a possibility to search for available netdevices according to
>> set driver name. Allow test to specify the name by setting
>> NETIF_FIND_DRIVER variable.
>>
>> Note that user overrides this either by passing netdevice names on the
>> command line or by declaring NETIFS array in custom forwarding.config
>> configuration file.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - removed unnecessary "-p" and "-e" options
>> - removed unnecessary "! -z" from the check
>> - moved NETIF_FIND_DRIVER declaration from the config options
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 2e7695b94b6b..b3fd0f052d71 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -94,6 +94,45 @@ if [[ ! -v NUM_NETIFS ]]; then
>>  	exit $ksft_skip
>>  fi
>>  
>> +##############################################################################
>> +# Find netifs by test-specified driver name
>> +
>> +driver_name_get()
>> +{
>> +	local dev=$1; shift
>> +	local driver_path="/sys/class/net/$dev/device/driver"
>> +
>> +	if [ ! -L $driver_path ]; then
>> +		echo ""
>> +	else
>> +		basename `realpath $driver_path`
>> +	fi
>
>This is just:
>
>	if [[ -L $driver_path ]]; then
>		basename `realpath $driver_path`
>	fi

Ok.


>
>> +}
>> +
>> +find_netif()
>
>Maybe name it find_driver_netif? find_netif sounds super generic.

netif_find_driver() to be aligned with the variable name.


>
>Also consider having it take an argument instead of accessing
>environment NETIF_FIND_DRIVER directly.

Considered, don't see any benefit. Touching outside variable NETIFS
anyway.


>
>> +{
>> +	local ifnames=`ip -j link show | jq -r ".[].ifname"`
>> +	local count=0
>> +
>> +	for ifname in $ifnames
>> +	do
>> +		local driver_name=`driver_name_get $ifname`
>> +		if [[ ! -z $driver_name && $driver_name == $NETIF_FIND_DRIVER ]]; then
>> +			count=$((count + 1))
>> +			NETIFS[p$count]="$ifname"
>> +		fi
>> +	done
>> +}
>> +
>> +# Whether to find netdevice according to the specified driver.
>> +: "${NETIF_FIND_DRIVER:=}"
>
>This would be better placed up there in the Topology description
>section. Together with NETIFS and NETIF_NO_CABLE, as it concerns
>specification of which interfaces to use.


You replied yourself.



>
>> +
>> +if [[ $NETIF_FIND_DRIVER ]]; then
>> +	unset NETIFS
>> +	declare -A NETIFS
>> +	find_netif
>> +fi
>> +
>>  net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
>>  
>>  if [[ -f $net_forwarding_dir/forwarding.config ]]; then
>

Thanks!


