Return-Path: <netdev+bounces-17981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF6753F27
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59661C20DEB
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BFF13AD2;
	Fri, 14 Jul 2023 15:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791DD521
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 15:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BBFC433C8;
	Fri, 14 Jul 2023 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689349222;
	bh=p3p6Og0Z4fCiXTSjfLnp4jo9We/cCE+HP1x6M5ILaA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EiKivC6BmKNGaq2NxW6kOxBD7T3w2I4HU0/Ja+8Bbg+p++EGtiDmBekc4/oTlj/jP
	 lMuctgLQ0mP3fVjj8kZFdbqBEEN+1Tj0+eC6znuWmaH4sJ6wCwuRY7nA3mcI+9m/W4
	 2Iomk6yL0/YIfS+YvEZ5cV7LsVuGKNROgMPwxbAGn1pPCTxbGtfhjMWJIGBYVDYWUs
	 imogAlOngAuDanZ/99lCt+CMkuR50bYiQqHgrKvPZ9ZFjLaNFLY2ZLgUehVHzSYBUM
	 AxZhi5hrO03KJ2EGpIHk9avzRerj6IBnh+X18rtn8WJqtJ0hrjUWIZBS0jDdPcgA20
	 e2OCLYTQLb21w==
Date: Fri, 14 Jul 2023 08:40:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com
Subject: Re: [patch net-next] devlink: introduce dump selector attr and
 implement it for port dumps
Message-ID: <20230714084021.51fea890@kernel.org>
In-Reply-To: <ZLEAsaKj+eKYlceM@nanopsycho>
References: <20230713151528.2546909-1-jiri@resnulli.us>
	<20230713205141.781b3759@kernel.org>
	<ZLEAsaKj+eKYlceM@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jul 2023 10:00:49 +0200 Jiri Pirko wrote:
> Fri, Jul 14, 2023 at 05:51:41AM CEST, kuba@kernel.org wrote:
> >On Thu, 13 Jul 2023 17:15:28 +0200 Jiri Pirko wrote:  
> >> +	/* If the user provided selector attribute with devlink handle, dump only
> >> +	 * objects that belong under this instance.
> >> +	 */
> >> +	if (cmd->dump_selector_nla_policy &&
> >> +	    attrs[DEVLINK_ATTR_DUMP_SELECTOR]) {
> >> +		struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
> >> +
> >> +		err = nla_parse_nested(tb, DEVLINK_ATTR_MAX,
> >> +				       attrs[DEVLINK_ATTR_DUMP_SELECTOR],
> >> +				       cmd->dump_selector_nla_policy,
> >> +				       cb->extack);
> >> +		if (err)
> >> +			return err;
> >> +		if (tb[DEVLINK_ATTR_BUS_NAME] && tb[DEVLINK_ATTR_DEV_NAME]) {
> >> +			devlink = devlink_get_from_attrs_lock(sock_net(msg->sk), tb);
> >> +			if (IS_ERR(devlink))
> >> +				return PTR_ERR(devlink);
> >> +			err = cmd->dump_one(msg, devlink, cb);
> >> +			devl_unlock(devlink);
> >> +			devlink_put(devlink);
> >> +			goto out;
> >> +		}  
> >
> >This implicitly depends on the fact that cmd->dump_one() will set and
> >pay attention to state->idx. If it doesn't kernel will infinitely dump
> >the same instance. I think we should explicitly check state->idx and
> >set it to 1 after calling ->dump_one.  
> 
> Nothing changes, only instead of iterating over multiple devlinks, we
> just work with one.
> 
> So, the state->idx is in-devlink-instance index. That means, after
> iterating to next devlink instance it is reset to 0 below (state->idx = 0;).
> Here however, as we stay only within a single devlink instance,
> the reset is not needed.
> 
> Am I missing something?

The case I was thinking of is if we support filtering of dumps which
do not have sub-objects. In that case state->idx does not get touched
by the dump_one.

Looking closer, tho, there's no case of this sort today, so my concern
is premature. Also what I suggested won't really work. So ignore this
comment, sorry :)

