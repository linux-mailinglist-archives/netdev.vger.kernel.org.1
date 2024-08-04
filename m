Return-Path: <netdev+bounces-115549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099D0946FB1
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198681C20D15
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702F756766;
	Sun,  4 Aug 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlVMnM7n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B8A47F7A;
	Sun,  4 Aug 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722786613; cv=none; b=NVZeQM2O7P9iyjiw4YqrwQty+rb5GGLo5nRYRxrQOrk3tBuXrld1vA8HDntZy+mG6a3/orG5d1A1kG1MuEqrjggCkeRZZN/tGd1hEdKzPYn9zaH2X/pMCQbeHlHe8bccttqxRSk2DV5Tr59c7gbyU5w1in357q0qwndR+/q7zwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722786613; c=relaxed/simple;
	bh=ewN/4BQyN/q12i1ZxoQWqI9kkVq5/gGBTwPLFXr4ODA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiJqKG3N08PZ/66tubrLOgTSQ15sngA+7oC4bqOJqagzBIfuoNVz0iBD1f4iwnF4xsDKqNm6EF621iHAcluZBs6h/0lGNjNmvD7SuZy71dZFnhUX2Ln3mgtdLtqqCM1jjOdDHbSLnQoYv1ge1d52nL3+EEzBvxZS6kwCqNATrVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlVMnM7n; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f035ae0fd1so110542021fa.2;
        Sun, 04 Aug 2024 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722786610; x=1723391410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewN/4BQyN/q12i1ZxoQWqI9kkVq5/gGBTwPLFXr4ODA=;
        b=RlVMnM7n+yV7k/WZ0HikfGhjyHWZ9eciDTW7yEnCpcMCcOCxmLAf9EYnDan0v2agqP
         4VLAgsAgL3K1NPnJIs6N6Gfe2IgCe/ie4fUKKHr8t8US/+seZPfXyrxd9jV47KexNiqt
         7UjWa1UKubnbPqBgnRg3bXuMMFtj8/29hTu86K+DsEW8GYUtyxYZr9UsUYk4RtBuwGaR
         JhJ/9mFY0upZQ1P0A3XRs6UY98VHh54I13w5myk+vmx0sypO/6pWevvyS0h6PdhtCVkL
         a+LT+5oCCqFeowyCklmxEn5LsSe9kUYIUV62xH5W2oaJeLAywvFy3SuFH2wCnM9KH7UP
         q6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722786610; x=1723391410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewN/4BQyN/q12i1ZxoQWqI9kkVq5/gGBTwPLFXr4ODA=;
        b=aor9/2d3JAVR0Rq+t/cbxO4lMpBQNDsmqavOn405F/+61wy2S7b4rDGwjTLkIEOTzX
         v0fqJmdbUoTSBWWQbZf1nrxV0GiP7lSYdNdg9cAZqdAuynRV5ThVbSZRKvuLBdYoozeE
         yFxx12UBmJ0NHHHkZnzrtEngY9pG6gCeMRHaKmIt65kJKEK/jKTnLhnx4VYi+HXqUvHc
         XZNVY9hB9z/uH5ezUx3WRPxDLj9M55Axg0kblBIsqcMmKDlriWfLjkIGW/C8IwvPCUwO
         Kmwp1Aixe6/6p417Xm1PwcFNoJ1LOSX1zSvnXfC4LqPt9ot7cK/QY0k3mS2NQZDi3Cpw
         xQuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGXVAbnCHRhhbxiu2FD9U+lVHfsMS2t1wGTfzRJRgHQJYbVt6ClGc4c2tCBOADvypjpSn3tAoEX+jNllrAbfyUPxFmgAbrviPBOzOi81o50MLU8o7u/QPvS41hlVxz3dYTfzpb
X-Gm-Message-State: AOJu0YwDnvIThSHAn4+z4KvFeuUXptDtX3pLxca4n2OGngZt34X/whrT
	hzO9lPR8IOdg4igiVDQCf2QQjqOOqVF7A9L/le+FwhDV7itgtEY8uDpOdjPQd2zxoaOJ4klnBpL
	EAPPz8+JHba1ahhnMAa/n3g/06aM=
X-Google-Smtp-Source: AGHT+IGa3ZMB+LwQ5uYPjMAPVdVAiDzLrWRsNejQAMMVgwaXJSdiCmj9gk+9luxJO5bYY2jkV0MIeBO8cbsvW8E9S7M=
X-Received: by 2002:a2e:8502:0:b0:2ef:2ee3:6e75 with SMTP id
 38308e7fff4ca-2f15aa8778emr68882731fa.17.1722786609701; Sun, 04 Aug 2024
 08:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125856.7321-1-ubizjak@gmail.com> <20240731093516.GR1967603@kernel.org>
 <CAFULd4aye+mGTV1CJp5Coq0Qr2DvwOezpd5-hxWbF4-xR5aj_Q@mail.gmail.com> <20240731181155.78219465@kernel.org>
In-Reply-To: <20240731181155.78219465@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 4 Aug 2024 17:49:58 +0200
Message-ID: <CAFULd4YZU2N0ExERf2eb+ELZyWHxAFAG3bRixjeFxKKeb8Te=Q@mail.gmail.com>
Subject: Re: [PATCH] net/chelsio/libcxgb: Add __percpu annotations to libcxgb_ppm.c
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 3:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 31 Jul 2024 12:06:18 +0200 Uros Bizjak wrote:
> > > Let's keep to less than 80 columns wide, as is still preferred for
> > > Networking code. Perhaps in this case:
> > >
> > > static struct cxgbi_ppm_pool __percpu *
> > > ppm_alloc_cpu_pool(unsigned int *total, unsigned int *pcpu_ppmax)
> >
> > Hm, the original is exactly what sparse dumped, IMO code dumps should
> > be left as they were dumped.
>
> Unclear to me what you mean by "dumped" here.
> Please follow Simon's advice.

Oh, sorry, I totally misunderstood Simon's email. I have sent v2 that
includes requested change.

Thanks,
Uros.

