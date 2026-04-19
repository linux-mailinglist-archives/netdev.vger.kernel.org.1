Return-Path: <netdev+bounces-279610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDtWH9xN5WlhgwEAu9opvQ
	(envelope-from <netdev+bounces-279610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 23:49:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B9042597B
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 23:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9808C3012256
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 21:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB5D2FB969;
	Sun, 19 Apr 2026 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0W+Uzab"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8C219E8
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776635352; cv=pass; b=mlC2v2nIVWrms5RYgB0dXGhGg7InB5N86GFKLIIU/QvM9WeHq34ne3fi5lpoVSiVX9wVLGNENmM0XhvhPykF5UV6OGVAZTuqxJmYomX5hZ3QulehnjWeO8JA91h6y4oxlgK5wV7WMmPDyFTcQRBM9+FZCF5yxu8dXP8rg7OZxQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776635352; c=relaxed/simple;
	bh=cFrGrWFy/krqcVnxXtLhe3ZTOUNcitG9G8OlGBpdvQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoBqochC6iNWX3OILp1fOldrLI9U4bcUSw0LhYSANEsB5Mp+nZ7cQKRKmj3hb+D/eD7/z0RcH3KXGkyHkUmxg2cyi7woHcct28zWhsJ2W835CtcMF8dGUZs8mh4DwzWu28x7+MNSX7PCcbOVTnTbadh9RGS7pe1B8NY4D4X9R8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0W+Uzab; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so14860585e9.2
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 14:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776635350; cv=none;
        d=google.com; s=arc-20240605;
        b=aEd2/0OkM06IC5tlJs0+K1+cOTvB1dtiTk7OQduYzVI3Vnfs+3efRkG+JxCJIqKn+e
         dgS8UTPtroO8i1oAnJdICgRRvmnPKIeJpcFdkyTOKHZruzjnTijedWZQbquZ9vs4cdYo
         LC7gSxR2mrHFdNrPOg305LxG5AjbZc3jqf38fv/nmEt4TB7gAAoptBmXklkR3T0HJy63
         fu6HqhsvQtqPZNcVN7QiTAAP6DmVTYOY5hKJqHIW8Hth0/baCqhPyaVblSJFyxYNKNOF
         Jei8yJdnfOJsmo+d4ocO/mKANTscP4NaDSKWkrDvTUjLYSzHUZpTksL6N56XWn9O4Yis
         4EcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cFrGrWFy/krqcVnxXtLhe3ZTOUNcitG9G8OlGBpdvQs=;
        fh=KKf+H11sbiZdGXhdh7FT+etxUdWJcg+8q78Ws50W94I=;
        b=eICxfTwlpoy/cgqxHAY5g44MU19OyoYaanK0OhWZgydz4qgn9uNyruluCSYa07W0vR
         q41p/ftbGFMIq6QjaMXNwf+yC/pns4rIuhBrm7KuVGZZjSDGB0Tm2y3u4mv5EWWTqYYx
         OPjGCtUn5W1oeQ2YCEpFLatr9bJrGi9siKw6skUDJeM2N46XllPoEGF/AuKsVL4d2RCn
         TFFQaqreb5xCDcqarHeMAFwGMFB5e44VktxSOdVa01mG8teTmaM5anczkTh2zwT4e4Gf
         quicrsOJcEGGHht/x+psXq8CBZGU4aGkM7/SXwPjFRcagZaqfMcxyCaQ2J5T7u7ehYv1
         HnMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776635350; x=1777240150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFrGrWFy/krqcVnxXtLhe3ZTOUNcitG9G8OlGBpdvQs=;
        b=l0W+Uzab8A2jHi9AcxeOjnrxJcFvsXQLbecG8wH73firfOdw3bPZWC8F+EeYZgcGPt
         uDSBJR8ChNkkCUqfQmr4et2FUqcrSKnBOg3hDrCW20sxhxWQ82lMnAu0jipAR8GWWmL+
         mV6yIlsedB5xlg7I3Z25gnMEh3GPxFo1AIGClWI2s9j+7PzpPJxhzJ/s8L6FY0wnDWh3
         tLH7UB/28LPrTqyxOcbUc8Gj2wK+ximgrl+oKN6oWL/gJvEC26DjVpXnOCbMqW/SM04E
         rXAhlOBTIAziv7EnL5nVSKqPNJVvdl6iPMhdbNAmT8uf+VD4BzFKE+a6SzE5C+2zefDf
         offA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776635350; x=1777240150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFrGrWFy/krqcVnxXtLhe3ZTOUNcitG9G8OlGBpdvQs=;
        b=LLj75XhXRMUv1+8V+VwDMJabQ/Fh+0ZlRpyt5e9zFcxMhyQu7kRuZBIm/bVtnKigjS
         mLHvED/u51qSTOpZFx9buYuMGhiSjV7VEJ8wleTOaodp+SD1cCfk1zfdCZTeLsh/tI39
         5sJzkhJ7Zp6mtWv1YXFmMdXm0HnckiiOayEnB8nxZQVSf12vrDobzlxdOH5TfxGR2SqV
         hT/Xz5Vx9mh8b1HHMBp4RCoyZKjlhUZYZHiI/Zu1o610fDmSG2+3XNJQKBDw27k3cu3/
         ZdgIzv3y7pTXp8j6igxm+mXve04etFW8jQ6F65hA0i//nN8lVm5f9vvP7MBjY4Y/05Yk
         h+3Q==
X-Forwarded-Encrypted: i=1; AFNElJ88Kjy/8bNqrJedwhPbJ1jbSaO+CC1hDjjCCIFWWdpXbGK/ISYoY5rxEA7kZHn65R3biSqWOUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYf+eJhtt620DLKMIH+YiKJQG9CDuHTAL/6Q65irw7K1nMH7j1
	tHgHim8w3wCj0uiksTFZwmhQCL7o5vIqzEKHxXDlkt6NrKe5xlP2CjNePOYjohzfTRikKrPcZfs
	ci6WOYKcX8xUeXIhls0iJik6sQ8Oltu8=
X-Gm-Gg: AeBDiesYF0kXcvKwCGXb0PEIIFBaYQGiaTbR2UvjifMiOLAgTUzU+LV/K3I/4NwmgJx
	8Zc1tvN2hfQIrTS6NrUV0Td/HTpnezvRWHTJ+SqW2/mO3z7EoSal6Wj2Lt9qGfaGKR+ry2tIfYc
	tQs46z8UZBl0A7IT+ByBgRuoQ0+xQFDIaRDDp1zwJtDCL9c5b3OTDLLrGeD5W6gGF1/3sA/gIOj
	v9E5x5iGNbvQV7LZVbb7hHrJB862QS8q3UOaYNZgq7w9uY+snbRBwze3Qq0eHfttV9Dcg6bwZXP
	gLs5EE2FS6rjaNbdsaZsuCPg3dZyMMEb6nwfXUF7xORUrK3skCKe
X-Received: by 2002:a05:600c:8909:b0:489:1b10:d896 with SMTP id
 5b1f17b1804b1-4891b10dd45mr22100635e9.0.1776635349567; Sun, 19 Apr 2026
 14:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
 <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com> <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
 <CA+fCnZd31GzdpEqR8VhfK4JtUKyyRMgbBoAbeGACJgm7WvB6Vw@mail.gmail.com> <CAADnVQKv5y+gq=TnOAEXSqgBRpmHNjwqCfxpLaw5XkcbQ+23bg@mail.gmail.com>
In-Reply-To: <CAADnVQKv5y+gq=TnOAEXSqgBRpmHNjwqCfxpLaw5XkcbQ+23bg@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 19 Apr 2026 23:48:57 +0200
X-Gm-Features: AQROBzBeG23-litRs0f9sM5oKr7DzVV_-wsJjyIfGuOE5YpAx7fmmNXRz9M5Gbk
Message-ID: <CA+fCnZe-b0Qqbo5gGv3HN20twquQETDfYYkE1r9tPr9zUFbW9Q@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279610-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreyknvl@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[bootlin.com,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B2B9042597B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 5:58=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> I think we're talking past each other.
> We're not interested in KASAN_SW_TAGS or KASAN_HW_TAGS.
> We're not going to modify arm64 JIT at all.
>
> This is purely KASAN_GENRIC and only on x86-64.
> JIT will emit exactly what compilers emit for generic
> which is __asan_load/store. This is as stable ABI as it can get
> and we don't want to deviate from it.

OK, I supposed that's fair. You did throw me off point with your
performance comment. But if you decide to add SW_TAGS support at some
point, I think this discussion needs to be revisited.

But please add a comment saying that those functions are only exposed
for BPF JIT and they are not supposed to be used by other parts of the
kernel. And in case you do end up adding a new config option, guard
the public declarations by a corresponding ifdef.

> The goal here is to find bugs in the verifier.
> If something got past it, that shouldn't have,
> kasan generic on x86-64 is enough.

FWIW, I suspect HW_TAGS KASAN already just works with JITed BPF code.

