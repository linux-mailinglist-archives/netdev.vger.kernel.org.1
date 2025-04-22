Return-Path: <netdev+bounces-184757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA67A9716E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B141774E9
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C770F28F512;
	Tue, 22 Apr 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxZ5CkgL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CB14883F
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336636; cv=none; b=Bw/jyt3UxcCaPGKFeaQdQr2RkxtU38qxGpf6WRuP5RC1R2dpm81bHw+osIDb452WOHXvx6+q2G+4JAzdzxFjADRsQRYYupikGfGEbKENRywSl/ss4yONYkWaiDsoaxucd+eR9Gy5j5vg1prAJuzc/DZ/vpi/Xk+h3aaVOivtyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336636; c=relaxed/simple;
	bh=40BL3YgoXiYEQLz6gZBGoXlOBg2djtVYXl4ixQlu2/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlOFHh0+WCzPYX912O0PgAs2MP9FXtnvhr20lO4x5QDLG5pB7J+w5EOh7XgAHDuwGQuj9rJgMit2v40SRqimR+gnP4y3+CHbwgIZ8FTVa4/D9X4h8Zhv14ap56e5/tmR1kC0dZiRDWChMAkbURIyFS5p/c6hNX6KYY0WcT8H7II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxZ5CkgL; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47666573242so391981cf.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 08:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745336634; x=1745941434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWlbXElNC79bT9XPVMNnoeBTmrZchXkZMkxVRj1tdo8=;
        b=QxZ5CkgLgAwYqzxLmuXyvEK1KB3MDdp9kb8u/+Qg0lgLuBlNTdGNrIBdVel3eua37q
         pDAXn4835WJ6UHx6NsYMrRTfq5I7ZO/Ipr8/fO+yUuTqKsM1SZtzqPfrNzft9gw/GiJ1
         ajtLLpnhFPX8qVK3X8EKksGtbqrNM0Trw3e7FGRZ2loO7cw5QVQaTbuOXRcym5nvOoBV
         /SmESkKJmOyMepH0IhopvkkzJRxBrsVgUsAjkW5xA6Y1KAd5lfGPaL/eeih15Z/FHwqu
         +FfYHgdDLcMAZEKC0NCh6GPynRg0T2Nj9khG453H4XxIuMwyvJrLOOMHWaiDkYbqvqFN
         glGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745336634; x=1745941434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWlbXElNC79bT9XPVMNnoeBTmrZchXkZMkxVRj1tdo8=;
        b=uaVinoZnUWSHF63nLjjajuyRxRSpHLB9plQMCwZYjAYcd1qmAc56/k6PEy6UdFe+9x
         GKAvrM62cmu6y1Ec0bwpbzB0xVJF0RTAuJ/Ue8+UDGqlxTTvooBNb/bvESg7iRwM9cEV
         GgBysfPj4PTuxHD1tEfLc5mG6oIYNlkg3vpD/3zfcZcQblYZegcwiVhyWUPI+z+3/Tq1
         WPgN+V1FMtJVZrGPVUDdg2e+vpDCaDieZBrEHT77leLS3w4dHoFNdljpW4U9YL7B3rOJ
         YCqzTe+rgnYNb4arBeldsQ0i0ZQbNQQbC0rDy9C+i9OwdbNMgZWtYvP6SIohplixXr3P
         jbCQ==
X-Gm-Message-State: AOJu0YxO70/5aiYcjCO7D+ZfeZKCs81S118yfXE5VZ71I6iGcm3it1nf
	CRReZWaPsxG4DfqDGR04uEXIMgKu+hNiYcph7GIA/gklpFhcGQNK2AP6savqXRc+d6MjFNvxOt2
	82N85SwKEdfNYOug9irEo/q/nnZTw4JjMtXb1
X-Gm-Gg: ASbGnctQB6QCyMBXPI230xwG6USiJ7k4bzL+LpIb0QNMl7RXZc1T0Eh7IVQWWattdFd
	SUsFM/7Z8L9Nsm6/ypGophSl6rvHDRlDN3+KoQqm6w+1VHxj9xD+fnX8Tssa/RYTwd9m1DISQkc
	+kKMgovgj+anLMpBMRQpd7Pu9r7h0LLc6Goru38Rl/zbosO9XbNERrF2g=
X-Google-Smtp-Source: AGHT+IEbKOKHHQnwcpr21e74IGc6Qc/LFbAN4nGKw98YVZGuq3yJ9P0kUAeex8jsUg3eaBhREScEHWyZp/sbZIBbMes=
X-Received: by 2002:a05:622a:19a5:b0:471:eab0:ef21 with SMTP id
 d75a77b69052e-47aecc69670mr17974951cf.13.1745336633656; Tue, 22 Apr 2025
 08:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416090836.7656-1-jgh@exim.org> <20250416091513.7875-1-jgh@exim.org>
In-Reply-To: <20250416091513.7875-1-jgh@exim.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 22 Apr 2025 11:43:37 -0400
X-Gm-Features: ATxdqUEuZEFn6i-mH810bxnoyFMzJNJZZAHZapYh2KMCNZ7w0Q7FDiT4GkgS5Ls
Message-ID: <CADVnQyn7i_ZHwZNm5gxwHuAcSAF9NdYZyNZyQ_2abr79oytT4g@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] TCP: note received valid-cookie Fast Open option
To: Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 5:15=E2=80=AFAM Jeremy Harris <jgh@exim.org> wrote:
>
> Signed-off-by: Jeremy Harris <jgh@exim.org>

The suggested commit title is:

  TCP: note received valid-cookie Fast Open option

The "TCP:" prefix is not the typical prefix for Linux TCP changes. A
"tcp:"  is much more common.

Please follow the convention that we try to adhere to for TCP TFO
changes by using something like:

  tcp: fastopen: note received valid-cookie Fast Open option

> ---
>  include/linux/tcp.h     | 3 ++-
>  net/ipv4/tcp_fastopen.c | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 1669d95bb0f9..a96c38574bce 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -385,7 +385,8 @@ struct tcp_sock {
>                 syn_fastopen:1, /* SYN includes Fast Open option */
>                 syn_fastopen_exp:1,/* SYN includes Fast Open exp. option =
*/
>                 syn_fastopen_ch:1, /* Active TFO re-enabling probe */
> -               syn_data_acked:1;/* data in SYN is acked by SYN-ACK */
> +               syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
> +               syn_fastopen_in:1; /* Received SYN includes Fast Open opt=
ion */

IMHO this field name and comment are slightly misleading.

Sometimes when a SYN is received with a TFO option the server will
fail to create a child because the TFO cookie is incorrect.

When this bit is set, we know not only that the "Received SYN includes
Fast Open option", but we also know that the TFO cookie was correct
and a child socket was created.

So I would suggest a more specific comment and field name, like:

  syn_fastopen_child:1; /* created TFO passive child socket */

thanks,
neal

