Return-Path: <netdev+bounces-133320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2139959D6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA8D1F22106
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 22:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489F0215F47;
	Tue,  8 Oct 2024 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQI3fZjh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E13214A82;
	Tue,  8 Oct 2024 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425419; cv=none; b=ExRnFDlVJbVH0JV0KPxDe47BL/yF1rdCORjPFfRrKkeLXXrfBCLMh5bMtvXL+KhKAn0POV0oiSQhdsidu97qSqyYMAy/td/rvYFbAr454oahaQ7f13GdmgMEsF9LAwibqhpOHT7YEP24WWrJrslP6mUo1ZOQm91TTgyUuvEorbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425419; c=relaxed/simple;
	bh=sK1P7HoZN41Pt/ym/ha4xE4SRoOw6oIzWTyHU8q1KDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0o+jc4LJw6/t7bdKbrSekYlMXjeZ2wwaUIEXiiDpnJdNAQan3iEGWlbRLdofFMtlxX+1NEJl+KICcf9+YAdEcMOCSB+e0JhxOa9SjWtoAmT42oZ0y0UXQkdolX+oioxvfZA1IFrkYeWxctTVYdOol74EQEyVfnC2JIhCIkJGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQI3fZjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD42C4CEC7;
	Tue,  8 Oct 2024 22:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728425418;
	bh=sK1P7HoZN41Pt/ym/ha4xE4SRoOw6oIzWTyHU8q1KDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kQI3fZjhPvWJN2UW7SHebKncT/c3sfK/ba2b+eClfc1qI7PwR5JKgqvncTslwt3kT
	 kbF44Ph6i9jopCTsIxRAOLoqcO4Dd6yAg2kRal0PwhEhwCE67GPGpbb+kxvNKPcTGw
	 gRugCs/UMsKPa8rv8yI9F0wsVv1ci3k/Gja2FtbEtURTTXRlxy5uIdL1YQXmSfdPJt
	 f9s4+FKXkLxRCywDJGUKwak6ZdHXF7/reNqR1Q4EXcIcQXsN07Smf81YjferbY2CIC
	 f5CfqipVULxsVBUd2fytzl/0seDB4ADnAWY4lKxRbh2jp6d+6pmEwDkAWJxa7qSiol
	 OAZQ+CwG1qLRQ==
Date: Tue, 8 Oct 2024 15:10:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
 sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi
 <lorenzo@kernel.org>, David Ahern <dsahern@kernel.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Johannes Berg <johannes.berg@intel.com>, Breno
 Leitao <leitao@debian.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org (open
 list:DOCUMENTATION), linux-kernel@vger.kernel.org (open list),
 intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
Subject: Re: [RFC net-next v4 3/9] net: napi: Make gro_flush_timeout
 per-NAPI
Message-ID: <20241008151016.2e6a7d93@kernel.org>
In-Reply-To: <20241001235302.57609-4-jdamato@fastly.com>
References: <20241001235302.57609-1-jdamato@fastly.com>
	<20241001235302.57609-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 23:52:34 +0000 Joe Damato wrote:
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 55764efc5c93..33897edd16c8 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -377,6 +377,7 @@ struct napi_struct {
>  	struct list_head	dev_list;
>  	struct hlist_node	napi_hash_node;
>  	int			irq;
> +	unsigned long		gro_flush_timeout;
>  	u32			defer_hard_irqs;
>  };

Same story

