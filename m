Return-Path: <netdev+bounces-103021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 859BC905FC8
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 02:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CB7B22562
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 00:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D588472;
	Thu, 13 Jun 2024 00:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ9XNKHY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F2811;
	Thu, 13 Jun 2024 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718239186; cv=none; b=EULvyud9kIoTdAzWDhA47hyoDn+fJxa+mHB+1JEJYtY42kECQqEEWA7ntpEQkA4IS3vz1oPvqJnb1RUX50co+Q+wv09z5tyGoYcYJfgCMBBWbEMSLbFm1u2qfC2/wOZ0YamiClxFDSy+qEotjI1nyNT2a8p28OKvscJfQiL3ErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718239186; c=relaxed/simple;
	bh=nWAMku+xbI0GhotCu17YZ8ZpkhtijhiBMYU1kQYy1qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pK8soVefszyF6hCgaFdjyEvpN26TZQY4RUXQaNW+zcXqJq9T9k6vFEzNQuw/p7QNkQUeZZqXJgLxvAutYOtSfDlnpK8n+rAFxUE9d61LHjOgbfNGGB5gDZflmHap57oD/tLyyw24rRK9Sle1fC7NKzZcxbbyfFARNqs/OX/i+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ9XNKHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39403C116B1;
	Thu, 13 Jun 2024 00:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718239185;
	bh=nWAMku+xbI0GhotCu17YZ8ZpkhtijhiBMYU1kQYy1qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kJ9XNKHY8DXHbJRMbruK6v4Uh4HpARwm6EL8RQv8TeurXvmI7AVVimMwZ44jP7+Vn
	 WP8dQaPZvR/A2PeW+JPvHoT2LA25OEWQaNpHwJ9L0gGvLPbsbTAJqQveFcgb4mQ1/6
	 STorpsEBEOk/iEKyBEakexHN3m8op6kRab3VQBmxp6oU4sXzBabe6XWD9/y9vjy8Ii
	 3HbP88+vOdu5hYV2VyzinNYD7fatRph9IlwYxlmjbPhe/rnelS+OxHGnWblXsA0RG/
	 CYjRUHaBJCyUCmivqoxkHPLUfD270AJqRpEHmemTvqVCVKLGtkBqAiCSNh56XgYNeJ
	 rFfGeyd4D78Zw==
Date: Wed, 12 Jun 2024 17:39:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v20 08/13] rtase: Implement net_device_ops
Message-ID: <20240612173944.05121bf0@kernel.org>
In-Reply-To: <20240607084321.7254-9-justinlai0215@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
	<20240607084321.7254-9-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 16:43:16 +0800 Justin Lai wrote:
> +static void rtase_get_stats64(struct net_device *dev,
> +			      struct rtnl_link_stats64 *stats)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	const struct rtase_counters *counters;
> +
> +	counters = tp->tally_vaddr;
> +
> +	if (!counters)
> +		return;

Same question about how this can be null as in the ethtool patch..

> +	netdev_stats_to_stats64(stats, &dev->stats);

Please dont use this field, there is a comment on it:

	struct net_device_stats	stats; /* not used by modern drivers */

You can store the fields you need for counters in struct rtase_private

> +	dev_fetch_sw_netstats(stats, dev->tstats);

