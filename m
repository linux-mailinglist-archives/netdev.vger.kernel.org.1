Return-Path: <netdev+bounces-249814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 269D5D1E64B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F8C6300384E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95771395259;
	Wed, 14 Jan 2026 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFF35kug"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F3539524C
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390106; cv=none; b=u61flNk9aX/wd8pVmsaOYQ1kMIJjSbd4ob1W3mKmOdCZVOH9qdbehVwzjnjVamYI4i0C3KDkjlPSuwwMAw9biyP+4/L0xAq3fMGsMxdOiSfOAr+nNh8WlrfCAAHnx+YKC5qXgOd0NE4ZMggOCcPKncVj2hbqbG4VZ2sO04ruUGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390106; c=relaxed/simple;
	bh=0fGVhftsc+nGHo+Lm9VKmninWdcz1+QWpalR0QeBDSM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfyZ4wgYVXQZTpjgndk7CA8sm2rlUW5SITGJyBiKqWbt+6xF/dAueizsReO4hTQWrLfgw1vxgJhuqLO0LfSj9xAOfXkNC4FpaGxvW/c/pNVIW3s3jKZb2/6APQzxc93CLY81Yp+qJqXvVol8DR03xvT8rYgENr0BJW1H6/wJpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFF35kug; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so64315335e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768390098; x=1768994898; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IGVDUUpgpDLMWHZgDOLEkAjObayE3q3JK8jeYcF9PIs=;
        b=XFF35kugUQxnCboeg0kWoGprR6/B0CUuUgWyN8gQOF7GT65jnzwWCBjfvibxdL0vVv
         3G87ZVe+M4ar9sHRztusxXCeQ0nZYK5gPrZkMRAz4RuvWegTaypQCDv9xjee2jYLiOpv
         i0fDhs3/U1sRAD93DiW4r6iB+l0Q3hl1JSJg373CEF2alY5mDV5kVdaoW+njviEX83A3
         je3WIF59O7CzephDfNYav3Wz+XivtdBYXWTgbUSSRSbNcCVKC+rgDVrIf+DeEkC0P5za
         V0q6OMd52b4WKl6+Ub1if/pp58kAiE6lsNI3H6+q6tGzP3M8M5FhN6glRVkqqFSVglYv
         In6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768390098; x=1768994898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGVDUUpgpDLMWHZgDOLEkAjObayE3q3JK8jeYcF9PIs=;
        b=Ng3bBAjhTUtSP3wv0IXSl57b2NAvFRmQ/WihAN2xCkHa10/d8enVLJIZ3OJm/vfKsN
         2fyytQ/Twb3y/wSX1XW6sq457D1yp+JWU+j78EvTnOzy5WY7jopK8pJPkEEjwJ/fpYfe
         2GecaJhPRwGBHAuQPOGTB4RteNYQtJmDD0xcIp0LPRJbSlfusURbZbpBDCP5gv6paY5j
         9hdfVik9w1kxBy6y43VHps5Cx3SHeXPNbiXIde50CokXduUcc75QVLgY7MrTIa3m6axe
         HcfVrreSfOpSjJ1O8t7CZB5YLlVim+tVVU70wYB9srpx6PNliYwnm+irrHes2bqcM8qH
         TfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqJQz0fkQRwpHrQEDBR5XC3BPb3vD7rgph1q9i5CGaY6jCyi3y+nIdc2dJShzgsMfnz78jN6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB749RQoekpint/tah8uCQv6gzBr/DtPhrhxxJsxZZs7NLl7wQ
	nmnpJnkDzWit37DpRF7Ul2PZnzhV8h5sZI5m6Y67DwVGohUjzOZlQixM
