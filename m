Return-Path: <netdev+bounces-27980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A330177DCF3
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581B428189B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D0DD523;
	Wed, 16 Aug 2023 09:07:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F54C2F0
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78BDC433C8;
	Wed, 16 Aug 2023 09:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692176820;
	bh=Iuy0Gisle5v0gS87Y/2h4udgh2jtKlrJ2U2AXRc0r7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulhTVwWHnsd5snyDbFRntHvkW/IBlzjU96A9Gn2uD0QsezsIEffSFquC7IPDkdsbG
	 5NnHOeYRtvjUDwI5PnCYn7Uxa73qQ9GFKoC+RC5lJOmfFHVUS+yN0tueSJcyyOpYMD
	 9w/4Q1Xi6le9siun+XJkBJPCqGtdVfPaa6cPdmQF1focMw9YM/MQxenJF4iLT6yE7T
	 8a7HEgCN1EHbl5sm/i/QIpzFNrKX1QzwSX7plMg47CKS781+mWgt5yv+v+G2tAHmcq
	 ur/ENKnBvFEarn6XpnCatM8VRZZ15xTOm8IIbQ7nY5rUt/07KSgJhXJ42hApYIi4a+
	 lu80vTxnnKx2g==
Date: Wed, 16 Aug 2023 11:06:56 +0200
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
	vladbu@nvidia.com, mleitner@redhat.com,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH RFC net-next 3/3] Introduce blockcast tc action
Message-ID: <ZNyRsOB0nfqhZM1m@vergenet.net>
References: <20230815162530.150994-1-jhs@mojatatu.com>
 <20230815162530.150994-4-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815162530.150994-4-jhs@mojatatu.com>

On Tue, Aug 15, 2023 at 12:25:30PM -0400, Jamal Hadi Salim wrote:
> This action takes advantage of the presence of tc block ports set in the
> datapath and broadcast a packet to all ports on that set with exception of
> the port in which it arrived on..
> 
> Example usage:
>     $ tc qdisc add dev ens7 ingress block 22
>     $ tc qdisc add dev ens8 ingress block 22
> 
> Now we can add a filter using the block index:
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action blockcast
> 
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

...

> +//XXX: Refactor mirred code and reuse here before final version
> +static int cast_one(struct sk_buff *skb, const u32 ifindex)
> +{
> +	struct sk_buff *skb2 = skb;
> +	int retval = TC_ACT_PIPE;
> +	struct net_device *dev;
> +	unsigned int rec_level;
> +	bool expects_nh;
> +	int mac_len;
> +	bool at_nh;
> +	int err;
> +
> +	rec_level = __this_cpu_inc_return(redirect_rec_level);
> +	if (unlikely(rec_level > CAST_RECURSION_LIMIT)) {
> +		net_warn_ratelimited("blockcast: exceeded redirect recursion limit on dev %s\n",
> +				     netdev_name(skb->dev));
> +		__this_cpu_dec(redirect_rec_level);
> +		return TC_ACT_SHOT;
> +	}
> +
> +	dev = dev_get_by_index_rcu(dev_net(skb->dev), ifindex);
> +	if (unlikely(!dev)) {
> +		pr_notice_once("blockcast: target device %s is gone\n",
> +			       dev->name);

Hi Jamal,

This code is only executed if dev is NULL, but dev is dereferenced.

> +		__this_cpu_dec(redirect_rec_level);
> +		return TC_ACT_SHOT;
> +	}

...

