Return-Path: <netdev+bounces-53011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457AC8011C4
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7364280A61
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712364E1D3;
	Fri,  1 Dec 2023 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="cd/J7M/B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B221B2
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:34:44 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cdd214bce1so2364130b3a.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701452083; x=1702056883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rzgg+qlCFJsDfBVcMk/HkNOAyNWDbZciDHUMZUKcrk=;
        b=cd/J7M/BOU3CDlrJuiDuH/M/XGieUnPkdWm23/5C8t6HHCCapNtMqgetZnuZVT2UvU
         QIl+ZDG5QEzSVoEDrVSIyPu//R1f8hATE6Gfd4CEAtzBMxuES/Kd2r/gxPoM+kHeri91
         pEdgDJ5YlqpwAXYT15hqn/fWRWdwinHrZfl8vAMj4NdYE/5rxKqraCvceVAXYVsQIcXn
         ywxMNo0EtxkVJWVoNCI+0Of7sqCRxy7ipm2oz5duU1EGVSSucCE6SpjQdrW0ljeqE4Qg
         b33grNCoY2pHTLnElyejB0AyCeRUqYPWl6lxjAvQSAX5fqMEDsmjG1Tmp6mNCO5R/2vH
         NwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452083; x=1702056883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rzgg+qlCFJsDfBVcMk/HkNOAyNWDbZciDHUMZUKcrk=;
        b=vIuFIfhNTCkmm/PFBMHSrtyLw6eU3TQm6Ucghpm5MIRh0FnPYBNjJaMNNaU6c4hk95
         Bpx03zTBucsYQ08AinaCiB0PwR8GsaINiIU22H7aRqDD3/Y+JY38iXX2QDf7hEDK/7wZ
         LxpAR56G5kI5eiJP8GV+XabxaBzULxzyHKcbUu3SmVIGlxWCNn8EFT8HymyR1pJB5uUI
         79bNv1qO+E9WW0wjC2PBGFsd9+jBomzD0snkZ1+fkU5B/5RB4fcEAL7DSNtwe6fD4Y7q
         W/8L1N/wbyInSVSmeUGXRHvbhVNI5FE60kOCFEz67LV+3yNRZWRyiYplSNa/hP+p1sGu
         V/Xg==
X-Gm-Message-State: AOJu0YyvqWnsra6J1Bd7MxrGKXQfFNNBJxuRzDddPPnvPNv5Wjn8bDfB
	vVLohe4+/7UPcGwRQO7hTR99ZQ==
X-Google-Smtp-Source: AGHT+IEvQAUHV/+KLez3XRzKDFMYbnItJFOxTWPWrctaxAVGCvNdEkuUSt8aO31mshTIT172FoVv2Q==
X-Received: by 2002:a05:6a00:e0f:b0:6cb:d2cb:5234 with SMTP id bq15-20020a056a000e0f00b006cbd2cb5234mr30155002pfb.32.1701452083532;
        Fri, 01 Dec 2023 09:34:43 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id h9-20020aa79f49000000b0069323619f69sm3342858pfr.143.2023.12.01.09.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 09:34:43 -0800 (PST)
Message-ID: <89fccc96-dc62-44b0-b329-82e5d8baf21f@mojatatu.com>
Date: Fri, 1 Dec 2023 14:34:39 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net/sched: act_api: contiguous action arrays
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, mleitner@redhat.com
References: <20231130152041.13513-1-pctammela@mojatatu.com>
 <20231201093317.017c6424@kernel.org>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231201093317.017c6424@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/12/2023 14:33, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 12:20:37 -0300 Pedro Tammela wrote:
>> When dealing with action arrays in act_api it's natural to ask if they
>> are always contiguous (no NULL pointers in between). Yes, they are in
>> all cases so far, so make use of the already present tcf_act_for_each_action
>> macro to explicitly document this assumption.
>>
>> There was an instance where it was not, but it was refactorable (patch 2)
>> to make the array contiguous.
> 
> Hi Pedro, this appears not to apply.

Oops, will respin, thanks!

