Return-Path: <netdev+bounces-128087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D56977EBC
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57231F27EC5
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C11D86F0;
	Fri, 13 Sep 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCkCgPRs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D51BE872;
	Fri, 13 Sep 2024 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227874; cv=none; b=I23b8lVzpdyKk17RW9nS8BZZPFWBih40loLs5bkrF5tUVc//rxI9/cMf0VSrRCH2dgU9s9+0IEZCNQOU8P2sCZGQoIzxUdnAdO1uTlXAz3o/hOVOwqwwEUL4DdU6Doo92SSfuCEAkxaT+lxw5UywFFtC89wohehde6ftghvQreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227874; c=relaxed/simple;
	bh=zcDec/v9hjdmFmqDlmf7R91KbYWhD0Wx0kIfhzeJ++A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZM7Ct68uweZe0nD0K8IL9DKCpktg7rVnlnNAVBw5L+63YntbwpXhNhEysy/WpaX8n/5r4ezmZb+gFKflyvsUlwK1uMY0XQdQGf03BbDMhNbtQ0kn5XCV9Z63QkS2RcH6Hb45otzMfWn/TeIZqMnB67+3Wv0HnEj3gyZPHt/CioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCkCgPRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8F2C4CEC0;
	Fri, 13 Sep 2024 11:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726227873;
	bh=zcDec/v9hjdmFmqDlmf7R91KbYWhD0Wx0kIfhzeJ++A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCkCgPRsDW54F8dMA5It5OGIL7ddX7PhM02aUYG4X+Ol3XJt8OA5Z8lkpgwMmwrUO
	 l/1Ko3iBVRqd5S98HC0TG/s4QF+Jf1A/UZNlslV3Qf4+Ehg+Ez+U6OxsV6axPnzHib
	 fR694+P3zD84+uBdUV/Dqg5B164/klfINS/v0mlEymwmUCKYK1iBIIVLDICkRp+MPp
	 o3FmT4XzAFqc9z0Hctb9KJkaq6QuAuP04mwnkrqZqQtwbMEI32+/RqE2AwI5juQdPm
	 YxtiCECSb/jTg305PcdQQtzZOr6cJ3SpT59vrsGHhyRY7AwqydWGP1bSwNr/om7k2I
	 Dk1Gu4UHGtYdw==
Date: Fri, 13 Sep 2024 12:44:29 +0100
From: Simon Horman <horms@kernel.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com,
	christophe.leroy@csgroup.eu, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next] net: ethtool: phy: Distinguish whether dev is
 got by phy start or doit
Message-ID: <20240913114429.GY572255@kernel.org>
References: <000000000000d3bf150621d361a7@google.com>
 <20240913080714.1809254-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913080714.1809254-1-lizhi.xu@windriver.com>

On Fri, Sep 13, 2024 at 04:07:13PM +0800, Lizhi Xu wrote:
> Syzbot reported a refcount bug in ethnl_phy_done.
> This is because when executing ethnl_phy_done, it does not know who obtained
> the dev(it can be got by ethnl_phy_doit or ethnl_phy_start) and directly
> executes ethnl_parse_header_dev_put as long as the dev is not NULL.
> Add dev_start_doit to the structure phy_req_info to distinguish who obtains dev.
> 
> Fixes: 17194be4c8e1 ("net: ethtool: Introduce a command to list PHYs on an interface")
> Reported-and-tested-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e9ed4e4368d450c8f9db
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

It seems that Maxime has also posted a patch for this problem.

- [PATCH net-next] net: ethtool: phy: Don't set the context dev pointer for unfiltered DUMP
  https://lore.kernel.org/all/20240913100515.167341-1-maxime.chevallier@bootlin.com/

> ---
>  net/ethtool/phy.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
> index 4ef7c6e32d10..321a7f89803f 100644
> --- a/net/ethtool/phy.c
> +++ b/net/ethtool/phy.c
> @@ -13,6 +13,7 @@
>  struct phy_req_info {
>  	struct ethnl_req_info		base;
>  	struct phy_device_node		*pdn;
> +	u8 dev_start_doit;

I think bool might be a more suitable type for this field.

>  };
>  
>  #define PHY_REQINFO(__req_base) \
> @@ -157,6 +158,9 @@ int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (req_info.base.dev)
> +		req_info.dev_start_doit = 0;
> +
>  	rtnl_lock();
>  
>  	ret = ethnl_phy_parse_request(&req_info.base, tb, info->extack);
> @@ -223,10 +227,14 @@ int ethnl_phy_start(struct netlink_callback *cb)
>  					 false);
>  	ctx->ifindex = 0;
>  	ctx->phy_index = 0;
> +	ctx->phy_req_info->dev_start_doit = 0;
>  
>  	if (ret)
>  		kfree(ctx->phy_req_info);
>  
> +	if (ctx->phy_req_info->base.dev)
> +		ctx->phy_req_info->dev_start_doit = 1;

This doesn't seem right, ctx->phy_req_info may have been freed above.

> +
>  	return ret;
>  }
>  
> @@ -234,7 +242,7 @@ int ethnl_phy_done(struct netlink_callback *cb)
>  {
>  	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
>  
> -	if (ctx->phy_req_info->base.dev)
> +	if (ctx->phy_req_info->base.dev && ctx->phy_req_info->dev_start_doit)
>  		ethnl_parse_header_dev_put(&ctx->phy_req_info->base);
>  
>  	kfree(ctx->phy_req_info);
> -- 
> 2.43.0
> 
> 

