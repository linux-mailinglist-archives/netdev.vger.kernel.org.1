Return-Path: <netdev+bounces-247627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4713CFC85B
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B77D3001021
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3792367D5;
	Wed,  7 Jan 2026 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4GpmKtgz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9B4275B15
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773387; cv=none; b=dFXSZiyPwMFrv31np88xq4B0GuJHP6MD1N9F75UFPfCRmCco4y3HRf4smBtuVhnCzSrWH39lR/KOLDnhk/XDy3ptgR7YWITUcWBg2xwUMei+UGlOD5I4PgNmsKs1tfvglMd6Llz5w47He10MDQ7+DKPQdW66Bsjq6aknEHNSSbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773387; c=relaxed/simple;
	bh=iDtvpg6okKHzbsH6k+r/FzkPcFZ1s7i8Tla2oUecwgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lj9y3h7mCFfltsD7acUT1rtllXuWmVpduZ7DKCCbWzv8yTqlfbgMSU12TbeAPyvL2ZzbeGtzosyb2/MbY10SbDV5H2nWd6kdVAcEnIKXxlQoeUoKmdEaIjxtaHzSck0Dvz2ShsYuXGWQHohMZzFnKcrI6L+RY1KbkzsFjfuUEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4GpmKtgz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed82ee9e57so22649701cf.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 00:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767773384; x=1768378184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGGRmaaunU4JOHExm8Lgzywsl0QINWdAv0QO1UVUpH4=;
        b=4GpmKtgz6HiMz/ES2yS0IvkuuK4IqQ6MQTEafzvjKtSaQKjlp/zLZDrir98CbK4gMV
         oASlk5z8CRq+RtGrXPBvxmeBTiV2rQrVIUcXkY1PSgWSp14vA5R1Foey2goiHHCWu+RD
         zJc5kObTFf+19YCK3qA5vmCxiZIP9rG+qdTMf9zwCqtuqZdFcYKUFsqgJZQiA0kYtZIa
         wOJU7Dm1qCzikOarPnANnxTYPA0gUe6Pyo3ZXyz8JRrPGKhCBw//0TwsR8kEj5EHNEPi
         bHc7x+b1TFqDucLhCBcKntbgkBytk9NgPUcHed0Vu9+qK9sQAgBBzFTQiKg/YvBtJ5rM
         E8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767773384; x=1768378184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RGGRmaaunU4JOHExm8Lgzywsl0QINWdAv0QO1UVUpH4=;
        b=WOQehtMwlPvSAbPtHr1mPjhZ/e3TWKOoatT/D14SzV3PCSSi0WNf77bA1gH1Eqyc8B
         rgJukV8iOXObgLd3YJuHAhy1CH4uxfSjfKFH5KfZ65jeudM4GuylAM0gDLycpzLgKvii
         Br1R1zL1vQjLZDaLBHpG4ti/WBJKNTN3TAI8zxioZbmzrJhJwz30jRQF1YF1p9d+0nsd
         SAnWEJoODgjmFsW0O9A3PYmSpZUHnVt4EyXQ+ppRvJ0m564BoJ8HqnU3ndNZ930M807p
         Yg0Cb3yK8BuU6W3fF5Z8ty3IQx3tgBSdis/HTVnFGEHqKXux950kIlYZneL0vCu6jE5J
         e8Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU308e4I5OBnzBYYv6NfOdP4IV/oQUdePZ6m+/+CStYag/AJXTdB9FU9kF3/6HDWu9MzorQTCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJyzHFog6tcttW7Vpxzob83GSTBNOqjsJcXoVNApI8jKpfrRM
	sL0g42iVbpGhDgWd7HDnHqkMAuBY4xyowpncZKwy1HcDFLyFCjaXEkMyeVDqKLcfwuHwbCrzRJn
	LJIJtMf/JcqbRCpvOAv/I5a+Y6OYHXC3XVJogwCgv
