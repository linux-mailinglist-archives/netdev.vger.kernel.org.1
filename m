Return-Path: <netdev+bounces-205959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89EB00EDB
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAB25C310B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BDF2D3A60;
	Thu, 10 Jul 2025 22:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FATok1j4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AADF2D0C6C
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187246; cv=none; b=fZzVzkEiusHftO4cmO9fQ1Bj7blZofdj2c9DEKZq+oFRX4EEvNepyjt9pFJ+xFvLp9zkPmNKY3JRUhvQKphxwbdD0W6UK6/FNLsRWhWvBfABs/vYPTaKbMbLtDS7blQ5E5q+SK3crvNo7hCjQxQja4Lz7O70OWVrrm/G5tfzH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187246; c=relaxed/simple;
	bh=4BsebS/yna141CM31Res1Jur1fq9obPmgO60ewPeD/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuCNcaU1XIJIrI4tY6grgt8TdUGcFTLGhStm0JTNqPpoh8uyiTLQxoeW5Z1/OJreuPHiOvu4xvsTMJ9+kwka/Enl+fDqqQheysKdzznTHktqALdHYfDPvgKsAKmzycSeSKdsfrZLZTl9xgYqJMEqOG97cDtUf/jag5U6Y7XKfIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FATok1j4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235a3dd4f0dso10511265ad.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752187243; x=1752792043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=80bncprfO0hmAZjadslQIkNGnTxUqM0IDxa4QNJdqsM=;
        b=FATok1j4zz2aLRf0R0zKq/p4xTDEBZc5euMQwOtDifBywJkCPezvR/uTWEHm4zCkit
         JcNr3MPXe3+ikVdAlFvMbvWY6JSVeS8Baa4cpTbS4k4XE9vJ1aUspHtlp+oCbWNJg+XG
         r09Zg1Ua3FRmxydECgSY7XJvxtsnAzmmKRZKmgihLJBiAeays5ZT59znyatvGixZcoxK
         dji1Cy8gucro+E3c/VaPu+goUpkzZmOJ9vwUOSnSep2UzWtbnyPZX/QboB43+5p3fJJ5
         GCC0u+/oj9HoiXy7pMczOlmW88lS7cJ7DcJwp0EVMjzCMpg42AH3DPnfbQdxg/D70P0k
         2ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187243; x=1752792043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80bncprfO0hmAZjadslQIkNGnTxUqM0IDxa4QNJdqsM=;
        b=wBnJ9oKLBaIa6nkAuYOA5LQIpw6mJ1EZQ/9ISwOxF4OnG36AvCPtvNB4wJSUztsrrq
         2cmEYuVY+1Jll+iGMQ8+mNyDSjYhirkJBfO75nZvBzmwRUZh0MBgh9GMVji+Jj+96dK6
         C1722LHtUMVObSiX8/14Y9+Lhm99QKuiUOR5NMiBNnO3bvzDhrpU0x6w11H1XWXEsP+I
         wDPb5ExF+tcv0wkc8Vt0fl9XZUxZdimPDX/8YIPTlimoYF105SBEElMrBaRfH76jE1Ud
         jKZAoGMRKkKoDkYHdkcHd0nKYRmPxOgUaz+tGH6QwXiYQ4mQzDRktpp9Vzg39X5dYtlp
         QpEw==
X-Gm-Message-State: AOJu0YxSN7KNHiMNHx2dv0Rp+LGs2keL2+KpoVOToIFIuY3qAXhcODLU
	5jWsBcyuzJLRPaFFiM9X0cOlj/CkpCUv87yKTFhes+vmPe/Tl4izCOmm
