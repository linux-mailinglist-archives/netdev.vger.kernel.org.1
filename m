Return-Path: <netdev+bounces-94461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BE08BF8A6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236D0285CD8
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D6B2E417;
	Wed,  8 May 2024 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYMulct1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F528FF;
	Wed,  8 May 2024 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157408; cv=none; b=BAE++hD+5bBFM/n/VI2lEHE09BH5rJTSpSrJnm8uPz9beRK9VhuV9rwwLVGHIly3NcCS+aCB5ZtRF0LZ5zASiA9nFZJcpadBtVlx6tYO3cVZqzvu+pLCU5EIiz47TNS1lOWV+G2XDHXAADkHAQIQ8AQPcV2Tw4Q/otlUJ5XHM4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157408; c=relaxed/simple;
	bh=Yt5LjAYmCH2zW6V6lFvCUyRwoou5rXH6aioGietuBfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MM9sW2Eceas69W9e6YmfaSypkDzmEhjlzE3Ccu53sNEKOkHMBffmJUu5QG1s/aQhYTCl4aCUdzzrtNNTdCTktlZdtYwU2IocrETJC1+PhJeuzcT2VuayOdAp6xcw/3GedgDxdWaMXRGqAKO4OCXNcy4DEZnDZooZWp4kls5Is+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYMulct1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E05EC113CC;
	Wed,  8 May 2024 08:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715157408;
	bh=Yt5LjAYmCH2zW6V6lFvCUyRwoou5rXH6aioGietuBfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYMulct1JFmm6SkV4txli38l3rSTtGc9dsso3RxQgTY7lyFMTn22SUOhR/2ZAWjHL
	 G6HxuCBbq4SOV62ahDrvpdHs54zUffQDB3KGxz/CE7BNboK0DAb9qzFXxohl5EQ2S+
	 GnbD7lQ9DScs0svtiYJUyqdODzGpHxsqGDwQIHmroO1LYX0gLhQrsIr8TAjjKGU1cq
	 HdTUNLiNc7WwdsONLdDfDUfYFqtDOIRk1tSj4c9KkoIFjkQOC5plqXfJV5sm8Zf9kC
	 WuZ2W6BdzBDadrmQswl3bXegCCR+Lx2tE9vKSBFYtH/XNscvaLXdOZlYOQt4DgFmAg
	 4gMq7SzN+tkvw==
Date: Wed, 8 May 2024 09:36:43 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v17 02/13] rtase: Implement the .ndo_open
 function
Message-ID: <20240508083643.GN15955@kernel.org>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502091847.65181-3-justinlai0215@realtek.com>
 <20240503085257.GM2821784@kernel.org>
 <745b2ee9e81f4904920e0e4fe6e4df89@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <745b2ee9e81f4904920e0e4fe6e4df89@realtek.com>

On Mon, May 06, 2024 at 02:45:11AM +0000, Justin Lai wrote:

...

> > > +
> > > +             /* request other interrupts to handle multiqueue */
> > > +             for (i = 1; i < tp->int_nums; i++) {
> > > +                     ivec = &tp->int_vector[i];
> > > +                     snprintf(ivec->name, sizeof(ivec->name),
> > > + "%s_int%i", tp->dev->name, i);
> > 
> > nit: This line could trivially be split into two lines,
> >      each less than 80 columns wide.
> > 
> I will check if there are other similar issues and make corrections.

Thanks.

FWIIW, checkpatch.pl --max-line-length=80 can be helpful here.

