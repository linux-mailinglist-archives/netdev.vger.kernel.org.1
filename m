Return-Path: <netdev+bounces-204679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71425AFBB2E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A98C3A1B35
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2458E264F9C;
	Mon,  7 Jul 2025 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSggV6k/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C9B264FB5
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914289; cv=none; b=kQcsVv/n5Y+qznLbZ9fTqxAN2Vfiwl9tv+rC5Vbpc3UN6d+25sQN+CDIqJ0kJ9vzCOKJyzlQDWk73rblXkR7x5fX2//+KFuuLHMF6vq5Kr3/54LHwJBcQbgi2UEdr+Um/MnrxDlPDarbRXmVgpufuXgvhIaVoJigN1IDGjQLyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914289; c=relaxed/simple;
	bh=7Dyq+g8vXKZm05xo4YNvhtYGPEhtRXcPgk0V9oZEWrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca+TvommqXnMYQ2dqqQBWkN7KVpE/6PubVykpZc9Mzsdq2x+jKCkij1XjCN+rKD7IWdqZ2E8TeUC6NHUO6+Q+Rwfmwv4rDVKsVLHrT4o1xkGbnDmA/y0CFBD7pv0gX5cQzCOh8Lg5riRnhyFSai1NgPlwKVKo77c6wpwr0ed3ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSggV6k/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23c8a5053c2so24673445ad.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 11:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751914287; x=1752519087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf9s4/IWfL6dWIFbQZmAOMOqFnYhERS98+ucicCVk2Q=;
        b=YSggV6k/QBJDO/K29c9GIuvGObbB8T9NhSWk9hjTBWUKwarjQ5ZjoaHotZRlc6bzqs
         73XgbsDS2t+N67U5BmFJk3mXaOpVx8BPGqpJFvaQXGn3SZnse4Un/sdXyIKR1zyn9QjL
         eshYVBEN9QFlHO4XKKTKlSC9Td1x8cLUqX+atwM+mBUrbLiasrx57VMHN30f2IabL3jD
         pMHoRsPNcBZgtq4y4ZVp14MPAcIDDbtZiWVmxAnYvFE197xRQWPH6Y4RY481llSBliw6
         H1xwsBexyHghV1fOpUgsxatX2Eu5Rflk4AGPgJgG1yNFXk2I8WbOts8dYgrCA0/GlCn1
         z7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751914287; x=1752519087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf9s4/IWfL6dWIFbQZmAOMOqFnYhERS98+ucicCVk2Q=;
        b=Zl9MAeaQmVF17O8c6SEbyW7wuZo4rFCwRJChBg4/k4H9AiXDBMyc5vrDXUPB3VY9gE
         pUooPp8SXFd5zNZsCAFy004jlPT9CrE0ebay2jBKWFQIqP9msEfHdwnIh0qtXJrrG6g0
         7zxr8/pCIa3iui6shDGcjXg10VjhsE1CD0KfmzXDB0KtCRToOHAZD8LJSlZ6VKXDcpRf
         OdIBEnQVLCbfEkmIYC2W8tbiUiDgrKLRrcuEAoTGf0XiF5MSXiADSXNJ1urcYseNoO8w
         ZvDQCTqg/Q+TXKYmlnjvgJdMGAiIEVOmgvofisEh6zBP2yLIR/poWt+AdF23Oy03fEul
         H81w==
X-Gm-Message-State: AOJu0YyntnT4i8L4agyAp68DSXD15+U52cDo60uyOZLWqPsEmIljCMqO
	wkWrOYKj7YbrqLoN0VAInVijp3hlqYB0yF1BTm8AeHD+QeL27+fgLhGP
X-Gm-Gg: ASbGnctnxjCD3H/kV8VV7jUYI6QNDf4b5bPsfer6G10RccXB6Mhfq9kAjWjUheEITKu
	W/y4bCGL+lxIzYAxP4AkMYAUXpZJQaRHOGe318vgI1ySHVpwt/BXiNySUwx5XAbKMOB3LNo6IVi
	uUGS0NC39WgNp9BBN3xbajtxUTl+qs1+SvYu2xxsc+kuXHqh58OVtf65J/bZZSVfMZehGV+SDoT
	EyyWGHPGv1XGA+ccbJzjHbdlP9j6ScCZBb8/wCb1EJTUhW9xCCkvqq4F/KyUzgSKoJQ1si1yaov
	Q+AJaKZEvIVxJPscbKUZ7R1qTncCoykPFhZl1j0M4vLrytj5i/YNgrVO55vWPFZe+PiAPLKZ2fJ
	Y
X-Google-Smtp-Source: AGHT+IF5zdOsUbsjW0nSYY19U2Qd6Pe2DbGi1qkEOVy9iPYuy3NFt6C4dSIjMLVVeX2T0rzSeoKx+g==
X-Received: by 2002:a17:902:c946:b0:233:f3df:513d with SMTP id d9443c01a7336-23dd0d3474dmr6186135ad.35.1751914286618;
        Mon, 07 Jul 2025 11:51:26 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23dc3090346sm38472595ad.168.2025.07.07.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:51:26 -0700 (PDT)
