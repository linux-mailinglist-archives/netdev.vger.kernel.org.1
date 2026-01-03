Return-Path: <netdev+bounces-246631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F61CEF81B
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 01:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E5CB300103D
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 00:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A378E3A1E71;
	Sat,  3 Jan 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFidOoKN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A321373
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399015; cv=none; b=fhAU9YzqxBlX45XFuDDRqvSy/e+g7OKnQ5mTrbNY5IWQRpRDA5o4+iUFgrLEsngQXOtpAWnH8rpe1sBSHlmKcC9J+1ZBVPWM0h9qds3kcJWczcCGGkjjc9VXXkbHguqv2ZjvCJTSjGUQicpAOA/h12e6EnQQeAvd11a4Dh4AOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399015; c=relaxed/simple;
	bh=Wa8Rpr+cMZHOmYJm/4DjGk4CXcoJ3Vb/eT27YqUk0u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7t75t2x/M+NP2tHco73Hr0USmByI5+jlkW/M/ol0XcZM4zNs3ZAKfRkMiQdIavVAhEcGZjGhaksrtUq3flq5UtDKvsBM4RLtHIPPHJH5wSRL0fewsb8L0JqVC96MrF2HBUUCejNdr6QlO4gAakiThBejUHwpwyDawnoJ3gRlYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFidOoKN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43277900fb4so135823f8f.1
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 16:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767399012; x=1768003812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRbbVXHTYPc2VKqPCXqyRbK5cNEYW6ST5IZJzvZ/sWc=;
        b=PFidOoKN+HTQ+d6swltktnk2oSkEJJzaRmOsMEcGFjLK72ytXjR4pgcaOl3aUb+nkj
         M14U7sL1Wgk3yzhn3JIza3nntrDcDUjqaonINHj5ijldS5rw6EwND/UZVijok3wFmb1q
         kstvHbK0NyBt+Iyh1T0npqY4+MA893mNK1pcjpnpB+ySaIy8XxEpm7zQ6Ee+UZ8ZQkqX
         LpyG5jMkg3Z3aZy7VoZX7WgBa2Cwvdq8nNlyA2z0HDDpAKkW3G+qtWYKl2JErdsR6PYP
         1106Wlo3LqjtBHiIBuLo6a5GUj48JrF/os6kCmQR3MubODv1vZFbEZQS28vDlHS4PR0o
         DYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767399012; x=1768003812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRbbVXHTYPc2VKqPCXqyRbK5cNEYW6ST5IZJzvZ/sWc=;
        b=txB6z3RqtCnHrHpDB64tkUoF20KoamdJed4oF2CiLzLKgkMXkMpgffCLtPnVaSigHF
         WXsRTBOBbHuN1acdMeIkcT0mywbOPwR/fGpnECXNtW+IK1P+oNXqxUGZ7i7tzxNVKM6u
         R1kvMEXXC1cG40XG8iT+R83mMeRyrzrTKsFb1rs5v4YrRaZZHWj5EBG/5TPBNyDdydf8
         GK8nh+/2TfY02DNbeaWAlUPe1pCxSq/7spADN6Bb+G6Z8dsMY/MAhEzTXN+kHtt7w9E1
         PUX3n2WyhAM+Wn9Wjx0x1XYbiLtgEQTEQpT8P47ZBBx1rzIrt8cIE5UHr0g5JnYG5t/P
         s6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCW90LjkSFcffN2AZ6YAugmJ5vudAoAr9JulRPVpulSgTOCAGCOaWxOCgaMRqawiy2XLp+mbW1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx7CXxsCAiggS919u1BWlwHLMubfuo5qdkJ62ktYdJlQm6kkq0
	ffgX0jDIonFcaMbeSSBMTxgeUEdfnbcU8ecvngxhfDFTP0TKrkbvWWajkHOvvp92TymisO+jI06
	RjNtIMiJyuMuE9N7XJmte9P31PbYlNls=
X-Gm-Gg: AY/fxX7tQqTTDUqNVCbSRhJd86YChB18ShHmbC8D6kZLXnjrJEWfxWHfroYLxyKLywa
	7OBaBLQqW8EqF3JxBXU4IXcyCxMTzcsKwQVzv0z4DKEiOuwcenbUmsnzBUufNf0hK7IbxNbSYqq
	50qyC0jHIIiqZ7sCrdU4fYqbr+/RUd1A+aWrZdXYc7GzckIYM6I+/Tqorgwjk1OQeggWi/oJy+B
	3qjLxtDiVv6Ve5HVfMc7S+6EZYD+elXjYVTDkM5Gz/czM6YJ42TnLP28e3qO9YCfkI8CJF02OdY
	CeLl1tNik/69z7uIadtQ5CqKVKrk
X-Google-Smtp-Source: AGHT+IHvl69qBLpKV4p1MDyfuhCpO300taFssXMhLvd1fV9VFeOxSAmsqIUTrqiT+c7w4vbSzdnJpbQJ+SrOnq45F+Y=
X-Received: by 2002:a5d:5f90:0:b0:430:fae3:c833 with SMTP id
 ffacd0b85a97d-432aa3f7362mr1829054f8f.7.1767399012266; Fri, 02 Jan 2026
 16:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102150032.53106-1-leon.hwang@linux.dev>
In-Reply-To: <20260102150032.53106-1-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 Jan 2026 16:10:01 -0800
X-Gm-Features: AQt7F2pkrrjlef2itb31CbuPvCzoWrna2Y0HhA2oqYpnjBfMeP4AzvREiUTVP_8
Message-ID: <CAADnVQJugf_t37MJbmvhrgPXmC700kJ25Q2NVGkDBc7dZdMTEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] bpf: tailcall: Eliminate max_entries and
 bpf_func access at runtime
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 7:01=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> This patch series optimizes BPF tail calls on x86_64 and arm64 by
> eliminating runtime memory accesses for max_entries and 'prog->bpf_func'
> when the prog array map is known at verification time.
>
> Currently, every tail call requires:
>   1. Loading max_entries from the prog array map
>   2. Dereferencing 'prog->bpf_func' to get the target address
>
> This series introduces a mechanism to precompute and cache the tail call
> target addresses (bpf_func + prologue_offset) in the prog array itself:
>   array->ptrs[max_entries + index] =3D prog->bpf_func + prologue_offset
>
> When a program is added to or removed from the prog array, the cached
> target is atomically updated via xchg().
>
> The verifier now encodes additional information in the tail call
> instruction's imm field:
>   - bits 0-7:   map index in used_maps[]
>   - bits 8-15:  dynamic array flag (1 if map pointer is poisoned)
>   - bits 16-31: poke table index + 1 for direct tail calls
>
> For static tail calls (map known at verification time):
>   - max_entries is embedded as an immediate in the comparison instruction
>   - The cached target from array->ptrs[max_entries + index] is used
>     directly, avoiding the 'prog->bpf_func' dereference
>
> For dynamic tail calls (map pointer poisoned):
>   - Fall back to runtime lookup of max_entries and prog->bpf_func
>
> This reduces cache misses and improves tail call performance for the
> common case where the prog array is statically known.

Sorry, I don't like this. tail_calls are complex enough and
I'd rather let them be as-is and deprecate their usage altogether
instead of trying to optimize them in certain conditions.
We have indirect jumps now. The next step is indirect calls.
When it lands there will be no need to use tail_calls.
Consider tail_calls to be legacy. No reason to improve them.

pw-bot: cr

