Return-Path: <netdev+bounces-24098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8D076EC07
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8948F282272
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C706C200CA;
	Thu,  3 Aug 2023 14:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEA33D8E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 14:11:57 +0000 (UTC)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610661BD5
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:11:55 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RGrPj3w4wzMpvQs;
	Thu,  3 Aug 2023 14:11:53 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RGrPj12PRzMppDL;
	Thu,  3 Aug 2023 16:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1691071913;
	bh=0Lr/X9xvu90gp+BVwk3QWde3xY2K+G94l41qvIHjpR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9hX0+XBnMFlwqnHzE6bK6QhYlZoIGDAScNSJ5LR+fuz5PNwrRo8/wl+TlRXzKt7T
	 rQ1H5R3l0FGgslfPQFvNyT+8XBTD1QY3Vz1w2iO4tvK+C3/NCDJV5zSY3KyxNEz19I
	 mEwJAujcIbDw3QqSLKltWiJFhErY6ksW6ZwBKqvA=
Date: Thu, 3 Aug 2023 16:12:02 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com
Subject: Re: [PATCH v11 08/12] landlock: Add network rules and TCP hooks
 support
Message-ID: <20230803.EiD9Ea1Iel0f@digikod.net>
References: <20230515161339.631577-1-konstantin.meskhidze@huawei.com>
 <20230515161339.631577-9-konstantin.meskhidze@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515161339.631577-9-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 12:13:35AM +0800, Konstantin Meskhidze wrote:
> This commit adds network rules support in the ruleset management
> helpers and the landlock_create_ruleset syscall.
> Refactor user space API to support network actions. Add new network
> access flags, network rule and network attributes. Increment Landlock
> ABI version. Expand access_masks_t to u32 to be sure network access
> rights can be stored. Implement socket_bind() and socket_connect()
> LSM hooks, which enables to restrict TCP socket binding and connection
> to specific ports.
> 
> Co-developed-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---

[...]

> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 8a54e87dbb17..5cb0a1bc6ec0 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c

[...]

> +static int add_rule_net_service(struct landlock_ruleset *ruleset,
> +				const void __user *const rule_attr)
> +{
> +#if IS_ENABLED(CONFIG_INET)

We should define two add_rule_net_service() functions according to
IS_ENABLED(CONFIG_INET) instead of changing the body of the only
function.  The second function would only return -EAFNOSUPPORT.  This
cosmetic change would make the code cleaner.


> +	struct landlock_net_service_attr net_service_attr;
> +	int res;
> +	access_mask_t mask;
> +
> +	/* Copies raw user space buffer, only one type for now. */
> +	res = copy_from_user(&net_service_attr, rule_attr,
> +			     sizeof(net_service_attr));
> +	if (res)
> +		return -EFAULT;
> +
> +	/*
> +	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
> +	 * are ignored by network actions.
> +	 */
> +	if (!net_service_attr.allowed_access)
> +		return -ENOMSG;
> +
> +	/*
> +	 * Checks that allowed_access matches the @ruleset constraints
> +	 * (ruleset->access_masks[0] is automatically upgraded to 64-bits).
> +	 */
> +	mask = landlock_get_net_access_mask(ruleset, 0);
> +	if ((net_service_attr.allowed_access | mask) != mask)
> +		return -EINVAL;
> +
> +	/* Denies inserting a rule with port 0 or higher than 65535. */
> +	if ((net_service_attr.port == 0) || (net_service_attr.port > U16_MAX))
> +		return -EINVAL;
> +
> +	/* Imports the new rule. */
> +	return landlock_append_net_rule(ruleset, net_service_attr.port,
> +					net_service_attr.allowed_access);
> +#else /* IS_ENABLED(CONFIG_INET) */
> +	return -EAFNOSUPPORT;
> +#endif /* IS_ENABLED(CONFIG_INET) */
> +}

