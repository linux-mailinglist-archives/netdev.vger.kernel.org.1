Return-Path: <netdev+bounces-87613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7618A3CCE
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 15:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901471C20C2E
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371B3FB9A;
	Sat, 13 Apr 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VG1mmfT1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330121106
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713014883; cv=none; b=rB+6f4OvzAR+TMjyRzfoDxrKEpZobtlCsGs+Ftc/l4nt58Hr54irZZWq39NA/Wacydbez9tkp5FmcCAuUWth4CWfy5hZn2/8EXGkeaMe30DWfwzwnPqESJuBL542KOtZMBXfWKwx5o856ybiO6JAxuH51aYn0JwH0ovwLrfqC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713014883; c=relaxed/simple;
	bh=LwGLc3+IrgJjbQnLV1TC69YW8KHGYXfCXdLWqOnivX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opRvYbVaMAbQrNUhysdyUCSp3apmYYsJvqB9y8ogyMRlfeHlsMjOwx+FXSND1UUGva7oLVcaKTSZQmHbm3/1NFJ2b2GtAU81Z0OH94XTSQ9WaAGIFoWMpNviTQQFoCDy4Tr8umCPPBWabFDRY4gAcMih0Usn9CsUznD4ZJlNlZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VG1mmfT1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so2103521e87.1
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713014879; x=1713619679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mdk3BCrsCTJnu5xf2tOmLWcHPXa5Tve1jVTCet9Q7JM=;
        b=VG1mmfT1aDmRkhza9ujSTGQYmqjgctEY4Xg96edzSB0C40YDh4RVWAhnm3ATtL0xS5
         xZB9W8sXDuN8JS5yzi2wPpWRwOvr1xUZfX32rsvSMdcszODzRqaj1LgLiLcFA9RBUFqa
         W+7RSibtYSn/P7yLSW+fhV9oUoLZ6Wzt0daZGL0qYuYC/DrXdA9j7sXc2j7gbVVucvdu
         iyBUtBf56jBF8zaFWp6Lz6XptE7WOIaC5cCLww2TCT8upuOtDU36TgNBouSopOws/wwI
         0becKs+dRThHc7p1xHa2wzamCg+GufH1zHydLA2ljES6EUR0ZxD/NgDuGMCLN0m00jO1
         B6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713014879; x=1713619679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdk3BCrsCTJnu5xf2tOmLWcHPXa5Tve1jVTCet9Q7JM=;
        b=dv8EQn4OEOyQrCj9jrkKpqYxjZpPZTCZHX6SN8eTos6kFavtwGfBEOr3BuFIv/vt06
         OJzWfMGpvR/Iw7I2VLfCXn/7zfqiosdAbYP80/mbttFf6k/YBi0oP2h+EpbHumPK065Y
         tMyWHdz9WrReyciLGE6VsEwTuhvB69GS+H9oVcupklUcHSBPUTZ8wLvLyXp7uVbgkLdV
         DpTvn1MZFeNDx1d1tXme/3eEN2/XIR9UGu7j4sJYQWdP9mzpO8lrAxQgYWxq1CN0R6i8
         tN6ac2f4f7FWvhrkYdmq6YRxDzXu4jtseimEOHrx/JI7VakFylOXEK/grdyKGvZ/tCVU
         4gNA==
X-Gm-Message-State: AOJu0YwNwicX0DsLVZzzqW5L3UaKQg6/cCRfM+9hDXtVgAHgiqLFSQgr
	tZjRkII8z92sCd6CsiR1ph7wvT1smdG8DMpmyjR6iYdfQO7fA1937F3FhSzZ5m0=
X-Google-Smtp-Source: AGHT+IHuuYRVy65MZ8rYdAOA7GSedvsAl/kLZcW/Y4B0ECtDIK457OVH4T7sHnxelpZv0xl1aRVvqA==
X-Received: by 2002:a05:6512:33c8:b0:518:b069:3b7d with SMTP id d8-20020a05651233c800b00518b0693b7dmr878248lfg.6.1713014879122;
        Sat, 13 Apr 2024 06:27:59 -0700 (PDT)
Received: from localhost (37-48-0-252.nat.epc.tmcz.cz. [37.48.0.252])
        by smtp.gmail.com with ESMTPSA id hd7-20020a170907968700b00a524dda47c0sm691236ejc.143.2024.04.13.06.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 06:27:58 -0700 (PDT)
Date: Sat, 13 Apr 2024 15:27:57 +0200
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
Message-ID: <ZhqIXZYnHA0MZT3L@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-4-jiri@resnulli.us>
 <ZhmbxntSvXrsnEG1@f4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhmbxntSvXrsnEG1@f4>

Fri, Apr 12, 2024 at 10:38:30PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
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
>>  tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 6f6a0f13465f..06633518b3aa 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -55,6 +55,9 @@ declare -A NETIFS=(
>>  : "${NETIF_CREATE:=yes}"
>>  : "${NETIF_TYPE:=veth}"
>>  
>> +# Whether to find netdevice according to the specified driver.
>> +: "${NETIF_FIND_DRIVER:=}"
>> +
>
>This section of the file sets default values for variables that can be
>set by users in forwarding.config. NETIF_FIND_DRIVER is more like
>NUM_NETIFS, it is set by tests, so I don't think it should be listed
>there.

Well, currently there is a mixture of config variables and test
definitions/requirements. For example REQUIRE_JQ, REQUIRE_MZ, REQUIRE_MTOOLS
are not forwarding.config configurable (they are, they should not be ;))

Where do you suggest to move NETIF_FIND_DRIVER?


>
>>  # Constants for ping tests:
>>  # How many packets should be sent.
>>  : "${PING_COUNT:=10}"
>> @@ -94,6 +97,42 @@ if [[ ! -v NUM_NETIFS ]]; then
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
>> +}
>> +
>> +find_netif()
>> +{
>> +	local ifnames=`ip -j -p link show | jq -e -r ".[].ifname"`
>
>-p and -e can be omitted

True. Will remove them.

