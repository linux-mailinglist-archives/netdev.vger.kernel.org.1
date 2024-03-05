Return-Path: <netdev+bounces-77613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE09872538
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFB81C2317A
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96410168DD;
	Tue,  5 Mar 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWvPaq8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AA614AB3
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658514; cv=none; b=lCTtPj02nC+bG0mOt07V7haoT7NmR+xiCj58gKoW2hm7HGe9nnpG80lAh+V7iMM1zb7T7BPBC8ASSoGy4WllwNcUsu/cZbuy3JwrIwCmdlLcQzyUdRQQmH7PEuiNKeZioST3ATbdYMT5ocPXAXZNAuwiCtMC855mWE9zrqaaq0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658514; c=relaxed/simple;
	bh=6jwQB8Y6IiY4eCuttseI27upLgSJv1woFbmU/Lxyn4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFg9eTHEC/Rk0zjETUUtqZ+hR/2dygF1Z3eQ1GEAvVjPf3mXFQtoJGicl5Wk3w5ek7Qa/B74IrHtqYkEfMF3s04+KUPH2OhDtSALIzIfvKSQMJpNkP31AD62dgEcYeOGmAjvISNxpGTRZfSfy92fjmLpCROl/qD6kTyo39EORy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWvPaq8z; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-608ceccb5f4so38648707b3.3
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 09:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709658512; x=1710263312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGs+7fONaVDIo9pslbI2FhOqUJS8wpFXcU4sPaUp7bU=;
        b=SWvPaq8zzT+J7z5thVoTr0+d9E4c8RSfbCZCSD1/APENhPxw1nkhIprlNf3xmkAUpR
         5CNR25W/b9+yQwzMBewtvY38yL1tY5gUnbm/F5wZZBQC5o2wMp+L2sfg21D6S3RYcsxs
         2++ac5027e7HMCCWhvhg1lISolfd/wItJkbTUtJaZXInX+E0hiZrblwcl2EPIYwsMwfX
         BbIAFuCjeBszenPIGNbXy5PMb9LTKPzbu0ISZJzVPqoOPeafailbXB4jYz0IxBT+4/Kk
         my6wIb/IcoIEkwKBP8kFoS/HiKu4qmJahDMd91XWB/sRVRfzI4+FjB9DZNBlg1PYdZCh
         EI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709658512; x=1710263312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGs+7fONaVDIo9pslbI2FhOqUJS8wpFXcU4sPaUp7bU=;
        b=IGPtxhaxfrCgmW+eCdUei2jrI3IZB2119aG+w4YPwxeV374oCLawePj3BudcEkA919
         /KKoWLhDMsz1jd/IXA3hIpXVr32hVjuC+FZLkTdvT3cz0j5PoohfKw6lCcH1340EhEuF
         x/TWkrpVWZgTCFYZVQ9uZsRfvJFDOnNUOCMvpGbcaEsXyWX1gew5rlmtswhQEonmoJmS
         jr57qvBbkeEx5hy8rgEITBRhMG0bvmnTZ5cDrI8+PmS572eump066mgFMGvGpbTIECyW
         IuQoRTlokooVlHhm8SWLiuVA2dZ5LrBM7qGfBJk34O3ahR/JLGig+doksAxtB8ujsDEx
         RRoA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Rz1qvkf/Ahiw1BPvt/MVjpChPppTDm49+NHYEBusJLmX/aNyBnmA4U8rboDu9014u2hC3S3XcwLRB7zWj1tPpUmTVva7
X-Gm-Message-State: AOJu0YxIJWx1uBkkCEUC+VulTM+wEmWSfzzjL8nWWn/uGG9b1QSz+cmP
	aBIXbUXN53EW5EVyw411ukpxJf8ziePVATPlJJfmmOCon7YMV4AG
X-Google-Smtp-Source: AGHT+IHFMEg36ig18eQ78UjKx2uY9ItnJesEhiWM6WGbx18hiNgslASx6gKNikkS5+Kpizpx9z8nIQ==
X-Received: by 2002:a25:9748:0:b0:dcd:5e5d:4584 with SMTP id h8-20020a259748000000b00dcd5e5d4584mr9488142ybo.34.1709658512016;
        Tue, 05 Mar 2024 09:08:32 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:17bc:ce67:1bd3:cddc? ([2600:1700:6cf8:1240:17bc:ce67:1bd3:cddc])
        by smtp.gmail.com with ESMTPSA id l2-20020a5b0582000000b00dcd56356c80sm2603390ybp.47.2024.03.05.09.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 09:08:31 -0800 (PST)
Message-ID: <5232b863-4c1a-44bf-b55c-920031d264d7@gmail.com>
Date: Tue, 5 Mar 2024 09:08:29 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests/net: fix waiting time for ipv6_gc
 test in fib_tests.sh.
To: David Ahern <dsahern@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Cc: kuifeng@meta.com
References: <20240305013734.872968-1-thinker.li@gmail.com>
 <99f281b1-76de-4a51-a303-1270ffb03405@kernel.org>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <99f281b1-76de-4a51-a303-1270ffb03405@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/5/24 07:38, David Ahern wrote:
> On 3/4/24 6:37 PM, Kui-Feng Lee wrote:
>> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
>> index 3ec1050e47a2..52c5c8730879 100755
>> --- a/tools/testing/selftests/net/fib_tests.sh
>> +++ b/tools/testing/selftests/net/fib_tests.sh
>> @@ -805,7 +805,7 @@ fib6_gc_test()
>>   	    $IP -6 route add 2001:20::$i \
>>   		via 2001:10::2 dev dummy_10 expires $EXPIRE
>>   	done
>> -	sleep $(($EXPIRE * 2 + 1))
>> +	sleep $(($EXPIRE * 2 + 2))
> 
> define a local variable with the sleep timeout so future updates only
> have to update 1 place.
> 
> 
Sure!

