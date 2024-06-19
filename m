Return-Path: <netdev+bounces-104730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6B990E2FC
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659BC1F21E75
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 05:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5028758210;
	Wed, 19 Jun 2024 05:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JudiA6O9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6253974045
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 05:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776726; cv=none; b=WbQ6bDV8ydm3Iy7Z/kfSRHNvP7RTxTCtqwcCrd8GTIc8WfFDgc3NhnJ69Fz2EsPtv/NHPW5Gfz4jNfLiZmCRtb3yECBT7xzmhAGA+VsxmfRnT7OZikDFtXlwd9oPvvUexHIwBTdbrWy97mhtiB0S+RsW5YgLGB7MuNli2ZJHkQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776726; c=relaxed/simple;
	bh=mKvuypwCg2ysIfGkZf48X1S/ES+lND3K9aArWWi2FxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+ntOe17nzXXHUwqrn1cAn06ILlCcZbQq6QgpSIIvQZvnmeVzgf+VvelxOezAXuedLufMQggL6QswWs6tciMYIGu2J/KtD1NN+Ii1PWsG75iR6sePV8ZHzyf6IENiaQ0pC2/iNVn9Pv39jmyH27rveR6xo8oY8HB9pwsBT/FXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JudiA6O9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bc274f438so6633296e87.0
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 22:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718776722; x=1719381522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUrgFPeLrIDba2V4vEREK/w4kbGZdOYeF3AUhpKjXrA=;
        b=JudiA6O9aHA/4yxSON62yIValbjCOV8xhpqWIGFLCCko4zD+M5obBQ+MdsHmsx+p8t
         +miQTXW4BpmKEUKd4odCcluzLl4OeQmHdfyY1JCFKcyQelMM3DrIQ9Bd0mZWSHW2WQ0H
         5ePu+bjHbh9gwoOTVx84m9hW8vwVZB8apldLrL0G8YY0IJWYXk7rhByC8+gcazHzR4I2
         RHX+a4FNqLRbrz61Bb5iuVrrGNUHWqiKXY+OVlUYvb+3UkvloqJH6tFOms3nCTdJci+e
         MuVgsS13aYqsz1y1bAGJ752Ht4dELtb8JC0usuR7p6/m9int+MAL5Jw9IrSBxcFYb5sF
         Xo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718776722; x=1719381522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUrgFPeLrIDba2V4vEREK/w4kbGZdOYeF3AUhpKjXrA=;
        b=cqEcK4PLMV3TrgXzWnkwjnjVvozgHNASUi6yMloUhpO9i5RtKwO9P8ORJJdSXfepnW
         sk3Bc9w+ooUac9OO3mg2K1vcvi1MqU8JK6D9dIqpfiCWBnIjvxg8f+FeLl+7oT97Wqs2
         wiVJXNjBtcHBATyOijTaIoQBZMvifQeaaWej4cBFnXfI8Q828jnVMZmbZD0Aejwt4tib
         zsrYE4k45IxnEf9mhXXNMJ7Douqw8eJOT7xkc1Dw9LNds4ZpDdPTeto3Pdykusq00wif
         qSMyKG4+nbRnfgqiJH5cKQE+jvKhpcics0BVG5EAk7xeFIHbvnNOCeWtn/KENd2FyJQS
         oBTw==
X-Forwarded-Encrypted: i=1; AJvYcCVIZ+/c+dKWd8/0sUPerR9KipN4mhyjH4dRu7STyjGe6Rq6nsl02KmonKvjqcy91MWq+gt0q1q2O/jyMLSUK9cYuvE+1y1V
X-Gm-Message-State: AOJu0YxVaPcvwY5KW22ZeBNzw5ncrypz98fPvC2C3pnbcUkBdyMVZOzS
	ckPtakZ67EEb2kggmHK4DS+EbCezXNjMvsb4N7nFpROc2ROWZy9fNAYh4lRXSVQKJmtGnV6KdFL
	m
X-Google-Smtp-Source: AGHT+IE7uiz9/1JMbsryvL2gDZGLl69uvIT5rVUtc9yz8grm5C5+b5dfv6zEkeITTyX4N87/UHuvJQ==
X-Received: by 2002:a05:6512:15a2:b0:52c:8339:d09b with SMTP id 2adb3069b0e04-52ccaa5961cmr856645e87.1.1718776722092;
        Tue, 18 Jun 2024 22:58:42 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a64bsm215763725e9.46.2024.06.18.22.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:58:41 -0700 (PDT)
