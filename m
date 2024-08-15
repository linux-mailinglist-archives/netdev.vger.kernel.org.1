Return-Path: <netdev+bounces-118867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627CB95360E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969D81C21E9A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CBD1AAE3B;
	Thu, 15 Aug 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plSphVst"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D121AAE38
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733026; cv=none; b=TG+wLW2el8WsdWJ773EzqjQoWAyrBysLD1OghLUuGkG/hfqAIFl9QDoM7osd6kv27TYGucFoylIJvOhV0EMsAqU2DXTMsRFplrk78f6bJwWiuYQXG6UFsjrfCKF51c+8Y1y7L4Am9+8rCAQqxz1w4pmXvplCkWtBvrNggzSYfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733026; c=relaxed/simple;
	bh=gY4ozU6gyhqMmNCsCqp211fP1r7Rlf0AVXkjTY4l5oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+rnqVM8rHMw4WkK3CWz+efybwcjv/ZhOiUA2Sj1tW5ak5Gut1VNCZQKB2mgTngAYoODCbUvBILMjI+eoYuZiXcGbtCVl0Qu+NStYJsPtgdj+9AdXqQe76VpT1jpUhV4Ge9gXQipKlknfUuy/4Qsb3A1uoFhhOufHsaMjJLqwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=plSphVst; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4928d2f45e2so377019137.0
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723733023; x=1724337823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwBkKvkjuMTQTL16fVdJGUHMEbhdM1JaYDW1ua3VpKQ=;
        b=plSphVstw1DaQ1GoIobJqvu4z1pkp9eAqaiFthQoQn5zsryxbJLAiGFy+U7+eAwCXh
         ikhyJmg4rySjGsiLYlFoIugyeu/0ZUttPeN61NDjiZW0g7WgxH7dptx/iVSdtlaogMmY
         c3dvH7wNl6xGwBGp3lqlSGUzmHelmT5Jt/yERMXRPTJPHks51nMtW2iRd+UBkvTconyX
         IwHtUMM2/gsyHXEpNNN36yr5LAwhjGkndl22lYcbftw8mpWKsVZgeusqH8bmd1zmUllW
         sGfB5oaEdbeoc2xwrnBLdSoYwlfx26yxO51QvI3nHQw9j2PasuTukrZOxYv9x8Ce0LKb
         07ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723733023; x=1724337823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwBkKvkjuMTQTL16fVdJGUHMEbhdM1JaYDW1ua3VpKQ=;
        b=QFLyJAObCG0YElcQyzOumvTLGXtNg01ez/tm8il386wwdWcB/c3E4gR1o4PPrMz+Ya
         IGaZNSuBTpC98M1aq70SiTEoTaUw71+t1pfDY19Awqh7F5tudRVk7wdp19uIhH+FxPxg
         tjQNpShJTHq5iYdZ0otlaDnzKk4gJio0sIfyZ+ELRNuY3q6NlDms3dGdP19ZthSKJlYz
         r4QTfESo4B6T6xyknKOPkBV8EXHIqw5pCTJZHeTzcWFPeOBORoeXD8iM7ARVi1AZC7LX
         0QyBJgqaHsd+QU4D+0xwdlnYksWjmvamRrHoepHVQefc5CzZyqyUDCWg70iU2fwaSJwt
         /MPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpdvcF2oGopxUYAO+lQsNSHEqrHJWZyiAnBguGwdIeHepOaPXy7T2C25wc11Ah2vx/vuQ19MhirLA5vigC1Ky2ul5SEZW0
X-Gm-Message-State: AOJu0YyRLUzxUH7FUfFedKD6Lnxn+3UDQ4amEY8CHw/K7/ycjbPpMHYu
	NuKFXZ3HGOHJUdO2FAfWfKTWUkOH02NFXcGX2M2zHGBY+zOVFUNhZEg5BguD6irpZ0lLKVfJt/c
	J1i/+pa1VBXVdXtsecq+QqSEm/iWAc/GWgMa+
X-Google-Smtp-Source: AGHT+IEN5VFP6U/VmxETVwcEZttUPnQRikGz4dY+s3IN90ckwUwOan/QeUgeiV/MFmQeQHIsMn+17C02oD+2gBv9xMg=
X-Received: by 2002:a05:6102:509e:b0:492:aaae:835d with SMTP id
 ada2fe7eead31-4977962ac53mr74477137.0.1723733023019; Thu, 15 Aug 2024
 07:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815001718.2845791-1-mrzhang97@gmail.com> <20240815001718.2845791-2-mrzhang97@gmail.com>
In-Reply-To: <20240815001718.2845791-2-mrzhang97@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 15 Aug 2024 10:43:23 -0400
Message-ID: <CADVnQykHS1uPT1Wa4WjOdnJ2=bQh1ZkQUBK2GNXGwcg5u5SC3g@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] tcp_cubic: fix to run bictcp_update() at least
 once per RTT
To: Mingrui Zhang <mrzhang97@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org, 
	Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:19=E2=80=AFPM Mingrui Zhang <mrzhang97@gmail.com>=
 wrote:
>
> The original code bypasses bictcp_update() under certain conditions
> to reduce the CPU overhead. Intuitively, when last_cwnd=3D=3Dcwnd,
> bictcp_update() is executed 32 times per second. As a result,
> it is possible that bictcp_update() is not executed for several
> RTTs when RTT is short (specifically < 1/32 second =3D 31 ms and
> last_cwnd=3D=3Dcwnd which may happen in small-BDP networks),
> thus leading to low throughput in these RTTs.
>
> The patched code executes bictcp_update() 32 times per second
> if RTT > 31 ms or every RTT if RTT < 31 ms, when last_cwnd=3D=3Dcwnd.
>
> Thanks
> Mingrui, and Lisong
>
> Fixes: 91a4599c2ad8 ("tcp_cubic: fix to run bictcp_update() at least once=
 per RTT")

The Fixes: footer is not for restating the commit title in your new
patch. Instead, it should list the SHA1 and first commit message line
from the old commit (potentially years ago) that has buggy behavior
that you are fixing. That way the Linux maintainers know which Linux
releases have the bug, and they know how far back in release history
the fix should be applied, when backporting fixes to stable releases.

More information:
 https://www.kernel.org/doc/html/v6.10/process/submitting-patches.html#usin=
g-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Please update the Fixes footers in the three commits and repost. :-)

Thanks!
neal


> Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
> Signed-off-by: Lisong Xu <xu@unl.edu>
>
> ---
>  net/ipv4/tcp_cubic.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 5dbed91c6178..11bad5317a8f 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -218,8 +218,12 @@ static inline void bictcp_update(struct bictcp *ca, =
u32 cwnd, u32 acked)
>
>         ca->ack_cnt +=3D acked;   /* count the number of ACKed packets */
>
> +       /* Update 32 times per second if RTT > 1/32 second,
> +        *        every RTT if RTT < 1/32 second
> +        *        even when last_cwnd =3D=3D cwnd
> +        */
>         if (ca->last_cwnd =3D=3D cwnd &&
> -           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
> +           (s32)(tcp_jiffies32 - ca->last_time) <=3D min(HZ / 32, usecs_=
to_jiffies(ca->delay_min)))
>                 return;
>
>         /* The CUBIC function can update ca->cnt at most once per jiffy.
> --
> 2.34.1
>

