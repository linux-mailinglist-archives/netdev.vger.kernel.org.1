Return-Path: <netdev+bounces-88529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36578A7997
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 02:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8049C284527
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 00:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F57EC;
	Wed, 17 Apr 2024 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxoFUZ4X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179927EB
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 00:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312465; cv=none; b=R3f2cgN0Z87huZB5Q5zXQ768kELNvog0KttHYC2SB0BouIynnF2/QUSNKKw1D4rAJa8Jx1x86JluQgKC0RrNObu7LaWe8FeQkEnQHhixnURhWm89l0S5bZIgn1EPyAo2YMbUN9ClYRsGwkilNcPd0THV4SWsGuZYmNXA6f75XcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312465; c=relaxed/simple;
	bh=2nuwxUAekyQUI6K6Q/PLk5TA6tRVp9Lg6ZBcrOCki3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJsMHfWe9bThmiRASz+OOW43WXcVrgd9s2FUgRropgDVfdUgk1FkN5kt6LrukuEgZJeJz0ooZjKLcozJy5mBwCrC5a0lHSdS2OUV2p8d+X8lGK1czPbzbK6nl2sQySNl7FQ2ceE0R/a8Wd0kpHd5do32uxT2r22re87II+R1MOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxoFUZ4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D62C113CE;
	Wed, 17 Apr 2024 00:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713312464;
	bh=2nuwxUAekyQUI6K6Q/PLk5TA6tRVp9Lg6ZBcrOCki3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SxoFUZ4XdYQ7muGUi5QTJTOrkOK2Hn1M0xsGtI7B3rUEjWF9ijcfmvYyB/6aECDKD
	 XWP9jjH5/uHWLGQJ/MrH8SQV9dBg4XLjKMe2XkPjqlfjJE1BQh/S02AFsgNDeGErdE
	 kaFsHrlPFpdI16EOs8ci68c6NpQbXl6qCMsAr4C48n23G1wlcmGj3gMxtTxmtJf3aM
	 iWT0bCAzaN2J+eW/KaHLSm3ZjIMQQbkOU0OBnvY+dcBQAgsEyqOZtNrwlSllseXU9f
	 Gy6bvY+yCe4B9VCwfsTD2/XL1I9M9rBejjI6deCBfbfXvzyQ9SNAQzrgGhhnYspKy/
	 uJA1kw5yGBb2A==
Date: Tue, 16 Apr 2024 17:07:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jacob Keller <jacob.e.keller@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gal Pressman <gal@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Michal Kubecek
 <mkubecek@suse.cz>
Subject: Re: [PATCH ethtool-next 2/2] netlink: tsinfo: add statistics
 support
Message-ID: <20240416170742.4ebbb130@kernel.org>
In-Reply-To: <20240416203723.104062-3-rrameshbabu@nvidia.com>
References: <20240416203723.104062-1-rrameshbabu@nvidia.com>
	<20240416203723.104062-3-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 13:37:17 -0700 Rahul Rameshbabu wrote:
> +		if (mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U32)) {
> +			is_u64 = true;
> +			if (mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U64)) {
> +				fprintf(stderr, "malformed netlink message (statistic)\n");
> +				goto err_close_stats;
> +			}
> +		}

possibly cleaner:

	__u64 val;

	if (!mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U32)) {
		val = mnl_attr_get_u32(tb[stats[i].attr]);
	} else if (!mnl_attr_validate(tb[stats[i].attr], MNL_TYPE_U64)) {
		val = mnl_attr_get_u64(tb[stats[i].attr]);
	} else {
		fprintf(stderr, "malformed netlink message (statistic)\n");
		goto err_close_stats;
	}

