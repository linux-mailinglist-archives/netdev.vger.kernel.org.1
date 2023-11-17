Return-Path: <netdev+bounces-48525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D167EEAAF
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 02:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901E5280EE1
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 01:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C54D111D;
	Fri, 17 Nov 2023 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="XvbhMbyo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEEDC5
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 17:27:21 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f055438492so788745fac.3
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 17:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700184440; x=1700789240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aKf/LZV/kvSMDigtlOXJdd990tp8RAjm519fFm7u9Sc=;
        b=XvbhMbyotVUY7kSB4pm2wrtlQnw9iGsTbTgHT3tu92ZOA8QmwwlgRVtV1DBB2IAHll
         tnMHrs7fck9cNJB7ePEo7xvAnsiQMHQFAUN3njz+CwTd2uYfMAuxTvOJHfKE/elR7VNU
         caJD7CN+zD8uFSJolo8EPV6/4E63D49upO7l1bHy9+AkUQ6wR3x24gOuVwTS61yjt4aE
         EKPaz7pMnghMLvJ68YHHr+rhelx2y6O0JIZKnsjiwJU8PLl+ZtkrFtUNBrHfi8K+A20i
         3h099f7fexEaKe5jORKvYM+sR2c2ZHO8H/3juip2p42lXhAq4IQcg51yJDdfuRRD7r/v
         G1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700184440; x=1700789240;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKf/LZV/kvSMDigtlOXJdd990tp8RAjm519fFm7u9Sc=;
        b=m7CzVksoJ3gIdJ4rJzHLD+you5EB5j5jy0EDl0xD6MpExPMx4pJeA5zD2qEXedPI0c
         LwUJ+F4wSvFeeeYGa7+MNIuDg/+Y2tZUZFvxS2ObSeTmUzvU1IPznM0sATrqwcMRLPKT
         ZUTIJMLd2AHfjGUyYIxt7UaCWs2bLoEYE2OpaDlfzAwnclhqQyubjMm4FghbH5sjp5ef
         CBwT4FM91dUOAUZ85eCxGyB5w56QxWVCF8p7Pqeu0l2weM0G+d18mPXb38v3WYJ4YdJZ
         ZC2T3QqiLF4Ty03XeJHCJ/3lO7MPnhf7P9d0/dEK/IGPAAWcQQMKRkR2HI1aDsdb0wgO
         oMgg==
X-Gm-Message-State: AOJu0YxbkjVVeMI7M82c856KJKszITHkLjkYyw+lfWhtvt5YPIffqru9
	ZIVRvzJHvNZOXD8C61yA8CdaUg==
X-Google-Smtp-Source: AGHT+IHe+gWJw0AKxuVcbBIXwt32o0SzEtp1hkMypo+gLCWDCnHgrd9UcktssVj7AN6A8lUEGQalJA==
X-Received: by 2002:a05:6870:d210:b0:1f0:630c:a58a with SMTP id g16-20020a056870d21000b001f0630ca58amr21197727oac.51.1700184440236;
        Thu, 16 Nov 2023 17:27:20 -0800 (PST)
Received: from ?IPV6:2804:14d:5c5e:44fb:7741:c354:44be:5c3f? ([2804:14d:5c5e:44fb:7741:c354:44be:5c3f])
        by smtp.gmail.com with ESMTPSA id y19-20020a056a00191300b0069ee4242f89sm372131pfi.13.2023.11.16.17.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 17:27:19 -0800 (PST)
Message-ID: <8c0bc61e-c0f1-49d8-8696-812c336fb74b@mojatatu.com>
Date: Thu, 16 Nov 2023 22:27:15 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [selftests/tc] d227cc0b1e:
 kernel-selftests.tc-testing.tdc.sh.fail
From: Pedro Tammela <pctammela@mojatatu.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
References: <202311161129.3b45ed53-oliver.sang@intel.com>
 <f9f772dd-5708-4823-9a7f-20ae8536b5e5@mojatatu.com>
Content-Language: en-US
In-Reply-To: <f9f772dd-5708-4823-9a7f-20ae8536b5e5@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/11/2023 11:16, Pedro Tammela wrote:
> On 16/11/2023 03:42, kernel test robot wrote:
>> [...]
> 
> Hi!
> Thanks for the report.
> I'm trying to address this issue and others in this series:
> [PATCH net-next 0/4] selftests: tc-testing: updates to tdc
> 
> I have seen this timeout in other CIs as well, but I cannot reproduce 
> locally, even with the CI build running on my laptop. I did notice in my 
> local tests that KVM is a big factor for test completion, so it begs the 
> question, is it running on a KVM enabled instance?
> 
> If there's any document describing the runner instances I would be 
> interested too.

OK, I was finally able to reproduce the timeout.
I have some fixes prepared, will post them tomorrow after more testing!

