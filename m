Return-Path: <netdev+bounces-251259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9F3D3B69E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22FCF300EDE8
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385EF38E131;
	Mon, 19 Jan 2026 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj+UESCg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713A2586FE
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849426; cv=none; b=BQI8nAgJcZ6bGDm0CVbTxbMEHEn+CKoa0lW1TvQed7ZoaxhyxZ5qyCFr1mGviso6aYxHo98WMjmkW49sjtpcliH2RGZbZz5IoF2gtv5xFWHW9KdFlVdSgqXhaIEWc9B0ZzyjvxhZQMKK2Gf/smlBi98ZJ57ajAKsVlGO8zlHsBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849426; c=relaxed/simple;
	bh=2VRfUNjAqvrq2v9ryLdJwLkWzIKgoDamqeHq0hKtcLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COfrZj8O0HdsmdAVja2qADeBw+sCFhfs3AkGMjha8Xj4RqAyzTFx16eZhO6cWs2QzBcP9C8q6TA9li1USyXuc1z1ygLs5U20Tkj2o+d8svuOJxAdFuEXZQLrSEPlwk/kcfUUW3xTs/GWDj8dm9SewslUNQN95K0EnYD436AAlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj+UESCg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so3174547f8f.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768849423; x=1769454223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRuqk5TCfryJ7Ik6jtbOGaU5nqofmByN3gyzEY2WCA8=;
        b=Gj+UESCgH7xsp3Ov7MMfLTJnFI+yPoCfGNjP85Ui4NLHOjyip6e5SsV15Y+sKMwnLv
         ae1YJm6mQTeKj2fYpVDPk/OvdLzTE38MXnmicOMXPzdRWiynqV0F8M8hYn/B80Fk2+zO
         eBaS1vPwC2s9xYpB8+AWuuYmeYZOFX7tO2zNnOZ7xG1OeuURihDy6QrTblD83j/SkdXH
         ezl0gpK3e8lxpA7Q/2KP5ZgLpl9NyNcl+1I+nJkZBV/kGlJAq7cs2RMNKDk1xnsCCz8G
         jE9QQ7cDN7ymvhthOIFyXw/OuCix2CPRshe1eOO7xW9FTWd4p1LiXoad7JXx8BNWvLyv
         RqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768849423; x=1769454223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DRuqk5TCfryJ7Ik6jtbOGaU5nqofmByN3gyzEY2WCA8=;
        b=JjOH+e+Y2CNfy5d6hwt+C5q8ADg+Yz+yIug05HdJ/JuNsqpGGqNKf4uFkNhYJID8Im
         TIYbqgoScKMaDz/QQY5KHUmAsmCPxsKyWyMbqpXER1Ht/0uBB1ME3DmQUQNlL67xXM0Q
         pisp/rphG+N9tpHgn2Mvr2YH2mnplIcLQhkReUIyy2tLB9JZEZisZmx3YHyr2Zp6SCBS
         MmBYncxNuXxxUjIqakRGsZA7fzAoGRE/s914Z02Adxk76xQeOIcv8tKbQ7CMGS8CkxhG
         kuYxkq3NRiOl+T402d+B88D2alG1vDMPR601IhVEZsErUhs5j7o9AnLvuKy+2UpahHqF
         S8vg==
X-Forwarded-Encrypted: i=1; AJvYcCVTH8CQjuCJS7OCw9aXor38W0TbNErCcxG4jzUBO9pkBjF2palCum6XW9D4V9296ZgFaI4cqL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynqjacIMNqIdTKR8asfUad5MIQcShYLDbhLZOzC/QpUSWsPPyZ
	F+Lqz/elQpcljV9nGgzBr/vloqzWIdcaUczteO/v0GS8yPRnK3Q3CfW5
X-Gm-Gg: AZuq6aJFdAq7BaaDTyWk7zoIhzWHDmC0xXl9EJUGLEnxndChfbXqtfJg+JK8kNAdMfK
	LJ29C82ZbW+dfoTv6MxhstHXy/Nl9Rj67xntz6cc2xmUyZqetPlWo3QZNUy4Wez9rr2+B+HSjzu
	C4c0bsCl13bfjqQVhsafNMtKPwMELrhG7vxCdhibuJ1FiYO3vSe0V6daEISbUuAeERf7q/TRL37
	gjOEj818MWr1jC5DwvM5DJitnukAIqvUkRBrSR+USmre1fcjHyjv0/wURuIvxER1J1TvPo3GXWl
	BN+HFnY554opLWL/re5fFiaDNiQ+XYH+tivYgwI9zgqjNFyKEJdgHRdaYaxh61WI652hgJ0zBBH
	UmcVsHDclrtfE0AXSHJSDuW2NBAQd65E7pO2VEyCrPcqC1BQE7zEKNhQtbyf6Bh+URlgbAiW8Pq
	PUUeARvImCS0c4J2A/W9vFZxOQK/z2Tzhq45LpvrWCyx6wOLSaz+N1
X-Received: by 2002:a05:6000:4202:b0:432:a9fb:68f8 with SMTP id ffacd0b85a97d-4356a02643dmr13808435f8f.1.1768849422955;
        Mon, 19 Jan 2026 11:03:42 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356999810bsm24831353f8f.40.2026.01.19.11.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:03:42 -0800 (PST)
Date: Mon, 19 Jan 2026 19:03:41 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <eric.dumazet@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
Message-ID: <20260119190341.39c3d04c@pumpkin>
In-Reply-To: <681985ss-q84n-r802-90pq-0837pr1463p5@syhkavp.arg>
References: <20260118152448.2560414-1-edumazet@google.com>
	<20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org>
	<20260118225802.5e658c2a@pumpkin>
	<681985ss-q84n-r802-90pq-0837pr1463p5@syhkavp.arg>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 10:47:51 -0500 (EST)
Nicolas Pitre <nico@fluxnic.net> wrote:

> On Sun, 18 Jan 2026, David Laight wrote:
> 
> > On 32bit you probably don't want to inline __arch_xprod_64(), but you do
> > want to pass (bias ? m : 0) and may want separate functions for the
> > 'no overflow' case (if it is common enough to worry about).  
> 
> You do want to inline it. Performance quickly degrades otherwise.

If it isn't inlined you want a real C function in div.c (or similar),
not the compiler generating a separate body in the object file of each
file that uses it.
That is just the worst of both worlds.

> Numbers are in the commit log where I introduced that change.
> 
> And __arch_xprod_64() exists only for 32bit btw.

I wonder how much of a mess gcc makes of that code.
I added asm functions for u64 mul_add(u32 a, u32 b, u32 c) calculating
a * b + c without explicit zero extending any of the 32 bit values.
Without that gcc runs out of registers and starts spilling to stack
instead of just generating 'mul; add; adc $0'.

I could only find the definition in the header file - may not have
looked hard enough.
But 64bit systems without a 64x64=>128 multiply (ie without u128
support) also need the 'multiply in 32bit chunks' code.
And common code is fine with u128 support (ignoring old compilers
that generate a call on 64bit mips even though it has exactly the
instruction you want).

	David

