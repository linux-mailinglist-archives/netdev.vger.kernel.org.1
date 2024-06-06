Return-Path: <netdev+bounces-101475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 137F38FF076
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8161F24F12
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF04A1993A6;
	Thu,  6 Jun 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6r9IXTT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD9196D99
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686891; cv=none; b=p9sCLRSr9kbMKAzaysP6RgvNFwHL02sPKqrksOgcqRWkOWyzuoLPDCjCOXAQN/ANX97frR7g8NPQNeXqJGhOTPSLwspayJ2I+sQka9QkjQgIHSiJ/8jKVLLj97jdakdOLnW+XeuQ5n0nCaFitoxNeRjvHFWbNxjLB+5yq8lNdw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686891; c=relaxed/simple;
	bh=ufsnf8qAsQLhpqocTeNN6vbzvOF6eXbPUNS12tJ8B4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKetuzBAyVMAl0OANtMY+KEEzWdCeFQ+yPARrmSXA2voPcBPbH236Vz3RplyJ0S93jYn5WvX0OOIlSVVJBkt/VfahXlpU2+SPFAo7nNdlg0V3jFzlAuUQFNRH5I357tVJTotL5Rcx0uIDwOUKEsOrLicGLLqOomuJTjlLQmQdzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6r9IXTT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso21924a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717686888; x=1718291688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH2xsAZtA2NnS0XTLgJHaGFNXTqmMGd2qF0f/Y95tfs=;
        b=P6r9IXTTBtEqKP27IajhByquJr0pokodZiSb2bvU2JaLStjjRTd37bRtfOAiVVJYzW
         EOCt1uF4snqY3x8bLRktLvscJmZI/avJMOHGDTcPkrhqTEm1yyf3JZoGi/xYByG5u/xV
         qRnBn61r3w8giQcnIflOhKfQa9N2p2adqH3Dg19xSgOgXuIAMT9tHbqbSccdjSzr0R8s
         mYkCDTmOWF5odtho4gWoFEx3iKmSh00B2QUj0s/ERUqq4nQM0FIjC35NDBRzaeZNR9KN
         Vfkb/XgkQHJyVX9YXcX22KY5tlcKKxeyBsnsH0ip7gQbJG1rDuSaze4fEsXvYGYTZ7z3
         MZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717686888; x=1718291688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gH2xsAZtA2NnS0XTLgJHaGFNXTqmMGd2qF0f/Y95tfs=;
        b=WVqQWEFXhqdZJu6bSjeK22nG1233GL/kphJeRLBKfzwRD1sRh686EPSsG+GPz4kXqg
         0FHGXpkIjbSTgnpnnXb0sDMHTZ8iotxXvhJCx3DIEfkPgzJhFPxevbE6rdY1PCFNxyU/
         bK4PO0ntx5bNktQNgRgygL1xBnuTbKc/a2m7bMoHi0WSV010GJ8uy5BOwyk3TfnrfE/i
         hRTn4/Hfn57eEra/4g4IhiHc99HouAlYDXo36600yoZul5iZnSSQ17PYTkYCGLCN8srV
         DnDR6JtHMHC8zG3Dj61QKOvuyGiUFOFgkHVDdyUbWlVT3fpjMg6PXCCPwdzBQ8Fniu05
         d+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCViFyNQd952RBlSOx6S70baGZ1vfxTx3L/aihOuRlp2zddJ2rYggLh2MfOxklpufZW9KiP3x2/XIPe49SMI2bBm3tbe+a3o
X-Gm-Message-State: AOJu0YzazYCKFwexqnVGeOQLA0ul9bQz9lKTlX0bcLVGe8cTyoAtREQW
	awm2SUw8GxpU/RJYaa/6t91Iqj5+WroH4BR8yuZRIt6nNMIY7FNnqnZwicjXOQxf/+3DYfKvcWS
	ZPWoljq14WP7CoV4urJ3p+R1tngXzz36sLLP+
