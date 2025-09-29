Return-Path: <netdev+bounces-227226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31421BAA9EF
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 23:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701841895664
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 21:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1D258ECB;
	Mon, 29 Sep 2025 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNzW64kw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6D2512E6
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180224; cv=none; b=aRAQ1iPtUmuz0njgxVFH/VnOA/mrogrzlF72KGlE/jeZ8rjw3RruCdT1SjAs80GRQyJCPRh9j24haNvzo5MqQzHyF2YoDIdO6z2C3h/jiCv37mgGTSHlF8P7ZpFHDjOk3YOEJPI25vIkB1qvvu8eMsJtmC5v+noIxQ2tWfjVA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180224; c=relaxed/simple;
	bh=PnNLfDHqst5vd6hrb/TK0HQlW3cZh7E8xmcGWIkSs4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sc+9ITeuqYlpuadRm+sxPenUqy8ECsNV1qg9Z0Tx74w1+MOGxZFR2BRFXW2f5KdHprOvZDQhvyN2CIZM/UcXJUT+as1TKKEwFV5c1Gzoms4tdcGRXn55TU+rcDD2art96D7/ZpG5uT3EoYjpFDab36EOZrH1Ch4J11LGCdtM8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNzW64kw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso7083789a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759180220; x=1759785020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnNLfDHqst5vd6hrb/TK0HQlW3cZh7E8xmcGWIkSs4U=;
        b=bNzW64kwbZdLoiCXBuNIKK+v5tbJpTqExvDDCFPrkP7sMK90AF9hZtMGVWEjmRuo7h
         2hbXiBxMxNHuHZUij7i0cI+b3Oh2j4PxM5SZiy9F3a8NgmrtaF2yXWM5qQ8yb8qmdpsw
         kYs03kwZUlDwfDgaQPBHJULnvFW/drSJ/uhuhaBaTKannWQn50ehWCj+GMAgR828qYFh
         X4N6y1woELjh5uFcL8tZBDHuWwQeqPNH9c64YXV/HtYlLLQv+VSj+hJHlpivIOTMzCqc
         xJQzcjFr54S7wqsY4YH+XeUawl905JKvvjnuUdjMsuFjOcUqyqxeIBR3yLMH8Dtv3cb3
         kAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759180220; x=1759785020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnNLfDHqst5vd6hrb/TK0HQlW3cZh7E8xmcGWIkSs4U=;
        b=oF8BvUWLZKSPISljHddG8H0a2eBElS8OBzKJHSMFtgHLpLQz61rR5c/i8yvvNPrGmf
         Kyc9W0Lt08NStPftRKUqcwucfGA4fwrEXluGfFKvDd0LIzfB50iZ9v8V+x+x1RgTZWSw
         4AcvcRqG2BWE1X1jsWagopfu3VQUuDqZq5UVm04c+3oYRye8TWJS/DjIWVg9t5/z7cWJ
         8Sup+TCxuaX+rTv1Zzj+MzN60UNtrDza9PC7kFbep9QXZAUCH1QLd/Nd6j7T84TiNCqn
         ZXqkYYHDBoY5qcSr1yzH9uG1Cg2hOK+vz8nt+ezvkjnz4hG3d6JQUqzxi9CLPDdDlhzP
         BIMw==
X-Forwarded-Encrypted: i=1; AJvYcCVcTVLNzV6WLvUvUp+btLw3ntsVyIKDbdn0AcMKI0BAyjAqxBLISQV1H6JzbJt6BBEGjOeT7wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXBf8LOrLMYiK8ZZQisU8NfmtziHHGL0qeV7QSUD9JPVJU6JQZ
	4csb2fQ3dTEtuu40fCOTdn8Jk2iHh4VrlcPsbKlGCTdR+1d14UJLSEK2OXMo4wQZoyjH4+IEqWY
	TpUcjxpXoFEIrmuTVVqcGUuMMfEaAbpE=
X-Gm-Gg: ASbGncsWAvUmwSgwqREwkK6MMV0E460nM/syT2gkzVlGFQhdh3SxwrkTFgJ71/xcmy0
	D1PjQotWqgex5kw4U5v0wpNAhFA5Cl16zVtka2S6vVUIEsOiFfzVhNBl+cH7wArdu3wuOyTzPN2
	/M+JcnNo17G9dOuKABTmLGbHi/tj4EqDrZXRX0b5EvDf7T6tLhU4W1vUmznt8F5iFImpw7b4+PK
	VjLQ/7qx5Di78kpXlEfOV/93kDgywnEOIRnkTjBV4OlFNQxNB6/
X-Google-Smtp-Source: AGHT+IH6lV5eV1Kt4fx4PJQ/xnpUMkEAkksSmL0ApQf1NYE5kHd4rYc4X1ZnoqKFvlP4C5fI0NBai3/kdLcOSzqbyko=
X-Received: by 2002:a17:907:7289:b0:b43:5c22:7e62 with SMTP id
 a640c23a62f3a-b435c227f87mr12156466b.50.1759180220317; Mon, 29 Sep 2025
 14:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929160230.36941-2-sidharthseela@gmail.com> <willemdebruijn.kernel.321e70874e73c@gmail.com>
In-Reply-To: <willemdebruijn.kernel.321e70874e73c@gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Tue, 30 Sep 2025 02:40:08 +0530
X-Gm-Features: AS18NWCEmn2M-D5zHU0jlR919m1nzZwmzKwrlDEi5S-4Vw12GrNcqqXAq1DzRds
Message-ID: <CAJE-K+B0xssX5TCwxyUwGu=vGMR1u-7r-3wDiMvs4GnqCkYUqA@mail.gmail.com>
Subject: Re: [PATCH v2] net: Fix uninit character pointer and return values
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: antonio@openvpn.net, sd@queasysnail.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	kernelxing@tencent.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:28=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Reminder: use the net prefix: [PATCH net v2]
Oh I thought you meant me to change the subsytem in the subject.
Changing.

> My previous response accidentally left a state comment. The main
> feedback still held:
> This default case calls error() and exits the program, so this cannot
> happen.
Alright, I thought error() is like perror(). After checking man pages, the
status being non-zero leads to exit(). So yes, it makes sense now, the
switch case, either loads up a value in the 'reason' or exits().

> End the commit with the Signed-off-by block. Either move changelog
> above that, or below three (not two) dashes.
Alright, Thank you for taking the time to reply. Sending w/ changes.

--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

