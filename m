Return-Path: <netdev+bounces-58812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B22818460
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E068B22ED0
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73CE134A7;
	Tue, 19 Dec 2023 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8qRNa9H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1254C14274
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-553a45208ffso334721a12.3
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 01:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702977958; x=1703582758; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UmFXDzDjGX53ZCrVsZ8QohDcDki5KmmW0Faw7maqMs=;
        b=k8qRNa9HiqMj0ZERKy1gNBEuxhulkSWCTR8iyNTllWT5ioNYQhRfPCA7MHYgq3fVca
         j39pzLqd9iz7/eF8D9g8rI74c8/BVkukjorq7jnm/24hv35Dkt5xijs/uyc122as9p84
         JzqgMdzNz3MzPXtvqRdz7jrXAlqzLTosJvAmB59b2qiBxfU7LLHdxAvgXuOgKv6gKp47
         s7DnXFS/lqCGnzooDYhGf9aUjoQmjOoDF4ttmL6asmmDnHROv5lIG50ZNlY/L2GzdYZN
         2Qv6/arwfcA1VUXoNfY3Qyo7UodzGhnn1yF7kYY+2Lw4xffiKdymc6OSdIVvwXY1m1cO
         pQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702977958; x=1703582758;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UmFXDzDjGX53ZCrVsZ8QohDcDki5KmmW0Faw7maqMs=;
        b=po1GzUIgCf7CYiMMqYf82WTO+o4tcy359Ci6PJIMZR6NkaTMQ/jM4LOSuKVEy9cHqR
         4+FKuFbDzzNuH+UuaNoN6GT/Fiihtww1LNSGsbF9fkVe0B9keDpoUctT7M4exvDqOdRi
         4sh4PSfJ/dl871RIPm9dEKg7ETRidiqRJ4B0G4HdVgVRT8ImFBJxJCNatErFxguv/ft/
         dwRl8Q3jLS2BsxHZZRJ982WtM+4DC/5hHQzCBERLX4HkUCP/3Btug1FlPp1atubT5ejZ
         xAONfAwiro8Gs+70StcDtAsE7zYX6SSrEVqB69wvNe6IG8SiWQl1fbXT3nmhXaPVvUyL
         Iu8g==
X-Gm-Message-State: AOJu0YwVFFnXDC0YvdMSk+nPo/amrr8tpHyUfQVdDuboo3nWVX3UWvXs
	HQ8pYIlhZjVCBQ45dcHCxjo=
X-Google-Smtp-Source: AGHT+IEhxmNdKHhKuxc2Gfo4ZgM30htzuVRT2i+X6+yQwwzJO0el7CvXvouTS79Gm/bKQ8V276hyMg==
X-Received: by 2002:a50:9313:0:b0:553:50d9:89e2 with SMTP id m19-20020a509313000000b0055350d989e2mr946969eda.19.1702977957963;
        Tue, 19 Dec 2023 01:25:57 -0800 (PST)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id c6-20020a0564021f8600b0055306f10c28sm3097478edc.28.2023.12.19.01.25.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Dec 2023 01:25:57 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <87r0jrp9qi.ffs@tglx>
Date: Tue, 19 Dec 2023 11:25:46 +0200
Cc: peterz@infradead.org,
 netdev <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com,
 Eric Dumazet <edumazet@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D816814-1334-4F22-AFF8-B5E42254038E@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2jypN_Qf9oojw@mail.gmail.com>
 <D773F198-BCE3-4D43-9C27-2C2CA34062AC@gmail.com>
 <8E92BAA8-0FC6-4D29-BB4D-B6B60047A1D2@gmail.com>
 <5E63894D-913B-416C-B901-F628BB6C00E0@gmail.com> <87lea4qqun.ffs@tglx>
 <2B5C19AE-C125-45A3-8C6F-CA6BBC01A6D9@gmail.com> <87r0jrp9qi.ffs@tglx>
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Thomas,
Thanks for your response!



> On 12 Dec 2023, at 20:16, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> Martin!
>=20
> On Sat, Dec 09 2023 at 01:01, Martin Zaharinov wrote:
>>> On 9 Dec 2023, at 0:20, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> That's definitely not a RCU problem. It's a simple refcount fail.
>>>=20
>> Is this a problem or only simple fail , and is it possible to catch
>> what is a problem and fix this fail.
>=20
> Underaccounting a reference count is potentially Use After Free.
>=20
>    if (rcuref_put(ref))
>       call_rcu(ref....);
>=20
> So after the grace period is over @ref will be freed. Depending on the
> timing the context which does the extra put() might already operate on =
a
> freed object.
>=20
> How to catch that, that's a good question. There is no instrumentation
> so far for this. Below is a straight forward trace_printk() based
> tracking of rcurefs, which should help to narrow down the context.
>=20
> Btw, how easy is this to reproduce?

Its not easy this report is generate on machine with 5-6k users , with =
traffic and one time is show on 1 day , other show after 4-5 days=E2=80=A6=





