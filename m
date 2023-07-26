Return-Path: <netdev+bounces-21291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43002763253
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2792281D0D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E53BA4E;
	Wed, 26 Jul 2023 09:34:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063EEAD37
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:34:00 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE0C2719
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:33:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b7dfb95761so8911895ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690364030; x=1690968830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0oULOTnWb1HIc+jcDQkyDbPD+ewEuK6cRZsxNFZBJHs=;
        b=QJhhRpaTfMAfucHkCz2d9TS31hpYk30s2kQKv681O+Sl1mLTZQhZq5VKb4l9mXe+gX
         5Eax6ixoNcCSNY9H6aAkwgnBd/g9cM9X43ylT+UhHbYekfmlgjo/JXqlix6WaCFQ7jVV
         2D4QfnYhGItzA17GFTgozRmivkdC7H5IwsXEWhmkOBzQK5UpXhnT6Ls+I4I3tsoeozxU
         24KbqK2Cq3sIWZ8RaqWYBiX9Q9627K0AND5qR2t9+dtM8IjHsDiCPK6lh5ggLgTON/bP
         sMZVbirBGOz1XlXtXsxmGmw+9U7+KmVQpZdmOnau0hPanAHKCfZx0jR+DbnWSE4a/7ep
         yq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690364030; x=1690968830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oULOTnWb1HIc+jcDQkyDbPD+ewEuK6cRZsxNFZBJHs=;
        b=dbtkQJDnnQ4FJdKo548/GCukybBmexXVOvt3dxP1yy7efTkzImNCgVGJYTdzK1bl6Z
         uiTF5hKRmJfZ0mzwW+ZsE+Ma+NJgRKmLAl6jlYkkL3amCkyeBeSPV3yS++ojhBys/UPR
         Gf/x/6cW9hEwB60ewkVPDuzRYYzr2oYJmsbu1ob/3u85ke3xkAr35yG5yEmuy8DVL36X
         xiM358bIsxRkQ68GllB80HIjC2P5qlGzHRFkPUtYPgyTTqI9GXneiknhEVRwPN1HJ48t
         1czNZpPPb4cjDvCAK5Rj4UiYlZvkulKJQXeUo98rj3uw38nD7K6gk/rQ2Y1A8+0TDf47
         JHug==
X-Gm-Message-State: ABy/qLbBGNOU/ochcF6kZXQN6/YxhZzona9HIx/EPKeW4z8ilhX2vEoY
	mKZvfI98DDzmekuB97wBp7Fh2g==
X-Google-Smtp-Source: APBJJlG8LKe8O0SB++JE7Hsj6dMankp6b2TdGG8KZmgQCX7ZvwrXNm6kysx08G1J6PXDjDRRJyafNA==
X-Received: by 2002:a17:903:32c9:b0:1b8:5827:8763 with SMTP id i9-20020a17090332c900b001b858278763mr2037984plr.4.1690364030014;
        Wed, 26 Jul 2023 02:33:50 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902d2c500b001b89466a5f4sm12582766plc.105.2023.07.26.02.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:33:49 -0700 (PDT)
Message-ID: <0f12022e-5dd2-fb1c-f018-05f8ff0303ae@bytedance.com>
Date: Wed, 26 Jul 2023 17:33:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 28/47] bcache: dynamically allocate the md-bcache
 shrinker
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
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
 akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
 roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
 paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com, cel@kernel.org,
 senozhatsky@chromium.org, yujie.liu@intel.com, gregkh@linuxfoundation.org
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-29-zhengqi.arch@bytedance.com>
 <4ee26da4-314e-0517-5d9a-31fb107368ef@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <4ee26da4-314e-0517-5d9a-31fb107368ef@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/26 15:32, Muchun Song wrote:
> 
> 
> On 2023/7/24 17:43, Qi Zheng wrote:
>> In preparation for implementing lockless slab shrink, use new APIs to
>> dynamically allocate the md-bcache shrinker, so that it can be freed
>> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
>> read-side critical section when releasing the struct cache_set.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   drivers/md/bcache/bcache.h |  2 +-
>>   drivers/md/bcache/btree.c  | 27 ++++++++++++++++-----------
>>   drivers/md/bcache/sysfs.c  |  3 ++-
>>   3 files changed, 19 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
>> index 5a79bb3c272f..c622bc50f81b 100644
>> --- a/drivers/md/bcache/bcache.h
>> +++ b/drivers/md/bcache/bcache.h
>> @@ -541,7 +541,7 @@ struct cache_set {
>>       struct bio_set        bio_split;
>>       /* For the btree cache */
>> -    struct shrinker        shrink;
>> +    struct shrinker        *shrink;
>>       /* For the btree cache and anything allocation related */
>>       struct mutex        bucket_lock;
>> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
>> index fd121a61f17c..c176c7fc77d9 100644
>> --- a/drivers/md/bcache/btree.c
>> +++ b/drivers/md/bcache/btree.c
>> @@ -667,7 +667,7 @@ static int mca_reap(struct btree *b, unsigned int 
>> min_order, bool flush)
>>   static unsigned long bch_mca_scan(struct shrinker *shrink,
>>                     struct shrink_control *sc)
>>   {
>> -    struct cache_set *c = container_of(shrink, struct cache_set, 
>> shrink);
>> +    struct cache_set *c = shrink->private_data;
>>       struct btree *b, *t;
>>       unsigned long i, nr = sc->nr_to_scan;
>>       unsigned long freed = 0;
>> @@ -734,7 +734,7 @@ static unsigned long bch_mca_scan(struct shrinker 
>> *shrink,
>>   static unsigned long bch_mca_count(struct shrinker *shrink,
>>                      struct shrink_control *sc)
>>   {
>> -    struct cache_set *c = container_of(shrink, struct cache_set, 
>> shrink);
>> +    struct cache_set *c = shrink->private_data;
>>       if (c->shrinker_disabled)
>>           return 0;
>> @@ -752,8 +752,8 @@ void bch_btree_cache_free(struct cache_set *c)
>>       closure_init_stack(&cl);
>> -    if (c->shrink.list.next)
>> -        unregister_shrinker(&c->shrink);
>> +    if (c->shrink)
>> +        shrinker_unregister(c->shrink);
>>       mutex_lock(&c->bucket_lock);
>> @@ -828,14 +828,19 @@ int bch_btree_cache_alloc(struct cache_set *c)
>>           c->verify_data = NULL;
>>   #endif
>> -    c->shrink.count_objects = bch_mca_count;
>> -    c->shrink.scan_objects = bch_mca_scan;
>> -    c->shrink.seeks = 4;
>> -    c->shrink.batch = c->btree_pages * 2;
>> +    c->shrink = shrinker_alloc(0, "md-bcache:%pU", c->set_uuid);
>> +    if (!c->shrink) {
>> +        pr_warn("bcache: %s: could not allocate shrinker\n", __func__);
>> +        return -ENOMEM;
> 
> Seems you have cheanged the semantic of this. In the past,
> it is better to have a shrinker, but now it becomes a mandatory.
> Right? I don't know if it is acceptable. From my point of view,
> just do the cleanup, don't change any behaviour.

Oh, should return 0 here, will do.

> 
>> +    }
>> +
>> +    c->shrink->count_objects = bch_mca_count;
>> +    c->shrink->scan_objects = bch_mca_scan;
>> +    c->shrink->seeks = 4;
>> +    c->shrink->batch = c->btree_pages * 2;
>> +    c->shrink->private_data = c;
>> -    if (register_shrinker(&c->shrink, "md-bcache:%pU", c->set_uuid))
>> -        pr_warn("bcache: %s: could not register shrinker\n",
>> -                __func__);
>> +    shrinker_register(c->shrink);
>>       return 0;
>>   }
>> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
>> index 0e2c1880f60b..45d8af755de6 100644
>> --- a/drivers/md/bcache/sysfs.c
>> +++ b/drivers/md/bcache/sysfs.c
>> @@ -866,7 +866,8 @@ STORE(__bch_cache_set)
>>           sc.gfp_mask = GFP_KERNEL;
>>           sc.nr_to_scan = strtoul_or_return(buf);
>> -        c->shrink.scan_objects(&c->shrink, &sc);
>> +        if (c->shrink)
>> +            c->shrink->scan_objects(c->shrink, &sc);
>>       }
>>       sysfs_strtoul_clamp(congested_read_threshold_us,
> 

