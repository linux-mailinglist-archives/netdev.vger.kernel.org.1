Return-Path: <netdev+bounces-249120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5A2D149BD
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD0330EF9B4
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3685D37F723;
	Mon, 12 Jan 2026 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQK9PnuA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BFB30E82B
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240043; cv=none; b=Q7UFcrnf3pucbrXqm1yIxklpVbJKlXfiwEdZJGnd/7ZJokeAXEIyg5ihBYDZAtKLVrg30ojkp9rqBdy7ZeoaPVg2Q3gk4QzXWG/lozEnTodipGQbdJid6reqsAxHUeMkOTJgu9xE95t+zuDJLE5Uw7/mCOWKzAIf9phiul7CAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240043; c=relaxed/simple;
	bh=/QJOFFtF5uxw5ji7BAVAG30RLwFgl9kFU9cKTxxZRZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRO4814Vi1KCEF2hWknqxhr9lofL/EIy6rR8PbKi6FmgytSipQERCTBuOOJbg3QhQaJMQwLZofgp8F2iLjUDYqbwnNDws3nVfAcfgowb1UH9j7cKLNjTd9iGWvrjS55LoQCNCEBUqwdaO9GT4VFgPkAUB1Yfpruxn3j5U2cX0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQK9PnuA; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64661975669so7176397d50.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768240041; x=1768844841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+frE4WDsMLdqbKRsugf8C8wilDLHiOI3JECrH7cio0=;
        b=fQK9PnuAMARRtuYl90P8Aeftyy1BzpLO5RWwsDtuj1Mub88ATMcyMpg8c3JH8Lxh+0
         NgqaFzWerT9PagZftr8XkwAnXUQ6SecSPNJEX/RreDizRg0PL/s4yetqOk9WCERWie0L
         QVpMeNm4tJmLnRa0rYmKU+s1hONMfaol9yyKeEpN+LHkX4h3WQpie6xLrpziFY8LJ8lM
         z8EWcf9BaiLhtC4ZU2DeiflRMLvbGb1jgGvQEUuSmsZMR9s9Cau4W96TnvdLifw6jym5
         6ZY8R2cxukJAAqzO4BLEEuuPQfKZN8dq7JirLCHT2d9mQAf4MDE0sbg2APpB1/ZPR/6z
         l1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240041; x=1768844841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+frE4WDsMLdqbKRsugf8C8wilDLHiOI3JECrH7cio0=;
        b=wSciPZ9ZkxzK8XBFJJLtmIyHswFyJUYcXVPAiw+qBwFNW+R4dKWrFqWdMNn4uY5N6L
         5vGGYuliqpeutGXZk3heoTKpshnpTOungFU136J/YrqkCFAg8wsj1kVVq5/6Yi1PNTkT
         72LMUoJQiOUNKtgdV2AtaOZW+noWjynOfX51FiRbVWTzoW+yB6Eha6MljbJucin5cyv7
         jjDKwFX2XP4+t2S8xO7EkbHIj+FBUkEhSsC+sri1HriguFgd32ua8sjJ9tAdXWKWcIr4
         HxYuuV3n89dv99DkomdWrlRKnczkY+36ZrNT45FRzQvlnMPlL05IjKKYTfHYbeJVLeWp
         /lbA==
X-Forwarded-Encrypted: i=1; AJvYcCUqgNIAQaHpNAA8ch9ZmZ1nE+1rur19z6VAufGVqCoTxpVhabGd1XzBQX0u/kNAx4GQU4YafV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTz2/DQeV2HcqY/NWa+zr03aVpvn9fMwr55eaIxzSVbw8P96K
	RQYsvDonKmMiOXzloGecvMqzXrHaGC/Sm2HVgOmKvLu/7MkubbbfAacdRbON/c+ll6ajicnIzFX
	8Ys+pgRAEsio8oMDO55HU6RSqG8Qh7/M=
