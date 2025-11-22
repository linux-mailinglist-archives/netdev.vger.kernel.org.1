Return-Path: <netdev+bounces-240926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 410A8C7C195
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFD9F35EADF
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29C929D28F;
	Sat, 22 Nov 2025 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKLVZDBk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9C239E80
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 01:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775403; cv=none; b=jKPg+Z8lRg/EqK9SsNPAEpEGRZMu0nI85X/CJ9ivSmlnWp1jgE+YjG95HHb0GGHoj3hwajesW67agP+ChV90ZCd/9DIBcy8LqVNdoXqxRXHtTyZxnGVFf/g24ksyVhAsZ5mKRffJUwwxXU7YkVnietkGIDPGWhxhePmO3DfJJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775403; c=relaxed/simple;
	bh=lSIKeSSdN0SBBxsZ4+EzfR7j4n/zPOL+lRRertv0kLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RN7AfDUSwNlWcCd2oEfFdjuAijAPFopAZq14OgU+tX1amVBZ0h0ZyKtXgxRRm9+bpsQDdV9ml/JK5v3w2+bFgpRgczefsxZL9cO8npa0iPWrjoy/2in83ID/Bocw3AszBzAtxJq3x/HzFUrphqLOaJNGwklgjQt9qFVqJ8OFm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKLVZDBk; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-640d43060d2so2365096d50.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763775401; x=1764380201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSIKeSSdN0SBBxsZ4+EzfR7j4n/zPOL+lRRertv0kLQ=;
        b=OKLVZDBkqubKwBh2WSy8yUObxbSd/X9NKONl9pYtKNRxIpIPHmH3TIjBT6044bYFDH
         8ZFl009wSUcP/QYe7+A+Nu45jQ3B3J3wpE+mpSZ/4L96s2AMbws5gV5DCFzCIIQE1nQ6
         s0YrPzE9WKe/9wV/IMOx8speEqBzKttUKPwmTMquXxxBb4edq1r7pfhRr9cEQaw10m1/
         KPrksvpfqdclpSZ9QEaiQbuzE8r9t351KRChDfPh+WlgDiRn/Td8TUVqX/KC2dvYWOq+
         dodn5hZSkdw1D+8ki6pfIj1kdtWGdFD1g0oVBlLRfCs9QVWKjt1JccReE9Ty5Z4M6n0n
         bM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763775401; x=1764380201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lSIKeSSdN0SBBxsZ4+EzfR7j4n/zPOL+lRRertv0kLQ=;
        b=ini58DQIOhfmrSnPCpQdeMMNOa7PLM9OJljgpUMLSe0+ERllPH82tt5+KNfAzJspRV
         NMvBKf6pGllBSs5V9gTWck9OocR4+cCdmbejzg10acebllBmZZ61w2NEorNcTy5C7kVV
         nNQDPgCtl26zwPFmE+SYJSVGY7Sa31eQ7iw/aYwT1vkIiwblDJwLGBm1urdIu4RoyIHc
         NLYY/tY19VQS9jcsddxTnLpaaa0v7jRjFJzYJxjlrcJYhvh1u/W3TKXf6/26EYfyAvbr
         kuQsRQGahVkBymwF86pbsBBAFGlG1V8OWBi8eD7CBM8iwXRK32Jy0yZaaSWlxOBxbLCb
         Tsmg==
X-Gm-Message-State: AOJu0Yy2sNZ125Lg2uQjcT4iUipwC+ABcGF+cyJIWZ/z7M9V0bCCwf13
	j+sfqZHmsv8jPOoEBP9hBzw9iyjdUL5WaUvENV+tTsworfoCbTnbH5+CBloTzurMoGege8WX/qC
	nxfdQfBZWCpBhgnCTe7EwMZeEuwp8TLA=
