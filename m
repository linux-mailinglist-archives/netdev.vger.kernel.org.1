Return-Path: <netdev+bounces-127539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E893975B50
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39590281305
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6E11BAEF0;
	Wed, 11 Sep 2024 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wh7OfAqK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C81B6520
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085200; cv=none; b=rgZNWnhisLVUEKqfL/TNr0gm0h0nORIz+g8rBVT0i+7GQRYe8Nbs0ANRsoHygm9g/DYh5RdkvQsdA5jVo8QBPfKI1s5QWCf7k3ZFgqZJcd6Uw26ttWnL96XaMTFM++Vva8EVgawglzXzjtoa4xbqzgyLk1WAZo/bLtKJJ2FFrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085200; c=relaxed/simple;
	bh=QpRlMhoE2wDragnqzLYjQ9/ef2ndvQ1GMahlogyOvkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbZWb8oUz3zPFoBFXspR8Un0Z0B9AhZrL2w/hIFkX7/mG8x/qakpjnGu/NWknNKubFOxI3KbJGN1LDS+tD7K+TAmw2QzMGtaXNlJVVvcwLIKVE4MoPCEE32RnH2neSueKq5rOuhQyAiCGDbIGtPgWdzGIUC+DPkJvQIEcDK60r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wh7OfAqK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a843bef98so30250566b.2
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726085197; x=1726689997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpRlMhoE2wDragnqzLYjQ9/ef2ndvQ1GMahlogyOvkE=;
        b=wh7OfAqK/weJiKFkUN13DToL9fg6+E1XvOjurEltrOW2rXpsJ6byFUI24DHsTR6oQr
         +9C2k/tqYD9oJTfEQ8sPrAl5d5vIx3nDe+r56AYl67ZBlxM1gJ21yXChlUZrjf9LN8ip
         pXTcOtG8h8YFTNiHDVDd/djlDpvhu+xoQmfkulbdxqj4jQbHJbDiD7jmdp0mIgjnNz0A
         +iHLS6cacl/D5QzlCGhlqm40k3kb9MZGNiO0UvdNmh5TACG97Xum8LyibQaIF8w5yWer
         Ho0Sjf42BPPd8lrYuHQY4I7/NbNw6fAqj7M7DrrDzR00K/V6PSp7mtyFHacG7SicxfO2
         3WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085197; x=1726689997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpRlMhoE2wDragnqzLYjQ9/ef2ndvQ1GMahlogyOvkE=;
        b=nFaKGrSToMd6rUaj0rtQHB+nLxoRL9g2t4NHh1KW2uX/NONGcXDzdPaTh5jP4LHtE9
         3nQDpBP6+yAWyU1NOcGPo38ctYJPvOzJ3WFe3a5rPZ71lhmiLTI6VSjZ8I4ZofvDPFvK
         nRBOPZUy1m9E/speFWYXq03WedTmbb2bGqIXFzGlXboI9jhMSUu7YSkii+M44srKYUIs
         LDM/HjHFmFRGhGcxgimi+aB9N7sIEwnaOU7wplnEt+iKBFFDAHXSq58IpHPwZUeXlIem
         SDaXN3BeItUt7ictt+JV8PH56eqljJ03uA84hT1Vce1ddwsg4PISFt16WeFq3jp+hHzz
         QzIg==
X-Forwarded-Encrypted: i=1; AJvYcCViybtrFIgQ+bdm5EQ05gRXFlqOnfuymMAEfJy5TnC5ad4gRFn/2ex5PIoj+vkIXkUKALOAksw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKt9avqq98NdNVJZKd0ZA4bwtupa2Ff5idcunsTexe8D6Mzik3
	pQJlq11aROoo8t47RjTYfpK28PRgC9PLZ50kYkgl6XuGARB/BY7GHj++qCGqgY/KUSSaTeQIl0g
	VvIJRtnUObZfd742kMw9ruk3ZaGiRuA0l4wzDDSODEfWf3L7OT5c=
X-Google-Smtp-Source: AGHT+IHmK290nFygp6EEmdgHjHHbcvRAsJmqrhscyOIv+qlRglD+XMLEZu7wBC5Z9BykbjmT8X0itqm6UXxPcC36azE=
X-Received: by 2002:a17:907:efdc:b0:a86:9041:a42a with SMTP id
 a640c23a62f3a-a902963a320mr54843166b.62.1726085196764; Wed, 11 Sep 2024
 13:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-1-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-1-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:06:25 -0700
Message-ID: <CANDhNCp38Zydv-6XBCfWp3gDUhdNVWB76_Asz+oBM3VUoE9JKg@mail.gmail.com>
Subject: Re: [PATCH 01/21] ntp: Remove unused tick_nsec
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:17=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> tick_nsec is only updated in the NTP core, but there are no users.
>
> Remove it.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Thanks for the cleanup!

It would be nice to point to when/why the users were removed, but from
some quick archeology I didn't find a single insightful change, just a
number of places realizing they weren't using their references to it
and dropping it bit by bit.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

