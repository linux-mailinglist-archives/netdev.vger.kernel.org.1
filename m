Return-Path: <netdev+bounces-131499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E60398EAE1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294E7B234B2
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0DC130A7D;
	Thu,  3 Oct 2024 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOUu0PXv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACCA53363
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942183; cv=none; b=uVirh5SnJKI9WBCl8/SFj2SwH0EMe4anqLaQqoTooS0GJ+S8TRwSd+5x/fZpZU6i1mgJW1xG0d1tAUoV6oZ/e6jFd1H9PhP91xTZp7hr0Fo3hYX87odMBT1CL01VyV+TY9KjBtlBoEE82KLrNUaEI3W5VgXhT6uP8yknMtzalTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942183; c=relaxed/simple;
	bh=v6ALvc4W24Stl4DcbfKSXH2YeE+6bGWlnQQLPePuZlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZgnSwBGtbMO4i6wJDHQaTaMou9aKG3s63NosQX3xrDeJEBKZ2odmz5yHa3CWGX5PxSt6plbXf/LHzVaTdpcCgN3B/Jf61HpM803zNIdVlc9Noor2iU31PAh39PsdGb8Pe3edsLtRwg8I6W68OUcM+OrJmMxS4tBRdWVIJiFhs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOUu0PXv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso650660a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 00:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727942178; x=1728546978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKyDwfp4Ml344QHsxkGSl5FGwY5UjFoy6Vbspzij4AE=;
        b=HOUu0PXvRUlRwG6A3NrFVfEIIqo6NrHkKLYNeqH2kXA8v0EZii/r5T8AOgJB2qcEli
         VUKchgLrjjSwUbiol/VZiWAFb6gKtSfgIXJboK/kzGdNW0lV9ZiClUp8DBlcR62cLy89
         dgkpvr1UM1xbhNPW7DfOTnUTQyIholapiKhfjiYljAX6W5+HskqrvaKUhUQdZHmv0AZ8
         29ZlsUk5RzANWOeBwPfapPv2T8UWzvWti2YSd3qZhJRBSNSsBDrs2kKtoxDPy/21UP15
         wHJxwo6L3S9bmurt/6oei4n5ztEDqY6hkUzdhn8vQjQemrgc+9KSTmyYxB4g9XOiveeA
         5a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727942178; x=1728546978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKyDwfp4Ml344QHsxkGSl5FGwY5UjFoy6Vbspzij4AE=;
        b=G76sv1r/k+n0tLvTZnSvugG1Yk6DEmComBRUGDaWtXbvtG4BP9vQqEEQwI77lQczqY
         o7b3NCW+gatgKpkCbQfP3wHXP3TnHSGBI56GQ8d9rXDg5jawb3jEwwidKOe01m0BV9c+
         7aMH1KTbkAFU2q+82nB+AGE347+a4yFsGaAHsezIm8tGjnVAn4RZLMCdXubtD+Z3DIcE
         qn0DjmY08nbCyhTkL67mlLy5opDpYFISh+NK4okPUK9Bp01QIFlb/u1NnM4MYFVJEUey
         iuKMCium26HcmIGj+p3z7wCJs7+ZvABnmRsTVcycuZC/moOEBZTFRVJaAm4BcGXmVf66
         UL3g==
X-Forwarded-Encrypted: i=1; AJvYcCW3xV2SCPGTqRWGwSAnlmIFNZQltg2VhTZznmKgEKAV3DiOqDiyvFDx59b/NltdgrrtGMtNB6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmzuaj2EpJNnYjvf/NYR+d07OjhvOck+SD/s2VUOt5bsnaOv5
	LcuA/ATIpZE+xGNvpvy2hU+qhvLHnlfk0IgL6CkN2dK2DyOPZXq1HjoRDKv+3hK1J7dqJyUMYlB
	dkuW+eHP2fqXuhVUWqrvtQSUKIRG4BXszco3F
X-Google-Smtp-Source: AGHT+IE1lXB/OQzfjadu4gqLsX6vwMaut6bPbMqb3wk8B2SU/Xr68rxVVKC73SYNSrAzyFVbSIuwVtACV3a0DRjhV8w=
X-Received: by 2002:a05:6402:5255:b0:5c8:ad38:165c with SMTP id
 4fb4d7f45d1cf-5c8b1b77ac0mr3450082a12.23.1727942177451; Thu, 03 Oct 2024
 00:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002053844.130553-1-danielyangkang@gmail.com>
 <CANn89i+y77-1skcxeq+OAeOVBDXhgZb75yZCq8+NBpHtZGySmw@mail.gmail.com>
 <ff22de41-07a5-4d16-9453-183b0c6a2872@iogearbox.net> <CAGiJo8TaC70QNAtFCziRUAzN1hH9zjnMAuMMToAts0yFcRqPWw@mail.gmail.com>
In-Reply-To: <CAGiJo8TaC70QNAtFCziRUAzN1hH9zjnMAuMMToAts0yFcRqPWw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Oct 2024 09:56:03 +0200
Message-ID: <CANn89iK7W1CeQS-VZqakArdZqZY6UQi2kCDcpUmL4dGjAQwbCw@mail.gmail.com>
Subject: Re: [PATCH] Fix KMSAN infoleak, initialize unused data in pskb_expand_head
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 6:42=E2=80=AFAM Daniel Yang <danielyangkang@gmail.co=
m> wrote:
>
> I took a look at https://www.spinics.net/lists/netdev/msg982652.html
> and am a little confused since the patch adds a check instead of
> initializing the memory segment.
> Is the general assumption that any packet with uninitialized memory is
> ill formed and we need to drop? Also is there any documentation for
> internal macros/function calls for BPF because I was trying to look
> and couldn't find any.

Callers wanting allocated memory to be cleared use __GFP_ZERO
If we were forcing  __GFP_ZERO all the time, network performance would
be reduced by 30% at least.

You are working around the real bug, just to silence a useful warning.

As I explained earlier, the real bug is that some layers think the
ethernet header (14 bytes) is present in the packet.

Providing 14 zero bytes (instead of random bytes) would still be a bug.

The real fix is to drop malicious packets when they are too small, like a N=
IC.

