Return-Path: <netdev+bounces-22935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F4A76A1BA
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 22:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D513528154E
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E541DDDF;
	Mon, 31 Jul 2023 20:09:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9118C32
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 20:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1342EC433C8;
	Mon, 31 Jul 2023 20:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690834194;
	bh=Yv9eIR3jcIkEdTn0HOZVv1V441z6076tjCIjywPROTA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=A+7XY4WXlGZjlbZ8kK78b2N8m9ugG5ke3EVSXIpiUChiK1UHAnPfDKp67wJut7d0j
	 XkGlufl66qwTluGJFaQQ5nRC752ZGbOFy39Qu4jFvUt/+wDQc8aX/WdxFtuikmEbQN
	 6jcplC8Iq4Fvky+uLxK6/VoFLaY4OnSu8KSiBh8+Mu1SEk4mRm4xQYSKiaYhE0QT6q
	 468RUUdSFo/eEoi3nYtBRypUV9P0QQTV2WXq1zGWFpK6QPydJ25DKsh/JWujhYHfC5
	 dNj7ZtJx6z60xEVKFIVRLZdL7FWoLGTnSP050apyh6SWGGHNq3Owytz+4EjVVYPeJj
	 cmwJiVjaW854A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A5A98CE1066; Mon, 31 Jul 2023 13:09:53 -0700 (PDT)
Date: Mon, 31 Jul 2023 13:09:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Huang <mmpgouride@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rcu@vger.kernel.org,
	roman.gushchin@linux.dev
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Message-ID: <43d29007-3c59-4497-a1e5-26f182a7f4c5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
 <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>

On Fri, Jul 21, 2023 at 10:27:04PM +0800, Alan Huang wrote:
> 
> > 2023年7月21日 20:54，Joel Fernandes <joel@joelfernandes.org> 写道：
> > 
> > 
> > 
> >> On Jul 20, 2023, at 4:00 PM, Alan Huang <mmpgouride@gmail.com> wrote:
> >> 
> >> ﻿
> >>> 2023年7月21日 03:22，Eric Dumazet <edumazet@google.com> 写道：
> >>> 
> >>>> On Thu, Jul 20, 2023 at 8:54 PM Alan Huang <mmpgouride@gmail.com> wrote:
> >>>> 
> >>>> Hi,
> >>>> 
> >>>> I noticed a commit c87a124a5d5e(“net: force a reload of first item in hlist_nulls_for_each_entry_rcu”)
> >>>> and a related discussion [1].
> >>>> 
> >>>> After reading the whole discussion, it seems like that ptr->field was cached by gcc even with the deprecated
> >>>> ACCESS_ONCE(), so my question is:
> >>>> 
> >>>>      Is that a compiler bug? If so, has this bug been fixed today, ten years later?
> >>>> 
> >>>>      What about READ_ONCE(ptr->field)?
> >>> 
> >>> Make sure sparse is happy.
> >> 
> >> It caused a problem without barrier(), and the deprecated ACCESS_ONCE() didn’t help:
> >> 
> >>   https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
> >> 
> >> So, my real question is: With READ_ONCE(ptr->field), are there still some unusual cases where gcc 
> >> decides not to reload ptr->field?
> > 
> > I am a bit doubtful there will be strong (any?) interest in replacing the barrier() with READ_ONCE() without any tangible reason, regardless of whether a gcc issue was fixed.
> > 
> > But hey, if you want to float the idea…
> 
> We already had the READ_ONCE() in rcu_deference_raw().
> 
> The barrier() here makes me think we need write code like below:
> 	
> 	READ_ONCE(head->first);
> 	barrier();
> 	READ_ONCE(head->first);
> 
> With READ_ONCE (or the deprecated ACCESS_ONCE),
> I don’t think a compiler should cache the value of head->first.

Apologies for the late reply!

If both are READ_ONCE(), you should not need the barrier().  Unless there
is some other code not shown in your example that requires it, that is.

							Thanx, Paul

> > Thanks,
> > 
> > - Joel
> > 
> >> 
> >>> 
> >>> Do you have a patch for review ?
> >> 
> >> Possibly next month. :)
> >> 
> >>> 
> >>> 
> >>>> 
> >>>> 
> >>>> [1] https://lore.kernel.org/all/1369699930.3301.494.camel@edumazet-glaptop/
> >>>> 
> >>>> Thanks,
> >>>> Alan
> >> 
> 

