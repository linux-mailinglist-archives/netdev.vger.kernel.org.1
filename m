Return-Path: <netdev+bounces-238810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2769EC5FD99
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13F0135A4E0
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0F91DF247;
	Sat, 15 Nov 2025 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/8INstA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379019755B
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172103; cv=none; b=KbIlzf+zMytsv2/GyK2HIAOhktgMyn2crp7IM8dr5r02wG1ArACfEZJ93SkGVHL5BcPm+GarWawVuiDm5Np2x22XbSOZ682uCi/XFEQk6kU7NkKqHt9bxWw+GmhgZvfV4hQQxVJjvhl0OaFDAAMb/dE/5SkKwzLxgBbcMHm6at4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172103; c=relaxed/simple;
	bh=/43KkXepOYmTg+RLFX6sLPbu5i/jn78Mlcc9IHgLJf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOppdMGWAnrl9sCBOorDq/emt9U4xRUvmWqGErWkZUbWhIJnq8N1JVIKZdTji4y4uaEDy4F8cyUgX0r9OHGi1ICiHw/NUh4OqXuyQNXMB1Vie27z7nBIwpBpczscCAFWvm2MnUp22nzAEQKi441aoo0nfl8mJiXCZStDLE9ZB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/8INstA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so14624555e9.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763172100; x=1763776900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snvBoq+ef5JsLu+gjGmrgTsLGO/j9TpebBmcGlqRx1M=;
        b=T/8INstA3vrr7Mqcm4k0nqu7RyMIGoz1qGblCC3nr7gtr9aXvaTwTzfyufDU3Q43iN
         Utdw3fyPxcK9Z0Sew+IA7Qz6DcNTL5CrbZJE+/wl8dJMFt6ADLOBaBP67m3Azc8RwRPL
         2weOjAVCn4neETSnbR1gi0n46EAVFkj0wMtCZPP7nT66VPWLkn3psyNCd/MlWymYokJG
         GqQW3AS/vtJPtrtTyslGvzzYV69wpxIb13iMowJTfeRus0qVFaNcyoAipROenRwbIiCL
         v6mAy1/AWTSTbCKk2u8044jJBx5/RL7v6cG6wIXpLl4M/ZIKBQuWq9v+ZXFwyCAhqs1n
         0kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172100; x=1763776900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=snvBoq+ef5JsLu+gjGmrgTsLGO/j9TpebBmcGlqRx1M=;
        b=ZR18PbgAwu1lvm00KdYjfq6/zb705TNtTUdi7JFnCU7/KqJczhO6OlpNR7T2T9Ws3T
         MlSX6JdqZA7pq3eYZV/D7uG7FAx19GDcb0zG6hvDTP6VrlWu7AiRjBDcyXkFsGw96mEQ
         JcmTncF6J0NS5K/252jG+pOVqsov3dPYK0kDEPt/ax5pXbY0FQ1UZ5ewxyIvu3AT58Ux
         QZl7FZyMX3tMQ7IhpXWxHCiR1P4Dvzx3xyIBFqYRCZwak8COtJtRSZywiSOUJCtUkCL+
         eGD0kQ2ojbVrPUwPd2axEyp4Wdzd78uaUi1crl7Oou+6tw8TeNsK7GuEYhWaTNJm7mwP
         VFgg==
X-Forwarded-Encrypted: i=1; AJvYcCU98HNl2KwpLYYq/E4WXBSNCJb6h0W2t8qWg9qWM2KNDVqg5LbGLZ/LWqHbQ61F9qqX16VzG6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoY3jZZhxfRy9I3jf6Kc8HapJL1tR41aaLhZpm9Uck4pZpCNJF
	ag6+bJY8yJMypgrfWDj+qi89pOm1gPd/TchOTmL+akkVkWoH+niVjbvmbREGOBzEPNLYwmGOdQ2
	1PX2fy65ZJ+10rGkfBx2ophp2mFuMqMo=
X-Gm-Gg: ASbGncsG0oKvzljT4R+q7TXb50Ve2k+DCO2hV2X93L6l/JFxEHWYWQ35kIWDeg92xR8
	mHqZHhODei9Mjzb6m3YNjnKYojY+rNgX5TZKBn0gJwta4U6a1LFFuzFRYkOxhUGuDJYx8QwogpR
	6X9QkgPMAxtMy/5zAMSb5Obbgzls3RcVLhTh6cItKzch8EK0im5EMyH2AYkA8xyiZT6kneqcdGR
	ekI0Uba9ylGKv4OaBAx0C+OTM5890wKhztHVTNY8Z5uzsmUXs94uZNfYNf/kfZfl6emByP7FZIY
	0RXolommRVKZkI7RcLTC6CfkoB+5mSo8rv5ypyk=
X-Google-Smtp-Source: AGHT+IFcIbmy0+KdmUTm8TULB/r+E+XQFU7N48InvlfGYO4yRCsNOw+aAzQYgliXTXvofhb9tnNDN8rxRdQuNV1vJuk=
X-Received: by 2002:a05:6000:2913:b0:42b:3806:2ba0 with SMTP id
 ffacd0b85a97d-42b593234camr4860658f8f.2.1763172100006; Fri, 14 Nov 2025
 18:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114201329.3275875-1-ameryhung@gmail.com> <20251114201329.3275875-5-ameryhung@gmail.com>
In-Reply-To: <20251114201329.3275875-5-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 18:01:29 -0800
X-Gm-Features: AWmQ_bl0zPxy_ssWz8jZphhCNVf_RE23q-z7MI3UW-rrA4RSIF6BfYq7BiradNM
Message-ID: <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] bpf: Replace bpf memory allocator with
 kmalloc_nolock() in local storage
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 12:13=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
>
> -       if (smap->bpf_ma) {
> +       if (smap->use_kmalloc_nolock) {
>                 rcu_barrier_tasks_trace();
> -               if (!rcu_trace_implies_rcu_gp())
> -                       rcu_barrier();
> -               bpf_mem_alloc_destroy(&smap->selem_ma);
> -               bpf_mem_alloc_destroy(&smap->storage_ma);
> +               rcu_barrier();

Why unconditional rcu_barrier() ?
It's implied in rcu_barrier_tasks_trace().
What am I missing?

The rest looks good.
If that's the only issue, I can fix it up while applying.

