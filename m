Return-Path: <netdev+bounces-216549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994EFB34709
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B6D7A32CE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12882FDC27;
	Mon, 25 Aug 2025 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtcZn9AX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01810271A9D;
	Mon, 25 Aug 2025 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138822; cv=none; b=QjfK4rRGIO5ZjCokN2I+dXDSitY4H8VzOmSoJbI4ncAP+1Y513xly2Si8vVgsZXCAoy10r4dy64sgpcSz0aXFQukwFgDfuk2MA23VijtKDvcJLPi8iS8gQMy1Lgq3xdrT0rQZHh0o08Bal5xgZgUptgFltHkKTSv3YQd6tFI4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138822; c=relaxed/simple;
	bh=TAcfmgI9LeesTtIHoLhIZ/JHO7GaVWax2M9oNJmKprQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=U8lrQM/0Koj2sytD/j+O64JwmXqKLr80LdGsAWigtAixeUv9W//WJDbxTyYH32Uufvm1pMNydLSFq1vh8AWCtjnvqfE9z2zdZg+phyQgxAtcDWvCaUzYizjD4O0XRaa+6Rkz6Ehv6E5sl1y8tPS6vGWIpPe6uqJfv27vp21zGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtcZn9AX; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-540e0970ae2so509740e0c.1;
        Mon, 25 Aug 2025 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756138819; x=1756743619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQK66bSWdpR/3neM6ZuMukiV+gZsLXj9dgiuTjYX2AA=;
        b=BtcZn9AXCrHxvLk0Vu/OLj4mvTA9QKbmWnXqKq67GWGRW8NDfMPAm5Q6I7TtZnE7mf
         +xqK6FO6PLWLyHXwe94mqJEi7VE1cZxX3TMZm9rp3kKynrQvVgnIo7McpJ8adRqYUbVc
         nuEYhCDJRP1hIFWdZ+ANS/O4pq8fqCoC41XNvMLLrRhd2Y3Tzvg5PKFYEupjgxTg5XsY
         J4q2wH+WHwj0YFw88Ikb/1aiqHjcfyTGQyqgiVtH5A0jqjyoRzo6bGoQ62vvDWtlJ9no
         Wpkqdb2hQkDkU8Qi5/lTuLDU0xuzTJ9WrYy1ITEndlj8y2VgxkvwAYhhh2hgCzNr5vw5
         kwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756138819; x=1756743619;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cQK66bSWdpR/3neM6ZuMukiV+gZsLXj9dgiuTjYX2AA=;
        b=LGziLM3veU+ihTghpXtFlEvi5q5PscHj+R9YgLdeWoazFxA+nmtXvy3+4+2mIqTBq3
         kLSf5RNRGpQO8ErxrudxY1C56nAvwu9bpiPF8s5wCDMEbd0c4SXye6IdsTd1/+PaVUck
         LlZ/bq+zAFGg2Ss2+x+9qJI3XvDHkKNW9NlX5s79Osr4HXc8joWL12XjBr2sQ9U9glDj
         VTDwj6sIfQ2ab37yfSIqRykxMlwIFpljQr9sk1k/B+oMW0En6kQ5MyvvRBEiZYU/iYL8
         U+TjgWnOr46xQHCztlvYZSp/Fuo98af4fCYOXCBvw4WjCWTYS+teqfV0/dqQv8nM8FV7
         VMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu83Ebo8Iiv+SII+Kzv70vJyBCI6BSM7aNl/TzcmtHd+KuLbOZ+uJL18ifvqjkJEsK0E4b3eFVJtApRyQ=@vger.kernel.org, AJvYcCXjbre7A7IqlSJ8ldKCdFb3wuAAVfFXquVpufmXLZ3b9tyCOs6lra9qmg1Z18RUIUpovfSgVpYy@vger.kernel.org
X-Gm-Message-State: AOJu0YyAstOe1RNTidLpXBirVnDauvQUmbdHd94YoTsAExhYhuNIr4f+
	IEcmlbD4qoYQynFu3VRUzwxfgIHJwew+VSP6UclFyStDH/GF5SQcQyBY
X-Gm-Gg: ASbGncte58m4RRaDFm4EnKvdHpM01ZgJbp0y+bpbmKKMeL9b9W92jdhquZEYRgE59I9
	eumXHUOAqRt3sf/PdJa1CcOtaGe62soOIbloT3L2nrSli5+JwNDbHmTo430dWWgFiUWJth5kNnG
	a84s84Pm7RX3nfXurjhj8fLU1PKH1OsnCXwGvcQU4q/KDvRoRkzJyxlRc4j5M6QbYAXkwirisY4
	8e5rWEXSOiBOvm8lrH8UX04eCCBCk2JBS33fjkgQElUl1zebCNdFNcxRADbUT6W2TkLh93yUVF1
	xSgPVkkEBZfQj391wMoYi/m1wpYqSl7hIUO4JCCt+++c/BSpTvbqJh1GywZQlY3MiLDlYIZ793L
	/mH4M18q7JvACSayxn3yO3AMNUUCIZ1o+/fnjIgJy+KjhdZQ7QC40AM7bPbBwsccS+Q/Z0A==
