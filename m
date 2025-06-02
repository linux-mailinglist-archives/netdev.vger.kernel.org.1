Return-Path: <netdev+bounces-194624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB9ACB904
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B99A206E4
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489A1221D94;
	Mon,  2 Jun 2025 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWcnciwd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8C2147E7;
	Mon,  2 Jun 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878136; cv=none; b=s14DYwiIBNJPIj6KT/6ImYN2JAR/PbeG9kh2EqPGNcQQbtx15R/swehjlgXwXdMcKZKw9rJZWUGw9OFmFUtN9ng/LrDxXbuRcLkIbDR8BjY/HTqdAoVgwrMCh+vZ0s5fQLFLVGg9hZBabI4ciqTMnIUqMmIZeTL7+UtuHIiv2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878136; c=relaxed/simple;
	bh=q7taHoVa4l9CtYy0iL1W3iWM2TGP0kNDiwb+YddXSU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awYOcAW6OsaQvHRx8CbfRTIyBE4hcC6sAc8MO3lnhJtlH6NjLCt+uphEgk2ESd64z7j+dVuX0SiU+2EpXyeKMYD0lvB03DZEtBZ8MpFfAuEwm6rkrIHkqGYPBtgF+3MtOTa9rRfIM3tQWEAmiaKGbKQUoj9zzmQNe59BpteAhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWcnciwd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2320d06b728so39129595ad.1;
        Mon, 02 Jun 2025 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748878133; x=1749482933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyhX9NbOq4eJXC2EVLcgaYIkPqpwZjDZzsRo8RbCXJA=;
        b=AWcnciwddubNgC2JBeddQS5ngjpT085uVCweVx/u+igFGbz/7p7DEVqy/lK5Hn/rQH
         iXd9gI5Y1f9nlGd8ozYr7do9gVtYXATHu1P82onTd0T8NY6Ev30qTblRJQ+tB8LESmNg
         693UbcWVx52Sj/ufDkw0v6ljrNePAxnTiJ7r0Q7o8RJ8IkO3SmKZ7ZwY2Ja2Ga+nJmZz
         UsgdGWvqBFtYkWuNGp6r2cPsee/8iUkOSQtCwBVari/yx0C2y3wfKAri1m6/lvt/Mq4n
         DCBSPRGe3adlRvzufJB25e3aPZYS0JvZRXZURq1w/H/AArShdMAzAuQ25eiQ/nhQaAlj
         Xh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748878133; x=1749482933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyhX9NbOq4eJXC2EVLcgaYIkPqpwZjDZzsRo8RbCXJA=;
        b=eMNnVMOCKNjSIc94/aazBy0RI902LV/J72Aw3Gv5DNDmruvlKH4COQ3RMp4G6maA0m
         Ko3FEZjNPUSij3UhyYkAGd+umiMyRgLxzptlLcbeDoA+HPIXyY1LGMXhwXPeqLwCWDx4
         Ifj0k420tCLwD7l1Im9sNLFr7hkB7mbK/MEZVqn9u+Jp4LgpBP1YCjmaIle6RN3Eg3Mf
         4aXUNwNV3yak/hHnMH+tJImDm8OUd8QidZz3q9JW1A/qmmXTk08SExRLh7RBgE2/PwF/
         e6J4yfzyMNVwKCHYzGrEB/DnDdNhCrq+k0SNpIwbXSe8UxBgzihsHz4rBxpgn7YWjriY
         YhxA==
X-Forwarded-Encrypted: i=1; AJvYcCXx6L2WZbKmCzm3aZK8MS0ou3KRdJeL1rsF9MCtEoa5Q+5x1DmpLqktaUAs9POj4K3uW33bysLW1efi3oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi68CBMoGZkEfvS7mTJszInWEZkDJ0GZFynjle2Bi+ze/xzzwR
	OFZ78U9GWB9eAYKCDadMBDoqFL7Esvj/m6vkX+NeQYpbr7T919ouG94=
X-Gm-Gg: ASbGncucQtigHiOi/kpZw1T+7cbvWc2Q/6+peLG95eWVjEHpnVZoqglWwUPPP4lmxaF
	Cfu/az0RAeDQi1Tn1WIpwu7UY5yeDn41Qoog29/bCcBNGeNhsg7lZe8XzljxC/YHUlo/2AVXR1j
	c4rIfR/5Cj11ukJ0v2UDOe5TBtvW5dSkQte7v3z/O+aJ280YO5rhAGys2js1x6ym7wWtG+e9rv7
	+IT1HA9shK/lF0xWOI278bFeaZHMwUURmbH23rSxhdeMdY05Q/9yPXadGvTkSPLefQanoWstW8F
	Xuizg9XR1uVCqC4Ug05GX5/uTBpAt2riY0MQvskXEvwsj3Xcbc5x0aqMInDavBUHueiJIX+60LG
	Tdywr20atvPRm