X-Gm-Gg: ASbGncs39CxefJhxh66zGjHbmyBcOTzbhwBNvFk5Gv+ha6LaWKgEfv1Pi3uxWToChMW
	gVa2KPe3G1Uu92HRRXUr52uXF8KGPOUrTCXyuP+mb7OhEIqLyNE1M+6G9I5ehR6hH3FlcmwuW8i
	WVZ/5i0HDgRUgbSrJ/d36zvxTDcKpEu8ZGA0BIFHJ2zuf+yNiv0dmUXRvl/9Al6u1FhHi81f2wN
	obrXwsvu5U9ETcaBqkNia3TUXjvtwY+LytCMxf2ITaG6G9Kgt2d4g4nNlFnI5YC2u/2mXoShfBr
	lWLWyydzCJVAgsP1myjPS9S1sc4XzpygvK7YnenF69f2aExKVndnJ0VEZSJXhVmZ7EnYmWYny2w
	XXTYuFVysDdCEWgoHYc1FYX67GA==
X-Google-Smtp-Source: AGHT+IFxkWSZxQIF3cNFSH22pYg5gs9V8YK74wDqOyl8v1+GokfxA/yg6rpi/74XyIWuukmzBVQDXg==
X-Received: by 2002:a17:902:d505:b0:236:8df7:b30a with SMTP id d9443c01a7336-23dede2d305mr15356075ad.1.1752187243397;
        Thu, 10 Jul 2025 15:40:43 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4334005sm30201855ad.158.2025.07.10.15.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:40:42 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:40:41 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Savy <savy@syst3mfailure.io>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [BUG]  Inconsistency between qlen and backlog in hhf, fq,
 fq_codel, and fq_pie causing WARNING in qdisc_tree_reduce_backlog
Message-ID: <aHBBaXPPQvBCejoM@pop-os.localdomain>
References: <2UMzQV_2SQetYadgDKNRO76CgTlKBSMAHmsHeosdnhCPcOEwBB-6mSKXghTNSLudarAX4llpw70UI7Zqg2dyE06JGSHm04ZqNDDC5PUH1uo=@willsroot.io>
 <aGh6HiQmcgsPug1u@pop-os.localdomain>
 <X6Q8WFnkbyNTRaSQ07hgoBUIihJJdm7GIDvCCY0prplSeVDZPKXquiH2as4hPXAWn1J1a2tyP5RnBm8tjKWNM881yDlMlx0pMg9vioBRY1w=@willsroot.io>
 <aGwXLe8djsE0H3Ed@pop-os.localdomain>
 <rt_47kiO_w5I_HyL1B4RuHKclPjWvmSJqnlZwSZB5YKxStxbDAsb7lTae0yhrRLJkh9yb7JjV-LpU_xzNCd031YI23Z4Yy83u8-DgYuPsEI=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rt_47kiO_w5I_HyL1B4RuHKclPjWvmSJqnlZwSZB5YKxStxbDAsb7lTae0yhrRLJkh9yb7JjV-LpU_xzNCd031YI23Z4Yy83u8-DgYuPsEI=@willsroot.io>

