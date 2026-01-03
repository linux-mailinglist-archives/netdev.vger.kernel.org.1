Return-Path: <netdev+bounces-246671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73537CF02C1
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 17:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4B19300ACFC
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6202248A5;
	Sat,  3 Jan 2026 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cuPX78QG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4AE219319
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767456646; cv=pass; b=Jxp/gBEcRCUekMAlJJt4LueLM6p+suiIsBWQnSLNBnTvt/esbSHCV3poUBD8SA8qDlKWJLzmO+OIEnrKMdvOPOSCUImHUubV4z/iIh3Z8MgSY/+C5f66kQQIRENTo24Mphde4Il49uTFm5nuDMSI2NY7Em6jk+de6QwQZSrsugw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767456646; c=relaxed/simple;
	bh=sLqm4k+Q0xcFLcapu1YoX24l7Z+bf5eMdUHJjUooRBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mw48qdWFqzTamt+KbEeTZ1vkAfeI7AZpACRaYudqy4xgFqreHEHkStLi4iowZw8cG4qGBoZE3UWKtSqtxPUPPuklm8P3DGZ/aqxDGnkMZFvFSLpiZ1SJo0xeZ7o4OXDCiDNXoL6MK7QLbRJKOrJfaU4ycteWDZLXvJxhJke+jAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cuPX78QG; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4f34f257a1bso228151cf.0
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 08:10:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767456644; cv=none;
        d=google.com; s=arc-20240605;
        b=IwjmLPOZYlnigspn+b8yrrn+XVDCSe6Y5aur3U5BEgiZfWOCd9pF3PMmzre2tGnZju
         Ogp5n2Hd6nBXU288RcXAsRxzAFhbF4/HA4dz0F77K7k+7Be6Jppl6ugwp2v5jB9oEAXA
         U+RmTwi82MDMPTrTDI1e6dHwTlskYn5PC4SWbk9YJbQMaM9W1rhpPLb90j+Vkrq1ATkM
         Mu39lBpJ36vi3bgDu/+kYHql6M2fFhZxZmpiUIUlTGFZxrVnGuRzjz1OJy1jFh5NLk/a
         O+amfri93Dx9/74TEocRSMkkdDZrxB+cnLquh/A75Y18PvlhBinxJ4ypZHAB9zTFNegH
         JT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rxFwQ8lwOEWkK9q4ujS56V9N9o7jjnUMeX1RAQDDAno=;
        fh=sAp/fCbAnyAJCql4VjBCtwx9sCTItDFGa3Mw65OHGE0=;
        b=HtG3EWvTzExC4X0ziGxw5R1dpanMrqU/Xsrn/5vpdUIONyFALKMxPRL0tAojKIwZaJ
         j/M6AxBcPqTGpXEQwqu7YXfdgKqsgvw5b/WHs2XU+uJ/neKxrMdYudOcp5jxkBYf5f6g
         37xNPWl+iavnRpHVnNP+Fz9JPVO4Erjn3m0WdUc/n5qkoqJewJkji2TF37E+TFYI4NUo
         IssAFrRGL0nM10PEgL8d+ospSG4oCU4prcXIweKqRnE+jA0wgTQvmE77SeAEWzAO78e/
         5dZDVWn3M+caHdWqgU4KNkJpd0EIkBe6bv+C7vjK3ZyQEjxSCxqudATm6EGjxZgi3NKn
         lKjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767456644; x=1768061444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxFwQ8lwOEWkK9q4ujS56V9N9o7jjnUMeX1RAQDDAno=;
        b=cuPX78QGSpKVqM4YZXDWhY3tEDero5dtAtzmLsN7l3Mx9oQ2oN1nqPcpU2/CkR3LBt
         MD3BPFFGhaNQ7WM5LFtzoqtQ7nQoHZyhONg4Zuq+N/S/fyNfQMsJFXzALg9SNft5+yaQ
         NPQGzLdFhZCeLhlgAqlLn3+zmEdN21cyPtSQf9FRZXhrjKFzuO+26Z828OoSHzbrHmPN
         iltD8GiuseJj8wW4CJgSOY2xPLLYPwmOfVgUJh7nmDlUMbSK/fhqdpSHIuwVyVfrwUiI
         vVEtdjqUvtvTv8BHoJ6OReOkqscyIvWidVsmkCxrvnU0ZxEx8VxZecwW4vilPjgAMYOn
         wSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767456644; x=1768061444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rxFwQ8lwOEWkK9q4ujS56V9N9o7jjnUMeX1RAQDDAno=;
        b=l8JolcxovxQh7mkYtw+L6J+mjPJ150wdYM7OV+lZ4SS6ItgPAixKqPz/qEfJzW72jL
         wN/zMC/zJpwvl8YSytCnNo8I2gvHU0McqD9+VfZTJ9xZYAA42Jis6QMx9Y1UFxg/W+3D
         RIs1LdNSndkqSr3P6jWE87UHhcNShHJRIOCTsWsXiTeiWQQHX+AG2fRqolU48f2GhYBM
         Tbsg2F+SntmQTRkr5h4+o4UqCsCSakga1nf2IrIxzBQmSqHrsMixj/a3TArvovRQXLvr
         60y/iUqDcJSF55/QkzpFSaRP54GVFu8k5L1ewa0rQ9i9SQHaK6oeghoDMXY5GeoDOBri
         oQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCeQRQWHilobuGx/aY65IOsCv8XxxpT9vgAZAs0YgWZM1MhhNQMU/wtYj/drKr3roLpKOsSZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MzyXaSK5FYEZ5JXJsN9c5Kpj+RPscK1IOhq4fLfDi25pDJBt
	gBLHYT+iZI2fgPfM7cl33mC8XgoXxq923R+KypfWLOMNfpESNr95z8fRN6X7Ty0bsXc4CbTiHv5
	slh0Xc6RT9CXLyNtyqsko4wmbtCqBK4rmgpdem7wC5I/FsRTwQPsVpXk2
