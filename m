Return-Path: <netdev+bounces-75312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5345B869192
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B8DB2C192
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F913B783;
	Tue, 27 Feb 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLKrpY/A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1B13B2B1
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039764; cv=none; b=Xsk6S8s2h7Y2f3huZHV8nB65cfr/F97KlR0kebuj+6zZBJSwyveb2+6X9qoZJFJXZg7BgfIvzmgZxdp3nWl/7BQtrsT8LDiIL0d4AVDEiN7lMs3avwy9+Rx8zA7x6votFigTtxTytJR7OClfzvbLGZkAWV254IZk7OCyV29ANP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039764; c=relaxed/simple;
	bh=8w6yJF1pf4+K6HFovn6W+rqsOmD2i17OUax9f7eXWyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YY5PtU1MSsiDYHhuPNBZWJReQK5TSxpsHoT5JRO6VFpfubJZ/tPu0RfU/xsXzG7OqvvIwfqn0RiVdcewGv4+keDFwI7qx6n3fjMDsU/dUxJUwLyavcweFW2kylKO5/4NnBxWODPFHRB7Hb5nCkntRKPE0dkD+Qr6bRxCXG1i4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLKrpY/A; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5664e580cb7so1879a12.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 05:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709039761; x=1709644561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w6yJF1pf4+K6HFovn6W+rqsOmD2i17OUax9f7eXWyk=;
        b=vLKrpY/A4zfOmqzSoINzuw+iWIWRwy2h/ojgvl2E665yZQIcnqoDD7ipZ6KhHMLwe3
         5Jikn4mOq/o+DtX59Mi1aWqkH9qHQLMr0b2RH6X0s9irAe88HUL2NAhOdOf4OG8wn1j8
         ygFcqqkcy0sd6eiC+oylqTKdAcKY6bGQsRoe2d/Rm816dkImEkLY1eTGVX1q2Yx6OZLt
         GZXz4iBpBaq5nu0dNY5fCZjclsCcN0B7xnYFXoPLbw2QIcCwoQOaUQ+ZIn+PjnoqvfaR
         RcntMirsxu2+Jb5lRb09CFS8t0ORdFUrV/9v38acVU/cW14IKh1zZb4ZFE4XZdOR6z0g
         Kf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039761; x=1709644561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w6yJF1pf4+K6HFovn6W+rqsOmD2i17OUax9f7eXWyk=;
        b=FiJfW5IRasDqkU9QZL7vbXL9zxoQp1wlLqSljOtyiaM40IbZ8EUK+gAPxWA4hZDZve
         mEEeUYvCxYcuHdr14WPVKoPL6YS18F/M5/RstW15fHA6Q7mn25Hty7e00EMRgQqBxOor
         BP9c1ewiTYIWoNO9voEBOPyAzmtgTCAwTJG0PfcQLcyrieKPBFAgYQGhBULc4tqyI7wP
         PaxV9ZFXpIQUijxgSjzIBnSl4vVv3vtWVL9jWRFIrzao907C0LwA6q8oE5BL3+545usz
         rQd1n/mroIDU6644ddZyfVqL/3QEkX00oY8G0qNG4/AI6TyyCNaArzJsdcXyonEHJyVn
         blMg==
X-Forwarded-Encrypted: i=1; AJvYcCW2tU8wPD1gKqTSS5b2HbzFwvovj1XY3ayLNYrwGmmW2jjFf6Kzm0qxAhQYrA8ZY043lIs1i5zo4v3pEaT4DeN1vhK0RNWx
X-Gm-Message-State: AOJu0YyDAvIChzbp099GgXaCGQ8yYECbJmYiXg5H1kvDAlaHcPG9qAyD
	U9gdHkjU9UgDfeaiMGP733uBIw4H7ta2bEHBbl/I/jokpOfI/nOxoUPDuRr8LuK6Gd+qFKXlbhR
	Pi6dXUzQNbw7ycAkJ2XPW/Iohr4bUgiIXqXKP
X-Google-Smtp-Source: AGHT+IEgjBD8SQeKmPmPD9H4CjpoRfz+TkEI9OjKFyRvAUJNO94nVp/JGZDOO6FVOyYwFb4JeZW6mcvO4K31zgBwh5I=
X-Received: by 2002:a50:d490:0:b0:565:733d:2b30 with SMTP id
 s16-20020a50d490000000b00565733d2b30mr237561edi.4.1709039760718; Tue, 27 Feb
 2024 05:16:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
 <20240227062833.7404-1-shijie@os.amperecomputing.com> <CANn89iL2a2534d8QU9Xt6Gjm8M1+wWH03+YPdjSPQCq_Q4ZGxw@mail.gmail.com>
In-Reply-To: <CANn89iL2a2534d8QU9Xt6Gjm8M1+wWH03+YPdjSPQCq_Q4ZGxw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Feb 2024 14:15:49 +0100
Message-ID: <CANn89iLAPhxCuy9omqdTjBT96yK2wE5o5gG+nJNegf+ioo=Aug@mail.gmail.com>
Subject: Re: [PATCH v2] net: skbuff: set FLAG_SKB_NO_MERGE for skbuff_fclone_cache
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: kuba@kernel.org, patches@amperecomputing.com, davem@davemloft.net, 
	horms@kernel.org, ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cl@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 1:55=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>

> BTW SLUB is gone, time to remove FLAG_SKB_NO_MERGE and simply use SLAB_NO=
_MERGE

Ignore this part, I was thinking about SLOB.

