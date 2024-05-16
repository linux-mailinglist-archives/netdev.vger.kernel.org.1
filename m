Return-Path: <netdev+bounces-96758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9CF8C79E5
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 17:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5361D1F22D1E
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C6514D44D;
	Thu, 16 May 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="SPWfcI5K"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650F114C599
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874957; cv=none; b=OyQCioBsDKDMMNmXnLNUvBXNOoDxQE1qsYjMOoOI3l7FXjZ1eVK4qqszEVPkcmXD/h27ogIzwBqgV90vXHbQp9hzSdfWuv17osrrpc/mp0HILicXevmSUUo042KMmGOcqKsw2lwex3lfsA/vsIUxbUqIGqjf0EXNIXSUcy3OXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874957; c=relaxed/simple;
	bh=AMbY8qXQj7Cet0EFGXEck3uVtIQnO99hPKqBn/Uw04A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pIKK82rS8EazdbtPCIdfkxmbhP+CzJHh7z0K4JgavHVlTjMYDqVcbdYeMJrarr8GaNPzXEEqCgxXRRX6jdjXHT8BE7DSVX8ynZkZWcxrL64xayEqDhQurx3JqdhZfvD6seTrXnBLjrCn6o1PE3I0e+m17/NgjNtXvfqlHttcOGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=SPWfcI5K; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7dSO-00394a-3S; Thu, 16 May 2024 17:55:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=U9oRo34tk8GKL1JV3i2UbgrpYUdRKaQ8wRvuXFebzKg=; b=SPWfcI5KzfBegBXQx8Uo5tFtE5
	w7/7q+AFKAnC7fHFSbf/Qi5OCKI9olWRR2yPcsTSZxjMTiT9TfNfIRsP87NQVriYSJLalY2QqaO5S
	ensJhr3ic8UG2c8mQjhZtUcoCtIYPoBQpY1Oz4OzK15uyVUBfLeHziarFawgvsIim/UCQSkNmG/pw
	53CGCSW7uRCF8gbqkLNsajkU3BvXJQITqDiYcIogwMnC9fLgp15UTcR3Ug3W9Yqew4rxAOrgT5d/X
	vQRPsy9HVabx98aOudcinP/qWsjHWqCoK4+ujYVZoMLAfKnrZI2Qi0t8BA1PTmpQEzLVc1OOD6zBU
	yOkLKSDQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7dSN-0003db-69; Thu, 16 May 2024 17:55:47 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7dSM-001CMB-MK; Thu, 16 May 2024 17:55:46 +0200
Message-ID: <b2d99a52-2603-4027-9a24-efe13656d019@rbox.co>
Date: Thu, 16 May 2024 17:55:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net] af_unix: Fix garbage collection of embryos carrying
 OOB with SCM_RIGHTS
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <20240516103049.1132040-1-mhal@rbox.co>
 <20240516123120.99486-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20240516123120.99486-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/24 14:31, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Thu, 16 May 2024 12:20:48 +0200
>> ...
>> @@ -583,6 +588,8 @@ static void __unix_gc(struct work_struct *work)
>>  	skb_queue_walk(&hitlist, skb) {
>>  		if (UNIXCB(skb).fp)
>>  			UNIXCB(skb).fp->dead = true;
>> +
>> +		WARN_ON_ONCE(refcount_read(&skb->users) != 1);
> 
> Given we will refactor OOB with no additional refcount, this will not
> make sense.  Rather, I'd add a test case in a selftest to catch the
> future regression.

Sure, I get it.

> And I noticed that I actually tried to catch this in
> 
>   tools/testing/selftests/net/af_unix/scm_rights.c
> 
> , and what is missing is... :S
> ...
> Could you remove the WARN_ON_ONCE() and repost with my patch
> above ?

Done: https://lore.kernel.org/all/20240516145457.1206847-1-mhal@rbox.co/

thanks,
Michal

