Return-Path: <netdev+bounces-278491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MoKLcVb3mlACQAAu9opvQ
	(envelope-from <netdev+bounces-278491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:22:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CAF3FBB43
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56E063073618
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8028F3E9585;
	Tue, 14 Apr 2026 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUKFA+2A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC73E92AB
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179424; cv=pass; b=L+9ZLoLX/bjn+mo99TQEJbhH7vjPLL4V4Qr1Hzlk7uZtFDwo2eG5OKrPMF8EesVFry3BsPBNkTO5fEV/cZj0lZ/uni1VexMYI2WPjd6MiRg7/TcrmdUKmhvUuNKemDlrhjdoLQpQRiU4iVNhMBoGqxMLX0y1XdUpOnpQo6hSOtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179424; c=relaxed/simple;
	bh=A7c7tKPqaKq3NgFiv2DNK8q/BvKoh1wbxDHgCCrA1+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVuDQ7CD1lUaLOClnp4ERb2rHTgVcM/EpNvBuJJrFnOkzGgfue7p/lsR4rxW2n2ikxHJjmbbUZlCfB9pZ8kpQeJsGfNVPAtovtcqjYmiBTBEbBlRr2+v3mkRkiiX8WonncpqFWPEeZhZvns0dcqRzoMIsYCrTc10wiSiMy/rMq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUKFA+2A; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d7a5e77b1so1360519f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776179421; cv=none;
        d=google.com; s=arc-20240605;
        b=GmkiQmJM3FwM9m2AoOo6sgpJhiSXWPy0S/KJHpt6g2CI/IvccXQcW3IG+zteeE0AqS
         QBohyXojbVn4fS4xOLXYwiiqWUj0Eg4MatJWWiBBD2d5BkyN4/D+hkrJx/bj9rc5k5M3
         /RQfmD4hSvR3YLhQd1cfXXqcLD4qGIlzt6UdF0gnLarmsxTtH8buuusbqNHrZKGj6iWs
         ZAEEzIHMKOnVkvkSfe4hSg+eDEURSxp52S0Dd3Op7vKBzVbG1p0mdPYHM01iU7EKM+s9
         SiTWcezqGtRx6BYrZczaSrx8pzcJyrEsr+1C/+1GeVKZCJ8QXSnVYl1ZOv9Kh8TeKyHR
         liaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A7c7tKPqaKq3NgFiv2DNK8q/BvKoh1wbxDHgCCrA1+c=;
        fh=k+02rcNCYpHmVmRQ9NUsv5WEHEgt29a31g3/0yP2fRo=;
        b=N7oF4oLGt1RzjnF8pXY+x9DtrsO0FXi8kFoQZkAAbOoMH//UtzfA2NBLyQACUZZV6b
         og7d8hEuFoBC2UZduNjq/aBQh0768T5rZOrWJqe98KxOJ+xuJacQ+FNp7Mt08KYBAa3Q
         LFVHFOHsEQ/qZFeYsPPW+5qmjXdB7bW7hL6ckX3ahXx12ZHGMD2JvorSK4rWeXWW14Bc
         znnWMIxtnSCloMsuJf9deogzvLboBpBddhfx6u+4SIDrrzg65ylgB42cARXN3XGoBG7T
         oRvDudZqhs5h2fGil5L99gQemU79UF5wiDAzI3H5dFJFEODws6MV7tQa8QDb46iSm/b9
         ctgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776179421; x=1776784221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7c7tKPqaKq3NgFiv2DNK8q/BvKoh1wbxDHgCCrA1+c=;
        b=eUKFA+2AoQREtn0iyQraI6Pd872uELauer8EVJrgJNhwKAL5DDkqWPhcB/7eDyozrx
         qbp9AJD0LHtNW1OtDScOl8AJVcbQOTNhU6w3VpD4FhCfMk0lNNP/jQ+LJwQ0drfIq1wI
         0oNyhdBZv/fo7rrKJ1W5X9KGjMvlW7rSLEGpsjo/XfKYyglsnire53d/4PbfQJEqNXDL
         3lOmas2U6pCwaTfM++sGZBaeyn5QXX/V/ErK0tawok/bWwzgOHtquIHAdxnsqGJhX+u4
         ocUpxh0rqMDOtK4blQIOE61GbogTPRhfyYmworZTWngPik83hC1PFpMdJF4kTzTTk8wX
         ZgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179421; x=1776784221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A7c7tKPqaKq3NgFiv2DNK8q/BvKoh1wbxDHgCCrA1+c=;
        b=OS9X9CQO9/9reYSRKFnvhpqdcinr69Bp5dVqlTOzhQ8ZhCoGD0lbKq9PI8T8bs7PWI
         E9Twqz3FG9ofvo58iS2B2Je/SS3sElQ9Lic+/ZhxLFuH8CMlwFAkImGDI3Q5295p3tOL
         4mnw4hAj79GPIbrj18ErTxvLthMjK7v1uBPLuZ0ypP6qFhseqIvoUEAMuRljRLyG6Ibt
         6eEPADE3t98+DgnFtVFoum6SUF6KhD9/ZdB6YFq3k3HtM0g6if5aWRkcgzmY+OljGLF5
         L0xNZuLfqgcuEWcjBolBzZMjYteeUuZ70H27B8PaJVg9QxPVhIQjVOrEuzfeZi7F3EBM
         R74g==
X-Forwarded-Encrypted: i=1; AFNElJ/U/8DbTO2KM8zp4RMsbqVudPVCc/+3Q5KsNM117jJaKr0kpFgWrYgF37Alzcxrab8iSeF/rBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHv+s8BcbkTxc+TF1S/zQs+JJxFAk1Et01DJ0gFOJNZNx6l1N
	PDNRqMtiVYHSorqLqXxo1OqwxL5lhc9v//2VaRDLAb+fl+DsqIvqMiWXhnkuB59VPMFVZGzWBXM
	PYI2KaqFyU7uGkYxGhU56LgBzi1LCqkI=
X-Gm-Gg: AeBDievEZ80gECyPIW27sfcJ+cZSfkqFxnB2RgGeoeDpn6cmbyR/Y1VAtuEVuahAmQt
	85sG44PZ4ip9eYkqxVWAzAje6FBZ1t7uz9iZPMsc9aw+csYHHNqsjEzyLQkvYWgzaSKdPYNrnAy
	NoFPPpLs7qhS4bahJUH9BVJzj6ODg2n6tJexy1Vh7yUQmrlEXmefUSTsTNly225aDWvhlqvwou9
	XMcqEnBvCRxn+vznPzQKD1KAy79Y2dqQlxnaoimOgaKh+v2+5H7APk/aYbqNI0WdNU4VAJT/tee
	x+Kv5myeSZEyDr3uEnzTjzmBta2dh+6qo5RhjHxV
X-Received: by 2002:a05:6000:4110:b0:43e:a8cc:89b7 with SMTP id
 ffacd0b85a97d-43ea8cc8c24mr1517128f8f.3.1776179420992; Tue, 14 Apr 2026
 08:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
 <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com> <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
In-Reply-To: <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 14 Apr 2026 17:10:08 +0200
X-Gm-Features: AQROBzAtXSFwPeCMpZ2dGca-DBLsSXREgEyBZSQFf7Waht1WxQ2QIbb8WTtAIYs
Message-ID: <CA+fCnZd31GzdpEqR8VhfK4JtUKyyRMgbBoAbeGACJgm7WvB6Vw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278491-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreyknvl@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[bootlin.com,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org,linuxfoundation.org,huawei.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,googlegroups.com,kvack.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 48CAF3FBB43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 4:36=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> > ACK, I'll try to use those kasan_check_read and kasan_check_write rathe=
r
> > than __asan_{load,store}X.
>
> No. The performance penalty will be too high.

With using __asan_load/storeX(), it will be one function call to get
to check_region_inline(): __asan_load/storeX->check_region_inline.

With kasan_check_read/write(), right now, it would be two function
calls: __kasan_check_read->kasan_check_range->check_region_inline.

I doubt an extra function call would make a difference in terms of
performance: the shadow checking itself is also expensive.

But if the second call is a concern, we can move kasan_check_range()
and lower-level functions into mm/kasan/generic.h and include it into
shadow.c, and then it will be just one function call.

To improve performance further, the JIT compiler could emit inlined
shadow checking instructions, same as the C compiler does with
KASAN_INLINE=3Dy.

> hw_tags won't work without corresponding JIT work.

You probably meant SW_TAGS here.

HW_TAGS will likely just work without any JIT changes (even the
kasan_check_byte() thing I mentioned should not be required), assuming
JIT'ed BPF code just accesses kernel-returned pointers as is.

> I see no point sacrificing performance for aesthetics.

With the change I suggested above, there would be no performance
difference. And the code stays cleaner.

> __asan_load/storeX is what compilers emit.

For Generic mode. For SW_TAGS, the function names are different.
Keeping this detail within the KASAN code is cleaner.


> In that sense JIT is a compiler it should emit exactly the same.

