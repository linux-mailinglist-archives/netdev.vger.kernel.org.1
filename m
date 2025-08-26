Return-Path: <netdev+bounces-216920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E91B36032
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786A01BA7D0D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E14207DF3;
	Tue, 26 Aug 2025 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qttu5Vzd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E901F09BF;
	Tue, 26 Aug 2025 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212890; cv=none; b=r3HeQcRPGwN7Z5rYHIgcl0F71mBTgTQHelkTj7M9PqKvLnDd3rDYS8V49zDY0zilLYnRAgPZL9O0AQni9kHwfkeR2lfyu+MG0UzUG+VigpbXvEBn43ZD2N0+D12ePLJ9EVVV2K0CcmYsyNG1X7npsWUS50AYMNUhyfUbf14jLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212890; c=relaxed/simple;
	bh=LXuP8d/+OEh1uPEue6k7yNAbaZ/uz/Zgm558er50t5k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UcbARlWqNnrevycTa7gPZO3GQ7OFKlF5gzQlKikiHcR2AGfJmxGivkHtUv6h0E5EA1weTX2HxqIMX/ewovMKHEzcroZBeKPHeINrm29/QEVfEROoodkaOknwFrUzD1PgcQaIJ86IFAw3fLUXbHKaR71bbDS6DwdnVL3wby3JdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qttu5Vzd; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-53f55b17a6bso2364574e0c.1;
        Tue, 26 Aug 2025 05:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756212887; x=1756817687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnJz260P+al/8wc9dq54V0f0J6jA1a/EJWHmGfEUVjE=;
        b=Qttu5VzdJSZpCJZtnh7MfQhCg3WQ1EgxCMUct2YsGMAmti/LF+x731uht4G+DJDCK+
         3vd8MFI/qgLYIv/JnfL90JuTCRs09c0wOOWAl7KMPhKw/bC6qMM0//Bt6JixESz0LOoF
         mCkecs3k4TOcdDuTDY5pB7e3+KUnyu3cCNgD/ljD8CB5nFQ2HVqlK0LqDV19Y1VqAs/s
         fhskNuQoULLdoWieR1kH0mxazlOhI+inxD2/5oOlCyca33YgoA0Hzq1TNIlPPvB0BRSO
         qeJ2Nbv8t8I8g0sxW1js6bfSlVK7Efq6WH8cO1ppUws+Utkrh4pOXGuQSG9hAb7xkm/L
         rnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212887; x=1756817687;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PnJz260P+al/8wc9dq54V0f0J6jA1a/EJWHmGfEUVjE=;
        b=ubW4CWqzByyh8mnasLE7FnSWMdFv8QN/rOAOJvSIN+YvCHKQQcdnJlWktv0tUe7FrC
         4XIRI4L71hjmEAjXQlShf20T2eGkg+FTfxAI7RfO4O0ESmhVdJEAM8LFv3jMhpHfGRIw
         7e3xahOF7G+RKBIHq2Tzihv3OoirYR2gjLVRzP/l3eEBMojffS0SudP5cT1wX3GCFiuF
         lYQbjnyQL+5Zc/zkKCA7uqgInSQXDBiGYmVTNi1SucGGKIfZJfJmhKlgFdIqCBxuLTsK
         vzADknq2tPbianLQpZr6Kd2tA4Rgbue8aRw7VYHE5hsniveiS+du6VNzxF4SvJuHYmXj
         Khng==
X-Forwarded-Encrypted: i=1; AJvYcCWLtIQ1TcZTizOEiDYhV2viOHyDuIyQFwiLlRzndjpn9ItnV3AY2iTPeGx+WrxF2jcUwHZK8ulElPDusdk=@vger.kernel.org, AJvYcCXY1osv9ZtCpsp0Xxv5gOfuzh5xlBJlmg1lbH8Qz3JgNykqVryKs7WHY5W6D6onc9pWcbk9Fb2b@vger.kernel.org
X-Gm-Message-State: AOJu0YzyNhAtgYmr8wUcB+oyj+81POL9zn6xrCfP2PZe39JwJxetyKL6
	rEYa1CIEU/XIsyRZcayxUmSUNQxHSuqN3Efy9Gl1/Ob87F4qI7xx4EGJ
X-Gm-Gg: ASbGnctvHNvM13lbEJPJWXiDMbOIMjrX1TeFCk02oRMmLIaJ5WgvPrzJFQMxnLNbby8
	xhk7u8eQvaHGGSvHVdO4tBbrqLMuopGqc2vqG09LyxnHtsa3JpYl5Ie5+dCJzYqelESGlnxSYTJ
	TX1TuGdM2LGVS7QKl3LlbnLc1g1amM/v7XhLneZ3ZI6nnikRs4C1ryilq9XKQulqfNMh3aVaPWr
	r21uJy5qYdbEzwqLi/590D+bklFow+iTSl88eGKNuTIfRMf4BzVO6AO5sHNmWoM/vBM3ryc5uKU
	CQIRa2W6bc4O9ysN5fwQEe64MCDSjEsFrKm3VFk3uaaYs484mBIOy4pX83uaepUYisN84WH+ptN
	xUKNDHyh4LwNlWbrEFrDFhgQGqZZZrSPOPb7uU4LqqUppfp9N/GnEDq/mNL0JCzVx/J6Og1JBTT
	qItw==
