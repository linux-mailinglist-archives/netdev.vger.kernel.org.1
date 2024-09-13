Return-Path: <netdev+bounces-128090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB42977EDF
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465DC1F228B2
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1991D88A0;
	Fri, 13 Sep 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Afv6Xwzi"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641BC1D6C7F;
	Fri, 13 Sep 2024 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228311; cv=none; b=Wg2IlaUtee0plOrL/n00NzQlStCsjRiECJqKUVa4nwqitYK3lUQFX4TouoCdAEsAgsc28L6ZyRFmnf17FX3I+eFl1F8aNQ5HJ6Hz1sQ+ABsIatv0oxUiOUkOLa7sBMkSXl4/DZWsJJHIHMDNsUKIYMzvdN/odMZAFpKave+KZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228311; c=relaxed/simple;
	bh=1TLm4rAZ5pFpsYIIQFLhLiHFR2YYzQXDu6UGmffJLJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdSoOP1PiC4xjb/OGvk01RKeWqEq0WYdf92LsWe0K5LqiSqF8H+HEGXKZsTWe+dk74FFxWH4hHBQBPwg9yvorRZp41ZZnUqu/x2ya3zhzlM9/tlQKpkVwEuCtucywI0ACW29DHhmTIsTa361qeafhVRvXwYjorCl3UOed7jVCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Afv6Xwzi; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 833F140002;
	Fri, 13 Sep 2024 11:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726228307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o22ld+Ml/WqxlcTNuea7Zj0lN6reXMa5feXwsZPjWbs=;
	b=Afv6XwzikOJ1Oxj7sjkT5xnkekmXx3kGpt6E4zviM0lqGfyyWrgQGf6xz0Z72g15ndFsxN
	+zsa2jjS8MBWHCr8Lanlxa/RjOsz7vUKhdJSi4HOqFD1a+8TI3DegsICkCJbXPGzxFln5i
	KkBiu2QG17SVcV21otBbvdONZHQMn86SSNlvvsWtYpbQQs1LKhGVRNDF2BNbry+i2FjIze
	dIieib+x/XuXQDu5gDaTFh3s7RgOfEFr/53+Hy2okgkWp3YejE1CCv8MO9WQqhZsZBNqiK
	1mMD9TVKROec5eqr0PU2gmegww2mZvTE7zr4Oz3GqKemu9TywB4cpFTYTCzGvw==
Date: Fri, 13 Sep 2024 13:51:45 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com>,
 <christophe.leroy@csgroup.eu>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH net-next] net: ethtool: phy: Distinguish whether dev is
 got by phy start or doit
Message-ID: <20240913135145.2c9ac50c@fedora.home>
In-Reply-To: <20240913080714.1809254-1-lizhi.xu@windriver.com>
References: <000000000000d3bf150621d361a7@google.com>
	<20240913080714.1809254-1-lizhi.xu@windriver.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Fri, 13 Sep 2024 16:07:13 +0800
Lizhi Xu <lizhi.xu@windriver.com> wrote:

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

Thanks for addressing this, however I've already sent a first fix for
this [1] yesterday, followed-up by a second one [2] with another
approach following the reviews.

[1] : https://lore.kernel.org/netdev/20240913091404.3d4a9d19@fedora.home/T/#m4777416dbe26bf97b3a0a323fc71a93b40e0f7fb
[2] : https://lore.kernel.org/netdev/20240913100515.167341-1-maxime.chevallier@bootlin.com/T/#u

Best regards,

Maxime

