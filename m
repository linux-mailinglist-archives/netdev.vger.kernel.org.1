Return-Path: <netdev+bounces-87614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4FB8A3CD0
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 15:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6780C1F2156F
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 13:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F07A3FBA0;
	Sat, 13 Apr 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="d3vNdPBG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897713E47B
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713014954; cv=none; b=k6MRfl8bC8zy5gKQlbwPRR7S2wkV13SCHSojN2Jnhy5FUyDIjb/LaZEHxOAcEfwARgUqquQJYORfzVy8NavnYnpbePtHEPjqnWr4I+6wudRiWiyB6fOYK6WFPT7rZtxUn3H9TWJLW4Pi28uxHY5DI+HudCbvbEpwFepE0q9bZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713014954; c=relaxed/simple;
	bh=MROLZPJUrsuLDWksM0DueQaZL91l9XmteS/PnFCdJ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdBJckGqtCfAz5vslGui4PSEj5qdRuxtTBdYZidH2QBEDYL2mrGhSn3HxRJ7nvM30LcciBBDol/pg9f9gYiVE62s4CZX2Cnx4X1MoWplS24ydg/mL499Q3zsdIQRVkKPVn82YG+p30w1dy5vlGTJMGrIc9SwIufR6v8zHE5YT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=d3vNdPBG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5171a529224so2206835e87.0
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713014951; x=1713619751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/sWcSLhrZ2N7z+BD4safYiDtjAH5nTepb/6QB7CjCtY=;
        b=d3vNdPBGYLLctLp4NP2h/GjzS66bVp4JqPSvc3G+Jko8EVqo85luglPkgJ7FEchZ9h
         X5e3sutma6ghpj3N2KQqr+TLrDQBBDIKfj4Ry++jXZR9Us7fus9QrTG/+ZmsC60mC9G3
         4M/VmTMPzsxeiy8HtefT5HyCHsnvS1EfoebqvChq5YxImBZ1WalXwUd37wQTPpuBOrkl
         caRWqrMOWQip/NDHdvcRpwZQxxaXpy36wR4MrxY9QenWrbUu0YtFgiNti0jP0lCPu+dk
         jlb6gjp+0feJmj4eajN6u2mCihM+Hjc9pkTQ1WrlALR+8Zw/riNDUrz7GFxJ6y6lAdVR
         8TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713014951; x=1713619751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sWcSLhrZ2N7z+BD4safYiDtjAH5nTepb/6QB7CjCtY=;
        b=MkpIOg0SwcY9vVCpQjMFPcUAimwY85aBFhXcQoVYzH4cQN9VBTOS/hLAdM/IhLKuyC
         unFYzC+VY2vpOYrMVQG9FDb66OAMHXKCydq0YLubAADfUY5VAl7RdxIyG55gRg4PXpVw
         N25TSYrxBGY5/HjdS+VTVSwGlgvCDxsoRZ0MQdTlOSBp1/5SV5sZCpKxhqJyQN+q6gQ+
         Ss7JZYMhKa0hwCCfcr/bR7Wrn8Nksw37JN48Yqzo8tzlZnwnFCjl3gW+7o2c+HOKHCRh
         obQOybPcguS5Ai5nu1cIPOTu0dgRjr6vUa74A6XeEMw8NtdI9i0ciT+3ZYpOTC70JqZw
         dc9g==
X-Gm-Message-State: AOJu0Yzvem8bfXZg3wNU0dDPDnPrPtC/9g/m8QhUaq0h/9G5WLnKtZCc
	FXDoQkv+KJH0V2D77pB28Yq22iM4Yv+caMZ9K5OhQoTIchKelEVrsi83mD10X24=
X-Google-Smtp-Source: AGHT+IGsnPRAi7TPtmzYtQAk/aBXjwsk4UzObITwkTK+3+FJ6lQdGsbZc1s1R0QpGxH7YsJDy0+ZJw==
X-Received: by 2002:ac2:5bc4:0:b0:517:88cb:ec02 with SMTP id u4-20020ac25bc4000000b0051788cbec02mr3234945lfn.42.1713014950602;
        Sat, 13 Apr 2024 06:29:10 -0700 (PDT)
Received: from localhost (37-48-0-252.nat.epc.tmcz.cz. [37.48.0.252])
        by smtp.gmail.com with ESMTPSA id h6-20020a0564020e0600b0056fed5286b5sm2317685edh.55.2024.04.13.06.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 06:29:10 -0700 (PDT)
Date: Sat, 13 Apr 2024 15:29:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 5/6] selftests: forwarding: add wait_for_dev()
 helper
Message-ID: <ZhqIpIF5N1ESWgON@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-6-jiri@resnulli.us>
 <Zhmc_KsL__7noHWZ@f4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhmc_KsL__7noHWZ@f4>

Fri, Apr 12, 2024 at 10:43:40PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> The existing setup_wait*() helper family check the status of the
>> interface to be up. Introduce wait_for_dev() to wait for the netdevice
>> to appear, for example after test script does manual device bind.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 959183b516ce..74859f969997 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -746,6 +746,25 @@ setup_wait()
>>  	sleep $WAIT_TIME
>>  }
>>  
>> +wait_for_dev()
>> +{
>> +	local dev=$1; shift
>> +	local timeout=${1:-$WAIT_TIMEOUT}; shift
>> +	local max_iterations=$(($timeout * 10))
>> +
>> +	for ((i = 1; i <= $max_iterations; ++i)); do
>> +		ip link show dev $dev up &> /dev/null
>> +		if [[ $? -ne 0 ]]; then
>> +			sleep 0.1
>> +		else
>> +			return 0
>> +		fi
>> +	done
>> +
>> +	log_test wait_for_dev ": Interface $dev did not appear."
>> +	exit 1
>> +}
>
>How about rewriting the function to make use of the `slowwait` helper as
>follows:
>
>wait_for_dev()
>{
>	local dev=$1; shift
>	local timeout=${1:-$WAIT_TIMEOUT}; shift
>
>	slowwait $timeout ip link show dev $dev up &> /dev/null
>	if (( $? )); then
>		check_err 1
>		log_test wait_for_dev "Interface $dev did not appear."
>		exit $EXIT_STATUS
>	fi
>}

Sure, will redo this. Thanks!


