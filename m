Return-Path: <netdev+bounces-96290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF30E8C4D41
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE9DB20B25
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C314277;
	Tue, 14 May 2024 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="jzDENsd2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88BD13ACC
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715672780; cv=none; b=t2sPeGzYPv/5rl4fdEZDk+CPqneFGeb7NmU5FPohtwt2H8F+UJB8IzM0ycbqA2KkvF4SyRxqIgjuKBCD4rmRoRiR+73cvZdKOONWvqsTM4A0DD3NMP6uu1YxfObbf2pnAcLT7xNMyL54HelJeOV7Qttu7/kN7gPW1QSYUIe2Y2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715672780; c=relaxed/simple;
	bh=TI7CuHv7Bc8Mde29ebJ3dkKcJVDO0enjEg10beUDF1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Soynob7XNzv8dHIjFqkzxzBc1oUfDgxShYjXPduU2bV/F30uMq1CjuJAxO7cKv9idIyfPH7yh4WgRK16DPtSADbkOQRU8mGAR37W3Gs8CM0TFfsSMPaIIqsBkYXjCt/WHErNU3n0kFr6dMOXsss/61RDTBfB1t1R10u9BzMiq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=jzDENsd2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e0933d3b5fso78757511fa.2
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715672777; x=1716277577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oh4KgwiBO6fXkK0I7THVbAVuWnA2rhOlc36ThKqDO4E=;
        b=jzDENsd2i/pjeKDqoSVFiLPBfr0/qalHtdsQJZsswF/Xg+M7kjXTCLRp85Pj1B5q+5
         waSCaIHpgB+FiFrb7wcx/vQGUx/6FYmZD2RqYm1kjYZYE7jGaurIJ+wByXax6a9f3MQf
         HvZ3zfcrQOH37p3GpZLM9gaDZLXvk/dosbbKP25Xdn+ofzFWREFFciY0nYu/aQnCFAla
         SAFa+JBFW6yCpDqSsZhAZwVBkGoSTuChTSDqj5zZb4TAl5zey2lDVo7VMGlIRdKOA5kr
         7XezNCzImbieVPTo/qCOg38TrgA2FVQECZjTbeMIAjDdeCldZoY7j9Nw7S1TuA5Mf/3d
         ireA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715672777; x=1716277577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh4KgwiBO6fXkK0I7THVbAVuWnA2rhOlc36ThKqDO4E=;
        b=TfawhbSTdpL25Wou3VYEL0kkuDN3sU1ZVVs3Aq6dQehyRwg0o2QT02LuJiGbIImeM6
         vB5dhkC1F7B5hpNNAHt2VBLyn0L9zJPOYeAzlXEIzGoWbsTGynIbL8T6NDNkRAdUhOBk
         h7UG8g3ltdFrx76HgNKa4h8Ropo9VTAcC99F034wuQp6iuhBO7AMBQTvoK0XouHViJ7Q
         4ennhWj7Y1nkIBbaoLJHYhwIG2W1tzgTBmIViXB2FdcaArsP2qiFnn05mnSxxH9G0lzk
         5Po4Sp7nRQrMIAw1V+Yc8qr4NDiOP2LVqYtpSuRVf85e2LqCzHtcr5266Pd388SRdFCc
         Q7EQ==
X-Gm-Message-State: AOJu0Yy7ueM4oYfAPw7d8vwnshRyCxSwoo8cBuZ+onfB53HNn/YP3LXU
	J1Y4T69PcW4Dvt1DA88JCFXIiNUHJK8kS3Hy6iS/L9nff0KWVN/YCwca8XIDwYQ=
X-Google-Smtp-Source: AGHT+IE6axpZtcVur4TM4/t0tdWY/ue3itmUJ3ARJHqWpp7ofCKUnixF9GDsVa0PpM8niYm+DeWWyA==
X-Received: by 2002:a2e:730b:0:b0:2dd:409:3b25 with SMTP id 38308e7fff4ca-2e51fd42038mr82575501fa.4.1715672777029;
        Tue, 14 May 2024 00:46:17 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce2449sm185175325e9.16.2024.05.14.00.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 00:46:16 -0700 (PDT)
Message-ID: <186278b5-b2d5-408e-8d89-8cdff6efe41a@blackwall.org>
Date: Tue, 14 May 2024 10:46:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: bridge: increase IGMP/MLD exclude
 timeout membership interval
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, roopa@nvidia.com,
 bridge@lists.linux.dev, edumazet@google.com, pabeni@redhat.com
References: <20240513105257.769303-1-razor@blackwall.org>
 <ZkKzcJm5owdvdu6B@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZkKzcJm5owdvdu6B@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/05/2024 03:42, Hangbin Liu wrote:
> On Mon, May 13, 2024 at 01:52:57PM +0300, Nikolay Aleksandrov wrote:
>>  	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
>> -	sleep 3
>> +	sleep 5
>>  	bridge -j -d -s mdb show dev br0 \
>>  		| jq -e ".[].mdb[] | \
>>  			 select(.grp == \"$TEST_GROUP\" and \
>> diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
>> index e2b9ff773c6b..f84ab2e65754 100755
>> --- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
>> +++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
>>  
>>  	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
>> -	sleep 3
>> +	sleep 5
>>  	bridge -j -d -s mdb show dev br0 \
>>  		| jq -e ".[].mdb[] | \
>>  			 select(.grp == \"$TEST_GROUP\" and \
> 
> Maybe use a slow_wait to check the result?
> 
> Thanks
> Hangbin

What would it improve? The wait is exact, we know how many seconds
exactly so a plain sleep is enough and easier to backport if this
is applied to -net.