Date: Wed, 19 Jun 2024 07:58:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] virtio tests need veth?
Message-ID: <ZnJzjgXFIawJtc1z@nanopsycho.orion>
References: <20240617072614.75fe79e7@kernel.org>
 <ZnEq3YxtVuwHdFqn@nanopsycho.orion>
 <ZnE0JaJgxw1Mw1aE@nanopsycho.orion>
 <1a63f209-b1d4-4809-bc30-295a5cafa296@kernel.org>
 <ZnFze5vFv6dWwQgL@nanopsycho.orion>
 <11ac196a-85cd-4113-97e0-7386c22c9e08@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11ac196a-85cd-4113-97e0-7386c22c9e08@kernel.org>

Tue, Jun 18, 2024 at 02:57:28PM CEST, matttbe@kernel.org wrote:
>On 18/06/2024 13:46, Jiri Pirko wrote:
>> Tue, Jun 18, 2024 at 10:21:54AM CEST, matttbe@kernel.org wrote:
>>> Hi Jiri,
>>>
>>> On 18/06/2024 09:15, Jiri Pirko wrote:
>>>> Tue, Jun 18, 2024 at 08:36:13AM CEST, jiri@resnulli.us wrote:
>>>>> Mon, Jun 17, 2024 at 04:26:14PM CEST, kuba@kernel.org wrote:
>>>>>> Hi Jiri!
>>>>>>
>>>>>> I finally hooked up the virtio tests to NIPA.
>>>>>> Looks like they are missing CONFIG options?
>>>>>>
>>>>>> https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/1-basic-features-sh/stdout
>>>>>
>>>>> Checking that out. Apparently sole config is really missing.
>>>>> Also, looks like for some reason veth is used instead of virtio_net.
>>>>> Where do you run this command? Do you have 2 virtio_net interfaces
>>>>> looped back together on the system?
>>>>
>>>> I guess you have custom
>>>> tools/testing/selftests/net/forwarding/forwarding.config.
>>>> Can you send it here?
>>>
>>> According to the logs from the parent directory [1], the "build/stdout"
>>> file shows that only this config file has been used:
>>>
>>>  tools/testing/selftests/drivers/net/virtio_net/config
>>>
>>> (see the 'vng -b' command)
>>>
>>>> CONFIG_NET_L3_MASTER_DEV=y
>>>> CONFIG_IPV6_MULTIPLE_TABLES=y
>>>> CONFIG_NET_VRF=m
>>>> CONFIG_BPF_SYSCALL=y
>>>> CONFIG_CGROUP_BPF=y
>>>> CONFIG_IPV6=y
>>>
>>> The "config" file from [1] seems to indicate that all these kconfig are
>>> missing, except the BPF ones.
>>>
>>> Note that if you want to check locally, virtme-ng helps to reproduce the
>>> issues reported by the CI, see [2].
>>>
>>> [1] https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/
>> 
>> Hmm, looking here, I see only command outputs. Would be actually good to
>> see what commands were run to produce those outputs.
>
>I think only the command to launch the VM is missing.
>
> - In the build logs [1], where we can see 4 commands:
>   > TREE CMD: make mrproper
>   > TREE CMD: vng -v -b -f
>tools/testing/selftests/drivers/net/virtio_net/config
>   > TREE CMD: make headers
>   > TREE CMD: make -C tools/testing/selftests/drivers/net/virtio_net/
>
> - In the VM logs [2], we don't see the command to start it. I guess it
>is supposed to be closed to what is described in the wiki [3]. At the
>end, we see the env vars that are set in the VM.
>
> - In the test logs [4], we can see the 'make' command at the first line.
>
>I can look at adding the command to start the VM. Do you see anything
>else missing?

After your patch to add vm run command into stdout, I see all.

I tested the missing config options added locally, the test runs clearly
after that.

I will send patch to fix this in a minute.

Thanks!


>
>[1]
>https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/build/stdout
>[2]
>https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/vm-start-thr0-0/stdout
>[3]
>https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#how-to-run
>[4]
>https://netdev-3.bots.linux.dev/vmksft-virtio/results/643761/1-basic-features-sh/stdout
>
>Cheers,
>Matt
>-- 
>Sponsored by the NGI0 Core fund.
>

