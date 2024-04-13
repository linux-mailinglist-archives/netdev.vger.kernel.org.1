Return-Path: <netdev+bounces-87615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E5B8A3CD3
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 15:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077141F21B0D
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 13:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B169405EB;
	Sat, 13 Apr 2024 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iTZkkqSE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB483E47B
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713014996; cv=none; b=oeUS+1MsepgRJMBM8JLcZ5dFGW1k46xzpqBEChUQ5R4ZJFuEAsXYmJZ9mIn0Pz6sCU5Pr9Hqs5lYei0WU5dVbKMlHbOodSySFtSR5Nh1qCP+nZ9Bgss1OomUUm2fD821tY2rypWuZlJ472aqUgZ0/O7VW/AYIdeJYCEcy3jbk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713014996; c=relaxed/simple;
	bh=Fb2/EjgZ2BeForpcKridmm4Z4TIHSrSo2dU0u2mMtF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5nvufBCZ6dckeKgHvEGOmox0SCRHz2TUeDtlzJkFT/VDfHCS87Im31TYDQ9ImhSle/jZE1i4IAKjNp8mMN+TwCTkTlidb7gLAsCURoC3H39Ga74x+nMMLDJKUT/+KKQ9gMvYER/KdlAN/GUXIk2K2nejqeiXz4/cFJld+uvAPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iTZkkqSE; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57013379e17so218203a12.0
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713014993; x=1713619793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hruTETA4PxCbHzLcp0spOlwZR1dHn4JdxXhkp8dJj3Q=;
        b=iTZkkqSE7ecycNDNIEvOWF39MBErzNy00hFyondue2sMWaD3oFyB2dRO4SCvYe6eRM
         EwAZGiziaBys+hoU8P6Ky14gXj4kaRWTOnn8qT9ZsghJFafaFq2FOgAfPD3BMCiqECCS
         6sSyRyYXaxbh3Nu76yxpZTeeD08BsmbgsbqRTsFr2eTluMZJ6rtYLbX+5CUvn9ab3AKd
         WZm6pCYMcNwe5tlqurO+h33VHtI+pVhYnMQhYNF8aD0WsToRa2nJqDV+a4SU8V1OCXZy
         ZmfWrdcankulrZfElE75b7mN9zi4AR8KMHJ5TRQJe6GwRbONJnhTThz8PztfWdhFTsy3
         q6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713014993; x=1713619793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hruTETA4PxCbHzLcp0spOlwZR1dHn4JdxXhkp8dJj3Q=;
        b=ZrCNQZjSycRAYKkxCtiaXQjlK26rmX7eKwSYPYk1m7bKqii8k3ec9HNnWrHtV5rxD2
         oDGBcuKaiPp5udoj/j2cLkflOV8wtxVQMBBAIrXX0B/gD4KuoGBKsNB68mpsjBXtEqTU
         V6OgO3RmYpI4k6oZid58Ca5wdhzIcjmIvINa04qBi5di39htxibtO4nh2x3+5Hj5tT3J
         ptck/C/5tkidvcHOV52wwCOuLeCLyg+XbdAuSdbvDRZckxpIdrCXpP3SL+ywU5BnRKrN
         0izP9YKtnCAyWzTqzg5Qy4/ZL5YlabZx5weBWOqpgIglRPrjNt9koPQEro3h4TSav598
         0T3Q==
X-Gm-Message-State: AOJu0YzghuwdrLdBSP4h5nGMvAPIHpLuzjXx3Vhs236+hk5+Vpl1qEcM
	ua8HMc+wAojo3vSnRmXWVmwP2LuMbbj5zoG3hclF9ArtLZbhvt2A3bZr9YJhhzk=
X-Google-Smtp-Source: AGHT+IFTj5mSgb2nSAJT/asQHCK/cz3QOVk3fD7qcAI2noH4Ve85gCoJ6VoayEz0/qvCpPfvyV+GQA==
X-Received: by 2002:a50:8717:0:b0:56e:3078:74 with SMTP id i23-20020a508717000000b0056e30780074mr4979093edb.31.1713014992626;
        Sat, 13 Apr 2024 06:29:52 -0700 (PDT)
Received: from localhost (37-48-0-252.nat.epc.tmcz.cz. [37.48.0.252])
        by smtp.gmail.com with ESMTPSA id g37-20020a056402322500b005700e153647sm740219eda.38.2024.04.13.06.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 06:29:52 -0700 (PDT)
Date: Sat, 13 Apr 2024 15:29:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 6/6] selftests: virtio_net: add initial tests
Message-ID: <ZhqIznimYxnC5YVS@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-7-jiri@resnulli.us>
 <ZhmdwiGi-r6eDyB-@f4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhmdwiGi-r6eDyB-@f4>

Fri, Apr 12, 2024 at 10:46:58PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Introduce initial tests for virtio_net driver. Focus on feature testing
>> leveraging previously introduced debugfs feature filtering
>> infrastructure. Add very basic ping and F_MAC feature tests.
>> 
>> To run this, do:
>> $ make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests
>> 
>> Run it on a system with 2 virtio_net devices connected back-to-back
>> on the hypervisor.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  tools/testing/selftests/Makefile              |   1 +
>>  .../selftests/drivers/net/virtio_net/Makefile |   5 +
>>  .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
>>  .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
>>  4 files changed, 232 insertions(+)
>>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
>>  create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
>>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh
>> 
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 6dab886d6f7a..a8e40599c65f 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -20,6 +20,7 @@ TARGETS += drivers/s390x/uvdevice
>>  TARGETS += drivers/net
>>  TARGETS += drivers/net/bonding
>>  TARGETS += drivers/net/team
>> +TARGETS += drivers/net/virtio
>>  TARGETS += dt
>>  TARGETS += efivarfs
>>  TARGETS += exec
>> diff --git a/tools/testing/selftests/drivers/net/virtio_net/Makefile b/tools/testing/selftests/drivers/net/virtio_net/Makefile
>> new file mode 100644
>> index 000000000000..c6edf5ddb0e4
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/net/virtio_net/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0+ OR MIT
>> +
>> +TEST_PROGS = basic_features.sh
>> +
>> +include ../../../lib.mk
>
>Makefile is missing something like
>
>TEST_FILES = \
>	virtio_net_common.sh \
>	#
>
>TEST_INCLUDES = \
>	../../../net/forwarding/lib.sh \
>	../../../net/lib.sh \
>	#
>
>Without those, these files are missing when exporting the tests, such as
>with:
>
>cd tools/testing/selftests/
>make install TARGETS=drivers/net/virtio_net/
>./kselftest_install/run_kselftest.sh

Ah, will try and fix. Thanks!