X-Gm-Gg: AY/fxX5l22wRzY4vGSgDJeX6A/T9JB4MRgLP6yVzXjEwtRvUzNXrG0vn76buATqe7rQ
	b7Qo93cX+aAjwIsTxFPbxD6qHNmyXKjUm3YIOcz7YBIGk+w/K8vCPpbrElGgAKQwWcVZmsA24I1
	YRkT+fNZESmPjx3HdpQB4oZivjoCHk/uU1QS7POCLGY83D3F+nGF9HwkM2FBV/tOIRqgB6SHa+g
	OMydueL36O3P/K3/w/5Q0ikxTr/MMQyTm/GUnOeRwZFC/bcRrK6f3ObzrU8tg8hnpBntQ==
X-Google-Smtp-Source: AGHT+IGNG65Be4zODipDD019g7WIz1QA/b45gTzV4f0diuN3AJ8DEZJ8F9m/c1BSJ9SkgC79ouAlPj/gV2uDGSt+TSg=
X-Received: by 2002:ac8:7d44:0:b0:4ee:4a1f:f8ea with SMTP id
 d75a77b69052e-4ffb4863702mr20582371cf.31.1767773383608; Wed, 07 Jan 2026
 00:09:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106194022.2133543-1-edumazet@google.com> <f3bf9a76-c110-481a-a89a-c54d5856cfe3@blackwall.org>
 <6a7cb6d7-b337-4b21-b236-5419b785dc90@blackwall.org> <5452a132-448c-43db-b6f2-53f0f207dc67@blackwall.org>
In-Reply-To: <5452a132-448c-43db-b6f2-53f0f207dc67@blackwall.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 7 Jan 2026 09:09:32 +0100
X-Gm-Features: AQt7F2qPKzM1_Perd4-FU2A9JIOzGeBot9tECBkBQBM_FJ1P0XjatSZuvSPk7kA
Message-ID: <CANn89iL8-e_jphcg49eX=zdWrOeuA-AJDL0qhsTrApA4YnOFEg@mail.gmail.com>
Subject: Re: [PATCH net] net: bridge: annotate data-race in br_fdb_update()
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 8:03=E2=80=AFAM Nikolay Aleksandrov <razor@blackwall=
.org> wrote:
>
> On 07/01/2026 09:00, Nikolay Aleksandrov wrote:
> > On 06/01/2026 23:26, Nikolay Aleksandrov wrote:
> >> On 06/01/2026 21:40, Eric Dumazet wrote:
> >>> fdb->updated is read and written locklessly.
> >>>
> >>> Add READ_ONCE()/WRITE_ONCE() annotations.
> >>>
> >>> Fixes: 31cbc39b6344 ("net: bridge: add option to allow activity
> >>> notifications for any fdb entries")
> >>> Signed-off-by: Eric Dumazet <edumazet@google.com>
> >>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> >>> ---
> >>>   net/bridge/br_fdb.c | 4 ++--
> >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> >>> index
> >>> 58d22e2b85fc3551bd5aec9c20296ddfcecaa040..e7bd20f0e8d6b7b24aef43d7bed=
34adf171c34a8 100644
> >>> --- a/net/bridge/br_fdb.c
> >>> +++ b/net/bridge/br_fdb.c
> >>> @@ -1002,8 +1002,8 @@ void br_fdb_update(struct net_bridge *br,
> >>> struct net_bridge_port *source,
> >>>               unsigned long now =3D jiffies;
> >>>               bool fdb_modified =3D false;
> >>> -            if (now !=3D fdb->updated) {
> >>> -                fdb->updated =3D now;
> >>> +            if (now !=3D READ_ONCE(fdb->updated)) {
> >>> +                WRITE_ONCE(fdb->updated, now);
> >>>                   fdb_modified =3D __fdb_mark_active(fdb);
> >>>               }
> >>
> >> Thanks,
> >> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> >
> > Actually on second thought, ->updated is used lockless in a few more
> > places, e.g. br_fdb_fillbuf(), fdb_fill_info(), br_fdb_cleanup().
> >
>
> I mean I see the subject, but since this patch will get backported
> perhaps we can annotate all instances in one go.

Sure, I will send a V2, thanks.