X-Google-Smtp-Source: AGHT+IHi7KgP81NZeH5O2mfF3aev/dSte9EE35/js81GU5i2aK8I+wHtLOMSTKXSxw5ebXHcnN1szEcA3rZvqgAX/KQ=
X-Received: by 2002:a05:6402:1caa:b0:576:b1a9:2960 with SMTP id
 4fb4d7f45d1cf-57aad16b967mr189414a12.5.1717686888119; Thu, 06 Jun 2024
 08:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606150307.78648-1-kerneljasonxing@gmail.com> <20240606150307.78648-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240606150307.78648-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jun 2024 17:14:33 +0200
Message-ID: <CANn89iLe12LJrhsYB6sQ4m90HPeLL=H97Ju2nm+HzUmMqk+yVQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: fix showing wrong rtomin in snmp file
 when using route option
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> TCP_MIB_RTOMIN implemented in tcp mib definitions is always 200, which
> is true if without any method to tune rto min. In 2007, we got a way to
> tune it globaly when setting rto_min route option, but TCP_MIB_RTOMIN
> in /proc/net/snmp still shows the same, namely, 200.
>
> As RFC 1213 said:
>   "tcpRtoMin
>    ...
>    The minimum value permitted by a TCP implementation for the
>    retransmission timeout, measured in milliseconds."
>
> Since the lower bound of rto can be changed, we should accordingly
> adjust the output of /proc/net/snmp.
>
> Fixes: 05bb1fad1cde ("[TCP]: Allow minimum RTO to be configurable via rou=
ting metrics.")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/tcp.h  | 2 ++
>  net/ipv4/metrics.c | 4 ++++
>  net/ipv4/proc.c    | 3 +++
>  3 files changed, 9 insertions(+)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index a70fc39090fe..a111a5d151b7 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -260,6 +260,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
>  extern int sysctl_tcp_max_orphans;
>  extern long sysctl_tcp_mem[3];
>
> +extern unsigned int tcp_rtax_rtomin;
> +
>  #define TCP_RACK_LOSS_DETECTION  0x1 /* Use RACK to detect losses */
>  #define TCP_RACK_STATIC_REO_WND  0x2 /* Use static RACK reo wnd */
>  #define TCP_RACK_NO_DUPTHRESH    0x4 /* Do not use DUPACK threshold in R=
ACK */
> diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> index 8ddac1f595ed..61ca949b8281 100644
> --- a/net/ipv4/metrics.c
> +++ b/net/ipv4/metrics.c
> @@ -7,6 +7,8 @@
>  #include <net/net_namespace.h>
>  #include <net/tcp.h>
>
> +unsigned int tcp_rtax_rtomin __read_mostly;
> +
>  static int ip_metrics_convert(struct nlattr *fc_mx,
>                               int fc_mx_len, u32 *metrics,
>                               struct netlink_ext_ack *extack)
> @@ -60,6 +62,8 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
>         if (ecn_ca)
>                 metrics[RTAX_FEATURES - 1] |=3D DST_FEATURE_ECN_CA;
>
> +       tcp_rtax_rtomin =3D metrics[RTAX_RTO_MIN - 1];
> +
>         return 0;
>  }
>
> diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> index 6c4664c681ca..ce387081a3c9 100644
> --- a/net/ipv4/proc.c
> +++ b/net/ipv4/proc.c
> @@ -428,6 +428,9 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq=
, void *v)
>                 /* MaxConn field is signed, RFC 2012 */
>                 if (snmp4_tcp_list[i].entry =3D=3D TCP_MIB_MAXCONN)
>                         seq_printf(seq, " %ld", buff[i]);
> +               else if (snmp4_tcp_list[i].entry =3D=3D TCP_MIB_RTOMTIN)
> +                       seq_printf(seq, " %lu",
> +                                  tcp_rtax_rtomin ? tcp_rtax_rtomin : bu=
ff[i]);
>                 else
>                         seq_printf(seq, " %lu", buff[i]);
>         }
> --
> 2.37.3
>

I do not think we can accept this patch.

1) You might have missed that we have multiple network namespaces..

2) You might have missed that we can have thousands of routes, with
different metrics.

I would leave /proc/net/snmp as it is, because no value can possibly be rig=
ht.

