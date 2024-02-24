Return-Path: <netdev+bounces-74640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B38C8620EB
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 01:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32391C221B2
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 00:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3766C10F7;
	Sat, 24 Feb 2024 00:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+NfpbH4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657964691
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732957; cv=none; b=cOXGXnhGV/SZjeDzOcRgZLc//nFCRyzvgB90nHqsxc6dTriUOonFL8JyWB1291tqvmlddUiECBU/1DzRKT9fv5d6JjT4Bf27LK+8Q4ITKYLkLPb4REGl0Sq76ZPDqGff+dqKP297KIK703qInfr6Z0+R0w3ikJH/RyYpq5ttSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732957; c=relaxed/simple;
	bh=o3Y8MEsnw3nTXumS5ysAPmjs5PSN/+xz2DilCm7iDMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sta++xEwPCeCUGl82+f9af3Ebi3WZCwTcPmnOhfWunL68J0tHqO3hsT7Npl7DlurL19EEXMgMgbAQ7pNnYBFhlQ473NDt3QZ6uNx5QJ5GGabMgj43NlNVHjhBNC1mIqa6gjReP4206wJb3Fr2ZpiFc+zfbiIgA6t4Sp/WcE6XSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+NfpbH4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a293f2280c7so156024466b.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708732954; x=1709337754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydeVpVmsijfXyDgP1gczK/vktc6t590o1+a4Z7nupuM=;
        b=A+NfpbH41Xrj/MybMHZYaaCR+W6ohjUOku6RQtbG8tLvwhOTdWHeVcaQJP58hZPv36
         w4bsZhd9TVvP0K2csO8rzoLu9kZTanh621nynmg/og5zj/DGRuG17aQ3rblQEeashP+g
         +Rffh8nZynrerrpORuXn8XZfiohlKoFUhzjKB/CeBiXQWtG2ZWnLtnVUhuz6fRAwgmFg
         zZ9D+zF2+ZIC0hEVxeyKoiP19beS5l6h9Oi7/JuWdQyTnYmrFuONiAlDXN6xVfjrLcm7
         lvAuiBx09M7ckO/lgcjP2nXKGi/DKJPRguAjJiFhGXfFbbxRu4dKpsR/ORnEu4Al+JY6
         s17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708732954; x=1709337754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydeVpVmsijfXyDgP1gczK/vktc6t590o1+a4Z7nupuM=;
        b=IeEHVDkS+A8+Ul5Ogvt8eXmUNAPcffn8igMw59ETksaIwzTobu4eiq8iGgDMs71WKT
         XGQJ+R6OKNZ95PPXChU/zpHRO0OtR0nhzR/b8cSySVEOGiwvShkhGnDCaVnnqyImCAtL
         RDmr+G6g45ub7DS6DxV7EcfZ0S8WR0ZqEe2omPMRS6gtgGLu5riA+pWMcxWbqfY3DhCD
         FViz++QLmgbvGbvsHEkajP2aRhu0HoV0xhOJNVZ6TOKXfebBZFLlgCxhmXUULbVl5sEi
         qFuUIbMB/32aKl8DL+WZNYTinvkG5PCtPYWZmDr6h8Kqk5NoI55RLW2Jl6dLngdtpO8E
         RW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuo5aPlW3JcRtUSj5rHA1HMXlXucq6UYBYS6Xy9tzHYXhRSBBQDXTAA5ke5SH1l1oi5c6iDYWRY+GoRTLlGH0hjxuebPZ8
X-Gm-Message-State: AOJu0Ywy2E+paD3qgLOG81y8k4sPjKxf6BdkRrA+jOmx/xLQ+pzHEjMh
	Mr4A9KM/mF4B8QbdAJHR8sgzviG6xfJ8053F/zeqFTdGmKLevBwK3YaLdQNMDX2XXJxh8eqaTsT
	5HHhwDWnJKRyi9WV69drqLzw81Tk=
X-Google-Smtp-Source: AGHT+IGU4TkA7MAAQ/nLMsPiwtrSeloPulayl9E2u1PpIBlLvFPUwv3BefYXlBbfvQCb7DXRuny4gE0gEszPGvPqfW0=
X-Received: by 2002:a17:906:4146:b0:a3e:27e2:2075 with SMTP id
 l6-20020a170906414600b00a3e27e22075mr797128ejk.67.1708732953641; Fri, 23 Feb
 2024 16:02:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223102851.83749-7-kerneljasonxing@gmail.com> <20240223193321.6549-1-kuniyu@amazon.com>