>=20
> Thanks,
>=20
>        tglx
> ---
> --- a/include/linux/rcuref.h
> +++ b/include/linux/rcuref.h
> @@ -64,8 +64,10 @@ static inline __must_check bool rcuref_g
> * Unconditionally increase the reference count. The saturation and
> * dead zones provide enough tolerance for this.
> */
> - if (likely(!atomic_add_negative_relaxed(1, &ref->refcnt)))
> + if (likely(!atomic_add_negative_relaxed(1, &ref->refcnt))) {
> + trace_printk("get(FASTPATH): %px\n", ref);
> return true;
> + }
>=20
> /* Handle the cases inside the saturation and dead zones */
> return rcuref_get_slowpath(ref);
> @@ -84,8 +86,10 @@ static __always_inline __must_check bool
> * Unconditionally decrease the reference count. The saturation and
> * dead zones provide enough tolerance for this.
> */
> - if (likely(!atomic_add_negative_release(-1, &ref->refcnt)))
> + if (likely(!atomic_add_negative_release(-1, &ref->refcnt))) {
> + trace_printk("put(FASTPATH): %px\n", ref);
> return false;
> + }
>=20
> /*
> * Handle the last reference drop and cases inside the saturation
> --- a/lib/rcuref.c
> +++ b/lib/rcuref.c
> @@ -200,6 +200,7 @@ bool rcuref_get_slowpath(rcuref_t *ref)
> */
> if (cnt >=3D RCUREF_RELEASED) {
> atomic_set(&ref->refcnt, RCUREF_DEAD);
> + trace_printk("get(DEAD): %px %pS\n", ref, =
__builtin_return_address(0));
> return false;
> }
>=20
> @@ -211,8 +212,15 @@ bool rcuref_get_slowpath(rcuref_t *ref)
> * object memory, but prevents the obvious reference count overflow
> * damage.
> */
> - if (WARN_ONCE(cnt > RCUREF_MAXREF, "rcuref saturated - leaking =
memory"))
> + if (cnt > RCUREF_MAXREF) {
> + trace_printk("get(SATURATED): %px %pS\n", ref, =
__builtin_return_address(0));
> + WARN_ONCE(1, "rcuref saturated - leaking memory");
> atomic_set(&ref->refcnt, RCUREF_SATURATED);
> + } else {
> + trace_printk("get(UNDEFINED): %px %pS\n", ref, =
__builtin_return_address(0));
> + WARN_ON_ONCE(1);
> + }
> +
> return true;
> }
> EXPORT_SYMBOL_GPL(rcuref_get_slowpath);
> @@ -248,9 +256,12 @@ bool rcuref_put_slowpath(rcuref_t *ref)
> * require a retry. If this fails the caller is not
> * allowed to deconstruct the object.
> */
> - if (!atomic_try_cmpxchg_release(&ref->refcnt, &cnt, RCUREF_DEAD))
> + if (!atomic_try_cmpxchg_release(&ref->refcnt, &cnt, RCUREF_DEAD)) {
> + trace_printk("put(NOTDEAD): %px %pS\n", ref, =
__builtin_return_address(0));
> return false;
> + }
>=20
> + trace_printk("put(NOWDEAD): %px %pS\n", ref, =
__builtin_return_address(0));
> /*
> * The caller can safely schedule the object for
> * deconstruction. Provide acquire ordering.
> @@ -264,7 +275,9 @@ bool rcuref_put_slowpath(rcuref_t *ref)
> * put() operation is imbalanced. Warn, put the reference count back to
> * DEAD and tell the caller to not deconstruct the object.
> */
> - if (WARN_ONCE(cnt >=3D RCUREF_RELEASED, "rcuref - imbalanced =
put()")) {
> + if (cnt >=3D RCUREF_RELEASED) {
> + trace_printk("put(WASDEAD): %px %pS\n", ref, =
__builtin_return_address(0));
> + WARN_ONCE(1, "rcuref - imbalanced put()");
> atomic_set(&ref->refcnt, RCUREF_DEAD);
> return false;
> }
> @@ -274,8 +287,13 @@ bool rcuref_put_slowpath(rcuref_t *ref)
> * mean saturation value and tell the caller to not deconstruct the
> * object.
> */
> - if (cnt > RCUREF_MAXREF)
> + if (cnt > RCUREF_MAXREF) {
> + trace_printk("put(SATURATED): %px %pS\n", ref, =
__builtin_return_address(0));
> atomic_set(&ref->refcnt, RCUREF_SATURATED);
> + } else {
> + trace_printk("put(UNDEFINED): %px %pS\n", ref, =
__builtin_return_address(0));
> + WARN_ON_ONCE(1);
> + }
> return false;
> }
> EXPORT_SYMBOL_GPL(rcuref_put_slowpath);

Apply this patch and will upload image on one machine as fast as =
possible and when get any reports will send you.

Best regards,
Martin


