Return-Path: <netdev+bounces-20996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4676219B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291C7281A64
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A12592B;
	Tue, 25 Jul 2023 18:40:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0429521D52
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F9CC433C7;
	Tue, 25 Jul 2023 18:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690310445;
	bh=tqR4+Qpg6YJZlSeZ0gM0nXOm5XD0KpcdGClcMwmXJTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rpnfg3TRAq1hGtpeivuo7h9TxuZV8jgUWy+00KCEYX0KwUNRgU7RBa0oafCW77Aou
	 tcp3YCXGmqiChWnwiTsOnbpx9ZJUpz9FyNc+cfk3M/HIJpJKuTjpjcVnTQSlEr2DiA
	 y5mHG2a5qmcyc7UFTrFkTGC5F363lOWSfi3OBVlI42TEPePcV3cxR6dUUsa6SpLxmT
	 x3UKRKXa0Ggg6JU4ck5oD0h96uoK2HXpJSu1Kj+Gb6vCI8hBOl2hd5XcGeL0Y6tPwG
	 ncCaTvuwMhpVgTJEK5YxcBiNISsMThPybal173CJyZ0/BBpnNZeurvI/y7ekyLmQXo
	 Ks2dsI39y0K3g==
Date: Tue, 25 Jul 2023 11:40:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 10/11] devlink: introduce dump selector attr
 and use it for per-instance dumps
Message-ID: <20230725114044.402450df@kernel.org>
In-Reply-To: <20230720121829.566974-11-jiri@resnulli.us>
References: <20230720121829.566974-1-jiri@resnulli.us>
	<20230720121829.566974-11-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 14:18:28 +0200 Jiri Pirko wrote:
> +static void devlink_nl_policy_cpy(struct nla_policy *policy, unsigned int attr)
> +{
> +	memcpy(&policy[attr], &devlink_nl_policy[attr], sizeof(*policy));
> +}
> +
> +static void devlink_nl_dump_selector_policy_init(const struct devlink_cmd *cmd,
> +						 struct nla_policy *policy)
> +{
> +	devlink_nl_policy_cpy(policy, DEVLINK_ATTR_BUS_NAME);
> +	devlink_nl_policy_cpy(policy, DEVLINK_ATTR_DEV_NAME);
> +}
> +
> +static int devlink_nl_start(struct netlink_callback *cb)
> +{
> +	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
> +	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
> +	struct nlattr **attrs = info->attrs;
> +	const struct devlink_cmd *cmd;
> +	struct nla_policy *policy;
> +	struct nlattr **selector;
> +	int err;
> +
> +	if (!attrs[DEVLINK_ATTR_DUMP_SELECTOR])
> +		return 0;
> +
> +	selector = kzalloc(sizeof(*selector) * (DEVLINK_ATTR_MAX + 1),
> +			   GFP_KERNEL);
> +	if (!selector)
> +		return -ENOMEM;
> +	policy = kzalloc(sizeof(*policy) * (DEVLINK_ATTR_MAX + 1), GFP_KERNEL);
> +	if (!policy) {
> +		kfree(selector);
> +		return -ENOMEM;
> +	}
> +
> +	cmd = devl_cmds[info->op.cmd];
> +	devlink_nl_dump_selector_policy_init(cmd, policy);
> +	err = nla_parse_nested(selector, DEVLINK_ATTR_MAX,
> +			       attrs[DEVLINK_ATTR_DUMP_SELECTOR],
> +			       policy, cb->extack);
> +	kfree(policy);
> +	if (err) {
> +		kfree(selector);
> +		return err;
> +	}
> +
> +	state->selector = selector;
> +	return 0;
> +}

Why not declare a fully nested policy with just the two attrs?

Also - do you know of any userspace which would pass garbage attrs 
to the dumps? Do we really need to accept all attributes, or can
we trim the dump policies to what's actually supported?
-- 
pw-bot: cr

