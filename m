Return-Path: <netdev+bounces-92593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B77C18B7FC8
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426ED1F24D28
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEAC3611D;
	Tue, 30 Apr 2024 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aypWveYb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528123C9
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502143; cv=none; b=VbXGGZYMrMZcjN1Z/FdW9BVcnDUEm/IMHsyYLtq1V8fFNIQzXl9UMtYhaKXSmtV6kyXYUL3hctV+gsXD9pGinn//49N9dNgnM+0oswccsOshJqgmVaUJmOmc1c5ydZAU3wtHFz7iilBxvyKYpN5OJUdxfGun75oZL5dOPWIkBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502143; c=relaxed/simple;
	bh=3x86ooPYEPhO+GNwxl5FSXFYXhvPlw9jMbZ7IbKDiQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/xONwbHl5DpVyj+3UYPcdZu+6NbcCdCyMtMam1HGS7U/6LOk67EC+RZNZhqjImHkOn13neVzM958I3fNNC1nGzDvxCEBnBXIn42f2mKlZxjr1sZmrU88S6koJxmqSAQhuylolHsdeaeIjjlcOPmmJwGcu3pcxqiBdxaJBBOlaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aypWveYb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714502140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eK7pUN3oxyFxhG1H642LJoUHGfpZGwbiS1NhVgv97U=;
	b=aypWveYbgTYLSCpjl6eCXksXK3V9gqjLuuLTSQR0IHaL9LN9PMsEyjeMZ4reDL9jWWDfkJ
	tAX8GFjVKzOD7HMC67niZ7XrXCEjOJhHLrt7SLYAtXxyk5oCyo6o0gbbyvKRpGW99sWJ1y
	CAmz44Cn2gSzXAEMvvbxr9qygIcugE0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-_7MFEjUeMc-Eaw4x7dMbgg-1; Tue, 30 Apr 2024 14:35:36 -0400
X-MC-Unique: _7MFEjUeMc-Eaw4x7dMbgg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51701401bd4so4785643e87.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 11:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714502134; x=1715106934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eK7pUN3oxyFxhG1H642LJoUHGfpZGwbiS1NhVgv97U=;
        b=eIYQt00oLm0Iz8gsUuSdqfKH24n1PYYBph4zEvalJGF+BAJDUCD8L/5n1oaVIzel8u
         sTsP/rqavTN4pz1q++nZCyGjy8ngpExsxJCHtXeDccVwm7i2fvv1gOozZ+5d0m6em9KG
         T9/46VswiajaQBBH0Ra7BDgJ+J9BeqH50o36tsiZTt7v3POb6hgvJ2WgWaF+tcoBxpMD
         tBKeOlr0PoNTcA5iTwC8m8Fm9/GU20B+l+cllJmby8abPvnf4qRT72r60hQhDiiRRI3/
         mOaQbnu/wzgMX5QVp/meeYdQ89zUZsWZ827iQ9qpsina6Q0DMm2Je1Z4zzyqQd+qCf/J
         k7hA==
X-Forwarded-Encrypted: i=1; AJvYcCWVS8zfG6Fx78DzrM4BFwR1RtdGwR5JkNCh7oCoWVTfQXF0mlk0yE9DvnoTUuTFQ4NyFhb7liYPVGs3e6/+/nkxSZ/o5CL9
X-Gm-Message-State: AOJu0YzW6QTFlQRix7gwT0BegOGiWV3PS0TQBk7l81hSo7xE7tvH4t4T
	kcZvkgnJpB9rVbWxxd+a/J1N4ZnRXRfvHqPZ0UyqvvvJCqzaQUa2XM1dRMUfIlVpWS/1G0WwuLF
	jc9he31fuRjidb8CmbzxVl8n0UNEONCgiVqLS6gmau66OJHGL5wkHOq9z9tXgn/d9
X-Received: by 2002:a05:6512:114a:b0:519:2c84:2405 with SMTP id m10-20020a056512114a00b005192c842405mr225054lfg.44.1714502134126;
        Tue, 30 Apr 2024 11:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/0lt5+R3E+YXkAX6kq4EN758w/3jqzH3dPihvkGMyzlAc530szKkGYU4Jdx+qe3zStt1KNQ==
X-Received: by 2002:a05:6512:114a:b0:519:2c84:2405 with SMTP id m10-20020a056512114a00b005192c842405mr225023lfg.44.1714502133308;
        Tue, 30 Apr 2024 11:35:33 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id jx12-20020a05600c578c00b0041674bf7d4csm48960320wmb.48.2024.04.30.11.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 11:35:32 -0700 (PDT)
Date: Tue, 30 Apr 2024 20:35:31 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: unregister lockdep keys in
 qdisc_create/qdisc_alloc error path
