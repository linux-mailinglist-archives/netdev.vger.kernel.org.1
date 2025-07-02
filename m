Return-Path: <netdev+bounces-203370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9262AF5A57
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05ED1C2269E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA6E2857DA;
	Wed,  2 Jul 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8k4UJsN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E02857C5
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464810; cv=none; b=WRF0O+y2Bgkey4lwuntE3NHldO8bXKwZTTKK3SafnwiYrm8o0kZMNRCGTQLFZudRij66zfRZIlls9ekT1sUD+oNOjHPLAyeCOahRTm+9HVbXbcoIUoHyBpDdwEPN9quH4Ic+VpOWZf/wAk+HOaLegKJXRte1rDU0OMkUbTdDnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464810; c=relaxed/simple;
	bh=334YBk5ho3itaFbhHkxVkPmHyXwS6qZYCVudfb1UGFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFBj1Ty6IdTDRk9q5rl5LsoP/VwJnfOVRIdnmJj9xkfojtJuhy3TnPaQbX1p2s0c1QAftf+pSsV3ryB0svnXZ9FOYJvik5ramorHaOmYqpWsadeT/RyYGb3EasuUd4lkB3r5ZsyIjtnwpSVLg/9P6rCuzA0/CA+wYni6L031nm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8k4UJsN; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d44e3a0169so291349485a.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751464808; x=1752069608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAy5pJVipOegXkcFxex+Nx+8U9RPqLz52WABvUkCFNQ=;
        b=p8k4UJsNFmJH8dmxp6Hogh2jRnL0joItbMbK/ovZlfPGo7l1EYY3pDfyeu0s9zTc6+
         mi2JtYEaTsfSJ0e/BxovsivoZMeXc0ixXlmLTeFFGvapAbbbY6qcFU3I1Lf45SmuCHOz
         IxVyOmK6c2MVNLciiRam9SGV9suzpBkGImYc+/0vH9F5jXEkKLnvJ+dbQeRNRQMX0BAe
         ss0hDkTEKXM8oK+fHkeRehHwdEYMKWczTBgkquJZZX1oTHTXqaGZZphrINtXXdTj9dCr
         oDfhtGaEpuA3yQYkZrEl7gxGymlJIi7YhqnVAHDanAapl2BSbIDUXii3wdLPSNz9g6bP
         CCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464808; x=1752069608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAy5pJVipOegXkcFxex+Nx+8U9RPqLz52WABvUkCFNQ=;
        b=PS2nq75evpO5EsBSOoBmoFbnV5AWf4JOhHYT8WPrRpnJ6gyM5ky+n3YXXS4LsvHHf/
         Gsq5VnIAl6epX54VPHw5NTmuFWCE8c/Er2FRC7hZMx1H99GubR+7CaXsJh04YjRwLgXc
         JOSg//feav/aeyOo3Zc4jicNiO6lST92ye2qv//lSoHfIm+UFP2WGDMmHO0TrwDqNSgA
         G48usVE+hUm65FVfkTpcp6+EQAkODFMUl9IJCwYsOPAEzJDNNR966JUK3hvMGPxyUxE+
         SQfcKRt1rZFqSk7JR2DlC3pwBkL95EyFfhq4MDuon+ej4xF6Te+QC267xxJJmoI4ENTl
         ZZxQ==
X-Gm-Message-State: AOJu0YwRgkSF7Q8jciQ9ihQCn9qmRu6FGfUTnEXficcHBY3VeMgsovyB
	AQFheOVpaRyenTUvYRYWc1pjMXjRnuvpkltdYWfYKfYqcIUZSRX1Y7NDyh3tzNVlx6J/EFA/jTR
	oXiiYpCZ1EMZQGBjLyKjWfbcIWy9MxPhrdisA/9bT
X-Gm-Gg: ASbGncsncvhHmLO8b567r/Ai9eQCMw1UHEeVsUW/0DT9XoA7CMHsVyZQfnusKvgMTa/
	iEaghiF/TDXR75GCo5QCVgeIgsnCDYZWFX1HzueKD07ZKBqNgCL7kN5htNrL8ynEiWIvij1Qjlj
	tsLh883vVKLAUPnHI0juCJVVoFNXt5TpRMqrRrJFPJ9A==
X-Google-Smtp-Source: AGHT+IGWIeV9qlCekPD5yvT3T7J12NSgNsep3S9VUDAzDmKLUwM3JtsT6ag92QX7EemHeWzXB4REymZEuWjnsHWsI2o=
X-Received: by 2002:ac8:5f53:0:b0:4a8:182f:3514 with SMTP id
 d75a77b69052e-4a976a204f4mr49474191cf.49.1751464806530; Wed, 02 Jul 2025
 07:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702110039.15038-1-jiayuan.chen@linux.dev> <c9c5d36bc516e70171d1bb1974806e16020fbff1@linux.dev>
In-Reply-To: <c9c5d36bc516e70171d1bb1974806e16020fbff1@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Jul 2025 06:59:55 -0700
X-Gm-Features: Ac12FXwp8XZXi4rEalR7Po7yvbkYy9PGyrgDLaG4STeExITm6ZjzUqu2xPuLOTk
Message-ID: <CANn89iJdGZq0HW3+uGLCMtekC7G5cPnHChCJFCUhvzuzPuhsrA@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: Correct signedness in skb remaining
 space calculation
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mrpre@163.com, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:42=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> July 2, 2025 at 19:00, "Jiayuan Chen" <jiayuan.chen@linux.dev> wrote:
>
>
> >
> > The calculation for the remaining space, 'copy =3D size_goal - skb->len=
',
> >
> > was prone to an integer promotion bug that prevented copy from ever bei=
ng
> >
> > negative.
> >
> > The variable types involved are:
> >
> > copy: ssize_t (long)
> >
> > size_goal: int
> >
> > skb->len: unsigned int
> >
> > Due to C's type promotion rules, the signed size_goal is converted to a=
n
> >
> > unsigned int to match skb->len before the subtraction. The result is an
> >
> > unsigned int.
> >
> > When this unsigned int result is then assigned to the s64 copy variable=
,
> >
> > it is zero-extended, preserving its non-negative value. Consequently,
> >
> > copy is always >=3D 0.
> >
>
> To better explain this problem, consider the following example:
> '''
> #include <sys/types.h>
> #include <stdio.h>
> int size_goal =3D 536;
> unsigned int skblen =3D 1131;
>
> void main() {
>         ssize_t copy =3D 0;
>         copy =3D size_goal - skblen;
>         printf("wrong: %zd\n", copy);
>
>         copy =3D size_goal - (ssize_t)skblen;
>         printf("correct: %zd\n", copy);
>         return;
> }
> '''
> Output:
> '''
> wrong: 4294966701
> correct: -595
> '''

Can you explain how one skb could have more bytes (skb->len) than size_goal=
 ?

If we are under this condition, we already have a prior bug ?

Please describe how you caught this issue.

