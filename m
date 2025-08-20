Return-Path: <netdev+bounces-215213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776EB2DAB5
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7DE1C47108
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C822836AF;
	Wed, 20 Aug 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlUDij/K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7D2153EA;
	Wed, 20 Aug 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688626; cv=none; b=hQGsf1XEXDWSEIpReCNS2I7L4LMhlLCQ1GDAbzPRJl/RQPrfJ6fbb4KvClfVvONDvCf74uTwDuJVqlDcERkJt8uD1CMuThEfFlK0SAm4GG8hl3WFOX2V/OojQXu0yVWJ2k+JGvKOtL+aimKoRJ8PHDuYybhFWT6ygoeRk+jz1cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688626; c=relaxed/simple;
	bh=OtQzCNcg827yKF1AZRHjHdNrIDUyBLx2+HLvYXYZWdk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VNxpufLGmfGAjqmljLwHoeFP9eKGjokcC6xnBPbvuI+p28CZp7oj1bwpU3HSTHM/+vGOKcmyn75ZeGrldMDNIVIzdnobXgY+b1FFCt4gsYcjkTvwo1lM7xliN11zC9lN7n+/apJEbYOWNIJzX3IRzhdXZQ9nsZxBNu7XoKXPWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlUDij/K; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e87067b15aso751501085a.3;
        Wed, 20 Aug 2025 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755688623; x=1756293423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNEGZw2y8apXm4uq52cCtCGx6Q4fZehAG68JnZ4REmI=;
        b=ZlUDij/KY8ZPEltLOANc/K4X5Z27hhEh8s/ysLWd0ilPlsDJUHWTZdhTSwhptLo8bl
         lrfrPsL5luhQilez4xQr1xGxP5MJ+Qd8HrC6V0TG/p7UMwY210kedalz0D4ILDNizxwt
         r+xrRv+zl+meimr7ThlCG7oNC8zNrhaAUKgSO7/6+VGJtfTXVQrG+oas+iAyfXUdpEXJ
         S+6R6zFdd0kTg2qzFyZsgUB2bvRt4llEjQfw5nAo1fXOCbSZG8swm2+NoV0IbnGwD6OH
         ipbI7NfzfgboJydzesqfSwdvgcMCX/OClJDWGf9jGn1RA0EYO54M4qWjRjtKsVJVYGOQ
         5kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688623; x=1756293423;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rNEGZw2y8apXm4uq52cCtCGx6Q4fZehAG68JnZ4REmI=;
        b=nuUEWu+jg8QHZmrmdcQSf2iBIUthRSqfoE0837DaxVkM2BllLKw7Px5j/d0ut6BrQr
         +Y+GOHm9Ad850puIaI4lL0PJ2YECcK3/lgvcxyyAneif641Ca3a/xWbTaeGnW1Ze4V+C
         6kKhcv4l0wiytMtXEK3QT8x27LjMmv9wAZ/D7+8APxYsblKip1tm8PgwAD8UloL4PUbr
         plLm8c1+tZzXhslml9WVkjvuROJR8mIhO4HXF1OPBmGEMwchn4Yo4SgZ6gBxK8s4rNph
         dSsdAZ0h1FiqMJjBD7EtYv8lL5RFD+lc4NGdhwsJMSqMbE3awF6ttwzgTB4za2PO3YqH
         8yOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQceLxy4oL2pMXjBKcoSSQuz4gLm5YMeivtdhmAer3leenKVVb0u4Ul4EsY3xhhG0lBsZr/nXxYkGa+KY=@vger.kernel.org, AJvYcCVimcfC4r4m4woUFHGTmt388uiHf3vpvZYRWvTgWukFHfecObUIieYXia0ISnitYMS829JhbVWp@vger.kernel.org
X-Gm-Message-State: AOJu0Yze3lZQGC50Qvoyy8jGVAUQPGlqoIxuTDmPkbuoLc3wdJMZM9fs
	RnSuEz+vmrlKvPs7irIIkMVQYh5FBD6DmiN1DQCzhT1Cy1zOQNNPM6nM
X-Gm-Gg: ASbGncsVAkGO5V6n9bobuGFBXvDjf7m9ZP33IT0Tz+OWYHUiO+5R3UV0ZZu/+ulPEKA
	HEHIbrO5rafuTo2YJhJ9C3HYwg1C0jNrmFrtAIcofaOENHftoOAB/QgdgidVY94aYBPbNrH2n8e
	XCq0gCmrBkPvOFMOf3wJYWcLFf0ZSJqigGg9d5hZo3S7YaJYiGU4CyGyxIIzNeLYu/ZvrldrY9L
	CIw1OL/0dbB1inSs+g1de2oRGGDJOhGomojcTzVApxnXOGafWdIxVtf/LkWwHWhyCR5zgmCO//V
	zHNvIqrCadkNvDKDFL8eJBJQ/TRNF8cSJxL7R4uOdS+SOMT1w+L+2YJBAOcgqS+j8QpqBDNYcXx
	Ui3xw+5wn1lYFa+2/K4SmIDnvAXFsMzWdluHPNQv5U8qT3ovQbWqxYaNST7yiNrnY1rnGRg==