Message-ID: <ZjE587MsVBZA61fJ@dcaratti.users.ipa.redhat.com>
References: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
 <CANn89iJJefUheeur5E=bziiqxjqmKXEk3NCO=8em4XVJThExMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJJefUheeur5E=bziiqxjqmKXEk3NCO=8em4XVJThExMQ@mail.gmail.com>

hi Eric, thanks for looking at this!

On Tue, Apr 30, 2024 at 07:58:14PM +0200, Eric Dumazet wrote:
> On Tue, Apr 30, 2024 at 7:11 PM Davide Caratti <dcaratti@redhat.com> wrote:
> >

[...]

> > @@ -1389,6 +1389,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
> >                 ops->destroy(sch);
> >         qdisc_put_stab(rtnl_dereference(sch->stab));
> >  err_out3:
> > +       lockdep_unregister_key(&sch->root_lock_key);
> >         netdev_put(dev, &sch->dev_tracker);
> >         qdisc_free(sch);
> >  err_out2:
> 
> For consistency with the other path, what about this instead ?
> 
> This would also  allow a qdisc goten from an rcu lookup to allow its
> spinlock to be acquired.
> (I am not saying this can happen, but who knows...)
> 
> Ie defer the  lockdep_unregister_key() right before the kfree()

the problem is, qdisc_free() is called also in a RCU callback. So, if we move
lockdep_unregister_key() inside the function, the non-error path is
going to splat like this:

 BUG: sleeping function called from invalid context at kernel/locking/lockdep.c:6450        
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/6                                       
 preempt_count: 101, expected: 0                                                                                 
 RCU nest depth: 0, expected: 0                                                                                                                                                                                                                 
 1 lock held by swapper/6/0:                                                                                     
  #0: ffffffff83e03000 (rcu_callback){....}-{0:0}, at: rcu_do_batch+0x1d6/0x630                                                                                                                                                                 
 Preemption disabled at:                                                                                                                                                                                                                        
 [<0000000000000000>] 0x0                                                                                                                                                                                                                       
 CPU: 6 PID: 0 Comm: swapper/6 Not tainted 6.9.0-rc2+ #655                                                                                                                                                                                      
 Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  07/26/2013                                                                                                                                                             
 Call Trace:                                                                                                     
  <IRQ>                                                                                                                                                                                                                                         
  dump_stack_lvl+0xa9/0xc0                                                                                                                                                                                                                      
  __might_resched+0x1a6/0x2b0                                                                                    
  ? rcu_do_batch+0x208/0x630                                                                                                                                                                                                                    
  lockdep_unregister_key+0x28/0x290                                                                                                                                                                                                             
  qdisc_free+0x1b/0x40                                                                                           
  rcu_do_batch+0x20d/0x630                                                                                                                                                                                                                      
  ? lockdep_hardirqs_on+0x78/0x100                                                                                                                                                                                                              
  rcu_core+0x305/0x570                                                                                                                                                                                                                          
  __do_softirq+0xcd/0x484                                                                                                                                                                                                                       
  irq_exit_rcu+0xc9/0x110                                                                                                                                                                                                                       
  sysvec_apic_timer_interrupt+0x9e/0xc0                                                                                                                                                                                                         
  </IRQ>                                                                                                                                                                                                                                        
  <TASK>                                                                                                                                                                                                                                        
  asm_sysvec_apic_timer_interrupt+0x16/0x20                                                                                                                                                                                                     
 RIP: 0010:cpuidle_enter_state+0x104/0x5e0                                                                                                                                                                                                      
 Code: 00 89 c0 48 0f a3 05 3b 3e 1e 01 0f 82 4f 03 00 00 31 ff e8 5e 9e 33 ff 45 84 ff 0f 85 ff 02 00 00 e8 60 4b 47 ff fb 45 85 f6 <0f> 88 24 02 00 00 49 63 d6 48 2b 2c 24 48 8d 04 52 48 8d 04 82 49                                        
 RSP: 0018:ffffbe4ec22e7e78 EFLAGS: 00000202                                                                                                                                                                                                    
 RAX: 000000000002ec55 RBX: 0000000000000004 RCX: 0000000000000000                                                                                                                                                                              
 RDX: 0000000000000000 RSI: ffffffff838d1436 RDI: ffffffff8385cace                                                                                                                                                                              
 RBP: 0000001486cedd9b R08: 0000000000000001 R09: 0000000000000001                                                                                                                                                                              
 R10: 00004d0a32102e4a R11: ffffffff83a0bb08 R12: ffffde4abd602710                                               
 R13: ffffffff83f66f20 R14: 0000000000000004 R15: 0000000000000000         


6442 void lockdep_unregister_key(struct lock_class_key *key)
6443 {
6444         struct hlist_head *hash_head = keyhashentry(key);
6445         struct lock_class_key *k;
6446         struct pending_free *pf;
6447         unsigned long flags;
6448         bool found = false;
6449 
6450         might_sleep();

... because of the above line. That's why in the normal path, the dynamic key is
unregistered before scheduling the RCU callback.

-- 
davide



