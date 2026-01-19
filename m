Return-Path: <netdev+bounces-251034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F2D3A322
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5F0930169BE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F17296BA5;
	Mon, 19 Jan 2026 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUQIJxJa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B8197A7D
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768815225; cv=none; b=bQglzTJXGPfULoUscRjhSpTJX2c+ztnjiarQbGJB78PMEpVDZeMqaohRk7wUp6RCOqTwhlWAzkCDoW2ibwboq0AFR4xbr9FGOHhsTGN6pYG9W8uqjJwOClnmpiqozjng8vR5O1JRjc1y6p7uGQHCmWobySUKSdVNNBSHAMXzPgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768815225; c=relaxed/simple;
	bh=Qfq+YGyJejMJFEyBEHzlzdNJQfj1V+dSrryNwTI+upA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjd39TJ05aW0EdAgvJYMiXc+pUWOLARo1YDMLOHNjJMQshwgk5BCvZzisezsNtD/1UChbJLQnKYT/e+7gdcR73zCS+WVYuZ3jePSiZq8VfbyYYjgvmaatOX9Qp6WctMmm7f6z0TttOtF4Ok7tUm2TiJSPUJfh8lihaOGAnG16io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUQIJxJa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee3da7447so25180755e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768815222; x=1769420022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxFUMINiROnPGneWmNkTLgSLfIoIsEZfiy7Cs/FTrhE=;
        b=WUQIJxJamOOepf+j+NyCMHAatXMTR58D/UAXrQfiR71AqCtJybBlx5YVNzeTuCAYiL
         7c+T1ZBJyO+NYGxeuRcowrZ+2VOyXw8JWHYeC9WBuKAV+FGI4M0XNQnWje4mVRHPSf0Q
         UMoNnyvIQPMdZ6iEQ3/WAaD1FY60I02MH3XzXXPXWQuweh22TEXfZXpSbnL0cdhv3Mxp
         1kQIDHf+p9U7qqF3FbK8TARu8Zvi0C0fvEJ9UXBPYNgpvCRfpdFVWpvH2BEXqTk0dIgJ
         kb1I8vvzKuNALs6eM20qsRq9P5RIsruWm4YWlA/HHbo6cfq/RixY9goJocjJ9Fr5YU6N
         x+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768815222; x=1769420022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vxFUMINiROnPGneWmNkTLgSLfIoIsEZfiy7Cs/FTrhE=;
        b=vgX+93TKPXuqEglehbv+XtwNef7os31MzpM42rHiMahtZxHtV1ZqBQDHNi56eTk6RX
         cMRqrUCYX/KgGgYdOBXMkZ2cDD3+vY6Dz39WVvqKzGodKXfOVWYyVwZFsufX8l24RcTi
         /GB/kdBFt392gFOhV3QrGGtxkC1QWJ0sMV5AHjo5bMoj1v4Y2TflfzYFacb55kR5EbG8
         0fbJq7k4utQycyo7dG3c0zbnt62E0xpwK1cMw5mDetrGY3+oY6N0Ghjsb5pzu+lXztxt
         pizKviTkrLW8trrTOnU7MXiGieL7HigQAqQGl1WsyWavvN5KeelPN+DSLu8+e0PFzFjy
         /l4w==
X-Forwarded-Encrypted: i=1; AJvYcCWT9K7nJopjdCnSTIlO14oxLaCbusCPNAI3Qk+dHm0Bm9w5NXPQaZRE2qE4Oz4gsaLixIdHsSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2864FpgswFaKD2Ug9mTROC2sm+d221OetJrtDi7Ns+TNvzZu
	MMecdP9QuKP7bBovyx8e6hECnveAD0ntdz9gIO43tXXv2poPraA/3uhB
X-Gm-Gg: AY/fxX64nBcdz9t/SRPe15+nWijCpT3KHyK6W/Gc6YpcqGIT046nc16IRh/FZujQcRa
	h5Glt9vjOA05XcBOjEWkdy6aoVUii4gzyoWv5uu+0wIYUqCPk2SCiHYEkWUD/ezZvnl966/3iE7
	M4EVApEM/e5TWGG/qc0dcFYKNTnGYtJEAoAIHd4r0JsW2RcDHOLq3sRKqZTP7MtPE0S8NqAYdQU
	9MORyvkq5Z7hMm2NmEI0wBRlpUCnSpiNL2iZM+wxhJnncQyp4dmVhMnzhRV02v4efo9oC6346dE
	Xxpt8L3RIg4/hRyN8/nJ+5UOgEWT1J8gNmJRaN2vTXFnhh6ODBYRi/MVhT/r/4gPkHQtbUgSTMN
	CEOe3YNP4XIXLiW9W+Q/lTz7W8LPZ3h9fpy5M0TmC9ugq43q3EF6w0BJ69JxgIoic89bX064rZ3
	JRHG3wvQgHIJt4G6i1jVUFM+ry0dVZ4rTWwPwiqUsoXQrJtJ7Mr3vk
X-Received: by 2002:a05:600c:5291:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-4801e2eef8bmr108328255e9.3.1768815221752;
        Mon, 19 Jan 2026 01:33:41 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4289b83csm239739415e9.3.2026.01.19.01.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:33:41 -0800 (PST)
Date: Mon, 19 Jan 2026 09:33:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Dumazet <edumazet@google.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, Nicolas Pitre <npitre@baylibre.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
Message-ID: <20260119093339.024f8d57@pumpkin>
In-Reply-To: <20260118160125.82f645575f8327651be95070@linux-foundation.org>
References: <20260118152448.2560414-1-edumazet@google.com>
	<20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org>
	<20260118225802.5e658c2a@pumpkin>
	<20260118160125.82f645575f8327651be95070@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 16:01:25 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 18 Jan 2026 22:58:02 +0000 David Laight <david.laight.linux@gmail.com> wrote:
> 
> > > mm/ alone has 74 __always_inlines, none are documented, I don't know
> > > why they're present, many are probably wrong.
> > > 
> > > Shit, uninlining only __get_user_pages_locked does this:
> > > 
> > >    text	   data	    bss	    dec	    hex	filename
> > >  115703	  14018	     64	 129785	  1faf9	mm/gup.o
> > >  103866	  13058	     64	 116988	  1c8fc	mm/gup.o-after  
> > 
> > The next questions are does anything actually run faster (either way),
> > and should anything at all be marked 'inline' rather than 'always_inline'.
> > 
> > After all, if you call a function twice (not in a loop) you may
> > want a real function in order to avoid I-cache misses.  
> 
> yup

I had two adjacent strlen() calls in a bit of code, the first was an
array (in a structure) and gcc inlined the 'word at a time' code, the
second was a pointer and it called the library function.
That had to be sub-optimal...

> > But I'm sure there is a lot of code that is 'inline_for_bloat' :-)  
> 
> ooh, can we please have that?

Or 'inline_to_speed_up_benchmark' and the associated 'unroll this loop
because that must make it faster'.

> I do think that every always_inline should be justified and commented,
> but I haven't been energetic about asking for that.

Apart from the 4-line functions where it is clearly obvious.
Especially since the compiler can still decide to not-inline them
if they are only 'inline'.

> A fun little project would be go through each one, figure out whether
> were good reasons and if not, just remove them and see if anyone
> explains why that was incorrect.

It's not just always_inline, a lot of the inline are dubious.
Probably why the networking code doesn't like it.

Maybe persuade Linus to do some of that.
He can use his 'god' bit to just change them.

	David




