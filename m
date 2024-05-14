Return-Path: <netdev+bounces-96233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579318C4AE4
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A481C21514
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368E17FF;
	Tue, 14 May 2024 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApvfW+mA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801517CD;
	Tue, 14 May 2024 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715650347; cv=none; b=HuJEYNGoaE9utvyzq9yDJSeq87xUbsMJO84pNsTFFc2Kl1tFFwi8yV8R7Ec2Cw1YM8Igwj53sixJikjBUcEIa2mTvii23QmLqb9y8zbyOs+3v8j4lYrAM0x7PK3fqWhSKAmqpOlTgeOX2jF11T4HbWKi2XgCrES4blqfCXrFCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715650347; c=relaxed/simple;
	bh=oIyLaWo1XRajE/9ltxq68fNhTTF6N2kIpdyk3gA+7EM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WFYsJ3kI4FaXr3/fRmeggEeujAa/CE0kkqmmqW7FMmAgC1y0cgV+Kti2OyZ5dN5DodUfv7qNXgiLEHOIM2N/FyXpPrUWq6wimi4aPUrxdWzhMV/Ng3Y5T6g4h1UyOoViCF1alNmobyNEzwn15Tbr1z5+rRIggsnmZEr8rQCyamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApvfW+mA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6a0ffaa079dso52484546d6.1;
        Mon, 13 May 2024 18:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715650345; x=1716255145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyRAmbF+8gtTT1Tq654YoPMkBAcyx27cTv4AvvGb2v8=;
        b=ApvfW+mA2f8lHYkzIXmj9jPVS6zTevAno2bLGQv4tdIZ36wz1XBgmBZeNLt0X2akuG
         dWlX+oaPjsehOIPAPEFZ0raCximZQsMqVNXPNNj/W8MHVA6wYwX1B7nqEUQvDYIlhz0j
         7s0IfsMn+y+vb377x8Q69wO8B5gDHdRB75SDEP/yvMUXpyy/R0tLRDvH/N/VLnPIWAU9
         0zkPr31o/SGbcnu8vhm6LHghPRNnMXX3CAKlft96gY3dJvFBu2rCBlIJrdZT0ISDxaRc
         EevONoG0uEHtjqpUQYqmivtsHCw1/RZKKWFu38V9ZTmwWC+pGK9GInMji9VXDGK/f2ah
         5vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715650345; x=1716255145;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DyRAmbF+8gtTT1Tq654YoPMkBAcyx27cTv4AvvGb2v8=;
        b=WbSwxrzxzRkELSOYLuLhDQY9BeJRBoSeYaa3KcgZv9Uo/K7GEa4qI66T27ERtF++Bn
         lq99dOPvKHWRn2C7YNCZ5AHvKFE8Tl9P/rdfJqaH+fFcOZBtKj3vfdVxlJACS++bdpha
         t6dNKUnK+jnN/ppAHXJ1tbv4y7Xq5mJCegv54Kv9qBENHaSXn/XKgaUemgE9BF6n5VSG
         SuzDqletyAZE6EPT4VmYJqeMcqKx451HBAEmI6n0pOkK7PGTZMDT6XWX1WrsupWZaF5E
         tFBqdAHFqZ1bExbZsi3AKaL9ZuqNXtnebotTLngxmEbRJCWv3Skbz7TUxbRiUNpZEzHv
         WQFw==
X-Forwarded-Encrypted: i=1; AJvYcCVWM5uK9Y4CeQXCH3A6sPxti70ZDwyhBv3mB/YKTRKHpsDPf7s/4+bPHWvaGP0qiGR/f1Pwch0Sxm1hNxtATVIOElyFrf5xvw7IqkToIvjppgqBggXWyd9JDnv0zFc7S2sz5HcRGuE6
X-Gm-Message-State: AOJu0YwfCPKg5CqLoQX+V2RLf1b7hZmmRN0nQ9qhvrlh8gtqENbJeyJ5
	JsOqYsQsGGuqJX9TNi0gBjUK58h8V6nLVAHqaIVd/4zdJqOHkcsK
X-Google-Smtp-Source: AGHT+IF51ok5d8ypICGBwKcYF2wLa0mHtLGZGjORrNISE5ca09HmRuygNjwr55Do3RLfEF8Vqqirpg==
X-Received: by 2002:a0c:e6c3:0:b0:6a1:174f:1212 with SMTP id 6a1803df08f44-6a15cb90881mr250227116d6.1.1715650345020;
        Mon, 13 May 2024 18:32:25 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f195018sm48884446d6.74.2024.05.13.18.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 18:32:24 -0700 (PDT)
Date: Mon, 13 May 2024 21:32:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Pauli Virtanen <pav@iki.fi>
Message-ID: <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240513154332.16e4e259@kernel.org>
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
 <20240513142641.0d721b18@kernel.org>
 <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
 <20240513154332.16e4e259@kernel.org>
Subject: Re: pull request: bluetooth-next 2024-05-10
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Mon, 13 May 2024 18:09:31 -0400 Luiz Augusto von Dentz wrote:
> > > There is one more warning in the Intel driver:
> > >
> > > drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol 'causes_list'
> > > was not declared. Should it be static?  
> > 
> > We have a fix for that but I was hoping to have it in before the merge
> > window and then have the fix merged later.
> > 
> > > It'd also be great to get an ACK from someone familiar with the socket
> > > time stamping (Willem?) I'm not sure there's sufficient detail in the
> > > commit message to explain the choices to:
> > >  - change the definition of SCHED / SEND to mean queued / completed,
> > >    while for Ethernet they mean queued to qdisc, queued to HW.  
> > 
> > hmm I thought this was hardware specific, it obviously won't work
> > exactly as Ethernet since it is a completely different protocol stack,
> > or are you suggesting we need other definitions for things like TX
> > completed?
> 
> I don't know anything about queuing in BT, in terms of timestamping
> the SEND - SCHED difference is supposed to indicate the level of
> host delay or host congestion. If the queuing in BT happens mostly in 
> the device HW queue then it may make sense to generate SCHED when
> handing over to the driver. OTOH if the devices can coalesce or delay
> completions the completion timeout may be less accurate than stamping
> before submitting to HW... I'm looking for the analysis that the choices
> were well thought thru.

SCM_TSTAMP_SND is taken before an skb is passed to the device.
This matches request SOF_TIMESTAMPING_TX_SOFTWARE.

A timestamp returned on transmit completion is requested as
SOF_TIMESTAMPING_TX_HARDWARE. We do not have a type for a software
timestamp taken at tx completion cleaning. If anything, I would think
it would be a passes as a hardware timestamp.

Returning SCHED when queuing to a device and SND later on receiving
completions seems like not following SO_TIMESTAMPING convention to me.
But I don't fully know the HCI model.

As for the "experimental" BT_POLL_ERRQUEUE. This is an addition to the
ABI, right? So immutable. Is it fair to call that experimental?

It might be safer to only suppress the sk_error_report in
sock_queue_err_skb. Or at least in bt_sock_poll to check the type of
all outstanding errors and only suppress if all are timestamps.

