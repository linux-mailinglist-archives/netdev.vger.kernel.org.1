Return-Path: <netdev+bounces-96585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB9F8C68EC
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221CF1C20F85
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701AD155727;
	Wed, 15 May 2024 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WlGXC00U"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F281553A8
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784078; cv=none; b=acbYbJ28i6W7UXMuz/fleYgA6U0eTxrXjBt4DxItWPeyzllAl+mkVFAoXNX56QjEHgKQZ9LY02wwYkefHd0xOAYDp/lWkm/r/Sa7DXyD20mv7+tl5zA4Q7a5cHSBbNnapqtsQB7rnYyoPmR0ICxJqtwBTxw6Q7OabiD6SyeNxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784078; c=relaxed/simple;
	bh=Qy/VvClyjItna3Z71NC6Q0+ChyqPZvHzoT23NRjxlH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0Q0rsyoYkFMiXChbc5Q+FSM/KwATXwvvcytQIk9EtPpmYWHm3ZX1sy9thmrK2wlSG2/FOmbEO79IwgNUyRDQA9MzfYIYm0mmMpFJvSGGc4qUMzK+3ZB+zbkSrtuw6DN8B/3FsQX5wJfAizPH5NsBNC2PCQ7TYJY+0P7/aZmb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WlGXC00U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TpZxcbD7+RJosYvywScnhUpX3neggChT3dECqogwgGc=; b=WlGXC00U4Ted/uGnpAzgEaUuaq
	4xD0Jkkh7rslv7CWFnYnFNG7DqotfXKHo3yoQjFYgw5oCeDuVWILnGNgmnJP7R+DEFwLvD7nrGiTJ
	swS4OJP4zNlmYN/t8SDkzBsfJFbqZsmxFxtmzdMAjWCvWotCn1aA7FaNX9qcBGiMQg3A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7Fob-00FSSi-RW; Wed, 15 May 2024 16:41:09 +0200
Date: Wed, 15 May 2024 16:41:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <3130d582-a04c-4db5-b4a6-c02f213851be@lunn.ch>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>

> + * struct net_shaper_info - represents a shaping node on the NIC H/W
> + * @metric: Specify if the bw limits refers to PPS or BPS
> + * @bw_min: Minimum guaranteed rate for this shaper
> + * @bw_max: Maximum peak bw allowed for this shaper
> + * @burst: Maximum burst for the peek rate of this shaper
> + * @priority: Scheduling priority for this shaper
> + * @weight: Scheduling weight for this shaper
> + */
> +struct net_shaper_info {
> +	enum net_shaper_metric metric;
> +	u64 bw_min;	/* minimum guaranteed bandwidth, according to metric */
> +	u64 bw_max;	/* maximum allowed bandwidth */
> +	u32 burst;	/* maximum burst in bytes for bw_max */
> +	u32 priority;	/* scheduling strict priority */
> +	u32 weight;	/* scheduling WRR weight*/
> +};

...

> +	/** set - Update the specified shaper, if it exists
> +	 * @dev: Netdevice to operate on.
> +	 * @handle: the shaper identifier
> +	 * @shaper: Configuration of shaper.
> +	 * @extack: Netlink extended ACK for reporting errors.
> +	 *
> +	 * Return:
> +	 * * %0 - Success
> +	 * * %-EOPNOTSUPP - Operation is not supported by hardware, driver,
> +	 *                  or core for any reason. @extack should be set to
> +	 *                  text describing the reason.
> +	 * * Other negative error values on failure.
> +	 */
> +	int (*set)(struct net_device *dev, u32 handle,
> +		   const struct net_shaper_info *shaper,
> +		   struct netlink_ext_ack *extack);

> + * net_shaper_make_handle - creates an unique shaper identifier
> + * @scope: the shaper scope
> + * @vf: virtual function number
> + * @id: queue group or queue id
> + *
> + * Return: an unique identifier for the shaper
> + *
> + * Combines the specified arguments to create an unique identifier for
> + * the shaper.
> + * The virtual function number is only used within @NET_SHAPER_SCOPE_VF,
> + * @NET_SHAPER_SCOPE_QUEUE_GROUP and @NET_SHAPER_SCOPE_QUEUE.
> + * The @id number is only used for @NET_SHAPER_SCOPE_QUEUE_GROUP and
> + * @NET_SHAPER_SCOPE_QUEUE, and must be, respectively, the queue group
> + * identifier or the queue number.
> + */
> +u32 net_shaper_make_handle(enum net_shaper_scope scope, int vf, int id);

One thing i'm missing here is a function which does the opposite of
net_shaper_make_handle(). Given a handle, it returns the scope, vf and
the id.

When the set() op is called, i somehow need to find the software
instance representing the hardware block. If i know the id, it is just
an array access. Otherwise i need additional bookkeeping, maybe a
linked list of handles and pointers to structures etc.

Or net_shaper_make_handle() could maybe take an addition void * priv,
and provide a function void * net_shape_priv(u32 handle);

    Andrew


