Return-Path: <netdev+bounces-86628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C710389F974
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 16:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82EFA2857C3
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4495216F0CC;
	Wed, 10 Apr 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b="WmFiF2q/"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nohats.ca (mx.nohats.ca [193.110.157.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA1816F0C8
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757752; cv=none; b=qCgcB2qJItbvqwOVJ7Y8W3Sspsf80E4sA9SShlvnaXBo7Ix38v0HLdvBCODlquN2xPg6VnrcBju5JvIza9k7PRumb+KuER4LCIFA9PuSW/r8F/dhwgIqSEerFWl0IdkT9CSpZEOwjx1B9uaF8ASjEA8edUvKVlMQqcdIxEi9EdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757752; c=relaxed/simple;
	bh=t626WBz4QG/pFsr1u7jA/gEzclLp/uWG/Qu8ZxQ4/aM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V/7a8DxIlJMOnFcSkPm9jCJ6IadYXl8lzQVPHK6E0lEerR+w+NCb4wu2l77teEHiUuBQduCqyBXDv8so9PV/itPUXZlri2KMjTwvbosSOwza0k62EDhj3zqa6gADX8iQpEjcJ44wKUx2L66a5pzrHOGbWC3tfch1UNFw88JctVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nohats.ca; spf=fail smtp.mailfrom=nohats.ca; dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b=WmFiF2q/; arc=none smtp.client-ip=193.110.157.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nohats.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nohats.ca
Received: from localhost (localhost [IPv6:::1])
	by mx.nohats.ca (Postfix) with ESMTP id 4VF45f6fKLz3Km;
	Wed, 10 Apr 2024 15:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nohats.ca;
	s=default; t=1712757158;
	bh=SBc68PnW8f1XdN8Pmd9O7gqoDGaa/9Xx2mWi0WiqVgw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=WmFiF2q/HQyMaCch1YltbFH7XJoT0F5w8ozLh2l7OFXrIxHPxikRSUcEJScz53h5K
	 LFqwUmFFsZB10Ph4TRh/3ii7p7WJFcfw6TFGtbSnDSLjVe0SMqcmbP8POGrmBzNvSh
	 A4wTJNT8CPA22zVlPFuBncII/qH40a7+LQ6HzuSs=
X-Virus-Scanned: amavisd-new at mx.nohats.ca
X-Spam-Flag: NO
X-Spam-Score: 0.566
X-Spam-Level:
Received: from mx.nohats.ca ([IPv6:::1])
	by localhost (mx.nohats.ca [IPv6:::1]) (amavisd-new, port 10024)
	with ESMTP id Q0D7DMqxW0qF; Wed, 10 Apr 2024 15:52:38 +0200 (CEST)
Received: from bofh.nohats.ca (bofh.nohats.ca [193.110.157.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.nohats.ca (Postfix) with ESMTPS;
	Wed, 10 Apr 2024 15:52:37 +0200 (CEST)
Received: by bofh.nohats.ca (Postfix, from userid 1000)
	id DDE5911BD543; Wed, 10 Apr 2024 09:52:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by bofh.nohats.ca (Postfix) with ESMTP id DA1A311BD542;
	Wed, 10 Apr 2024 09:52:36 -0400 (EDT)
Date: Wed, 10 Apr 2024 09:52:36 -0400 (EDT)
From: Paul Wouters <paul@nohats.ca>
To: Sabrina Dubroca <sd@queasysnail.net>
cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, antony.antony@secunet.com, 
    Steffen Klassert <steffen.klassert@secunet.com>, 
    Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org, 
    Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v9] xfrm: Add Direction to the
 SA in or out
In-Reply-To: <ZhZUcNKD8viY6Y3W@hog>
Message-ID: <8b27d067-d401-88b9-f784-4589b27f8e32@nohats.ca>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com> <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com> <ZhY_EE8miFAgZkkC@hog> <f2c52a01-925c-4e3a-8a42-aeb809364cc9@6wind.com> <ZhZLHNS41G2AJpE_@hog>
 <1909116d-15e1-48ac-ab55-21bce409fe64@6wind.com> <ZhZUcNKD8viY6Y3W@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 10 Apr 2024, Sabrina Dubroca via Devel wrote:

> 2024-04-10, 10:37:27 +0200, Nicolas Dichtel wrote:
>> Le 10/04/2024 à 10:17, Sabrina Dubroca a écrit :
>> [snip]
>> >> Why isn't it possible to restrict the use of an input SA to the input path and
>> >> output SA to xmit path?
>> > 
>> > Because nobody has written a patch for it yet :)
>> > 
>> For me, it should be done in this patch/series ;-)
>
> Sounds good to me.

If this is not the case currently, what happens when our own generated
SPI clashes with a peer generated SPI? Could it be we end up using the
wrong SA state?

Paul

