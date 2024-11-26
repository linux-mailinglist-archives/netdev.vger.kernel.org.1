Return-Path: <netdev+bounces-147490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6399D9D6A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280A5280C17
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D6D1DA614;
	Tue, 26 Nov 2024 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXUAzmoR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271EA1D63E8
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732645938; cv=none; b=j71eC93uTPYSx7YM4KPxLtY0rNSA8VEyHy6HQCw1lqMc/Q2M4Vt1n6qG0am0LjT4fqr3F6L1Nivth8jamHCzdkYekCXZ2AUDomizXb9wuY/IBa0SAh3sKS+Dh4w3zKDZk77pO2A2qa0K4S0RkaECwuA9v7uyc60e8koY4mosmoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732645938; c=relaxed/simple;
	bh=Ss+qH1p66Iauaymu6hpyDmQ+54On7Lt3UYbnLeJzpnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PV4t4AG4RjjWX/1q9ufiRE3rbDxtU5OjsfNuUQevvsn84Cx4Aq/lau3QVs2pGlWC9whEKvaHt2lBC86GMxCmbHETV/mBDYfI23RHQIbpWQeFc7A8XOuiobZc7e2B7XceLczSb5eMw/+gqJLfgm0c6DBiumceZgEYltLfI4fdoXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eXUAzmoR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so103754a12.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 10:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732645935; x=1733250735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss+qH1p66Iauaymu6hpyDmQ+54On7Lt3UYbnLeJzpnA=;
        b=eXUAzmoRQM0YFlmd5JPAbcks6E/mUdDA5w/qrTfN0oAHFAG00bfQCe+9qmnRCSTEKG
         COItV+OUu4YM0NaLJTE2qxWRmAQfkYnfHI6ImITyXgHWH8vXlrxcwefilZ/Jn9XnVWqu
         4qm/mQM9GzBdI7U5shYwODDw2eY9xlosWf5jcGYZzIgi3DQiZFDjwn6ooLxYnYq72GAN
         pZOOYMkHAzytCSilCp6SI+MZwyt8fh/Ehudn41Y+2JzQmilGTfRUQwTvhEiY60FYsSzC
         ntGLIWZkBQgNnLTdKBsPWUBNrFnmGTIw+Nniv95r3r1AcREtg25wLR60ibg2iTzY1GuS
         0JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732645935; x=1733250735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ss+qH1p66Iauaymu6hpyDmQ+54On7Lt3UYbnLeJzpnA=;
        b=KKIcTCmvMFyMAUD702NQqEcubErFT5ILyxEhJxcXO2ceymSRDjBopUDUPcq/+Y1b+a
         b6tgGDrxZRc9nzAHYubbC/i0PPDiibic8q7rOyEYCT0PJVW4BYfzU2stCEDuFdhQ7zeX
         LFZGOi33p1dvFwOMKQ7D/4pkf8PoArg5ai9j6PQQt+lsH+xeFPOSgfMvU7p0qWdpcxIL
         Ilgn3IW8230OsRj7Dgc9Y+zam7ucqUPCP76Gfx+QBWrQ0M03YHVx8VlUBhF3GFKglXIt
         Fe9w16T2ecprlxpGKCpVT1zhJZCTgLTbg7CBWkOBLp4DJgCeIdXKaHHPvYHFE46pEwfI
         3Dpw==
X-Gm-Message-State: AOJu0YxP5pNtLbBcOQLrpwZhe528BUWPYOZ/nv9tqi0XlIUBmle8tDSd
	6JJcGFAQY3Axx7U4k19XR74OzSBkBbtJZLNs6dVMkWq4TppmiN2X1OfvSYvLP2Q0sfdehQUbX4U
	oIEjh5bdNNiTVgBIWMOQkAGjBh1B2aGLWMBDdOG7jGrWCnCWRpENgh3s=
X-Gm-Gg: ASbGnctJFdvn5yme0/1tpKHa047/A1pnKiDFw5CNJpGklF4DJU7380wbsvjBmizdgks
	KiA1Y8hy9YyIpk7Wc+Ae42d+Q3Z348hUD
X-Google-Smtp-Source: AGHT+IEC7x8uxVYzVfhtoBuf7J+uTJHo7rlSkD7xXKFRv/V7KC796QJnnEIr4IoT6BMGmtBjn8IcYtxTOaDjELblmuM=
X-Received: by 2002:a05:6402:26ce:b0:5cf:d341:dfec with SMTP id
 4fb4d7f45d1cf-5d06a52b1d2mr4235736a12.0.1732645935287; Tue, 26 Nov 2024
 10:32:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126175402.1506-1-ffmancera@riseup.net>
In-Reply-To: <20241126175402.1506-1-ffmancera@riseup.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Nov 2024 19:32:04 +0100
Message-ID: <CANn89iJ7NLR4vSqjSb9gpKxfZ2jPJS+jv_H1Qqs1Qz0DZZC=ug@mail.gmail.com>
Subject: Re: [PATCH net] udp: call sock_def_readable() if socket is not SOCK_FASYNC
To: Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc: netdev@vger.kernel.org, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 6:56=E2=80=AFPM Fernando Fernandez Mancera
<ffmancera@riseup.net> wrote:
>
> If a socket is not SOCK_FASYNC, sock_def_readable() needs to be called
> even if receive queue was not empty. Otherwise, if several threads are
> listening on the same socket with blocking recvfrom() calls they might
> hang waiting for data to be received.
>

SOCK_FASYNC seems completely orthogonal to the issue.

First sock_def_readable() should wakeup all threads, I wonder what is happe=
ning.

UDP can store incoming packets into sk->sk_receive_queue and
udp_sk(sk)->reader_queue

Paolo, should __skb_wait_for_more_packets() for UDP socket look at both que=
ues ?

