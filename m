Return-Path: <netdev+bounces-72819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ABF859B7A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 05:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC6A1F2210A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439FC1CA98;
	Mon, 19 Feb 2024 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdoMRbg8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11F1CD13
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708318696; cv=none; b=HbKDH7DPSgDb6iXPYfA4oJtUIk9Izw8oHstAW3z317TSCavHqw5X50zXWgemgVOQH+H38vsdMbrYX4XVM55VCsLZOlN1fI6fdf+ZRT/fczyz5D9RvcUsPq+PjrRND0tGDgOkGI1woRbkBiuXQSRfJE4QKkA8FOy7s4DYnwm5D2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708318696; c=relaxed/simple;
	bh=o+TiuWUwJ/xwe+jg/SFWNUSGYziz3sZBjr6jdPV3wvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abKRmmf3BptpC062+YRs85pOlmOjWkp3whA7lioK9Hp2+xDBilV+nnefBamYnKVnSzvwre3i+61hKLz/02n3DxCmm40PusjMNDvtLbVeXeMhlYlTjFKe2tSYZ2l09qvipn7j0eGqJfzS6sAnHn5XRIt9L0333uTBDelHQomi54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdoMRbg8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so1646003a12.0
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 20:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708318693; x=1708923493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws6QYIz6VvhBC0E0Rz9A6yxDwPDW1ZUCeia5nYhoPkU=;
        b=JdoMRbg8gMaSLfNA3TiH2enBL3YFlqdzfjPe7nPTNQTcxjTlZzX0NI5agmy0AD3AZP
         lzdIJke5es+cuyu1JKBr98sTmrsC2bLagQxR8dzgp1glsIU0/zTpPgBeH3sOoKcKVpG4
         1WVsflPdEaty75zKhC2LYJjkS1p1jpz2eKABVpBJG8YzTdDxgGseGMEDRi7XUWLjqjcg
         LfaBA4K/DwVtVi0u8LdrtWgVjnjmp7BoYdLvszxFdas/6big6PyBTJI3+vmyYGMn1NcP
         wy3rcPJpHpAkTj3uLbFTwUnX+MQgBw8Or7seVcrvOU4my35aRNiwtmdiD/xHavG2WpNM
         zmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708318693; x=1708923493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ws6QYIz6VvhBC0E0Rz9A6yxDwPDW1ZUCeia5nYhoPkU=;
        b=w32XWRI8WLNfPb96JonK7xOx1Hpk4Pwum/APnGKyCNRKGCXbLrGdIrjRenIIQSXy/Z
         ub5whmHb3eC4fP1s2IUMYklsSvs1CQWNdG+P8BMPqNuy2pCpC9Ew9dO22T6k4pmdzTRr
         +bffNl2PEyF2rSPH7XI1QWhpaQsb0xXcBbMbpcMir+nApLLRulVoo2561baIK432VoGW
         RD6flnNjICK47PvAMG2uNL8/JTu1qvWBovCkrWzMwchpy80HvsP+S6eU0pRSwgp+6rz2
         HohS9oAVmi3RBignRKuVwDt/QGoGo3dMGCdvLHOgDz/jIKaXVHt+MXq6KgK2DdYwq5Ms
         Tdhw==
X-Forwarded-Encrypted: i=1; AJvYcCU3wiydrCv5uuJtazk9optGHNAvCuG4/nAO5VUQs1YDgl9IxYfaSInUHAfyAjp5avzh4A1+icloVNhdSobMLvmShxtVtusq
X-Gm-Message-State: AOJu0Yy8MDQ7ER7HcOx9FHm1BFudyNcEf2vttlesGNrSF2onnR83qhGO
	+lYwDM+E1dwAZgUkBStlImG2LDesDyXgrb01v+qF2X5uWRMYxFxNh0TIEgmP1/opTl64XyUmgJY
	fqn+OtN0NxQkJZGn4nGuYJS+IwQW2cWDP9vw=
X-Google-Smtp-Source: AGHT+IFdZh3UGfSy5b4dAXrK5WS9E7jsQ9NiZRlYO7eeekq9tjSoZl+FpaFz5eT1WCwqNZl8F3Xdza6Bjhr12xwaQuk=
X-Received: by 2002:aa7:d917:0:b0:55f:c5b7:5855 with SMTP id
 a23-20020aa7d917000000b0055fc5b75855mr6740348edr.6.1708318692623; Sun, 18 Feb
 2024 20:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219032838.91723-7-kerneljasonxing@gmail.com> <20240219044744.99367-1-kuniyu@amazon.com>
In-Reply-To: <20240219044744.99367-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Feb 2024 12:57:36 +0800
Message-ID: <CAL+tcoABYSbFCfctNqd9yO0-fnczFqvk0NdZoWCyk=atF5yBiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 06/11] tcp: introduce dropreasons in receive path
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 12:47=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Mon, 19 Feb 2024 11:28:33 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Soon later patches can use these relatively more accurate
> > reasons to recognise and find out the cause.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > --
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
> > index 3c867384dead..402367bfa56f 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -30,6 +30,7 @@
> >       FN(TCP_AOFAILURE)               \
> >       FN(SOCKET_BACKLOG)              \
> >       FN(TCP_FLAGS)                   \
> > +     FN(TCP_ABORT_ON_DATA)   \
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
> > +      * field. because of ack sequence is not in the window between sn=
d_una
>
> nit: s/. because of/ because/

Thanks. Will update it.

>
>
> > +      * and snd_nxt
> > +      */
> > +     SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE,
> >       /** @SKB_DROP_REASON_TCP_RESET: Invalid RST packet */
> >       SKB_DROP_REASON_TCP_RESET,
> >       /**
> > --
> > 2.37.3
> >

