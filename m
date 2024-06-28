Return-Path: <netdev+bounces-107530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B69491B54F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 05:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01B3281FF3
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 03:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A431BF37;
	Fri, 28 Jun 2024 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIY9rU7q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814F1B7FD
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544235; cv=none; b=CureIL/9y8Ljm5J64+oz+l0kQndQ/l7VW2xli6n+R0o+A/NubfJgtiIJoUjwb7k32/ZrXi2n+4CZmZyuyAAuw3EQPW2YruEj9XCKPAiRsKBFUO9KGbghtEXY4Kp5JLZ/FxGxok9ZCHiRYiqzI5JqfekERq4ghW2s63bgj0FrMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544235; c=relaxed/simple;
	bh=ayUtdj0jbmYyhKV/itKphkG4lSGfodZRBtWNtlUBvGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBWhpFuRVSQQ5o01HQJHuRRagjdJM3Q0+4+2g5w5qCOkAtCOcjnStapZPdfNQYjYO4NQ+npofrXsDteXujF/xKNGBOcGlB74FbruKs+EhhBuN5mGgFzcWtbXaXvyUh/+akpCpd1bBslU1WgCyt90U1R2mU3FiqGZF8O5mP9SW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIY9rU7q; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-701b0b0be38so145029b3a.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 20:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719544233; x=1720149033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRAqCzJrRfu6LeRpymGALBIDW+CZkSunC+6/vOx3XWI=;
        b=bIY9rU7qcJdoJlF07Od0J4ZpPxti2akNM3K4iaKVwp8eXgE6sPC+Ve8oVYbN/QJvrY
         PWPnivN67W/uf0wmxV+BcoOwg/WYylL2xpF6KgBzLSYAVoEWjRxGpqChIdh87T/rXUKJ
         Tl89LpZQunlkIoSYa8Im3DZj9q3W453bJsImGIHMi4qmLehrY0fNxLpJK42AwPEFdT8D
         l+wSueP6rNZOoVsWbCC3PtP1W3zmJ2jvWW+pS1aXgu5rbc27mhWJBMh/Bvj627E3oZDU
         WAjqgSLOKo4TTzV6etbm740m1eI5mzCv8sUI3cngMa8mrCZXlB/5Z8oxkzdvkPAOb6Hv
         Vryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719544233; x=1720149033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRAqCzJrRfu6LeRpymGALBIDW+CZkSunC+6/vOx3XWI=;
        b=X8VEjz6713miRkdUuuoMO3FbYuunhOhaukcPzg6kRrVqjf6oW5aq9qobixzby9HCoI
         2sfqIL+aV3VQWnzsAHihH3GZOl/mijClJEHvyV4Ge1k1p6Fo8gnVKeZuDSsoyGwdsz7i
         LvVeAfT0l1lbDekUtEe37FyWKQ+5ZOm6xtSBClJ30mxW4C63Mc2uDxKR800cAcWHgf3R
         pMnl09qn8aDSY69GkSjB7jWBlAAWiVWS3tizeEAbtw0qtfxsmBB/xvDqGFGownuZXZX9
         pUJ4k62tkbHnGefvE39T5lAMZzH26/eSN1y1/xVjHcOT3esigiaZr+fKwoSfpyN+lbv/
         ikKg==
X-Forwarded-Encrypted: i=1; AJvYcCX1N4ooIhOXdZD8lbtNQH5LbfXtiXLRy23M2+8MAnCHWyy08jftebOAcbi23pykhe2pSSQwRIbU6OAFfuaR/lOZnN7PwZ7t
X-Gm-Message-State: AOJu0Yy/pqowd7SmOKz9k3bGbii0J+VUVTpEiwS8i7t8nTo3B6PVY+32
	H+cW7bb4ZNFDC2euag6NFx+twPgryyEiOSyXK2wK0XKhHsIkcDMR
X-Google-Smtp-Source: AGHT+IFTjEgNdisyE5vhQgaRG/9dAuawYzNheYQw7LkuCImTPgPGhoHUgbuw8O2tmVYvSlnsCtsC1A==
X-Received: by 2002:a05:6a20:841c:b0:1b7:733c:d11 with SMTP id adf61e73a8af0-1bcf7fcdbeamr20312501637.41.1719544233163;
        Thu, 27 Jun 2024 20:10:33 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:fd0:4f66:6e77:859a:643d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1569192sm4817645ad.214.2024.06.27.20.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 20:10:32 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:10:27 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Amit Cohen <amcohen@nvidia.com>
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
Message-ID: <Zn4po-wJoFat3CUd@Laptop-X1>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
 <20240626145355.5db060ad@kernel.org>
 <1429621.1719446760@famine>
 <Zn0iI3SPdRkmfnS1@Laptop-X1>
 <7e0a0866-8e3c-4abd-8e4f-ac61cc04a69e@blackwall.org>
 <Zn05dMVVlUmeypas@Laptop-X1>
 <89249184-41ac-42f6-b5af-4a46f9b28247@blackwall.org>
 <Zn1mXRRINDQDrIKw@Laptop-X1>
 <1467748.1719498250@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467748.1719498250@famine>

On Thu, Jun 27, 2024 at 07:24:10AM -0700, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> >Ah.. Yes, that's a sad fact :(
> 
> 	There are basically two paths that will change the LACP state
> that's passed up via netlink (the aggregator ID, and actor and partner
> oper port states): bond_3ad_state_machine_handler(), or incoming
> LACPDUs, which call into ad_rx_machine().  Administrative changes to the

Ah, thanks, I didn't notice this. I will also enable lacp notify
in ad_rx_machine().

> bond will do it too, like adding or removing interfaces, but those
> originate in user space and aren't happening asynchronously.
> 
> 	If you want (almost) absolute reliability in communicating every
> state change for the state machine and LACPDU processing, I think you'd
> have to (a) create an object with the changed state, (b) queue it
> somewhere, then (c) call a workqueue event to process that queue out of
> line.

Hmm... This looks too complex. If we store all the states. A frequent flashing
may consume the memory. If we made a limit for the queue, we may still loosing
some state changes.

I'm not sure which way is better.

> 
> >> It all depends on what are the requirements.
> >> 
> >> An uglier but lockless alternative would be to poll the slave's sysfs oper state,
> >> that doesn't require any locks and would be up-to-date.
> >
> >Hmm, that's a workaround, but the admin need to poll the state frequently as
> >they don't know when the state will change.
> >
> >Hi Jay, are you OK to add this sysfs in bonding?
> 
> 	I think what Nik is proposing is for your userspace to poll the
> /sys/class/net/${DEV}/operstate.

OK. There are 2 scenarios I got.

1) the local user want to get the local/partner state and make sure not
send pkts before they are in DISTRIBUTING state to avoid pkts drop, Or vice
versa. Only checking link operstate or up/down status is not enough.

2) the admin want to get the switch/partner status via LACP status incase
the switch is crashed.

Do you have any suggestion for the implementation?

Thanks
Hangbin

