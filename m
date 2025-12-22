Return-Path: <netdev+bounces-245666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F4CD47B9
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 01:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12DBA300419B
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 00:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C14B1A9FAF;
	Mon, 22 Dec 2025 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YTqkmXwT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DC13B293
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766362684; cv=none; b=kLfm7+YraNT7uSwtCHfUfrsbZTBjyL21tX9Ct+2c9GC93QirMgQhK46UilI37YJYjEzkVF0H/cGMZ2m3ZzmdXOzdXqvHLImndt7sIquNU3Nl9HmjXMzPmVu/tBeXtXhSJn+veUTwCsMF6/UT9B8XdBGymXUYtRzE9Dqf39kbxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766362684; c=relaxed/simple;
	bh=RWqM6dEUARL94pjeMR8E0qm53/hUx6LHcDE2ByNHQkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lp7t+WJbnmF1r35M7BKIKpdXVP6PYmuz1mtSGrkha7rf5YEk5RGmkn8QBATzi/Agroe+HMdYn5kEJGu590gP6GZwayP5exBUVBBIb97wrm2LRHinQrYkn5UyG5nrJoABfqvBsF9cJqTLjS+Vw+SJQMTICL7pvGIuM4T6TqsbJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YTqkmXwT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-649e28dccadso5501668a12.3
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 16:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1766362680; x=1766967480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=byepX8xovUdjUXYl8PQ86I/am8y5adYz0GpOyQvNnYE=;
        b=YTqkmXwTea9HmD//0WakbJQLwhUbimr33wuh5utC80sD/ErhV4kBW9LHzbK2h4EUwW
         uL/3VPrid3juk1OgG4/UWv/nRkv0oEMBGJ9CHY2dSC3ZIbgrguTmjkcnJ5aqe05+kgkZ
         trAhRN0oeyHXKb8/3MWtSCcR4LX/tTPW9m7Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766362680; x=1766967480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byepX8xovUdjUXYl8PQ86I/am8y5adYz0GpOyQvNnYE=;
        b=Tdl1o1KFASmBJkazw/P8Vkqt3IZQJpHKtRe/1Y6qmgLMtJ6EZqpq0aLOBYcvjso2tU
         Kwe6zjORXRcCCp3SWHrSSbW78BbtHQgdl1bR73MEmA3AyOs+41zWHH5uMvzWuk7d30Y0
         /4AzF4ZkSH+1ak82tsNOgbrSnjJBalo1SzQSJVVlG+mzQRhh27nOPKIEQXP6x5W822I8
         8hEf8nfJk3hGZnVMOwdGJB5GKhhHy/nQPfn8Ciop6pkEv+UxZ1F0YP1Q73/qoM1mJFk0
         hLuEnqCIAqbhriuZIZ0k4p5BX+w8e97XLELT7sfR2/dE3VAhQsBbebWUxmXD+a9/Rszm
         r50Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpWKm4+3vIMxxWXnsIsNc6tHeqMdbgD2WirIfv/0KH72BN7VPS8hD4Hj1xdgZwN7KUp8AfVYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDSWjj/fZf6ICHRNG1UxwuRXno0QtiB7L8tamCBjPv+SNEtjm
	ku6Q8IkPud5O/CTYfBrEaWYKh8Ih23ENXiIrEnj+LAbQiSNABETmTRhS/5attUrPtd9SZnZ0ICl
	i5Ekqi5Q=
X-Gm-Gg: AY/fxX6dL3JKVAcUU/xcGrlL64GjpRy029piE13tSoakcY2Jry+r2zCYpSjQRKTk5yr
	mnv9tkEzPyOTUimOckKSEqq2GH1LhOBP53Go9j6YikD6TWQbRtjFY+H+lyKzlsfxmrebNepUZpH
	WN7V5Ykm2grnlK/syUKJH4Ep1hk7KhwBHlYx5F4o114owZr/azetmYsyuiRmIPoieGhrRf2Wf6u
	2Hhk93+m5ed7AwHA0tLr0T0iEAtMowXSNyYEAO89k12K6MKbdQ6scBWqI6rdT6kd+kYacwgqUep
	x9RaFir0n7/diUX0H3ntph09hNV6h2S/ZQdBaFq4tFnoGoyw4qiKOJsVOtUYl5qJY3y6CrVReEF
	gv7yS6vlYuqBvSiN/nw6Y6vyzEw2m48o7n6EaLVyLto9WwNzZBnurcFakM91bxADOo5LNPfeKeA
	IE/JN27H09gMXZ2c8yD5CbrVLo7G+fk3fUMgwNp+HqypFdJUyJntkMo7NI1IvNQO8DGgUsISk=
X-Google-Smtp-Source: AGHT+IG3C9QnvTRAM/1EVBuIicyDUPF2SMhpqorMsK8X9cJkMyoFMP5nm1A2Oih75En2SBdd6SnR8w==
X-Received: by 2002:a17:907:7eaa:b0:b73:885b:7554 with SMTP id a640c23a62f3a-b80371d5059mr998091166b.45.1766362680194;
        Sun, 21 Dec 2025 16:18:00 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0b7bcsm923117766b.49.2025.12.21.16.17.59
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 16:17:59 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b736d883ac4so617973066b.2
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 16:17:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUS75f2FF4OfyfBgRTw5I386tqOWCK3/Tpd51f7Vcuq7Yfi4aPGohJnMtuTPdzx+4DjWL6VBqs=@vger.kernel.org
X-Received: by 2002:a17:907:6d06:b0:b7a:368:8776 with SMTP id
 a640c23a62f3a-b8036f5a9b7mr965396866b.25.1766362678844; Sun, 21 Dec 2025
 16:17:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202234943.2312938-1-kuba@kernel.org>
In-Reply-To: <20251202234943.2312938-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Dec 2025 16:17:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgG=XFsHgMhgZpOM-M-PMa1cuz5=jExFv0KbajJ4JXN9w@mail.gmail.com>
X-Gm-Features: AQt7F2pnEIXd2mejIjQs5d5DcImJgrcbUdHXrJDHvfzpVw7HpQM9t2XUHWmkQbM
Message-ID: <CAHk-=wgG=XFsHgMhgZpOM-M-PMa1cuz5=jExFv0KbajJ4JXN9w@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for Linux 6.19
To: Jakub Kicinski <kuba@kernel.org>, Tim Hostetler <thostet@google.com>, 
	Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Dec 2025 at 15:49, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Tim Hostetler (5):
>       ptp: Return -EINVAL on ptp_clock_register if required ops are NULL

I didn't notice until now, but this seems to result in a warning for
me on my old threadripper system:

  info->n_alarm > PTP_MAX_ALARMS || (!info->gettimex64 &&
!info->gettime64) || !info->settime64
  WARNING: drivers/ptp/ptp_clock.c:327 at
ptp_clock_register+0x33/0x6e0, CPU#0: NetworkManager/2370
  Call Trace:
    iwl_mvm_ptp_init+0xe6/0x160 [iwlmvm]
   ...

and the reason I didn't notice earlier is that it has no other ill
effects outside of the big ugly warning in the kernel messages.

Looking at the iwlwifi driver, it looks like the reason is that it
doesn't have a 'settime' operation, only an 'adjtime' one.

I can't tell whether it's the iwlwifi driver that should be fixed, or
whether that ptp warning condition is just bad. So I'm sending this to
the usual suspects, and hope somebody more competent can make that
judgement call.

                Linus

