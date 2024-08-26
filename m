Return-Path: <netdev+bounces-121958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8756195F617
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D182826CC
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C482D1946C9;
	Mon, 26 Aug 2024 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F7iSUMGo"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C91192D76;
	Mon, 26 Aug 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688568; cv=none; b=gZnwnogFpJhXxzUR9IpXtPjkHkYL4h9pT+Ku6pyGb7RK8nAV7+SYwsk1q/NUKqMmlxcVKj1V5xNe/ssOUlGGDQBN+YWYRKm2BA3cSpTA9jVu8zeArI4tMCDzTLOLHwdTTkrQwx5Gb8eS+T7Fc1nzTwsncA5Td37Z2o/whTwM/dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688568; c=relaxed/simple;
	bh=ULnLDFQ7wf4MsiECPkjlBokXT3BfEO2B+mjQgtBHp7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiUyUcC9HSWGhRZBqKlLG6lf/+T86nzcnb4/ZO49Np0CiGTZFZD0UMq+V2fSL5XevyDrPI+wVWORkbJ8DrUveMR+bgJVEa/+l38lWJkZHYHz7T/R97DUrSSNHxX4b5FJYh/JXkHtVd1FaB/x0XU3aIslCYtECUix5xmDbP+Mv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F7iSUMGo; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 409EB1BF203;
	Mon, 26 Aug 2024 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724688564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gk7c9yUO6WSbS/GsY+1LLV8a0la0WnhOHRC+F6/dALM=;
	b=F7iSUMGo9EWgn4rfMEmVZndCiJdAaD0DkP3EK8soXI5yOB6kXKvwJGlo228a8fICszaxn1
	syC9T7NSo1LADChaMWjV0Tc3NBiHLKrVptVUH8bEJXYtsoIpWd3EhsG5dpvIzf9XZcuiAP
	dqTE1kCMRB6zoQ7njXR0+gj/95Tdv9Dyzab9lornjnPG76s1zPLtKXO+/gNEKxM7prBU8y
	8hCuJxQgh+6Dieq4KEkK+1XhB9ePGAjbrdh2fEFz3Y5dF3k+wxAEa9u1JEpjUwbe/SfyP/
	Jnvue1DwvhpzxkU5fvr3XPzkjnSnhAtae47T8ozn4M+iiO4t4hGq49b2A+EN6A==
Date: Mon, 26 Aug 2024 18:09:22 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch net-next v2] net: ethtool: fix unheld rtnl lock
Message-ID: <20240826180922.730a19ea@fedora-3.home>
In-Reply-To: <20240826140628.99849-1-djahchankoike@gmail.com>
References: <20240826130712.91391-1-djahchankoike@gmail.com>
	<20240826140628.99849-1-djahchankoike@gmail.com>
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

Thanks for addressing this. I do have some comments though :

On Mon, 26 Aug 2024 11:06:13 -0300
Diogo Jahchan Koike <djahchankoike@gmail.com> wrote:

> ethnl_req_get_phydev should be called with rtnl lock held.
> 
> Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
> Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
> ---
>  net/ethtool/pse-pd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index 507cb21d6bf0..0cd298851ea1 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -227,8 +227,11 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
>  	struct nlattr **tb = info->attrs;
>  	struct phy_device *phydev;
>  
> +	rtnl_lock();
>  	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
>  				      info->extack);
> +	rtnl_unlock();

RTNL lock must be held until the PHY device is no longer being used, as
it may disappear at any point [1]. RTNL protects against that. The first
iteration of your patch had the right idea, as the lock was released at
the end of the function.

[1] : https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/ethtool/netlink.h#n281

Thanks,

Maxime

