Return-Path: <netdev+bounces-249141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFB2D14BE1
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A84A1300819B
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACB438758E;
	Mon, 12 Jan 2026 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWpZ9Lrv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="guWZ/pOZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D13815C1
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242241; cv=none; b=iTptsNHitjdRPTK4Kq64oGnbHqm2fUcjD3l8NKL8CagCOQgzEkjn0grt46Gdv8H2uHgXZ1iVSXGywPCNUKcsF24Q5Ec4dfeaVgfda1UtJCScKUBLTx5Oe+9Y+tGc5svdRmu+I46BtHoLZMo/2wuIL3MeXVwNWGZ3vVj14j4eICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242241; c=relaxed/simple;
	bh=zpoNdTeaB4i3QK4pd6pXO1rrYW3DhRqSBMGvDT0il6g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q6gye1TkwkSF/CDOqAFVC8OBWvNVlGRviHFvBwn90kHSCf7/o/EdNtJlZYu2pjxrHgwWuPSw5SwybSQ2j/uPw+bYrmiUmYHGK0xTRvGx5wzxwYuFYC7wJv8T+FmhubYiCaRa9bBU5KWrrtjQexueC8HA7Q3K6B3v4nZ10h5cC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWpZ9Lrv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=guWZ/pOZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768242239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gLOxIDyxhTvVzJuSwvSFZ4MlqhsCFk9OHFtuRb1ESk=;
	b=FWpZ9LrvYHiS7aGdljd+Igfcct2cokATR6+D5ebFep8iti98uX0GqcrakCmUdIlJh8z3o/
	eHRLERNxEe9QPsW2VDqS2q5yvNLWuPgqzxtjJAewEQbRjK+OuvXSF2ATwYstzR/B+Kwmmw
	aHufBShApfcsR1sjFnEi4/uVfHYjqis=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-f8j93KGnMHW6IURMnQJGdA-1; Mon, 12 Jan 2026 13:23:57 -0500
X-MC-Unique: f8j93KGnMHW6IURMnQJGdA-1
X-Mimecast-MFC-AGG-ID: f8j93KGnMHW6IURMnQJGdA_1768242237
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5ecdaf59131so5202698137.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768242237; x=1768847037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2gLOxIDyxhTvVzJuSwvSFZ4MlqhsCFk9OHFtuRb1ESk=;
        b=guWZ/pOZLgLBpVMG05eI3nl8fDNrxtbg2JeJCnJpCJrPxAsxB0oM8wX1VZpMXoNChX
         pxVtL3oEQmmej+J7Eoz8v2sBGDeskbAevIn9NmTy3ojM3gvsNXW2FCX7PLS/gSwFs9Rg
         22898MVltwFNGxKeyaMy5jSocMHB7lcT1a6L12IkSe0hAwRkjhrPwbyiDdX6Q6ipjmqT
         ACAnBfRKxgkyS7q8cV5a2zWbQWX23rvz/z6tCe1AjFaUArNLOnZJ3Ouwlsk2WJK/lbk9
         hYiI6TnNwFUjKyE28XmfU3yhWW02R0ju/S/QE4BQz+4ubhR5V1itNdkLypLRsXsJi1Eg
         EMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242237; x=1768847037;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gLOxIDyxhTvVzJuSwvSFZ4MlqhsCFk9OHFtuRb1ESk=;
        b=VoJyHqR1z4330UdNH5XR2kR3FM5wSyHmnMHFVQml6Camz80yyFY6SGx4GlOVkg/GWD
         FAHBLYqhZuBAUB6SHUBBxHM3i+1twdBRKJIVOb1MLHjEEUr8l+HAFVPjeYHY7+0Zp/Z6
         3V3GZ6z8WFhL6uvByRzL7xAr9FiWfI8HEK/XvyLrA3u97uyOlQV7dpJU6tyCdc7E+z3Q
         LWJXirniSJPbG+7s/E9M5OVftGrko7bKXJhSzeVHrJ39Zt/x1MU21MAFOqYEfWjAJ1ZU
         Q5eBs/F9eobp3Iuxr9xi5G8pFfiig2u599syi80XmUtTAmrgp4+EbmTpgZGdpKd6MmnQ
         sByw==
X-Forwarded-Encrypted: i=1; AJvYcCVWKqyiZY+1IwKq9DaAEOG4qyWPrb/z4Kzfk6wLZKmllJ6TMUqmGqgj8NpmvmJ67yV9ksdN96k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeFiHk5u/wxna5VIujH83htmRyGkFSGzYeraaJji2YQprZOuqP
	QUwacbbyYf5faLHQhBYocNBqePE+NIDffW7BeTlF4wxbt6SaIHiDJcfo5TzSOrx0Cm5HX9GT+ef
	mPOES96RgpyoZliaCtXf3CdxyEhUTFDS1V8QWEKDJ19VFDb2yseNu00Wlzg==
