Return-Path: <netdev+bounces-128481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BC2979C20
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 09:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E88B1B2218A
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 07:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DED13A258;
	Mon, 16 Sep 2024 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sa+KPykl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83823A9
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472332; cv=none; b=rJyyAuoAcUfZJgKhDxsfJHUq7wZgO91Ex0aKUft0dQtweUxNVcO7Avo/G6RCAVRGbWQbhRtNS6oTgJB3M6hrPnJiJLN0rAv+WcwMpMikMR0RiIYUiDosSu26AJre1MyE6UOo71wC6/AAMpS+C8MnRyDQ389j704i5dlHVr22yHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472332; c=relaxed/simple;
	bh=KkZ8FICImOIgw6q1N4ryk672Wpj+EqkLc3wopN4lyo4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rYLAwZOwrdwrIDuR5BoAhYADOgK4UlltAZLuLnJHTKqAdSrQbHDk/OBYy7I9DzglfIgGg6SlDLjSc2jI8WIcO6yszo8u0Cy8L3cRdruDaK5pcF56a8PwIg33jX3gnzQ3hPPiOzLGGZFVdtjUoaEA0088FtY8Zeelu3uRJDamsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sa+KPykl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d4979b843so571683466b.3
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726472329; x=1727077129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0l+BKAXt7MqE6WV7ro8OGZ1rHQNqUOyBNh5u+LY1jQ=;
        b=Sa+KPyklnBxlg3L1xmKchlo7eHrLw+5t+lCLXrKVTPkWiFFCuf9o0A8Ph1J0nxW6Z4
         5rL7rxOsnobsP81QuKBpn4diqEiAXgJZ8EmLorA4CV5pNHVBFGDJsoDwkeLHYSQX9INf
         hdN3dfNkNqjXO/aSwSCRnm8n4sSVIv+b3SR/TWmTBZOn2ZLz5pS4sa7gQw0x/w0/5Wgy
         MSYL9bbKGu4WP1PMxGP9q2tt5M1hl5D0L1y8I0AdAmMN7XnsUQy63dyARJnKHNx0bjaa
         ez3tfXNc8fVSjt6yrJ8udpFxrxMTSvjEUaauvUasyOMTLtYWbdB4Ol5YPyISb2serMB1
         lrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726472329; x=1727077129;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0l+BKAXt7MqE6WV7ro8OGZ1rHQNqUOyBNh5u+LY1jQ=;
        b=nYaWvppy5y/iB/U7Js34aQL53raQ9BgX3+MXFVQl8jaOqsRfsaBeazI10uF1V0CDaD
         4X/3E2IRmRfZd1HfGD2Lli3/2lVzkaGCySk9rFbBvLGmvrruA+r432+XZjHo0FCkwXIE
         rvcEH1dd/3mvO/EMISJ75V/ssnAHxSyU0L2W8WoUYBaki7XI7GI/njH34XNYtbwTikzY
         C8HXE0mOZmPZekGzC4FboQ8gleeUSFzw3FtB5iOjYGWaeNQpFUOJgFrvil9zgMHTdoUT
         LbCZ3Wf2LRZFYh0B8UKfA4SnuDs3e1tjy0aJsSCRwXSLjfaKwMfaW/fdsLVCFuH630F9
         Lmkg==
X-Forwarded-Encrypted: i=1; AJvYcCUOnuRqD6rQn0HDbzJtgj+8fn57Nw0lPJskxuv9aKWs17jDvwNoG2ohTPgMbH162IfOVU/xT9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6k2EeQ/PI/IIsvniGeEshVcPAzl4ZlMlcZGJAKC2bdD+bYgVV
	S52ePale482TMSvrm8b328/0Z7PwXm5c2I4kRr2f3zC4hcGCh0jgTxZqiVCq3lBQpT5mb6DUQoG
	c
X-Google-Smtp-Source: AGHT+IFnSYPx5cT7cc0vnJ0PuZYlzFKCA4aIyeYwcDHqzEAp8T7CjdW+2Q27t95F9/ektxipH96rCA==
X-Received: by 2002:a17:907:e644:b0:a77:b4e3:4fca with SMTP id a640c23a62f3a-a902941e770mr1337622766b.9.1726472328688;
        Mon, 16 Sep 2024 00:38:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610966e2sm278081166b.16.2024.09.16.00.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 00:38:48 -0700 (PDT)
