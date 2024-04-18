Return-Path: <netdev+bounces-89166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872BE8A9964
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83141C2276D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACDD15FA72;
	Thu, 18 Apr 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ArwqPyMg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610815E7E7
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441622; cv=none; b=diOWgZYMkss6lJ/0S919iRiIHTNdLih+BtCEE2T6AUV0ZH2ivnwp/2e2SjUdaeJ3/WjEY0mlMf1P4brO+CnN7QPmehdJFE1XnQuhksV0z0WgtrBhhG5vhScmwcBg5HMt1mRkh6tYF+x5/qSsns3mLaqH61auM/wp5fFfh5dkfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441622; c=relaxed/simple;
	bh=a7rhft9+f6E6CZaHtNcPSvmrUhAZnSV0d1mIll7g2Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kssg80XoW6uI2ZYACchtHHNKHFMpsrX3E6dNo5RN4KPi1MSh4bdvLCsuyODf5iCexXwrm2nrKVVFOfbm0sGDo8yGRf8AxkWbcw983ub4NCfJV/r1UR+PKQBjk5sLfjwN9lQty6engU5MWJUQwcJOffEI1HPF00SPukGUPhHEmL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ArwqPyMg; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56fffb1d14bso1328025a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713441612; x=1714046412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwUqdIuY+eDu/EcFyYGUaTkLl+Kne1AA8UMhkE5/9Sw=;
        b=ArwqPyMgjrd+3vntaOU6wLW3Fsw0rZtrnyt4U/OYZHYsKkRVsmKR2jt+63nug8dpqE
         EURYQyjSQjeFlUfdbk0Gl0lJpYOM6SEwfVgMb8JwWQvPLBFsliCU2L2DmuVX2YUTd9oP
         KzfFG+xH+ErCxWtsV/thkqpjB0IJrJ90dNmD4dRDkryT+WSe6sw5iMziP5zIVZg6MDvQ
         4QYJTuNe5CEibU1zz1x94rVZZiGYipCn0xjPmy7udCSP/9KlS/7ExBJgaTrbmFhNFRqK
         sEmA2IVIbdBYp9xIBcWwRaDTQGOiJ+Hc+Rln0kisQbJC5CXwyme1xLIHxrHG+2bpUMTz
         p+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441612; x=1714046412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwUqdIuY+eDu/EcFyYGUaTkLl+Kne1AA8UMhkE5/9Sw=;
        b=pZa5Optz3j4CZM1nks8QnFciEyW+E4dV6/nOb9q2gRSipFXNlzzSnLV8FQzvBKohN6
         Qlq8mb8NieA4oNSZz1PH7AknuyHyVbVea1e1Dkxr4qS3Q9utADvBY4o8AfIdNMSuzl+f
         N/7RVAOWBYKN/7XHANfymLMrECSHNeWktLMvb3XzcP1J0Hbuzm7Uw0yq3Svz55MzrpR0
         yyNvWcWMdkZFfcL0UfsnM0hOEYFkwbQXhOB1JTpxxnmVrKpZ9qB0zaXMu12nEmSFXCsK
         fMwEMJP5jizHm3t9cbBlAm4FI2wB20mFXSbPClZ8ksGn9xTs7tLdmMLsAOMsDT+WJGUo
         xbWw==
X-Gm-Message-State: AOJu0Yyajdoac/a09V07IxWhnAaQ8L+IoRjn6M8ZJhXEoPV+UNR3eNJw
	9uyPy3e2Vy0mjOP8pWD2HuX+1W0IkRZ5fkd/AdBVOlzCHc+XrsscO0dmnjww9yI=
X-Google-Smtp-Source: AGHT+IGthP8iEGCeNaOf9TDh2tPZaTJPryMHFc//F72pGlW0keYCltfl498SG97CDYoIpJt8o9hsjQ==
X-Received: by 2002:a50:fa85:0:b0:571:b9c7:2541 with SMTP id w5-20020a50fa85000000b00571b9c72541mr1532066edr.11.1713441611778;
        Thu, 18 Apr 2024 05:00:11 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b0056ff4faa0b9sm821264edi.6.2024.04.18.05.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:00:11 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:00:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v3 6/6] selftests: virtio_net: add initial tests
Message-ID: <ZiELSaMVEuYJmeaB@nanopsycho>
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-7-jiri@resnulli.us>
 <87ttjzawhd.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttjzawhd.fsf@nvidia.com>

Thu, Apr 18, 2024 at 10:39:49AM CEST, petrm@nvidia.com wrote:
>
>Jiri Pirko <jiri@resnulli.us> writes:
>
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
>
>> +h2_destroy()
>> +{
>> +	simple_if_fini $h2 $H2_IPV4/24 $H2_IPV6/64
>> +}
>> +
>> +initial_ping_test()
>> +{
>> +	cleanup
>
>All these cleanup() calls will end up possibly triggering
>PAUSE_ON_CLEANUP. Not sure that's intended.

Okay, will change that.

Thanks!

>
>> +	setup_prepare
>> +	ping_test $h1 $H2_IPV4 " simple"
>> +}
>
>Other than this nit, LGTM.
>
>Reviewed-by: Petr Machata <petrm@nvidia.com>

