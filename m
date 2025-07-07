Return-Path: <netdev+bounces-204683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBCCAFBBD1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B791D16CA4E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1598266EEA;
	Mon,  7 Jul 2025 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLth78te"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A6266B65
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751917244; cv=none; b=E3YmhTkE6maBX1dSaKx+aDwDO7FLTQ5lyYaQQO5Hjddg/H1pSe4cgMe0/DHVDgYl5zPjaVO3CeXNb8DAVoWyJRmqJwfqmb9pvCZdFmQ27IAuCAQgZ2u8CfgiRZfAc7bbQOuFvu5TDosFMavidu1hMxsoWtekswpBHDbxFqOGFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751917244; c=relaxed/simple;
	bh=THWFh1m0HZ+K8ZcZT3BzRuteofGhTBbzq6cVM4wAcMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odXJ4R0/pttLAx8Kkkre2PNQ7AslVEkP+DUFbuT8P7D4rMEfJBSRdkZRA47jgrCYsp2sytj6xuBcIB8RaqlCQzVjcsvSP806U4ysrm7cvMykzg3CaxcNigtz5FNrP3+I30s4OsadBiIP2qXPWL7O6ceMEprIHsvt0/SApe/6pNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLth78te; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74af4af04fdso3517719b3a.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751917242; x=1752522042; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZNwAhDs0n7u3s+MHu2tzeKRRRuf2WyE5yN2L4FyRPIY=;
        b=gLth78teZ9LO5UvQPtyraUvTagBUUn2Mrtg+K1+cGKY9vICS4LrQDpmC+Wp6V/h7EH
         utfm4Wqq+WycmQ0WTM7fUa2jkQryF08HjkuNZcpgmIu+Aq/FlAZw/pUT8FPIG3AkAkUX
         4fDIngT0gT3KLRj5y4GTr1+a9TW7amTBnmMJjxOgnsgJu9bZohyDsNkRq35UOERjXhTI
         EFmG30rk5uCj2cobsQr3Z6O1r/tSiTiFGW/7BrjdgQKQDcSX+R+JkIaLbNpbpUdbfcrv
         ZHYwaP1/2pJlmaVoJHa81wKSWcb34TyN7SGkfA5Z3X9VtLcORUso6B9d+ywqy2Dl4fHp
         j76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751917242; x=1752522042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNwAhDs0n7u3s+MHu2tzeKRRRuf2WyE5yN2L4FyRPIY=;
        b=G5556V3IQYzSrz0QeErIJyjNxhKEGhaqAyL1TiKxX2MkyXe54qQMC4TzoZ6u5uAiLZ
         LR1WvWg7FO6HcsKUhGlyWbaGVKG21VPLpQT9AhCb7d3r1tcslGHA2fR4flfRZmo0kphR
         5pfPoda6lckV/QizEj/qfi1Vjzpl6AM9ybQ39bMMieX770hcoTo7+6DDF0KpifVMbhqy
         MpeNfu8xIKfjo2vVia80J6JIrP8HWiiC/FdX1CwcArREIihVt94+L/geGZvEitG5VALv
         zl3dKz4YbQ36B0nKdkBM2BmOXmgar/xa0XmjKpfyBSinJxo9zbz3l4cNh8lWwBTtnIbW
         Gx1Q==
X-Gm-Message-State: AOJu0Yxmn5saTXH7TheAPtx7w8x5sWwtB4lpCbfUAaX9BMxYnBt5UMNG
	R70gGJR8WlrAi00str4NMzpCvDzseWyfHe5YAV4kUKg2I9ArKWGHdBbp
X-Gm-Gg: ASbGncsHRBYCUmH1uheGMq08jhXLk291RGMoak8k8OeVu3fhhJQC0uN2bhN6vbXZlnz
	c8HB0qocc2dVR1RVlAtoa7hsGKJqag5L6o2ZbLPeBlyBeM2DhZ2eRNOKMTRKlzVKQ2f7gEA0nR4
	03B8UJaXMvXp5jd/BvzDnOLN/4XDxe/kSpv0KlZeSQYCJguFQ4HpKefqFFXhgobfRuCcno/bFMe
	ZJBd9AX7ThoGw3mcwDLw3kvYSbfAf2BSMvJLPn722DmDh1IIqKY63D84ByTkUXWtMZCbPoNMHsf
	71SSnrZGpG7izTQCNhqOqLgnhNpCKRPEOyE20KhaXQmEiiMX20RVs6sQm4+WomVxrg==
X-Google-Smtp-Source: AGHT+IEpsS0LgTH8Wcn4p/9VRHkD+xy3M9ocMrcOs7n9SU0yBqrkDgM+qZ/QuHDN2v9DdALkOKaigg==
X-Received: by 2002:a05:6a21:6d84:b0:220:2fe9:f07a with SMTP id adf61e73a8af0-22b23d85f2cmr1279460637.6.1751917242288;
        Mon, 07 Jul 2025 12:40:42 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee4797dasm9569217a12.26.2025.07.07.12.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 12:40:41 -0700 (PDT)
