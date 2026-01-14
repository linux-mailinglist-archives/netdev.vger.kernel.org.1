Return-Path: <netdev+bounces-249942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBCBD21414
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55507306F27F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9389D3596F1;
	Wed, 14 Jan 2026 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdFkGNVF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F685358D30
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424422; cv=none; b=fvRh8AmMH3ZZVB4JwwtnbMzOza9uRGA9mXAnuKop3etD9v7IfE2PVR50hAZX7/VcryIzdR3/1ixSIYTpBxvpuy+n0JW9TaCsLkRZEVPWwPPUstw0slsq5iRRZAdBORPRTRm8xkHWv2RdQ/lV9j79Hoj0uIO7/sDVE4w0KsVVeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424422; c=relaxed/simple;
	bh=solROkaC8BCCmCJGYs5DkXY3qSNb6tm03ecJ5p94KEI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k07pSXLquVhjsDQ/Lm4O2KsvhCuPJRVVyJDELWjBZdNYWgF6fAx+ayB7Crn09xB59bdVoOKm9FAJb+m3ZQdbmzYcbltQ1E35QGy27zhUSPpq7Up/MInbCi9hvVa8wVrFUpLR0uhFQlQtYAt4FAFPwQdwAhUs9kOt+tMWymOgPrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdFkGNVF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so1598735e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 13:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768424418; x=1769029218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yZ1qoNAl3hi5ypXf81uyaWM/SL2Im8OnG4dcyA+tbN0=;
        b=mdFkGNVF7DnXhhPd70XRAixVMM0guzf4sps1VsE66Utvigb6PGszNdcllShXdSNHqC
         4RQEd9W3Dc/Tx0+82YXF7cDFg4To1ehfejw5NO6mvzDbKxszrJg2rXLzXbwtiXPzkC3N
         bGbovLFfQ1a2aZ+IMuxntxCpnIv3RdJ9dsJNScqKWz65raZsDFgpIozFBGCMIBknYife
         +daaXKuQcNhx/TMbYn3vHkZFFr/ox9H3MU6ov5dTnX4d6UM7x0z8vxJWJF7sowtYuefx
         6PD5jlyElPbbVWgIzW+kE6nqPkdr8YG+RFw0+JsVNxQQaRXbVBHjOdIo9WiC6Jy/bj1m
         yveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768424418; x=1769029218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ1qoNAl3hi5ypXf81uyaWM/SL2Im8OnG4dcyA+tbN0=;
        b=O61PXM7ESUwjSy0iD+QbCHmYgEn6zaB+IV7hsRflKzEYgP50b8r4OoNmmiF99nwLKE
         aWbzd/HawPcYfZVyI+e14YG4LkirCzi55AnsibtoxGrz40H2+MqaPfHLaMzphH6+SKz6
         sIjBLzHWemWGzrmI4Ej2BEAx71lLqZ/N9RmSUUwfyCBANvT9MQQD8yMMDY/JOkapiZco
         kyI6obu9i+JNvBAgrJTtzHDYeuYBeBus1C73+JRVcE18xWiQqtylR3LwVfAIdcLHFRNN
         fvgcuP/AMH1rvNAMchGDjo/oEU2HY87qej1vIKz9A064Vr/Bi1Y87B/FUhldkG0TM+OO
         HKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMwphZv1izsIHCzn5urJbtlSQyc1vn0OygL/ZAa8fWceoEXxKK4i5HvCd9wruOU6kp3Xt6uxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJxI3bY1q2eGlnbB0Ow4z6f/Xk1ezDlSQwax/LBHhOhelakrW
	W5zTQxABO3XEDEYp70oztCi6sfjO3xFIJGLGj5f73DhBqZjQrYkrNWoB
X-Gm-Gg: AY/fxX6oOm+xlt0iF7CqkEi7mDUaoiQGuB+p3PIFmil6An8gPu84hs6ii7T82HBjNFT
	rn2Cre6MN41aArHykeoukZN3Kg+qEwM57zlex2XEjwPbBp+mYWW/u9RAFkaMgQeggpU49XzZVyX
	1yAs7Aek7OXZuIH/7BbAA7q9yphWjhtVcJ2H8AZ/FmUnw8Ez1Sd7ag+mEFTWP3+EDbLBNSCvHrL
	DIIU4pJndoGObv+r1HtPyW1GRRPLPlSiGtupavoWhbBXVTJtKd1XCeXQ1vFfmIukOf5HQYIYFvg
	vdo8mj7d/LvMq6K6RN2i1xpOSut+dZJR9PiIsoW+e9GX74ZHN8rhDhv2ABQBLxr/x42dFvNGooR
	ldae0E2FZBnDXKdyvbLWbfXRhuOWMlXf2yQHdJaVkttXLFfh9PZvIXbVXb06Cc/v7D64y/rH4Vv
	w=
