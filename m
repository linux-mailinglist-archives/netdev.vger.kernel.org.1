Return-Path: <netdev+bounces-236852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852D0C40BF7
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 17:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DC3566EB3
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CDD28C5DE;
	Fri,  7 Nov 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbWNVCh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7925291B
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531468; cv=none; b=BeMG3kvKVY4+eUzOmAFMc079lN2Zv0sNOZnCYp0kPBCOdKNwxFJZDsT1v+3123QrJjf4560UEKCqkisOj8L7RLeSqHTvIT2AQKCymG8I1P9iayg65jgYsedG/xz3NldaXyFLzNTXLOUbbWzenPXl3+n8wxBF44Mx8bweuYhUAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531468; c=relaxed/simple;
	bh=xuH/Gs9ceCRxwjHeY5Pde+rCzIIpWzsNhw8y8vlXS90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNEfN+YD3mIRvbQrMQn5AzfieOTrqWqte07U3Jq+bV/3vvroZDHO6xLklTNzioiKhPTBupOUqjhQNipsdlZDYcSv0b4hFzuf9SolHAryijnZRW18LIEWqpRDWPWI+a9ZokcJQbQfJPE0m93SqBUWB4L8KqCnPH54Mein/XUfMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbWNVCh6; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-4330ef18d8aso7241155ab.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 08:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531466; x=1763136266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuH/Gs9ceCRxwjHeY5Pde+rCzIIpWzsNhw8y8vlXS90=;
        b=BbWNVCh6SQeCMfv9OIjKLU69yFwwqXy9dblJhzuqlA+XsL7GspvlAc5lRy+9PNKKHw
         NisazOs/8WFxlSktKa6Mx6rPswvsoYevU0/+KBE8dzatN6BKcWx3M2/DcMPj0LHo8JKE
         AAJN8R4gNhv3rlbZ1q7DKjmjHdKOG2H+QVX+nP7+mXtjzaME319LdmxcEykMppO/Ggmx
         qOeljooi8QrnDPEx5ap04QKmQdMIIqVWDdgyLDaldRJGaxwk9YHwFR292ze2q4xooQRX
         t9WuLKl+ueed/nBYPVxbuRzX1tbst1TkTlFMydlbgyoot1MQtTQzoFueh1AdFpn/UTNv
         ZwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531466; x=1763136266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuH/Gs9ceCRxwjHeY5Pde+rCzIIpWzsNhw8y8vlXS90=;
        b=YW/0zGj5/gf3ZMZfV5DxBTCVTlu+3Ib5OQsqGI7E0ZT79Kfyd1H5cbzZAQosiVXfvz
         suITTA0Rb4yyNVzJF9NRoZYQg9s/kYezxY6tx3vuABvL9OflgfojZBxX9rIRa0DKlPhr
         GfAJwHp5hSPfANpIoRHXKrvnqgkuu2Ahgxdi2gfHZEODGPjhwwZ7AFj8vEXY2KGxQ3pN
         /RGaWTHoREegXK4P1hSHD6PO9/9FSfyjEdFYtAWEPXqfNYRwS9Vt6YM6bC8h4XHeHlKs
         BTO7u6yv0Fu26w4C6UPVdwRKnkb22s8aa1hlYfHEEzgXFdAVz6Sq4KMEIqONXTbZptCG
         LzSA==
X-Forwarded-Encrypted: i=1; AJvYcCWjznDTYJHXjCxwmhrK7Ok7s+js05OCyUPoiJMvdbcP4EFW6m9xrpBLBcT2R5SMgp655S88cco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIvnEoRZhz+hilPZQGElmIxIEVFKCFc3AqeKrVLpF0TjL8LdHs
	gLm4Di/zgfeOvXx/1pPlorvQdjsqeMhVMgNV+BTMo/OuRMEZT3bIig6g/+huIoIODMmA6OHe1Ll
	poipX3+Gs6a+T+U7rhk7/jSa0ONczO8U=
X-Gm-Gg: ASbGncu3AVu8KwQQQgbVFhe11YsABguIVg3QnXeCMnjX9W2fYpi9QBoSYB9JeEf/5xD
	lqkQlBpkMUuO8fTHBwNFZtlhPZeYoPRxOuuV9HfLIPdhga5oFuEr6QsDBPQ75BpRnk+uwcf910n
	BPhnRSA8NMMG5BetjBGghld3u58gzPFjfZbe4xgSgIBk2SLJza2a6aCnq9CmxaeEwENnX108Mwz
	P4vqiv2XCLDnNkpIJzioeTGvpZ4sTCVYZ71Cw09Uy31TGVzYwycyp2Brdkuyf9RLjvxhU1sSw0=
X-Google-Smtp-Source: AGHT+IEIvIpUkmWvOy3jJnVPepX0plWjymPuF8DRlrXs+Tq8y3TtjSFLJcU+JsSbh0/pzwDn7nxqE9p4eJhA0PU97s0=
X-Received: by 2002:a05:6e02:156d:b0:433:2cc0:f852 with SMTP id
 e9e14a558f8ab-4335f45be3emr46442195ab.26.1762531466151; Fri, 07 Nov 2025
 08:04:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-4-edumazet@google.com>
 <CAL+tcoBEEjO=-yvE7ZJ4sB2smVBzUht1gJN85CenJhOKV2nD7Q@mail.gmail.com>
 <CANn89i+fN=Qda_J52dEZGtXbD-hwtVdTQmQGhNW_m_Ys-JFJSA@mail.gmail.com>
 <CAL+tcoBGSvdoHUO6JD2ggxx3zUY=Mgms+wKSp3GkLN-pLO3=RA@mail.gmail.com> <CANn89iJcWc+Qi7xVcsnLOA1q9qjtqZLL5W4YQg=SND3tX=sLgw@mail.gmail.com>
In-Reply-To: <CANn89iJcWc+Qi7xVcsnLOA1q9qjtqZLL5W4YQg=SND3tX=sLgw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 8 Nov 2025 00:03:50 +0800
X-Gm-Features: AWmQ_bn0oYBShbSAG28HpRj_asu7OA5ejCsnZxCPg2uWrbmQNTpWO7NCZhTqEuM
Message-ID: <CAL+tcoCmpzJ_z4DCvcoWok2LrR9vL2An8j3zi5XHOjiSity3jg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: increase skb_defer_max default to 128
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 12:00=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Nov 7, 2025 at 7:50=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Fri, Nov 7, 2025 at 11:47=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Fri, Nov 7, 2025 at 7:37=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > > >
> > > > On Fri, Nov 7, 2025 at 4:30=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > > >
> > > > > skb_defer_max value is very conservative, and can be increased
> > > > > to avoid too many calls to kick_defer_list_purge().
> > > > >
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > >
> > > > I was thinking if we ought to enlarge NAPI_SKB_CACHE_SIZE() to 128 =
as
> > > > well since the freeing skb happens in the softirq context, which I
> > > > came up with when I was doing the optimization for af_xdp. That is
> > > > also used to defer freeing skb to obtain some improvement in
> > > > performance. I'd like to know your opinion on this, thanks in advan=
ce!
> > >
> > > Makes sense. I even had a patch like this in my queue ;)
> >
> > Great to hear that. Look forward to seeing it soon :)
>
> Oh please go ahead !

Okay, thanks for letting me post this minor change. I just thought you
wanted to do this on your own :P

Will do it soon :)

Thanks,
Jason