X-Gm-Gg: ASbGncv5uyVh1OCKx900eM/rRwa3kmgL6DbF3TNhhkt3bzYXwKWie495DjM5DBTGs9C
	aOfaIVQteGSWMKVP6CmyIHflgJGGxPLfS4mT7lpByX5rk7VKKOtedpTG6DvM8EzN2q7CPtmo2oS
	m3Y8EBQJPskfO30QIki7+hYH6EJlfVUVv4CQZC3y+AkRz+dUQF1lytiSqanAejkrkasD7682fk2
	uuaVMP3WQH1ARYjeAbR0ntdNw64PWQGPYlfY5tL8qejafIBIa5E1G5SnGl/jjzr3+BaTM2g2YaZ
	4VGTxZQ=
X-Google-Smtp-Source: AGHT+IEEcdXpW1Ky9zijzeuapP78vdemo3GsNAJC0YAo753LTJxCkEd//RTstJFeJ2xLGXeW1BCWyjmKKeZhiNoPUBw=
X-Received: by 2002:a05:690e:1488:b0:63f:bc75:6ead with SMTP id
 956f58d0204a3-64302a2f958mr3111193d50.9.1763775401006; Fri, 21 Nov 2025
 17:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118070402.56150-1-jiefeng.z.zhang@gmail.com>
 <20251118122430.65cc5738@kernel.org> <CADEc0q4sEACJY03CYxOWPPvPrB=n7==2KqHz57AY+CR6gSJjAw@mail.gmail.com>
 <20251119190333.398954bf@kernel.org> <CADEc0q5unWeMYznB_gJEUSRTy1HyCZO_8aNHhVpKPy9k0-j8Qg@mail.gmail.com>
In-Reply-To: <CADEc0q5unWeMYznB_gJEUSRTy1HyCZO_8aNHhVpKPy9k0-j8Qg@mail.gmail.com>
From: Jiefeng <jiefeng.z.zhang@gmail.com>
Date: Sat, 22 Nov 2025 09:36:29 +0800
X-Gm-Features: AWmQ_bmNfulo0Y3AhLxrzxVt3M2ENJKcudUeNbK9Mf1eC90GK2aeMW6Fd50qHYY
Message-ID: <CADEc0q53dNkcfk+0ZKMRrqX99OfB-KonrZ8eO2r1EC-KLkfXgA@mail.gmail.com>
Subject: Re: [PATCH net] net: atlantic: fix fragment overflow handling in RX path
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, edumazet@google.com, linux-kernel@vger.kernel.org, 
	irusskikh@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 9:06=E2=80=AFPM Jiefeng <jiefeng.z.zhang@gmail.com>=
 wrote:
>
> On Thu, Nov 20, 2025 at 11:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Wed, 19 Nov 2025 16:38:13 +0800 Jiefeng wrote:
> > > And I have encountered this crash in production with an
> > > Aquantia(AQtion AQC113) 10G NIC[Antigua 10G]:
> >
> > Ah you're actually seeing a crash! Thanks a lot for the additional info=
,
> > I thought this is something you found with static code analysis!
> > Please include the stack trace and more info in the commit message,
> > makes it easier for others encountering the crash to compare.
> > (Drop the timestamps from the crash lines, tho, it's not important)
> >
>
> Thank you for the feedback! I've updated the patch to v2 based on your
> suggestion to skip extracting the zeroth fragment when frag_cnt =3D=3D
> MAX_SKB_FRAGS.
> This approach is simpler and aligns with your comment that extracting the
> zeroth fragment is just a performance optimization, not necessary for
> correctness.
>
> I've also included the stack trace from production (without timestamps) i=
n
> the commit message:
>
> The fix adds a check to skip extracting the zeroth fragment when
> frag_cnt =3D=3D MAX_SKB_FRAGS, preventing the fragment overflow.
>
> Please review the v2 patch.

Hi, I've reconsidered the two approaches and I
think fixing the existing check (assuming there will be an extra frag if
buff->len > AQ_CFG_RX_HDR_SIZE) makes more sense. This approach:

1. Prevents the overflow earlier in the code path
2. Ensures data completeness (all fragments are accounted for)
3. Avoids potential data loss from skipping the zeroth fragment

If you agree, I'll submit a v3 patch based on this approach. The fix
will modify the existing check to include the potential zeroth
fragment in the fragment count calculation.

Please let me know if this approach is acceptable.

