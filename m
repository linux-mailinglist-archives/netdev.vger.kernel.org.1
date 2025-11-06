Return-Path: <netdev+bounces-236381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768C5C3B8FD
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 15:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6AE623940
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D62F33C525;
	Thu,  6 Nov 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9x5nJ4A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CDE33372C
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436584; cv=none; b=deKI+AEFLrLUDfcxpLc2/6el3eb8dIWwCooMfYaxutAs4Tk0dG4E52SLrNWNaBuY0s5G3R7skpACT8gGlWEkA8ksIdLyv7750/3uEr8OmbDj5ey4TgH26PREKXmR0+75ZLHh+uPhs2Pr0SCtj4a6pS2eMUyWWnu5lYImATjcVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436584; c=relaxed/simple;
	bh=yM08vXYgeS+2QUmB9lU/TpbxKmTJ2bayDxKCYSgsODA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5m5rz/Q84bLAHwhwlVNEzwO7bSo+ckw/jMCi/boEwMr121950nQND3G1X6sT1o508kA0AYjlf/4P57m9jM2IUH2uGopIDbzfvGOkggUkuaKhNSpMA1dRyGsm4bN80vfkniklmdp1lCeLqGZ1TfIEsWmna9fiZbVRxkCmZXBbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9x5nJ4A; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c4c65485so774160f8f.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762436581; x=1763041381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4DaQeGVyB05KYzPS0LHKvWlhb6TnpUA8LWnzGCb6LE=;
        b=l9x5nJ4AF4qOQZd2QseTvTvF/rCgyyJIN6Qv2MsWPmsPJ5d451JTrINWDA8Q80ZAzI
         jyAck/zrgsmhQFqcT6p2/BvTEZu4VTPZd8133qGGTnw6O74kmjSQ6Ap4gTLbhaQDT9QB
         r68iBUc4wxX1MrLQ0jlIaIbh6nUKnpEBd0psRiUjJQpgR2LYFWa4K2YJ2NGt3ecrD2rB
         4g4U3Ci0QpWeZHcbjuaHFfarQncTFQz8+QWo469YWfUiMszgGcNXO1YSLDpP03HppifK
         BAe0mvnkUA32K952D7kSNEQ+R1PbWgm61mqKQ+Afj2AycHhVbB8s1Zk7UbJDd28ymJfZ
         Yi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762436581; x=1763041381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4DaQeGVyB05KYzPS0LHKvWlhb6TnpUA8LWnzGCb6LE=;
        b=v/cYGSl4zqDFM73QaY1RGFsP3IbkRQP95XuPnoc3OH9tnYmZPLH6qTZrWrEDrp7E5v
         pw/pR4SeCRttYY7KAVZ2MgVqZhCNizYFXHXDfFYAuo1HOshxzTE40NSyE88vH/KRQVJH
         0aDVm5GqPUH2uaX8HcpKHnEG1VZxMhO4cfTwObQXuoHcgkm/Jq1JbRcJb6bJfPXGZYDv
         rYhQ30k6o7GvMIyWomKoOsTZAst6LOgMvN0XVVuM8CH0CeVKEIz0Mqb81Eu7MweyrOL5
         myPiLgcGm0DdoSWITbi981bt5Ju5DjJjjhdXnG17A9pRiweEnswY1YxZ4Pmm08JOseDL
         hiQw==
X-Forwarded-Encrypted: i=1; AJvYcCXudYEpTafKIYn+XbPXdX7QP0Rrk8V/zvMjqhsBOT5bvVhZdcobM4I+JizMB3TSK00DY9FpdPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Gb6v42ZGBbtyS0ADsnyDYcwBLWDijJdSyU3fLsPM+JS/fXxv
	hxjYLc9rDei8l+hbSYKAFXukZnQs5kSvlay5K4wDDowhqFiwpNqgukDY
X-Gm-Gg: ASbGncv0mKgrEIRnXvkDRrwQWKp0UeUKzpL+tvQBjDDang/Lj7K5Fbh2xm+CYAeeenY
	IJ1yDtt9wAgfSdTNAhcjxgTErOJCRCi64Mgqb5InssdRif1hzFFgB7Iqt+Ul0thnmAxQdaHfHmL
	BNgvoze983O2hRLsXjmmPs3OdtuurhfqkUHpyY7j/LP2rKxkljgDBB5dbsO/jljnnuV19kSPmfo
	bWF6/1W4lD8F6U8qUiv93MFCr6XuU75G1m99o7+/H8KXhfLUNihV4mh5mxE6XmWSb5uBARXcay7
	XhS50c3FK1WCNPtpZxXpoeNDDjuV1rANTULlr7mXB7qq6sKBKh+R5YEbne6U8vcY0C7ug2cyE/G
	MQ1w6tac6zTbHZHCM9KS1y+l/wGCjdMTqHRyuN6wt6h8rFYU0URDfOe1If2e3OWDh1sJwyyqrZk
	xIDfpsLDT4zYIJThFTESO0p90w7S6DtT/l6BCsWht6cGWl2YEgvhHCdRSSgSw1El0=
X-Google-Smtp-Source: AGHT+IHDsjJABGBM/pDAFp2o03YAq/Y+Phzta3DyuV5Jfm/SuLEOelkoMEjBy0TTBTORIGeE1uEwkw==
X-Received: by 2002:a05:6000:26c1:b0:426:d81f:483c with SMTP id ffacd0b85a97d-429e33088ddmr6854934f8f.33.1762436580431;
        Thu, 06 Nov 2025 05:43:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb42a354sm4888852f8f.20.2025.11.06.05.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:43:00 -0800 (PST)
Date: Thu, 6 Nov 2025 13:42:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 10/10] powerpc/uaccess: Implement masked user access
Message-ID: <20251106134255.2412971a@pumpkin>
In-Reply-To: <20251106123550.GX4067720@noisy.programming.kicks-ass.net>
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
	<5c80dddf8c7b1e75f08b3f42bddde891d6ea3f64.1762427933.git.christophe.leroy@csgroup.eu>
	<20251106123550.GX4067720@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 13:35:50 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Nov 06, 2025 at 12:31:28PM +0100, Christophe Leroy wrote:
> 
> > On 32 bits it is more tricky. In theory user space can go up to
> > 0xbfffffff while kernel will usually start at 0xc0000000. So a gap
> > needs to be added in-between. Allthough in theory a single 4k page
                                  Although
> > would suffice, it is easier and more efficient to enforce a 128k gap
> > below kernel, as it simplifies the masking.  
> 
> Do we have the requirement that the first access of a masked pointer is
> within 4k of the initial address?
> 
> Suppose the pointer is to an 16k array, and the memcpy happens to like
> going backwards. Then a 4k hole just won't do.

I think that requiring the accesses be within 4k of the base (or previous
access) is a reasonable restriction.
It is something that needs verifying before code is changed to use
these accessors.

Documenting a big gap is almost more likely to lead to errors!
If 128k is ok, no one is really going to notice code that might
offset by 130k.
OTOH if the (documented) limit is 256 bytes then you don't have to be
careful about accessing structures sequentially, and can safely realign
pointers.
I suspect the mk-1 brain treats 4k and 256 as muchthe same value.

Requiring fully sequential accesses (which the original x86-64 required
because it converted kernel addresses to ~0) would require policing by
the compiler - I tried it once, it horrid.

	David


