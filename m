Return-Path: <netdev+bounces-248668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E91CD0CD8B
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 03:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA1643024D57
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 02:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98C25EFBE;
	Sat, 10 Jan 2026 02:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Teb8aDVT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8D239E75
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 02:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768012963; cv=none; b=HiJrgPgIBudKspKuwAsTVIAStTp5bO92wvRmDF0cW6bkfPSj9r7p9RBsC/niKHbQW7YDB4B4Otb0PNJquUMFcpTNciBsAYrCJciON2qze1qxxLs3Hd1kh5u5bDN0tA2v5gTANeLhFB+N4eiaIP+Bd9AydOELdrO6dPoTky7fDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768012963; c=relaxed/simple;
	bh=Cs/hrKTGodK2hLpEUcdQqwz0BRefB04X3sFppe5CwEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIHLY25QQCDSgJFpUSMsR4pVpF/+1fA3Y4PC1HOr8I94WiV51IuN2OyjzBFzZush0WjQsNVHvbLP2kGkC+EpwLxIf88F1jRuPPN688YhJ7i0TQexivQMekTyocViMm5yqHC4346crUmBk73YZC9QZIvHiEScboE9Cprv9DOIeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Teb8aDVT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbc3056afso2681211f8f.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 18:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768012960; x=1768617760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YC9+biAN1KILtegWcGGy8UcYztxHh3eBFiLomvxFRos=;
        b=Teb8aDVTj3Fjd56kKX402RQB6r/s9qjKd6iM4k0yQtvq21XI2D554B1v9BTT7XadxI
         yn0EPIjn47sd0ihh97CqNpC8Li9oDMzPF3BPmWv6DNnWtOggryeHQFzhzECtcWNfQGNJ
         o/5lGlHebG5gEq4C3wCPncAjuaMXlLqJM1hFsuRUyxG8JCZcJI4oIAUZpJQSgaV0nYtM
         qq5drN+2XfD5aJMoDKpiRKrMcXK+tzqIeHIwFZBgqbK4CGhl9fvMyMjhKkhOEiQlsEXJ
         tzZHfgrtUMl6OcV/kEsIj/nWTpjgvOvjruCAVpMhCnacLH6o66rZRlhCZsfN/+fF+cUx
         uZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768012960; x=1768617760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YC9+biAN1KILtegWcGGy8UcYztxHh3eBFiLomvxFRos=;
        b=i6r2q6oDSlcNt1D7Z1tG16xuYk+IcFGwlsd2OxjToh9tSm2zrGx9oGWbbHQpdsRvnw
         clr88VYyMyEftQoe2q31JfWf7tQf8ptwo4opuLeGnf2gaSpeax8g8ceZOm9HEd2H+63P
         sgElP8J72LEFcpZDAnjQPZEYAU98oBwzLE/33hwPe1f27qxvCDU+k74rHvVaRhRV2Wu2
         anSo1ojbFrxzqQU+3rfpw9GCWoTOBqV7M2CFjEdxcnzOmq7EMgsnMaf0tRrtRajBQhGC
         Nn6wYhtUIZSYpodTEX5+L/wmrrLMOWZd3UO2GJU1HFt/wBcZkqT2vkzWQYXq+aVDyOcu
         Kf+w==
X-Forwarded-Encrypted: i=1; AJvYcCVUqH8AJwBIzSt8PDD40D3URnPaYCH9m7qamDkO9ZaXWeyO8wBC6vu7kEJn6SXlAKC4aKukCeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Roqx0zSap3Yguy7u5AJ8RG9tXJaIKyoYImhg9SdX2H9Jne+l
	IVsT9Czw+hxIC4U0WaQA8ZnWi6T6HOtdz6Prqz81Ok/+ti/ak+WEbDMPCsoMNp15WkT9W4aNESD
	7Sm85Ue+i8d8+q3BpSLe6KYQtpvMUvXU=
X-Gm-Gg: AY/fxX5pMnO1I57WaOENDElAr/llBpNXgB8wbo5ClrI5WI62jqzW0zeak/iPFy/fv0U
	C6Bn2DYZqCwOLFvEZp5ZFSEJqwwep/aZcMs8AuWiYq4A4pAqjcRgJwkea4kpb5vyMONuZSNAudk
	nqwZFdBQP20AihkeGZXPfY6opVhaP6etuV7YpYX3gEc50R873ew0je1sT1yy5qmEotZyM9RFZ62
	Ttyenmu8IMzN3vjjrk1TmPZgoLMrbemofFihKZrTLRSYBG+fAhtJrwzWvDori8p6sJO7VTYXBVA
	wsfJr4nOArWDU7dfEgEAPk8sp8eF
X-Google-Smtp-Source: AGHT+IEqVkZzGkstjdYrQiTVPP2vr6lxGNdwWrtx+26U3tqXFZE9/A6kLQ8NdQ8dOEsX8G/rPjPKdB4RZ2K4vvQsbcM=
X-Received: by 2002:a05:6000:40e1:b0:431:488:b9bc with SMTP id
 ffacd0b85a97d-432c3629b8emr13307356f8f.10.1768012960014; Fri, 09 Jan 2026
 18:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108022450.88086-1-dongml2@chinatelecom.cn> <20260108022450.88086-6-dongml2@chinatelecom.cn>
In-Reply-To: <20260108022450.88086-6-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 18:42:28 -0800
X-Gm-Features: AZwV_QjQLPM4b4V-6CUBAXR1QS1q8Ht0YXFasxqaYRvgD-y99rqQyXQ9HcUk62g
Message-ID: <CAADnVQJtyGS5BQKcnzsqRNEDO7Kcs_89k6Q5tBi10iaff=tbtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 05/11] bpf: support fsession for bpf_session_cookie
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

On Wed, Jan 7, 2026 at 6:26=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
>
> +u64 *bpf_fsession_cookie(void *ctx)
> +{
> +       /* This helper call is inlined by verifier. */
> +       u64 off =3D (((u64 *)ctx)[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF;
> +
> +       return &((u64 *)ctx)[-off];
> +}

Same question... this can be a comment.
For some of the helpers earlier we kept C functions to make
things work on architectures where JIT is not available,
but kfuncs require JIT, so for kfuncs there is no fallback necessary.

