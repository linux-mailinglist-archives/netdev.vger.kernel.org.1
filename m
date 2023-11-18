Return-Path: <netdev+bounces-48912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FB97EFFEC
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 14:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CA8280F41
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74B5107B1;
	Sat, 18 Nov 2023 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8AF131;
	Sat, 18 Nov 2023 05:42:54 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1r4Lau-00038a-H1; Sat, 18 Nov 2023 14:42:44 +0100
Date: Sat, 18 Nov 2023 14:42:44 +0100
From: Florian Westphal <fw@strlen.de>
To: Kamil Duljas <kamil.duljas@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genetlink: Prevent memory leak when krealloc fail
Message-ID: <20231118134244.GB30289@breakpoint.cc>
References: <20231118113357.1999-1-kamil.duljas@gmail.com>
 <20231118120235.GA30289@breakpoint.cc>
 <CAFR=A7nkyx_Lf=p0BS-S68_vxQL97rUoLMZpo4kxHjKykAgTRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFR=A7nkyx_Lf=p0BS-S68_vxQL97rUoLMZpo4kxHjKykAgTRw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kamil Duljas <kamil.duljas@gmail.com> wrote:
> Yes, you're right. I did not think about it. So if we have a static
> pointer that may be resued, should not restore the pointer as at the
> beginning?
> static unsigned long *mc_groups = &mc_group_start;
> 
> At this moment we don't know how much memory is allocated. What do you
> think about this?

We do: mc_groups_longs.

> >                               new_groups = krealloc(mc_groups, nlen,
> >                                                     GFP_KERNEL);
> > -                             if (!new_groups)
> > +                             if (!new_groups) {
> > +                                     kfree(mc_groups);
> > +                                     mc_groups = &mc_group_start;
> >                                       return -ENOMEM;
> > +                             }

Seems wrong to shrink when we can't grow.  Whats the point?

