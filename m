Return-Path: <netdev+bounces-21852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE17650D7
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776A8282202
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601EA14AA5;
	Thu, 27 Jul 2023 10:20:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2711184
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9266C433C8;
	Thu, 27 Jul 2023 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690453251;
	bh=Uv0jglg4XDxm5uiOcl1Fs0VDdmS3vnj5J06IHksC3j0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VjGCTE5fXWQGMkstr5mWfG/olGcukHbx9MJ5gIHM1kJfwo/BiFcjiuEaiA2TxQad6
	 b/CL9D78jYHhDiLBxLD9gCBB6CtR9Pngnq1E4RM+cWQl1ITCzXzhPBEMorh0UStJGb
	 V5QypMia7H1mT7Yv9W7oIRfkDRB1G3xJIxfo7Y/Lymzj+mXx3lcBAFmRFbWxhh8lk9
	 h4N9LjcMkMC3/ZfJEah0qCVly/fWQ4ostsbFgLI1m7GG/WQbkHJ87BAgn9cUsNUERW
	 XrnUyEDaK9+tFU+Iukly/qv+tfC9IZiVkgJJJYsmEkH+2gmJEivzAz4IAcCpkEsNUW
	 WY8rxT9ubVHrA==
Message-ID: <ba0868b2-9f90-3d81-1c91-8810057fb3ce@kernel.org>
Date: Thu, 27 Jul 2023 19:20:46 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 28/49] dm zoned: dynamically allocate the dm-zoned-meta
 shrinker
Content-Language: en-US
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
 linux-mtd@lists.infradead.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-bcache@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
 david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz, roman.gushchin@linux.dev,
 djwong@kernel.org, brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
 steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
 yujie.liu@intel.com, gregkh@linuxfoundation.org, muchun.song@linux.dev
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-29-zhengqi.arch@bytedance.com>
 <baaf7de4-9a0e-b953-2b6a-46e60c415614@kernel.org>
 <56ee1d92-28ee-81cb-9c41-6ca7ea6556b0@bytedance.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <56ee1d92-28ee-81cb-9c41-6ca7ea6556b0@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/27/23 17:55, Qi Zheng wrote:
>>>           goto err;
>>>       }
>>>   +    zmd->mblk_shrinker->count_objects = dmz_mblock_shrinker_count;
>>> +    zmd->mblk_shrinker->scan_objects = dmz_mblock_shrinker_scan;
>>> +    zmd->mblk_shrinker->seeks = DEFAULT_SEEKS;
>>> +    zmd->mblk_shrinker->private_data = zmd;
>>> +
>>> +    shrinker_register(zmd->mblk_shrinker);
>>
>> I fail to see how this new shrinker API is better... Why isn't there a
>> shrinker_alloc_and_register() function ? That would avoid adding all this code
>> all over the place as the new API call would be very similar to the current
>> shrinker_register() call with static allocation.
> 
> In some registration scenarios, memory needs to be allocated in advance.
> So we continue to use the previous prealloc/register_prepared()
> algorithm. The shrinker_alloc_and_register() is just a helper function
> that combines the two, and this increases the number of APIs that
> shrinker exposes to the outside, so I choose not to add this helper.

And that results in more code in many places instead of less code + a simple
inline helper in the shrinker header file... So not adding that super simple
helper is not exactly the best choice in my opinion.

-- 
Damien Le Moal
Western Digital Research


