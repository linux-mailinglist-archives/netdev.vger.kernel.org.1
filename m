Return-Path: <netdev+bounces-248091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C670D034C5
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 15:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F6D53148957
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865E84C6F1C;
	Thu,  8 Jan 2026 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llD/m/JG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21E84DBD6B
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880766; cv=none; b=dKDjfWHxdnexEQEY2jx6n64lBodVVFgPrEHxS7nNkCzpVKX5GYRZd+j/b1TLVAzG6yhQMipkvsp4RLlRJ64pwMtTvEOIqDS3zTAlV574GU/hKlzW+Y1SkCRVPhrfJxmsJB2UY+bLrdTMfQyhfu3XtaBaxtfc0jeGrYwW5Dobpnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880766; c=relaxed/simple;
	bh=2pKAnlEn6hRYqap+nvJVoSIseniKes/Ivmr+dkuPPFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXXosa6/QMcPA2LjxEKpBZGR9BTVhNnGueVoWQwvmeWZ4P/OZPw0mkqgCc+R1MrUEmuSw8q9z7JRow75UCV+39LfKUxBTCvF7H1j3hHJu1RiKkS4+IV4/074IIa1jsxWUI1Qz9HNVbhVCVtl6pUpGdzbvGbmNWx+ixlJBnFT51g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llD/m/JG; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso33129801cf.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 05:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767880764; x=1768485564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDy71JxhuxNQvQEZmT+0GWb6fjggpBo0WVDg9NnAn2A=;
        b=llD/m/JGeenMEEb7shRsC4OaET6KkdY4KZtRUfGe9E1sIAJ2r0vK+71P3o8ex2somg
         qx0Y1wRqCDc+A/goGBz8Gu9TkrZjB+ntQCbBF7ASTudSPd5c30GQ6uMbg6AuodO3D9xr
         qgs60wJYzk0f/UccpghYzLprBxKnLpgq/tr0n2mvAQbKvJumV8VSwC8lc7l/L3eKyIaa
         IhuBY48ya2XBri5NhsWSFkoUKP8qLzAXTy5x3p8iRMyczkChRobcZG4bYlS6eGu7QOjJ
         ZyWTWyE7rOoVi0JBGR6u3SBzCrgQcNp70JPUwc2LX9uYdgJzLW3D265dQLZDWz8bBehT
         Z8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767880764; x=1768485564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uDy71JxhuxNQvQEZmT+0GWb6fjggpBo0WVDg9NnAn2A=;
        b=xVRDf2BThCJofj1rzTx88cfRTekQgUQpeeAK1DgeP2xIOSw4dKVbAN7vKIQnlz1J/Y
         +JAQAf9aK3rmq3RCDurPRiX5LDXi29j9UbWzNsgjfxo/UOQgvWW1VJCc0gn7f+K1fRnc
         o2AOw4sEwCdYZCAMvQUB9kur3cZhdL6oZiOB1m/IfakpIdleS/Vy2jJXPauMW+4MBTnY
         rCWiHTio4Yevz1IsNJN0mW08KYLlkNkbGZQnTR9zFk/feOCN4j1oVbH0Nh+i0v4OaLdJ
         HJj4m1lukTI9KjbxVbSnBjyZqFBR0vcXe5XeLR3tlERHzsjZW2tLM/K7r7ufkwNf/jpR
         IyVA==
X-Forwarded-Encrypted: i=1; AJvYcCUlLh/RRNhUKusBp3REIU4sf98nZHjuYoYYvJPB+yLREZ1xZ3NadDk2ecULUEBUZt7ZauOKsvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/g5l9QgmIAZLi53G1pZpLwVPF+feaJkKTV9VBV+5I/ny75BE5
	wo7EQQOK/OUf2CyEPuYUBUIZCXXLhsPT9QWYLaXi5p6//AVVXFmDof97XVxy1Bkf7iDeX30VZgO
	CqiCVTQmSbouCndV22I1IMytkQlcBjnGxUJ4kHt5G
X-Gm-Gg: AY/fxX5VNw9SM3Nb76V4Bmy0QTFUNyOEgT5UeGHzQL0qs05uIZo1UocWOnLI3m9BT5K
	ZXdY63I788psvfbe03SnrCbs3qeIdsG0Bcxm1E8lokPHaIo8x1vRCu1VoJ3LMg7HSFtDuNQqVmb
	bffBPueNDbG3Qr+gq9mVhPIMLPs1IAqYPpfPrqctAKD5tlHgQ/6MCnmaylVZx375n7trBHyduEt
	jwMb/4HvB/RIJfUCfzJtd1Mf6KfCLR38y7Feui4cZRelBLgkwjc3sFLROadyyswLixQ0A==
X-Google-Smtp-Source: AGHT+IFsds6ZAUmMQT/8XUII+uJ/L0chWB0gSjHaZOF/WPuPs/LHIXOtHv6L1aOWMgUlYiGaenOj0af9Eh+7ppZuT4M=
X-Received: by 2002:ac8:580f:0:b0:4ee:1db1:a60f with SMTP id
 d75a77b69052e-4ffb47d6537mr89817661cf.16.1767880763322; Thu, 08 Jan 2026
 05:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <695e7cfb.050a0220.1c677c.036b.GAE@google.com> <2744142.1767879733@warthog.procyon.org.uk>
In-Reply-To: <2744142.1767879733@warthog.procyon.org.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Jan 2026 14:59:12 +0100
X-Gm-Features: AQt7F2ohXWhRfOT_iVfpSN35Cg00-2WqmDTRpQnRPNtu5XMbSkKBhR2D11ff_3Y
Message-ID: <CANn89i+z6XzGGJRJFuL-1_FDeRXQUULZwZNnXU9RLkcptpw7jA@mail.gmail.com>
Subject: Re: [syzbot] [afs?] [net?] KCSAN: data-race in rxrpc_peer_keepalive_worker
 / rxrpc_send_data_packet
To: David Howells <dhowells@redhat.com>
Cc: syzbot <syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com>, 
	davem@davemloft.net, horms@kernel.org, kuba@kernel.org, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 2:42=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> I think that this shouldn't be a problem.  The write is:
>
>         conn->peer->last_tx_at =3D ktime_get_seconds();
>
> and the read is:
>
>         keepalive_at =3D peer->last_tx_at + RXRPC_KEEPALIVE_TIME;
>
> an approximate time is fine as we're estimating when to send a keepalive
> packet if we haven't transmitted a packet in a while.

LGTM, but potential load and store tearing should be avoided, using
READ_ONCE() and WRITE_ONCE().

last_tx_at being time64_t, this would still be racy on 32bit arches.

last_tx_at could probably be an "unsigned long" (in jiffies units)...

