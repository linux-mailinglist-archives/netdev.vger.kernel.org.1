Return-Path: <netdev+bounces-123320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB99964847
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185F81F2187C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903E81AD9E9;
	Thu, 29 Aug 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWoH5i0u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD5C1A76C1
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941685; cv=none; b=Z5ZqLAD4lYL+2q9EVVfZ8wgjrSLCqdRAuYcEnDr4dLF87KcRHZE1K3+gM8hN/bv7Ru4x9pBdoSunMgN8pcNG1yqdSbCW4oaVqgnqb4rXAVSesgLEcWtRKnTvbPrRjfoRInw7GgdLabo4dVELB68os5C2i8pzipGaDXssATayC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941685; c=relaxed/simple;
	bh=lcKELKr8totNm0cUxFM2hX35N4EWGx/nhbP2H3tcdfY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nokmBXnCkESiWit0DX+OGk0/YJQAZAWIqeDAAvyn3PU0+4XKVHJEuiRZvT9Q8RDe1jxxp+Cyc7ZDDKm9+xKmNCcnSKBc5PZZk7Cg5/ib+eoCht89kLcMV+t7cqPc3Vlp0qw6h2+i0Ecu9J4ar/lQyxTwnfFzo4Vpj2fuiMyT/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWoH5i0u; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d984ed52so45596085a.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724941683; x=1725546483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxopms5H26lccB7XS2Iv+r2Lk+fonFl21eb/XjH2878=;
        b=kWoH5i0ubIQkaJmlArmwmdfGafWUvsHc+52eqJl7m7JOQofrerpPyKNhTAZvMSXv1d
         ldglOWfWjxOXg1Alx2lFWh44s13ZdLKtki/EGt3rmsCxnGrfjw7iRJ3p1ykuSEjbvFZR
         j+xOEcpJ4Odw0Nrz0qf2KQIl1QHdfXqwYa26ah8W/lmadNITfX5pG5a6lELzVyWq472N
         iElkmxeafHuLo0uQouXhSnwoUo1XH3bDMKZVRka/rSOJw9NYmZ5wQupBb/1xw3/Uvzuk
         p/rXSyIfITKFGrgQQA/CjU6I5iFCQbNg7noYKFOec7KWlbAxSUbXTB23FNdZf/4YvQQz
         8+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941683; x=1725546483;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wxopms5H26lccB7XS2Iv+r2Lk+fonFl21eb/XjH2878=;
        b=UpU43NpSFfugtFdM7Jd4s58M5f+Gnv5fCkILqZ9wdYHW9BGbUDbAEetkVY4Y4aJPBM
         wcowszQ9SPPOFgpYdjiioudEEJZNGGoiiptdH4sbGyibb+fpfQJXBYoURE0h8ryqovaJ
         O3o5N7Wt4zQGvmYfLu/VprVWtTgxJgtlu7SLoP5xkFb2+rosJpj43VfX2Ic3RH+PwjAn
         fKPGcO9Zhbrzxozq0kSXUP4kdR+poeQkyKE0DdvbBpztL9LgGngJA5YOJ3dyK9Up18JR
         IZOx7ztRfueUaB8Gg/66gLaWzruLk+Hmy0cechn6Sc0rhkSOKvharfDBllkAX/ZZCu1e
         1y3g==
X-Gm-Message-State: AOJu0Yzsa8wf7w4qREpM10LmwzxtoOcG+eJMEvTBM0g5IWh3tm5lNzlf
	XykCbtUEzTw2QcbgRfvjxJnw2abkqlZ0f7r9obA7uOZGA1weeOFG
X-Google-Smtp-Source: AGHT+IEqGuHpMvWwGKSuP8WHSMwaoC0yT3JZTKxiz97Qs5i5EnB4/ViF8MGiWTW2TBIQcQR+GoVL3A==
X-Received: by 2002:a05:620a:4511:b0:7a1:df6f:4374 with SMTP id af79cd13be357-7a8041ad994mr302243285a.16.1724941676014;
        Thu, 29 Aug 2024 07:27:56 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340dafffdsm5440436d6.140.2024.08.29.07.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:27:55 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:27:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Vadim Fedorenko <vadfed@meta.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Message-ID: <66d0856b4234a_38c94929436@willemb.c.googlers.com.notmuch>
In-Reply-To: <dfe033f1-cc61-4be3-a59d-e6b623591cc6@linux.dev>
References: <20240829000355.1172094-1-vadfed@meta.com>
 <66d0783ca3dc4_3895fa2946a@willemb.c.googlers.com.notmuch>
 <dfe033f1-cc61-4be3-a59d-e6b623591cc6@linux.dev>
Subject: Re: [RFC PATCH] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in
 control message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> On 29/08/2024 14:31, Willem de Bruijn wrote:
> > Vadim Fedorenko wrote:
> >> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> >> timestamps
> > 
> > +1 on the feature. Few minor points only.
> > 
> > Not a hard requirement, but would be nice if there was a test,
> > e.g., as a tools/testing/../txtimestamp.c extension.
> 
> Sure, I'll add some tests in the next version.
> 
> 
> >> and packets sent via socket. Unfortunately, there is no way
> >> to reliably predict socket timestamp ID value in case of error returned
> >> by sendmsg [1].
> > 
> > Might be good to copy more context from the discussion to explain why
> > reliable OPT_ID is infeasible. For UDP, it is as simple as lockless
> > transmit. For RAW, things like MSG_MORE come into play.
> 
> Ok, I'll add it, thanks!
> 
> >> This patch adds new control message type to give user-space
> >> software an opportunity to control the mapping between packets and
> >> values by providing ID with each sendmsg. This works fine for UDP
> >> sockets only, and explicit check is added to control message parser.
> >> Also, there is no easy way to use 0 as provided ID, so this is value
> >> treated as invalid.
> > 
> > This is because the code branches on non-zero value in the cookie,
> > else uses ts_key. Please make this explicit. Or perhaps better, add a
> > bit in the cookie so that the full 32-bit space can be used.
> 
> Adding a bit in the cookie is not enough, I have to add another flag to
> inet_cork. And we are running out of space for tx flags, 
> inet_cork::tx_flags is u8 and we have only 1 bit left for SKBTX* enum.
> Do you think it's OK to use this last bit for OPT_ID feature?

No, that space is particularly constrained in skb_shinfo.

Either a separate bit in inet_cork, or just keep as is.
 

