Return-Path: <netdev+bounces-21212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B512762DB7
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D061C20A24
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 07:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2DC8F5B;
	Wed, 26 Jul 2023 07:32:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D48C79F3
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:32:32 +0000 (UTC)
Received: from out-22.mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92626A1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 00:32:27 -0700 (PDT)
Message-ID: <4ee26da4-314e-0517-5d9a-31fb107368ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690356746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYGRVTqgscFQdcJoAIv1RQJgZK2J3Xems6RanwsA4o0=;
	b=GCsKw+CqeG0NLvU5JG9vhNLkiCqBIozjq4+mghrN4n54qEc8Ada19ZBzziy+rqbgGP2UKc
	TRnfIbI6wQqD1XzBynZ64zgbT937OIDi9314tjiKBhNwZptVDCqjhQglYT3NeOO47ZzKdD
	/L1dy0OB1iSvzxJ2Vh5k44+kOPJOpuA=
Date: Wed, 26 Jul 2023 15:32:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 28/47] bcache: dynamically allocate the md-bcache
 shrinker
To: Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
 david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz, roman.gushchin@linux.dev,
 djwong@kernel.org, brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
 steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
 yujie.liu@intel.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
 linux-mtd@lists.infradead.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-bcache@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-29-zhengqi.arch@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230724094354.90817-29-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/24 17:43, Qi Zheng wrote:
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the md-bcache shrinker, so that it can be freed
> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
> read-side critical section when releasing the struct cache_set.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   drivers/md/bcache/bcache.h |  2 +-
>   drivers/md/bcache/btree.c  | 27 ++++++++++++++++-----------
>   drivers/md/bcache/sysfs.c  |  3 ++-
>   3 files changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> index 5a79bb3c272f..c622bc50f81b 100644
> --- a/drivers/md/bcache/bcache.h
> +++ b/drivers/md/bcache/bcache.h
> @@ -541,7 +541,7 @@ struct cache_set {
>   	struct bio_set		bio_split;
>   
>   	/* For the btree cache */
> -	struct shrinker		shrink;
> +	struct shrinker		*shrink;
>   
>   	/* For the btree cache and anything allocation related */
>   	struct mutex		bucket_lock;
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index fd121a61f17c..c176c7fc77d9 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -667,7 +667,7 @@ static int mca_reap(struct btree *b, unsigned int min_order, bool flush)
>   static unsigned long bch_mca_scan(struct shrinker *shrink,
>   				  struct shrink_control *sc)
>   {
> -	struct cache_set *c = container_of(shrink, struct cache_set, shrink);
> +	struct cache_set *c = shrink->private_data;
>   	struct btree *b, *t;
>   	unsigned long i, nr = sc->nr_to_scan;
>   	unsigned long freed = 0;
> @@ -734,7 +734,7 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
>   static unsigned long bch_mca_count(struct shrinker *shrink,
>   				   struct shrink_control *sc)
>   {
> -	struct cache_set *c = container_of(shrink, struct cache_set, shrink);
> +	struct cache_set *c = shrink->private_data;
>   
>   	if (c->shrinker_disabled)
>   		return 0;
> @@ -752,8 +752,8 @@ void bch_btree_cache_free(struct cache_set *c)
>   
>   	closure_init_stack(&cl);
>   
> -	if (c->shrink.list.next)
> -		unregister_shrinker(&c->shrink);
> +	if (c->shrink)
> +		shrinker_unregister(c->shrink);
>   
>   	mutex_lock(&c->bucket_lock);
>   
> @@ -828,14 +828,19 @@ int bch_btree_cache_alloc(struct cache_set *c)
>   		c->verify_data = NULL;
>   #endif
>   
> -	c->shrink.count_objects = bch_mca_count;
> -	c->shrink.scan_objects = bch_mca_scan;
> -	c->shrink.seeks = 4;
> -	c->shrink.batch = c->btree_pages * 2;
> +	c->shrink = shrinker_alloc(0, "md-bcache:%pU", c->set_uuid);
> +	if (!c->shrink) {
> +		pr_warn("bcache: %s: could not allocate shrinker\n", __func__);
> +		return -ENOMEM;

Seems you have cheanged the semantic of this. In the past,
it is better to have a shrinker, but now it becomes a mandatory.
Right? I don't know if it is acceptable. From my point of view,
just do the cleanup, don't change any behaviour.

> +	}
> +
> +	c->shrink->count_objects = bch_mca_count;
> +	c->shrink->scan_objects = bch_mca_scan;
> +	c->shrink->seeks = 4;
> +	c->shrink->batch = c->btree_pages * 2;
> +	c->shrink->private_data = c;
>   
> -	if (register_shrinker(&c->shrink, "md-bcache:%pU", c->set_uuid))
> -		pr_warn("bcache: %s: could not register shrinker\n",
> -				__func__);
> +	shrinker_register(c->shrink);
>   
>   	return 0;
>   }
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index 0e2c1880f60b..45d8af755de6 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -866,7 +866,8 @@ STORE(__bch_cache_set)
>   
>   		sc.gfp_mask = GFP_KERNEL;
>   		sc.nr_to_scan = strtoul_or_return(buf);
> -		c->shrink.scan_objects(&c->shrink, &sc);
> +		if (c->shrink)
> +			c->shrink->scan_objects(c->shrink, &sc);
>   	}
>   
>   	sysfs_strtoul_clamp(congested_read_threshold_us,


