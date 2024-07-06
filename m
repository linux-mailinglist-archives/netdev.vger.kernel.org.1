Return-Path: <netdev+bounces-109590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF30928FDB
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 03:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 128B9B21A08
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 01:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93604C8F;
	Sat,  6 Jul 2024 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9vWIFNI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4E36B;
	Sat,  6 Jul 2024 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720227617; cv=none; b=atOhip/pyFIAsAT9eRopeXhrKTBSLOMY6MFwQmUrXvTgWOLTAu0YmE2g0YqBEaKBpRDq0q/ELp/RnCSBkXKGtNS7gBo6ALizxiWEJjgAPkIuE/A5XmhlhLaDBLuMSh6OUYoHAtdbpOT0WfbGJuo+KNMkyRxx+txusC521HdbE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720227617; c=relaxed/simple;
	bh=NKe8d7nE7KBBUVo3XpcWOiOEGCATtjXXgO3ZyCTv0Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5FHKgHm397bFjCNp9bIKVB1jIesbXe0u4EHDJaNqD1c/ySG0x/kdXs9Tj0Z67022H3/PgIYqVCy+JLTqjA173+/Zb3HEB/uRe7Br7OlJzLVWWtUYsndC8VPC1p3wheabTb83Cby0H9IXz3o1aO+GHxmnT4LcgHD4Q+W2aLrXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9vWIFNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE218C116B1;
	Sat,  6 Jul 2024 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720227617;
	bh=NKe8d7nE7KBBUVo3XpcWOiOEGCATtjXXgO3ZyCTv0Aw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c9vWIFNI+El3Ec46hVmyNAaGWJrzKLn9F4vgRmTtNFwzldQa5lNcKirMyHuxAnJvS
	 YSHYHTKKklK5rfFEIERUQ+KNfkrJzBDLtVWqdI+49dyBvc2Th5Yn8BEwWA2gn1wKtg
	 UYT/r08XockYoUwASx1qcT50oUOn5lSP1UTPOM8P3JgaKQcVvbi2W+BMrM3RLH6d/s
	 QBCSc3wOwXrN0eqGb+A7ypmDk6/ThtCcAVoEeQMsCikCTAu/HduDtCehItN+J4jfbl
	 8qyOTUr/8S87vGL6g8JhH5YxK5FjxXnTS4kWXNTiF2B58VO+D66hQqkBskZEutVmlM
	 cxSX5g49dQ9AA==
Date: Fri, 5 Jul 2024 18:00:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Michal Kubecek <mkubecek@suse.cz>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Arun Ramadoss
 <arun.ramadoss@microchip.com>, Woojung.Huh@microchip.com,
 kernel@pengutronix.de, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] ethtool: netlink: do not return SQI value if
 link is down
Message-ID: <20240705180016.64085ea5@kernel.org>
In-Reply-To: <20240704054007.969557-1-o.rempel@pengutronix.de>
References: <20240704054007.969557-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jul 2024 07:40:07 +0200 Oleksij Rempel wrote:
>  	if (!phydev->drv || !phydev->drv->get_sqi)
>  		ret = -EOPNOTSUPP;
> +	else if (!phydev->link)
> +		ret = -ENETDOWN;

Can we stick to EOPNOTSUPP for the link down case as well?
We're consuming the error, the exact value doesn't matter.
Or let's add a helper which checks the int sqi in all it's
incarnations for validity:

static bool linkstate_sqi_no_data(int sqi)
{
	return sqi == -EOPNOTSUPP || sqi == -ENETDOWN;
}

