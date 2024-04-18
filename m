Return-Path: <netdev+bounces-89168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320F8A9969
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8831F21801
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612615F322;
	Thu, 18 Apr 2024 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="E2g8aTOR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F7E15F3F9
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441692; cv=none; b=Zxtv5MNewLh6kNvhUIU3hB8ddF2rSpE8TWgGVFlO4yDv3fPwlgg5FJ1WpreE0EFpDojI5RgyW9v7/jUtn7rr+ks7EV0xTRIOV3ieVDBXxF6HDs7nq3CSbWsrhOGREFQyLSJg8KV/oKevCjPRFPUBcp5nEUk7cWpG5wvBIuoH+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441692; c=relaxed/simple;
	bh=fVrTKiOn5uwYp9pqQv/ZPb+GJYoq6Poa9VPpujFIX94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuUTJS9Fm3Xu1asW3F95kNcNsBC3RCKO/+iQ0jc1dR32mgpFiyse7lviKh6VeIIz4dXFMh+AF2n94RFkf53ZGnHb3w2lZXBqF5GoevOL7YH8jXyu8PTC9ObUdbDzOVBxdPZVlWCBe+kZMV8DwTCm6jpKk1diFai3wAKoGFQWG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=E2g8aTOR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-571bddd74c1so494010a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713441686; x=1714046486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMpzycIzCpjrOrH4WFcDDQP42P8HzuPiF7zvkcJLpsw=;
        b=E2g8aTOReR7m0Tau0LFhPA7f1XUROu0FedkbbNyY2cA2lPSXhSqrysCBnLAN+W10iP
         +47DX78P9k9J+yrie1fB/HkXkB2ZYcytilhdOelq4lCS6d9o7AtC2JuwmWMg9j8SOFNK
         aqRbhNPi5Zio5snMVwon0S07A6QIdCttVGohr5O6gdn9CZKQUJ3wZBvH3duLjnFRMCg4
         BmT99YOcXFeGajkeaw5St2oGgNLr3s3clddssDqHSsybpo69wbqWiEMAEHHkj5V7ZdBD
         9ErkbDfr+JxrNZuc4078NAzKveKxrJn5uS6AMds1qe5GKAbqKEWDSX8A9HWDeFibNqLG
         MqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441686; x=1714046486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMpzycIzCpjrOrH4WFcDDQP42P8HzuPiF7zvkcJLpsw=;
        b=WBSG6epwTdebOGfHjipvFfZjjFyet4YHojqqxbxMLWvqPhWV9B6v6IeKXtl6er3fgo
         DYipJWRp1PCxJMhX6K/BNGawDEzD5VYGfv3ffMRWHi+yc8ihRpjaKBYxogQ+9wycqfus
         SdZVr5BXxb8INosa0uL9gMYyI/dfprmonHc/BpgL+FImoL4o+cc/SrJN13kewEAFckhh
         Y9PADEA4mpTdyMS6JUoXMci2jdy3Rv4k1n6V/orRSJZQ3WmGkZnOo6FNwbtiouUov/PB
         Atl/WsEYYXtNphIEqqAXXHbHtiNK9M8J0va1CcWI5ive1kpW1E+DjWhE0/hoIJuJDKM1
         vzqQ==
X-Gm-Message-State: AOJu0YxZLHnr0q/kKCrkKTxYQ1BID2Jn3wPjUTZwaYu1ahtqNNrriepf
	UXl685XsKJaCQawA0bD0weDub6/o9pHR9zbJDrP4b01xYNJdYVrA6E2I49e3Pn8=
X-Google-Smtp-Source: AGHT+IFbucxxkcsWN42LkuhAJt551MfeNbGoUIU2wWgxXl2gs2XDgp3EXFJ2FGetwBHsg9OG55KB7A==
X-Received: by 2002:a50:f68e:0:b0:570:5b72:164 with SMTP id d14-20020a50f68e000000b005705b720164mr1787321edn.37.1713441685468;
        Thu, 18 Apr 2024 05:01:25 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id fj17-20020a0564022b9100b0056fe8f3eec6sm759931edb.62.2024.04.18.05.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:01:24 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:01:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v3 5/6] selftests: forwarding: add
 wait_for_dev() helper
Message-ID: <ZiELkw051EsXrraM@nanopsycho>
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-6-jiri@resnulli.us>
 <8734rjcbkq.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734rjcbkq.fsf@nvidia.com>

Thu, Apr 18, 2024 at 10:33:13AM CEST, petrm@nvidia.com wrote:
>
>Jiri Pirko <jiri@resnulli.us> writes:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> The existing setup_wait*() helper family check the status of the
>> interface to be up. Introduce wait_for_dev() to wait for the netdevice
>> to appear, for example after test script does manual device bind.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - reworked wait_for_dev() helper to use slowwait() helper
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index edaec12c0575..41c0b0ed430b 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -745,6 +745,19 @@ setup_wait()
>>  	sleep $WAIT_TIME
>>  }
>>  
>> +wait_for_dev()
>> +{
>> +        local dev=$1; shift
>> +        local timeout=${1:-$WAIT_TIMEOUT}; shift
>> +
>> +        slowwait $timeout ip link show dev $dev up &> /dev/null
>
>I agree with Benjamin's feedback that this should lose the up flag. It
>looks as if it's waiting for the device to be up.

Ok.

>
>> +        if (( $? )); then
>> +                check_err 1
>> +                log_test wait_for_dev "Interface $dev did not appear."
>> +                exit $EXIT_STATUS
>> +        fi
>> +}
>> +
>>  cmd_jq()
>>  {
>>  	local cmd=$1
>

