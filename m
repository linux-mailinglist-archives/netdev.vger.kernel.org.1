Return-Path: <netdev+bounces-127334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9AA9750EE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1E81F23A95
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C98187347;
	Wed, 11 Sep 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AM8WLIXw"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45251185B7B;
	Wed, 11 Sep 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054857; cv=none; b=AuDWAEZZwYR/UJlNGI5Gyd6ObyOE7tgIr7iv9KooI5WlebWFCWwXmcgKBcYs5XSs4CG7WNb4iFNdrRX2bYcTFc/IVvfwhP2I64qTrYXVyXeVk9MhyNVVM8D4mzGcsJx/lI2Li0n/YO1rxrQkHJfM6OxC+y6Abu2FUJRevpNLtOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054857; c=relaxed/simple;
	bh=/XXVT6q8RiMe9UT0xxXTkAytUD/qvI+7F7T0T5CI+rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OB7GAGZREsrnwWyet3n+pLD5mnjtgfag1RvBrkbiZSWYPI/koao4xiLprpvEVhj+JTBBhTGLZRLhf88WSd/reIfPSepIUi9A49SbPNf3w3WE6St2AZiY6k+0+tltXs9hUoZm4zLUfmzPiUqWezTH3rHa9mTaw5ixW07B0fYOYHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AM8WLIXw; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72151E0002;
	Wed, 11 Sep 2024 11:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726054853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ViEZfDybIPW9Y+6DVFpJ2QKOTVgxZ0iUBJMokDbxNBA=;
	b=AM8WLIXwDgbeSsOimNmOqvq/k74TuQtmpqbgyeE//eYVBaYcFp1SIbfpeYuBvWEClpeqyT
	DLvevss25btSL9CioPNsfo2d5/qrqjmPRxxS12FRU8+yUGehaMk79Z0h1/NFDcYQvxXolX
	OMW6mnYlxddt7gmzn5SmRcMiiauF35XiwkydelX7LQ1Du9iKFDrFJh7fMXfpVYj7Nk+ngN
	TU845Iuc5/HNIaVJVjB1W150y0wTE71+CmH5Qjk2Gwon/p5SNVzx6ZTj7xkUJqBOCDE+8U
	ghhYdxSMHXrIrLdnBfQt1+xRpiWavYrV9+CjjW18AI96ix9wFufawQx1QN/CFw==
Date: Wed, 11 Sep 2024 13:40:51 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com>,
 christophe.leroy@csgroup.eu, davem@davemloft.net, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: refcount bug in ethnl_phy_done
Message-ID: <20240911134051.7c3ad4a3@fedora.home>
In-Reply-To: <CANn89iJBFiHzMPCXyDB4=MAvE0OY5izFUzHxb3cnRzTRr=M3yA@mail.gmail.com>
References: <000000000000d3bf150621d361a7@google.com>
	<20240911120406.123aa4d4@fedora.home>
	<CANn89iJBFiHzMPCXyDB4=MAvE0OY5izFUzHxb3cnRzTRr=M3yA@mail.gmail.com>
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

Hi Eric,

On Wed, 11 Sep 2024 12:08:36 +0200
Eric Dumazet <edumazet@google.com> wrote:

> > I'm currently investigating this. I couldn't reproduce it though, even
> > with the C reproducer, although this was on an arm64 box. I'll give it
> > a try on x86_64 with the provided .config, see if I can figure out
> > what's going on, as it looks like the ethnl_phy_start() doesn't get
> > called.  
> 
> Make sure to have in your .config
> 
> CONFIG_REF_TRACKER=y
> CONFIG_NET_DEV_REFCNT_TRACKER=y
> CONFIG_NET_NS_REFCNT_TRACKER=y

Good point, I now reproduce the issue indeed. Thanks a lot for the tips,

Maxime

