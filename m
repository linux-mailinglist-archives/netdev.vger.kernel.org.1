Return-Path: <netdev+bounces-119104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7F49540D3
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 07:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E081F2163D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9B67641D;
	Fri, 16 Aug 2024 05:03:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6106478B4E;
	Fri, 16 Aug 2024 05:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784631; cv=none; b=KIVDHTp2aVmhY6RAIvwNduYi1bogidhxUaBk5dc4Y9ajMofcssI9U2EBVgRCONcc4yqiUcGjuskC1tssU4OTsnra3KB44qqJfvCEAatiSbkAyrlMGmxhs0QuWvWurIRSA350N5ONIv65kDi0ALq9PHGu3aiCw8RVN1dstRw1SIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784631; c=relaxed/simple;
	bh=at/5sXA7hMGXbGdtLNpxmOkLM5DfI4PsBAf5VoFdLHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZw1HeQdOtPdmx8bmk/uagv4oX357bEQ26HHMhZwbmFwAg/TjWHa4PtiNws1jO6NvsCAb53TN7B3Gyb5SPOb1h0xJYF3bx9veL537DTy7ZcjxEm4A1T/WrizuS7YAnOkmNcYEeIiP7r0kKjuEDp1fRtZGcPBwvlTgEL2Z/sg3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 47G53KDA015224;
	Fri, 16 Aug 2024 07:03:20 +0200
Date: Fri, 16 Aug 2024 07:03:20 +0200
From: Willy Tarreau <w@1wt.eu>
To: yangzhuorao <alex000young@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, xkaneiki@gmail.com,
        hackerzheng666@gmail.com
Subject: Re: [PATCH] net: sched: use-after-free in tcf_action_destroy
Message-ID: <20240816050320.GA15186@1wt.eu>
References: <20240816015355.688153-1-alex000young@gmail.com>
 <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Aug 16, 2024 at 12:06:25AM -0400, Jamal Hadi Salim wrote:
> On Thu, Aug 15, 2024 at 9:54 PM yangzhuorao <alex000young@gmail.com> wrote:
> >
> > There is a uaf bug in net/sched/act_api.c.
> > When Thread1 call [1] tcf_action_init_1 to alloc act which saves
> > in actions array. If allocation failed, it will go to err path.
> > Meanwhile thread2 call tcf_del_walker to delete action in idr.
> > So thread 1 in err path [3] tcf_action_destroy will cause
> > use-after-free read bug.
> >
> > Thread1                            Thread2
> >  tcf_action_init
> >   for(i;i<TCA_ACT_MAX_PRIO;i++)
> >    act=tcf_action_init_1 //[1]
> >    if(IS_ERR(act))
> >     goto err
> >    actions[i] = act
> >                                    tcf_del_walker
> >                                     idr_for_each_entry_ul(idr,p,id)
> >                                      __tcf_idr_release(p,false,true)
> >                                       free_tcf(p) //[2]
> >   err:
> >    tcf_action_destroy
> >     a=actions[i]
> >     ops = a->ops //[3]
> >
> > We add lock and unlock in tcf_action_init and tcf_del_walker function
> > to aviod race condition.
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in tcf_action_destroy+0x138/0x150
> > Read of size 8 at addr ffff88806543e100 by task syz-executor156/295
> >
> 
> Since this is syzkaller induced, do you have a repro?
> Also what kernel (trying to see if it was before/after Eric's netlink changes).
> 
> cheers,
> jamal

In addition, please note that since this is public, there's no point in
CCing security@k.o (which I've dropped from the CC list) since there's
no coordination needed anymore.

Thanks!
Willy