On Tue, Jul 08, 2025 at 08:21:31PM +0000, William Liu wrote:
> On Monday, July 7th, 2025 at 6:51 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > 
> > 
> > On Sun, Jul 06, 2025 at 01:43:08PM +0000, William Liu wrote:
> > 
> > > On Saturday, July 5th, 2025 at 1:04 AM, Cong Wang xiyou.wangcong@gmail.com wrote:
> > > 
> > > > On Wed, Jul 02, 2025 at 08:39:45PM +0000, William Liu wrote:
> > > > 
> > > > > Hi,
> > > > > 
> > > > > We write to report a bug in qlen and backlog consistency affecting hhf, fq, fq_codel, and fq_pie when acting as a child of tbf. The cause of this bug was introduced by the following fix last month designed to address a null dereference bug caused by gso segmentation and a temporary inconsistency in queue state when tbf peeks at its child while running out of tokens during tbf_dequeue [1]. We actually reported that bug but did not realize the subtle problem in the fix until now. We are aware of bugs with similar symptoms reported by Mingi [3] and Lion [4], but those are of a different root cause (at least what we can see of Mingi's report).
> > > > 
> > > > Thanks for your report.
> > > > 
> > > > > This works on the upstream kernel, and we have the following reproducer.
> > > > > 
> > > > > ./tc qdisc del dev lo root
> > > > > ./tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1ms || echo TBF
> > > > > ./tc qdisc add dev lo handle 3: parent 1:1 hhf limit 1000 || echo HH
> > > > > ping -I lo -f -c1 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
> > > > > ./tc qdisc change dev lo handle 3: parent 1:1 hhf limit 0 || echo HH
> > > > > ./tc qdisc replace dev lo handle 2: parent 1:1 sfq || echo SFQ
> > > > > 
> > > > > Note that a patched version of tc that supports 0 limits must be built. The symptom of the bug arises in the WARN_ON_ONCE check in qdisc_tree_reduce_backlog [2], where n is 0. You can replace hhf with fq, fq_codel, and fq_pie to trigger warnings as well, though the success rate may vary.
> > > > > 
> > > > > The root cause comes from the newly introduced function qdisc_dequeue_internal, which the change handler will trigger in the affected qdiscs [5]. When dequeuing from a non empty gso in this peek function, only qlen is decremented, and backlog is not considered. The gso insertion is triggered by qdisc_peek_dequeued, which tbf calls for these qdiscs when they are its child.
> > > > > 
> > > > > When replacing the qdisc, tbf_graft triggers, and qdisc_purge_queue triggers qdisc_tree_reduce_backlog with the inconsistent values, which one can observe by adding printk to the passed qlen backlog values.
> > > > 
> > > > If I understand you correctly, the problem is the inconsistent behavior
> > > > between qdisc_purge_queue() and qdisc_dequeue_internal()? And it is
> > > > because the former does not take care of ->gso_skb?
> > > 
> > > No, there are 2 points of inconsistent behavior.
> > > 
> > > 1. qdisc_dequeue_internal and qdisc_peek_dequeued. In qdisc_peek_dequeued, when a skb comes from the dequeue handler, it gets added to the gso_skb with qlen and backlog increased. In qdisc_dequeue_internal, only qlen is decreased when removing from gso.
> > 
> > 
> > Yes, because qlen is handled by qdisc_dequeue_internal()'s callers to
> > control their loop of sch->limit.
> > 
> 
> This makes sense. However, if backlog is not adjusted in that helper, then they would go out of sync. qdisc_tree_reduce_backlog only adjusts counters for parent/ancestral qdiscs. 

Oh, you mean some callers miss qdisc_qstats_backlog_dec()? If you can
confirm this is an issue and adding it could solve it, please go ahead
to send out a patch. It makes sense to me so far, at least for aligning
with other callers.

> 
> This should help elucidate the problem:
> export TARGET=hhf
> ./tc qdisc del dev lo root
> ./tc qdisc add dev lo root handle 1: tbf rate 8bit burst 100b latency 1ms || echo TBF
> ./tc qdisc replace dev lo handle 3: parent 1:1 $TARGET limit 1000 || echo HH
> echo ''; echo 'add child'; tc -s -d qdisc show dev lo
> ping -I lo -f -c1 -s32 -W0.001 127.0.0.1 2>&1 >/dev/null
> echo ''; echo 'after ping'; tc -s -d qdisc show dev lo
> ./tc qdisc change dev lo handle 3: parent 1:1 $TARGET limit 0 || echo HH
> echo ''; echo 'after limit drop'; tc -s -d qdisc show dev lo
> ./tc qdisc replace dev lo handle 2: parent 1:1 sfq || echo SFQ
> echo ''; echo 'post graft'; tc -s -d qdisc show dev lo
> 
> Perhaps the original WARNING in qdisc_tree_reduce_backlog (which Lion's patch removed) regarding an inconsistent backlog was not a real problem then? But this backlog adjustment can be accounted for pretty easily I think. Let me know if I can help with this.

I think Lion's patch fixes a completely different issue? At least I
don't immediately connect it with this sch->limit issue.

> 
> On another note, asides from hhf (because the backlog value to qdisc_tree_reduce_backlog is 0 due to its different limit change loop), the other qdiscs cause an underflow in the backlog of tbf by the final graft.
> 

Does adding qdisc_qstats_backlog_dec() solve this too?

Thanks.

