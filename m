Return-Path: <netdev+bounces-122184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884BF960463
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4184A282893
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28F0194136;
	Tue, 27 Aug 2024 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZZfhRuV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FC155CA5
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747278; cv=none; b=uJ1fFJttnNlb02+8EA4Sf/mr8B4Y6AqNNfQw/wuUI4MU+iqpaKwAOclFlawK7KKE8eOImv7idCt6TrX4lVwen42IbvUSwNBfBVvlGLYlnS+Y30vqTGVEdwM2HaK9LAwoMOolv1zlXffAZMkd2YuTODlVcYmQ95Pmnn0VYLqq/iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747278; c=relaxed/simple;
	bh=8Yjdf7ts1lrctjQCpk4fkhBjp5Lar6/yqLkSLLEeQnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlzZCmQuvPoIzBLqrQIddfbn5EuX1V0hPQ5xL3e7knlhCPrIGUn0JW/G2WrxAJxGbgXBHrqJ1V3mr9poBNFaP7DTpx6D/mtUIPSmQVtfCabcm+8ez+VeKZ27RzOxk1vrDoT0+hsLLujk0Pr1/YUsHu7jD7uegP36oFmdU+fqBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZZfhRuV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bed05c0a2fso6417041a12.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724747275; x=1725352075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwBFZ+aIXeWT7gdWxFkQlsDLmw4Uh9N2NqhVyqhD1WY=;
        b=RZZfhRuV3MtmhER9p3upvmK93wcP1NJbLzckNN674A9mBLLNtsGjE3JCM2COtxwBDU
         sO5XglZBZlCM2j+jCa6w6C816G++Qg6mxg7vuSX3xG7zIggkCgWNCNlSacC/OY3bkH9v
         3j3cETlcarNe4i355eOGfz4jjvg0o9NzJQDZnoErNbbfB1dCiCck43poMw9j/9rlVJyt
         3oi0QydWFMaBEJekV3N8ZKV7zLThlJ7CeZgemghJanEGIjx0GdNsQgYKZPLeIXVHWo4l
         C8yXiBnF0+qGqIz+P/AQ4Io0Kfa89eYI9TMsPZDX4fY8rXR8AjyfU3I0tTiHXMYaoZYT
         jcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724747275; x=1725352075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwBFZ+aIXeWT7gdWxFkQlsDLmw4Uh9N2NqhVyqhD1WY=;
        b=HfGclxUVOJopF+SkDDXB4OkRAi/hQiPwrMwzOx1BtIEhYdaObwK4MJdJq9YQizQtlp
         EEhRa7w4+6Tt0DNkswjRSPZRW7ZkB5hTGn1mHOi8uRek78ls6DFY6fZfKReAZ4jp/64m
         xJXhl3U9xqhbsiYTe+tgw3R1NrW6GTrhdal995BU8N6rS+JMb5VqQoyA6VsJSik00uGD
         GmSzRQefNlz8o2Do0teUd83jpKnSe4tokFXiuYsm9ZYMCrzXGIK4nc7YDp8I0rluGYok
         MK8+LYzCjHH2RICeAUiTxC1LG0dpbczQ+iPxqtq+wBzqysRfUfrcCWyuyu3hr7YwBc3w
         08og==
X-Forwarded-Encrypted: i=1; AJvYcCXSTV8OnVEfFSy2nG/G45Vft+ezreRqNJYQ2KDI1BHK5v55vF13Sj7G9ca51Wka3z5jOPcVB2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz04nREnw5Ae52KciBurN0bOBTpicGwEs8YUfH8PnpnN5ypb8Et
	2oL2xTfgvimpizfapNKs1ss+WzyXQIrkXIwlZfi3cPfbWuYP3/DpAzUa+k3QxnY=
X-Google-Smtp-Source: AGHT+IGoytf/csiM7P+oT51XLKCJCIoyP5CWG+PH3sD80bM3KlZXHkavP3BVjH98KYSXriq2GD3wpw==
X-Received: by 2002:a05:6402:524e:b0:5be:fc0b:9a6a with SMTP id 4fb4d7f45d1cf-5c0891aba58mr8008738a12.32.1724747274856;
        Tue, 27 Aug 2024 01:27:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb4829ccsm720941a12.95.2024.08.27.01.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:27:54 -0700 (PDT)
Date: Tue, 27 Aug 2024 11:27:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pengfei Xu <pengfei.xu@intel.com>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v17 11/14] net: ethtool: cable-test: Target the
 command to the requested PHY
Message-ID: <a1642517-366a-4943-a55d-e86155f51310@stanley.mountain>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240709063039.2909536-12-maxime.chevallier@bootlin.com>
 <Zs1jYMAtYj95XuE4@xpf.sh.intel.com>
 <20240827073359.5d47c077@fedora-3.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827073359.5d47c077@fedora-3.home>

On Tue, Aug 27, 2024 at 07:33:59AM +0200, Maxime Chevallier wrote:
> 
> This issue has indeed been detected, and is being addressed, see :
> 
> https://lore.kernel.org/netdev/20240826134656.94892-1-djahchankoike@gmail.com/
> 

There is a similar bug in ethnl_act_cable_test_tdr() that needs to be fixed
as well.

net/ethtool/cabletest.c
   307  int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
   308  {
   309          struct ethnl_req_info req_info = {};
   310          const struct ethtool_phy_ops *ops;
   311          struct nlattr **tb = info->attrs;
   312          struct phy_device *phydev;
   313          struct phy_tdr_config cfg;
   314          struct net_device *dev;
   315          int ret;
   316  
   317          ret = ethnl_parse_header_dev_get(&req_info,
   318                                           tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
   319                                           genl_info_net(info), info->extack,
   320                                           true);
   321          if (ret < 0)
   322                  return ret;
   323  
   324          dev = req_info.dev;
   325  
   326          ret = ethnl_act_cable_test_tdr_cfg(tb[ETHTOOL_A_CABLE_TEST_TDR_CFG],
   327                                             info, &cfg);
   328          if (ret)
   329                  goto out_dev_put;
   330  
   331          rtnl_lock();
                ^^^^^^^^^^^^

   332          phydev = ethnl_req_get_phydev(&req_info,
   333                                        tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
   334                                        info->extack);
   335          if (!IS_ERR_OR_NULL(phydev)) {
                    ^
This test is reversed so it will lead to a crash.

Could you add some comments to ethnl_req_get_phydev() what the NULL return
means vs the error pointers?  I figured it out because the callers have comments
but it should be next to ethnl_req_get_phydev() as well.

   336                  ret = -EOPNOTSUPP;
   337                  goto out_dev_put;
   338          }
   339  
   340          ops = ethtool_phy_ops;
   341          if (!ops || !ops->start_cable_test_tdr) {
   342                  ret = -EOPNOTSUPP;
   343                  goto out_rtnl;
   344          }
   345  
   346          ret = ethnl_ops_begin(dev);
   347          if (ret < 0)
   348                  goto out_rtnl;
   349  
   350          ret = ops->start_cable_test_tdr(phydev, info->extack, &cfg);
   351  
   352          ethnl_ops_complete(dev);
   353  
   354          if (!ret)
   355                  ethnl_cable_test_started(phydev,
   356                                           ETHTOOL_MSG_CABLE_TEST_TDR_NTF);
   357  
   358  out_rtnl:
   359          rtnl_unlock();
   360  out_dev_put:
   361          ethnl_parse_header_dev_put(&req_info);
   362          return ret;
   363  }

regards,
dan carpenter