In-Reply-To: <20240223193321.6549-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 24 Feb 2024 08:01:57 +0800
Message-ID: <CAL+tcoA-2ZtLxtLmmXYaX-27MeBf01eK+4zs5KEU6V3qKbGJhA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 06/10] tcp: introduce dropreasons in receive path
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 3:33=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Fri, 23 Feb 2024 18:28:47 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Soon later patches can use these relatively more accurate
> > reasons to recognise and find out the cause.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Reviewed-by: David Ahern <dsahern@kernel.org>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> one nit below.
>
> > --
> > v9
> > Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fd=
a1@kernel.org/
> > Link: https://lore.kernel.org/netdev/CANn89i+j55o_1B2SV56n=3Du=3DNHukmN=
_CoRib4VBzpUBVcKRjAMw@mail.gmail.com/
> > 1. add reviewed-by tag (David)
> > 2. add reviewed-by tag (Eric)
> >
> > v7
> > Link: https://lore.kernel.org/all/20240219044744.99367-1-kuniyu@amazon.=
com/
> > 1. nit: nit: s/. because of/ because/ (Kuniyuki)
> >
> > v5:
> > Link: https://lore.kernel.org/netdev/3a495358-4c47-4a9f-b116-5f9c8b44e5=
ab@kernel.org/
> > 1. Use new name (TCP_ABORT_ON_DATA) for readability (David)
> > 2. change the title of this patch
> > ---
> >  include/net/dropreason-core.h | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index a871f061558d..af7c7146219d 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -30,6 +30,7 @@
> >       FN(TCP_AOFAILURE)               \
> >       FN(SOCKET_BACKLOG)              \
> >       FN(TCP_FLAGS)                   \
> > +     FN(TCP_ABORT_ON_DATA)   \
>
> One more trailing tab ?

Well, I noticed that there are no specific/accurate rules about adding
a trailing tab prior to the current change. Some added more than one,
some not.

>
>
> >       FN(TCP_ZEROWINDOW)              \
> >       FN(TCP_OLD_DATA)                \
> >       FN(TCP_OVERWINDOW)              \
> > @@ -37,6 +38,7 @@
> >       FN(TCP_RFC7323_PAWS)            \
> >       FN(TCP_OLD_SEQUENCE)            \
> >       FN(TCP_INVALID_SEQUENCE)        \
> > +     FN(TCP_INVALID_ACK_SEQUENCE)    \
> >       FN(TCP_RESET)                   \
> >       FN(TCP_INVALID_SYN)             \
> >       FN(TCP_CLOSE)                   \
> > @@ -204,6 +206,11 @@ enum skb_drop_reason {
> >       SKB_DROP_REASON_SOCKET_BACKLOG,
> >       /** @SKB_DROP_REASON_TCP_FLAGS: TCP flags invalid */
> >       SKB_DROP_REASON_TCP_FLAGS,
> > +     /**
> > +      * @SKB_DROP_REASON_TCP_ABORT_ON_DATA: abort on data, correspondi=
ng to
> > +      * LINUX_MIB_TCPABORTONDATA
> > +      */
> > +     SKB_DROP_REASON_TCP_ABORT_ON_DATA,
> >       /**
> >        * @SKB_DROP_REASON_TCP_ZEROWINDOW: TCP receive window size is ze=
ro,
> >        * see LINUX_MIB_TCPZEROWINDOWDROP
> > @@ -228,13 +235,19 @@ enum skb_drop_reason {
> >       SKB_DROP_REASON_TCP_OFOMERGE,
> >       /**
> >        * @SKB_DROP_REASON_TCP_RFC7323_PAWS: PAWS check, corresponding t=
o
> > -      * LINUX_MIB_PAWSESTABREJECTED
> > +      * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
> >        */
> >       SKB_DROP_REASON_TCP_RFC7323_PAWS,
> >       /** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate p=
acket) */
> >       SKB_DROP_REASON_TCP_OLD_SEQUENCE,
> >       /** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ fie=
ld */
> >       SKB_DROP_REASON_TCP_INVALID_SEQUENCE,
> > +     /**
> > +      * @SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE: Not acceptable ACK =
SEQ
> > +      * field because ack sequence is not in the window between snd_un=
a
> > +      * and snd_nxt
> > +      */
> > +     SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE,
> >       /** @SKB_DROP_REASON_TCP_RESET: Invalid RST packet */
> >       SKB_DROP_REASON_TCP_RESET,
> >       /**
> > --
> > 2.37.3