X-Gm-Gg: AY/fxX5KJtxpE45+u/PU2oy4fgAq33Z43ZfzLoyGivS50RKc82bHWLRiaZETq+6qlFA
	+ZBw8ctIlogdEDMlIb8W9OWWk2eeqBJHnHEnNN7+CRqmWRmyTDcyt4IHUkx/DewwJz7T2qmYrs1
	KqIuxFZvSXl142MMs3wd3ZfkptrmcMf4r6oHQVTRWt0WUzdE+MCBphqE1B4/2tPnkStgiameMqN
	v4YyrrDkRnQU1BmYp1HDlN/s+21FEmBpbv3DWljg73A+Dgz8sPyrmt27ZRoLpyLl4JtUt+4+1V4
	dYeFbYa221N0kJ+Bz87OL0Ah2cJxJWxHvRP6kZaytI8pRslW1Nl3WNZTlVAKcorPkW81Ch9XvSe
	9PozeuxJop/TIvhhXM+Ykb6VIPd78lEZ3VYlQr72T7nJViELaB742NBIiXNQrra3yied6Vb4+2D
	s=
X-Received: by 2002:a05:600c:4f0b:b0:477:9392:8557 with SMTP id 5b1f17b1804b1-47ee4819824mr18444405e9.18.1768390097518;
        Wed, 14 Jan 2026 03:28:17 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee54b90d5sm23620545e9.2.2026.01.14.03.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:28:17 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Jan 2026 12:28:15 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <aWd9z8GVYO12YsaH@krava>
References: <20260102150032.53106-1-leon.hwang@linux.dev>
 <CAADnVQJugf_t37MJbmvhrgPXmC700kJ25Q2NVGkDBc7dZdMTEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJugf_t37MJbmvhrgPXmC700kJ25Q2NVGkDBc7dZdMTEQ@mail.gmail.com>

On Fri, Jan 02, 2026 at 04:10:01PM -0800, Alexei Starovoitov wrote:
> On Fri, Jan 2, 2026 at 7:01 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> >
> > This patch series optimizes BPF tail calls on x86_64 and arm64 by
> > eliminating runtime memory accesses for max_entries and 'prog->bpf_func'
> > when the prog array map is known at verification time.
> >
> > Currently, every tail call requires:
> >   1. Loading max_entries from the prog array map
> >   2. Dereferencing 'prog->bpf_func' to get the target address
> >
> > This series introduces a mechanism to precompute and cache the tail call
> > target addresses (bpf_func + prologue_offset) in the prog array itself:
> >   array->ptrs[max_entries + index] = prog->bpf_func + prologue_offset
> >
> > When a program is added to or removed from the prog array, the cached
> > target is atomically updated via xchg().
> >
> > The verifier now encodes additional information in the tail call
> > instruction's imm field:
> >   - bits 0-7:   map index in used_maps[]
> >   - bits 8-15:  dynamic array flag (1 if map pointer is poisoned)
> >   - bits 16-31: poke table index + 1 for direct tail calls
> >
> > For static tail calls (map known at verification time):
> >   - max_entries is embedded as an immediate in the comparison instruction
> >   - The cached target from array->ptrs[max_entries + index] is used
> >     directly, avoiding the 'prog->bpf_func' dereference
> >
> > For dynamic tail calls (map pointer poisoned):
> >   - Fall back to runtime lookup of max_entries and prog->bpf_func
> >
> > This reduces cache misses and improves tail call performance for the
> > common case where the prog array is statically known.
> 
> Sorry, I don't like this. tail_calls are complex enough and
> I'd rather let them be as-is and deprecate their usage altogether
> instead of trying to optimize them in certain conditions.
> We have indirect jumps now. The next step is indirect calls.
> When it lands there will be no need to use tail_calls.
> Consider tail_calls to be legacy. No reason to improve them.

hi,
I'd like to make tail calls available in sleepable programs. I still
need to check if there's technical reason we don't have that, but seeing
this answer I wonder you'd be against that anyway ?

fyi I briefly discussed that with Andrii indicating that it might not
be worth the effort at this stage.

thanks,
jirka

