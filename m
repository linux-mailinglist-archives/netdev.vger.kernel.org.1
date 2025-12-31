Return-Path: <netdev+bounces-246454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B8ECEC708
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 19:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 658E630036FC
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 18:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2BB2F690F;
	Wed, 31 Dec 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eMIZNaZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE652F616E
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204574; cv=pass; b=JIpWgf3KS/77uIrpFjol5UxSpB9uMhtT7gpbhzD/obi/YIhiTfaRzBtT9iGW6cZVz6uwPZ+wDZsH/qRrGRhS/9JEZjLD1G+RvCmgo7HkXTJLNMIHtbsYMxSK3IO+r/CqKq7r8heXrFk8i3Kj5zZZh9/CDFNzZVyA7yXwvr05oto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204574; c=relaxed/simple;
	bh=Mtz2A8tWa233gsaBDZq5niJH69EnDrxIcs8csRo3gmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HH15ZkcOrEYdHBW6BOVNQTUcPDWloPjGZ0qB/je7GXSjIKiLqp1X5+eMRjx68uj6v8atCWKHhftGPp92rIKAxtXkjgKLwC0ewBGpjV9rNX8M1tqlZtblT9tG/pkr8L8kcYwGpmjJBCvp/Pu2SsyseRyz4rsj3wH7FAmANDOubBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eMIZNaZx; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c2a00109fd8so253198a12.3
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 10:09:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767204571; cv=none;
        d=google.com; s=arc-20240605;
        b=RYQBzvt4oq7+DYTSRTcIv5Yom+MartuVhI7rs4bVvrq3phR9sFXzH8rXbjyQTgrnLT
         mzETgkEiELVCbGTPm9RSlgLIkXEjWAlpYUfcoGjM4r5gOBiDu7BLBT8Vi5LoeIl3bCih
         hLQQ7gb9+Nhyg+a1ODdLaJLWbVL4PutdCqx7ZXztVKhhPjBJq42hBgDlBAowwL21H1sL
         IIUEMG4dmuOygcrMa+SdVcU0+QAtjTmFQoWmHe8ulhS2w/mtwW1PNM78udS0Ae03OWKl
         z41NE3vr/gLimshP0XxUAWfzKEwtWWpTUvEdp2LlNBihHOWVW1jmuo/AAjYoLfEUZN3G
         re4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        fh=82j2yDanneCoE4l8HoMd4k+6lYCmgsd6I0FKBk93iSs=;
        b=ZSgJY2vctyORmjME+1dkc5hQYpVkkA2YjmRRebHBV1HXFhisK6T6yqLIp1bfMwKCM2
         uPHIJtmf/CLQzgYWswurasJOaZKEL/WwUN8R1F0Ls63gJyeD27z2KuVqOkHg8s9kugA0
         NTcZsZfaUaKYyoNC6IvdJHnJ5mdywXyltQhF9g8Z3IZZjk0tzJvfi+56kt5sj3ENsSem
         R4wDnsT83c1REGSW+1Ix9VdgaYhiCSR2zpYROWUopjTeV7jIozOINf+G5BjwEEek5AsS
         6e239K4dDYkzK7nAKfLgCObuj2M+XU7nLN2kk90waK5f8BlXNy5NfzfqnhkkpIPzutKB
         ibng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767204571; x=1767809371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        b=eMIZNaZxBhjFWbRV5ha9XKWe6+Thr83KYVjbX2EkOS0ijkIS/ouyjp0CtYoTRWnilM
         e58ePoaklivu0fQntxNqGZw9WUotToDYHEVdITkDaRpzEbVk0cI4e+0WXxKdC9aGjZJj
         JgFBFp0fhc6aUWuQCuIWhwiQ4wMayISpnxgDrXkOgMY16odAXqHr9AANLOBFS7j+6a5F
         fJO0q61tAgcea0PhgKSTCegLBw7cy5T1i8LarrJq8r33fGcLXBobunY3aVGko+6xOKhS
         RkYLDJqwAvKBEaH/S64IIxntuSDjfWqmS+f7PwuwiOI+FcPy3dSnealEdllqritOeNLy
         1TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767204571; x=1767809371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        b=Z2GMY+RANc/OD667oU0To/vZ6rJt8E5aDP34BHPMHcD3/HvaX3gKm9hV9t0BJE9YVH
         sIfeaHcAbVYR8QOdDss0GvN4nOWw2IsGf26QGSxaWGEwjaRrKC4Xb+WEXScW1dPWbYoY
         6YGQe8B7+RD2f+iyoyKhyTWW1HTxRn4dwxc5XLvAnNEoElYbL5La1zLLEweOIFGBUuY2
         sk47Ho3JeCYULo0hvJN9dEkqv30CRnCOoPMH/qwVdU6uK4Cww5iHjzPkmdl/O3WFA2t2
         Y+c9LPwpKp19fogFNm34rw0Qyxw1QqbauTCUOau1awo8Z/bkqlanOfu0JaDeXe/vbcde
         7nUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEWR7Rtd4fleM5N3/8VShL0SBbuSV+nVarJiztX6tJadAO1Xv2rfdi4zTFwEbUCH0++BLs5Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9aUxFxYc9TWHMvXZuXuWOcw4jZwDBwca7H+HKB60neukgPV9
	Qwix4omG3qT1pxgumUWFHb0MFWexviId+jyqd1qsytPdCpNclv5Gs6hl/AoGxUYXxQZbLKu3/tc
	S1Xl6CmwBORrCFRaNlXkHeatI0sGFnF/da6YMjPAH9A==