X-Google-Smtp-Source: AGHT+IFCBUKljKD5m5RLKcPd+XCFYuuJ3uY3fDjRHzOwo6jxt7LqbYVS5RfhEPX9TEbBpvd6DxZA/Q==
X-Received: by 2002:a05:6122:6ab:b0:540:68c4:81a2 with SMTP id 71dfb90a1353d-54068c49af3mr2433859e0c.14.1756212887511;
        Tue, 26 Aug 2025 05:54:47 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-5438796ab60sm247590e0c.15.2025.08.26.05.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:54:46 -0700 (PDT)
Date: Tue, 26 Aug 2025 08:54:46 -0400
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
Message-ID: <willemdebruijn.kernel.ade9d72d060e@gmail.com>
In-Reply-To: <20250826030328.878001-1-jackzxcui1989@163.com>
References: <20250826030328.878001-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v7] net: af_packet: Use hrtimer to do the retire
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
> On Tue, 2025-08-25 at 0:20 +0800, Willem wrote:
> 
> > > We cannot use hrtimer_set_expires/hrtimer_forward_now when a hrtimer is
> > > already enqueued.  
> > > The WARN_ON(timer->state & HRTIMER_STATE_ENQUEUED) in hrtimer_forward
> > > already clearly indicates this point. The reason for not adding this
> > > WARN_ON in hrtimer_set_expires is that hrtimer_set_expires is an inline
> > > function, wory about increase code size.
> > > The implementation of perf_mux_hrtimer_restart actually checks whether
> > > the hrtimer is active when restarting the hrtimer.
> > 
> > Perhaps we need to simplify and stop trying to adjust the timer from
> > tpacket_rcv once scheduled. Let the callback handle that.
> > 
> 
> Okay, I would also like to modify the timeout only within the callback,
> so I think PATCH v7 might be a better solution. Additionally, in terms of
> performance, it should be more efficient than frequently calling
> hrtimer_cancel/hrtimer_start functions to change the timeout outside the
> callback.
> 
> Why do I add the pkc->expire_ktime in PATCH v7?
> 
> For example 8ms retire timeout.
> T means the time callback/tpacket_rcv call _prb_refresh_rx_retire_blk_timer.
> T1 means time T plus 1ms, T2 means time T plus 2ms...
> 
> timeline: past -----------> -----------> -----------> future
> callback:      T	           T8
> tpacket_rcv:                 T7
> 
> Considering the situation in the above diagram, at time T7, the tpacket_rcv
> function processes the network and finds that a new block needs to be opened,
> which requires setting a timeout of T7 + 8ms which is T15ms. However, we
> cannot directly set the timeout within tpacket_rcv, so we use a variable
> expire_ktime to record this value. At time T8, in the hrtimer callback, we
> check that expire_ktime which is T15 is greater than the current timeout of
> the hrtimer, which is T8. Therefore, we simply return from the hrtimer
> callback at T8, the next execution time of the hrtimer callback will be T15.
> This achieves the same effect as executing hrtimer_start in tpacket_rcv
> using a "one shot" approach.
> 
> 
> > > Do you agree with adding a callback variable to distinguish between
> > > scheduled from tpacket_rcv and scheduled from the callback? I really
> > > couldn't think of a better solution.
> > 
> > Yes, no objections to that if necessary.
> 
> So it seems that the logic of 'adding a callback variable to distinguish' in 
> PATCH v7 is OK?
> 
> 
> > > So, a possible solution may be?
> > > 1. Continue to keep the callback parameter to strictly ensure whether it
> > > is within the callback.
> > > 2. Use hrtimer_set_expires within the callback to update the timeout (the
> > > hrtimer module will enqueue the hrtimer when callback return)
> > > 3. If it is not in callback, call hrtimer_cancel + hrtimer_start to restart
> > > the timer.
> >
> > Instead, I would use an in_scheduled param, as in my previous reply and
> > simply skip trying to schedule if already scheduled.
> 
> I understand that the additional in_scheduled variable is meant to prevent
> multiple calls to hrtimer_start. However, based on the current logic
> implementation, the only scenario that would cancel the hrtimer is after calling
> prb_shutdown_retire_blk_timer. Therefore, once we have called hrtimer_start in
> prb_setup_retire_blk_timer, we don't need to worry about the hrtimer stopping,
> and we don't need to execute hrtimer_start again or check if the hrtimer is in
> an active state. We can simply update the timeout in the callback.

The hrtimer is also canceled when the callback returns
HRTIMER_NORESTART.

> Additionally, we don't need to worry about the situation where packet_set_ring
> is entered twice, leading to multiple calls to hrtimer_start, because there is
> a check for pg_vec before executing init_prb_bdqc in packet_set_ring. If pg_vec
> is non-zero, it will go to the out label.
> 
> So is PATCH v7 good to go? Besides I think that ktime_after should be used
> instead of ktime_compare, I haven't noticed any other areas in PATCH v7 that
> need modification. What do you think?
> 
> 
> Thanks
> Xin Zhao
> 



