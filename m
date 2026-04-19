Return-Path: <netdev+bounces-279612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KXfAIJc5WnjigEAu9opvQ
	(envelope-from <netdev+bounces-279612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 00:51:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1A4425B84
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 00:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D4513014944
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 22:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26E730E84B;
	Sun, 19 Apr 2026 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIVyWv+N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869B7DF76
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776639102; cv=pass; b=EOiYasy2NZxSlDj3z9CoAuyxokpWw/ghA+lRcF3viP9t1aaqD1jlpPU5Net7R5m3hyslhUEFVIc6vr0SJV87jE/V0FPf1A22sGp5l7kCUeFboUcXvebQF5+/r7dXIa3BLPpkGAiaL9k7qVHKoGP5BRTzsiGkNMoXJixe1A37ioY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776639102; c=relaxed/simple;
	bh=nGI8q1vIW2YCqL8DB2swQpMBunXNj9M7QpTu5vxe99c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Evk/p6VwDed7h1b411x57Odo26agFE13UpJkBB5S7xzuksfybEO0dBfq0VQfyE2fATsr59amRs2rJSs/tCk4BB0EP8kQEvzeeI0UbDx+074DIPyuq5nQ6Y6GwWGg77N/dVvNVf57D13TFMCHv0dDiNfmoO20aAB8je4hFa8+I88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIVyWv+N; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7645adbdso1352568f8f.1
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 15:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776639100; cv=none;
        d=google.com; s=arc-20240605;
        b=NvoC6TBLepSsAcng6j4KcrZsy0THE1eHOYjymaS9OZBW8IK6VsBRqJ4uCVNH2ksG5F
         qdwgbmUQhfZQbnT2XjjT2RSEF126+i69PsIr3xAuy3dBz8m/j21dEx6COnG1HmChZzfl
         B83+fipkuYUmIvrvKLN36lbovaQY4e/gvEsI2e2etXaDMuyH07sXiW35oCJyXgFE1GGt
         ZCMfCp8N8uwr8y6cqXB+1h5C/y/PA2AjAERrMLO6PMxMjcRfid3Uvn34hQS3kVg8KQg3
         PidkVDDFR+5hmnfHpbsFLBhH5+/2VOjTlrwRZyTFHgM1n3eSHYpYpz0ck/RmKIq3uL77
         JPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nGI8q1vIW2YCqL8DB2swQpMBunXNj9M7QpTu5vxe99c=;
        fh=WJBewR0FLTQOwROAYrDd01yaORTEtbasJa0KdWJOF5s=;
        b=Z5BA0ziDRcUn4oFAkQ13khH4Wma93Ypl+qTbITEjWF8oqH+uQ8ryBIH47k0PXGuk9V
         du63XupJ25BJIJuHeKO83wi3ZjS8PYCn1XBgUuw9yOEglBOYpJcw8ulbMoflmB+e+0fG
         d85k+VBWYBuRH3sg70RO81aPSgZb/u0CtVHnZiqygonbjzCslAhJ/AyHwQHSgY9ihFkz
         as7/yF93HVO2av9fWHFkj7CbBF74bA0cocGZseVWzhvW0d3+QDc8srPsowqvygixr45+
         6t6nkqioGupAbctjfCi4KyXD15iAvaknD4vEF9MhYfoPhjFEfWwydT7gXDpLHgsknouC
         gJQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776639100; x=1777243900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGI8q1vIW2YCqL8DB2swQpMBunXNj9M7QpTu5vxe99c=;
        b=PIVyWv+NVODk1fM6YRVoPCmpL9zUGbaduJRw4E4FoAIegZ+uqMEy9ajZ7vRe5i/8N+
         RT36e8bOpdX9w73YACH/l0FcEzpiJaZbl7xGoROLu5Q/LnEJ8rZ3Mt8JKc5Pajbb+qnF
         pHHG8o8xDfgi4ZgoAibFk2eVuMZf9wCPxXFBXKcgJsGLpAtCQg9jpRnSv7l0KGYzx9gc
         mw0kJUbWR4s0+qaiBqMamkwWwAQrjkcbjRoQPeeYL9jTYaeelFQDGyXHhEijC3J2I8Cf
         hwxUMXRFR1zLB6O0gi72EtXG75ami26eD2t1jPZW5QUxbx+Q8nPooW8yXDDOzwVJ67vH
         kxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776639100; x=1777243900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nGI8q1vIW2YCqL8DB2swQpMBunXNj9M7QpTu5vxe99c=;
        b=qhbicr7SEQVSFxDyUxNAoU5NQthjnr5/A7PAy3eEMq3hUe78yOt+mdBmw0PcZS1rFb
         WI3wR4qtPTR3NFGqoYhArfWRn0hbgu2ihfty8jzk+zos57kBbdmgFs8Xu2DVYrj7h1vO
         e3KnYoCXG15D/E5IjKV82b37eXO1zYA0voqmCeX7bc3/ydRFtQwx+mN21WKSbMSp0AOR
         d7SG6c2o/baUNGfr6k3M9GzygD8IdOTLlEeqOJmOqUXfKOS+hQ3uPjPMLUCtMFSWWNEC
         7+vdwPO5G+NqhlWSmfr9GommRTFzFaOG6JiadDz3GmkqhvIxxNdNggB1DB18ehsM+rmd
         uhAw==
X-Forwarded-Encrypted: i=1; AFNElJ/vz0KmBJ2yEB+K8dhi3LjkBdVPlBo8nKl7kA0Lvz5qwdFQvfnPOBmfIN0ikxgIitIipPiRWg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzwB2uZVRiRXyuNjy6wVv3JXDFupHzpNKqwD0huu5SnVpWoGHV
	LtPF1zaJ9TZcgNJ3tW3tfAK+8aInd2quZ0lmwuukCha6DSp4G/b+ZCCvIFsz3dofJ5A68ZymuHk
	PlRSNe+hw5d0UH0j6Ia9hr+rFLajj8Qc=
X-Gm-Gg: AeBDieuUlJ2aopJNGS4YJUK+6KRhFFgXxlBmjPJ6PV6P4yInOLBYi6CY9vic3mj0JNX
	LSVMF1Y9Mt5iYIkf8xvwNKZaBpmY+6Fz9AvPepIc0KbRwwQSKuwmgcHin6vtix/hFr/n26M9k7B
	rP8nh3F9m8PPqI909MUcbvdOPTVrjPWUgVdayA0RWMI5kgEOiTT1m6A/0+ZZb7dwaj0d2JiTbKd
	yZoqWu9fqywN2egPpusCH9uKFe+fMuBwMur6/cgFM3jnB2Vuf4ydWrP8MJGtD9o8ogvplMrX6sg
	PBFUo52c1g1N9v6QiATSCrlS+j99UR+HsGeEutMBnpolrLQtWWkEQ3X2EqwtC4AtMz0utJHyCQ/
	8X8fmm0oR3/kkD7hg4sQOdF1x/wgncYlQuxZR
X-Received: by 2002:a05:6000:22ca:b0:43d:7883:87ce with SMTP id
 ffacd0b85a97d-43fe3dfd265mr15420059f8f.34.1776639099627; Sun, 19 Apr 2026
 15:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
 <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com> <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
 <CA+fCnZd31GzdpEqR8VhfK4JtUKyyRMgbBoAbeGACJgm7WvB6Vw@mail.gmail.com>
 <CAADnVQKv5y+gq=TnOAEXSqgBRpmHNjwqCfxpLaw5XkcbQ+23bg@mail.gmail.com> <CA+fCnZe-b0Qqbo5gGv3HN20twquQETDfYYkE1r9tPr9zUFbW9Q@mail.gmail.com>
In-Reply-To: <CA+fCnZe-b0Qqbo5gGv3HN20twquQETDfYYkE1r9tPr9zUFbW9Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 19 Apr 2026 15:51:28 -0700
X-Gm-Features: AQROBzDew-foTfJLq_z3E45rMJ3PdE7WT5G5Kb1cNLd7o7s_NLhMVNDGxKf8D94
Message-ID: <CAADnVQKuptG_opA12O=Xb9_+cHf3f=ycAZdfUp17P2HBYQzdsg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
To: Andrey Konovalov <andreyknvl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279612-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[bootlin.com,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5E1A4425B84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 2:49=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Tue, Apr 14, 2026 at 5:58=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > I think we're talking past each other.
> > We're not interested in KASAN_SW_TAGS or KASAN_HW_TAGS.
> > We're not going to modify arm64 JIT at all.
> >
> > This is purely KASAN_GENRIC and only on x86-64.
> > JIT will emit exactly what compilers emit for generic
> > which is __asan_load/store. This is as stable ABI as it can get
> > and we don't want to deviate from it.
>
> OK, I supposed that's fair. You did throw me off point with your
> performance comment. But if you decide to add SW_TAGS support at some
> point, I think this discussion needs to be revisited.
>
> But please add a comment saying that those functions are only exposed
> for BPF JIT and they are not supposed to be used by other parts of the
> kernel. And in case you do end up adding a new config option, guard
> the public declarations by a corresponding ifdef.

I feel concerns of misuse are overblown.
Being in include/linux/kasan.h doesn't make them free-for-all
all of a sudden, but if you prefer we can just copy paste:
+void __asan_load1(void *p);
+void __asan_store1(void *p);
into bpf_jit_comp.c

> > The goal here is to find bugs in the verifier.
> > If something got past it, that shouldn't have,
> > kasan generic on x86-64 is enough.
>
> FWIW, I suspect HW_TAGS KASAN already just works with JITed BPF code.

Ohh. Good point. Looks like modern arm64 cpus in public clouds
don't have that enabled, so one would need pixel phone to
catch verifier bugs via hw_tags.
So we still need this x86-specific jit kasan.
I guess eventually it can be removed when hw_tags support is widespread.

