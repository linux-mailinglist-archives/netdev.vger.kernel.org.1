Return-Path: <netdev+bounces-250106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFEDD24106
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 903C53017012
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3398236E48B;
	Thu, 15 Jan 2026 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFj+qDY2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD04236E485
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475230; cv=none; b=IDPq8OSMh/H4H5gB6RVeIEWA4ZX09RSBPtlySteHFqFOYDmAp/d0rb5KucNBvOJ+zIs1TK5Hl13QkIbL5OiWQZv2mRettWeM25FP8RZNPumFF/xU/6s54Io3aB4LjDbl8zE+1GbwfgYj4WBdoBiRMPGgJkwGrJrvRqGf9TsNkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475230; c=relaxed/simple;
	bh=6fUiY0+rCl3UEu3u5p5tJ3fwQpm2cLu8Rc9fum4XjTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/MVNAf3w5eGz+mQ9TQBTH0/v+tIGMiqEq60EAF375QR+21VDAcqudpf8tmpQPrNne8ha8+3m898pWa060KCOxGoeO2Ex4dV3Lp4AP75mVuU8S0wNElzNZduz4C8k2nx0GFDsqCoVRNbDQqseRbXlrtVoCtBKLVSYCnGDBYH3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFj+qDY2; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c53421cdbfso82588385a.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768475228; x=1769080028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fUiY0+rCl3UEu3u5p5tJ3fwQpm2cLu8Rc9fum4XjTY=;
        b=FFj+qDY2bF9CgaQO/OpgfwtjpOTUyCuT/YRPuYU7s4v2pocpU0ngFvBht3vWSj37EP
         Wumi43RYXqH9oVmw3bgB+7sSAhjSWrzQ0REmpfeeACnpPxC+Fk7pcoYPQRPOhFsW8Aq1
         3vW2p+6EmZD9oFPwubeUggNm4Py9NYXE9p60EmE5V2hVJyBU3geaPoqJP3SQJa24YXLs
         VK7/D7rI1wEF78GNXMeZkKi4iWPytoaV9ixRXDYIyzN5vfc615iICBigHlqK3onF6F0F
         cyJmZHj9rP9PvcJngb0FsBNHEJKGlyyRXlEV3JTpG26QuyTbtmUocbE1CCwKGLcmehTf
         STVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768475228; x=1769080028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6fUiY0+rCl3UEu3u5p5tJ3fwQpm2cLu8Rc9fum4XjTY=;
        b=n/yj5Iu7N/rSNovQsmN5wuaAls6wExUrnMv1IiLoCwQoAO6ZwijPmMMCn4oRat28cb
         x3PfVR1UB3tezM0iMN8HV61uJPs3jzPxBysIcu1PllPnAb/6KLOxKMrZE8rabqvlpAU3
         PYHzx9EaJ7TjAnYOTOL4mH/RtGTd/PS4ez4ERwk1rkyr0E7peJwzq5ofUCyao13f3A2C
         cVCe2/nEouKWNPfULhFRm5RUVWKVzqxzCFCnWymrVSGfVLV5fGYHHlO6c0SslR58X/E1
         +/QJq50YxMiRalelL4DfcIFzWralyk8C/vtOVmY8VVKw27fX2u6jUdp4Xv9CpadFdT+j
         VE0A==
X-Forwarded-Encrypted: i=1; AJvYcCW2XNS1+dVNuKsrXGaG6XfO3CqfzHKuFJzI/mOoBqF74jziYP2nFOM4aLPVudge3jU1h+IF+Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/ZnJiliF3TCn54FzEe3ADEfnIaBNFiNW6okCb6GwgLm35vmi
	EUQJI29OGJuebIWgJWM37xIYRCOblCiOZf3jPRn/aOvcT8iLCqcEfR543Ow8Uoswdi5WoRwLR++
	x33atEeS0mD7B9sGKJ1VETg2DDkuQCgX7I691Zt1l
X-Gm-Gg: AY/fxX7zVqCzPrt8jp9efG81VEQvIvx/lUTuyQoojkx8IToy4NOPscmULRCBQadq2C3
	riPM/8/L0lP3jPPgT6Ktt2O7+x47PfVO6S/jqdYL8mrKp8uu2+F7cqwi13+TEL//7uLeMabSqj7
	lTnWLXDaqO68w1XZtvocWZ7POP3cZiUAW/mJHETinh3yyPoHbGZCKrDSSemWNhCrjpo9RojI331
	Dej3gwaiHhw36A4CB5sS6V543pdnFKD0m1duycScDvB8yZ31B4sXirFcBdWWYIp34q6AJTcA0lJ
	Hmlv
X-Received: by 2002:ac8:7d09:0:b0:4f1:b398:551f with SMTP id
 d75a77b69052e-50148488accmr91072181cf.68.1768475227363; Thu, 15 Jan 2026
 03:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
 <CANn89iLVq=3d7Ra7gKmTpLcMzuWv+KamYs=KjUHH2z3cPpDBDA@mail.gmail.com>
 <CAA3_GnrVyeXtLjhZ_d9=0x58YmK+a9yADfp+LRCBHQo_TEDyvw@mail.gmail.com>
 <CANn89iJN-fcx-szsR3Azp8wQ0zhXp0XiYJofQU1zqqtdj7SWTA@mail.gmail.com>
 <CACwEKLp42TwpK_3FEp85bq81eA1zg3777guNMonW9cm2i7aN2Q@mail.gmail.com> <CAA3_Gnqo37RxLi2McF0=oRPZSw_P3Kya_3m3JBA2s6c0vaf5sw@mail.gmail.com>
In-Reply-To: <CAA3_Gnqo37RxLi2McF0=oRPZSw_P3Kya_3m3JBA2s6c0vaf5sw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Jan 2026 12:06:56 +0100
X-Gm-Features: AZwV_Qg9ek4dMZolBKLAHsFHpAWlhtxV0SMKbpiX5faPw9Q8vumNLVesml4-mI0
Message-ID: <CANn89iL8FnPG9bD6zW0eHmeSNzc33SJgrUR7Aab4PFG-O4nfTw@mail.gmail.com>
Subject: Re: [PATCH net] bonding: Fix header_ops type confusion
To: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 11:33=E2=80=AFAM =E6=88=B8=E7=94=B0=E6=99=83=E5=A4=
=AA <kota.toda@gmo-cybersecurity.com> wrote:
>
> Hello, Eric and other maintainers,
>
> I hope you=E2=80=99re doing well. I=E2=80=99m following up on our email, =
sent during
> the holiday season, in case it got buried.
>
> When you have a moment, could you please let us know if you had a
> chance to review it?
>
> Thank you in advance, and I look forward to your response.
>

I think it would be nice to provide an actual stack trace of the bug,
on a recent kernel tree.

We had recent patches dealing with dev->hard_header_len changes.

