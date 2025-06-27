Return-Path: <netdev+bounces-201986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFCFAEBDA4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 18:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E46179D53
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96D929898B;
	Fri, 27 Jun 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8prCgDV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342661CEACB
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042306; cv=none; b=u6fvrmdyph61SFqkYeH5fO8cFE9SjneflqfIrhSJc3UH9dDoizrJMQEaL1upLP86cTdwCgvE0ivgX51cBxKBse/wjqS/y3/GaSkSE8NZBycfelgz72bs0qLP7DNYjeUliAL6hWnZLxPNipQe3RpCG7fMNwfkORZYNxxldIMERmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042306; c=relaxed/simple;
	bh=VhveM/KOuGUtxeJDoBDNqK2L1eLPl7UszqRULWUiuAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egxaRcpIKNwVtbutGvhR8HkquOu5NHwYK4z+XUK+v2nuZaaOSfuev+aAxrtYSz6s3ASZZIXmvI+nHtIPMnf2Q96Qsv0WHP3Ns/miB5O2R2LthJkM1IIWC6xdm+kgrFiVc/IYDRhJk8PHdxuj52cP7RkApS/wUqH8QUuj9FpJjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U8prCgDV; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so50333a12.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 09:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751042304; x=1751647104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjA155f1pBEqKH7AB3aZFGokcKJAb1KjX75SUqeTg+c=;
        b=U8prCgDV4iDT7NllOEwo3a0kxxKWCMnqDxV2NEe1PeNXgnKmkt1aEw3GDs+p8opmez
         4nAmQqtAQ3AypfUANAfdpBqrCxc+iyLysjgqf1mQnVWjmcv/CY2963pQA85BO0jKyzE0
         qa/+EaaLmjYaU/I0mjp9umwzHlqOCgPSsjPWxCxhpA2mqaSV+dFMMpZ3V9jf0pzaFLsR
         /+MdNIjcIRs9clEuXPeV4i0VbCMYGh/Pc1wvY9DK+ghigLDTioKTzVRxzO1s8X6ngPgL
         NUJYVXkNP52FW6QnEFp31kgvgNd5MzKe4aAENTZqXzfBZgURY8DhBZuX/riUeWytqi1g
         OIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751042304; x=1751647104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjA155f1pBEqKH7AB3aZFGokcKJAb1KjX75SUqeTg+c=;
        b=L21mHtrz6OpvgBhy5X+ZeYch7jZFr2MJeLI/A99st5PFQSBPcRHfqI0Y9vz8M/tIzE
         1u4f816y5Qi55trLmHV9I0RyYJquo4X2cBRsU1xuAnSY+Vxh//QIS2/mhJeVHh0XuYhs
         TZ8Inq2/AkbfdYBfobbMWhenT+AIzHaeMnWL/WZHZkydQcs3RGNxM2CBmBbyrmgmJMr8
         YDTImJi5FQ821FyE/vCwURrp3Nui9CcklkICfki7/Jd30OYodO++7+k//YftHG9/Y7Lo
         olq92vYb7iLQU4nzkpjedhtkKLsuBT+mO1xmvKQJz98c23CtER8KcwU8017h5sugh6Lo
         Jd4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5mgCnXWzLh0HRw0hmFD5QzugTKgasFtxcWwKwprWbU28ZgV865ToQCqwMjuOwtCP7NE9MDLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9KGrXkGdjEFgf6LlsYcSgRHadUPaRgyIZwdZ8aJYEjdsGKMUj
	WROD3v7X+5tw2c3FObeyLUqg7YlFIjmijryD7d2n6gvJLijRjEP76iDS9OE0ANH9JwdEhtThzSn
	ndS+7HxHNDZTaDNeCaqPLqAdDdV9DtYM/uo17XhHjAovg5+MOOJY/2DgQ
X-Gm-Gg: ASbGnctD5kvOL//3KmQx86F/pyJBiDqEKJ6a9AUA3Jy2pu20uRZklE2jEdzylJKMOaa
	AkDBPMY5unEvgAkTZosOAVLg6IphR65ZoFwA4o5tncbcp8nLEwdw2KfMh3NH5p1T40gUoyNV7Lo
	TyqR7SLz9uiQxGQZCO1G/ZrzQMt7Q9QhcVMQCfvKzkkQ==
X-Google-Smtp-Source: AGHT+IG0R+6DD1YIN9X+I3Sr4l+PLbikt5EFdVSxPYums+jwJ4sPDhYi+qtXz6JrPx2ef0oP7bSY9IBLHRLhjTjW3K4=
X-Received: by 2002:a17:90b:1dc4:b0:311:e8cc:4264 with SMTP id
 98e67ed59e1d1-318c922ef55mr7404410a91.12.1751042304252; Fri, 27 Jun 2025
 09:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-7-kuni1840@gmail.com>
 <CANn89i+aMsdJ+oQmo1y4sbjJM40NJpFNYn2YT5Gf1WrfMc1nOg@mail.gmail.com>
 <CAAVpQUDa8w49-mvf4=nAYLKv0aX9hmAt312_0CD+u4nSWWAv3A@mail.gmail.com> <CANn89iLpv6esFywtGMZTuNU2Ppdj_Ps_vff-c+Sp_iPNZrkxJA@mail.gmail.com>
In-Reply-To: <CANn89iLpv6esFywtGMZTuNU2Ppdj_Ps_vff-c+Sp_iPNZrkxJA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 09:38:11 -0700
X-Gm-Features: Ac12FXxyTYfIo1P9JJiKxulHtGV5-s5POmekHMVbOF3D_WBgJBRSLYnx7eLGqjM
Message-ID: <CAAVpQUAxYYAi+veJhCYVKxzyDDC=P4i5up58WR0Lnsawf6MHjw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 06/15] ipv6: mcast: Don't hold RTNL for
 IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 12:21=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Jun 26, 2025 at 6:01=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
>
> > I'll post a follow-up for other rt6_lookup() users and dst.dev
> > users under RCU.
>
> I have prepared a series adding annotations and helpers.

Thank you!!  Will use the helper in v3.

