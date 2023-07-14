Return-Path: <netdev+bounces-17767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A2C75302A
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BAC1C214F7
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 03:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7217E3D71;
	Fri, 14 Jul 2023 03:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B28187A
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 03:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66FEC433C9;
	Fri, 14 Jul 2023 03:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689306702;
	bh=bDKU0i8AZGL8hw1FyYebUWf6iwpkO6JJDY035oXePeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bx6Yv6993gZc14YaOkBnMyzbNszFjw1c/B4RWVjRUWJh1mHBq2adxNd+16zViHiEY
	 OTFgSSepKaH49KB+EXv8B8aYja0ERgqBF6cWkjrf6piehtLEHwe4egPdqXRAiV+KU3
	 ElGBnRa4uGjHpn0X9Hujg7jvQADgrQenY7Z2Jd+9vE8kk1vtlgN3SZ/Wq8VamAR8n3
	 Am3K7UtfDYEREilaSEDEBMpf6utBE7cDijEc4L/TiNl1qhHN92zqS7oZr7DHMrot/p
	 Uf4co7k1q/CfcvdFtEQSigvDnzCw7eTwgmO80LyStEa3jSl9UlbMs1mwjPOCZzEdhq
	 T+GG8RAssxvMw==
Date: Thu, 13 Jul 2023 20:51:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com
Subject: Re: [patch net-next] devlink: introduce dump selector attr and
 implement it for port dumps
Message-ID: <20230713205141.781b3759@kernel.org>
In-Reply-To: <20230713151528.2546909-1-jiri@resnulli.us>
References: <20230713151528.2546909-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 17:15:28 +0200 Jiri Pirko wrote:
> +	/* If the user provided selector attribute with devlink handle, dump only
> +	 * objects that belong under this instance.
> +	 */
> +	if (cmd->dump_selector_nla_policy &&
> +	    attrs[DEVLINK_ATTR_DUMP_SELECTOR]) {
> +		struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
> +
> +		err = nla_parse_nested(tb, DEVLINK_ATTR_MAX,
> +				       attrs[DEVLINK_ATTR_DUMP_SELECTOR],
> +				       cmd->dump_selector_nla_policy,
> +				       cb->extack);
> +		if (err)
> +			return err;
> +		if (tb[DEVLINK_ATTR_BUS_NAME] && tb[DEVLINK_ATTR_DEV_NAME]) {
> +			devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), tb);
> +			if (IS_ERR(devlink))
> +				return PTR_ERR(devlink);
> +			err = cmd->dump_one(msg, devlink, cb);
> +			devl_unlock(devlink);
> +			devlink_put(devlink);
> +			goto out;
> +		}

This implicitly depends on the fact that cmd->dump_one() will set and
pay attention to state->idx. If it doesn't kernel will infinitely dump
the same instance. I think we should explicitly check state->idx and
set it to 1 after calling ->dump_one.

Could you also move the filtered dump to a separate function which
either does this or calls devlink_nl_instance_iter_dumpit()?
I like the concise beauty that devlink_nl_instance_iter_dumpit()
currently is, it'd be a shame to side load it with other logic :]

> +	}
> +
>  	while ((devlink = devlinks_xa_find_get(sock_net(msg->sk),
>  					       &state->instance))) {
>  		devl_lock(devlink);
> @@ -228,6 +259,7 @@ int devlink_nl_instance_iter_dumpit(struct sk_buff *msg,
>  		state->idx = 0;
>  	}
>  
> +out:
>  	if (err != -EMSGSIZE)
>  		return err;
>  	return msg->len;
-- 
pw-bot: cr

