Return-Path: <netdev+bounces-187661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 210A4AA8937
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 22:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287431893738
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB019D8BC;
	Sun,  4 May 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFGroO52"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1658494
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746389889; cv=none; b=YzmHoONXt3ATohHyC2QYMXvKUMgBe+baLhQHxx9auGG6KCE/vVN5GhxyO0tB8F+eh6jg4GMveIJBYNgfjvesLFSOgK0RHCRR9SCdGe28jvCP+A6121xgf5O/saZwVs9HBe4u1xa2BmcKnR4Ml39GKy1wa6C2TiF9U6RXE6RVtjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746389889; c=relaxed/simple;
	bh=il2HSTg1WEyM9SDKF5gmqGQXSIHezegaxdU8pWyTrvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2CQCP67hBuYW3WaZLcYow/Sn0KUZTIBV7tWo9PV9/8LpNmbBkLhWP8h7grBOh5osakgU+kaNg7hLNEkzGY0a5Ogk1QDTQJh4c+noQc7bATNxTHkj1DK2RSWsp+w+WnsvadDYKV0N8ERdyFnHCCNmK2ro84EtN2xZCtq2kz05Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFGroO52; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2241053582dso55880575ad.1
        for <netdev@vger.kernel.org>; Sun, 04 May 2025 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746389887; x=1746994687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3CJ9OYEzL25KIEHSXVFSRpTW5a8w6nofrKrinB5k8wA=;
        b=gFGroO52EpU+HIBFFUoy8zlOOTNMjmTCdXi7Dc1CgtQyvLfYP2v7DbC9RkE9N3gCBj
         IFQUrwZps/AGYtSl5f6IO+ybkdCdIz60mdIC0keIpg0tYxr73hUxG5+gv1QGBEgTSyso
         lLb8RlOCeT+cOaym/pKUR4iIz4ZXy5gLAsASdxIKahw2/nTZjycmUAqPTo6X7gehjodF
         CsP/5dMwq293YgRnNnvwLbPupvp9Htr4U+TFO22YmIWs0o2SYWrwQSt78GbeRJ3aN6vB
         LqlF6LBaq9P1Z21C2OkBx1KUZMdOuAKs7AsCdP5aF5k21bynVLu9VvpfspuHjqWLw4rl
         rs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746389887; x=1746994687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CJ9OYEzL25KIEHSXVFSRpTW5a8w6nofrKrinB5k8wA=;
        b=C5pxByydcoeDjILh3TrCDYooOSDtFTCwnFZbKIPfENCe4sn50i+LGRsAqW3l9W0xwF
         4uv2oy2MxJliUrMcCCGUyGJv+uph5iPEASIvxulAwgMTYJ/5Q/lQ/0wiAYUly4m1miqp
         cQK5nicW/YIOGmsOvaxHAfUw2KsIlYoEWgT1pZqtpvc2N9nyl5IMkDKGQXKKdgoG+9Ol
         /4zDMMNF7Y6zygOu89tP1/OfD/PBt0LmP8Ne6SMFOT7HQhv4/dAsGNOkgtFytjHupBXA
         HVJ41SwzmlDm1TiMOalY+3XjFYNZ/lMYZ+luwQKB2c2qdHIWcz9a0OCGLLWWuEjO1HaH
         BFeg==
X-Gm-Message-State: AOJu0YxOxDQk5sPYMZvZOdG3UUVrPDIMtfOMOlCOknkbLt3S1OcE5bSc
	JKaUky9JdAhsnDnBmZlBen+PkNL0gtrgUVG1zWM8JYPGFDf6wCaL
X-Gm-Gg: ASbGncsgIxDST/g1IrN7UCGhSlfBKwvImTS60AEwHoihwNR2xuM6Uqv7Yzw7NjfPGwU
	OEoScQBlEwfAiMW4VqR/oNbHJ/MjRzMN37mj9jYHHHPCKl7R72/3M4J43Y53MiTGXcKREW7k+Lq
	Pnvf99hKu9WaNUF+dd6mFM8oTzcwtjih2gx9rmgiFi36EKSTo/JrhnSf+jNb94uU/5EVkP4Z9V8
	Icf3VHToiJZXh5d4MpFVf/aKxzB3EpRphIOA8+tb07TcM1IMu1CytMNO8mJtoEy7wwrFTjwsnMy
	+m/tIMjctiq++htegPjUSfbA7d6E7SJqYu0mmNazihg=
