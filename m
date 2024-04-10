Return-Path: <netdev+bounces-86368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745D589E7E5
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 03:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874CA1C20EE8
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDBEA5F;
	Wed, 10 Apr 2024 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjMP09ap"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1337C;
	Wed, 10 Apr 2024 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712713442; cv=none; b=prdINOa/Kmq/mbTvEpVvH+qSsq9AMI6CtrOZhqSciuZSS3bQNpm8fQJS33Mayjf3SlPyMB2ZlW5XCt4elOT6lbOkr3OlRxt9AVXDnaHjCSwVfuOLbcL28n+/5OjCznvMYeBhm/qPEakjgSX7EUT63ackAvaaKpuI5wzCDW240jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712713442; c=relaxed/simple;
	bh=qYOChTpajn74y/ZZBnjUt178KiphhdOmGOzkpms/EuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3D3iVYCR0zQ8MqUV6Oy6GyhLcl/bpJ8wsUvGfwookmGo7I/yUNFivNfSf8egbRYqnJhm9zFiHufMnpxTILjhSwCMjyKE67p7L0WxqY55pYkNT0BgWTq+B5HsQQica3uJV1miRBLoAAluhTb9KgeALJyuX1+ZFJBHFR3PPVdeZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjMP09ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF63C433F1;
	Wed, 10 Apr 2024 01:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712713441;
	bh=qYOChTpajn74y/ZZBnjUt178KiphhdOmGOzkpms/EuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FjMP09apZsVxdvsmBWN6YnI5iMVkpxzqslSMg4L6m/MPNS9nbBQkfTx/W2OGz9Uze
	 QyCj9cujnN0AJRt4k9lcR/jTnJfY94uufgoP8wqSVPiLhXwg6Q0YHV3guVYlmq/2Yz
	 fE6Vgu3v3aW5eWtrXKgyziIwCCQMq37AfGXqcfV5Xu2j+OlY9qFYYYc/Ho+65JSA9M
	 /7XA5Ke3D4BU4JyWded0V+5S6QJnxrZ9UhtkuYE2HoxfQJupPAlXPnnSkNozrrKk57
	 0BoyXYfnNXHKm6ONjBS0fLfpeatlVBsdm91AY8At1W1PHOJaqeybhX6vmgw5U5e9u1
	 +U9EdEpac1BNQ==
Date: Tue, 9 Apr 2024 18:44:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 1/4] ethtool: provide customized dim profile
 management
Message-ID: <20240409184400.4e5444f3@kernel.org>
In-Reply-To: <1712664204-83147-2-git-send-email-hengqi@linux.alibaba.com>
References: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
	<1712664204-83147-2-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Apr 2024 20:03:21 +0800 Heng Qi wrote:
> +/**
> + * coalesce_put_profile - fill reply with a nla nest with four child nla nests.
> + * @skb: socket buffer the message is stored in
> + * @attr_type: nest attr type ETHTOOL_A_COALESCE_*X_*QE_PROFILE
> + * @profile: data passed to userspace
> + * @supported_params: modifiable parameters supported by the driver
> + *
> + * Put a dim profile nest attribute. Refer to ETHTOOL_A_MODERATIONS_MODERATION.

unfortunately kdoc got more picky and it also wants us to document
return values now, you gotta add something like

 * Returns: true if ..

actually this functions seems to return negative error codes as bool..

> +static bool coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
> +				 const struct dim_cq_moder *profile,
> +				 u32 supported_params)
> +{
> +	struct nlattr *profile_attr, *moder_attr;
> +	bool valid = false;
> +	int i;
> +
> +	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
> +		if (profile[i].usec || profile[i].pkts || profile[i].comps) {
> +			valid = true;
> +			break;
> +		}
> +	}
> +
> +	if (!valid || !(supported_params & attr_to_mask(attr_type)))
> +		return false;
> +
> +	profile_attr = nla_nest_start(skb, attr_type);
> +	if (!profile_attr)
> +		return -EMSGSIZE;
> +
> +	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
> +		moder_attr = nla_nest_start(skb, ETHTOOL_A_MODERATIONS_MODERATION);
> +		if (!moder_attr)
> +			goto nla_cancel_profile;
> +
> +		if (nla_put_u16(skb, ETHTOOL_A_MODERATION_USEC, profile[i].usec) ||
> +		    nla_put_u16(skb, ETHTOOL_A_MODERATION_PKTS, profile[i].pkts) ||
> +		    nla_put_u16(skb, ETHTOOL_A_MODERATION_COMPS, profile[i].comps))

u16 in netlink is almost always the wrong choice, sizes are rounded 
up to 4B, anyway, let's use u32 at netlink level.