X-Gm-Gg: AY/fxX7bzW1qBRRxnjMgkv7BnHsKGMHD4MyqLY42yiX/ddDgm3CWErvhi79XQwc/zhr
	gco9908V8AG7ddYr0Zn1NqMatdYY6Eln/ZTgYmLSI8pFG+I1eCBNWmafnFe7jyiJRymOvmIkJ5E
	/N8LS922rqk+H0M8A2+b94QbSnitT6fo9zG2Lah9PK0bMqxdLHxdROcSQfzDv7m8Yy4Tj92mg8a
	vgCDVRHZvZrRbfHFHh9igKzlJawzC2zdFalAWhh/WCnsxYzfFqWlbOqiTmlK2C+Bnzgola3MZt/
	FGeX6s7A8dvDxtmFc+Q+9gcoJJZ5
X-Google-Smtp-Source: AGHT+IH4VSFS7H9XXCoXCOhz46vr+gFwgZL4hhqfsA0/tTmkZeIcGB0BgXtOAUwNOUGTbWQj+yfsp9N0wX8rE2j0VFU=
X-Received: by 2002:ac8:5e49:0:b0:4ed:ff79:e679 with SMTP id
 d75a77b69052e-4ff7cfdab06mr4262571cf.19.1767456643799; Sat, 03 Jan 2026
 08:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231232048.2860014-1-maze@google.com> <CAADnVQL4ZPaiwuXtB7b9nrVVMg0eDiT6gnnNGrU5Ys61UWdgCA@mail.gmail.com>
 <CANP3RGdFdAf9gP5G6NaqvoGm7QZkVvow9V1OfZrCPBzyvVDoGg@mail.gmail.com> <CAADnVQJXdRiNpDAqoKotq5PrbCVbQbztzK_QDbLMJqZzcmy6zw@mail.gmail.com>
In-Reply-To: <CAADnVQJXdRiNpDAqoKotq5PrbCVbQbztzK_QDbLMJqZzcmy6zw@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Sat, 3 Jan 2026 17:10:31 +0100
X-Gm-Features: AQt7F2q-QskYivbGlULymmanqYCPWC-YbceFTocPslSfTsL2jdavlfuvLb_fAK8
Message-ID: <CANP3RGemkEqfZi2zzB3YFqePf=6ZRJOiENK9mVTD+mJ+tzJJtQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: 'fix' for undefined future potential exploits of BPF_PROG_LOAD
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 1:14=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> > I am actually aware of it, but we cannot use sysctl_unprivileged_bpf_di=
sabled,
> > because (last I checked) it disables map creation as well,
>
> yes, because we had bugs in maps too. prog_load has a bigger
> bug surface, but map_create can have issues too.

Yes, of course, bugs happen in all sorts of spots in the kernel,
they're unavoidable in general, all we can do is try to limit our
exposure to as many of them as possible - by putting in various
barriers.  That logic is why we have things like layered sandboxes.

I think you'll agree with me that it is a lot easier to
catch/fix/understand the bpf map related code than it is to understand
issues with verifier/jit.  It's also significantly easier to test/fuzz
map related stuff.

Anyway, in a sense it doesn't matter.  BPF map memory consumption is a
significant problem.  As such while we can require program loading at
boot, being unable to dynamically create (inner) maps after the fact
is a way to limit permanent memory use, for potentially unused (or
lightly used) programs.

(Side note: it would be nice if we could somehow swap in a map into an
existing program at run time without it being in a 1-element outer
array... perhaps we'd need to flag such maps as run time replacable
[provided types match], or something)

> > I don't believe so.  How are you suggesting we globally block BPF_PROG_=
LOAD,
> > while there will still be some CAP_SYS_ADMIN processes out of necessity=
,
> > and without blocking map creation?
>
> Sounds like you don't trust root, yet believe that map_create is safe
> for unpriv?!

FYI, we don't blindly trust kernel ring zero either (AFAIK on some
devices the hypervisor will actually audit all new ring 0 executable
pages, which is difficult with bpf)...

The 'unpriv' we're talking about here is not truly unpriv - it's just
less privileged.  It's still dedicated signed system code running in a
dedicated selinux domain, with sepolicy restricting map_create to
those domains.  It's just that the restrictions on bpf access are
wider than on bpf map creation, which in turn are wider than on bpf
program loading.  There's various levels of restrictions. Some of it
is uid/gid based, some sepolicy, etc.

> I cannot recommend such a security posture to anyone.

Yes, obviously, allowing random apps any access to eBPF is a recipe
for disaster.
Bad enough they have access to cBPF.

> Use LSM to block prog_load or use bpf token with userns for fine grained =
access.

I hope you're aware (last I checked, which was a half year ago or so)
BPF LSM doesn't work due to being buggy (there's a hidden requirement
to enable DYNAMIC FTRACE, without which it is non functional - at
least on x86-64, likely all archs) - trying to attach a BPF LSM hook
unconditionally fails with EBUSY on such a kernel configuration.

I reported that here on the mailing list, search for "6.12.30 x86_64
BPF_LSM doesn't work without (?) fentry/mcount config options" (Aug
22, 2025) - you were cc'ed on the thread.

