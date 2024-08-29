Return-Path: <netdev+bounces-123172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2397963EBC
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109B41C244B5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C08118C324;
	Thu, 29 Aug 2024 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G0W1zO6t"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C7189912;
	Thu, 29 Aug 2024 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920559; cv=none; b=fKrnifP+T38n72qXcJV97Y0HDEXhZ9nCakfKE2SYw5zeM0Fco/9BQzwiHFch0/AdKnjbm8vqWy57M7/Yv5CNEtF4KgN6QQPg6YT6DdajdUbBRgXypSCftAGqHKOMmUDHbkV9fzYDZWBpb2sgEs6d47A3ArurNmfKjAFWBK4wqgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920559; c=relaxed/simple;
	bh=kYfR6vntvOP/ZNvvFwoIJHJ0pNxEGNa4BCttNEffydw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7xCvwNw6XOzirKDE6Lmy29yAsSjE/qdbbyosheAFz3ZErcO0KGy6my7tiCLv9LeJ0+RDU4rm5t5koMWGKssAQaJ4jASCuA5Eh6Er8f+YkVbfgaIa1X92yrqtEodh1KKl7gQ9z1e+Wujf0Fm2WFSozxs4/l4CjnSVAi0EoO4DTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G0W1zO6t; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E6B7E0003;
	Thu, 29 Aug 2024 08:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724920554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8/ITs5ZwIVyovjR2zQIGYV49XbmpSZY/DEuv5GceYc=;
	b=G0W1zO6tjw7DOdqAwN4v9iW7SlKaQ3FqxPe+/hoOcJ4aiysVXd9dL8/pBKOFkTix9E8cvv
	skCOKDtLmOHM8jd2n0rhHa+O5UI7GkItQ9pqfexs8eaK1R4vQ729ogQKRxJjnjKgnvpZuU
	yK3l0PjMn/xf6Zm3K61PrXwGpdvZBYlew1o7EK4gBzzwGJtZYZnHiRgQMDtDYYSJx91hqb
	/JxH+IBhV+PfM2j27pMQgKU7Ix6BLnw98B545utC2DZ8eKAEOm9TSDhCl8lD5UfvhEx9OI
	goF14YLFuNIgmAXqM+WAXEYDVlRONprF0PClcMPQCt+bAV+c4uULJHqpFgM0dA==
Date: Thu, 29 Aug 2024 10:35:52 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch net-next v4] ethtool: pse-pd: move pse validation into
 set
Message-ID: <20240829103552.09f22f98@device-28.home>
In-Reply-To: <20240828174340.593130-2-djahchankoike@gmail.com>
References: <20240828174340.593130-2-djahchankoike@gmail.com>
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

Hi Diogo,

On Wed, 28 Aug 2024 14:43:17 -0300
Diogo Jahchan Koike <djahchankoike@gmail.com> wrote:

> Move validation into set, removing .set_validate operation as its current
> implementation holds the rtnl lock for acquiring the PHY device, defeating
> the intended purpose of checking before grabbing the lock.

[...] 

>  static int
> -ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
> +ethnl_set_pse_validate(struct phy_device *phydev, struct genl_info *info)
>  {
>  	struct nlattr **tb = info->attrs;
> -	struct phy_device *phydev;
> -
> -	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
> -				      info->extack);
> +	
   ^^^
You have an extra white space here. Make sure you run your patch through
the checkpatch script to detect this kind of issues.

The rest looks good to me. For the next version,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

