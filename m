Return-Path: <netdev+bounces-184761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97359A97197
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7363BE335
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6C17DA66;
	Tue, 22 Apr 2025 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrsHrhB3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAC28EA53
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337023; cv=none; b=E3R1KdkzmkMWcvqFsX39szh5vLiIJZa4FTejXQ/eWBlmC52mSNuijoTtOpDTyNU1ivhV7f3NEcantUxsGWRhyqbNEza0lUfOM/VneAkjEm+TlZsO/Euj2YzHemqzAHA8D0QGc1eQz3NavdmqvKL5wdzDWhPm+DIvTeGpiHmS1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337023; c=relaxed/simple;
	bh=9a/te27GMRCbm35aeHTbXgTZJ8xRa/MxJVvZPTI76FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4S0IXoDkSS299XtQgAY50+TlQqkjzXf5EXtOQpzFUAkT/Z24rab5Uw5f/FkVZOt1xYSIVEfojpPTkufQUTDWVJE2iFuX4rsAwH6tgx0GZfcN784G1mnnLePQNnA+8dkdYLKo0q4g2YXvVMU39ibQdSCnk2KyrsBmMvNpdmgUfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrsHrhB3; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47666573242so395801cf.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745337020; x=1745941820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9WW/3aSy1uStjkHqGlcJMC5YK3g/j0A+LTP9BMPhwY=;
        b=RrsHrhB3RpIGWhvE0arw5XCfN5jpJCNI+V2AcpbwGU9ZXfZi0lmL9OhhsrO5fsG9W/
         aElA5oFYFRfjiuDc4rZareTtVOCecZurlPQenq/ccR8DRLwob7O/h1vN+HV1L7NuTAKw
         xmYSvKLSc+JEGWTl0wIpLP5JmLhlEUUiQ/LYb2q5AEKG0abBOTMpx5zlKN7AniRNY0Vm
         KGx9+1W8+XyQ7uqQ0scSYsoXiNkUUqcfywNdrPNuze0WSbw2Rdav+qH3gh+AYJxC7lIl
         YhrdfQEZ6S5FNOYeu0ZwRvRIPeqFyT3iDLHOIKxhJv9xrTcNECsQtzNj2FngoovJ5x0y
         ww/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337020; x=1745941820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9WW/3aSy1uStjkHqGlcJMC5YK3g/j0A+LTP9BMPhwY=;
        b=EXOFdqRbO2Yl0pI442ptkFrS7YG1tAriiaOx01j9agNAXMIHJTa02BA5fiv6JmZbFC
         EgC+4tgIdxNCRmn8oQSvwSGT2nogADymQiBAGSpnUac5Tzu0k3V2vrEq3wx06IYu+tKh
         Bhetg8sBn8pecNEazAnNFP1SnnY8aYxzsS+ooulike9HveAJRGb6EjBoQEV4p9qQyTu2
         I36Et5MSBk3c5c5GbxXLYebqVh1J5XPdssReH6ZeOxJ7GMHkhtdUIfUolHgEe2aOaa4c
         OrVju1XaCmpTMLper6br2uRtEeEzD1B2KRJpODwo0Dw5IwSy6Qvlp4JicZP7cg3LtyxM
         w1pw==
X-Gm-Message-State: AOJu0Yxs5AoFFxjDo4X961cOgG8NY4T7mbZd1Z/5kf/NovP7s9PSEdqe
	Xfx1LFYfJTShS1u7R5Q3qAx4mka8477vDHyyRQl4shWvRYWDvQy0/72c3XXGi66T35JcJBY8rLS
	u+QL0doYq2Sgwwr3FZO1o1n4ZDjvj9nnbqqhR
X-Gm-Gg: ASbGncttXB3JC29QaEvHAJhYcGFAj7bIVV7qE1QzD5tr3Rpp7m1v43wxpaJ4OFQGxg3
	Br49b0NLn9b+Y6u6xNJjRG1PmiD4t5b0IJHCnmwrmvbRFoFHm8tF4t5F6xPlF5/2cTdiCKMPJsJ
	5Rw5qz7I7D5j07TJqUkTTtjWNLQg/2a6n24bcOXvoVTY09DkNMoJO31o8=
X-Google-Smtp-Source: AGHT+IGFd5omKb+41D4OUGv/1BPoQexPE3dSdZ2XyNBGQvxopJI59M6W12wb16n5IMitxGYWUmCiKKTnXbAt0Vm/7/g=
X-Received: by 2002:ac8:5dce:0:b0:477:8577:1532 with SMTP id
 d75a77b69052e-47aeb26e7admr16602861cf.28.1745337019814; Tue, 22 Apr 2025
 08:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416090836.7656-1-jgh@exim.org> <20250416091538.7902-1-jgh@exim.org>
In-Reply-To: <20250416091538.7902-1-jgh@exim.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 22 Apr 2025 11:50:03 -0400
X-Gm-Features: ATxdqUGoIsQajo4ACBF6YRc6O94FXkESO4Bz2aVBp5s34atuP0ODoNnHuG_hXiw
Message-ID: <CADVnQym3FmsuCOZdjhf+G42xryOmGLT23gBiHdam2fDcMv7TFg@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] TCP: pass accepted-TFO indication through getsockopt
To: Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 5:15=E2=80=AFAM Jeremy Harris <jgh@exim.org> wrote:
>
> Signed-off-by: Jeremy Harris <jgh@exim.org>

Regarding the proposed commit title:

  TCP: pass accepted-TFO indication through getsockopt

Please use something more like:

  tcp: fastopen: pass TFO child indication through getsockopt

> ---
>  include/uapi/linux/tcp.h | 1 +
>  net/ipv4/tcp.c           | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index dc8fdc80e16b..ae8c5a8af0e5 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -184,6 +184,7 @@ enum tcp_fastopen_client_fail {
>  #define TCPI_OPT_ECN_SEEN      16 /* we received at least one packet wit=
h ECT */
>  #define TCPI_OPT_SYN_DATA      32 /* SYN-ACK acked data in SYN sent or r=
cvd */
>  #define TCPI_OPT_USEC_TS       64 /* usec timestamps */
> +#define TCPI_OPT_TFO_SEEN      128 /* we accepted a Fast Open option on =
SYN */

IMHO this bit name is slightly misleading, and does not match the comment.

Sometimes when a SYN is received with a TFO option the server will
fail to create a child because the TFO cookie is incorrect. In such a
case, a TFO option is "seen", but TFO is not *used* because the TFO
cookie is incorrect; so this "TFO_SEEN" bit would be 0 even though a
TFO option was "seen". IMHO that is confusing/misleading.

When this bit is set, we know not only that the "Received SYN includes
Fast Open option" (comment from the previous patch), but we also know
that the TFO cookie was correct and a child socket was created.

So I would suggest a more specific bit name, something like:

+#define TCPI_OPT_TFO_CHILD      128 /* child from a Fast Open option on SY=
N */

+       if (tp->syn_fastopen_child)
+               info->tcpi_options |=3D TCPI_OPT_TFO_CHILD;

thanks,
neal

