Return-Path: <netdev+bounces-138882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5719AF4A9
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70E3282929
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BDC1C7281;
	Thu, 24 Oct 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDHxTVMI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C818784C
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729805166; cv=none; b=MvRCz9aGemjVTZLA3SwmUiYf/0s359zwV6JZYutu4+eqp2+8vCmLMmzJ6RC2CvjLctGpn4zG/9OAs8UvxlTOFOiMaZn/pPHEbC5urp4BbCZ9+ivBM/9gE0P6j3htFWjSbV+62hDIIOCWQwvteO5DrKs7FJjlCKiox84wA68QMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729805166; c=relaxed/simple;
	bh=02Ju0hbej8lBOecyQ1HKOEDqHVq1YxKinn01v4+GzqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqyB2fHwqrq+61/EBjvbLS6QlYUZfAYvT8I6Xc6Akof6P5WYQunHYLzolgi/rPlaPdyJz1BBdEALZurKQSW9rtrpS6CiLrR+2rEnJrbzKJx4o6FY2oqsTjzm/B+A3dOpaMtWUhbyaU3+BJJNKWzDy7eUk7jnJ5OC3ImtTSoMerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDHxTVMI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so4452080a12.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729805162; x=1730409962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02Ju0hbej8lBOecyQ1HKOEDqHVq1YxKinn01v4+GzqI=;
        b=GDHxTVMIBptKhI9yKZw/Bfg5Fx02MY/iXZhW9/q0AqW9wbRccilzXpVQZy024hjehz
         rNv+lPcx+zng8CPfs2XGDb6e/2S3eVls5t5tAIuxCloUov50llIUkK3bZcw9KbyaLOiQ
         s4gbEr6hguxewW8gw066/GoUwa3oqu7dLA0sGtxcjWvPHw9vhs6/eTIvQEfYg1XNnBdN
         eiUCxtycdC44ALyXLOCtqQzvHLr3uNr1ZXQq16/GkZTx/7WbVyuJdg1rxvlW5ics/GOe
         YFPihwy2P038osboZU2SfGIpb5R6wnBOE+WzREQ/j71RNIxIvQQM9rqG6Ro+oYQkO2oS
         +a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729805162; x=1730409962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02Ju0hbej8lBOecyQ1HKOEDqHVq1YxKinn01v4+GzqI=;
        b=MJXNtkereth+TIdj1StScxcYk1A17VwhTVeEWWf/83ifsPInnuArrwNb9DWmiIlFzr
         uEB924v8AM6ddjRfI+KFP/RpInZd8zFMTU92sqk7JIvrv4llZiVvYjFHebTU4vHdZwV3
         WgzYza9i9WLQI8L1xQBvKonPNTe5V1kODFAOLLFQxMIQGFCMgF0cyzrPzMoci+Kzcmer
         4ZAi+CXWtbZd7lYJh2jOA2D4yogL2LQ254yzXr+/2KG3u/h2uRVWR7nepzAoizN/t2gs
         LNo8I30q9WDEcs+FCkuZwPJal59PsfVN12rY5URMPOy7nAruzZtO+L8WHL6waGWwu4Oz
         JCWg==
X-Forwarded-Encrypted: i=1; AJvYcCUf4Szvkrzv/s1yv4ZgEmd4/wnPUZWBVK7nKJhKAhj1IsnP9gLWIL+8cR1bldLsWjVQ9bs+Trk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtufSe+h9svUCC/KiGs1Vroyqe0VXk1kzrxTq5kkZDrZ3ETvx4
	erqgw/XDkXIdAKpKuTeoJ4W+xGRiLowUQc3xkMnTxmKEAzV+sAV1edkULI5AmwsKJSo+HIbm7ai
	ozH2N2DiC3eJH8rEth61o3A2EWgE40+XGZzA=
X-Google-Smtp-Source: AGHT+IFfCFQXeBsv2p/5d9ojwB91t4WR9gtYZwaOCbNsG7CQYeiFO3Qj0tYKAzRN4mE25bpGrrgWdECqRRJ29FadD/E=
X-Received: by 2002:a17:906:6a0f:b0:a9a:60b0:a8e7 with SMTP id
 a640c23a62f3a-a9ad199c2b9mr374829166b.2.1729805162304; Thu, 24 Oct 2024
 14:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-11-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-11-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:25:50 -0700
Message-ID: <CANDhNCo7rxFs8p_yq+vwt-zzOJS2ac=fbHaTF6ikhvOPLYzZLw@mail.gmail.com>
Subject: Re: [PATCH v2 11/25] timekeeping: Introduce tkd_basic_setup() to make
 lock and seqcount init reusable
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Initialization of lock and seqcount needs to be done for every instance o=
f
> timekeeper struct. To be able to easily reuse it, create a separate
> function for it.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

