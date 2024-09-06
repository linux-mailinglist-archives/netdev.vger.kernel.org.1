Return-Path: <netdev+bounces-125957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9487296F6A5
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18621C23C84
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71791D04B6;
	Fri,  6 Sep 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug5voc+X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9891FAA
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632733; cv=none; b=ZNk/OKhsboP1pRA2dAlsIG/e5yX2VKuw1QiYlGMvKLjofoaTEMGqRaNtdwN+hn5UhVM9gAtYUFJaRbRtmOkdTh+24lN/QgzNrdhB2mEvhg24I0yIdz/rngI7EggfiRI9TeldchyXRQzp/952CC8NCxjtlfpTahmWuYuLB0n35/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632733; c=relaxed/simple;
	bh=GAs8iurpJ8qv5psVpVpp7NkCdyjJ7rDJRCia9N6KHQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgA4jYyu0jDMExHol4S/9RnfcdMTHoyJckga5APzRp2PgABWrxSljGgfJXoMvJe4gAonoiEQZgI8zZSEfPzwhM3v2SaI2WC1JCav4+ctSlbskGEli1ed8s90d0rwJfNSFxLp3Eb5LjsHOMNbQb9xvz+Xusn7zwEQEiJNFi2DXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ug5voc+X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725632730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+awdkgcqXaMAPB7BpN1GvvWlqJvyzdLn+E4BenWut/k=;
	b=Ug5voc+XaRKFHXEJmxqddsEcy70qSsb77AbuUJtls+cFyakYHMl9Rh64KU+J2s3S89InrL
	GxNoFp0ByATNVkFLc459ZCeumU2NLYwm/TMc4Zd11Q1lUUz2kYHXFS8Y82L0DIbkl1DmQW
	zsMy0pEvy5/Yytj9VYJdUUqfrpglx0Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-geAxTG9AOJmwKtQAg0Dkfg-1; Fri, 06 Sep 2024 10:25:29 -0400
X-MC-Unique: geAxTG9AOJmwKtQAg0Dkfg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso16623355e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 07:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725632729; x=1726237529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+awdkgcqXaMAPB7BpN1GvvWlqJvyzdLn+E4BenWut/k=;
        b=ddBF+StYJLGapjQU3QrsmbD4nLxs4VBpLCwUQL7SyLkNGQMB+KSAalCaOQQfMl6Mfq
         DHFALqyLpEjgqEsKJWpmOkjIgsrQGdKRpkdd7QxQcGe3YaBga7Zhvv4TgQQ8/CiWEYIX
         b1QI+t0EBUBRseel362DNzrL+dppLO9VAf8pHMzGmLm2kO+DLch4wbSwoQAggp4HPk8q
         VmuXYfxrtFGyuyyXchTXRcjUEwlrFfpxJ9c8Nwg4iyHuAGo5zFI+m5IurQpFoLWfqGoE
         EKIZVRF1yj6W7vpHKl94fNlAV1ILzNuAogH+XZ7Xa1DY3VC7f6MjcMeYbo59AOiMMYTd
         Vpew==
X-Gm-Message-State: AOJu0Yw8vcbo8vfQvw4DSs4wXkpGkEpmLkSQ81LzlFmrQs7B/eUC1Jrr
	n29WmnddlmA4zImm3xOxQISr5lz7g8AqaosKnB6rqVu5YBpsewQ0nMdDZFj2A8LCTrnD142QZHi
	Y+EuXrBrW1yusLtFxE39w4UWv+WyYxKm0xC+ulq06ZobxiRniyHavGA==
X-Received: by 2002:a05:600c:3b29:b0:427:ff7a:794 with SMTP id 5b1f17b1804b1-42c9f972fd0mr18240695e9.4.1725632728624;
        Fri, 06 Sep 2024 07:25:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWjALGFtsurtRTbvBx3AjYYILknCDM4oacHLdEQEnmM0Qm74uNXQuxRhlYs+vOKF88iRzxjw==
