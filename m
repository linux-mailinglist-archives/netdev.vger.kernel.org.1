Return-Path: <netdev+bounces-248290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C51AFD06877
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 00:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6D1D301A636
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 23:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC6433CEBC;
	Thu,  8 Jan 2026 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PoYU/nyR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F42EFDBB
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767914460; cv=pass; b=kkLAu9KyZ9ibZax0yFSU7J5n9Fk7EXadplSITnZq7YgKkDFWgpcT5ZFMA/qwzKAXW7dWQKgMwip0Ddycrp0h8BA2FmD/wwuBnu0U3hKCnURPq0IkYZlF5v2YtDTZbQ4+qLe/3ARj+NVk4Djxh297osvSX1z9D2vy6sB5MvAU/QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767914460; c=relaxed/simple;
	bh=rhCQWH/yPA2hIsQ82SImjkWBzo10eMRYT8Mz8RFa9JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4uu0dwdVYwFwqxJp/PXQbR65zqU/mVtnEHakIb5qD1O/ySPi1XdKdsoxkX7unQj9MYzZrPlsTkXOTnJcF09xRc13Pb3zRBxVQSFjshpsj5A0+J/NJKWLlya2aq7xtrTH9n8pzWBJYbgHOWu7QVJdplBctiS49+IMsCNs5wKsbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PoYU/nyR; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee243b98caso79601cf.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 15:20:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767914458; cv=none;
        d=google.com; s=arc-20240605;
        b=P/huK9Z1yB7IvYgwYRQqnxlU8g59brrZfrmm45J+9M2zYK/0dIoffKByl8x3zMfvHy
         8OqIrNzp+ldzQwoSOpWQ5JliTmH9oJYZWzBN0XyZyVovym0EX80vV+eTfM+ZoRVAI7+a
         SzI7Y8wfv4zEqgqpoC6valEmcih8TJur3aBkkl9CP8Y/TQRwDa0r40fYqGYzWQQyuqH1
         /O6jBLrVRYNCt9OjR4+IBSLECep3vbix7uTbi5rLf2XbH0bo53/YVpMviWWtolio7U9B
         sqUp5LU/Eq50gdR4MndjfqlXlNG2ltpGQ9JI9HePfUtJCGoNRkEloqTmY2Zdo1L2JQIy
         SGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wj+2ERqBcujhHCH9Aw3uOT+r18qxiQCPwhg6TrYRXaA=;
        fh=8CDcCm5NHD1KT4l2TBOX0zbMqFM/Vexs2xQD0DnJGJA=;
        b=Zfr0EnNzWcE5HdbmunwhtOkcFuns5j9wDgpT+0ldecIApO9lpG9ddnSIi6p6V6AIXM
         9lxnV1Zcvn2kKjctRfQPRzIU25ReYdC4K4ToJKdes6ykgCAxO+6CqNJbm5JFUtuucgOE
         nkq9llQdkmw+d0gozjIVTXSuk2vJCzTh13loWixrkaQuJ8CjJbshPLZVCSS1jIel/CA3
         9BlqlVZxyzu5XDVI30ZYsCY8w0ZOA+S6O19swzHb3nbipMILnVkbIEFyMJpXh6Hip3sq
         ggUP5L9TM33PZoaecUdme9EUWQB90y0UesVRao2LQ1nZdqPh4baViVfaHwphjrt49qec
         ca7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767914458; x=1768519258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj+2ERqBcujhHCH9Aw3uOT+r18qxiQCPwhg6TrYRXaA=;
        b=PoYU/nyRL6U8AMm+w6+xHu6Rp4iz1e1Zjwndtf1P91rPFzimAMia/xk5fhd449Yzxq
         wOals5bwl/YzYefe3/yTZAjAWkISnRAZn8K1QbpSXs2ccRYiBBAN7hFiMcvfG2xwNXC1
         K57zh+rov+V7kAdpWShLKBCoQ9SSw7P9vZDUIf9q4Q8vTWZJ0QcuRBaPhvGnNIkmk64d
         tEo937ako0z2KeIh2dBrKuWwBp5257PoYUZg7RYNYYdqCoTlndR5zq6h3fwcT3bizaPf
         M86h+FD6RdajgFP379GAaSe+QJc4JG99+Zv5ieYjS26cJc7oZwDse17dx9FHSYA2SaM6
         5gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767914458; x=1768519258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wj+2ERqBcujhHCH9Aw3uOT+r18qxiQCPwhg6TrYRXaA=;
        b=GTS0fUafOOBIKig9XuiE0mvvZl78j93nX8bZszmohBDPCOz/nbUn1yWEuwIgNasgGG
         /NJrQqeDX7gADtO16C2hMKMuvzOQUL/D6ifBpyvxntB/m0gF7TKuLcTg4H4WeyHvHAn5
         zcwA/lrFMgzK2+CboczVsIJ3xvl1b8BWyBly1mxmSJGrMLxkmiuJCZrO3RAWNuw6k5lw
         wqT/eO4veASTfjXe+3VNxS3T+QP/5nu9B6U9XBWg6e6wMEOMSyf3N8jb9uE8o3GLJ/Nd
         op0RcWvtAfAovw9CgTWhIeVsmzz9ZSMtBKUSoWHKiIv6HjJv46RS6KUYoBoIxXvZEhZl
         +Xpw==
