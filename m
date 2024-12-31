Return-Path: <netdev+bounces-154634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DC09FEF5B
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 13:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D63918829DB
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0EE19D06B;
	Tue, 31 Dec 2024 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQEtWC1U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0902AEE9
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735649102; cv=none; b=qFFfUroVCLjwSpdxNIhmFugN4pAD78BvY/QwBiTtkm5D5hokhWUZWEqNmLgZq01U4ritTBgPVssb3/5OD0gLcRVYxiGMqTfXPAg+QPeAu+vUu9t+EKFTkZ+MHgq0fEGuNQtE9Pp0Al5KjLoZ08+0+XfuxTJ5vhoD8S+3dgDHwGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735649102; c=relaxed/simple;
	bh=rtnWtbH7LWUONXk0uFbLci05oAQvaPHXs5RuE6UcM9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9bbCYtjMa4b+j8gGwUuha0BkjY7xYuR9/s85+zAjXX60+t7v0sPMexzTYx1i6ZmewQkSK17Np8gsQiTlBuSqcHQwYlqKUECVT/hrdxK69zby8eGJLQDLMnBbzCcsYYfnVnYBsvjEHXhL7eJ66bYzrOMv1/Xu20gSn/hs3/rEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQEtWC1U; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d8c1950da7so4770501a12.3
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 04:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735649099; x=1736253899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9vWb8C0Masin/UN5pwHCOeE3alaajgfAcBoXEP5Uys=;
        b=mQEtWC1UZVVb9qaPsExEf3MghPQDFGYbnd+Kd1E0Ixt7+Jx+5tPzvrKgO/UvxjVOAe
         Co1J2cpwGjnAjqVK6wRcV9GBcQU51ny2mf/X6Y3LzF+l+xaneXB8jHxeKokq7BL0GPpf
         HLhrjvllWU22RDfs3BknJxy6qci/sP5tYyOAMCXZEuWqj+YoWOeYMm1gUwSpmY4fOcMF
         gvCe5wHsdoz/vdTlUax9+PyzJjGcfEv3zlT8l8PO9dHlkDmd6Hgt+YX8ub+ApO5GQ1Px
         bHMcVP35OsHBighxtpY45U+iPm2XYCNLI+vUlDeOSHB2/pceUrk+xNdOeGYfnf4gL5dc
         U9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735649099; x=1736253899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9vWb8C0Masin/UN5pwHCOeE3alaajgfAcBoXEP5Uys=;
        b=lZy9YVgbkO45P5c13RR0qrYh8CuGzmWgEdleYOxrj+V5qsKkuAVg8s+1Z5zDXI7Y6V
         uSzKEq11bgrdfc7eGC8SRYoPRk9uAuaQhqMokKa2QA6ZzFJ1cKZeozm2mlX5aY6p4wdK
         4nYVgOk7SQb6u6PVqN4mB4kAiWc2/aZVfBz7ku0CaXD1Mw+yX3Zb+uLV0R0UuSlW3j5B
         ocuuAXcdAoxcAFCEgTJEUUdI8UQKotnRfcz3T0ixcHFdhkFE/XQpxWTMdWcD0JyDu+Wu
         vsWIrHx+sNI/ajOy/I4MHXdEdMGBZ2L6+1ioxgZ9B9xSkkTZetJa8Rrw+dMg3tty8wMu
         mjcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzCXbD8PRJZXiJrkldq4wbklbVxdgszwCxd7XSyL6+aDZ7wNJDIlOnoFVXn2bdIFUK/dgICKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YynsmVI841Q1meHBM3MMSpLKf17KBAXo2u09/Gk0lw1iJHuM
	TlAtcPhwyJB2L2cKs8+DGxbijG9L8rWBxVklmaTi43ZQnQnK+OaY+oZ9tca9X7Qf+XPUJroqPgw
	eeIwZaOEBYZUacZ44j11sNZnHLua2VpdIxob67LRFkWXa6xhOP3ub
X-Gm-Gg: ASbGnctrU5tSn5oVEHC0LZ5Gl2kyV1c+9uArV0wswr4Td/AKYQa1r7K5R8vawWqoZiw
	ETICOP/oGfCEnrDuGED4lWlqT+YlskwvLjN3jU28=
X-Google-Smtp-Source: AGHT+IGBCod/Knayn1h1YH5TcjrOqcwA9vjBE2DbOUsvlNOKUXFCTOpUzOIL2HX4DTy8fPQ/t9B8kQnrQbN7Nnk8YvQ=
X-Received: by 2002:a05:6402:50d0:b0:5d0:e826:f10a with SMTP id
 4fb4d7f45d1cf-5d81dd84d4cmr33183521a12.6.1735649099265; Tue, 31 Dec 2024
 04:44:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230193430.3148259-1-edumazet@google.com> <20241230160739.351a0459@kernel.org>
In-Reply-To: <20241230160739.351a0459@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Dec 2024 13:44:48 +0100
Message-ID: <CANn89iJzjq9w-Z8GJaY1=KDLku00aweoZTB4_XHzHe=Cp7xy6w@mail.gmail.com>
Subject: Re: [PATCH net] net: restrict SO_REUSEPORT to TCP, UDP and SCTP sockets
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 1:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 30 Dec 2024 19:34:30 +0000 Eric Dumazet wrote:
> > After blamed commit, crypto sockets could accidentally be destroyed
> > from RCU callback, as spotted by zyzbot [1].
> >
> > Trying to acquire a mutex in RCU callback is not allowed.
> >
> > Restrict SO_REUSEPORT socket option to TCP, UDP and SCTP sockets.
>
> Looks like fcnal_test.sh and reuseport_addr_any.sh are failing
> after this patch, we need to adjust their respective binaries.
> I'll hide this patch from patchwork, even tho it's probably right..

It seems we should support raw sockets, they already use SOCK_RCU_FREE anyw=
ay.

Although sk_reuseport_attach_bpf() has the following checks :

if ((sk->sk_type !=3D SOCK_STREAM &&
     sk->sk_type !=3D SOCK_DGRAM) ||
    (sk->sk_protocol !=3D IPPROTO_UDP &&
     sk->sk_protocol !=3D IPPROTO_TCP) ||
    (sk->sk_family !=3D AF_INET &&
     sk->sk_family !=3D AF_INET6)) {
err =3D -ENOTSUPP;
goto err_prog_put;
}


(BTW SCTP is not supported there, although SCTP got reuseport support
in linux-6.0)

