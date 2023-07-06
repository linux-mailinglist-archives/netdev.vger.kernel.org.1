Return-Path: <netdev+bounces-15813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220EF749F16
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE76628135D
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A348F4F;
	Thu,  6 Jul 2023 14:35:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE08C19
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 14:35:03 +0000 (UTC)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF354E5
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 07:35:00 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QxfFG26stzMqvsW;
	Thu,  6 Jul 2023 14:34:58 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QxfFF36qHzMpr1M;
	Thu,  6 Jul 2023 16:34:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1688654098;
	bh=Al8MPGnendAoYtffWyrnkzctwTz9tkzB4l1vsKqhTOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cBGKGqNfxrIcI1wUmW85uDN6vGH4Bb0NOHs1T4VdHq6bEOcmsXJa6A8C0RkwfUtcj
	 Dy/tPFaE7tDHwGm9m/GZBdvHu+7E7ueIikVhVLX2iBDy/otIxzjv66/Ynlut6dE2Ht
	 7TgMgqZtOW2DuLqCCgwS6KztUKWiI8w3Nn2ZxZ6Y=
Message-ID: <ac3c0b76-01a9-b36f-63a2-734250d486b2@digikod.net>
Date: Thu, 6 Jul 2023 16:34:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent:
Subject: Re: [PATCH v11 03/12] landlock: Refactor
 landlock_find_rule/insert_rule
Content-Language: en-US
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, yusongping@huawei.com,
 artem.kuzin@huawei.com
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-4-konstantin.meskhidze@huawei.com>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230515161339.631577-4-konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 15/05/2023 18:13, Konstantin Meskhidze wrote:
> Add a new landlock_key union and landlock_id structure to support
> a socket port rule type. A struct landlock_id identifies a unique entry
> in a ruleset: either a kernel object (e.g inode) or typed data (e.g TCP
> port). There is one red-black tree per key type.
> 
> This patch also adds is_object_pointer() and get_root() helpers.
> is_object_pointer() returns true if key type is LANDLOCK_KEY_INODE.
> get_root() helper returns a red_black tree root pointer according to
> a key type.
> 
> Refactor landlock_insert_rule() and landlock_find_rule() to support coming
> network modifications. Adding or searching a rule in ruleset can now be
> done thanks to a Landlock ID argument passed to these helpers.
> 
> Co-developed-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---

[...]

> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 1f3188b4e313..deab37838f5b 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -35,7 +35,7 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>   		return ERR_PTR(-ENOMEM);
>   	refcount_set(&new_ruleset->usage, 1);
>   	mutex_init(&new_ruleset->lock);
> -	new_ruleset->root = RB_ROOT;
> +	new_ruleset->root_inode = RB_ROOT;
>   	new_ruleset->num_layers = num_layers;
>   	/*
>   	 * hierarchy = NULL
> @@ -68,8 +68,18 @@ static void build_check_rule(void)
>   	BUILD_BUG_ON(rule.num_layers < LANDLOCK_MAX_NUM_LAYERS);
>   }
> 
> +static bool is_object_pointer(const enum landlock_key_type key_type)
> +{
> +	switch (key_type) {
> +	case LANDLOCK_KEY_INODE:
> +		return true;

> +	}


Because of enum change [1], could you please put the following block 
inside this commit's switch with a new "default:" case, and add a line 
break after the previous return like this:

\n
default:
> +	WARN_ON_ONCE(1);
> +	return false;

break;
}

> +}
> +
>   static struct landlock_rule *
> -create_rule(struct landlock_object *const object,
> +create_rule(const struct landlock_id id,
>   	    const struct landlock_layer (*const layers)[], const u32 num_layers,
>   	    const struct landlock_layer *const new_layer)
>   {
> @@ -90,8 +100,13 @@ create_rule(struct landlock_object *const object,
>   	if (!new_rule)
>   		return ERR_PTR(-ENOMEM);
>   	RB_CLEAR_NODE(&new_rule->node);
> -	landlock_get_object(object);
> -	new_rule->object = object;
> +	if (is_object_pointer(id.type)) {
> +		/* This should be catched by insert_rule(). */
> +		WARN_ON_ONCE(!id.key.object);
> +		landlock_get_object(id.key.object);
> +	}
> +
> +	new_rule->key = id.key;
>   	new_rule->num_layers = new_num_layers;
>   	/* Copies the original layer stack. */
>   	memcpy(new_rule->layers, layers,
> @@ -102,12 +117,29 @@ create_rule(struct landlock_object *const object,
>   	return new_rule;
>   }
> 
> -static void free_rule(struct landlock_rule *const rule)
> +static struct rb_root *get_root(struct landlock_ruleset *const ruleset,
> +				const enum landlock_key_type key_type)
> +{

Same here, you can remove the "root" variable:

> +	struct rb_root *root = NULL;
> +
> +	switch (key_type) {
> +	case LANDLOCK_KEY_INODE:
> +		root = &ruleset->root_inode;
> +		break;

return &ruleset->root_inode;
\n
default:
> +	if (WARN_ON_ONCE(!root))
> +		return ERR_PTR(-EINVAL);
break;
}

> +}

Actually, I've pushed this change here: 
https://git.kernel.org/mic/c/8c96c7eee3ff (landlock-net-v11 branch)