X-Received: by 2002:a05:600c:3b29:b0:427:ff7a:794 with SMTP id 5b1f17b1804b1-42c9f972fd0mr18240495e9.4.1725632728056;
        Fri, 06 Sep 2024 07:25:28 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05d3052sm21983555e9.25.2024.09.06.07.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:25:27 -0700 (PDT)
Message-ID: <8ba551da-3626-4505-bdf2-fa617d4ad66b@redhat.com>
Date: Fri, 6 Sep 2024 16:25:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 07/15] net-shapers: implement shaper cleanup
 on queue deletion
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter
 <donald.hunter@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com
References: <cover.1725457317.git.pabeni@redhat.com>
 <160421ccd6deedfd4d531f0239e80077f19db1d0.1725457317.git.pabeni@redhat.com>
 <20240904183329.5c186909@kernel.org>
 <8fba5626-f4e0-47c3-b022-a7ca9ca1a93f@redhat.com>
 <20240905182521.2f9f4c1c@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240905182521.2f9f4c1c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 03:25, Jakub Kicinski wrote:
> For the driver -- let me flip the question around -- what do you expect
> the locking scheme to be in case of channel count change? Alternatively
> we could just expect the driver to take netdev->lock around the
> appropriate section of code and we'd do:
> 
> void net_shaper_set_real_num_tx_queues(struct net_device *dev, ...)
> {
> 	...
> 	if (!READ_ONCE(dev->net_shaper_hierarchy))
> 		return;
> 
> 	lockdep_assert_held(dev->lock);
> 	...
> }

In the IAVF case that will be problematic, as AFAICS the channel reconf 
is done by 2 consecutive async task, the first task - iavf_reset_task - 
changes the actual number of channels freeing/allocating the driver 
resources and the 2nd one - iavf_finish_config - notify the stack 
issuing netif_set_real_num_tx_queues(). iavf_reset_task can't easily 
wait for iavf_finish_config due to locking order.

> I had a look at iavf, and there is no relevant locking around the queue
> count check at all, so that doesn't help.

Yep, that is racy.

>> Acquiring dev->lock around set_channel() will not be enough: some driver
>> change the channels number i.e. when enabling XDP.
> 
> Indeed, trying to lock before calling the driver would be both a huge
> job and destined to fail.
> 
>> I think/fear we need to replace the dev->lock with the rtnl lock to
>> solve the race for good.
> 
> Maybe :( I think we need *an* answer for:
>   - how we expect the driver to protect itself (assuming that the racy
>     check in iavf_verify_handle() actually serves some purpose, which
>     may not be true);
>   - how we ensure consistency of core state (no shapers for queues which
>     don't exist, assuming we agree having shapers for queues which
>     don't exist is counter productive).

I agree we must delete shapers on removed/deleted queues. The 
driver/firmware could reuse the same H/W resources for a different VF 
and such queue must start in the new VF with a default (no shaping) config.

> Reverting back to rtnl_lock for all would be sad, the scheme of
> expecting the driver to take netdev->lock could work?
> It's the model we effectively settled on in devlink.
> Core->driver callbacks are always locked by the core,
> for driver->core calls driver should explicitly take the lock
> (some wrappers for lock+op+unlock are provided).

I think/guess/hope the following could work:

- the driver wraps the h/w resources reconfiguration and 
netif_set_real_num_tx_queues() with dev->lock. In the iavf case, that 
means 2 separate critical sections: in iavf_reset_task() and in 
iavf_finish_config().

- the core, under dev->lock, checks vs real_num_tx_queues and call the 
shaper ops

- the iavf shaper callbacks would still need to check the queue id vs 
the current allocated hw resource number as the shapers ops could run 
in-between the 2 mentioned critical sections. The iavf driver could 
still act consistently with the core:

   - if real_num_tx_queues < qid < current_allocated_hw_resources
     set the shaper,
   - if current_allocated_hw_resources < qid < real_num_tx_queues do
     nothing and return success

In both the above scenarios, real_num_tx_queues will be set to 
current_allocated_hw_resources soon by the upcoming 
iavf_finish_config(), the core will update the hierarchy accordingly, 
the status will be consistent.

I think the code should be more clear, let me try to share it ASAP (or 
please block me soon ;)

Thanks,

Paolo