X-Gm-Gg: AY/fxX51Mn8BHrjMD9jvwLnN2ZmGWNtoNPme4TW8r/6XhDGZOrR/hwA5R8/1d9LgIxF
	4hVK1hExzbnfDSFVoDtX9p2EqkkuywowJ+mg8FjtUu9kw8qCC3GTNW4OISCxu7ZXslD2WBJxnfh
	GKKjsPWEUICSXUBWvBsBzP84l28FOY0fzBuJ+PZZ92zyJUjjj/1xh3U3b3QpDlAumdlGyfW7Nkz
	WiwV4IuipXmr0NUrlDuJtiBkFN4Ez5x0qh7sVhQdSAHZxx1d1pXbdX/gmBclQdvNyG4VOjZbGQo
	i/m1Rf4=
X-Google-Smtp-Source: AGHT+IEoQb+VMYUZF/EVHfCupM/J7UKB/HyklpfhaHst9+Iqt6sXvQ7lmZWvrOhCEyHebOWe5s6vxpHZd7OfrJbc6Sg=
X-Received: by 2002:a05:7022:6194:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-121722b44b3mr19049815c88.2.1767204570391; Wed, 31 Dec 2025
 10:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com> <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
In-Reply-To: <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 31 Dec 2025 13:09:19 -0500
X-Gm-Features: AQt7F2q8qmB_ZWyKhj1fKhcgEDCzRqBwfvvrWtG8WY5Jchb5VzTDRzCjSxJzD0s
Message-ID: <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: bot+bpf-ci@kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, shuah@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/too=
ls/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > index 90c4b1a51de6..5e460b1dbdb6 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>
> [ ... ]
>
> > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy, =
struct task_struct *task__ref,
> >       return NULL;
> >  }
> >
> > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> >       .test_1 =3D bpf_testmod_test_1,
> >       .test_2 =3D bpf_testmod_test_2,
>
> Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_init(),
> this struct is modified at runtime:
>
>     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
>     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
>         *tramp++ =3D bpf_testmod_tramp;
>
> Writing to a const-qualified object is undefined behavior and may cause a
> protection fault when the compiler places this in read-only memory. Would
> the module fail to load on systems where .rodata is actually read-only?

Yup, that's indeed the bug caught by KASAN. Missed this mutation at
init time, I'll leave __bpf_testmod_ops as mutable.

Thanks,
Caleb

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/206242=
06229

