Return-Path: <netdev+bounces-248667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E1FD0CD82
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 03:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A69573022F35
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 02:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE625F78F;
	Sat, 10 Jan 2026 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bziJjKEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC7238159
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768012837; cv=none; b=YMr9/mUXqZ8+QpqTeyg81IJNaEZDsqijJvnooqpkX9ySt1LG1y90LHyV9xUKLD9oTv2Lo8y2erQx1XJnF6XOZlNl0m9JCdQOSZj2ZgK8cp+Hi7VuagKZ+rEvu+tbe6TwlOWxU/p5DxfhD0ZcYXZyNo6A+u5kumZWpKnNxmmIjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768012837; c=relaxed/simple;
	bh=1SxIsqUEAexn1us/dXgWbqN7KGJyaebrlCFgxxvhPfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSqKxoJDQmmgGcn8JO6tZ44ov3Njg2EIx2XZLmr6oTF3bCHexHpyrl8COO1lV6BRR4m0Tj1X3vcDy3MxloWg+q5/uANSbmexus8PeOitZ8iz14m1g7vYLiphWcQV8scTBf8g8rdtLg7PPUzb+l7WduZmt9KiRlKyJPCc/27K8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bziJjKEM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so3886856f8f.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 18:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768012834; x=1768617634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUPhPnertLhe8Dwd6BnBPWZPWRSSVIbsf6i73EuWKvo=;
        b=bziJjKEMvDdLATsU8zdIBO9GMWE70znypkjq8QqhN+EDporEAaVMQ9IHwMiZL2L9I9
         GLj4YdtBhlB3gm+3xpmq3L/hlA14OP2y4UCVg8XKwDnJ1mxINNKV+DXrevJe30E5GX7i
         el/FsM8O64BjR5yczuQs2CABTXqKFNDIhd0Glr7fhlj9gE5iSmMEupC7dPh0RxFEDm9k
         cRWEory72teO5ppxnBfv+qFdrDs/w6jk1XHZcliD66vEKCM9S1mwowsr9idUEqYMdEQu
         DIJgTRG6yacuX/nkji8NtmjY0BIE4Xki31bbcPWCEO1F1sXF+UbZh1l/Vj7rl9CIc1I/
         wbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768012834; x=1768617634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wUPhPnertLhe8Dwd6BnBPWZPWRSSVIbsf6i73EuWKvo=;
        b=KyhJnDFlDWnDjHejcTV7jpiQNDjmfcpa4ZKE/JCUTrOj6/Y6/ra1vFakdMwpepaYUh
         euDNakrJFSGT6MpwTe0vYFDOWIl96ZZdxxJtWI21mvw+IAlbdMz5jWvWMLnbF+SBgE0L
         778ezn4qKf3Ks26SaLbcPQzmdAZP1D2HtZE5zN+SIr9QKoHD+NzGDR9hnSlS5QQUOoHU
         8LGHWaenKzsujuojyjrutLdxaOOy4qXCoYeG67WGaCLllxzPeu1zRoqbcTR0TqV94Wzs
         P3L9mzquvthJYNr7ibj5b8hwMzdrHCLFEBMrKwjbIdZ8D6yoRwJyM6vMbCnSBgycJ8C8
         wB9A==
X-Forwarded-Encrypted: i=1; AJvYcCVZeRbpEtgmf+o/JOgl8iLaW4vm8xgGH3/qoMPC5xVK5oY6NhKvHHBBNrFQNh3msBB7Nq7XAaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlwCxra6dzzBQo4vEeDTp99vbkWGUNk0ziSW3KNOQBGmI0oB9A
	yuz7TH00OUNaXz9O67eKPAuDbtu9lOILxMzoBvySJq3ajNu2W1g1Y0/9d6nTOpsKWG4pwJ/EVdA
	LE/TW9RzqX4IUExUUZmoqav/X/EfHzs8=
X-Gm-Gg: AY/fxX71N8a0Ck5OljrcKDhsZt6bSnCo9fBHBcVPlUYBQJ+x+3gIkDSHJluUPiVbk0O
	fOVBqzL+g6MGtjXDJ+InwstddMU2FFvb7HEAXrUXbmC7x8p9neZ5tGJxdE/YeH0ky0emfLGmnN9
	+VlnaWNz0o1pzsXXg8CB/LcBR1hJWgkT6KeuOkE76jxcXhtSTs8X1TMyNm9+tv3kZFPQD+W4TRO
	zFwQBP7WsIe+LdBTl51RZz3VdPUsLjOfd7+LVK3QWE6jlM58sxYUknBUFgT1oGnggB/PDHyT9wI
	S0fN9zs6w9wE8wJz0M10EDBOwDck
X-Google-Smtp-Source: AGHT+IHUZuAsyb3vQ91cVAoljiuOY2kpXkAZ+YC+zBkbNxTarYHC+smPORFxQkwRxluy1QTn0hufXerkK5Vx5AWIXN8=
X-Received: by 2002:a05:6000:2886:b0:42f:b581:c69a with SMTP id
 ffacd0b85a97d-432c378a894mr15215276f8f.5.1768012833811; Fri, 09 Jan 2026
 18:40:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108022450.88086-1-dongml2@chinatelecom.cn> <20260108022450.88086-5-dongml2@chinatelecom.cn>
In-Reply-To: <20260108022450.88086-5-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 18:40:22 -0800
X-Gm-Features: AZwV_Qjn1VvPqinFnx4m7uVmtKxhbfLQEknzypym2_Xevslb15VlVNmv8ccYnvE
Message-ID: <CAADnVQLj4c-nc6gLbBiaT24KXWEpG3AzFT=P1tszu_akXhyD=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 04/11] bpf: support fsession for bpf_session_is_return
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:25=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> +       } else if (func_id =3D=3D special_kfunc_list[KF_bpf_session_is_re=
turn]) {
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_FSESSION)
> +                       addr =3D (unsigned long)bpf_fsession_is_return;

...

> +bool bpf_fsession_is_return(void *ctx)
> +{
> +       /* This helper call is inlined by verifier. */
> +       return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
> +}
> +

Why do this specialization and introduce a global function
that will never be called, since it will be inlined anyway?

Remove the first hunk and make the 2nd a comment instead of a real function=
?