X-Received: by 2002:a05:600c:1549:b0:47e:e970:b4e4 with SMTP id 5b1f17b1804b1-47ee9810b73mr15842165e9.29.1768424418075;
        Wed, 14 Jan 2026 13:00:18 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a666sm1329588f8f.6.2026.01.14.13.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:00:17 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Jan 2026 22:00:15 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Leon Hwang <leon.hwang@linux.dev>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 0/4] bpf: tailcall: Eliminate max_entries and
 bpf_func access at runtime
Message-ID: <aWgD3zH7vsiBdIcr@krava>
References: <20260102150032.53106-1-leon.hwang@linux.dev>
 <CAADnVQJugf_t37MJbmvhrgPXmC700kJ25Q2NVGkDBc7dZdMTEQ@mail.gmail.com>
 <aWd9z8GVYO12YsaH@krava>
 <CAADnVQLxo1uPbutGNKrv=f=bSVkzxOfSof0ea8n7VvqsaU+S3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLxo1uPbutGNKrv=f=bSVkzxOfSof0ea8n7VvqsaU+S3w@mail.gmail.com>

On Wed, Jan 14, 2026 at 08:04:38AM -0800, Alexei Starovoitov wrote:
> On Wed, Jan 14, 2026 at 3:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Jan 02, 2026 at 04:10:01PM -0800, Alexei Starovoitov wrote:
> > > On Fri, Jan 2, 2026 at 7:01 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> > > >
> > > > This patch series optimizes BPF tail calls on x86_64 and arm64 by
> > > > eliminating runtime memory accesses for max_entries and 'prog->bpf_func'
> > > > when the prog array map is known at verification time.
> > > >
> > > > Currently, every tail call requires:
> > > >   1. Loading max_entries from the prog array map
> > > >   2. Dereferencing 'prog->bpf_func' to get the target address
> > > >
> > > > This series introduces a mechanism to precompute and cache the tail call
> > > > target addresses (bpf_func + prologue_offset) in the prog array itself:
> > > >   array->ptrs[max_entries + index] = prog->bpf_func + prologue_offset
> > > >
> > > > When a program is added to or removed from the prog array, the cached
> > > > target is atomically updated via xchg().
> > > >
> > > > The verifier now encodes additional information in the tail call
> > > > instruction's imm field:
> > > >   - bits 0-7:   map index in used_maps[]
> > > >   - bits 8-15:  dynamic array flag (1 if map pointer is poisoned)
> > > >   - bits 16-31: poke table index + 1 for direct tail calls
> > > >
> > > > For static tail calls (map known at verification time):
> > > >   - max_entries is embedded as an immediate in the comparison instruction
> > > >   - The cached target from array->ptrs[max_entries + index] is used
> > > >     directly, avoiding the 'prog->bpf_func' dereference
> > > >
> > > > For dynamic tail calls (map pointer poisoned):
> > > >   - Fall back to runtime lookup of max_entries and prog->bpf_func
> > > >
> > > > This reduces cache misses and improves tail call performance for the
> > > > common case where the prog array is statically known.
> > >
> > > Sorry, I don't like this. tail_calls are complex enough and
> > > I'd rather let them be as-is and deprecate their usage altogether
> > > instead of trying to optimize them in certain conditions.
> > > We have indirect jumps now. The next step is indirect calls.
> > > When it lands there will be no need to use tail_calls.
> > > Consider tail_calls to be legacy. No reason to improve them.
> >
> > hi,
> > I'd like to make tail calls available in sleepable programs. I still
> > need to check if there's technical reason we don't have that, but seeing
> > this answer I wonder you'd be against that anyway ?
> 
> tail_calls are not allowed in sleepable progs?
> I don't remember such a limitation.
> What prevents it?
> prog_type needs to match, so all sleepable progs should be fine.

right, that's what we have, tail-called uprobe programs that we
need to become sleepable

> The mix and match is problematic due to rcu vs srcu life times.
> 
> > fyi I briefly discussed that with Andrii indicating that it might not
> > be worth the effort at this stage.
> 
> depending on complexity of course.

for my tests I just had to allow BPF_MAP_TYPE_PROG_ARRAY map
for sleepable programs

jirka


---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa1ecc1fe9d..1f6fc74c7ea1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20969,6 +20969,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_STACK:
 		case BPF_MAP_TYPE_ARENA:
 		case BPF_MAP_TYPE_INSN_ARRAY:
+		case BPF_MAP_TYPE_PROG_ARRAY:
 			break;
 		default:
 			verbose(env,

