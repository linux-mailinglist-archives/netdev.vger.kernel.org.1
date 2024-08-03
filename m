Return-Path: <netdev+bounces-115496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77D8946ACA
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 20:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3771C206A5
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 18:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B453215EA6;
	Sat,  3 Aug 2024 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="yVv+xTCp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34A6FA8
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722708695; cv=none; b=M4DkOHcKz1JxpOcnLu2S0SXBVlukHwUWVbtetkHBozEH4Fv9VeHWQ80hZHkZ1XIKqzQoCcL+X7owF0ZVefn4t4DvGNqCSGM3+WqyPvbhnxNSdkMjSIywEDu6FX+rCON0tVzTOHgcFT+Gh4QJO4tm4L0KwREbXiQ7P78FRfOZt2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722708695; c=relaxed/simple;
	bh=85mzIHVbmDPqY5YzUVuesEGlJqqJKFDiJr87xUFtWO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUp+njEEpY8mFjDrA1TJmw/aV/1OUfnTeZNtMFbNLOY+fc1Yi1zDZcGZY+zfrGaCuQy5TqvjpHc/zfc7hW7CJkJrnIOQFScKB65DolMSun7vzWnvONK9HtwPjAnWKu/IssVHuC34pV/SXTh99kmjxU32vW6rdHJLI8AkU5xyAu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=yVv+xTCp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428101fa30aso62307445e9.3
        for <netdev@vger.kernel.org>; Sat, 03 Aug 2024 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722708692; x=1723313492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYjcSPjVDWfsXNZ8//s5IwKpmiouYrrwAo6x+rTr3K4=;
        b=yVv+xTCpqq7KhHT3AkXO89uXT/lZLSG0iyWHxQfgIMFatDOF7RAjE90Mk3I5Uqo0Fp
         +PHs2V8QRXWHPHWH60N2PCy6TWvke5ZVRKFe14SAg6L0JPOmxllqXdtxEUtOE8YN2LBK
         cQJhCZT3sWAc7dcJy5jEs+5KSBJ1g5AvZjubc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722708692; x=1723313492;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYjcSPjVDWfsXNZ8//s5IwKpmiouYrrwAo6x+rTr3K4=;
        b=rx+K5bXNxkU3Fc4deQewcWQX+1vnucdbBKTnGqFR2jaSXwIwW5tWp84o3Pz9a648PJ
         xa7ohfegG0qyEWDe5ir4H6KK9gXK5Y0/A95/UH6J4dqAYcN2nX0BUiuaAs7gDWxrE10a
         W5HZtSoE4aupQKpZ38oYMuwqOW/3QP9z8RnHNox5VLoCmFWwiWS8Nr3wQJ0bZytweUhF
         J+AofUmk+uIXlo7+KTs9zBxcW7OVWLJLUeZE19xcgz4Rp55xwlksr80dR/6xGlYZ7Az0
         s0cJ2J5L7cw4hmEzeElszp076uUusIh90jTARnMYphX9sTzEjYDUByNgbID79VBoSsW7
         v8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9ErdLgefXWTwEeJzQI018bl1ai6++tGM8ZL7+BMcA4Y5rjHjITnp7qaO0DWpCBjJJ+cQDtsByeVWVJUgGXSEjQc6iIRKJ
X-Gm-Message-State: AOJu0Yx/XAz8H/xyX/tJ/tFa68eSwcclrLnVwjjQ0dUbXG7Q2rBbDWGr
	z9SfVJ2IJuZqcqImDFEkFJeKqt84V0RGIqC7s+ey66p3I4u/iQc79XPAc5utnC8=
X-Google-Smtp-Source: AGHT+IFLB3u2Nf5Y0eIKVho5hdTAbx6xF0dA7eyXWE0JIGSZsUQ4WFj9jmCQH2I0xaBhMxNWiSofjA==
X-Received: by 2002:a05:600c:45cd:b0:426:66e9:b844 with SMTP id 5b1f17b1804b1-428e6aeb0b3mr55176835e9.8.1722708691736;
        Sat, 03 Aug 2024 11:11:31 -0700 (PDT)
Received: from LQ3V64L9R2 ([2a04:4a43:869f:fd54:881:c465:d85d:e827])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1e180sm4897288f8f.34.2024.08.03.11.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 11:11:31 -0700 (PDT)
Date: Sat, 3 Aug 2024 19:11:28 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
	gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v2 09/12] ethtool: rss: support dumping RSS
 contexts
Message-ID: <Zq5y0DvXQpBdOEeA@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-10-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803042624.970352-10-kuba@kernel.org>

On Fri, Aug 02, 2024 at 09:26:21PM -0700, Jakub Kicinski wrote:
> Now that we track RSS contexts in the core we can easily dump
> them. This is a major introspection improvement, as previously
> the only way to find all contexts would be to try all ids
> (of which there may be 2^32 - 1).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Thanks for doing this important and extremely useful work. I am
personally very excited to see this data available to userland.

[...]

> diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
> index 023782ca1230..62e7b6fe605d 100644
> --- a/net/ethtool/rss.c
> +++ b/net/ethtool/rss.c
> @@ -208,6 +208,139 @@ static void rss_cleanup_data(struct ethnl_reply_data *reply_base)
>  	kfree(data->indir_table);
>  }
>  
> +struct rss_nl_dump_ctx {
> +	unsigned long		ifindex;
> +	unsigned long		ctx_idx;
> +
> +	unsigned int		one_ifindex;

My apologies: I'm probably just not familiar enough with the code,
but I'm having a hard time understanding what the purpose of
one_ifindex is.

I read both ethnl_rss_dump_start and ethnl_rss_dumpit, but I'm still
not following what this is used for; it'll probably be obvious in
retrospect once you explain it, but I suppose my feedback is that a
comment or something would be really helpful :)

> +};
> +
> +static struct rss_nl_dump_ctx *rss_dump_ctx(struct netlink_callback *cb)
> +{
> +	NL_ASSERT_DUMP_CTX_FITS(struct rss_nl_dump_ctx);
> +
> +	return (struct rss_nl_dump_ctx *)cb->ctx;
> +}
> +
> +int ethnl_rss_dump_start(struct netlink_callback *cb)
> +{
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct rss_nl_dump_ctx *ctx = rss_dump_ctx(cb);
> +	struct ethnl_req_info req_info = {};
> +	struct nlattr **tb = info->attrs;
> +	int ret;
> +
> +	/* Filtering by context not supported */
> +	if (tb[ETHTOOL_A_RSS_CONTEXT]) {
> +		NL_SET_BAD_ATTR(info->extack, tb[ETHTOOL_A_RSS_CONTEXT]);
> +		return -EINVAL;
> +	}
> +
> +	ret = ethnl_parse_header_dev_get(&req_info,
> +					 tb[ETHTOOL_A_RSS_HEADER],
> +					 sock_net(cb->skb->sk), cb->extack,
> +					 false);
> +	if (req_info.dev) {
> +		ctx->one_ifindex = req_info.dev->ifindex;
> +		ctx->ifindex = ctx->one_ifindex;
> +		ethnl_parse_header_dev_put(&req_info);
> +		req_info.dev = NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +rss_dump_one_ctx(struct sk_buff *skb, struct netlink_callback *cb,
> +		 struct net_device *dev, u32 rss_context)
> +{
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct rss_reply_data data = {};
> +	struct rss_req_info req = {};
> +	void *ehdr;
> +	int ret;
> +
> +	req.rss_context = rss_context;
> +
> +	ehdr = ethnl_dump_put(skb, cb, ETHTOOL_MSG_RSS_GET_REPLY);
> +	if (!ehdr)
> +		return -EMSGSIZE;
> +
> +	ret = ethnl_fill_reply_header(skb, dev, ETHTOOL_A_RSS_HEADER);
> +	if (ret < 0)
> +		goto err_cancel;
> +
> +	if (!rss_context)
> +		ret = rss_prepare_get(&req, dev, &data, info);
> +	else
> +		ret = rss_prepare_ctx(&req, dev, &data, info);
> +	if (ret)
> +		goto err_cancel;
> +
> +	ret = rss_fill_reply(skb, &req.base, &data.base);
> +	if (ret)
> +		goto err_cleanup;
> +	genlmsg_end(skb, ehdr);
> +
> +	rss_cleanup_data(&data.base);
> +	return 0;
> +
> +err_cleanup:
> +	rss_cleanup_data(&data.base);
> +err_cancel:
> +	genlmsg_cancel(skb, ehdr);
> +	return ret;
> +}
> +
> +static int
> +rss_dump_one_dev(struct sk_buff *skb, struct netlink_callback *cb,
> +		 struct net_device *dev)
> +{
> +	struct rss_nl_dump_ctx *ctx = rss_dump_ctx(cb);
> +	int ret;
> +
> +	if (!dev->ethtool_ops->get_rxfh)
> +		return 0;
> +
> +	if (!ctx->ctx_idx) {
> +		ret = rss_dump_one_ctx(skb, cb, dev, 0);
> +		if (ret)
> +			return ret;
> +		ctx->ctx_idx++;
> +	}
> +
> +	for (; xa_find(&dev->ethtool->rss_ctx, &ctx->ctx_idx,
> +		       ULONG_MAX, XA_PRESENT); ctx->ctx_idx++) {
> +		ret = rss_dump_one_ctx(skb, cb, dev, ctx->ctx_idx);
> +		if (ret)
> +			return ret;
> +	}
> +	ctx->ctx_idx = 0;
> +
> +	return 0;
> +}
> +
> +int ethnl_rss_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	struct rss_nl_dump_ctx *ctx = rss_dump_ctx(cb);
> +	struct net *net = sock_net(skb->sk);
> +	struct net_device *dev;
> +	int ret = 0;
> +
> +	rtnl_lock();
> +	for_each_netdev_dump(net, dev, ctx->ifindex) {
> +		if (ctx->one_ifindex && ctx->one_ifindex != ctx->ifindex)
> +			break;
> +
> +		ret = rss_dump_one_dev(skb, cb, dev);
> +		if (ret)
> +			break;
> +	}
> +	rtnl_unlock();
> +
> +	return ret;
> +}
> +
>  const struct ethnl_request_ops ethnl_rss_request_ops = {
>  	.request_cmd		= ETHTOOL_MSG_RSS_GET,
>  	.reply_cmd		= ETHTOOL_MSG_RSS_GET_REPLY,
> -- 
> 2.45.2
> 