X-Google-Smtp-Source: AGHT+IHjyyRgQLmlOx9za8Eph26gHmfEwR25z915Rl8D5Zzlq8HGc1E8iUboqZ4NL+Eo2rlLAnjcpA==
X-Received: by 2002:a05:620a:4607:b0:7e9:f820:2b83 with SMTP id af79cd13be357-7e9fcb6c355mr275475385a.68.1755688623016;
        Wed, 20 Aug 2025 04:17:03 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70ba9300f0asm85023846d6.36.2025.08.20.04.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:17:02 -0700 (PDT)
Date: Wed, 20 Aug 2025 07:17:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.795154e3cfd@gmail.com>
In-Reply-To: <20250820071914.2029093-1-jackzxcui1989@163.com>
References: <20250820071914.2029093-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v4] net: af_packet: Use hrtimer to do the retire
 operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> On Tue, 2025-08-19 at 22:18 +0800, Willem wrote:
> 
> > > -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> > > +static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc,
> > > +					     bool start, bool callback)
> > >  {
> > > -	mod_timer(&pkc->retire_blk_timer,
> > > -			jiffies + pkc->tov_in_jiffies);
> > > +	unsigned long flags;
> > > +
> > > +	local_irq_save(flags);
> > 
> > The two environments that can race are the timer callback running in
> > softirq context or the open_block from tpacket_rcv in process context.
> > 
> > So worst case the process context path needs to disable bh?
> > 
> > As you pointed out, the accesses to the hrtimer fields are already
> > protected, by the caller holding sk.sk_receive_queue.lock.
> > 
> > So it should be sufficient to just test hrtimer_is_queued inside that
> > critical section before calling hrtimer_start?
> > 
> > Side-note: tpacket_rcv calls spin_lock, not spin_lock_bh. But if the
> > same lock can also be taken in softirq context, the process context
> > caller should use the _bh variant. This is not new with your patch.
> > Classical timers also run in softirq context. I may be overlooking
> > something, will need to take a closer look at that.
> > 
> > In any case, I don't think local_irq_save is needed. 
> 
> Indeed, there is no need to use local_irq_save. The use case I referenced from
> perf_mux_hrtimer_restart is different from ours. Our timer callback does not run in
> hard interrupt context, so it is unnecessary to use local_irq_save. I will make this
> change in PATCH v6.
> 
> 
> 
> On Wed, 2025-08-20 at 4:21 +0800, Willem wrote:
>  
> > > So worst case the process context path needs to disable bh?
> > > 
> > > As you pointed out, the accesses to the hrtimer fields are already
> > > protected, by the caller holding sk.sk_receive_queue.lock.
> > > 
> > > So it should be sufficient to just test hrtimer_is_queued inside that
> > > critical section before calling hrtimer_start?
> > > 
> > > Side-note: tpacket_rcv calls spin_lock, not spin_lock_bh. But if the
> > > same lock can also be taken in softirq context, the process context
> > > caller should use the _bh variant. This is not new with your patch.
> > > Classical timers also run in softirq context. I may be overlooking
> > > something, will need to take a closer look at that.
> > > 
> > > In any case, I don't think local_irq_save is needed. 
> > 
> > 
> > 
> > 
> > I meant prb_open_block
> > 
> > tpacket_rcv runs in softirq context (from __netif_receive_skb_core)
> > or with bottom halves disabled (from __dev_queue_xmit, or if rx uses
> > napi_threaded).
> > 
> > That is likely why the spin_lock_bh variant is not explicitly needed.
> 
> Before I saw your reply, I was almost considering replacing spin_lock with
> spin_lock_bh in our project before calling packet_current_rx_frame in
> tpacket_rcv. I just couldn't understand why we haven't encountered any
> deadlocks or RCU issues due to not properly adding _bh in our project until
> I saw your reply.
> I truly admire your ability to identify all the scenarios that use the
> tpacket_rcv function in such a short amount of time. For me, finding all the
> instances where tpacket_rcv is assigned to prot_hook.func for proxy calls is
> a painful and lengthy task. Even if I manage to find them, I would still
> worry about missing some.

Thanks. I also reasoned backwards. If there had been a problem,
lockdep would have reported it long ago.