X-Google-Smtp-Source: AGHT+IFzj10u17tG4uzXyiAblF/d/oVI7X+bT997Y9FX0EK0jqv0PHUpSj0taMzvpbXjqcT22s9ffw==
X-Received: by 2002:a17:902:e5c7:b0:22c:36d1:7a49 with SMTP id d9443c01a7336-22e1eaeff29mr84053965ad.53.1746389886712;
        Sun, 04 May 2025 13:18:06 -0700 (PDT)
Received: from localhost ([66.205.136.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e188285f8sm31153595ad.46.2025.05.04.13.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 13:18:05 -0700 (PDT)
Date: Sun, 4 May 2025 13:18:04 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	alan@wylie.me.uk
Subject: Re: [Patch net 1/2] sch_htb: make htb_deactivate() idempotent
Message-ID: <aBfEk6QUI//BIyZC@pop-os.localdomain>
References: <20250428232955.1740419-1-xiyou.wangcong@gmail.com>
 <20250428232955.1740419-2-xiyou.wangcong@gmail.com>
 <eecd9a29-14f9-432d-a3cf-5215313df9f0@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eecd9a29-14f9-432d-a3cf-5215313df9f0@mojatatu.com>

On Wed, Apr 30, 2025 at 12:19:03PM -0300, Victor Nogueira wrote:
> On 4/28/25 20:29, Cong Wang wrote:
> > Alan reported a NULL pointer dereference in htb_next_rb_node()
> > after we made htb_qlen_notify() idempotent.
> > 
> > It turns out in the following case it introduced some regression:
> > 
> > htb_dequeue_tree():
> >    |-> fq_codel_dequeue()
> >      |-> qdisc_tree_reduce_backlog()
> >        |-> htb_qlen_notify()
> >          |-> htb_deactivate()
> >    |-> htb_next_rb_node()
> >    |-> htb_deactivate()
> > 
> > For htb_next_rb_node(), after calling the 1st htb_deactivate(), the
> > clprio[prio]->ptr could be already set to  NULL, which means
> > htb_next_rb_node() is vulnerable here.
> 
> If I'm not missing something, the issue seems to be that
> fq_codel_dequeue or codel_qdisc_dequeue may call qdisc_tree_reduce_backlog
> with sch->q.qlen == 0 after commit 342debc12183. This will cause
> htb_qlen_notify to be called which will deactivate before we
> call htb_next_rb_node further down in htb_dequeue_tree (as you
> said above).
> 
> If that's so, couldn't we instead of doing:
> 
> > @@ -348,7 +348,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
> >    */
> >   static inline void htb_next_rb_node(struct rb_node **n)
> >   {
> > -	*n = rb_next(*n);
> > +	if (*n)
> > +		*n = rb_next(*n);
> >   }
> 
> do something like:
> 
> @@ -921,7 +921,9 @@ static struct sk_buff *htb_dequeue_tree(struct htb_sched
> *q, const int prio,
>                 cl->leaf.deficit[level] -= qdisc_pkt_len(skb);
>                 if (cl->leaf.deficit[level] < 0) {
>                         cl->leaf.deficit[level] += cl->quantum;
> -                       htb_next_rb_node(level ?
> &cl->parent->inner.clprio[prio].ptr :
> +                       /* Account for (fq_)codel child deactivating after
> dequeue */
> +                       if (likely(cl->prio_activity))
> +                               htb_next_rb_node(level ?

It reads odd to me to check cl->prio_activity before htb_next_rb_node(),
and I don't see any existing pattern of using this.

My patch pretty much follows all the existing patterns of checking
either cl->prio_activity or cl->leaf.q->q.qlen. So, although it looks
bigger from diffstat, it is safer from this point of view.

Thanks!

