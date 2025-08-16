Return-Path: <netdev+bounces-214294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4E1B28C75
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 11:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7EF5C32C9
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AED9242D97;
	Sat, 16 Aug 2025 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyCl71GV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B167714A60C;
	Sat, 16 Aug 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755336811; cv=none; b=KRJ3Onshb5LPx9xqYYVSXHrKcAwYoESkky5S6qgzHaIQfiF2ENtWNDxC6r3aMkcY22HmlsFP4Gv2EPKJh8VIvoLukfqLi9s5BhS2aN0pT608gdBKzmshKth7SIcFhNtA2iImRmP9ZeaCceWJCUZsj5zii+07uSouSsxX8FWnmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755336811; c=relaxed/simple;
	bh=h8Pxd3f200CYSh4P4nWvjVf5VDOPmEEv+EAJ0L9mnlk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=l5/fmVNjYSg/ctgc6ExmLVXykSPwK2bUhjtYGt+IiOXTZH88ve9oZhqjlpo+cyaPZKqQi/EqZp+VanLmVIQkavVG1MdT5abztKl3lQtyWYcy0kFlfayCMemTE7USm2XvqFwRtray+KYv0lkqW4NemhVeW+pJPpcEGFwZ0c+dPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyCl71GV; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-89018fcdcd4so1544807241.1;
        Sat, 16 Aug 2025 02:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755336808; x=1755941608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WC6fm10gld8RBE2RgzmT0kGOCE9b+UemG0pezoqppA=;
        b=PyCl71GV+XfPUvpCqlh8okKqUYGnB53Hvv+DKX/v8cKSwwthZAHJGtkm5xvoPKBCob
         3PpSnyiAsNp+ps7HxLTQqS9Q09OhDKtZQOqiQMZmlyRue2U8QTtmwucBP/svuMxr1DDd
         9DFyl3amEP83tRlcCvwGt6mPGb72FLpq+ta4Os88hWbnSULz6HsfjOhQ1/B7jyJpS/Zn
         sSIi1TrOWL+MP+I7Gs6O0knFJg6B63n3mMbAMWkCE4TZ8db77mGo0lTWv2JonNv/snGN
         JWd5iCT4VZXbFWHoKSZbQR8BUoy9sHIu0vI2kRbaIPjK24sAYdmQ+sVXa9npZlCoceEf
         X+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755336808; x=1755941608;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8WC6fm10gld8RBE2RgzmT0kGOCE9b+UemG0pezoqppA=;
        b=pLjJIIUBJWuD2TKj8g9m5DrunLAq2clamPWjYB2vLu0OZdt1hyZI4SggPKX2mTZMfR
         1ynoTlFTSXfgEBqM+Mj7mkNr8xPv2wATOckqxUnAUqSoYVezHUEMCubAc9yyOh4eUSGg
         i1UGP+j06iywpNtDw4zz+AWEXXYpShLmNx7fJGXlnZirPA9rlOY2pxq58zpvRKFs4Hj0
         2QnUxkNpA2O1Grr2q0H66/6zAjSfp2g5yPQ0Q36Nl+bQHzWYjd8244fGVp65O/hZhnbc
         Joot5EJ4/DewobQkOzVIemqQj+ycjQ1AFbkJ4JTf1r+HC+yDk8xEucWQjNElAg8EDA+v
         ezuw==
X-Forwarded-Encrypted: i=1; AJvYcCUxLjo706Vn5jXJfSly2Z7hxTC5NPfErdBCh1GtYfSD45lrcCMqBQtk6fuortifRD6Elxg9Rixg@vger.kernel.org, AJvYcCWRVUL7kPpGA6ddVx55UtZuuZB0wjWAGaTRjCafjB4oYqt8Rxjl3c0Kp5GJWJR0Jlm9UwV/MzEzBD/n2YM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa8QQkTkgVsXAeBExj6nss4ORa6hbQfyCeMlG/Usjqgrm1pYrd
	6b1IhvjkCfsZ2bzL9HUBcgVfhC6FdT3XQXSGkYM9ZDnIK3YSmN3hheHh
X-Gm-Gg: ASbGncvUDnqoYfDPowOpE7STx2zHAT+8nA02XVtMRbn4WOPRhtw7+ULVg0NrhnP2W9Z
	neaMSl/Hp2c2IzoJj5q0iNwvUnBQNN0dY3iYhWdQF0yx4C7J8vL7OccfOm/GqaVtfbBFVAKinVr
	LoH/3QB8Wz3lN66MB+/ytJF/jv0gN6/YvqguzR+i8NVTK20vkAsfyzEir/QY9d4Fjh+TGNzcKou
	i/R38ZT2U0WNWfXAIxgTCfiFEI2AUE5zBVKFy7WZKjNTDxn3r6gBWvJdoQcq9A4cetGmsTmuCZu
	U/Z1u1foleomORVMz0EviVZrya6QJvTCtR6jfW4EFSCvmNmfOBcNf2ccPca9gGmcHZX03Fy3RA/
	UhXE3mqpn8fW8E/Y7r5UoUcJMWS92+P+qzDC5YArQj3TQhch+rLI7+azbBdNKeObseVFX9Q==
X-Google-Smtp-Source: AGHT+IG1uDiAYDpg/CyT9XmT5i0fJ+S+8+fiovzD5bYY/+648p74exjHgCcXPZ9iN71PsfpnGYjQlw==
X-Received: by 2002:a05:6102:38ca:b0:4e5:9c40:824d with SMTP id ada2fe7eead31-5126cd38593mr2166625137.16.1755336808372;
        Sat, 16 Aug 2025 02:33:28 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-5127f80546fsm728220137.14.2025.08.16.02.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 02:33:27 -0700 (PDT)
