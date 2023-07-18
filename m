Return-Path: <netdev+bounces-18714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD367585B4
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962D41C20DE4
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C934171C3;
	Tue, 18 Jul 2023 19:41:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6AB171BE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 19:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471F5C433C7;
	Tue, 18 Jul 2023 19:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689709317;
	bh=e5TeCW4dLFqhF4I7vtXPeuXyiF89ZhZmbGGaNJLtsuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZmUyhUNdt4h2uDTeo1tZEPe79idS0yJjGLCyV0L1I75XRoF45kTFlvgfJKdsfY0O
	 70bXQtCxFmA4fF/FJTi4i/L8GduaT4jhAhh31ouYhwVq2J6ZH47MBxujs0/OM3jsf4
	 SzzL+AMPmvnlFTemY9NkB9Es3O4N3a1XWDzskMDmXClqKcK5i2CIkHMqu2SMmhBCNo
	 T8ZP7R59dEajX3QnT997W5kol1+DSOIa43iEIzSXQDeaRHgdK7Ptf2Bd3wpn5QQ4ed
	 KPBtxOUPXv2i9NDKdTfgwS+7QHSoo5r1qg8zHtRt/ASTaTtPkG3HD5IS9SyRsHaDU2
	 VbQwK9ivcklGA==
Date: Tue, 18 Jul 2023 12:41:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kees Cook <kees@kernel.org>, justinstitt@google.com, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Nick
 Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] net: dsa: remove deprecated strncpy
Message-ID: <20230718124156.07632716@kernel.org>
In-Reply-To: <dbfb40d7-502e-40c0-bdaf-1616834b64e4@lunn.ch>
References: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
	<316E4325-6845-4EFC-AAF8-160622C42144@kernel.org>
	<20230718121116.72267fff@kernel.org>
	<dbfb40d7-502e-40c0-bdaf-1616834b64e4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 21:31:04 +0200 Andrew Lunn wrote:
> On Tue, Jul 18, 2023 at 12:11:16PM -0700, Jakub Kicinski wrote:
> > On Tue, 18 Jul 2023 11:05:23 -0700 Kees Cook wrote:  
> > > Honestly I find the entire get_strings API to be very fragile given
> > > the lack of passing the length of the buffer, instead depending on
> > > the string set length lookups in each callback, but refactoring that
> > > looks like a ton of work for an uncertain benefit.  
> > 
> > We have been adding better APIs for long term, and a print helper short
> > term - ethtool_sprintf(). Should we use ethtool_sprintf() here?  
> 
> I was wondering about that as well. There is no variable expansion in
> most cases, so the vsnprintf() is a waste of time.
> 
> Maybe we should actually add another helper:
> 
> ethtool_name_cpy(u8 **data, unsigned int index, const char *name);

I wasn't sure if vsnprintf() is costly enough to bother, but SG.

Probably without the "unsigned int index", since the ethtool_sprintf()
API updates the first argument for the caller.

> Then over the next decade, slowly convert all drivers to it. And then
> eventually replace the u8 with a struct including the length.
> 
> The netlink API is a bit better. It is one kAPI call which does
> everything, and it holds RTNL. So it is less likely the number of
> statistics will change between the calls into the driver.