Date: Mon, 16 Sep 2024 10:38:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	christophe.leroy@csgroup.eu, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next] net: ethtool: phy: Distinguish whether dev is
 got by phy start or doit
Message-ID: <05580c1a-9652-4471-abd1-3d271fe844e8@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913080714.1809254-1-lizhi.xu@windriver.com>

Hi Lizhi,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Lizhi-Xu/net-ethtool-phy-Distinguish-whether-dev-is-got-by-phy-start-or-doit/20240913-160835
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240913080714.1809254-1-lizhi.xu%40windriver.com
patch subject: [PATCH net-next] net: ethtool: phy: Distinguish whether dev is got by phy start or doit
config: x86_64-randconfig-r072-20240914 (https://download.01.org/0day-ci/archive/20240916/202409161017.tjjHpXGT-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202409161017.tjjHpXGT-lkp@intel.com/

smatch warnings:
net/ethtool/phy.c:235 ethnl_phy_start() error: dereferencing freed memory 'ctx->phy_req_info'

vim +235 net/ethtool/phy.c

17194be4c8e1e8 Maxime Chevallier 2024-08-21  212  int ethnl_phy_start(struct netlink_callback *cb)
17194be4c8e1e8 Maxime Chevallier 2024-08-21  213  {
17194be4c8e1e8 Maxime Chevallier 2024-08-21  214  	const struct genl_info *info = genl_info_dump(cb);
17194be4c8e1e8 Maxime Chevallier 2024-08-21  215  	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
17194be4c8e1e8 Maxime Chevallier 2024-08-21  216  	int ret;
17194be4c8e1e8 Maxime Chevallier 2024-08-21  217  
17194be4c8e1e8 Maxime Chevallier 2024-08-21  218  	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
17194be4c8e1e8 Maxime Chevallier 2024-08-21  219  
17194be4c8e1e8 Maxime Chevallier 2024-08-21  220  	ctx->phy_req_info = kzalloc(sizeof(*ctx->phy_req_info), GFP_KERNEL);
17194be4c8e1e8 Maxime Chevallier 2024-08-21  221  	if (!ctx->phy_req_info)
17194be4c8e1e8 Maxime Chevallier 2024-08-21  222  		return -ENOMEM;
17194be4c8e1e8 Maxime Chevallier 2024-08-21  223  
17194be4c8e1e8 Maxime Chevallier 2024-08-21  224  	ret = ethnl_parse_header_dev_get(&ctx->phy_req_info->base,
17194be4c8e1e8 Maxime Chevallier 2024-08-21  225  					 info->attrs[ETHTOOL_A_PHY_HEADER],
17194be4c8e1e8 Maxime Chevallier 2024-08-21  226  					 sock_net(cb->skb->sk), cb->extack,
17194be4c8e1e8 Maxime Chevallier 2024-08-21  227  					 false);
17194be4c8e1e8 Maxime Chevallier 2024-08-21  228  	ctx->ifindex = 0;
17194be4c8e1e8 Maxime Chevallier 2024-08-21  229  	ctx->phy_index = 0;
355b18bd0d5516 Lizhi Xu          2024-09-13  230  	ctx->phy_req_info->dev_start_doit = 0;
17194be4c8e1e8 Maxime Chevallier 2024-08-21  231  
17194be4c8e1e8 Maxime Chevallier 2024-08-21  232  	if (ret)
17194be4c8e1e8 Maxime Chevallier 2024-08-21  233  		kfree(ctx->phy_req_info);
                                                                      ^^^^^^^^^^^^^^^^^
Freed

17194be4c8e1e8 Maxime Chevallier 2024-08-21  234  
355b18bd0d5516 Lizhi Xu          2024-09-13 @235  	if (ctx->phy_req_info->base.dev)
                                                            ^^^^^^^^^^^^^^^^^
Use after free

355b18bd0d5516 Lizhi Xu          2024-09-13  236  		ctx->phy_req_info->dev_start_doit = 1;
355b18bd0d5516 Lizhi Xu          2024-09-13  237  
17194be4c8e1e8 Maxime Chevallier 2024-08-21  238  	return ret;
17194be4c8e1e8 Maxime Chevallier 2024-08-21  239  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


