Return-Path: <netdev+bounces-153206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB19F72C8
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C571891186
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9294D146596;
	Thu, 19 Dec 2024 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGmJErVB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF778F52;
	Thu, 19 Dec 2024 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734576084; cv=none; b=ik/XVZi6SAAGVYrZBKcouTSPMrDsUiAVJC9yvAWsYpV6+AvO0h3Wvi1YYtDOHA8EHRqge0SxIIZUkFM1NKfOH+gSw/J3jMO2hj09QHd6/dLaEf5vtjDaC4YX0EqvaTiCz7YKyxBH3MkdKb2aS1gFrMtIINWRR9gG+lCYJPvW7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734576084; c=relaxed/simple;
	bh=x8AYl8HDSHlZ7J+FFdQAC8suQ91ToLdJ5RIn53cMnaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csVD4V573zpVXMVF3TG119mFVSTou9a1hbMdP1C2sHwJSi1/tkjUjTgfQTzJ6p02eOtFGkLN19Hyf494yyA9L32atb+9B6ufUm6svz2FgjnKRT3pf9B4ldORFJ4homJRTbrwhZT0BQYKDWCcoD29K5YfvU+OKpAeDOybCJGo46Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGmJErVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9619DC4CED4;
	Thu, 19 Dec 2024 02:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734576083;
	bh=x8AYl8HDSHlZ7J+FFdQAC8suQ91ToLdJ5RIn53cMnaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QGmJErVBSgGO4eGYNSB9Uqzr6MebQg319eyh1N/Z4fw0QXg5sgtlUzB09pU2ol3t8
	 ZPUOjay8XzVwq9r5cjdloUTIXY8BUmZNZ11yRrMjGv3txu8R1cFJtECscb5XVxj6u/
	 FhfVui9rcB1oKIRKDrz9cfTDpZ9HalNmpQ/AfzrixElfdWCwyibJ0e4fxjhA0FFa8g
	 /j0Nv++zbvj526UUl+y/ZwWeKliJdfzHxxbZz5H974VA3ywj2o7MkfBbKWVwyuOlz3
	 OxDQsZW7xaPC17H9mF2GGE9YSaGV6uLM8VHrRPGAkaJqpFjVlklq6B/VwjzxsyLhmS
	 2zQkUOTfpLoZA==
Date: Wed, 18 Dec 2024 18:41:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com, Andy Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH net-next v6 3/9] bnxt_en: add support for tcp-data-split
 ethtool command
Message-ID: <20241218184121.7117cf67@kernel.org>
In-Reply-To: <20241218182547.177d83f8@kernel.org>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-4-ap420073@gmail.com>
	<20241218182547.177d83f8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 18:25:47 -0800 Jakub Kicinski wrote:
> > +	if (prog && bp->flags & BNXT_FLAG_HDS) {
> > +		netdev_warn(dev, "XDP is disallowed when HDS is enabled.\n");
> > +		return -EOPNOTSUPP;
> > +	}  
> 
> And this check should also live in the core, now that core has access
> to dev->ethtool->hds_config ? I think you can add this check to the
> core in the same patch as the chunk referred to above.

Oh, you also already have this logic in patch 7?
So it just needs to be reordered in the series, and then the driver
doesn't need to check?

