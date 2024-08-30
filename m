Return-Path: <netdev+bounces-123872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D831B966B39
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3DF1F22F52
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB811BF337;
	Fri, 30 Aug 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+zeQFLi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1F1B8EBA;
	Fri, 30 Aug 2024 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052981; cv=none; b=kMQ8rI259u6O6mstlq9TWj156QK4P8TyXeOpsoKEAXlogCKSYku7dpfBAzrLT8bmraTJLsuYc7pysobRv5uQNLnEvfWTbj6tkzbHu6pItpH2PWMdFms4Sigtsx8YLGz8YNIpjbTwh8bR3H2411oVzjI51xJH5Xq8S4qCfxG23oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052981; c=relaxed/simple;
	bh=dJe8wNkIWvUQjWgBxOajeKykm8DqekUhoVPp2/f7pMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/WgahVdzTgrYOF437xR9AhxV23yMyOkX1+Z42tPTO8QB2XvLW5p6smvQPlrvE1ogkHCpkCfD/IY/18aoii3HewO0z/Umea5w3KwbLNS7B0YxIcL2Y+vYoha8YP25mJ6Tfi3izScrzCv7ZGmaycRZrvRzCrBGz1dRQMv3LGSthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+zeQFLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4376AC4CEC2;
	Fri, 30 Aug 2024 21:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725052980;
	bh=dJe8wNkIWvUQjWgBxOajeKykm8DqekUhoVPp2/f7pMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g+zeQFLibZJs3tD5SXjng1Y/Drd5EtjIJ50/0c8sDnJlUAK661IHDCmWZl+sbkn7o
	 fecUrCzwhBo68sfr1LiUns77kYRuG6uJqo8Nu+K3qKHvxO78oHYH6rIBDnqtv5vi4X
	 il182GcP2TWUIGxv40BzV5sXF/Hhj9PVEuK8/KP9LoifqM7r5we+o+4i9rtr5BSgEY
	 HKQ/1wnsuiveiGNSm+En7XHuOw8Pj84DwvIqyb3TBWuLRkJR6M+JnXN9GDWLjSobg8
	 syIl/tkBd0X3mhTOr2xjNxl41h0x/AIKY6aoCXQ8yO3a3ww3IC19eFFkMqpBGXu1Cz
	 3qHsF9lrxagfw==
Date: Fri, 30 Aug 2024 14:22:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
 hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com,
 skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens <danielj@nvidia.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/5] netdev-genl: Dump napi_defer_hard_irqs
Message-ID: <20240830142259.045a4308@kernel.org>
In-Reply-To: <ZtIsHQoAEk1wfq0P@LQ3V64L9R2>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-3-jdamato@fastly.com>
	<20240829150828.2ec79b73@kernel.org>
	<ZtGMl25LaopZk1So@LQ3V64L9R2>
	<20240830132808.33129d22@kernel.org>
	<ZtIsHQoAEk1wfq0P@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 21:31:25 +0100 Joe Damato wrote:
> Is the overflow check in sysfs a fixes I send separately or can I
> sneak that into this series?

It does look kinda random in that patch, I'd send separately

