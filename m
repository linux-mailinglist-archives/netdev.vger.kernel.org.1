Return-Path: <netdev+bounces-230164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EF1BE4DDC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE7C8509035
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68714156230;
	Thu, 16 Oct 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8vE5wMm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204CD3346B6
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636046; cv=none; b=JNoPpSaYvImsJlrBayC7AsmX41xux2gcU9LGFhyyOY+XnIH0mbv41+I9uV4TbYiki/JMu4NI6hiJmMKOqul1s2iiJIhLNO7qPGEbAHP2UzfD1gNz5wuJToBCF3AO4N3wn1eNMTMs/4GR/FZAvw73f5fZSZo5zW7Da29sWswNdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636046; c=relaxed/simple;
	bh=M8Iom2JIsvSON7igHQsc1lNqP9D/E554guRlKjkrA34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXjcm0PrWci3VKfS6vdrL5M0tFZ8+wyaJ1qyM7gIhE8cJAlJdITa9FgUFxeUSf45Uvx/VXTxFVwOG/FXPPLRD+gjYSQRDQGUliQg8GCK3VRhqco+OfEBr04yTQ7FN3ifZQGVOO7wTXlZnmn8zlUMa3Hj7yEOIuL4zcn6VJkgT+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8vE5wMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC80C4CEF1;
	Thu, 16 Oct 2025 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760636045;
	bh=M8Iom2JIsvSON7igHQsc1lNqP9D/E554guRlKjkrA34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8vE5wMmnSeVY22kpgRUP9xj2/zDXl9A646qr4gJkOmFG6z03CWRdqgC5hc0Dgdrg
	 vupYRCH1LF4igti+QCJlADnMMFqqYzRYHkjRmNLuhizPlcjTSGHIf09RzAjiN6tXyl
	 R1sNodrqxf0K9aJEYoOzABOFT5hOQNSOjRyY6OAa7gUb/zTugu3gCIbmMG1pBo0qA5
	 FBo3sV2h8Y1+XKOf2FRxQMiLKdRor4EKXC8CkMFeZgbdYuAEg3x0zsIUcLQXaUNGc/
	 brqtkKiLT3j3cc0pwPNf4SM9I4WFXzlrM87Ojyr+/Q9ku6HtZYKl5wAi0oaaAD7DBL
	 y+NmIYSFDq6hg==
Date: Thu, 16 Oct 2025 10:34:04 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com,
	Parav Pandit <parav@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next 1/3] devlink: Introduce devlink eswitch state
Message-ID: <aPEsjG-mFIx-IqtV@x130>
References: <20251016013618.2030940-1-saeed@kernel.org>
 <20251016013618.2030940-2-saeed@kernel.org>
 <6uzvaczuh6vpflpwnyknmq32ogcw52u35djzab7yd7jlgwasdc@paq2c2yznfti>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6uzvaczuh6vpflpwnyknmq32ogcw52u35djzab7yd7jlgwasdc@paq2c2yznfti>

On 16 Oct 11:16, Jiri Pirko wrote:
>Thu, Oct 16, 2025 at 03:36:16AM +0200, saeed@kernel.org wrote:
>>From: Parav Pandit <parav@nvidia.com>
>
>[...]
>
>
>>@@ -722,6 +734,24 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
>> 			return err;
>> 	}
>>
>>+	state = DEVLINK_ESWITCH_STATE_ACTIVE;
>>+	if (info->attrs[DEVLINK_ATTR_ESWITCH_STATE]) {
>>+		if (!ops->eswitch_state_set)
>>+			return -EOPNOTSUPP;
>>+		state = nla_get_u8(info->attrs[DEVLINK_ATTR_ESWITCH_STATE]);
>>+	}
>>+	/* If user did not supply the state attribute, the default is
>>+	 * active state. If the state was not explicitly set, set the default
>>+	 * state for drivers that support eswitch state.
>>+	 * Keep this after mode-set as state handling can be dependent on
>>+	 * the eswitch mode.
>>+	 */
>>+	if (ops->eswitch_state_set) {
>>+		err = ops->eswitch_state_set(devlink, state, info->extack);
>
>Calling state_set() upon every DEVLINK_CMD_ESWITCH_SET call,
>even if STATE attr is not present, is plain wrong. Don't do it.
>I don't really understand why you do so.
>

I don't get the "plain wrong" part? Please explain.

Here's is what we are trying to solve and why I think this way is the best
way to solve it, unless you have a better idea.

We want to preserve backwards compatibility, think of:
  - old devlink iproute2 (doesn't provide STATE attr).
  - new kernel (expects new STATE attr).

Upon your request we split mode and state handling into separate callbacks,
meaning, you set mode first and then state in DEVLINK_CMD_ESWITCH_SET.

ops->mode_set(); doesn't have information on state, so a drivers that
implement state_set() will expect state_set() to be called after
mode_set(), otherwise, state will remain inactive for that driver.

If state attr is not provided (e.g. old devlink userspace) but the user
expects state to be active, then if we do what you ask for, we don't
call state_set() and after mode_set() we will be in an inactive state,
while user expects active (default behavior) for backward compatibility.

To solve this we always default state = ACTIVE (if state attr wasn't
provided) and call state_set();

Let me know if you have better ideas, on how to solve this problem.
Otherwise, this patch's way of preserving backward compatibility is 
not "plain wrong".

We can optimize to call set_state() only if (mode || state) attr was
provided. Let me know if that works for you.

- Saeed.