Date: Mon, 7 Jul 2025 11:51:25 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Savy <savy@syst3mfailure.io>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [BUG]  Inconsistency between qlen and backlog in hhf, fq,
 fq_codel, and fq_pie causing WARNING in qdisc_tree_reduce_backlog
Message-ID: <aGwXLe8djsE0H3Ed@pop-os.localdomain>
References: <2UMzQV_2SQetYadgDKNRO76CgTlKBSMAHmsHeosdnhCPcOEwBB-6mSKXghTNSLudarAX4llpw70UI7Zqg2dyE06JGSHm04ZqNDDC5PUH1uo=@willsroot.io>
 <aGh6HiQmcgsPug1u@pop-os.localdomain>
 <X6Q8WFnkbyNTRaSQ07hgoBUIihJJdm7GIDvCCY0prplSeVDZPKXquiH2as4hPXAWn1J1a2tyP5RnBm8tjKWNM881yDlMlx0pMg9vioBRY1w=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6Q8WFnkbyNTRaSQ07hgoBUIihJJdm7GIDvCCY0prplSeVDZPKXquiH2as4hPXAWn1J1a2tyP5RnBm8tjKWNM881yDlMlx0pMg9vioBRY1w=@willsroot.io>

On Sun, Jul 06, 2025 at 01:43:08PM +0000, William Liu wrote:
> On Saturday, July 5th, 2025 at 1:04 AM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > 
> > 
> > On Wed, Jul 02, 2025 at 08:39:45PM +0000, William Liu wrote:
> > 
> > > Hi,
> > > 
> > > We write to report a bug in qlen and backlog consistency affecting hhf, fq, fq_codel, and fq_pie when acting as a child of tbf. The cause of this bug was introduced by the following fix last month designed to address a null dereference bug caused by gso segmentation and a temporary inconsistency in queue state when tbf peeks at its child while running out of tokens during tbf_dequeue [1]. We actually reported that bug but did not realize the subtle problem in the fix until now. We are aware of bugs with similar symptoms reported by Mingi [3] and Lion [4], but those are of a different root cause (at least what we can see of Mingi's report).
> > 
> > 
> > Thanks for your report.
> > 
> > > This works on the upstream kernel, and we have the following reproducer.
> > > 
> > > ./tc qdisc del dev lo root
> > > ./tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1ms || echo TBF
> > > ./tc qdisc add dev lo handle 3: parent 1:1 hhf limit 1000 || echo HH
> > > ping -I lo -f -c1 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
> > > ./tc qdisc change dev lo handle 3: parent 1:1 hhf limit 0 || echo HH
> > > ./tc qdisc replace dev lo handle 2: parent 1:1 sfq || echo SFQ
> > > 
> > > Note that a patched version of tc that supports 0 limits must be built. The symptom of the bug arises in the WARN_ON_ONCE check in qdisc_tree_reduce_backlog [2], where n is 0. You can replace hhf with fq, fq_codel, and fq_pie to trigger warnings as well, though the success rate may vary.
> > > 
> > > The root cause comes from the newly introduced function qdisc_dequeue_internal, which the change handler will trigger in the affected qdiscs [5]. When dequeuing from a non empty gso in this peek function, only qlen is decremented, and backlog is not considered. The gso insertion is triggered by qdisc_peek_dequeued, which tbf calls for these qdiscs when they are its child.
> > > 
> > > When replacing the qdisc, tbf_graft triggers, and qdisc_purge_queue triggers qdisc_tree_reduce_backlog with the inconsistent values, which one can observe by adding printk to the passed qlen backlog values.
> > 
> > 
> > If I understand you correctly, the problem is the inconsistent behavior
> > between qdisc_purge_queue() and qdisc_dequeue_internal()? And it is
> > because the former does not take care of ->gso_skb?
> > 
> 
> No, there are 2 points of inconsistent behavior. 
> 
> 1. qdisc_dequeue_internal and qdisc_peek_dequeued. In qdisc_peek_dequeued, when a skb comes from the dequeue handler, it gets added to the gso_skb with qlen and backlog increased. In qdisc_dequeue_internal, only qlen is decreased when removing from gso.
> 

Yes, because qlen is handled by qdisc_dequeue_internal()'s callers to
control their loop of sch->limit.


> 2. The dequeue limit loop in change handlers and qdisc_dequeue_internal. Every time those loops call qdisc_dequeue_internal, the loops track their own version of dropped items and total dropped packet sizes, before using those values for qdisc_tree_reduce_backlog. The hhf qdisc is an exception as it just uses a before and after loop in the limit change loop. Would this not lead to double counting in the gso_skb dequeue case for qdisc_dequeue_internal? 

Right, I think hhf qdisc should align with other Qdisc's to track the
qlen.

Note: my patch didn't change its behavior, so this issue existed even
before my patch.

> 
> Also, I took a look at some of the dequeue handlers (which qdisc_dequeue_internal call when direct is false), and fq_codel_dequeue touches the drop_count and drop_len statistics, which the limit adjustment loop also uses. 


Right, this is why it is hard to move the qlen tracking into
qdisc_dequeue_internal().

Thanks.