Date: Sat, 16 Aug 2025 05:33:26 -0400
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
Message-ID: <willemdebruijn.kernel.329bd64b377b9@gmail.com>
In-Reply-To: <20250815170825.3585310-1-jackzxcui1989@163.com>
References: <20250815170825.3585310-1-jackzxcui1989@163.com>
Subject: Re: [PATCH v2] net: af_packet: Use hrtimer to do the retire operation
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
> On Fri, 2025-08-15 at 18:12 +0800, Willem wrote:
> 
> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> 
> > Please clearly label PATCH net-next and include a changelog and link
> > to previous versions.
> > 
> > See also other recently sent patches and
> > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> > https://docs.kernel.org/process/submitting-patches.html
> > 
> > > ---
> 
> Dear Willem,
> 
> I will add the details in PATCH v3.
> 
> 
> > > -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> > 
> > Since the hrtimer API takes ktime, and there is no other user for
> > retire_blk_tov, remove that too and instead have interval_ktime.
> > 
> > >  	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
> 
> We cannot simply remove the retire_blk_tov field, because in net/packet/diag.c 
> retire_blk_tov is being used in function pdiag_put_ring. Since there are still
> people using it, I personally prefer not to remove this variable for now. If
> you think it is still necessary, I can remove it later and adjust the logic in
> diag.c accordingly, using ktime_to_ms to convert the ktime_t format value back
> to the u32 type needed in the pdiag_put_ring function.

Yes, let's remove the unnecessary extra field.
 
> 
> > > +	hrtimer_set_expires(&pkc->retire_blk_timer,
> > > +			    ktime_add(ktime_get(), ms_to_ktime(pkc->retire_blk_tov)));
> > 
> > More common for HRTIMER_RESTART timers is hrtimer_forward_now.
> > 
> > >  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
> 
> As I mentioned in my previous response, we cannot use hrtimer_forward_now here
> because the function _prb_refresh_rx_retire_blk_timer can be called not only
> when the retire timer expires, but also when the kernel logic for receiving
> network packets detects that a network packet has filled up a block and calls
> prb_open_block to use the next block. This can lead to a WARN_ON being triggered
> in hrtimer_forward_now when it checks if the timer has already been enqueued
> (WARN_ON(timer->state & HRTIMER_STATE_ENQUEUED)).
> I encountered this issue when I initially used hrtimer_forward_now. This is the
> reason why the existing logic for the regular timer uses mod_timer instead of
> add_timer, as mod_timer is designed to handle such scenarios. A relevant comment
> in the mod_timer implementation states:
>  * Note that if there are multiple unserialized concurrent users of the
>  * same timer, then mod_timer() is the only safe way to modify the timeout,
>  * since add_timer() cannot modify an already running timer.

Please add a comment above the call to hrtimer_set_expires and/or in
the commit message. As this is non-obvious and someone may easily
later miss that and update.

So mod_timer can also work as add_timer.

But for hrtimer, is it safe for an hrtimer_setup call to run while a
timer is already queued? And same for hrtimer_start.

> 
> > > +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
> > >  {
> > >  	struct packet_sock *po =
> > >  		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
> > > @@ -790,6 +790,7 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
> > > 
> > >  out:
> > >  	spin_unlock(&po->sk.sk_receive_queue.lock);
> > > +	return HRTIMER_RESTART;
> > 
> > This always restart the timer. But that is not the current behavior.
> > Per prb_retire_rx_blk_timer_expired:
> > 
> >    * 1) We refresh the timer only when we open a block.
> > 
> > Look at the five different paths that can reach label out.
> > 
> > In particular, if the block is retired in this timer, and no new block
> > is available to be opened, no timer should be armed.
> > 
> > >  }
> 
> I have sorted out the logic in this area; please take a look and see if it's correct.
> 
> We are discussing the conditions under which we should return HRTIMER_NORESTART. We only
> need to focus on the three 'goto out' statements in this function (because if it don't
> call 'goto out', it will definitely not skip the 'refresh_timer:' label, and if it don't
> skip the refresh_timer label, it will definitely execute the _prb_refresh_rx_retire_blk_timer
> function, which expects to return HRTIMER_RESTART):
> Case 1:
>   if (unlikely(pkc->delete_blk_timer))
>     goto out;
>   This case indicates that the hrtimer has already been stopped. In this situation, it 
>   should return HRTIMER_NORESTART, and I will make this change in PATCH v3.
> Case 2:
>   if (!prb_dispatch_next_block(pkc, po))
>     goto refresh_timer;
>   else
>     goto out;
>   In this case, the execution will only reach the out label if prb_dispatch_next_block
>   returns a non-zero value. If prb_dispatch_next_block returns a non-zero value, it must
>   have executed prb_open_block, which in turn will call _prb_refresh_rx_retire_blk_timer
>   to set the new timeout for the retire timer. Therefore, in this scenario, the hrtimer
>   should return HRTIMER_RESTART.

Above I am talking about this case, where the hrtimer is reinitialized
and started in _prb_refresh_rx_retire_blk_timer and after that also
restarts itself with HRTIMER_RESTART.

> Case 3:
>   } else {
>      ...
>      prb_open_block(pkc, pbd);
>      goto out;
>   }
>   This goto out clearly follows a call to prb_open_block, and as mentioned in the case 2,
>   it will set a new timeout and expects the hrtimer to restart.
> Based on the analysis above, I only need to modify the situation described in case 1 in
> PATCH v3 to return HRTIMER_NORESTART. If there are any inaccuracies, please provide
> further guidance.
> 
> 
> Thanks
> Xin Zhao
> 



