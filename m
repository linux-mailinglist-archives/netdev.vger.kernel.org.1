Return-Path: <netdev+bounces-216906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A33B35EE6
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4DE1BA052B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC0D31B139;
	Tue, 26 Aug 2025 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUtkdXO/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381FE2D320B
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210313; cv=none; b=ZbP2wuKprq/309mloa5MuASG8LZ/VQcRYeTYQQX3/kEZSYSQOGm5f920OcutfYT/7ol80Jr12VGss9+eH99LNvyBpcbIOin35Odp35W8fP2moVsgWCpvcBhkqo0+MA4edMBplJ9GZfSgbxEgg2fEm7PsrW3urX2wLFqQzReruoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210313; c=relaxed/simple;
	bh=QkP8vgC7yeQ0hqS8yGEksBT8rluRT7rFNmw7DflZ/A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iD5ZjbjCIluzvmegOSIS1zt0+WEb3HCD+2eDCNtHlTxvF9NgAYPJBXwSzU2RHBbxC3nGKfN6e7w4N6rDxcMH8Xocrx8+BHLZmHe8jB8H7GhvhH4OaOlnkEePPtK2LXaKLgSgMujOL+x4Oi0xlUsr9EH8Hw9aQrjmw9GqcE+q1/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NUtkdXO/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109914034so73011231cf.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756210311; x=1756815111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qr5AhLg/jhJ5N/K+aPFUa1QWz7D/Sxc7RI1NNen4Ac=;
        b=NUtkdXO/W5CulsFE4qQcHUi9sIWwGkaFDBaVAormUF/EN9iYizNHnrTLHNvMgCXGXQ
         3IouqjgJSvAZG62DXAvvayxcBfqZus+kmyjVYn440Loen6sOCj1MjgFiFsrn3H0Alh7C
         B7fziv0U8A/0sstI/3Un/qm31RAHnZUyvgH+niJlMOqMaarQVdbvYMdsREFSz6ezY9N4
         /OKnTv6kyH2c6ieSYsGW8ia3birsqgzhe5zJXRq2dabu1vDgf2QtrpaU87eaC6PgZPXz
         00JgrY9MmGyfIfqr870R9LnQB/vpY1KVxDmPFMLckQfhOf8diUvIh2okfTRC9WQs8SH2
         Jp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210311; x=1756815111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qr5AhLg/jhJ5N/K+aPFUa1QWz7D/Sxc7RI1NNen4Ac=;
        b=QntfxlVb5jyLERPf50VKy21yeocYJDNh7MT9Gn6fQdD1sV0BX/N11Tp4iOPXN2m388
         XWRS610+Z64YCCY79bv5mUyplPmsn1wTQB5vtJOvqk7QPU2801Vu9PalCqRrAq9jJUUJ
         xcOovmb2WkimSzIZ32FLrmK89s1adezqB9oQI/SMfP+6pL3N4RhOnzcV/ANCplzUpVZe
         rvRiCjdkx7gKQceC9Yt5p5G9MR+ca6E4cIK1/z6X0Q9bIe9n1stAwfi3WgDZ2M6iSRJv
         1O4rg98NINBFHiHnbGiY2JOr1Bk+pUlsD8RDg8cfWpquK6AhZTs2m84jtB47BiPHgUXb
         sK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMlpfNw0EIuer/voXs7g5mDByoBYo5IedIHl/TfBd24h5BwPrt3HO1t/IluwhwNdPUg518EyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0WAebbzmqH8sVMmUrNW6MCcdLXwfcTtFJDprhgYL1XzVWQqz
	Dgc7kJl9JP1k3i/lTnFKWQ/HLcr+KvvtUWXt/NUdpm0LCz0jkKR1umGGgBYxXANs0t09GbjhHUu
	G075TmVY+2wXq6ry/d0LP5sg8JglilnGMtFnhxn+52YJQ1LnGjAo2xU1F
X-Gm-Gg: ASbGncuZJB9d6/togQYZtHxF/Z0WtbQSBFePTur3OSXeBzim8FpBZ0D3aIqv6ZU5TF4
	2dBpF0ot7GgL+4gyRU79q4bk2KCe8GeIfGzfombDmpisAWxB7x95bkl3u500Fy3H8onSuE0eGWw
	jfmwsgHP/2reK03Uqn1vU9LkKSS/RHNhTK5/OTyKNwnG8XIeM1Lq2tGe0DAiLE54AsLEecdRW/H
	rXRnvhp7wfkF/9D/iY/mYk=
X-Google-Smtp-Source: AGHT+IEReIHfafYH1cU/hmu58NsAMHvIkmprBwRtYD7E0+tEydHpxdNoqe07k8jL4V31GC8bHtzsYa5FXw0atVU4r5g=
X-Received: by 2002:a05:622a:40c4:b0:4b2:8ac5:25a2 with SMTP id
 d75a77b69052e-4b2aab73638mr148893191cf.75.1756210310538; Tue, 26 Aug 2025
 05:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195947.4073595-1-edumazet@google.com> <20250825195947.4073595-4-edumazet@google.com>
 <6e645155-1d2d-4b64-a19a-a6e90a12b684@redhat.com> <CANn89iLNnYXH0z4BOc0UZjvbuZ5gWWHVTP1MrOHkVUq26szCKA@mail.gmail.com>
 <8f09830a-d83d-43c9-b36b-88ba0a23e9b2@redhat.com>
In-Reply-To: <8f09830a-d83d-43c9-b36b-88ba0a23e9b2@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Aug 2025 05:11:39 -0700
X-Gm-Features: Ac12FXxKlNDUzB6Tcd1HLyIm4e3n4O9ALVksFcgpLXLIGbvcFRkRz4phZ-a21LA
Message-ID: <CANn89iLaYB_zS2u4jdrfSkqa=V-fHQnttxSZR2B6-5oK6RU+uQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: add new sk->sk_drops1 field
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 12:16=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 8/26/25 8:46 AM, Eric Dumazet wrote:
> > On Mon, Aug 25, 2025 at 11:34=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >> On 8/25/25 9:59 PM, Eric Dumazet wrote:
> >>> sk->sk_drops can be heavily contended when
> >>> changed from many cpus.
> >>>
> >>> Instead using too expensive per-cpu data structure,
> >>> add a second sk->sk_drops1 field and change
> >>> sk_drops_inc() to be NUMA aware.
> >>>
> >>> This patch adds 64 bytes per socket.
> >>
> >> I'm wondering: since the main target for dealing with drops are UDP
> >> sockets, have you considered adding sk_drops1 to udp_sock, instead?
> >
> > I actually saw the issues on RAW sockets, some applications were using =
them
> > in a non appropriate way. This was not an attack on single UDP sockets,=
 but
> > a self-inflicted issue on RAW sockets.
> >
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Thu Mar 7 16:29:43 2024 +0000
> >
> >     ipv6: raw: check sk->sk_rcvbuf earlier
> >
> >     There is no point cloning an skb and having to free the clone
> >     if the receive queue of the raw socket is full.
> >
> >     Signed-off-by: Eric Dumazet <edumazet@google.com>
> >     Reviewed-by: Willem de Bruijn <willemb@google.com>
> >     Link: https://lore.kernel.org/r/20240307162943.2523817-1-edumazet@g=
oogle.com
> >     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> I see, thanks for the pointer. Perhaps something alike the following
> (completely untested) could fit? With similar delta for raw sock and
> sk_drops_{read,inc,reset} would check sk_drop_counters and ev. use it
> instead of sk->sk_drop. Otherwise I have no objections at all!

Good idea.

In v2, I will only add the extra space for UDP and RAW sockets.

Thanks !