X-Gm-Gg: AY/fxX5YL+Rv2ey3QJGKvudkNqL1Rh3RtFXdo6dsIF3rT/eVbMQmcehpVLQbtyfnNhb
	haHncOMmMmNfCjpQmONC0hvyNFwKXNVoMy8/yrvg0VTikvhjaPmp+JWBSz9MhZeIG9H2TBrNN8b
	sSpVHi3ExWSqZXHxd2GGBNs+LW/NFrKPDBls76iK98HNF0/wcxKLFGWcgab1IWiwjTmkumZUDqr
	dPeYw1xGH8lD80JC1Eo1dJ7fk3MOlSgwbNxpHJL5Dq+0AGKb5LGN6fM1A8tCvlcUef6tLhElH6A
	TKYykNc1PRL/q+c2AB7gCXze5RIjwI6UIHbKTswQceJuEIJKuOpvR+1Z1Y91Qw4tCsNirVdPFUI
	aAkeZ6kihKF6nOaUgTN1H+IfMT1WGib87fC5XAzG1Tw3Bg+Mr34XEiClR
X-Received: by 2002:a05:6102:ccd:b0:5ef:b5fc:dd4c with SMTP id ada2fe7eead31-5efb5fceabcmr2465163137.7.1768242237209;
        Mon, 12 Jan 2026 10:23:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwmHNbjOkRHiOzASiFvy8qH079mvHRUgTgzybGWlZGH94huRhJ7zei/lWRFsGQLOin7Q4KDw==
X-Received: by 2002:a05:6102:ccd:b0:5ef:b5fc:dd4c with SMTP id ada2fe7eead31-5efb5fceabcmr2465086137.7.1768242235294;
        Mon, 12 Jan 2026 10:23:55 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ef15be79c6sm10965711137.12.2026.01.12.10.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 10:23:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <437ccd7a-e839-4b40-840c-7c40d22f8166@redhat.com>
Date: Mon, 12 Jan 2026 13:23:40 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33 v6] cpuset/isolation: Honour kthreads preferred
 affinity
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Phil Auld <pauld@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Michal Koutny <mkoutny@suse.com>,
 netdev@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>,
 linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, Michal Hocko <mhocko@suse.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
 Chen Ridong <chenridong@huawei.com>, cgroups@vger.kernel.org,
 linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S . Miller" <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Simon Horman <horms@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Gabriele Monaco <gmonaco@redhat.com>, Muchun Song <muchun.song@linux.dev>,
 Will Deacon <will@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Chen Ridong <chenridong@huaweicloud.com>
References: <20260101221359.22298-1-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20260101221359.22298-1-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/1/26 5:13 PM, Frederic Weisbecker wrote:
> Hi,
>
> The kthread code was enhanced lately to provide an infrastructure which
> manages the preferred affinity of unbound kthreads (node or custom
> cpumask) against housekeeping constraints and CPU hotplug events.
>
> One crucial missing piece is cpuset: when an isolated partition is
> created, deleted, or its CPUs updated, all the unbound kthreads in the
> top cpuset are affine to _all_ the non-isolated CPUs, possibly breaking
> their preferred affinity along the way
>
> Solve this with performing the kthreads affinity update from cpuset to
> the kthreads consolidated relevant code instead so that preferred
> affinities are honoured.
>
> The dispatch of the new cpumasks to workqueues and kthreads is performed
> by housekeeping, as per the nice Tejun's suggestion.
>
> As a welcome side effect, HK_TYPE_DOMAIN then integrates both the set
> from isolcpus= and cpuset isolated partitions. Housekeeping cpumasks are
> now modifyable with specific synchronization. A big step toward making
> nohz_full= also mutable through cpuset in the future.
>
> Changes since v5:
>
> * Add more tags
>
> * Fix leaked destroy_work_on_stack() (Zhang Qiao, Waiman Long)
>
> * Comment schedule_drain_work() synchronization requirement (Tejun)
>
> * s/Revert of/Inverse of (Waiman Long)
>
> * Remove housekeeping_update() needless (for now) parameter (Chen Ridong)
>
> * Don't propagate housekeeping_update() failures beyond allocations (Waiman Long)
>
> * Whitespace cleanup (Waiman Long)
>
>
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	kthread/core-v6
>
> HEAD: 811e87ca8a0a1e54eb5f23e71896cb97436cccdc
>
> Happy new year,
> 	Frederic

I don't see any major issue with this v6 version. There may be some 
minor issues that can be cleaned up later. Now the issue is which tree 
should this series go to as it touches a number of different subsystems 
with different maintainers.

Cheers,
Longman