X-Google-Smtp-Source: AGHT+IHjmv4fbhsnSYHt4UCLZ9DUWSV8QGFrP+17mDHqMDKXfBlG0avCCHv2PMgw7MoEJx6bbOjGew==
X-Received: by 2002:a17:902:ea0d:b0:234:914b:3841 with SMTP id d9443c01a7336-23529a17ffamr199212775ad.39.1748878132820;
        Mon, 02 Jun 2025 08:28:52 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2eceb36961sm5702278a12.43.2025.06.02.08.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 08:28:52 -0700 (PDT)
Date: Mon, 2 Jun 2025 08:28:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eryk Kubanski <e.kubanski@partner.samsung.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>,
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>
Subject: Re: Re: [PATCH bpf v2] xsk: Fix out of order segment free in
 __xsk_generic_xmit()
Message-ID: <aD3DM4elo_Xt82LE@mini-arch>
References: <aDnX3FVPZ3AIZDGg@mini-arch>
 <20250530103456.53564-1-e.kubanski@partner.samsung.com>
 <CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p1>
 <20250602092754eucms1p1b99e467d1483531491c5b43b23495e14@eucms1p1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250602092754eucms1p1b99e467d1483531491c5b43b23495e14@eucms1p1>

On 06/02, Eryk Kubanski wrote:
> > I'm not sure I understand what's the issue here. If you're using the
> > same XSK from different CPUs, you should take care of the ordering
> > yourself on the userspace side?
> 
> It's not a problem with user-space Completion Queue READER side.
> Im talking exclusively about kernel-space Completion Queue WRITE side.
> 
> This problem can occur when multiple sockets are bound to the same
> umem, device, queue id. In this situation Completion Queue is shared.
> This means it can be accessed by multiple threads on kernel-side.
> Any use is indeed protected by spinlock, however any write sequence
> (Acquire write slot as writer, write to slot, submit write slot to reader)
> isn't atomic in any way and it's possible to submit not-yet-sent packet
> descriptors back to user-space as TX completed.
> 
> Up untill now, all write-back operations had two phases, each phase
> locks the spinlock and unlocks it:
> 1) Acquire slot + Write descriptor (increase cached-writer by N + write values)
> 2) Submit slot to the reader (increase writer by N)
> 
> Slot submission was solely based on the timing. Let's consider situation,
> where two different threads issue a syscall for two different AF_XDP sockets
> that are bound to the same umem, dev, queue-id.
> 
> AF_XDP setup:
>                                                             
>                              kernel-space                   
>                                                             
>            Write   Read                                     
>             +--+   +--+                                     
>             |  |   |  |                                     
>             |  |   |  |                                     
>             |  |   |  |                                     
>  Completion |  |   |  | Fill                                
>  Queue      |  |   |  | Queue                               
>             |  |   |  |                                     
>             |  |   |  |                                     
>             |  |   |  |                                     
>             |  |   |  |                                     
>             +--+   +--+                                     
>             Read   Write                                    
>                              user-space                     
>                                                             
>                                                             
>    +--------+         +--------+                            
>    | AF_XDP |         | AF_XDP |                            
>    +--------+         +--------+                            
>                                                             
>                                                             
>                                                             
>                                                             
> 
> Possible out-of-order scenario:
>                                                                                                                                        
>                                                                                                                                        
>                               writer         cached_writer1                      cached_writer2                                        
>                                  |                 |                                   |                                               
>                                  |                 |                                   |                                               
>                                  |                 |                                   |                                               
>                                  |                 |                                   |                                               
>                   +--------------|--------|--------|--------|--------|--------|--------|----------------------------------------------+
>                   |              |        |        |        |        |        |        |                                              |
>  Completion Queue |              |        |        |        |        |        |        |                                              |
>                   |              |        |        |        |        |        |        |                                              |
>                   +--------------|--------|--------|--------|--------|--------|--------|----------------------------------------------+
>                                  |                 |                                   |                                               
>                                  |                 |                                   |                                               
>                                  |-----------------|                                   |                                               
>                                   A) T1 syscall    |                                   |                                               
>                                   writes 2         |                                   |                                               
>                                   descriptors      |-----------------------------------|                                               
>                                                     B) T2 syscall writes 4 descriptors                                                 
>                                                                                                                                        
>                                                                                                                                        
>                                                                                                                                        
>                                                                                                                                        
>                  Notes:                                                                                                                
>                  1) T1 and T2 AF_XDP sockets are two different sockets,                                                                
>                     __xsk_generic_xmit will obtain two different mutexes.                                                              
>                  2) T1 and T2 can be executed simultaneously, there is no                                                              
>                     critical section whatsoever between them.                                                                          

XSK represents a single queue and each queue is single producer single
consumer. The fact that you can dup a socket and call sendmsg from
different threads/processes does not lift that restriction. I think
if you add synchronization on the userspace (lock(); sendmsg();
unlock();), that should help, right?

