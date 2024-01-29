Return-Path: <netdev+bounces-66798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D93840B25
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F96C288818
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B4E155A5F;
	Mon, 29 Jan 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEEGIQlm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9A5155A58
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545135; cv=none; b=CWtUY5xMKiHEo42Re3S7RhjOFN5jQT+uibY8tIWim7t24nSvF6oib/TjRXBTO5TgMEfAhmr/vuMLnetSaKtr2DrKe2Y+1Cf/SPG/lOHiHRvAaK/YUCCBJev7l6ZDn0iT6wMpdexVExycTzkfu8VZ73n6xiH2nkXMizGFvA2b0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545135; c=relaxed/simple;
	bh=Nc7mApj5cmFrobKcXKrtziDlCDWDsNZ/CXJlIwQ8reM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVklK+xEcgp7gbOu2IK87/v0Xv1GZ04dYRGx2V/bbRg2JS+G7u96n0BYAPYXp2InXP2YOL2sqWveIX1kmp1KSN9qBcS5piUMcgEQnOd40+/3hpWHvDepLl7YwvvgovQHhlkPvEzrFbzY4taDAIY+kwvR1f9m6HQUKI9yAuGORJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEEGIQlm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a271a28aeb4so342736066b.2
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706545132; x=1707149932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jO8ftAtFbbWmlUaRWi3riz3XRi9wttWk4/W50kBdcZM=;
        b=MEEGIQlm4xLzIXDx0/kYR1MgIDZFDO22ApYDoaPec6i9s1A4WeEm0hVY3yFH6uPGZQ
         Aq7dolnDk6XcXPUpC3OF9z1I/oEgQDTStdR6BOW4GPazbZQDeKNl9ayMAYGDqtMW8RNq
         Om3dFtIQ9PJ3PkoKh18svEnqUtH+DKKexw0+8gpBTwHKoSg6NNtriOpWCXlSSV6d5Bao
         T55K9yRf0JdscqpZCc6YfEpQsAJErunjO51x66VLCVaAgKpCgxpKSXoP9IjiVAbxrZ/M
         4WPlQKOeOdkNfSINx2ws3Qufz20DsShpPlE+LsezO1FKkRyiQyq4IzaRCfRaULIjOYeH
         FQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706545132; x=1707149932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO8ftAtFbbWmlUaRWi3riz3XRi9wttWk4/W50kBdcZM=;
        b=U1XlpvcndS8utffA9PeVBSUfLBGM7PKn03wF53fxhFM6U7sQGpjrx2ALlCAV4RXxah
         Bckk6+rvk18uFkYQwIxcFAzOZAGdICbM4BL3hMBoxWHiz7NGBAadOwSqBTcvdcbYwaUH
         9MD9ooUa+eHmAd75ETqv3vNxdbNuX6t0a0ZzEC3ryySU301pY92czSkqlfOGisse2Sia
         0IFiPbyU/SsVYZ2MeYCqHIN0SrVJJI5qQgwIHHQyRmei8YJTQ/KXGMvQtJCeDgkgmdZZ
         uc+ISSURP/jS5gFfvJLNNEU7yA3mhEUNUs9Lg6Qa11UslCPhcWmoYxLGzXeZ1dc6nNzV
         7Z5g==
X-Gm-Message-State: AOJu0Yw4sEpKkj56dnLWBWn1IopXfK7ENS2xvBPVktP6c6FAMiMmzv7m
	RtVM4txy39Fyn03z3RY5xfFQVZYBj6x1AR92/5xDgBCp7IGWsCoq
X-Google-Smtp-Source: AGHT+IE4bjo2HCbJaNM077/KuimGg8PplpVvaD6c3jmVbP3E8rL/3MSPhGmNmsiMAhB5NhQKIYV36w==
X-Received: by 2002:a17:906:c343:b0:a30:d336:d7b6 with SMTP id ci3-20020a170906c34300b00a30d336d7b6mr4886060ejb.57.1706545131597;
        Mon, 29 Jan 2024 08:18:51 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id u13-20020a1709060b0d00b00a35df307713sm692349ejg.161.2024.01.29.08.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:18:51 -0800 (PST)
Date: Mon, 29 Jan 2024 18:18:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 05/11] net: dsa: realtek: common rtl83xx
 module
Message-ID: <20240129161849.rcmtduo4ineg434g@skbuf>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-6-luizluca@gmail.com>
 <20240125104524.vfkoztu4kcabxdlc@skbuf>
 <CAJq09z5TE_VSGmyWdNfb+o7ymg2qsfGhjky-AXY+Pv5_0V7RLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z5TE_VSGmyWdNfb+o7ymg2qsfGhjky-AXY+Pv5_0V7RLw@mail.gmail.com>

On Sun, Jan 28, 2024 at 09:09:38PM -0300, Luiz Angelo Daros de Luca wrote:
> > Not "any context", but "sleepable context". You cannot acquire a mutex
> > in atomic context. Actually this applies across the board in this patch
> > set. The entry points into DSA also take mutex_lock(&dsa2_mutex), so
> > this also applies to its callers' context.
> 
> Yes. I'll update all kdocs that might use a lock. I guess just the
> unlock that is actually "any context".

Well, the unlock has to have the lock acquired....

> > > + * rtl83xx_remove() - Cleanup a realtek switch driver
> > > + * @ctx: realtek_priv pointer
> >
> > s/ctx/priv/
> 
> I was missing some kernel warnings with too much debug output (V=s1c).

If it builds cleanly patch by patch with W=1 C=1 you should be good.

