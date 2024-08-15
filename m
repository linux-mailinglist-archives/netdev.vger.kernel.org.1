Return-Path: <netdev+bounces-118869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F179953624
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7677B20F03
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7328119FA9D;
	Thu, 15 Aug 2024 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJH6v3f/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8561AC437
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733215; cv=none; b=T+gPsxcQO63HdbZWlrIfOU0cJjAS1GSFOWjHh5XjW5za1oboXtnADkDix90gawF8YKVkscxBHa6ObJvwlsyJ/GZTctDtE/kHomdfRDGrEt6tflrlZDEOtf27CRxyrrmWaWC0zFaadDwmLbAFAxy6V9o3TvkLod8vKPm+ZsypUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733215; c=relaxed/simple;
	bh=pnJpgohckSrsEOlgAlyXU7Z9yiTmkx2jJ9CyfBMcsVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vsvsjl+nXUTGE5up+gqLEgXMm6USwDbqvVS3rETmGgtmyn4ScWmhQ68uJOFvz/q+P+/8lhfK5Eg75rHKLeJk0y3cP+7i9jBtWMO9uKQPuUUjagQO4kQ0DyZBUiPpIZTd7WNlc4fOmnUy+RfjyO/wKGcuMf90EqAVmXbV7AZ+FtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJH6v3f/; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4929754aee9so287667137.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723733212; x=1724338012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7JC8W2JHCPXgYR+Bw6jZJ7bH3hdODhQovUmZlKATdc=;
        b=DJH6v3f/oZgZxTWQzwV8moYWqo9WQFV8VZX+m/UROOAOQJjJJidRhR8qtBxofxvzG6
         rDuA29KePQt9VeMhWjHRogCKHTb0PmCPA33ElCqsxT47a7my2JG+L1NNLe6YC9W1dHVb
         3mOPmPXhdmG9amL97zIw6D7hyjzJnOxcs8yhxilLWI+AvqLUmX1O9B018VwZWPqsjrru
         4cZWDOxLTX9+Y1FzZizZfaG53I/UauVJDNJWKWp4TRR24oabeRnA/eyLNO9ZB4yoqGjS
         i8oIOtrrA2bBBDFptNGLjcpK7YNgKLO89sAjYDMbqnqnmLoRiNc985vFGrPi8WbTbAze
         g3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723733212; x=1724338012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7JC8W2JHCPXgYR+Bw6jZJ7bH3hdODhQovUmZlKATdc=;
        b=W361ZKgyW2t2W0W+OAHowAWG13daFGUF1PZ/kyX7NzTfygx8Vv6PTwhMkq4ez8rC4F
         P0LKVAPEcPmGdONQQ3s0OnjXWcDkS87vgRu6+gRdmgTSlPEAzPYL/3iNydepMNzuC3wT
         sBZViorPgE7StJ7yapEJui8KVN6zxlvgAjnsCe4meJiYTk67RNkYpUBHLCBHEIYRgWYK
         LXm4eBM9R8/J+7mXOI3YEi/0GQh+JMf4cIST/AQYiF6zFpCe3vTJ9vq7+kR9Xz16SP9b
         nSIjVKh3HS98HykM4X10V4MCba0ENmjEvDaqMAEnhDhaNxdWIoX8iydfEY/iUJjU29jv
         RJsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7e+GWCSmVWMl96DzsT+XPw411dYY58QRwt/YyFzIIjFNPucf2j9Ppv/M9KXLvbdEUu0ZPgvK8rHmjJZ5eCbAEkCNJcyhd
X-Gm-Message-State: AOJu0YxV4uA8ZoMSidazUW5/WC6uf0Ui/HYZndZnx/YEymG9rM8Olmgz
	/UCa5SOzzAoTr8ljljwvU3J4KNrblhJwj2SAUxWnCTKbGlQBpSLfGLLA9XrmCKkSsuOUss7XoEH
	1MRilPfXkfUIRAaeK1U6RBLaORdM0I10fGOAj
X-Google-Smtp-Source: AGHT+IFQWS3T7S5BQqZ0aRDuc1AzNEE4ebBHy3Sd7a8Yn+FCpBwaFebeV5CDeov+3+XFP1dD8bm9Ff4fR8BvT9SM6iU=
X-Received: by 2002:a05:6102:5122:b0:493:b52f:ecb6 with SMTP id
 ada2fe7eead31-497799d5ab8mr23471137.20.1723733212305; Thu, 15 Aug 2024
 07:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815001718.2845791-1-mrzhang97@gmail.com> <20240815001718.2845791-2-mrzhang97@gmail.com>
In-Reply-To: <20240815001718.2845791-2-mrzhang97@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 15 Aug 2024 10:46:36 -0400
Message-ID: <CADVnQymaehUnVtqhraet3tryvMyJCbA1f7FCb+h4EbbdR+oOzw@mail.gmail.com>
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

Another note: please remove these commit message lines like this with
"Thanks" and your names, from each of the 3 commits.

Please run "git log" in your git Linux working directory to get a
sense of the conventions for Linux commit messages. :-)

Thanks!
neal


> Fixes: 91a4599c2ad8 ("tcp_cubic: fix to run bictcp_update() at least once=
 per RTT")
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

