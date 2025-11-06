Return-Path: <netdev+bounces-236486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D4EC3CFC3
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 19:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7AF3B6DF4
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25606350A02;
	Thu,  6 Nov 2025 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSa0AzFx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273AD3502A7
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451883; cv=none; b=YbFl7T/77TtH8YQWsAYO6pWtIZR0x4DF6I90wMfa0Ocdpma6ds3M2+8xGJkhF8HclA22KhoB5gmr3ZAT8qNUsyBTXjQq+1R9gDC3XyesjjDmJo5YFL0sIGgrELennPl7s6Cf+UgAWRU3fnYNuijQCnDZ9VJooaQCQkiqSVVg/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451883; c=relaxed/simple;
	bh=glDJwADkOumTnv2wh0y8hasj3tQrqspeLBN3EP/hPeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bM6PBTx1yQtMjw3mSvNYOWbh7oueuDAboZOgI2CuBpQUHsOqfjH2ip/RTN3499GPu1iyTQFuMXMkg4lblAvyRi9572baItsP4UjHrVaJWzjG1LiR0htD0AKk9F1aSFL7ccOcdCNAtsnqpC+TCe+0PG6ehuT4kk908SHnfeddYe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSa0AzFx; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b994baabfcfso783251a12.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 09:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762451880; x=1763056680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq2BG8wI9bIT4TcMCE4faFvSiiQMg+JzNyI7cyMI09g=;
        b=HSa0AzFxYv7Eywl+uuTcMiBDZCL4x61QFtqaeTalq9vAF+EBARPsAutYojSSzBXY/j
         HgyJE+Kczrqr/XsUX9wkUO0jm1ekeMQxNjTWYQ6aEfcry9/BrWxs2nxG2C0CZZwngyWL
         e5a/dtezsaRTnUneG7iAnR4TA4jqBL436pwIqVwc0XmggagxM2jLRTNHmxO0bwUDFeqL
         VXeGMsQiMuCmT8DtKZlDXcb3Y+BA2LPLPjArZzaRcjwENq4uzZLV/vkRTZWuBlrbphIw
         KGAUq++7NbOMwv5wnOBWVWpeRTz7duDVEwPCmRbIp5Jp9ksCqL6qiG2Lxy4kRjRzKtom
         Omvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762451880; x=1763056680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qq2BG8wI9bIT4TcMCE4faFvSiiQMg+JzNyI7cyMI09g=;
        b=MEIz6Fn4x9PF5LtReMbkhREJmCkmX3H2V+vM4EvHYl/i/0v+/RI9SgnRpqBRfvcc4T
         yWgP1vnseINLA6DumMc7/RV8Z01bEWFIbiGUh9KKvfRdrycPbkLsAVo87Tb5KNfOOVBF
         jr6jHGVnHtSPV6n91vcNX8nbZ4dqnj0eSi1aPZNgDJFC47TvujI4HuZf7bAOK2ipdkDt
         3U58odo8xQqocRyHjRHKxansMgTKf3XLGyFmBGWfbnzsIJtTHkci/b7+8IkBSqJdyOhj
         W3uir0lNTQnRuW7rHeVnugJXTG8HhXBq1ZLF15EJLfaYsNu7nfBH7SvTk4ygnR7N9ar1
         oe5g==
X-Forwarded-Encrypted: i=1; AJvYcCVRSwq0XdiEVxX9cRS5YxkhRh7/7B83zcyEDnd/8cisvG6n4eN0CPSTLODJf4jpIyx8KdqR4go=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGN02tjEZounXRIKHc+Tvc4BUuPvkrmcq27HKHUskF/UOg+Ia
	9HipSb5f3Bbp3HkxeU8KI/9y5KtD8FavQ2+PhB10Atspaa4+jVJnTB6pJ8Er5wGC001+4UT82C6
	nTgVpVnNWg6EFvOs+FUOgWAi5ALlxUT0=
X-Gm-Gg: ASbGncvxHXUoPtqwHlCh+M4OKeTIOn6j4vx1tQX+Tl/wcrO9Tn0nFF3LiIiqb2ElxPM
	1uA3Don+14Lr79FXtTcyUgfn97Hr3tkvClNsZPvDUxDSav+YcJwkpx4dLB830An7DWB51yccjHi
	ZLXyXoCV0aY74U8P5mR6Y20FfC9nc773tatJVilRYIB6FPFpbUdh5c2rrsmwwuCrNF6oNsZCkTI
	Myft3ggtCFUV8VO0BlU1Yn1EHNWtn8XcoYP05kAqXCLmo5KgxUgM5xjwPjCXNt8K6g1RnVwhBlv
	ltJaxJre3jI=
X-Google-Smtp-Source: AGHT+IEo2c3LTKhoAWPaU5mA29bYX/vQ3YlDfexEaLKPDZKxloUHe6GGY5t624x7bqLaqtKa75S0FMw4WhtkQE0EKKo=
X-Received: by 2002:a17:902:db0b:b0:297:c048:fb60 with SMTP id
 d9443c01a7336-297c048fb72mr3932805ad.25.1762451880461; Thu, 06 Nov 2025
 09:58:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106113519.544d147d@canb.auug.org.au>
In-Reply-To: <20251106113519.544d147d@canb.auug.org.au>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Nov 2025 09:57:46 -0800
X-Gm-Features: AWmQ_bm8E-PozACS9d1X9w71i5ba0KKhj-9cPqMEYJ2xotNsfTlmXkti2aB73FA
Message-ID: <CAEf4BzbDyeMG4KdgryqFTTT3t5EQWRsKf8n1W6AHL_VOW0SC7A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:35=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/helpers.c
>
> between commits:
>
>   ea0714d61dea ("bpf:add _impl suffix for bpf_task_work_schedule* kfuncs"=
)
>   137cc92ffe2e ("bpf: add _impl suffix for bpf_stream_vprintk() kfunc")
>
> from the bpf tree and commit:
>
>   8d8771dc03e4 ("bpf: add plumbing for file-backed dynptr")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc kernel/bpf/helpers.c
> index e4007fea4909,865b0dae38d1..000000000000
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@@ -4380,9 -4531,11 +4535,11 @@@ BTF_ID_FLAGS(func, bpf_strncasestr)
>   #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
>   BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>   #endif
>  -BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
>  -BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
>  -BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
>  +BTF_ID_FLAGS(func, bpf_stream_vprintk_impl, KF_TRUSTED_ARGS)
>  +BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl, KF_TRUSTED_ARGS)
>  +BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl, KF_TRUSTED_ARGS)
> + BTF_ID_FLAGS(func, bpf_dynptr_from_file, KF_TRUSTED_ARGS)
> + BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
>   BTF_KFUNCS_END(common_btf_ids)

LGTM, thanks

>
>   static const struct btf_kfunc_id_set common_kfunc_set =3D {

