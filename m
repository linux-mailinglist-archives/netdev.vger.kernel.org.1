Return-Path: <netdev+bounces-216964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCFBB36B6D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CEF980BBA
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C6B35AAA3;
	Tue, 26 Aug 2025 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ+CKn5n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABC335691B
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218588; cv=none; b=WrheAEwjwf51oe5D5riLeGlB9uXfS7Y2vzz8WDh9NqMlWD0A6pCa92RJ3etP7QAvOh6hxsuSUiMmJ9Ngov+Nf+rSD4LiV+LYEYGlrEuHb4avFQSBElNPlto16ei7SZEE7yKHNdNEF/xAcCq6zJwtzyMzVzSXv4TRBtO67Brx4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218588; c=relaxed/simple;
	bh=adeMrx3CLn3fNSJeO/crbBFVCR4KSU5DRPDqzZ4IsEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxFX54R4vHblpLY24pxXESEm1ZLolAnyIPWjWUzfQGdVxUd4+J9JrsIdeughBPC795xkRtzTSzU6MdeE/qjHHxUXZ/83jHb3w761gq8qUdqyo41MPF9mgia9FXQqFiUdE+D1Fob44kf49C6FG+SugjwnOJo1eOWlkBRcztpNEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ+CKn5n; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso4008201a12.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756218586; x=1756823386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZkkZ2UUdPurD8iksdsx9qQb4W+EDGU8E4WhURbCFmA=;
        b=VQ+CKn5ndw5kJBn8XKfhn7zoOXjGGrf+cSwq6KYr6Y5NNzbgGJsWXtnMr5jz2+jGQ4
         zIQ+1GfW9nIFmuqzmKNbNd3bBLH6b9BwKKXYbja5UKnmDL9wOShGu/YKmCx0XuclquA4
         OVSRol6fuDmjjZvS4dfh5POnAlnOTm+JxOpGUpaVNB1wCqkN7oXrrAUSYY1qNk5ZuZao
         /AOIHsxiZKwqG3GZ3b7uccE2PDtChXhXHP3Ey02j2QsaTIP3+/jUMD7cFYpYcnmQVdEe
         PXTmf0Nn8yM+a8F9U6R7eIwhSPlkvuRoCjr0w7EM+hOz8ga5E0XMwbCUG5nqoyxa/97r
         J+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218586; x=1756823386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZkkZ2UUdPurD8iksdsx9qQb4W+EDGU8E4WhURbCFmA=;
        b=UbKujta7KfNlKhzOyyf2ICfCQtxCfkSGVgY/tN0VACYVbfTFd7DY6zxCtcxSccEkAA
         Zet9fQJoRJAWvOcF7sPNDppep75DdQQlody8udnKlPFvuO5q+2spxE52+IbWqqDuBjB/
         RPhHasup8ZaY1hLzRlnMxSHWjDgiy1rwIXRizCukX/Mz0LpzTIMXAaXpUNAHSRLILTqU
         PsbZ4/Wj465gtZxs0KJ7JnQaQcSKivAuGUQOHVnkD0eXETyoJWq3aiUsgBW3V+O0ssjv
         mCqjB8rW2/JZQlJyc7e9mg0QcvOrvfQDlAHPeiDSmTLtsAs3TtJil2cyXV44phGoiHhD
         dCIA==
X-Forwarded-Encrypted: i=1; AJvYcCUo3KmMRbggzaLf9H5DorsgKXSOpcl0fmOcT96P7Lfr2jKCcfd9ow9n96993sTMNHkY/4vDt1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDo+e1yt8JtCHPeoQqY+eJUxV1RuzRuRDPLvuajnYS2HT0iauy
	32tN6JrmPyCF1R+nCqGXo8DwXpRY+TjT7vqME+YB0mgoDV9vwhqidgvMEHQiyn8htHHencQuVQg
	ieoxKzLovH2QJ6HgFHXtAlVjrt3pSVh8=
X-Gm-Gg: ASbGncsxrpXRd9ODS951B7m9i9cTn1SkmWzGR9z90CqWHOw4IJhmeI8ZYKVetmOxClL
	fZy0BG9dAiq1BRQZw3pt9xLLZQG1b160GzU65Qng3r3N6nCUKNFfQa/PUyJPC04MDYT6cRnGnQp
	+Kgjj10PunTljPRDJdppjXvYhVCHjp2OzQcMeoNnPi3lwoO3Aa87xkPpMYlTfoPC3yNkFBK/kJY
	PalsXxXdm7PlO63b5jSj6QYbeiiXR/YAeR2VO0=
