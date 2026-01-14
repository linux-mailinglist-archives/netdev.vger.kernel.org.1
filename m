Return-Path: <netdev+bounces-249658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CE3D1BEC2
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 027173068FB2
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE9429B8D9;
	Wed, 14 Jan 2026 01:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lduhi7b9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E5C1E1DEC
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353880; cv=none; b=lX8vTiyLY41uTWRU4JppSKZxKxYerHPHOLJSxiiU8VGH+lgW10ZtEN1w+Xjh97+3VlqpDJqvYZuqP+mDSBpsz36gpsZHZesMNIYh5hUa2HBZbuPfPW8dulYTv1IRSh+l4BmaPJBKtF3ijUSUN0gpjZDag4rfQP+Ndp3FlSpkbCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353880; c=relaxed/simple;
	bh=40BrPp0M59FAG3TB67K33T95VY+/hsIzuUC9ymB75As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeXFixkH8tOJ97CS0O5X4a2IeQQI0YEbGyhwjuJx3Uy8cqSfMr6xdxzdVk1G5WfpKG54a3N9i3KZFN4L6U5Pyg+tA1CnKB3z6INxLyDi80bVgnv8ttadPtIkSr+HYX20BJvZxckSEHEBPvonlbxz17hLZleprwSaDacjyGbNtMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lduhi7b9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c2af7d09533so5226514a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 17:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353878; x=1768958678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLTXxY9Q3BxypQ5k5gaq+M++dRdP5vB+e9T5tp/A1X8=;
        b=Lduhi7b9JGo9tgATMp6qtU2LnoceB5hIntpf7wC05RfdUxZ5TmknqiuM0OrLccjsao
         pJsSHoUuBPvnKs5GHslc4ubbuqmX8FxBZmxhfv81/X6T89eNSFI1dM0R5VNguWuA+38v
         E4pvq8QP9vVoSiI79wH6rqH17uwQ3j5ytR4y0z3bGlycDGMtG3OagIxASBZddHx3efaF
         chkLLEsNR3FabTqKvFRVxPmDC1/bBCnpHCRCeNecu/Vu62Ncaq7M6dUO6TpUYSLyXTvl
         VLah2k3BkAOVruDI2hYTubkO8iJ/wqdKo2YacP+S6E9CtVrQ5OSBbUcjFoBWw7370cZV
         VQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353878; x=1768958678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LLTXxY9Q3BxypQ5k5gaq+M++dRdP5vB+e9T5tp/A1X8=;
        b=MmwbQKJhlQrbaYA3LsnIyMvSwIuySlpNGCIHRof55oCeCVdX7JanbkOQb/MSuOIgsP
         D49L5i/SxWvj8acg7wuVJEXIgzq/g3tf9H7bNyyCWlaf0G1lfeCOEqS6QrVXLvHoK9Ud
         WjzFzTLIlsmlfbEaN1ZUQrTTs84s4kI6cOwotuzuYeigozgvO7QAV76JE76l8NMJPw1n
         Uac3VA2iqh9bR6lgK5qxTbY7EhXXEFHKVnLXJxFj9fbJkNwivvc10XGTd2jBaNq3BLbx
         vZnWK7OhcfLUPrRWrRTbwsIJHAqKLOWvVBa17WH+Qz3zukcWwtPWH0QklllFDjJMDvQE
         atWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRY9Vpc+mC2YqtsNNLHHr00xEKnnVxrYk8hOi/u/s4g0a195W+rGB8yb4CS3dhr3b45bT5V80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgcQt74IiMTHzGsPwoNnByqliirhIYtPoTdbJw6S21mQ79QwlW
	MwazCzDuP0Lw8esDJnptk5aGNL2zSbaegsmeAI6hgZCcqsteKb/8tMN+qBpvhNxZi2ScBMpLiZj
	VdgnNq0df2hyxBlBeQY5jCH7M16/pZgI=
X-Gm-Gg: AY/fxX69yy3gi60POmKpGWqh/iKl9IYIC2KD2Q3+gwugPDgyTtkJ4Hy+S323L4MwhzS
	j5UHVkKA9hPGcY+rkaxuVKVxueQWrKH9kyVzCnILFphwC5479jhj93G6Xk/5S+/Op+xtPpUAgZb
	lgdw3B5643k7DIkjzm2xCpCYrZlw+C9FkTtXlEsCi8nBb4ePoCYDNVIWPGbgB1KL3GUpsT1TPqq
	y+G1pLJptrXvV+p4CW/LNGTXxPQkXHVCsEnbvQyEEURWktndId+LGDaXN/BNfSpW3m6a+EkeEhJ
	NnJpqqwGDaI=
X-Received: by 2002:a05:6a20:4310:b0:36b:38e0:4bf5 with SMTP id
 adf61e73a8af0-38befbc7dc1mr430207637.51.1768353878382; Tue, 13 Jan 2026
 17:24:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn> <20260110141115.537055-9-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-9-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 17:24:04 -0800
X-Gm-Features: AZwV_QgZnDXM6IYPYS91-BHZn70EC2birCKZHLzCw6UXKOTHAKflwo6NksxnPSs
Message-ID: <CAEf4BzY0s2fe_Xq4MC2PiQaiYZPic=O0mfMaoF5HW-gDnuMQhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 08/11] libbpf: add fsession support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add BPF_TRACE_FSESSION to libbpf and bpftool.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v5:
> - remove the handling of BPF_TRACE_SESSION in legacy fallback path for
>   BPF_RAW_TRACEPOINT_OPEN
> - use fsession terminology consistently
> ---
>  tools/bpf/bpftool/common.c | 1 +

I know it's a trivial change, but we don't normally mix libbpf and
bpftool changes, can you split it into a separate patch?

>  tools/lib/bpf/bpf.c        | 1 +
>  tools/lib/bpf/libbpf.c     | 3 +++
>  3 files changed, 5 insertions(+)

[...]

