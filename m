Return-Path: <netdev+bounces-107626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC31E91BBFB
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFAA1C21D74
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D54153519;
	Fri, 28 Jun 2024 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQq34SzR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55841487EB
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568543; cv=none; b=IL3r1ObIefjHWSASo+CIAFy3EFjUkdohcFVarR6Zik5nMnIUjRGUNnuH4VqbZcDS3w2EGDogqnZDqE/1iezspulyWXlNKzdpK86SXXX+npD758YnmSaGAIxHv6GcGgCCTxRjE+OLXQTk1awntwPLLTUq/PuAjv+NLBGndv/a5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568543; c=relaxed/simple;
	bh=nr40iIxImaxsg3z1MTE/IxSByGsFLtJpvI5+HedhVyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaVaLt4lv1ewJpSJhgKYiDHsvhzh0E6QKBM9q2yJoGvsiAAN9Ak2AilkWi/9suj/r1Lwx7ofL6iNSNRz//RZUaD5pUHnsO38KpAnq2/Ptcjf3WJoitGT5UOUkGuZg4s4j8GPFJRrkKaDAqQEgMTVOa0fJ1PrhoIN3aMuspSfZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQq34SzR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9c6e59d34so2395845ad.2
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719568541; x=1720173341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUA6E2y/f9m3oEg9cUUx1Y2aD6Rmlt8vUJRjGwRxO0U=;
        b=UQq34SzRKl5adSreSCTpiwPm2EiRm2+cWvGokIjYWCxE8oezNVibr+wRGbj3omTPVg
         8mnOpejE679xSRBEG9R6MNu9ni55SlwH3fGtno5xQ2dgfr22qAZNTW/J/PA4IXrVaMKj
         K7XeCUeY3/HmgjZUlep4lPQRVThv5t9pnaOrYRrpU0fTRTjLEZocvOFEsQgAyR0lv6Qs
         M8zkYCqp2KUYQ5Kq/A4vbS3pWlw0nRb//yNwgUiEAA0YoDyORdzmSocrCeQKxOFGfk53
         LjkQqgRZ0JNpVayo2LNnbNSGS7SdLa++W/NIOZOAisLonx/u2CSShLu49DEBCCDPfPJV
         UqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719568541; x=1720173341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUA6E2y/f9m3oEg9cUUx1Y2aD6Rmlt8vUJRjGwRxO0U=;
        b=CzT1d6gL1DhVlRe6rr2NlyTtRrXMfoTqc0YJMLdbUQL1uNWqBqmrMegYgDSxU6rT7D
         IVREWzNqKtlAZPeuyQc9XTu+tyMz0HVFOJfaS371zNcB0y5R7MSCMyhHzq2zQ1teU2Zd
         4f/XivtV5PPqc8CEl7vfXPLohuFZIVkwy2ixPuNgZ4t6ZhZbUMMPtRByzu1AUFKe8j/C
         /BkUG0qN8i+0AljZv19lT0j2Jq74qIkL4+mAwjlaIPVxdsG7+5n6TVJHm0l15AEyZtZe
         +qTR/KhVk96c6K77Yvtt8kuV0lGI8ly8egRr3RMvonwD7yMIJ/k97/OIilmtQr6esh1C
         m9Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXR8tZn3RHWQBrU68GuheeEO+rCfasMhoh3xnVEK8hu8HRX84sMBMuPf0NPfu61dbxLoHF2uVzKwQpoJUh52PrXysoazRvg
X-Gm-Message-State: AOJu0YxxLiMo/X8by7HaIq2cU1I5Z28sYU/PMHUHICENuUtvM2IV2Izw
	qjHF+Wef7uf5BUeOa2ssZ6I0KMbje7Ts4R/zL+/GXqU5Bktn15ZK
