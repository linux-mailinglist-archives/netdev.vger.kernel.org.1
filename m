Return-Path: <netdev+bounces-90457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA3D8AE33A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75FC1F22D23
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548E664CE1;
	Tue, 23 Apr 2024 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="enoOMfSv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092964CF2
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869951; cv=none; b=jXOlZukdlEu5GcECDbxMAbH0m+YYvkC3LJCxo3jXF0PLtYPmUxSB+80BE2zQ6zmMUIclUcs8m+4jEK3bf5naorRI0an1lAoLGPa77CbagO8R5q357ac+UK9AU9M/93nfq4BOblo61hYbnEvS6zdub00Rt/4PpTsYaAIN/VHJ6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869951; c=relaxed/simple;
	bh=VCIM8fphpg2wx5wS1Ev8Yru7L2gGj5YRS2RiKLz4gO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+oafbEADWRW8TrFXNV/MlDyegMatYkTEEdAziHXxYM61THJh7340+Sxl85aUa2h4R1qF/yY0z6f4XAqgXTPsY5Y9DTOOwzLdCgXuhK6OEZ37bljdlgXXJui8MJ4uad2a/EgCrjvMhuX073t2ZvVrqJGe6oVKpHQ9VYq5h/P93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=enoOMfSv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a442c9dcbso16450325e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713869947; x=1714474747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9eYSffLutyekkUg16FuXfR9J3J44OlThKKHWZXllQ8=;
        b=enoOMfSvTdCGk5ZWUXnWtyhFFwzq5fqJWlf0/SjtU81ls06cPQ+3Z830nYKIt4bnP2
         PG4eWRHc/LAbFFn74qW9ThC6f4TCPY7s1xgBAHpiBLPUkxss4K4hA1LE+O/c3RSe8Sc/
         JwX8JcWOpyxguFZJa+uO+mVkYk/gaS2/lbmp9t1lsGrPTtj6tbGAz57JhsZPnYcQmlRs
         RSCRn7DhKK0Zha48H6Ef7qZb5uPpxkzKGh84kZxNGLK4kziFDGPesjTPMAcDvXqfkoIb
         nUh6oi+5doO0kwTsKAZGKD9RCpuzWX70ifMbKLsrkqboi4UURo9oAhcWedQmlv1VHnx4
         qJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713869947; x=1714474747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9eYSffLutyekkUg16FuXfR9J3J44OlThKKHWZXllQ8=;
        b=YPZ1IzEIAt2zRkGROosufi5Hhhh2qlJQWSEkocOZXPb3f/7VYEJDIopHZrWNwk7yrH
         Bohz2+oq0RQYXGTuehpB/EjCql0vZFP9kBiW5dbnmrWOZrUci8VJfz4m/YNNHt8LYiOU
         jGdwGV3tEyg4pBbPHSNpoXoOpwJh0bD2gDWl9fKMek0kzw7QpgnRUStDNcOd5tg98/VP
         WPhbjEujUoKWIjm7ciKzVm5gbpCmW3G5fHdu/8qanmriRJx8PJI+/tG8mdSlQF3Tyi6x
         JPD9xPc3z6FDN7kM7aYURBjo04qAwndgjeOZoGUfHK2z1zveV9GVGc66+B7TNukrhWVT
         IHLQ==
X-Gm-Message-State: AOJu0YyGWLYDHfUd88qwmuWRM9ia3lRDOJ0FVQ/EE/EdBsDEHepFbpdn
	wkDnlOgS180RpL5MU4+y7vAz2ZblLRivlXQJ48bzv1sjshpewRbYa6+tYq1ZTk418b3WNCoWP9e
	N
X-Google-Smtp-Source: AGHT+IGOlfmMGQYqlQ7v0Cu9gVXAoL7wHOkkoQIclnh6f8TpYdXA81OomiP0mJ8qvvgvGacWsTBnKA==
X-Received: by 2002:a05:600c:4508:b0:418:95a1:1975 with SMTP id t8-20020a05600c450800b0041895a11975mr9197041wmo.20.1713869946943;
        Tue, 23 Apr 2024 03:59:06 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b0041a81ece2a7sm4800735wmo.19.2024.04.23.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:59:06 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:59:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v5 3/5] selftests: forwarding: add
 check_driver() helper
Message-ID: <ZieUeciv-0dmmPLQ@nanopsycho>
References: <20240418160830.3751846-1-jiri@resnulli.us>
 <20240422153303.3860947-3-jiri@resnulli.us>
 <ZiawyyOY-6radvXV@f4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiawyyOY-6radvXV@f4>

Mon, Apr 22, 2024 at 08:47:39PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-22 17:32 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Add a helper to be used to check if the netdevice is backed by specified
>> driver.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 9d6802c6c023..00e089dd951d 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -278,10 +278,17 @@ check_port_mab_support()
>>  	fi
>>  }
>>  
>> -if [[ "$(id -u)" -ne 0 ]]; then
>> -	echo "SKIP: need root privileges"
>> -	exit $ksft_skip
>> -fi
>
>Why is the check being removed entirely? This change was not in v4 of
>this patch. Did it happen unintentionally when removing "selftests:
>forwarding: move initial root check to the beginning"?

Oh, a mistake.

I messed up the v5 submission, repost couple minutes ago but I missed
this comment. I will send v6 tomorrow.

Sorry!

>
>> +check_driver()
>> +{
>> +	local dev=$1; shift
>> +	local expected=$1; shift
>> +	local driver_name=`driver_name_get $dev`
>> +
>> +	if [[ $driver_name != $expected ]]; then
>> +		echo "SKIP: expected driver $expected for $dev, got $driver_name instead"
>> +		exit $ksft_skip
>> +	fi
>> +}
>>  
>>  if [[ "$CHECK_TC" = "yes" ]]; then
>>  	check_tc_version
>> -- 
>> 2.44.0
>> 
>> 