Date: Mon, 7 Jul 2025 12:40:40 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, will@willsroot.io, stephen@networkplumber.org,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
Message-ID: <aGwiuDju8TNvRdGe@pop-os.localdomain>
References: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
 <20250701231306.376762-2-xiyou.wangcong@gmail.com>
 <aGSSF7K/M81Pjbyz@pop-os.localdomain>
 <CAM0EoMmDj9TOafynkjVPaBw-9s7UDuS5DoQ_K3kAtioEdJa1-g@mail.gmail.com>
 <CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com>
 <aGh2TKCthenJ2xS2@pop-os.localdomain>
 <CAM0EoM=99ufQSzbYZU=wz8fbYOQ2v+cMa7BX1EM6OHk+dBrE0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=99ufQSzbYZU=wz8fbYOQ2v+cMa7BX1EM6OHk+dBrE0Q@mail.gmail.com>

On Sat, Jul 05, 2025 at 09:52:05AM -0400, Jamal Hadi Salim wrote:
> On Fri, Jul 4, 2025 at 8:48 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > On Wed, Jul 02, 2025 at 11:04:22AM -0400, Jamal Hadi Salim wrote:
> > > On Wed, Jul 2, 2025 at 10:12 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > > >
> > > > On Tue, Jul 1, 2025 at 9:57 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jul 01, 2025 at 04:13:05PM -0700, Cong Wang wrote:
> > > > > > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > > > > > index fdd79d3ccd8c..33de9c3e4d1b 100644
> > > > > > --- a/net/sched/sch_netem.c
> > > > > > +++ b/net/sched/sch_netem.c
> > > > > > @@ -460,7 +460,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
> > > > > >       skb->prev = NULL;
> > > > > >
> > > > > >       /* Random duplication */
> > > > > > -     if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
> > > > > > +     if (tc_skb_cb(skb)->duplicate &&
> > > > >
> > > > > Oops, this is clearly should be !duplicate... It was lost during my
> > > > > stupid copy-n-paste... Sorry for this mistake.
> > > > >
> > > >
> > > > I understood you earlier, Cong. My view still stands:
> > > > You are adding logic to a common data structure for a use case that
> >
> > You are exaggerating this. I only added 1 bit to the core data structure,
> > the code logic remains in the netem, so it is contained within netem.
> 
> Try it out ;->
> Here's an even simpler setup:
> 
> sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0
> 0 0 0 0 0 0 0 0 0 0 0
> sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
> netem_bug_test.o sec classifier/pass classid 1:1
> sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%
> then:
> ping -c 1 127.0.0.1

Of course (I replaced your ebpf filter with matchall):

[root@localhost ~]# cat netem_from_jamal.sh
tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# tc filter add dev lo parent 1:0 protocol ip bpf obj netem_bug_test.o sec classifier/pass classid 1:1
tc filter add dev lo parent 1:0 protocol ip matchall classid 1:1
tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%

[root@localhost ~]# bash -x netem_from_jamal.sh
+ tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
+ tc filter add dev lo parent 1:0 protocol ip matchall classid 1:1
+ tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%
[root@localhost ~]# ping -c 1 127.0.0.1
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=3.84 ms

--- 127.0.0.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 3.836/3.836/3.836/0.000 ms

There is clearly no soft lockup. Hence the original issue has been successfully fixed.

> 
> Note: there are other issues as well but i thought citing the ebpf one
> was sufficient to get the point across.

Please kindly define "issues" here. My definition for issue in this
context is the soft lockup issue reported by William. Like I already
explained, I have _no_ intention to solve any other issue than the one
reported by William, simply because they probably can be deferred to
-net-next.

> 
> >
> > > > really makes no sense. The ROI is not good.
> >
> > Speaking of ROI, I think you need to look at the patch stats:
> >
> > William/Your patch:
> >  1 file changed, 40 insertions(+)
> >
> > My patch:
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> 
> ROI is not just about LOC. The consequences of a patch are also part
> of that formula. And let's not forget the time spent so far debating
> instead of plugging the hole.

LOC matters a lot for code review and maintainance.

> 
> >
> > > > BTW: I am almost certain you will hit other issues when this goes out
> > > > or when you actually start to test and then you will have to fix more
> > > > spots.
> > > >
> > > Here's an example that breaks it:
> > >
> > > sudo tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0
> > > 0 0 0 0 0 0 0 0 0 0 0
> > > sudo tc filter add dev lo parent 1:0 protocol ip bpf obj
> > > netem_bug_test.o sec classifier/pass classid 1:1
> > > sudo tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%
> > > sudo tc qdisc add dev lo parent 10: handle 30: netem gap 1 limit 4
> > > duplicate 100% delay 1us reorder 100%
> > >
> > > And the ping 127.0.0.1 -c 1
> > > I had to fix your patch for correctness (attached)
> > >
> > >
> > > the ebpf prog is trivial - make it just return the classid or even zero.
> >
> > Interesting, are you sure this works before my patch?
> >
> > I don't intend to change any logic except closing the infinite loop. IOW,
> > if it didn't work before, I don't expect to make it work with this patch,
> > this patch merely fixes the infinite loop, which is sufficient as a bug fix.
> > Otherwise it would become a feature improvement. (Don't get me wrong, I
> > think this feature should be improved rather than simply forbidden, it just
> > belongs to a different patch.)
> 
> A quick solution is what William had. I asked him to use ext_cb not
> because i think it is a better solution but just so we can move
> forward.

I already posted a patch, instead of just arguing. Now you are arguing
about the patch I posted...

Thanks.

