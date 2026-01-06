Return-Path: <netdev+bounces-247240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9DECF61C6
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 01:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B752300E7FB
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 00:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FACB1E520A;
	Tue,  6 Jan 2026 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBZyW95V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A561DD9AC
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660723; cv=none; b=chhvdEwEGe6VlpUz3LQc0FDbPZTpLl9jRmIROsqVI8O0jyZqEPJG++YqVbe+OjTc+9oQvGk/4hUcpFMiWtkCYYhLGgYoz7jENeuNNtyHYhooR8/iPk/k8LYkIFzwwhKzr+ZkaRr/+SdP9MbfpBsY64Nuwto72tcuZ8DcWM9HwvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660723; c=relaxed/simple;
	bh=121YepIIPK3mdJqqn2NtkzokqFn0EteVfZ0Rhg8h070=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKlNYTIt0CVQydjn8dFI49IAoigH7hp6CaetYZy7tM5dSGlOxQmlAa+yKscwv3cQSZC+hBL7D2gM9kYM1QoYufn1rT0xRhCO4v6PXEkGP1Pl6b4ZFQ5srqsBFqZwdMhpTUk+EjyXeNAF1wRJ/D4bmD64ulDRD9XPTKScGz2QSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBZyW95V; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34f0bc64a27so406781a91.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 16:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767660721; x=1768265521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAD6YtZZBHQIK4oM5dCNs2iuqj3Y+7DXU4uKX2S0GE4=;
        b=NBZyW95VecLft/W80maeDo6q4A2+a8cSGZgYzHikTq3bnTwjIJgpouJrlnZBm86OfB
         ttF0Gs7DJqB4pkRd95tBCYphrLG70YeZNAKd4TNJj1veagU/kZJAm8njj0IY65OmE42V
         wuFW1nS9gNvnEO0qFuiUWx/R4zTmRgwKnJ7nNiB1hjNZGKnrxX/ojTXC+xn9bnG17zvl
         NixOzD1xfJO1u+krWRal5RmZe8a/ep1CSe7p8/obY0rHdpjtrOh3VaShXz5p5myA+HiV
         li9entmLOtuYnDQVm9z1qbk6AdR679Z3P8G4PGZOWht/G4kXcW7KStVApjG2PQUXULll
         L5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767660721; x=1768265521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qAD6YtZZBHQIK4oM5dCNs2iuqj3Y+7DXU4uKX2S0GE4=;
        b=fWisOJZm2AV7rq4Y0SH1+62acP1+XasN/m2GztOq6/eDisUgTFhi3akLmtpwB3UiT7
         pPKnBkwOcE58TiHWhbwSlLZZqAK4qWB70i6mIgxLtF9Tvr35KJDjqGmQA1BPJ4+BCIXL
         1qs/5YgJ9pocGlaQhuF0NOjaH7Z64gt916XxGFkLXEMuvCprgDKU9UU9sGCpAHbYm1Al
         ctQpBE8MFNO/NIzrYe2pdqg3qMd8+rKd6K9dyoirG9RjJTgnxvjkQodvwmVhT4nFXrBe
         hwOTOpWlkRcXDBlgg2ogDW1Jm9dNm2TU48wlpGWzgysMBQBzIU+jUGHHgE3BHQfNISmB
         O7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfjCCXNN8+HxerMD3WW/IMzpKCy/XlV9IvDu4mORX0b8B6txevbwe7tPDC08p3Q5yP2VcDflM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMoH98J0gfo2o/kkJPCf5gG0zKvLXY+I/N+gM4sAHWJVF6IvW
	oaq3hQ4p5BGPxiSUtRwBn6RgrOUc5OktexBpgO/xwalpYAmXtcHHp8yLA/bNYmfOUIn8kYEigbo
	NL5ssHqQLwcLxYIbb0kPRQ1XRRqXbjJM=
X-Gm-Gg: AY/fxX5bQ3tPWawEgu6SFR2GfbnQ8wonaHnZpjtktUUZWDUw10KgJA6fktjpQo8u1T5
	TeV9ZlhejKocJc4Uh+fL4QZIGSnd5dFcXfSsnf2yx37KjPtXh9vAlqa9Pyw0ydp63CbQmIWcvAy
	AINmI4zfGQz6iEIgEccXZX0BSpm80bOO2UXmx4uhyZxsdCQap3TPtBfybdyeruABtV6XqYeIxhP
	vZ/pNuOiTf76rsKb69jgemnSocj1/tuC+QQF0un2kTTLc7ffnTAm/inYeWjS5m0sxoNXWO7vanf
	hMFnRtCopmA=
X-Google-Smtp-Source: AGHT+IFv603VqYElE35SX3ELAvBCRGlQYtqXiilEa9Qkts21oLcu00Lv08iVpktL/hQ99CcCQkhb+hhuq/1eVssKoUg=
X-Received: by 2002:a17:90b:2d4d:b0:341:abdc:8ea2 with SMTP id
 98e67ed59e1d1-34f5f36e115mr904799a91.37.1767660720750; Mon, 05 Jan 2026
 16:52:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104205220.980752-1-contact@arnaud-lcm.com>
In-Reply-To: <20260104205220.980752-1-contact@arnaud-lcm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 16:51:48 -0800
X-Gm-Features: AQt7F2pWBNs-OAi0pD2XDPRGnH3bUZqznbZCdhovb5g-fSH9tIlvDDzLKUS1k10
Message-ID: <CAEf4BzYakog+DLSfA6aiHCPW0QHR-=TC8pVi+jDVo27Ljk5uuA@mail.gmail.com>
Subject: Re: [PATCH] bpf-next: Prevent out of bound buffer write in __bpf_get_stack
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, 
	Brahmajit Das <listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 12:52=E2=80=AFPM Arnaud Lecomte <contact@arnaud-lcm.=
com> wrote:
>
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stack()
> during stack trace copying.
>
> The issue occurs when: the callchain entry (stored as a per-cpu variable)
> grow between collection and buffer copy, causing it to exceed the initial=
ly
> calculated buffer size based on max_depth.
>
> The callchain collection intentionally avoids locking for performance
> reasons, but this creates a window where concurrent modifications can
> occur during the copy operation.
>
> To prevent this from happening, we clamp the trace len to the max
> depth initially calculated with the buffer size and the size of
> a trace.
>
> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/691231dc.a70a0220.22f260.0101.GAE@goo=
gle.com/T/
> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation int=
o helper function")
> Tested-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Cc: Brahmajit Das <listout@listout.xyz>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
> Thanks Brahmajit Das for the initial fix he proposed that I tweaked
> with the correct justification and a better implementation in my
> opinion.
> ---
>  kernel/bpf/stackmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15..e56752a9a891 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -465,7 +465,6 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>
>         if (trace_in) {
>                 trace =3D trace_in;
> -               trace->nr =3D min_t(u32, trace->nr, max_depth);
>         } else if (kernel && task) {
>                 trace =3D get_callchain_entry_for_task(task, max_depth);
>         } else {
> @@ -479,7 +478,8 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>                 goto err_fault;
>         }
>
> -       trace_nr =3D trace->nr - skip;
> +       trace_nr =3D min(trace->nr, max_depth);

there is `trace->nr < skip` check right above, should it be moved here
and done against adjusted trace_nr (but before we subtract skip, of
course)?

> +       trace_nr =3D trace_nr - skip;
>         copy_len =3D trace_nr * elem_size;
>
>         ips =3D trace->ip + skip;
> --
> 2.43.0
>

