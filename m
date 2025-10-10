Return-Path: <netdev+bounces-228547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E95ABCDEBD
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 18:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342AB5405B9
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 16:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A4C2FBDF4;
	Fri, 10 Oct 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXnSbxtH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C22FBDEF
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760112567; cv=none; b=MGLHDGBSb4zoT6ghMYNmcWOwcN4HWwfLUGlfRh7D8t0GGFNTNOh3ZcpeW2DBbrwneuey+W2xjraFiD+slRfdG76zB1AQVJGA8l5hejxsh5Hzuw4seNAlDp8HimkrgMTjF/e8jSKdYCh+xRhRJbV8THyJwvi5I9H4atP77nCPkeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760112567; c=relaxed/simple;
	bh=dUAeS7yBEEUpdZCGYWU4GjkvgMKwT400c1scQYXOmu4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LqBpA8BQ82DZEUtGsNewRumxfkP4h0bmY+w47t3oMV41oWzBTDB0yCsNAQSS8h7MJtlJf9cpKojhxhArcPQN6+jr0RwT2Fe+86a/NtoigDdK/H+zwpT06AOZBDY6BI4FFVE2jzPs4PFVncipboaOXBLr+pQi+IPCeOPxweo5DtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXnSbxtH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27c369f898fso29307895ad.3
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760112565; x=1760717365; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUAeS7yBEEUpdZCGYWU4GjkvgMKwT400c1scQYXOmu4=;
        b=ZXnSbxtHX3vbly1eok8TXzd91rr9rrRDQsD+QL/kiAilppk/eDxNYmCSLD3HmxvtVa
         VBSw3eMwn3+uo4OtyJehuir8S1+wf+qJtw+S0MQ9K4+ORMWMemQPJQU9mejHHmJF1enQ
         gPpFFj1kTVSrnhff+R4p4Xs116zsC6oKyzfJUhgMrBH6tem0G2kVlVHuv/rHb7aHxbC6
         /W6q36WTO7mIoboXq7qYKowwh2qBloWawU4DLFSpfp6FRugQPrJCWN3lILTezC+B4+jA
         by6MKNlakMZ39rvioOALkYosKR3n+HCR6F5FdupNCIA70gfkRBPh+I4MbREQE+ra6p9f
         dUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760112565; x=1760717365;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dUAeS7yBEEUpdZCGYWU4GjkvgMKwT400c1scQYXOmu4=;
        b=Xp3IozHZLJ2aBcD9tjiqRHNViAUSjmSo0KnP2Nz+Nad+GHdhx0EtnGhkr1K9GUsQnn
         p2ntxx3RmJkyM6eHgoH2k+S6uTfsXl1U5QXGV2CwYJPfwAXxNbrAZ53o9Z/kwTqFIcM+
         gVic4kXMqFklsYGF8G+Izp7E+SwleS8+LdV7KKC4TkWpQoaS7bdr0mB5Rc95ux5/eCnl
         +tt4oVD5guwNoEnyAVe/5G4pXZlUhLCT4+dAYyBVaAFIYKKRxwV7jTkpZCCIbYVI+hsB
         5mS5vPRiYcXWYsVgYR5ctS2wvgvX29BQ/bTayiDxyHf0C6bjpz+OLqrK6ZCJTO2+xWD0
         iRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF3IezRT6c4jo5QWxDEQMa8C4DdCa9UjH8NSRAF9yLd5xjA9h2PjBdqmuYsijTeJHeTzZLkBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFy/U3UdmQw1yCv1U9mo7+ILLJubX/L7sdUSlaVnNl4/9J9TE
	vtKT4UCjTuHtdSxX+W+9dlgmHK32mXYiqfz9xmdPf5bI1XVRGyuW8dxO
X-Gm-Gg: ASbGnctYgtTyulHPr2RLrAxC1ywWWIuRW+Wt3JSTsMg4IBHD9AO/ivvSwiuh4zuTFSQ
	QGbSorANvdq2ttqVVXG0NpaPYHkI6fHZ71ivMF7IwVm3EJsU3YCjnw9fLAkKVO/WvMYa35jlzDz
	rx0mxY6sWxf5e9DoufA2nPiXCyjMX0BhWGMMqcS7UsSDvrmJGM9UzZlfgi2qIoHyC8toVhJkDC7
	lRXgYZ3f/CmA+pLLhOm1vJDzwBxRMfq3ExeIT7s+dLnJO1SB1emseSQnTnzB5E+5vFISbuHRl7L
	tOI8tVSwOmyNtgwOvkXZx68jxCiKe07STbpB4jeJASUkkg4KNXudfRzNxMTvJXEf+BcIIPKN5UK
	+pooMJbYnCD6R8uzdDxSiMvCuTWd46lSlzOad7+HSzuaxFV6c
X-Google-Smtp-Source: AGHT+IH+Bl3n6xNhazOXQB/JNZbXQU7MgQx2mZf+w+x6ONuirr3C9IMHxepRFQ/oxDWw/d8XL0TVFw==
X-Received: by 2002:a17:903:1984:b0:26a:8171:dafa with SMTP id d9443c01a7336-2902723fc6bmr169811785ad.21.1760112565141;
        Fri, 10 Oct 2025 09:09:25 -0700 (PDT)
Received: from localhost ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm61079905ad.48.2025.10.10.09.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 09:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Oct 2025 01:09:21 +0900
Message-Id: <DDERTVVZ8Z1Q.QZXNA7INPVQ4@gmail.com>
Subject: Re: [PATCH net v2] net: dlink: handle dma_map_single() failure
 properly
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20251009155715.1576-2-yyyynoom@gmail.com>
 <20251010065515.GA3115768@horms.kernel.org>
In-Reply-To: <20251010065515.GA3115768@horms.kernel.org>

On Fri Oct 10, 2025 at 3:55 PM KST, Simon Horman wrote:
> On Fri, Oct 10, 2025 at 12:57:16AM +0900, Yeounsu Moon wrote:
>> There is no error handling for `dma_map_single()` failures.
>>=20
>> Add error handling by checking `dma_mapping_error()` and freeing
>> the `skb` using `dev_kfree_skb()` (process context) when it fails.
>>=20
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
>> Tested-on: D-Link DGE-550T Rev-A3
>> Suggested-by: Simon Horman <horms@kernel.org>
>
> FWIIW, I don't think my Suggested-by tag is strictly necessary here. I di=
d
> suggest an implementation approach. And I'm very happy that you took my
> idea on board. But I'd view as more of a tweak in this case. Because the
> overall meaning of the patch remains the same as your original version.
>
Thank you for letting me know,
>> ---
>> Changelog:
>> v2:
>> - fix one thing properly
>> - use goto statement, per Simon's suggestion
>> v1: https://lore.kernel.org/netdev/20251002152638.1165-1-yyyynoom@gmail.=
com/
>
> Thanks for the update, this version looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
And I really appreciate your review.

