Return-Path: <netdev+bounces-247212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A6CF5D72
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 23:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A07F300B9DC
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 22:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B339B214204;
	Mon,  5 Jan 2026 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVm/eDv8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080134C97
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767652432; cv=none; b=dn5UdFUe8leDaFsfzfej7zehIdxzIyNli3YWg44pgNYZwQnDJUQ0hU3mfBtT9FfHGgBfsp/zSZDFzbF92Urb9A7yQ5eS4XHWEedeat8dyG6x/Ksg4EwAx4hulQlroSqluNVwFx7hXXbp9tee5bwwBadHZi+9DAAJA8ZqAOeibnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767652432; c=relaxed/simple;
	bh=XyNAwwSRh0ea+o2ZHOIEDYhb989XVxYoKerSYaQ/rQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPMU0Sud9jTJHVjKJbXt+kz2yfv/cOl9myeUuN7dWIMk5LowV2Rrf7CwVQiW7E64OLsSrUn3/FaIEto054s67LTHTiiAOFboAro8b9zwecTuhbsL6a/XTD/HunBS56o8TowX+KBS6XDiDsXIwQgLwh/HR8Skx1fcnKGonVmW+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVm/eDv8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432777da980so197080f8f.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 14:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767652429; x=1768257229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyNAwwSRh0ea+o2ZHOIEDYhb989XVxYoKerSYaQ/rQY=;
        b=ZVm/eDv8N37bbOM6hOGKc7qWOVpkszywAPB/VyQ7db66aDfHM5+C69+3I3Q7umqdp3
         /nZeJUHqFpEu4WKCrEI9+txUR8uLZHY/1uC4bdcCGyNZuqzxVoacAVJZTEhQRM2DpA+b
         o/W9l3RX98tWKcJAh8VzXtpUv6zFLMkh5swlfNkQk63jn98Mo3G2NruFlJDDLCv+4r9l
         MOmkOBWiSSzXfLWfEMBC4cRUg2LOfPi8fWJ7qDnpB+++eV49oT+L3JY53OBwM3rbUGD7
         cR00aFMb+vLFGvHAppnpgW/pNOSIGxntolZ2tLa8QIi3IRsyQdgX7CtLbnw7cgZvj150
         Swxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767652429; x=1768257229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XyNAwwSRh0ea+o2ZHOIEDYhb989XVxYoKerSYaQ/rQY=;
        b=O5tTiSPbbkiRGMRJOAiF+A+7X+Ho4+2ffsy1sYuqD6wb3yPv3V9WMxjyn8+TpdMCDH
         E7DL1BFTEWmymBz2GZVfZImx+lwyDmc9TPY/sVSm3K5mgRc+jXqA7pA5k+ejFTLeK7YO
         rwWa3tD/FRTyHU8zk9VY7bYAvGnxJIBm6KPORs6EmODXgqKKs3SOZNy4migYwVIpTX0U
         uB9aEwpqzuBKFSpGGt8OEjAoOCCmJSafwoWXVwNii4OHPQjc/3nNKUPdXVqqueOdrL01
         bAShnpP9Dwt5xk0KJQfHl8GbOhvRQvC8kVzvV0m8NKZcQ6qC8yP9Fwafi3y2xDaagwsg
         IlCg==
X-Forwarded-Encrypted: i=1; AJvYcCXEPMpF0qe0UACw5hR2viRN5+8CvwK27b/cGeRc5ekXSenfeBK3B2kM/kqXTjfV2cKlhUqvXEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfAbLtQd3ypO5szedF+a2BxPBIkBMezkryP8kP5fd6a63qSOts
	Xbwuy93mROK+b0bKzSLFdii45mbhW9vmCEnv6AKDby+ScFgbeAdNMPRQ2mzQGAOJD3elN0EBpGo
	aB29GP6YpH7cXGXRFygn0CknNtCYDS0s=
X-Gm-Gg: AY/fxX7M9W2idGZ6PerHThHJM7+MQXEB6tZuP9pZGZhy+djju0y2QI/HG0DrHMEyPtw
	/6riaFLIlvFmlADj3VltJxL6DZbznGdW3X+f/qMQ9tjjB/MresTMiGC2uWaD3/pbfxjWF1Zw+54
	ai5LAR2tRULCuZG4aJWDxTUZB9L6cob+RL0vCGAZTvkCWI18i/eU4mmpQRIbIvSMkXSls7LQJvt
	2IeBaj9G4FyGJNX6GtS7ZyrHmApRJGtWnbltyMKLLhu143e8hHJBNDsc3Yujwv69oxh5oh7hDUq
	6VcYZiiRVgE/ekN5/RUIOUgeHiuc
X-Google-Smtp-Source: AGHT+IHyUpIlnxhLNs9vUwOvPHQQkiLrdEPuoA1MO0lPN9p0H5yKaRJgyCbGkX+8PkINg4466J+7ncc9++EAa8JDQNw=
X-Received: by 2002:a05:6000:2411:b0:432:8651:4071 with SMTP id
 ffacd0b85a97d-432bca2b8b7mr1501402f8f.18.1767652429277; Mon, 05 Jan 2026
 14:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 14:33:37 -0800
X-Gm-Features: AQt7F2oN5dSGx-LIvpN3esAITXjbM-Mv5yyouCpQWhrn0tQffiQ6Jq60jnulvQo
Message-ID: <CAADnVQ+cK1XvYrBPf3zuNmRF+2A=i-AKGaNV4SoeTUeGRLF2Fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/10] bpf: fsession support
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

On Sun, Jan 4, 2026 at 4:28=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> In current solution, we can't reuse the existing bpf_session_cookie() and
> bpf_session_is_return(), as their prototype is different from
> bpf_fsession_is_return() and bpf_fsession_cookie(). In
> bpf_fsession_cookie(), we need the function argument "void *ctx" to get
> the cookie. However, the prototype of bpf_session_cookie() is "void".

I think it's ok to change proto to bpf_session_cookie(void *ctx)
for kprobe-session. It's not widely used yet, so proto change is ok
if it helps to simplify this tramp-session code.
I see that you adjust get_kfunc_ptr_arg_type(), so the verifier
will enforce PTR_TO_CTX for kprobe and trampoline.
Potentially can relax and enforce r1=3D=3Dctx only for trampoline,
but I would do it for both for consistency.

