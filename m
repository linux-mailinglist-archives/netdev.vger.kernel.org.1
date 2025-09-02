Return-Path: <netdev+bounces-219278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BA0B40DE8
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C857B56262B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B09286D71;
	Tue,  2 Sep 2025 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXP0GEIo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E911865FA
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841540; cv=none; b=dJYP09IptS/qMFgGQvGXtAOMCwlbq/fFH6wsQFFIcQkxWmFCbIKEEdH9Rwb3pp3y6tcHM8X93KFN4KLIWXPhFbxEWM0cFXUGvZvowIAFcA86XJz1hnt5smEnsfqr+Ngvvk8zf3SpGxSrOyReAoIm8+wyWJhlKMJ0kKHcT7E/xnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841540; c=relaxed/simple;
	bh=WXVTLRCSAPDFGUkUfLjV2Brr9pyB4DXWU/7ceN0WPc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDESXN6l2qiqEmRjOXx04tohL9Fc2NOeOFI8SHEqQEq+L1IQEK98ohNCWyJ2OYQUdJoYsh11ssaE+5dS8LUUuFv1mNACmg5UmcCf+DCAHldNeaclO2I/b3mEVl3lFjY1da1/XokkeEC0e6D04u8YZMgU5TZwg8HXS7R8osMErzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXP0GEIo; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c9a6d3fc7so3377482a12.3
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756841538; x=1757446338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CETCbHQ39zTv8P6yQnZyYPqp3sT+ZziTFW/GxUKVpUk=;
        b=NXP0GEIowFOumK0JFjXDr5F3b59TMRyQANHLy0VTMjauhFMjT16UKGhlwHjE46tid1
         FV0ssmjsPyBhtPf7oWS13Hz0H8raCuOiB62xfjNb4+QGL2FdKzXqaq7Wt3PrJBdmHjnd
         mjc3rzfAQDbpYLvIYAdtowXC28UMWBBq8N49HEVNY/7rmMzZ4ExVQ6Diw1iqBgOc1yHL
         zT88I73ytL388dG1bV7baKT6nRFmveOyRw/2TbG/eMS9ow6rhohYooFCyg271kfZ20TC
         YoGOOakw/IYj/mx5qvfnZKHRe+KBiBqGT/iiagteD5TD+g1j7m+SE8NgCF2tlcHjghGV
         GVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756841538; x=1757446338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CETCbHQ39zTv8P6yQnZyYPqp3sT+ZziTFW/GxUKVpUk=;
        b=piVAKhv8f75hMkaOvZ+SKgqUr6oS0bomQkEziBqui+ykfeBjnD9gAOHfStjJW5Fgnx
         RgMd+t75u0XJ72U0WMe9GZma/avu025RVRbQm7y1ZTZOLWJP27xSI6RzFvO5EDGHa5+B
         eDnkSTIhdNTKFKy+9tAGmk1s7L1l6uk/pET5GtlQPq6xVGKlYZvKHy+441CWs/uNgtpc
         D83apRRL+CUL+TWuSF1ArUK357Q6voRWtI04I1B8pmPdrnxiR7ILv7Kbi5OnMwwqQKQn
         FH8DSldwaSQ7qmHtQQtnFVxEZmz5cj04O79ID0QI5xP6BAW2DrlGW5RHS8M/5Sh6zo1O
         ayJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3EEKAtijwgaLJAWallWQYStkmXH1DuKo9paZZwdTY/8f9w5kyVWI+R+tW+3ResExfyj/XO64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwchV0I1aJISLQCq/edP44A2viYQWzzcL5+SvmGEjM+TjpA/sjF
	uNfLlkIPVBtnFKkKGtR0xHEQUZG/W1ouAEH01qw+q3Ls0GSQNhUfLGw3PWnZXRUDIdEL+Kgmobr
	OYddcrNZiXwupFyWNHzA615ZSkYcY2yvUhpPJLFES
X-Gm-Gg: ASbGncvX8R3A5/iwUpuMRft5sGZ6VHnAc3uKIYrSz7Jh2oktjzTnvhA3DAvnHIhkAzK
	lKt9b1ZexOgCohdVA1L7QGw7R/RvZrH5ihJkR1xqAQYkK9CX1eob2D+ml5MUUQ5HdjCePMcZNwB
	TjzlIA5SXqb89oT89OS+SdQSLjLNtAV5pgGnxmdx5CYqbhkK9LYACZ3woeYXPqE6bDIMlauvbZ+
	GySttfwq8YXb60XVuuAnGsQ/i60ikWWLo/t+6nF01U5bl0BSH5dfeL6sNqNrsaf2uJcU2vWoskx
	nA==
X-Google-Smtp-Source: AGHT+IFlntFZ8AUaPfRapFyYDD8zXpzvZtNnXvChrwOKRdLdIDsAmCAq+LIFbd1zGlCIFyeJTHa63qqIh6k70Elzs4Q=
X-Received: by 2002:a17:903:2a90:b0:248:fc2d:3a13 with SMTP id
 d9443c01a7336-24944b67d88mr155884325ad.55.1756841538200; Tue, 02 Sep 2025
 12:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com> <20250829010026.347440-2-kuniyu@google.com>
 <2527aee9-4e19-4e41-9176-7be1eda9aede@linux.dev>
In-Reply-To: <2527aee9-4e19-4e41-9176-7be1eda9aede@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Sep 2025 12:32:06 -0700
X-Gm-Features: Ac12FXzalWk_-6qt9buKearmsTUcb0_1tRNSujSQPggWO-EMCYtR6EEiiMu4sg8
Message-ID: <CAAVpQUCivp-5vNq01z3CTikX50OkeEVt=ikVa90CioqGkf9XCQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next/net 1/5] tcp: Save lock_sock() for memcg in inet_csk_accept().
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:55=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> > mem_cgroup_sk_alloc() is called for SCTP before __inet_accept(),
> > so I added the protocol check in __inet_accept(), but this can be
> > removed once SCTP uses sk_clone_lock().
>
> >   void __inet_accept(struct socket *sock, struct socket *newsock, struc=
t sock *newsk)
> >   {
> > +     /* TODO: use sk_clone_lock() in SCTP and remove protocol checks *=
/
> > +     if (mem_cgroup_sockets_enabled &&
> > +         (!IS_ENABLED(CONFIG_IP_SCTP) ||
> > +          sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
>
> Instead of protocol check, is it the same as checking
> "if (mem_cgroup_sockets_enabled && !mem_cgroup_from_sk(newsk))"

sk_memcg could be NULL when the socket is belongs to the root
memcg, and then we shouldn't call kmem_cache_charge() for SCTP.

Also, SCTP's child sockets are not supported until we convert them to
sk_clone_lock(), and I plan to do so after this series lands on net-next.

https://github.com/q2ven/linux/commits/522_sctp_sk_clone_lock/


>
> > +             gfp_t gfp =3D GFP_KERNEL | __GFP_NOFAIL;
> > +
> > +             mem_cgroup_sk_alloc(newsk);
> > +
> > +             if (mem_cgroup_from_sk(newsk)) {
> > +                     int amt;
> > +
> > +                     /* The socket has not been accepted yet, no need
> > +                      * to look at newsk->sk_wmem_queued.
> > +                      */
> > +                     amt =3D sk_mem_pages(newsk->sk_forward_alloc +
> > +                                        atomic_read(&newsk->sk_rmem_al=
loc));
> > +                     if (amt)
> > +                             mem_cgroup_sk_charge(newsk, amt, gfp);
> > +             }
> > +
> > +             kmem_cache_charge(newsk, gfp);
> > +     }
> > +

