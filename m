Return-Path: <netdev+bounces-217271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7016B38216
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EB3461C2C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B5D307AD6;
	Wed, 27 Aug 2025 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAtOikWG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23B304968
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297000; cv=none; b=XO++VQSGZOXUVck+6r6iqNc38BP4+Wbas5ssPTY6HhSPlVxnKPjMpEBN/uLPso46AFUiRm7sR9KHuGYMhsHDMkwaK7pwbwftLRF/F+E8BlSX7Gp7dFDRyIYGiyQDTBDiqJ3LAlV/6v5T+Yqs1BeBKxsHgCrnKOdXgaOoFLcDfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297000; c=relaxed/simple;
	bh=BRGCpX4TW/j91X/6TqK3cFWa8c5jkEDq9SMKcufHJTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8BxcRAaLQEpauzKKyeiXlknkMUkJP8AgMi+Tc6WGk17t+xVbKS3GitoiE2ENYZaFmfRUWVATAjHcufcONT8q+CbhU6Ixt9WIEu29DH1ttZVcUBnVgJABzv7ZziVFa+Vl2Vq+hP4JimZmgFv786tnO3VB6MkpzMC6qKZgrVNh6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAtOikWG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109c6b9fcso68720141cf.3
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756296998; x=1756901798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRGCpX4TW/j91X/6TqK3cFWa8c5jkEDq9SMKcufHJTY=;
        b=kAtOikWGNhl9c9nJn/hyyMfXH04WqPhPnZ90V63oAhycywhqgX+lihgudTOhmdA5AI
         5I2jCKO4D9mFe0PGd3jratPcJm1y3gBgIc+o5JH791SVhc+BV2dnDg1lLxE0TwTfBrR7
         Ws2dJq3SXootzk8s6mu0VttKeAl8yY8pRzG1Q2TF8rCpduu7Z2egqraj9X9fOeolRCtJ
         7UizJfkClj1PjQ9eIc4TM2j3nTvQwOYCoyZvnYnbAlIM679R+dUTBNDK6/TKqRi3kzGS
         AA+pFBpdqb23AVPp26trk9wHfBIG7viQ6BANL1ezminsZD1SrLBm3wj6f0VNFrZXb53Z
         AJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296998; x=1756901798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRGCpX4TW/j91X/6TqK3cFWa8c5jkEDq9SMKcufHJTY=;
        b=OMsQJnYJXBulc36Yj+nvNzzMpyG2TSpOF07NXYiGLo6VcjtzD19n31psE97uhdgkfK
         x2Cae+f5nU/6DmmLiiim1gSuJ3c+JdvVrjmFI4Z6YJqxrhC5Y/8bb8mF2r4Upc0aztst
         mZJCbeaG5Wdl46sqNosqTKSSS1iFiH7m8UZv6nsYfO7WMAF6RXKAXgYc165DINA4TudD
         p6Bct8iDGyjW1MhJbx0XWRBzjWQdvhDZBBoFrdtF/KwBeWfBPlMx2l9rBPnzc/kUogk5
         ppgAc6LlCoaeFLqENeVe9hlvXNDTRyvC78MIUemqVBmTGCkeeOjII3lk35EhzrhqmVyE
         iCqg==
X-Forwarded-Encrypted: i=1; AJvYcCUeq40dbSxtEyEeS/Dak9IORTBt1FJKRvAQyIN5IiGiPiaHZI8pfp4A6ApOOYu7HrWFSApJcWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKLDNr0+g30dIJO3CyNm9yib5gkXNXfvR2s6mEo191amhRU2xL
	zzoyp8GI/erJyxmyKujWKfH5+h6vhsfwsqgLW8inKcS6RSr23mc1pJHlvYjDTo2FQMrTRWVCkdM
	maN/XfH0bIjzY/O5szGXRaHCu8bKwEZnPwXEHZBhE+G83anZI8Lw8KHeOL1s=
X-Gm-Gg: ASbGncu8aMQ8NKjAWuZafUVe+R8CF0WhQfdBzvYFidzN1xxiw0kW6PsPmK3OtUTvAYk
	PTIkCtu8DMjLG1QMjMW767hMdlUHdMiIKrxwK15ozxnCP/thNpHTuPHXVjaX5YCsfTBlyV2dNTG
	/gRNqDtMapGjkW+o/nfREnyXdP8v6RJ5Q1dM7L0PrGlxnCTY4Qvu4+8avS7t9TnpdnMNnN2QGWv
	3AOWnG93AQf9uQ=
X-Google-Smtp-Source: AGHT+IHecp4mK6bhtL0glQd7+xCH/d53sWCltRZZrBQsNz4y2dtQXeiV8XRH5EMbDgI7KLx6NLG7UCz3EXjp0x7rJZA=
X-Received: by 2002:a05:622a:2516:b0:4b2:d8e5:b6dd with SMTP id
 d75a77b69052e-4b2d8e5c90dmr111472041cf.49.1756296997228; Wed, 27 Aug 2025
 05:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-4-ouster@cs.stanford.edu>
 <ce4f62a8-1114-47b9-af08-51656e08c2b5@redhat.com> <CAGXJAmzwk87WCjxrxQbTn3bM8nemKcnzHzOeFTBJiKWABRf+Nw@mail.gmail.com>
In-Reply-To: <CAGXJAmzwk87WCjxrxQbTn3bM8nemKcnzHzOeFTBJiKWABRf+Nw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 27 Aug 2025 05:16:26 -0700
X-Gm-Features: Ac12FXyOfqpHJmEd7QzP-bbFKX1CBNzy6Lhvi1irEAcfQPvV5qUIxViPEmHlIIg
Message-ID: <CANn89i+yjrhykQ1FEaKoq4tPAutR44o3FbdNH_sw2R9dm2jMkw@mail.gmail.com>
Subject: Re: [PATCH net-next v15 03/15] net: homa: create shared Homa header files
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 4:11=E2=80=AFPM John Ousterhout <ouster@cs.stanford=
.edu> wrote:

> I feel pretty strongly about retaining the use of TSC on Intel
> platforms. As I have said before, Homa is attempting to operate in a
> much more aggressive latency domain than Linux is used to, and
> nanoseconds matter. I have been using TSC on Intel and AMD platforms
> for more than 15 years and I have never had any problems. Is there a
> specific inconsistency you know of that will cause "unexpected issues
> in the most dangerous situations"? If not, I would prefer to retain
> the use of TSC until someone can identify a real problem. Note that
> the choice of clock is now well encapsulated, so if a change should
> become necessary it will be very easy to make.

Real cost in these helpers on modern cpus is in rdtscp instruction.

And using rdtsc (rdtsc()) instead of rdtscp (rdtsc_ordered()) is not
measuring anything useful
because of speculation.

Using get_cycles() in networking is simply a big no from us.

We do not want to deal with all these #ifdef CONFIG_X86_TSC games.

