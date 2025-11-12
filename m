Return-Path: <netdev+bounces-237915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AC8C51612
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4B8189D65E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF319220F5C;
	Wed, 12 Nov 2025 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjrGDI/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E982FE592
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940054; cv=none; b=NKEmFnTVLBUK22b9IMcC1i3pN6L+CCOMadRK6lLkILeEpDaGRZutOZI1pjAYFaqfEnZ+PNwCyuq1R1WwS1we6be93nNXksmVRHq28SNhQtwsUAxAowG4azY8TK6b6nepFzXSqKtIcuX1EC1rWaSCUXwXA9LIjvkeR86mizp5FhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940054; c=relaxed/simple;
	bh=x2jKNqGY/kiVKpHZUUrGXa1xAzr4YMtJ7n2T4FCXCgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gw5+s50PVuTWAPPKTsHG4xgl99OwD4p46CBvstzoN99TesAHrgFa5jA6xnnyCko3f8vbgbCSQG8fNQCNP9SweRx58CC3QJV9t3sG6b1kf+M3iPzvYYzrzZOgSUt0QESlp45FiMqdEZYxr6jE2TUBwlgCbgs/c9U4PivWjzYYYd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjrGDI/N; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so828844a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 01:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762940051; x=1763544851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+ph3n81MNofPspKtp5iN2RLnNXwZpO7ZQr4gG1y+Xg=;
        b=IjrGDI/NkqhS3NDtElz3W18OJX3jd4A2UQpatWoD5mbm7WgpXK6LHK2+BS/ywFOO4r
         DTFAwc5R0OC97BVil91RvUWrBewlI0zmsMlhaiynC3DIFunv40a/vyM5CgiCdnLwrn4Y
         FRQhR6eNToBo8P3Vp9xSlFvXyCGCr6zucmF7HmFoXDYnFsDkA+czHUwzJco+kWxKwtyb
         EmLZnqg+YhUd9BG1fMaJfRPdTMte0DIN0z1yiL9IaZjv/u8uwB49NZV+GFB1PvqVGhvb
         HVS5E70BQZk3efWO9HtbKhjbzM4Y/1ey3h/xH/sgRQ4Xpy49cU831BVYd7XgMYZLDhlu
         ZHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940051; x=1763544851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+ph3n81MNofPspKtp5iN2RLnNXwZpO7ZQr4gG1y+Xg=;
        b=El9MeA1qrMn1u3nGplfYxE50qgvctEl7HQpZ/zggtCVk96XauA6TBePuSUlkgwj1pv
         QSp9RkBwrwEuxKKNJiZNWSsMHDMPYBxlYp3XJ2eVKAo7J+PNTX3S9c+MOGjb6MfOZleX
         NV0J+WdXNheBZgAUANA6t5xheaYPCCaZh0CftUshf7Bv5J+3vTsD2ngYDyd4c/mZ6fCL
         b57MuxNxOC/A7PGdXVp4IEZiiKHm09y1Pf3m2p9Zl+wCm5peKYJWIelKpb0nUFq+maOX
         cMIGBNGsW7yQSqjtyFyKOYcurah8tQktUi+KbHV/qZ4fCv9yERP57Qiybokb8XIwFl7N
         W+UA==
X-Forwarded-Encrypted: i=1; AJvYcCU1O3vtZedLP9uOnmrSrrw305STpCIW1sAUpxu9aVnrFd7MnJm+YDisMkYktcTSVUzK0l/uNU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCgSUKdDTn+5n/b2UWsD5gEf/bJhuHVYoMidLwNl5aNWZWeHr8
	wOYP9fIkPXZIilrML0aeGSQj7TTh5PWKqqoQ0oNCvXxreKW3KIsPRA8=
X-Gm-Gg: ASbGncuOxTot66z0yP8AJF5m1zdXTORzSxUC+jGUlwcp8qEVWnD7+6yZFlD+nAYHipq
	5hH+aTG6rXiO1wI770SeBIa0KGVlYrwwLo9rwRsRhPhPDclF3Tf7+FZ1MYdziC8aONrpeNABTVk
	cREPrBPOuy17vPypSA+0L/MPj79xySqfedkmAF15WPvU2hcENhN0f147FzDJ4tArc2sLQsrzMEq
	6rMT28IN0W9LwSHoMV+e9DsztBcLkvWvHAXsqhm2CZ9zQkx0pp5/0VvhNDwFA+Y5GXxNwE4ZfOO
	/OkYuZyyZ+tOmT4f/ZnAcEXCs2GRCKKfKHG1TkGhrZ4rNitn9MmecmpU2JM8zzwMGe+WhP6WsUO
	EBGughMZHWsMnB2JbP4+KjdXBGIoxujvT3ld7u8etiyHBVSfhkRMCKChBV49bToKjG+pqKBD1YH
	iEe4i8x1E0FMFBWadEuiUJTBhAKFQb0OSkwTEBKc6QOcOv+QlyO9BA
