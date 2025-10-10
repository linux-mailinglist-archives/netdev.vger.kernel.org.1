Return-Path: <netdev+bounces-228534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 035FEBCD7DD
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D08433561C0
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0E12F5A29;
	Fri, 10 Oct 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgcdt5nb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B132F5499
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105963; cv=none; b=I9k7i1Cl3TPlcMJRQWcfj0W2UIjw3rL7uvrEffe+wsihqMHzPXXcJADOhzfu87glPzl3p9FrTksnm8qqL05iL0BK/Q26CGrMojIrgGPK8uOwIzTbrg9WPchrVOHHTt1iEXlQrYUCZl1GN60FakKB6leAVQIHbfp+owJ1zf2wfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105963; c=relaxed/simple;
	bh=FdLxE7Lm30nhyAzpTObSV2SsmYXiyE6njXvC6pEK/ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdlu2RzPmoW4cGgmcSq50WzsQM8zMe5QzjM26lk5zJHTBIzChTUn/Az11lNzfd76b6c4WXBJrz1Bx/WuYx9l7alB/DjjmvUQ3snAj2tGTiG1IZ1sHOFI/yiJ7nTGKNmaoLsMj/Xl8GsJ0v9r16DkNZbDXKDMa9OR4qQNM2hNdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgcdt5nb; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63b960a0a2bso2488361d50.1
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760105961; x=1760710761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdLxE7Lm30nhyAzpTObSV2SsmYXiyE6njXvC6pEK/ss=;
        b=mgcdt5nbX1LLUaGdnUPLUImPENVMbDBZ/LIBH4nO6BbtnVPuj8xQF++g6WRLpevd9u
         nQNz4U6c5mLeiUazjtzOJfUDLN6RBUPm2934+fnbqyxYCK640jwZ8YdS5ua/b1g5r+7G
         iedrPck8PskE12I+Bpw1Yq/hP+b+KHWaxyjsmtlkvMJrGVu0ritCRfA+ESqZ4fE035XU
         3U0JUz3LaPiJckH/vh7wDwrKh6V9uvmtAOHBe4Un+G0XQGcyeRSxd9VO+qb8HlElyAd1
         CzOTaYPoVYmVJk1zb+4P5RVGJlztoex7DUOtgfOtcLnxs2SvImjz8upUTUMZh14y4Cfo
         uYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760105961; x=1760710761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdLxE7Lm30nhyAzpTObSV2SsmYXiyE6njXvC6pEK/ss=;
        b=OeFwxMhw1p4CqK98iw9zDeuVOJP+4UfMhFOLlu8unHKIoXgWlf5Dwc1tq3Npzafc+t
         EBJfec99QBBGPIw1Aj+/xlxtBfKvkStpUoK2vGFRFOmk5mUA/9OxQT549Y/vpvRbqDDU
         tKQ1mwVkmwuTrkpBrpWvTWfmW+u6KGOCzQ8MHq0cq2EUBJwpIUvR+Lo3qTlMeTzubP6l
         eXGD1K/IJafSgleab+dsiS7JYXTJelr1ZtmzJ4k9WJI97D8wu67FSyj5zhY42/fWrPPz
         eQFlOFJ2SaQJsow+Lp+FjOwZmoUmPSJVrXXrxiPmcCBwZ8E+V37Uru6UOYuyAL5iiDfo
         OvFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjOdmQwouTakv6zfToRrDobm3MhGTric3MDu0idBN23JnB6VDPC/awEy6VBlw5trNXRAS0Ono=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpe8/JH+V+B1k5TskcuCBa+ixUVKuRDGYaZ/UY/rMjvjPBwj9m
	ZiG04jaEk5DEKbgdiokbrpdiMWVfqATzDYxekZTZBq+rfeiZXW98zdTaRj2BslrhlvZj42pvPmb
	bRV1jmxYwUB3AlRHh47Wa8ZgA+lYebHmrNpyWmawd
X-Gm-Gg: ASbGnct+PwRzjzsFYRZ7bOo1yn1ar8msVExZdAXCWp37xXvubsMUQAITrP+RiwrU32Q
	wTBekzEpjDssJ/EygIhDLQGXgJcKDRrEJrwVYayToTKKkHSytbYkSDfx8x5KOv26Y6nt2kJQ8OS
	AuEm0ls6JN2B1I1dOXJsiyJpIhzuyDqeeGmgBu6LVcrwBSPteLDpnyAg79Krrkz4B3G2Lxewh7a
	9byQWrErSRDgFlO9l1kBtLDZs94v1vUc6I/0dgTHRXz
X-Google-Smtp-Source: AGHT+IH5jygwKiKj8iWh7NXNa5aupSDxyDfR+khBSnZcImv7vqxxqCrpmKSorFziFLH513QVJf/OcUBtXZUfZcpK4oU=
X-Received: by 2002:a53:b6cd:0:b0:636:d4ab:a507 with SMTP id
 956f58d0204a3-63ccb85e07emr8088258d50.16.1760105960542; Fri, 10 Oct 2025
 07:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com> <20251007001120.2661442-2-kuniyu@google.com>
In-Reply-To: <20251007001120.2661442-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Oct 2025 07:19:07 -0700
X-Gm-Features: AS18NWANXiYqX9j9t6ZkUl82Zdn7j6m_ZQHBRWnadmG5JVnbTEP8rqhXa70_KeA
Message-ID: <CANn89i+=V0Pr4B0C9NH4vLf4kRdQAhpT53UyVPEPxQavvZ6FCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 5:11=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> If memcg is enabled, accept() acquires lock_sock() twice for each new
> TCP/MPTCP socket in inet_csk_accept() and __inet_accept().
>
> Let's move memcg operations from inet_csk_accept() to __inet_accept().
>
> Note that SCTP somehow allocates a new socket by sk_alloc() in
> sk->sk_prot->accept() and clones fields manually, instead of using
> sk_clone_lock().
>
> mem_cgroup_sk_alloc() is called for SCTP before __inet_accept(),
> so I added the protocol check in __inet_accept(), but this can be
> removed once SCTP uses sk_clone_lock().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

