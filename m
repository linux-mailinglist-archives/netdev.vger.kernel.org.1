Return-Path: <netdev+bounces-239427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA61C6838A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEED24E1FC5
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDE730B509;
	Tue, 18 Nov 2025 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyvR0XUC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2A2877D7
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454764; cv=none; b=c2fkLqRrL6p5LjPJhP5afjztGJCsAATAZbA1EpKCGUwJiRtQSNR3vrvpJL+6QAPdtRs1atLCNidD3g1U7afIDr3aDBkvUkH7HjrPeZqr44U48NjLGp9ACqu4ipMW6dLM2ORBptvaNE5Po6GuvvT86vftImg8cuE9IednRykjwL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454764; c=relaxed/simple;
	bh=1mHnmcWp6rRYR3G3tcyAvpSy0GNVWG/OY1byeJrOIpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaYgDDsO1Nn0ODkFZ4q8VoPBUNKWE8Tlx1XjP7GNgFKAlxVYs41l3No+ylaT4TsxdVJad9tUAmF76r39sCXD1KE5ygKst17ufpq7zmo9pk/EH9t4wKd/YbUc7EGVYIaKOVBSLA7D/F4B4SSCd/U+LjADla+O4EsZyo45DCSM26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eyvR0XUC; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee0084fd98so26719161cf.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763454762; x=1764059562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mHnmcWp6rRYR3G3tcyAvpSy0GNVWG/OY1byeJrOIpc=;
        b=eyvR0XUCgOCX4VZdWZ2fZDRKNLeJpyJ8UIo3+saaOqHVt5U+bTlBeBBNTeA6UaMEve
         d462+RQYFvuUcAMv46m1LYEiHAXqTuZVWeiwqE/czZzjw0/GMlT0cNsmlCUixJGg937X
         cpDV+ImOeGzvb5XhWeaS0dlKGTf8q9qjfkSzSAYXjx0TSiyb6NgMNKSUSzez3TsjXmMZ
         Bmt3WkuMvjE1le+jqzbocufsrR+WTHwUW0obZ/f8evvZ9y2BWGBku3aKwYNIy0MoDNCa
         20/LJ3aGd+KhB4XwdzKGsBxAXP/+HaRh1apiALOxSNCRronNkxQxPLE600l7rDXEfvWX
         Q+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763454762; x=1764059562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1mHnmcWp6rRYR3G3tcyAvpSy0GNVWG/OY1byeJrOIpc=;
        b=Q2ZUdSN566r7ng3JXRIYeCk26r+eSxBkQXvrz4mISRI9N28xm6BuOjgPemTc5aJp2U
         B0JCxv8do4OlN+2ERf+OBOeM/psHmE4I3iId0ctGg13Z/34nJkmofZKLGpXDKd6j/E5t
         urgOb96Q9F3XbTwuDKzR98Rz1FsE266JbFnpL++rNFLo7sxeM8nWtAmkx2eHoydiDr63
         uNCHyJU+U4lvDgkM9/a85viOgxgbZxm0Myph7yfbqChVzvtS5SuIpw8Ha+XIij4Q7ffy
         Uj1OHX5J8RHi34WnUfOK2dF/Kp21SpojU5s5itLNZxNT5JEZEkGuL4CFM3eiAxbohco2
         ajjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0i7/yyLFh/AF7G8CXOUkrbBDyHuCtLeTkOf+wW3H0AnXU/pGqkSC0cBtSMJ2izTpgiZPTBfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5iIAsjE20tKE9vYgz1ziNjdCQipF8x14s7E+cPAYc7ztW9A6R
	lMGzo+qCLKup0ti77hsSu/aJu40bupYFuyDxYCyAjp76SO7pytO+CrriUKVL+t0/kwmouZMNqQ2
	tkBG5BNx9B1RK3ttNxux699qqPkifdj1RhI9MIVLl
X-Gm-Gg: ASbGncvWRGwkHJ9+Kz2zegxMhJ/i/WbGlNAl//SbNu7YUpWQeQx5m3R/Hc6nd1CF0ZW
	NaFB+lF4mZL+IjZcY1tlRhSdrfNBabJcgYQOAUz0dNDK0R4wbt7uu8xxdp1YatScUzglOQobDFr
	57tJ4QMux0m/yq/Xaiqg/oe+LDSOPfDziG5/SaYLsa5g+uATESJWUBmYyZEnDXuforcbc1wTYkF
	kVFo9PO7m2CAc2VDDxTsR0ZW/L6XGWGep3J5UzctBgYXdIlPTVm/ksPa0GJnW0Uyyz7ytCD
X-Google-Smtp-Source: AGHT+IH3YNDL98ZyOMCnH0umCySpaC1iKuhIFz4H8v4cGiIqTxSXm7i2+3kC3iyVZkOdsa6a6+pyR8W4aPBbhxb4DEg=
X-Received: by 2002:a05:622a:1805:b0:4ee:1b53:ca70 with SMTP id
 d75a77b69052e-4ee1b53ceddmr93808481cf.23.1763454761198; Tue, 18 Nov 2025
 00:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-4-edumazet@google.com>
 <CAL+tcoD3-qtq4Kcmo9eb4mw6bdSYCCjxzNB3qov5LDYoe_gtkw@mail.gmail.com>
 <CAL+tcoBpUg=ggf6nQpYeZyAcMbXobuJtyUdN98G1HpcuUqFZ+w@mail.gmail.com>
 <CANn89iJb8hLw7Mx1+Td_BK7gGm5guRaUe6zdhqRqtfdw_0gLzA@mail.gmail.com>
 <CAL+tcoBeEXmyugUrqxct9VuYrSErVDA61nZ1Y62w8-NSwgdxjw@mail.gmail.com>
 <CANn89iJec+7ssKpAp0Um5pNecfzxohRJBKQybSYS=e-9pQjqag@mail.gmail.com>
 <CAL+tcoAJR3Du1ZsJC5KU=pNB7G9FP+qYVe8314GXu8xv7-PC3g@mail.gmail.com> <CAL+tcoC8v9QpTxRJWA17ciu=sB-RAZJ_eWNZZTVFYwUXEQHtbA@mail.gmail.com>
In-Reply-To: <CAL+tcoC8v9QpTxRJWA17ciu=sB-RAZJ_eWNZZTVFYwUXEQHtbA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Nov 2025 00:32:29 -0800
X-Gm-Features: AWmQ_bm_95_kJKbrIoqmjbeOBf355zw3JuGb821BLcMYZE4A8YYl8T5Qc0aUKaE
Message-ID: <CANn89iLhd2Y0Htwx_kO7RixXPrPviBngZxngeMgN5n2zBTNG-w@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/3] net: use napi_skb_cache even in process context
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 6:07=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Nov 17, 2025 at 10:31=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > On Mon, Nov 17, 2025 at 5:48=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >

> >
> > >
> > > We can add a static key to enable/disable the behaviors that are most
> > > suited to a particular workload.
> >
> > Are we going to introduce a new knob to control this snippet in
> > napi_consume_skb()?
>
> That's it. For single flow in xsk scenarios, adding something like a
> static key to avoid 1) using napi_skb_cache_get() in this patch, 2)
> deferring free in commit [3] can contribute to a higher performance
> back to more than 1,900,000 pps. I have no clue if adding a new sysctl
> is acceptable.

I will add one as soon as this series is merged.

