Return-Path: <netdev+bounces-95258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68198C1C4E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 04:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBEC1C20EF7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443BF13B797;
	Fri, 10 May 2024 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3eqUzO0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014229CE1
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715306947; cv=none; b=UFfwh7P6P9IDZuXh9pkyzp/Ca7HAMYPwMUuAGjIAEJACCmrRAfmD46YeTK/XGHzL0A8cHrZMX5ORbbzeV+foDB+qIqDl+NYYOY7CJKfZ7NMg03zKGfwOM4o401KFeWFBl/bk1Y8NlUvj6UeZjrZpru+Ue6UKDIk+NQ1L7+hzFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715306947; c=relaxed/simple;
	bh=dKV4PDfvc8XgAh57/s6gitanI7APpwIPoNQYQtepti4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPqo599zjK2lvsrJjmNaGghhMmMShCjN3j5m9ULt3gBMIjNApO7Lud15tWgrG03uOFYYC6938SBdGc2dN2QEdx4kfGLd7MbjUosHNrJd+sJdPqwAhhKxPXTHRnYiPVMB5aeCbrQT6UmHhmqbdQL1bXTIyf3Bfk7U3CxpdXQGww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3eqUzO0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59c0a6415fso423398466b.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 19:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715306944; x=1715911744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OiBicesxlqr532YyRF28eg+ySoA/LIj8lKMoYZw3to=;
        b=b3eqUzO0WCs3uXI4F2jZuqOqU5H6uJKRaBBecTNDBe0Q720CVgmBw8FPz/aQ7q1lFO
         Y29G135Mku1a/lDIeqnWII04JZuAP1ze9L2FPfmY6FXCqL9cZJP4suCqE8FrzUYmsmyp
         zQHNn63X67Z4nYWVWSTTcaCaLOQGl7Zr9UOSAkX5MPKij8uvxfFWzVbBXXUkwnuunajm
         0rrJmzkKpTDub2imyciJQOJW9NjRbyh3++WGq4dM67u0bN9RrPNy29UyFSLtRkKwIg5l
         2aFX3cdej/xs+w7UomDT2KWP+BUKQTqPd2rfHEKkTgNsZaAiMD2U4JK4F/olg0tlVeyS
         mF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715306944; x=1715911744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OiBicesxlqr532YyRF28eg+ySoA/LIj8lKMoYZw3to=;
        b=rVEUxKrKOaJerrZWukGD6XAFGl6dolsEi2AEB3RTDU7cm+CWoP7WXYgoFgenD+CFWh
         s5tBec83ndB0QTc3vaFGvYXwjHiAWwVv5UHhI9hynMT+hSxiPsThyYQWyV8TEsJre919
         x1zn44qUjob382fDlA+JE0TSbBIata2wqUkwwSSMkeSX+sa1o60PGao2hdtD3L6pGo4o
         RXtt5VPBkzCab7pYqlsY+XUXqcq0a2edh2WUe3PsJP9blLEMfDFIZx4+ILDIvtKSZnK5
         PMZQsjydv+6tC+kMAOBwOagu/4lja6srM7QJQvynRMQ4dm8kXkjuHt4K/GAmxVNmcIz+
         ulrg==
X-Gm-Message-State: AOJu0YxCHUmftVklSKDasaftqYk/1dcK535QJUROSR3vk0vfzMmNau7S
	fSLYzeGj060loCu7YCduldhvy4CMdjuD/ZZwsWMz8ox8THFNOG9w8MHx9cQT5SiD04KCDBCEEmy
	LA5gc2AkPl6vNzFSdLzT20SoFQIM=
X-Google-Smtp-Source: AGHT+IGLjJKkEYscJ7V8FBusWKqm9MWI2dZ17l5e9lHmKxr5vhSBKLCWgrCU6aEhE8Du2/v8JeNt+QIiLnxQR9qGMss=
X-Received: by 2002:a17:906:3012:b0:a59:a0c1:b217 with SMTP id
 a640c23a62f3a-a5a2d5ca7c8mr81798366b.46.1715306943706; Thu, 09 May 2024
 19:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509131306.92931-1-kerneljasonxing@gmail.com> <20240509131306.92931-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240509131306.92931-3-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 10 May 2024 10:08:26 +0800
Message-ID: <CAL+tcoBDWzecSzKXEYG_teg2+8SDDquTagUO8QBYOh8NHW345Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] tcp: fully support sk reset reason in tcp_ack()
To: edumazet@google.com, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 9:13=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Based on the existing skb drop reason, updating the rstreason map can
> help us finish the rstreason job in this function.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/rstreason.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> index f87814a60205..a32b0fa17de2 100644
> --- a/include/net/rstreason.h
> +++ b/include/net/rstreason.h
> @@ -10,6 +10,8 @@
>         FN(NO_SOCKET)                   \
>         FN(TCP_INVALID_ACK_SEQUENCE)    \
>         FN(TCP_RFC7323_PAWS)            \
> +       FN(TCP_TOO_OLD_ACK)             \
> +       FN(TCP_ACK_UNSENT_DATA)         \
>         FN(MPTCP_RST_EUNSPEC)           \
>         FN(MPTCP_RST_EMPTCP)            \
>         FN(MPTCP_RST_ERESOURCE)         \
> @@ -50,6 +52,10 @@ enum sk_rst_reason {
>          * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
>          */
>         SK_RST_REASON_TCP_RFC7323_PAWS,
> +       /** @SK_RST_REASON_TCP_TOO_OLD_ACK: TCP ACK is too old */
> +       SK_RST_REASON_TCP_TOO_OLD_ACK,
> +       /** @SK_RST_REASON_TCP_ACK_UNSENT_DATA */

I'll add the detailed comment into this kdoc which was found by
patchwork in V2 series to make sure every item has its own
explanation.

Thanks,
Jason

> +       SK_RST_REASON_TCP_ACK_UNSENT_DATA,
>
>         /* Copy from include/uapi/linux/mptcp.h.
>          * These reset fields will not be changed since they adhere to
> @@ -130,6 +136,10 @@ sk_rst_convert_drop_reason(enum skb_drop_reason reas=
on)
>                 return SK_RST_REASON_TCP_INVALID_ACK_SEQUENCE;
>         case SKB_DROP_REASON_TCP_RFC7323_PAWS:
>                 return SK_RST_REASON_TCP_RFC7323_PAWS;
> +       case SKB_DROP_REASON_TCP_TOO_OLD_ACK:
> +               return SK_RST_REASON_TCP_TOO_OLD_ACK;
> +       case SKB_DROP_REASON_TCP_ACK_UNSENT_DATA:
> +               return SK_RST_REASON_TCP_ACK_UNSENT_DATA;
>         default:
>                 /* If we don't have our own corresponding reason */
>                 return SK_RST_REASON_NOT_SPECIFIED;
> --
> 2.37.3
>