X-Google-Smtp-Source: AGHT+IHY4yTRP7nWM4gd8by3ODwSPAsJGNV7dUm0kTgJm+ZXABVEcPNkrLIBef3e2Ilj1jWU+fqPKA==
X-Received: by 2002:a17:902:ea11:b0:1f9:b697:b246 with SMTP id d9443c01a7336-1fa1d3de553mr198931195ad.5.1719568540876;
        Fri, 28 Jun 2024 02:55:40 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7825:fd0:4f66:6e77:859a:643d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1facea87cd7sm4230995ad.296.2024.06.28.02.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:55:40 -0700 (PDT)
Date: Fri, 28 Jun 2024 17:55:35 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Amit Cohen <amcohen@nvidia.com>
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
Message-ID: <Zn6Ily5OnRnQvcNo@Laptop-X1>
References: <1429621.1719446760@famine>
 <Zn0iI3SPdRkmfnS1@Laptop-X1>
 <7e0a0866-8e3c-4abd-8e4f-ac61cc04a69e@blackwall.org>
 <Zn05dMVVlUmeypas@Laptop-X1>
 <89249184-41ac-42f6-b5af-4a46f9b28247@blackwall.org>
 <Zn1mXRRINDQDrIKw@Laptop-X1>
 <1467748.1719498250@famine>
 <Zn4po-wJoFat3CUd@Laptop-X1>
 <efd0bf80-7269-42fc-a466-7ec0a9fd5aeb@blackwall.org>
 <8e978679-4145-445c-88ad-f98ffec6facb@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e978679-4145-445c-88ad-f98ffec6facb@blackwall.org>

Hi Nikolay,
On Fri, Jun 28, 2024 at 10:22:25AM +0300, Nikolay Aleksandrov wrote:
> > Actually I was talking about:
> >  /sys/class/net/<bond port>/bonding_slave/ad_actor_oper_port_state
> >  /sys/class/net/<bond port>/bonding_slave/ad_partner_oper_port_state
> > etc
> > 
> > Wouldn't these work for you?
> > 
> 
> But it gets much more complicated, I guess it will be easier to read the
> proc bond file with all the LACP information. That is under RCU only as
> well.

Good question. The monitor application want a more elegant/general way
to deal with the LACP state and do other network reconfigurations.
Here is the requirement I got from customer.

1) As a server administrator, I want ip monitor to show state change events
   related to LACP bonds so that I can react quickly to network reconfigurations.
2) As a network monitoring application developer, I want my application to be
   notified about LACP bond operational state changes without having to
   poll /proc/net/bonding/<bond> and parse its output so that it can trigger
   predefined failover remediation policies.
3) As a server administrator, I want my LACP bond monitoring application to
   receive a Netlink-based notification whenever the number of member
   interfaces is reduced so that the operations support system can provision
   a member interface replacement.

What I understand is the user/admin need to know the latest stable state so
they can do some other network configuration based on the status. Losing
a middle state notification during fast changes is acceptable.

> Well, you mentioned administrators want to see the state changes, please
> better clarify the exact end goal. Note that technically may even not be
> the last state as the state change itself happens in parallel (different
> locks) and any update could be delayed depending on rtnl availability
> and workqueue re-scheduling. But sure, they will get some update at some point. :)

Would you please help explain why we may not get the latest state? From what
I understand:

1) State A -> B, queue notify
       rtnl_trylock, fail, queue again
2) State B -> C, queue notify
      rtnl_trylock, success, post current state C
3) State C -> D, queue notify
      rtnl_trylock, fail, queue again
4) State D -> A, queue notify
      rtnl_trylock, fail, queue again
      rtnl_trylock, fail, queue again
      rtnl_trylock, success, post current state A

So how could the step 3) state send but step 4) state not send?

BTW, in my code, I should set the should_notify_lacp = 0 first before sending
ifinfo message. So that even the should_notify_lacp = 1 in ad_mux_machine()
is over written here, it still send the latest status.

> +
> +             if (slave->should_notify_lacp) {
> +                     slave->should_notify_lacp = 0;
> +                     rtmsg_ifinfo(RTM_NEWLINK, slave->dev, 0, GFP_KERNEL, 0, NULL);
> +             }

The side effect is that we may send 2 same latest lacp status(the
should_notify_lacp is over written to 1 and queue again), which should
be OK.

Thanks
Hangbin

