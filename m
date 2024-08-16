Return-Path: <netdev+bounces-119285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6CE9550E8
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D072843EC
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B061C3F25;
	Fri, 16 Aug 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofKZ0bde"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09A1C3F11
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833174; cv=none; b=rinNlNa0/sHXtvj3gheoOLzE5LuUKjv4eFiXkQmbLDX5ZambuD6/AThHLYY1C8xtx8kuQw4mplEYsUi9COI6TuGzOnDQW5wIS/lywCf6wydKJb7QNw6kpfxhzjI3tBTf8WGz1hLQk8ooznRnS7cdD8TFmZrf3+hwHf136mRRxLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833174; c=relaxed/simple;
	bh=UFlHCdDv+1gK+/Yn166EjWKCK2mmvNB8Unr7fnDOwBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LD5gh8eGjXvWVyt8xEnb6bcn/dTQl6tuXdr0g26HXHR6i7j+6NEQngfmncWp9mNOmhgNBdtio4Ew5ZfwG5plJJsrpQGk+S+pkc3FMwjZjmvoFRe+lHxyIFyEqfkw2VktqDmHv/jSvAIItLBSRxJJRviO2YoEzdYzbN809dlbLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofKZ0bde; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f6c136a947so1032992e0c.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723833172; x=1724437972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rjKqKUVGp8fdP/ihVTIvHa/NSn6CTLuRPoa9qMW33E=;
        b=ofKZ0bdehU0ZycCsCNYp97tmg9pUXwv3bUPsMD2LOND81wjIeqhMFp+T/ypk2Zk5oZ
         JG/Cc6YgrKmI5BiJ/GtFeHTbZ+YsNoXaqKxn6V7vT5drU2hWkEzD1pNND6jGvny5Mtsk
         tETFFQswmuihnZUig2fDnVvqV8V1C/hwzD35SMB/Y6x2DIorhpwC7fi69SaD9mqt06L1
         f+mr3aNPgKqzRQzPVxDhY9Q5S+jiNxMNWjV5AMZSApCMHv3o1MrSNNiUtpHxNcu8ut7c
         lvsYyPApTGbCthnF9/MlOdYt8l3rt7ShLIyD26iT6xqz8JsM7PbUrwgULCEk5BsYgYsV
         OsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833172; x=1724437972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rjKqKUVGp8fdP/ihVTIvHa/NSn6CTLuRPoa9qMW33E=;
        b=vIg2PQmlLXRJ4eXJxlAqyJd7ps3nGez/2YIxOHoeqex3OmgtNJEmruUd4VHTwGxoNu
         zptj5Q0+NhvcQ9p8slS6k2NQ/cqApGgpdv9tjUjjS1JVFKYs1Ygl14BvKD0if8+B9voc
         yofWWWgyrwWK37yq1UR4ClHyVCUiwXpnP0tUn8fMYNUkx03PH1O13RU7qZ7wyiWBN9Qe
         zIcjwNza2kd6gDIOJkILRugjLhnFmyVnIyCHIDg/hjR09q884netL/kZdKTMBKHS2ngF
         8bIqe7sUCqyQo+CKnLENYWPLTH5vH1VL7JNqoDRO0NVPz88M8sS5sIkREaDi70DULnZ1
         JUtA==
X-Forwarded-Encrypted: i=1; AJvYcCUEMdXP9pT4qo4XWpSAa3RdG5XvZyVdbiNT3D1zJTFLTpuyntXV313M+eNq3848qmUy9AkPr1VmTYZuahre6lrDIk/++J1k
X-Gm-Message-State: AOJu0Yzv4W2fvc3PW+exBH2O+s712hPLVIlcQBVhsNq6nxBbFlp+OYP8
	xMZV1xHzSaiZPNBtsxFzV86k9S1UXdTdyiWOFGc4rtKpKSWA6vNFzf8Gx6AuWi8CY3tP/3Ujfnd
	JtV4KWikSgR4DEezyNtilV/9UpkHbK3YVuNGbWDpL//RGHV7gSmM3
X-Google-Smtp-Source: AGHT+IE9y9Qwde/sAmECzbjTmj+QyKkGZLy3/r+3uNjFduuZ/tG4JaE9edLMsnU7TE0FhapB+DVwikJCehgoWuloqEc=
X-Received: by 2002:a05:6122:7cf:b0:4f5:2276:136d with SMTP id
 71dfb90a1353d-4fc6c5e6093mr4498545e0c.1.1723833171999; Fri, 16 Aug 2024
 11:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815214035.1145228-1-mrzhang97@gmail.com> <20240815214035.1145228-4-mrzhang97@gmail.com>
In-Reply-To: <20240815214035.1145228-4-mrzhang97@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 16 Aug 2024 14:32:35 -0400
Message-ID: <CADVnQy=URvcxoU70b0TMJ9gpYVWgKE_CNwQXrP9r2ZJ3EGWgfg@mail.gmail.com>
Subject: Re: [PATCH net v3 3/3] tcp_cubic: fix to use emulated Reno cwnd one
 RTT in the future
To: Mingrui Zhang <mrzhang97@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org, 
	Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:41=E2=80=AFPM Mingrui Zhang <mrzhang97@gmail.com>=
 wrote:
>
> The original code estimates RENO snd_cwnd using the estimated
> RENO snd_cwnd at the current time (i.e., tcp_cwnd).
>
> The patched code estimates RENO snd_cwnd using the estimated
> RENO snd_cwnd after one RTT (i.e., tcp_cwnd_next_rtt),
> because ca->cnt is used to increase snd_cwnd for the next RTT.
>
> Fixes: 89b3d9aaf467 ("[TCP] cubic: precompute constants")
> Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
> Signed-off-by: Lisong Xu <xu@unl.edu>
> ---
> v2->v3: Corrent the "Fixes:" footer content
> v1->v2: Separate patches
>
>  net/ipv4/tcp_cubic.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 7bc6db82de66..a1467f99a233 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -315,8 +315,11 @@ static inline void bictcp_update(struct bictcp *ca, =
u32 cwnd, u32 acked)
>                         ca->tcp_cwnd++;
>                 }
>
> -               if (ca->tcp_cwnd > cwnd) {      /* if bic is slower than =
tcp */
> -                       delta =3D ca->tcp_cwnd - cwnd;
> +               /* Reno cwnd one RTT in the future */
> +               u32 tcp_cwnd_next_rtt =3D ca->tcp_cwnd + (ca->ack_cnt + c=
wnd) / delta;
> +
> +               if (tcp_cwnd_next_rtt > cwnd) {  /* if bic is slower than=
 Reno */
> +                       delta =3D tcp_cwnd_next_rtt - cwnd;
>                         max_cnt =3D cwnd / delta;
>                         if (ca->cnt > max_cnt)
>                                 ca->cnt =3D max_cnt;
> --

I'm getting a compilation error with clang:

net/ipv4/tcp_cubic.c:322:7: error: mixing declarations and code
is incompatible with standards before C99
[-Werror,-Wdeclaration-after-statement]
    u32 tcp_cwnd_next_rtt =3D ca->tcp_cwnd + (ca->ack_cnt + cwnd) / delta;

Can you please try something like the following:

-               u32 scale =3D beta_scale;
+               u32 scale =3D beta_scale, tcp_cwnd_next_rtt;
...
+               tcp_cwnd_next_rtt =3D ca->tcp_cwnd + (ca->ack_cnt + cwnd) /=
 delta;

Thanks!
neal

