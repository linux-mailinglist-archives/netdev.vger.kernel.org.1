Return-Path: <netdev+bounces-174994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E41A61F64
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 22:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2076217312E
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 21:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F81F204C3F;
	Fri, 14 Mar 2025 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="QiFjnhyk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754B19049B
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988680; cv=none; b=nEVrXyngHQWIHcPo2jykQwedMLIUDyvJUKGsE49S95FuYGxiqw5YNt9j/W21rebjo2GycTR14zINDqU/6hW4wArafA55eEqMsUyQmFHbZTFx+nZi9S04xR96c7GjXRyAqQyDpAqyTCYC8xWrcdTPmU7DrxibGWf9FFz0Pk0GqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988680; c=relaxed/simple;
	bh=vfncAfddjIcNiQo8ie81bODzjNZjL66lZljd6RJcJBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqoOJq6VDoqLkSqGGK0EilpjCJ0QCEPG0Jwaxk67GgZjoSkzPtb/XITHmL3cLQOtRl+Nrp8cMVyLGy2+3Tf2DhN73JCVXobdXWVh8zi7GwmsVYtSw0JE/rgf6FgAPOdXoTuabjxoAusBhO8xCeyDp/qMI2JfGuwtyM85pPzpd1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=QiFjnhyk; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so3055295e87.0
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1741988675; x=1742593475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygJ0H2vxATGxkU1M58pqnJ01OJulJY0qCIFHyH4kGoc=;
        b=QiFjnhykMld5xiCWfCALlB3OfAYorrYYO/UN4EhO9dKKWrmcEXM8uURHxSRWDkqkRm
         eMuXTdsD0SiU0rFlbg8Fm94uqoXkK1+mmXDPUgr+DEZKHAOntAEvrc7342eEZzVN64ju
         Whud/Cgnyi5YNbfXAPPjzTUTeQULKPpK9vWxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988675; x=1742593475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygJ0H2vxATGxkU1M58pqnJ01OJulJY0qCIFHyH4kGoc=;
        b=lKQvaZeutKcsfvILqUgMYgL0yMF/zbXvAWDyuApTjC4enAF18BWguJ9lnO2xFqFmdX
         TpAk9p7qZbV8KahlBS797b4PCwB9j7DNxoDMtB5KpDh0u/lO35M2TiLiaJQHWOtNUOMD
         tw6aFpFp9NeizHoJIs2zZ1Mv1zcSB7bK4M/Xeg9HmCK3xKI336Ab3Xd7IwQnEHr8/uOH
         eMNbWmY0XlvPMtXtE8uQqLh88W6tf/MBXVN5UbPkptsaa1TipuB7H0HzLnTl0us2v4xY
         ajZhdeMNhL1U3IFUMsb/VMaG1cDykn+EvpT53pXPpXXf2wBOa+BtOYs7HPz+YCctJEoM
         GGdA==
X-Forwarded-Encrypted: i=1; AJvYcCU4J1CcCg1/jDN8Dl6X7P28yGhLPQItyIrB170V4GgbvVBU5j0ilOR3uUFqP58UwFUj4+xE7OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXzSYK3PvcLZmYmjtgYWCUSTuSjNiq1Wx3/W22QgNtTCLcSvCv
	O42220ryjuKbZ0oCSrl8UPnbhJ0raJyOGPoS8Xf0sATCXJxeBT/pJBQ+w4634EN//M/98qEDJZb
	XhzOmn3K7dfrjGANKWvuRY1tZZqWKJZoylpQEXw==
X-Gm-Gg: ASbGncuzATLKK3Blkm+GZxQG9gMHpQQ/kjbpxCf9NdFvrWNrlmOTT284k3Ozw4eq7Zj
	h6qUmTikeUrxZ1ROjfw2CvqZpMQs5JvmTXfrWS8Om3HolcTbvv4PqPwqrRuMzPe9eaMrEUQmI9j
	zXbLZTyWEyEv9j2NwGGRYXfjKm7GY=
X-Google-Smtp-Source: AGHT+IEWnBhSIPLhooGWGB0QxRqKLPoxClk0plnFc0aU0hQcJNEEZNrsXc81K8BgPOFalpv3pmHZB9T+v3qJh5b2Kao=
X-Received: by 2002:a05:6512:1148:b0:549:7394:2ce5 with SMTP id
 2adb3069b0e04-549c3989a46mr1481063e87.41.1741988675047; Fri, 14 Mar 2025
 14:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com> <20250314195257.34854-1-kuniyu@amazon.com>
In-Reply-To: <20250314195257.34854-1-kuniyu@amazon.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 14 Mar 2025 22:44:24 +0100
X-Gm-Features: AQ5f1JpjBGfpOP5zNlKX7GO_VCD0NDNoLpNnm489_7MjjqdnEeHOwR7BjyJB7Lk
Message-ID: <CAJqdLrqJska=kCcq7WUEPFnttHfvB_xaN12MDEkc0MQzgMVZ8g@mail.gmail.com>
Subject: Re: [PATCH net-next] tools headers: Sync uapi/asm-generic/socket.h
 with the kernel sources
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aleksandr.mikhalitsyn@canonical.com, annaemesenyiri@gmail.com, 
	edumazet@google.com, kerneljasonxing@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	vadim.fedorenko@linux.dev, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Fr., 14. M=C3=A4rz 2025 um 20:53 Uhr schrieb Kuniyuki Iwashima
<kuniyu@amazon.com>:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Date: Sun,  9 Mar 2025 13:15:24 +0100
> > This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.
> >
> > Accidentally found while working on another patchset.
> >
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Jason Xing <kerneljasonxing@gmail.com>
> > Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
> > Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>

Dear Kuniyuki,

Thanks for looking into this!

>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> It seems the patch is marked as Changes Requested on patchwork.
> Also, I think this is net.git material than net-next.
>
> So, could you repost to net.git ?

Have done:
https://lore.kernel.org/netdev/20250314214155.16046-1-aleksandr.mikhalitsyn=
@canonical.com/

Kind regards,
Alex
>
> Thanks!
>
>

