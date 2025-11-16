Return-Path: <netdev+bounces-238961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CDBC61AF9
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 19:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 922C54E2D36
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77FA30EF69;
	Sun, 16 Nov 2025 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2gks8oc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D82F6569
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763318505; cv=none; b=hNnoeOtUztHlEFjiOl8gTiYLvhUTBgjRssdwL/+GA7BtwfPNhlbirLa84r1HsWYzSPDmSDJKD7O1+XAKWfIoK6sKozU6ADxKmJOGFvdIcBN9sEacW+d4qYWRPOxt7YzsGJA4MVSxmJPVjg2LITcEIno1Krp0vjKnyg7zzZ51mwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763318505; c=relaxed/simple;
	bh=OX2dz1IsuZ3u/q04PmVqNF4uqRvtSGeeaPBG/449gtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZ3XFsqRJ38NEVbQuGDhvW3Q6XX70YbH4Kf0mTiO9VxJwrKpBbEmeiOFaLvUDsW3+9eQtJ8nTcCbwpXkCrPikyMLfO30f9kCR9akTg2K1rvyjaQmSIbaDVNPiiKGVO4g7jC6kjOSIFTr7FtTm2j+0mFCsxsaFvNBefPLoJPvnfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2gks8oc; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-787eb2d8663so49058297b3.0
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 10:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763318503; x=1763923303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX2dz1IsuZ3u/q04PmVqNF4uqRvtSGeeaPBG/449gtU=;
        b=n2gks8ocI7b0lcXw7i9zMPXsFldCrKZMIQv6G+GUh2D82mQsSTX8ry3A0o0SSnoWQN
         OASN3++JITKDTDKIDiEADo6gbNrh94e4Cc+gzVJ0A1t5leDeev8EdqVv6ZbjwDBh6wfW
         1yIawcxpP4oPAv7zIimXNChN2UKbIi24YllSbUzRDeQjAbrdxMoycDZ6pBn5DmW+nCyH
         PtIhZemAoJp0d+tC0mc+yeTCCnnkVtxqX6UhzjfhTRzMpt9+pacwozR64/2ntZAT2LP6
         ym2NTR8OKqdwQHFHEc8DmqXRRPmR3sT99B8gWpfZtCCQsoz5IEEju9sIim3qcQ/gfnkN
         zB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763318503; x=1763923303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OX2dz1IsuZ3u/q04PmVqNF4uqRvtSGeeaPBG/449gtU=;
        b=bvls8WMsPhT8UOodXNVdcp4u985MKDoSB0G/6vZHNJ7O43hLc2+qD9L1m3Uz3EjAou
         +mgtdaPL6i9FBM7Op7XMKDCUtSJESST/6rf1wLRj3bRLgbgG6f1LFfds6X2OSUyVwvDy
         TQtALhuofLfKaVC5MOXJ8GRDGzflLjs7dnQz2nml/q0TywIduGDvPG0fMl4m1GL6H79u
         sqm9KN4T9DQ24/4zNg/jBep18thuo/87p63QPRsU61UtRfvkkDCnmXG+YcRWhy2HuK2n
         IEl2Q8/6rCCLpR3lybWwPKpi7D+xappkuvIs7rUF8iGasUbGSU/5bVXxFZyx084X98sE
         Lcig==
X-Forwarded-Encrypted: i=1; AJvYcCWmSxvZmMr9LdQCYloMwlGDSi/A98hv7KI4ssNhz4gLaZY1Cuuq1vYuQpsNqZSnVaQWu6xGtTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0VsIdsi+kXslv0S5filmavO6kSmS2XrqnkPjzlox2HTQBonS+
	8hhINa97ItJBswqhIsxziuaW9zwpnYvdfYR8dzqzmU9+Y/xcPgMSb41/1YJYmiIt1/8i7trvvZX
	ZMGrMJ3n1MRPun4nvWa5oRoC0QNEw09FS7qpnUqy9qOhnsSmrHA3gjTGL
X-Gm-Gg: ASbGnctXNq7jWxtgGbDcuBSlrSW7OHgSKszesF960NcsMIa3BRR50MxLruxewVHxmfc
	Kr4BcMojgEpB6Bcl4Q1F6XgFBiOjXPPXRMKgmMUPF8+t0WWq7KRpk13vMDEnwR7JmYs9jj+vIqR
	NDb4pYAB6op5XohqpZOxL85mCng/9QzY6Z4tUODTVP15BeyuDs8rQjPIkUuHRInwnzFX8mElEv7
	QY9pbhdGUJgyVMq55uTbIEXoCd8N8v9ZlDoaD2Nxpl6EYIn2VQu0iTiDuKByIe76FBmEQ228Tet
	ssGSXQ==
X-Google-Smtp-Source: AGHT+IFB+VMK3mBchE7T2LiMjAFB3uN/r0/XXcBBJ7eTTs8zXYY16FK+MFVUgaljz/oh+/k/NSVgB4FqyVk+KlVw1QI=
X-Received: by 2002:a05:690c:e3cd:b0:786:504a:4fef with SMTP id
 00721157ae682-78820702922mr114009647b3.33.1763318502748; Sun, 16 Nov 2025
 10:41:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114140646.3817319-1-edumazet@google.com> <aRoRKp4yDGOsZ4o0@google.com>
In-Reply-To: <aRoRKp4yDGOsZ4o0@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 16 Nov 2025 10:41:31 -0800
X-Gm-Features: AWmQ_bl1bFoubc5fIZb7tDV24DFTjwW3_ND966Wj0fPv4FdoVwIVjYlFpVHRk08
Message-ID: <CANn89iKYLf1AWi_YvK47NvQXb0B31NHxF736dXYg=2E5Xxg0Ew@mail.gmail.com>
Subject: Re: [PATCH 0/2] rbree: inline rb_first() and rb_last()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 10:00=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.co=
m> wrote:
>
> Hi Eric,
>
> On Fri, Nov 14, 2025 at 02:06:44PM +0000, Eric Dumazet wrote:
> > Inline these two small helpers, heavily used in TCP and FQ packet sched=
uler,
> > and in many other places.
> >
> > This reduces kernel text size, and brings an 1.5 % improvement on netwo=
rk
> > TCP stress test.
>
> Thanks for the patch!
>
> Just out of curiosity, do you think rb_first() and rb_last() would be
> worth marking with __always_inline?

I have not seen any difference, what compilers are you using that
would not inline this ?

