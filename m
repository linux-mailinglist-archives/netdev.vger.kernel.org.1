Return-Path: <netdev+bounces-234575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492C5C238DD
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 08:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49673A7A53
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 07:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D47329C5B;
	Fri, 31 Oct 2025 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSV9TCqI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC622F60A3
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895940; cv=none; b=qArPePyP47gRUMr519HkrSH8pJ3SGbV3psIouqu8rekJvjFSzafF0wx8rdG0iqLwvmNyxI9s1JZB2Uzo0HNF7JmsijrOkiLjl28qKWJ6D4fCal4nMy6W/zzE1h5k2A6bmhiRy098nJm/dACBTwCqVQe1gfGQuToi+2tUkG1son0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895940; c=relaxed/simple;
	bh=BMrQhc78/tWbKmAlQyS3CQRZfigmg1PQWr4K/DHEl3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ax+jQOdn6ucw7z1s8PVvXpkNfnX5EmFVD4/wgcou2YtWWvEt9nffk6It3dGIxLH53f2K6fBVBQr9IWPJLf2S40uOBcK32NZN278W+wXx6fjK/jhz0SBAbrtezQxqve4FXF1LSKOi7y4YFFVstapWY6npQzeibrHp3xPcMrXmooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSV9TCqI; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7829fc3b7deso20140477b3.3
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 00:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761895937; x=1762500737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMrQhc78/tWbKmAlQyS3CQRZfigmg1PQWr4K/DHEl3A=;
        b=nSV9TCqI+lLKZqb9Rlc8zZedS4htr3Zm6tW/f0p1+r3ewf8ntrsFhdQxWP4himYHmI
         UbHgMSjGkCWF4KRG5NLg1U2vcjbOqrgbAj13sVLFmBqYx7FDsWMLOlDNtab/jIpMwqRE
         jdjLLwF/5S9YZ1T5PPbnYPqhqO3x07RBHNFWLsPZtYpco0EXMMIhxXRN+Tz6LR9BWd4O
         pzUCZUoh7VmvVziXpQffGUNW7A3qlvhd3TYyJaxb8m9qEtwUbWZCONJS+moIXjeo5SwC
         XVFGYns02/O8S4cR/aP74C7xtNrd5MrOQTBBTAx/R8rybznKgmxigHOCsEtG6ehFdvkq
         84IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761895937; x=1762500737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMrQhc78/tWbKmAlQyS3CQRZfigmg1PQWr4K/DHEl3A=;
        b=TYi8qk1uqT+GqNMsCYoMPXfKIYg13VSZwpAE0eI14QGGO0IKWK6VB7ia74pQ6WVl62
         SUiWknRn2lyndehMEETrhi2mi6Nsd+pRndNQk1gRfjFmgLtfalzao5KMQn2jZFqAKyuJ
         /BAP+GDP5EznC1DqsSrpvEy01Jl+Ku+JImqLlAk8spLlG5UW1o2wHplX+9ua+xmOvVIy
         4XPvzWRt3pnUfn+ofBmKig3Q9due4st16zos6lVGfbdCumv7m0vJ1CxSH0dWWjWccVap
         3lHHJBbCwoA1Cs5aJ3a3QKBmNXbxkeo8L/kpEj5JvHMYoSbc8a/NvTBYYug8/uMIsT/W
         OSXg==
X-Forwarded-Encrypted: i=1; AJvYcCW536y7jM5blJKWCtRtp9nIv/fVhXZC68UclXdIRF5S5F+DMUTwwoITOVtAcDRsf9FQ64gA3xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUxtoNtEQ0M5InZjP12vwQiaNATOBhkjQFWrQg62qz7QpTANsM
	G8+Jy8jUwA/hCtzciXdnMvwyUVdLXOiBaSPTFjXSvI58PNAxCx1HcTI+olxuU8Eb7k//2oUUZDd
	peH+tYZjfYKkLKiGAIdvrIX0ZORqV14o=
X-Gm-Gg: ASbGncuT4/VGTZJKqdt9OwZebuMjRlvC0Ljen145qLLHG0R/n6PAI0kO53mo4p7w3oT
	HBVNnLzEn6xhT94eDrjN3hDtpvlz39JusKbyZVi9fa2gpZWoTvvxeW2HbnoDCk/krED6rkv7mbG
	0NUfw9lwQwDLNxW6FCQ/P7tAGFtr11NyXB3sNI9B4cP/tE7n6S3IPwqUJ6ZIaVi6Odl0oXes9Cf
	9SwBctz7Vf3S2yzdmmYuO7EtzAbkHu9lPFxvOdnVMG2/Lkl4IaOA13nkyOccIAUYrJJrAt5AXs9
	v4wRWDVcWJg=
X-Google-Smtp-Source: AGHT+IHJQTA3KNqKyYFQiTmzgxAa+tjK8r9Su/bQ2kHLfDXiO0jTTvMOB4R2M/5y1O7Kk/f5k2x5Z4CMKas681wgGyM=
X-Received: by 2002:a05:690c:fc8:b0:781:7ee:10b5 with SMTP id
 00721157ae682-786483e8ac9mr22021267b3.5.1761895937576; Fri, 31 Oct 2025
 00:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030064736.24061-1-dqfext@gmail.com> <CAKYAXd9nkQFgXPpKpOY+O_B5HRLeyiZKO5a4X5MdfjYoO_O+Aw@mail.gmail.com>
In-Reply-To: <CAKYAXd9nkQFgXPpKpOY+O_B5HRLeyiZKO5a4X5MdfjYoO_O+Aw@mail.gmail.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 31 Oct 2025 15:32:06 +0800
X-Gm-Features: AWmQ_bn7BSFll8h75cmXBIOIlKgqr5WL20vu8LJPrTdeOFLYt0KTtgFQaVW8jBU
Message-ID: <CALW65jZQzTMv1HMB3R9cSACebVagtUsMM9iiL8zkTGmethfcPg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: server: avoid busy polling in accept loop
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Ronnie Sahlberg <lsahlber@redhat.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namjae,

On Thu, Oct 30, 2025 at 4:11=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
> > Fixes: 0626e6641f6b ("cifsd: add server handler for central processing =
and tranport layers")
> > Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> Applied it to #ksmbd-for-next-next.
> Thanks!

I just found that this depends on another commit which is not in
kernel versions earlier than v6.1:
a7c01fa93aeb ("signal: break out of wait loops on kthread_stop()")

With the current Fixes tag, this commit will be backported to v5.15
automatically. But without said commit, kthread_stop() cannot wake up
a blocking kernel_accept().
Should I change the Fixes tag, or inform linux-stable not to backport
this patch to v5.15?

+Cc: Jason, Sasha, and GregKH

Regards,
Qingfang

