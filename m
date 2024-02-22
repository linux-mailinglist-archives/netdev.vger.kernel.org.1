Return-Path: <netdev+bounces-74112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DA5860081
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 19:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C61D28450F
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 18:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816CE157E93;
	Thu, 22 Feb 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRz7FWpZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C481A2BB01
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625518; cv=none; b=cvYaiduF8W7+eHu8km0orU3HEt2kRXDHMs2vzzXUKB6/fi+KvbuGvCA0ZUjMqYpHskuwAuwHygnSgltcst912NpwpsE4qHWC0L7lfka6oMBA8JpGzLkZBaq4B3L+2Gg0gYGndPt437SwPe0baIu8UhP+AnLvzeFTsAi6k1DXvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625518; c=relaxed/simple;
	bh=KPncTL4aBqujQSqk4XPknNbyLJ+auoEV8vje5Db3cnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwUSmkF+tH4ZoZwlj9VhnKfS2ijvsCJb79ODkqX+UsxlfKUae9OPg5YYlLoSE6UYHFk2KzSWKpsO9eGZet64HQ8MTv/PaTGXFpXJe7phbuIwg1tzaX4SsWLJzSwXOwP3ltrianUe3RRbmdeipuK6vYrITT6XWuDq1JnxVEwXSdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRz7FWpZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so8384863a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625515; x=1709230315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFxxrq50tLjdwhxEbdurkslWEcG5/gPrItFAiPhGpPg=;
        b=RRz7FWpZZeBWS/r8NUDz2PTXV1hIm7yErflvgYrshwda5XKs9IXL0PippGR3bli90s
         TNdWorQMmUPi+o1JEUUBDsJ1gL+5OG9GkgZT0rgKIWiYBSrFA66/oNtAYl2fGu0hZOtB
         j2mRPLc4VCHXJdVTnjwgz5Ndsek7L0+LYwSeMF8M7Vz50tdMcXNwr/OwyOcDsgkvSAm0
         /dwD+HAPPX3cmCgM/yTld19CiBZMfJX1jH0W0u6shLl+wgdU9Boh3274nUbiltXAIZ6R
         ovPIcMygoiMWpAxeE4/MkrQ4J8LWZa6g0N1Zs6ADgMy9UkX0qzXni3b/n2g6yLVG82p6
         jPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625515; x=1709230315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFxxrq50tLjdwhxEbdurkslWEcG5/gPrItFAiPhGpPg=;
        b=HAndpPHVv/v3Tc4+sdjxzyJDGXKBOwfRRnUTuxQeuRgMGid4Yy7E9CM5o8jeWOTaUv
         urEW/RVDTr751Y49WIWtYaO5nBXgLyF4pgCvIfNyW2anaxM9LF3c28HsWkuTQyrTISbg
         1rOsT7jv1HEv/TyP3F8FvI30wXYatugOwo6bDS2Ntt2FQQrLTnAivEG43mZu4jgMK22V
         6gevlCwZNNZJXz21Hivaq6H5rsy2iAaEmTvw1WmCh8mQg2U888aG3WaLYqz/PFARrrig
         hD+4OheECZH0Y0fwWKYc7ntMchDOEuXJ0od4qB9NdIDzTJqZgaUcDQXG+sPvGx+gd7Qx
         /PPA==
X-Forwarded-Encrypted: i=1; AJvYcCVs/AdtEeC2/qtXjQgipiuXHUTboCu4T6KQFcZZ5PTZu0P7qvlWgzjs46/gFoPrN2VpbBtWkPkejOHo8+Ola3aKMml9RA6+
X-Gm-Message-State: AOJu0Yw3naF/kJHkXKHO6tDQaxQkYZSJBdCab7Eimmzq/o5HtAie1aQ1
	YxNSKj0JuYhWeZ8Ik9d5Gte/q+bXXqZIZ+zwUWoDYfIfS/YMr8WjroXLmhxal8H9gO/a0JzRgwv
	NulCN6qivxhnryjTrz2Meb2tXNyU=
X-Google-Smtp-Source: AGHT+IFX3Hdm7vkq/sfyVBUqn3qEEqsAnRRt85tjLkb7PjZ71aZdG5BViXvfxb/TUCVr5OeQ198plCYyXaWy5XPBFX4=
X-Received: by 2002:a05:6402:1b1b:b0:564:311d:9912 with SMTP id
 by27-20020a0564021b1b00b00564311d9912mr11403700edb.30.1708625514944; Thu, 22
 Feb 2024 10:11:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222113003.67558-1-kerneljasonxing@gmail.com>
 <20240222113003.67558-9-kerneljasonxing@gmail.com> <b053dad4-5745-4b9a-af55-f5c04beb6584@kernel.org>
In-Reply-To: <b053dad4-5745-4b9a-af55-f5c04beb6584@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Feb 2024 02:11:18 +0800
Message-ID: <CAL+tcoCbsbM=HyXRqs2+QVrY8FSKmqYC47m87Axiyk1wk4omwQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 08/10] tcp: add dropreasons in tcp_rcv_state_process()
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 1:28=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 2/22/24 4:30 AM, Jason Xing wrote:
> > @@ -6704,8 +6705,13 @@ int tcp_rcv_state_process(struct sock *sk, struc=
t sk_buff *skb)
> >                                 FLAG_NO_CHALLENGE_ACK);
> >
> >       if ((int)reason <=3D 0) {
> > -             if (sk->sk_state =3D=3D TCP_SYN_RECV)
> > -                     return 1;       /* send one RST */
> > +             if (sk->sk_state =3D=3D TCP_SYN_RECV) {
> > +                     /* send one RST */
> > +                     if (!reason)
> > +                             return SKB_DROP_REASON_TCP_OLD_ACK;
> > +                     else
> > +                             return -reason;
>
> checkpatch should be flagging this - the `else` is not needed.

Maybe the way I use the checkpatch script is not right...

>
>                         if (!reason)
>                                 return SKB_DROP_REASON_TCP_OLD_ACK;
>
>                         return -reason;
>
>

Thanks, I will update it.

