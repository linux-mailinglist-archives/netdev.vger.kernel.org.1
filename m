Return-Path: <netdev+bounces-218864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E309B3EE24
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0972A487DF6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97921FAC42;
	Mon,  1 Sep 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iDoQGkvS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9FF1C6FE5
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752940; cv=none; b=dZ5RJnEn7epKtvA4/yEekVZJE3ooUCyuSdD6xYr1XYt0Ta+gfRKdO+lC1ZZEPauGVpir1aTcaLPBflNmPhdkmFzzhS3rAh8XZqryjjtogJm5DqT3lvqh9yj4v4Xu9Cpdt00R8Tx7+S1CZbq//yQYg2xAaGOdliTvUfBtPtGYZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752940; c=relaxed/simple;
	bh=OOpdK/BuS5ONqqQvbDiuwzdMkwFbeDOcxFYw6KNv5Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOgPHqo/Li++y/4nEIYH72tI8Og/8qStEIL6KpcDTB8dpHtBketAVb0+/0jiSDtdlVSgdHc2QRmZriJVO1kjb5PYI6yL+MLA12A8BzBAdgvL/SJdDEXq2waybfMd7DZMxaT/2wnpDYwAUuqwHzZ2d6x4YMqAbMqXL2DeOXkzRPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iDoQGkvS; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7fac0a7d2b1so428265485a.3
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 11:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756752938; x=1757357738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/lwow3zQU9YplnuyLevRq41/lMRinlPBzXWjmfgn14=;
        b=iDoQGkvShND0eCTHLmAIg6z50Q+U2WflD9fhsOdLS1iojyfmuQlYAqIehRQ+2qP4G6
         UgxA43mYoWEifcflpiGz54PiR07hgLzZPcfIh5T6ZnZe0QvsAF+aKQu9bkiRXccU0VZA
         Qw6kyePSLId+JKJvH+UxryT53DtmvIn3PR3SrVCVj+DHqfCbbZ73dGQ5fWwWxVgw0Asr
         VhYfY3QoI25LwTVwRvX2ss7QPcpTOlW7/m7DVaWto/BibKm5k5naPR4nS+eTx+F+Klhh
         PktQmtdUAyXc7cVXyMmueNS5e6QHpS81SBg2KaV/Lo41mM2OsNhCR7PSIz8ntP5I4SUC
         by8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756752938; x=1757357738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/lwow3zQU9YplnuyLevRq41/lMRinlPBzXWjmfgn14=;
        b=onwH27TuPabDy5/QYKInPbpbiqPvmn0BND9gvGHnQRGJQ+l3jHua9aOAtGUUgnubNC
         WUrAseDPpy/tNjjxRCziMmpRxI1TSDYwGFs2GCqSshFbhFhxYe1WPC5T9OuQJT+CV8gh
         PrB3KlUYUxa940br/jrrntLqiE/t1ah6FS0T0KdrDXp/jG+LSAOkp2sX4JHwEJWlzS3N
         wvpoyuQhqzlDg5pLj8r6apqF4gdYqvwye7ZgjrDBRrjKM7QslQOJ2YN+f/vAK5BJtLYO
         FJMXeQePMZIjz1DcBT0LCLav3yF4ZF8uJZeBb8ZLcykvnPv4UL0GxwOiyu/5NDww7yPN
         htQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7DfPdECOb4O3pQTwH4gj4iR6cQZpuJ0ZpuJnK4LDuJcJX4GcPkRKv2MFpUrJtmlQccvFiZvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdENEMtV0Vf3BDCh2mCVx8EhTtQn+wKk7fsYN/9I/aPvqkdlB
	3yMfLk7LOwnS6QHkwfcHZcYQZxz5hQTwjFpxkh9NMCM1o7DB3fpdPd+RrSNj8ZnehcHKZWd9+1Q
	Mhd9MrGyUNMeS+fjLmBksRReXsaHveQZ7pfBcOKtV
X-Gm-Gg: ASbGncsv6slC7UpdeBitRVwRl/hPR9OUjUrPsQIdBwVB3x9qob8PQdyY48iXJo/2tmp
	91GG02OI4Xebrdi+ZSzgu3gkk59+EjcDgAHbbBzzcvGAnyr7wtt+7Y5QfQ/u8tq25M4qOGIfANq
	JAhT+YTWotBNOtE7IsqjzzsySwgGz70R4lnZHdIuBTNf2XXkj1EGHKQKjySrTla4RLwPqOALsmA
	9R6lRv9H3VWGOb1rs8kWnWQ
X-Google-Smtp-Source: AGHT+IHEfYzfBDvd9C55JrqTxMQCponhzrNfDPJZ+Bt+doFe5QpIHfR8TOO059ENiVppafzZnsRoZz38mhu5gxg4gq8=
X-Received: by 2002:a05:620a:4709:b0:7f9:2cf8:bda0 with SMTP id
 af79cd13be357-7ff2c14477fmr1052152685a.65.1756752937613; Mon, 01 Sep 2025
 11:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901181623.5571-1-ouster@cs.stanford.edu> <20250901114444.37c53a6a@kernel.org>
In-Reply-To: <20250901114444.37c53a6a@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Sep 2025 11:55:26 -0700
X-Gm-Features: Ac12FXzBoeSttJFpiAcugh64Cpd5EOclhe5HZo7Xhcntn99TN8rsQwPknxg4mCw
Message-ID: <CANn89i+r6ogvutW1+C7ZDhEYKZN7WU=OVONpgnoX4EgYX=BF4A@mail.gmail.com>
Subject: Re: [PATCH] net: export symnbol for skb_attempt_defer_free
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  1 Sep 2025 11:16:23 -0700 John Ousterhout wrote:
> > This function is useful for modules such as Homa but is not
> > currently visible.
>
> It has to be part of the series which contains an in tree user.
> We only export symbols for in-tree modules.

Also if homa does not have yet GRO support, I doubt
skb_attempt_defer_free() is a big win.