X-Forwarded-Encrypted: i=1; AJvYcCVc+3Nk9LY8KmnahUazN5nSNDtqyb3y9jeqSNlzzF5OP0KZilrDxB5+5JoyJ00xTR/ZBakzihk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0dCMdcb1y9kAidZAQCuWDNHgjtFYoVDG9x7LxcibkzyQZTZ+
	fJSpLtccR8w4r5+hBy0ojaZYA4wv0l8vz+LeTWO3Da9Ng6RGib2VOg+NvoSfb86uOPBsDMZLPy3
	Yvy/935SoIgUemOUtpTV5DxNUeB5/bMdArCd2R2VL
X-Gm-Gg: AY/fxX74uiq/qYTL9h9G3nxv/XfmP7XAMsk1K12TjtsEQx1Xwg07iwvD0auJgdzkcoZ
	ZvPvx1E7u84yVR2tsoqvmFFhuB7hRgeEAjgTu8/eTDEyGW/QyIQXoJsE/Oqx2jkJ8rpR3wrwJLT
	6HwmF2/KeolfL2Qk5m1jwUsY4/pcDxljjXaPpIE3zGcJzUSszUCzdFYvGsoVzR7S83/ruC4YSQV
	YNLcgRBqqo8jnA4E3nSHes115/p9M4aQFELRXMAIx4edRGwg5nob27Ek5YJxKRjNEbCdFvGCXWd
	Zl9RS/nckNIvS6Z03P2Jw4h2/wMCkjd/T+lu8Mcm0blfBSPH2nc0pUkXrCPpXZ1EzE06BA==
X-Received: by 2002:a05:622a:451:b0:4ff:bffa:d9e4 with SMTP id
 d75a77b69052e-4ffcb20efa3mr2340841cf.13.1767914457681; Thu, 08 Jan 2026
 15:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com> <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
In-Reply-To: <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Jan 2026 18:20:40 -0500
X-Gm-Features: AQt7F2pqVzz9M7qiJp7DfsnUleYfVSMGUfqYVX43z4keU7aZSTGIZ7pkvS8mv_0
Message-ID: <CADVnQynohH4UyvyKm9rUNcCMbnepJKMwhOCPRFzM5wTvpDR1ZA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.co=
m> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > cover several scenarios: Connection teardown, different ACK conditions,
> > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > retransmission/reorder/loss, AccECN option drop/loss, different
> > handshake reflectors, data with marking, and different sysctl values.
> >
> > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > ---
>
> Chia-Yu, thank you for posting the packetdrill tests.
>
> A couple thoughts:
>
> (1) These tests are using the experimental AccECN packetdrill support
> that is not in mainline packetdrill yet. Can you please share the
> github URL for the version of packetdrill you used? I will work on
> merging the appropriate experimental AccECN packetdrill support into
> the Google packetdrill mainline branch.

Oh, for that part I see you mentioned this already in the cover letter:

  The used packetdrill is commit 6f2116af6b7e1936a53e80ab31b77f74abda1aaa
  of the branch: https://github.com/minuscat/packetdrill_accecn

Thanks!
neal

