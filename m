Return-Path: <netdev+bounces-138881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615779AF4A7
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928281C21F3D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE32F1C7B7E;
	Thu, 24 Oct 2024 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyzD6QB2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976F1FF04A
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804915; cv=none; b=mGDgmYlrs6+i+09Suc3JoJtm4zzacp3sRyzXPToAdUZ6MqlPhoneRd6uMiI7Rb2xho1efDZIaOeSTfiIEiiSVwH2kTfq+xqKwEBftu74drbK3E+tYz5LD4/rBhaEmzF3wbr4qTl3NHMrBMPaOxV6j2WkltmOjQBNqPCPK0AWfgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804915; c=relaxed/simple;
	bh=/WQoSvHqnv2AaCKBN87rg4+23CxO/Hlfj72utA8xuSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bw1lXIc9E2SefU+YzMHqOc8Hv0OqE1eTIyLk4t+82xHxoZICqSm7lP84jpk4ZZg0B6ivZNW+YXXVmsvvtr7JlBdGhX3k7iUOQwnGqjqOw8w5oiHh5aXMpDWg4LwPSfFfMmQH4hKgg6sPR7HZL+0C27PI28IrHsiJwYZelVZ+TcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyzD6QB2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so1759399a12.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729804912; x=1730409712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WQoSvHqnv2AaCKBN87rg4+23CxO/Hlfj72utA8xuSo=;
        b=PyzD6QB2XjAmFyGPn0fkTwJj5qVthe3+yHJ4A+7UjUQ1MNJnDlEhT3Z3WyLaOUywmF
         WDXuPVMayZ8YMqWH4fazLR4dAu3cTmBpo1VFNp7y9sD9IljAE8oxHln1JtZfp6SuMnRK
         Svc+aWRiyZKSLbPoNV+Hsg8PrV+pk3Y9rZsPhCpD72RFKAy6tjNlZXSmTVIV7tdR752q
         bSQ0PksnWERMapeTO9sD8TLbLT8T9pFo0W6bf46gS9Hwb+2DAhPHJ6DG8Ok3rk+6zxiX
         FF9boSJVJ1dihQbaQJyUFhuxJm+93GXlnS3nzKqU8hFlFkWA1673dR8Yga5Uf3opGAKg
         QYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729804912; x=1730409712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WQoSvHqnv2AaCKBN87rg4+23CxO/Hlfj72utA8xuSo=;
        b=ZUvytu0U2ss+eGDWRugajvLt2QD/s8+gnM2SkChK1WHLAT9XsagVos7KiJCudLPRFy
         s6oJStZCUupHa0U4y5i9Og2UXtgACmXdS94WLIH5kvaqeeVdUTbiiLLCg4gzmkI38NTl
         MW29W9J/IqAk5hZsHEBjcAmTAlYBcverz8Yurzj7VfOyXtjXxqk0sZSR5v4WeC91nln2
         TJGkIw93IfxeSqTnbaqJsNR29i5iyYVT4Zx2ibB7Fy9I85gMuNnfpi9vaw9dx8yYEq7Y
         I0EvUnatBxiNCcOxr6dQ9UKVG9tZ7Dzaz8DdPViRz6rN+pUM4+pSq+3v8sAbiu/HfceK
         IADw==
X-Forwarded-Encrypted: i=1; AJvYcCUP+MjyWZoW5PwKPnPLDvF9oaOS+KKWn5NgJAWAFwWtkDCgsyszU6MxYqJvgZkCSIbnwD+wdFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhiZlWi3sRj1tQDExj6YfTJRfJUR1y3KtDZcghuicNdsEobnx
	8jLZZZmK37AXRGDWxyYN3VsnIK0sEGn6fM9MX9lOWxCQKcFDadbGqk+NVssVDLDI5rsamSFUznR
	Hw4HtFFWKfgb6hxm31VZyK8I/Dntp6vdXi8s=
X-Google-Smtp-Source: AGHT+IHtgEhxn5BA5sOxWnweacFsVWNQnKA/wvWAjKL8OCa05dpvvIHMQnAIiP14sjO06mtJlY6sA8ggvhC//ltBKcI=
X-Received: by 2002:a17:907:7f14:b0:a9a:cee1:3cf3 with SMTP id
 a640c23a62f3a-a9ad285ee91mr326044566b.53.1729804911718; Thu, 24 Oct 2024
 14:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-10-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-10-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:21:40 -0700
Message-ID: <CANDhNCox-M6J9f-hak2CEBqG8PRM=ht34cfTRQ7O5VnCU=Jryw@mail.gmail.com>
Subject: Re: [PATCH v2 10/25] timekeeping: Define a struct type for tk_core to
 make it reusable
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
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> The struct tk_core uses is not reusable. As long as there is only a singl=
e
> timekeeper, this is not a problem. But when the timekeeper infrastructure
> will be reused for per ptp clock timekeepers, an explicit struct type is
> required.
>
> Define struct tk_data as explicit struct type for tk_core.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