X-Google-Smtp-Source: AGHT+IEbaOVdolpRZRtQY4C4p55uxdFbLWKLEJUaTQ2W0vBS9wly5TtrzUUAVAA7VNF0NNYTPywc0g==
X-Received: by 2002:a05:6402:3046:10b0:640:b814:bb81 with SMTP id 4fb4d7f45d1cf-6431a55e501mr1856940a12.32.1762940051127;
        Wed, 12 Nov 2025 01:34:11 -0800 (PST)
Received: from lithos ([2a02:810d:4a94:b300:ec52:7cf5:e31:cdb7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64165b2aa03sm9869160a12.6.2025.11.12.01.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 01:34:10 -0800 (PST)
Date: Wed, 12 Nov 2025 10:34:01 +0100
From: Florian Fuchs <fuchsfl@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geoff Levand <geoff@infradead.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ps3_gelic_net: handle skb allocation failures
Message-ID: <aRRUiYIrOcpSiakH@lithos>
References: <20251110114523.3099559-1-fuchsfl@gmail.com>
 <20251111180451.0ef1dc9c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111180451.0ef1dc9c@kernel.org>

Hi Jakub,

On 11 Nov 18:04, Jakub Kicinski wrote:
> On Mon, 10 Nov 2025 12:45:23 +0100 Florian Fuchs wrote:
> > Steps to reproduce the issue:
> > 	1. Start a continuous network traffic, like scp of a 20GB file
> > 	2. Inject failslab errors using the kernel fault injection:
> > 	    echo -1 > /sys/kernel/debug/failslab/times
> > 	    echo 30 > /sys/kernel/debug/failslab/interval
> > 	    echo 100 > /sys/kernel/debug/failslab/probability
> > 	3. After some time, traces start to appear, kernel Oopses
> > 	   and the system stops
> > 
> > Step 2 is not always necessary, as it is usually already triggered by
> > the transfer of a big enough file.
> 
> Have you actually tested this on a real device?
> Please describe the testing you have done rather that "how to test".

Yes, of course, I intensively tested the patch on a Sony PS3 (CECHL04
PAL). I ran the final fix for many hours, with continuous system load
and high network transfer load. I am happy to get feedback on better or
acceptable testing.

My testing consisted of:
1. Produce Oops: Test the kernel without any gelic patches, scp a big
   file to usb stick and create high cpu/memory load (like compiling
   some software) or extract verbose, tar xv, a big file via ssh
2. Safely re-produce the Oops using failslab injection, so I dont need
   to wait for it
3. Develop against that failslab injection, high load and network
   transfer
4. First solution was to just always refill the chain, which resulted in
   RX stall after some time, as the dmac seemed to be stopped, when buffer
   was full and NOT_IN_USE head found and needed rmmod/modprobe to work
   again
5. Run the final fix for many hours while injecting failslabs, high load,
   and high network load with continuous scp and netcat
6. Further massive improvement is to convert the driver to use
   napi_gro_receive and napi_skb_alloc, but this would be a separate
   patch

> > --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> > +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> > @@ -259,6 +259,7 @@ void gelic_card_down(struct gelic_card *card)
> >  	mutex_lock(&card->updown_lock);
> >  	if (atomic_dec_if_positive(&card->users) == 0) {
> >  		pr_debug("%s: real do\n", __func__);
> > +		timer_delete_sync(&card->rx_oom_timer);
> >  		napi_disable(&card->napi);
> 
> I think the ordering here should be inverted

I thought, that there might be a race condition in the inverted order
like that napi gets re-enabled by the timer in between of the down:

1. napi_disable
2. rx_oom_timer runs and calls napi_schedule again
3. timer_delete_sync

So the timer is deleted first, to prevent any possibility to run.

> TBH handling the OOM inside the Rx function seems a little fragile.
> What if there is a packet to Rx as we enter. I don't see any loop here
> it just replaces the used buffer..

I am not sure, the handling needs to happen, when the skb allocation
fails, and that happens in the rx function, right? I am open to better
fitting fix position.

Thank you for your feedback!
Florian