X-Google-Smtp-Source: AGHT+IG2SB6HV/igLcf/l+JXN0WdxIQZJfAeS4LvxzC77dE4qsQS1ozPkgnpW4FhRxDHfdfengYhKHLqURDgLDuzMMQ=
X-Received: by 2002:a17:90b:1b4c:b0:31e:f351:bfec with SMTP id
 98e67ed59e1d1-32515d111e9mr18762748a91.0.1756218586380; Tue, 26 Aug 2025
 07:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826141314.1802610-1-edumazet@google.com>
In-Reply-To: <20250826141314.1802610-1-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 26 Aug 2025 10:29:34 -0400
X-Gm-Features: Ac12FXxhWqGGf1_scGdaiojV4vummAellqfWC9ofBURENPKShUi8wZ4r6vr2V0Q
Message-ID: <CADvbK_eG+f4O+WGBFucpWTZFvpPxWJ6obnV8hHPsX1RvEonWDw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: initialize more fields in sctp_v6_from_sk()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+e69f06a0f30116c68056@syzkaller.appspotmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 10:13=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> syzbot found that sin6_scope_id was not properly initialized,
> leading to undefined behavior.
>
> Clear sin6_scope_id and sin6_flowinfo.
>
> BUG: KMSAN: uninit-value in __sctp_v6_cmp_addr+0x887/0x8c0 net/sctp/ipv6.=
c:649
>   __sctp_v6_cmp_addr+0x887/0x8c0 net/sctp/ipv6.c:649
>   sctp_inet6_cmp_addr+0x4f2/0x510 net/sctp/ipv6.c:983
>   sctp_bind_addr_conflict+0x22a/0x3b0 net/sctp/bind_addr.c:390
>   sctp_get_port_local+0x21eb/0x2440 net/sctp/socket.c:8452
>   sctp_get_port net/sctp/socket.c:8523 [inline]
>   sctp_listen_start net/sctp/socket.c:8567 [inline]
>   sctp_inet_listen+0x710/0xfd0 net/sctp/socket.c:8636
>   __sys_listen_socket net/socket.c:1912 [inline]
>   __sys_listen net/socket.c:1927 [inline]
>   __do_sys_listen net/socket.c:1932 [inline]
>   __se_sys_listen net/socket.c:1930 [inline]
>   __x64_sys_listen+0x343/0x4c0 net/socket.c:1930
>   x64_sys_call+0x271d/0x3e20 arch/x86/include/generated/asm/syscalls_64.h=
:51
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Local variable addr.i.i created at:
>   sctp_get_port net/sctp/socket.c:8515 [inline]
>   sctp_listen_start net/sctp/socket.c:8567 [inline]
>   sctp_inet_listen+0x650/0xfd0 net/sctp/socket.c:8636
>   __sys_listen_socket net/socket.c:1912 [inline]
>   __sys_listen net/socket.c:1927 [inline]
>   __do_sys_listen net/socket.c:1932 [inline]
>   __se_sys_listen net/socket.c:1930 [inline]
>   __x64_sys_listen+0x343/0x4c0 net/socket.c:1930
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+e69f06a0f30116c68056@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/68adc0a2.050a0220.37038e.00c4.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sctp/ipv6.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> index 3336dcfb451509927a4ae3c2bf76c574c743936b..568ff8797c393bea28f8423ba=
bd4c85d6407f9ff 100644
> --- a/net/sctp/ipv6.c
> +++ b/net/sctp/ipv6.c
> @@ -547,7 +547,9 @@ static void sctp_v6_from_sk(union sctp_addr *addr, st=
ruct sock *sk)
>  {
>         addr->v6.sin6_family =3D AF_INET6;
>         addr->v6.sin6_port =3D 0;
> +       addr->v6.sin6_flowinfo =3D 0;
>         addr->v6.sin6_addr =3D sk->sk_v6_rcv_saddr;
> +       addr->v6.sin6_scope_id =3D 0;
>  }
>
>  /* Initialize sk->sk_rcv_saddr from sctp_addr. */
> --
> 2.51.0.261.g7ce5a0a67e-goog
>
Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks.