X-Gm-Gg: AY/fxX4eSp8A3owCAotXdz9wDQZwuoh1ltYWNXeQA2HrBDm1OtRfEATHOoSBucXL+H/
	qrQoDIBXZckzUvMcQlt7BoIWc9De5dhTMGUMeBnqWGjurpKVKY98/ZCnDN5GjWhvndufnv8qOrU
	6XN+ZN69JJhdl4ettwnL5UuLYTnCXgveSttGaiSiDlyFXxs52GD5fA4OpnfZHOpmQqAa/TSrht5
	dourGYkBBnyVOVFyiJqO+LiVGUpjP0PHKNF0CJrjRvqww/cyhsFtgLoyDVowH7AbOTXqA==
X-Google-Smtp-Source: AGHT+IFVeQvnTyVi0gka/tZbpXqlCHihWT6A5xV5oVP9fW+lR6g5Zw/srIkUgZCvohE4kliOlhCty0HLnOkI4vLDbzA=
X-Received: by 2002:a05:690e:1501:b0:63f:9a63:46e5 with SMTP id
 956f58d0204a3-64716b9b436mr14975163d50.28.1768240040678; Mon, 12 Jan 2026
 09:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218175628.1460321-1-ameryhung@gmail.com> <20251218175628.1460321-2-ameryhung@gmail.com>
 <74fa8337-b0cb-42fb-af8a-fdf6877e558d@linux.dev> <CAMB2axP5OvZKhHDnW9UD95S+2nTYaR4xLRHdg+oeXtpRJOfKrA@mail.gmail.com>
 <f3e041d4-c65a-4c16-99ff-37caceebb54a@linux.dev>
In-Reply-To: <f3e041d4-c65a-4c16-99ff-37caceebb54a@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 12 Jan 2026 09:47:08 -0800
X-Gm-Features: AZwV_QgwOOPE3jQ0mq9YK8F7JmNsIIsVms4e0eONCJZyCYBKNOgEmrzCPzHPpUU
Message-ID: <CAMB2axMMgGtYqE3+jbhN=T=GrGdN3DctP6jeR1t9M+4tLkeO0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/16] bpf: Convert bpf_selem_unlink_map to failable
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 1:53=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 1/9/26 10:39 AM, Amery Hung wrote:
> >>> @@ -574,20 +603,37 @@ bpf_local_storage_update(void *owner, struct bp=
f_local_storage_map *smap,
> >>>                goto unlock;
> >>>        }
> >>>
> >>> +     b =3D select_bucket(smap, selem);
> >>> +
> >>> +     if (old_sdata) {
> >>> +             old_b =3D select_bucket(smap, SELEM(old_sdata));
> >>> +             old_b =3D old_b =3D=3D b ? NULL : old_b;
> >>> +     }
> >>> +
> >>> +     raw_spin_lock_irqsave(&b->lock, b_flags);
> >>> +
> >>> +     if (old_b)
> >>> +             raw_spin_lock_irqsave(&old_b->lock, old_b_flags);
> >> This will deadlock because of the lock ordering of b and old_b.
> >> Replacing it with res_spin_lock in the later patch can detect it and
> >> break it more gracefully. imo, we should not introduce a known deadloc=
k
> >> logic in the kernel code in the syscall code path and ask the current
> >> user to retry the map_update_elem syscall.
> >>
> >> What happened to the patch in the earlier revision that uses the
> >> local_storage (or owner) for select_bucket?
> > Thanks for reviewing!
> >
> > I decided to revert it because this introduces the dependency of selem
> > to local_storage when unlinking. bpf_selem_unlink_lockless() cannot
> > assume map or local_storage associated with a selem to be alive. In
> > the case where local_storage is already destroyed, we won't be able to
> > figure out the bucket if select_bucket() uses local_storage for
> > hashing.
> >
> > A middle ground is to use local_storage for hashing, but save the
> > bucket index in selem so that local_storage pointer won't be needed
> > later. WDYT?
>
> I would try not to add another "const"-like value to selem if it does
> not have to. imo, it is quite wasteful considering the number of
> selem(s) that can live in the system. Yes, there is one final 8-byte
> hole in selem, but it still should not be used lightly unless nothing
> else can be shared. The atomic/u16/bool added in this set can be
> discussed later once patch 10 is concluded.
>

I see.

> For select_bucket in bpf_selem_unlink_lockless, map_free should know the
> bucket. destroy() should have the local_storage, no?
>

You are right. I can get the bucket from map_free(). I will use
local_storage for hashing.