X-Google-Smtp-Source: AGHT+IG+DDyinrOkYJVWmDmJqNIEOlqMrV1fm+S8myMgd86vycFol54MLKDK798r08P9S1+6Mp7TvQ==
X-Received: by 2002:a05:6122:8d0:b0:538:d227:a364 with SMTP id 71dfb90a1353d-53c8a2bde65mr3110548e0c.3.1756138818726;
        Mon, 25 Aug 2025 09:20:18 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-541b1dbcffcsm496071e0c.4.2025.08.25.09.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:20:18 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:20:17 -0400
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
Message-ID: <willemdebruijn.kernel.26d6abeee5c4c@gmail.com>
In-Reply-To: <20250825050628.124977-1-jackzxcui1989@163.com>
References: <20250825050628.124977-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v6] net: af_packet: Use hrtimer to do the retire
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
> On Mon, 2025-08-25 at 2:08 +0800, Willem wrote:
> 
> > This is getting more complex than needed.
> > 
> > Essentially the lifecycle is that packet_set_ring calls hrtimer_setup
> > and hrtimer_del_sync.
> > 
> > Inbetween, while the ring is configured, the timer is either
> > 
> > - scheduled from tpacket_rcv and !is_scheduled
> >     -> call hrtimer_start
> > - scheduled from tpacket_rcv and is_scheduled
> >     -> call hrtimer_set_expires
> 
> We cannot use hrtimer_set_expires/hrtimer_forward_now when a hrtimer is
> already enqueued.  

Perhaps we need to simplify and stop trying to adjust the timer from
tpacket_rcv once scheduled. Let the callback handle that.

> The WARN_ON(timer->state & HRTIMER_STATE_ENQUEUED) in hrtimer_forward
> already clearly indicates this point. The reason for not adding this
> WARN_ON in hrtimer_set_expires is that hrtimer_set_expires is an inline
> function, wory about increase code size.
> The implementation of perf_mux_hrtimer_restart actually checks whether
> the hrtimer is active when restarting the hrtimer.
> 
> static int perf_mux_hrtimer_restart(struct perf_cpu_pmu_context *cpc)
> {
> 	struct hrtimer *timer = &cpc->hrtimer;
> 	unsigned long flags;
> 
> 	raw_spin_lock_irqsave(&cpc->hrtimer_lock, flags);
> 	if (!cpc->hrtimer_active) {
> 		cpc->hrtimer_active = 1;
> 		hrtimer_forward_now(timer, cpc->hrtimer_interval);
> 		hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED_HARD);
> 	}
> 	raw_spin_unlock_irqrestore(&cpc->hrtimer_lock, flags);
> 
> 	return 0;
> }
> 
> Therefore, according to the overall design of the hrtimer, once the
> hrtimer is active, it is not allowed to set the timeout outside of the
> hrtimer callback nor is it allowed to restart the hrtimer.
> 
> So two ways to update the hrtimer timeout:
> 1. update expire time in the callback
> 2. Call the hrtimer_cancel and then call hrtimer_start

1 seems preferable. The intent of the API.

> According to your suggestion, we don't call hrtimer_start inside the
> callback, would you accept calling hrtimer_cancel first and then calling
> hrtimer_start in the callback? However, this approach also requires
> attention, as hrtimer_cancel will block until the callback is running,
> so it is essential to ensure that it is not called within the hrtimer
> callback; otherwise, it could lead to a deadlock.
> 
> 
> > - rescheduled from the timer callback
> >     -> call hrtimer_set_expires and return HRTIMER_RESTART
> > 
> > The only complication is that the is_scheduled check can race with the
> > HRTIMER_RESTART restart, as that happens outside the sk_receive_queue
> > critical section.
> > 
> > One option that I suggested before is to convert pkc->delete_blk_timer
> > to pkc->blk_timer_scheduled to record whether the timer is scheduled
> > without relying on hrtimer_is_queued. Set it on first open_block and
> > clear it from the callback when returning HR_NORESTART.
> 
> Do you agree with adding a callback variable to distinguish between
> scheduled from tpacket_rcv and scheduled from the callback? I really
> couldn't think of a better solution.

Yes, no objections to that if necessary.
> 
> 
> So, a possible solution may be?
> 1. Continue to keep the callback parameter to strictly ensure whether it
> is within the callback.
> 2. Use hrtimer_set_expires within the callback to update the timeout (the
> hrtimer module will enqueue the hrtimer when callback return)
> 3. If it is not in callback, call hrtimer_cancel + hrtimer_start to restart
> the timer.

Instead, I would use an in_scheduled param, as in my previous reply and
simply skip trying to schedule if already scheduled.

> 4. To avoid the potential issue of the enqueue in step 2 and the
> hrtimer_start in step 3 happening simultaneously, which could lead to
> hrtimer_start being triggered twice in a very short period, the logic should
> be:
> if (hrtimer_cancel(...))
>     hrtimer_start(...);
> Additionally, the hrtimer_cancel check will also avoid hrtimer callback
> triggered once more when just called prb_del_retire_blk_timer by packet_set_ring.
> The hrtimer should be in an active state beginning from when
> prb_setup_retire_blk_timer is called to the time when prb_del_retire_blk_timer
> is called.
> 
> 
> Thanks
> Xin Zhao
> 



