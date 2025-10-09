Return-Path: <netdev+bounces-228444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0C7BCB1DD
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 00:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF28F3ABDDA
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B9286D45;
	Thu,  9 Oct 2025 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz8SruKs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A012868B3
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049512; cv=none; b=RHNOUq3CPNXmWMOFXRuZfB3/cOohST+WzqDhpIFYM1mBX192iF5mtM05UDMUymaFQ0SmGzebsAtaRhTJfHr2rcx8JHEA8hhODAV5wcnLtj7BMzOW4RORR8fpLp9ciJDS4rYHA8Dm/spkXsamV2FYCg7oCum3Ji1zDKB5WHMKFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049512; c=relaxed/simple;
	bh=SGVEequXzpQlmwTnv/DQGNo4OQhhE2kPDPP0GHhqP8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9MYHEWj1j1mGHnVjWLPFbelrdVKoADLWO3burQIM9tQCLkTtgAnNFSXEk0kXJSmiA/JP+jx/WL+1V9piM3xEs7SGeGPT5VjJDg/fjcpA/um6pj4wc6Ur9ZEX6iRvw+Hg2v6tv+hc8//VihspEojomTSFvId9FqcxFBFfIZleJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz8SruKs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so13411745e9.3
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 15:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760049509; x=1760654309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pX43H97TMHIdwtm0l5tv/67eOJTCXZOrCI+4u7I6kR4=;
        b=Rz8SruKsvbo3GP6qvQqm/H5fGnIxTFL+QdUNxiZGydcmoZ4p9ZB0hY3Ljj2witUzD4
         YKxRV4q/50E4BoeilQ2gTyaon1zVZuWykLv4AqrH0er2hKatB3dfWVgi128TZyGBigtS
         XjJOBivxGatOhY9qUhZdu/eGr534iramARvS8A9sWXF3BrIkG1WQO7cHknUCSyqSb/4w
         du/CxixrRnaTPuCb4Ltl2Nx9Y8pkx+WYAVCi0IPDpzCaPs/9Cun/JVgoKNR5JB3bc2aQ
         09IVxI3ykgcHSJgM8T/iGmyVFKHzxP4Zvhp8Qh0uO2o4hE4w1CAsXjwgQY9XII4yqgWI
         Mt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049509; x=1760654309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pX43H97TMHIdwtm0l5tv/67eOJTCXZOrCI+4u7I6kR4=;
        b=Nocvp2V+I3EBG49IMbLtMulOsez6O4Hg8cQGAG/Da2SBEW3GPRHzl4Mocy6Nxy5TsQ
         e4c9e7kYyqMIzjep80XjrG3+AChiCx4KPvAIuOh521s/HIdQkwvk4pnCqGV7o9CftOW1
         NZn7+o+Prfwx9OnkJRx3DvUZ/rHODRhRQR7TA4olk8Kgquu3Gq6RLuwxNqXyswXzGKs5
         kykhyfYUDxPgv0V2vIoz3eSKQVmB/FVmfqREV0zyqe2MVSsFtSaFWrZVVvWrVH+B8DwI
         AufZVnXQ1vOnODHemj3Zb9ygGdQFv27yIgkw8m4taF6ycrbNIV9mBMvoOnQ+Y5E4+3aq
         IBRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzxVCrku5PGFbFHL72qiXmENBZmNIHPk8MCEavEbymOCbTlXRRma3ZeNIto3Ao1rr7bFT7+OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzll9AVOOuMCB+Sw/qDkiZIDMinXQHmbB/h+fBuYm2AwRH17As9
	V0EGsQUalpGx/I6jcpXKjt2YJHQOqJmx1oJ1fMnHzn68ofYIhsa/zI8G+ItiZzz+Ea0zGEp9p2i
	USrI431LucnC/+vUfclY3L/CMDiSGhZE=
X-Gm-Gg: ASbGncsBejO7h1XYnNc+/XKHQ6esJxQzIacOKI/TmeA8GRrcZueqf/hBu0WlXWhLpRu
	pBBBbKLaOpHCaMnkiTt9+CEUBGMfnvbjDCVO83+pAcUC+QrmC5kKsp8GwaMP94hMbxYczA4WWiM
	vm8e/BwR8dz3PIgBZ80hsndre6wOTLU9f1Bl0QZLjsSRDIueCWlOhSOmLvK2OgjShdT2Ru5lk79
	gEQF/P907iB3TsazW1FoHEwsHdynrtDHCkVNUAsQEsMXwsQgHib1i3J4y7hrxyc0wn8zqN6SgQ=
X-Google-Smtp-Source: AGHT+IHCGAek9aLYnqO6h6qsaegIprBP2JhFgyiNZ2Akv0snlWVmDL6rPA/XdN2zodvDo8rNlXjq2b+YANheSLZaO04=
X-Received: by 2002:a05:600c:6212:b0:46e:27f7:80ce with SMTP id
 5b1f17b1804b1-46fa9af8f39mr64662065e9.23.1760049508783; Thu, 09 Oct 2025
 15:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68af9b2b.a00a0220.2929dc.0008.GAE@google.com> <20251009222836.1433789-1-listout@listout.xyz>
In-Reply-To: <20251009222836.1433789-1-listout@listout.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 15:38:17 -0700
X-Gm-Features: AS18NWCOSO6I5mHnXsHQEv_1ULrRUw4sT_HIqjSgrJz_CypEeQ9hbJFdbnIG9cI
Message-ID: <CAADnVQKbmTgwXf5WvXACKUNbzs8r+Cvgx6KyyD7Xq1SOL9gLmg@mail.gmail.com>
Subject: Re: [PATCH] bpf: avoid sleeping in invalid context during
 sock_map_delete_elem path
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 3:29=E2=80=AFPM Brahmajit Das <listout@listout.xyz> =
wrote:
>
> #syz test
>
> The syzkaller report exposed a BUG: =E2=80=9Csleeping function called fro=
m
> invalid context=E2=80=9D in sock_map_delete_elem, which happens when
> `bpf_test_timer_enter()` disables preemption but the delete path later
> invokes a sleeping function while still in that context. Specifically:
>
> - The crash trace shows `bpf_test_timer_enter()` acquiring a
>   preempt_disable path (via t->mode =3D=3D NO_PREEMPT), but the symmetric
>   release path always calls migrate_enable(), mismatching the earlier
>   disable.
> - As a result, preemption remains disabled across the
>   sock_map_delete_elem path, leading to a sleeping call under an invalid
>   context. :contentReference[oaicite:0]{index=3D0}
>
> To fix this, normalize the disable/enable pairing: always use
> migrate_disable()/migrate_enable() regardless of t->mode. This ensures
> that we never remain with preemption disabled unintentionally when
> entering the delete path, and avoids invalid-context sleeping.
>
> Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  net/bpf/test_run.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index dfb03ee0bb62..07ffe7d92c1c 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -38,10 +38,7 @@ static void bpf_test_timer_enter(struct bpf_test_timer=
 *t)
>         __acquires(rcu)
>  {
>         rcu_read_lock();
> -       if (t->mode =3D=3D NO_PREEMPT)
> -               preempt_disable();
> -       else
> -               migrate_disable();
> +       migrate_disable();

pls search previous thread on this subject.

pw-bot: cr

