Return-Path: <netdev+bounces-152998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426E9F68DB
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB8237A2412
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8EC1C5CB5;
	Wed, 18 Dec 2024 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kszJVjY5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7601C5CA3
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533104; cv=none; b=TRPQRbekz6uPdZRZRkg+4ZnVi4lVehkqpP3yXHdDVEkDtuW2CSAaYtmzfR+f66rOO3iixkrUCDHNrb02RN9JWW1EzArcCnwQAJxol7fAUrvZP+6X+nMnnaPLyeK+ZyfhO8dZnUS+c/789CTZT3guzXHJxwcPDU17iBNVHpSRSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533104; c=relaxed/simple;
	bh=6G3cw0GA85gvLCUYoxKlmm1BxiAeb0Wd7HozJLmTY6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEwfB3O66Decqitv41t7mVGi50+HFX4qLh17FGRFHRauXr4SWjjpFLCaf/MUVqdwDd3MC1hGyl99k6dIkuebKxwDsRJBo3TwzJLMPTPItOZp1Ye8ZKLG2k9U5YbDNpo8GKdFDtAkdaprWggC62bfrwJCeY3kN+8dJZvkt7JV2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kszJVjY5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so899929766b.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 06:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734533101; x=1735137901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G3cw0GA85gvLCUYoxKlmm1BxiAeb0Wd7HozJLmTY6s=;
        b=kszJVjY58wMlwGP/uW4ObG3cWRCvuvXQo+xj9LELfubWVjkSWFB2x4TyGOkznmimkk
         pc3duriL99jg3tiNe/aRVVmDSfLZSWcj4WMBLtnjCwC9rbAq1mReLiZnKVD6whlvqUKN
         3uhc6BAezNdRa2Zyauir4dy5mBjxs57C36Vd9xy5bhNJP14aNcejuT3VDLEziGmggDpy
         PLpPIXcZen1vb47aK46IdHHYPlKHx7gFeG/gerTEar+I0fUUS0c/KH1skqsDYkwmQ3bE
         7KuPx1qrrSr5bwY/O4eZ7lYPwqABdCx5H7ntEH1jE7jnKpn6LuuJcsRDBaxA3/dI49O0
         8RSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734533101; x=1735137901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G3cw0GA85gvLCUYoxKlmm1BxiAeb0Wd7HozJLmTY6s=;
        b=XjQ5/mLOF+glK94g3MvlMulVtcqhjBYkIX6pveatqqHROo7BlZPBn3+5varymzoX+z
         gGPdmyX0jSsSmL69J40hq4A79KEki9q9my3BkRkcy4hGmtl5rEEXZDtFAxFVG2GkM6qS
         QJAvWp0j6FVG7ZggV/tdv0hwcpQHFdHwaCUIoXKB4Sbpw2KhbaVyycZpocjhDcHALRGE
         paxOW2yR+515iJjh3ldIqLM9gOmoNSgtsWl5LUBvc9y7VUzNADMYz1675YXktvSuX1F6
         2I445Tq1s0t+Yg+4Q2oKqYWE8dPZCZjjSGY14IuJvfs+8jEfgMQ4ZcEOHs/ImgO2j6JP
         c63Q==
X-Gm-Message-State: AOJu0YxLL8c/ZrX0kXNjD3qBcKBSR03DKA8c/Ra04vIuniTaMDZ7FOnq
	G+GZknZOTBFXhbkilUCWIPkTVcbVEPLbDQF1Qt/JY9nAnJmZtwQVjkrzrnYjCMxJxm/w1tJFhP3
	6EkVpiAwzfRUm/wCy5hglFRAsCdGgs7ho0ssTI+tmDffNXWH/ByCL
X-Gm-Gg: ASbGncuoInkenjbxDEs1IrYg58qnjKNSdp5tpf0qJOnStHPl0Jm4Izl1X30pp5NskOa
	Lcj6KwgJigFXj3UtWt9LFKjgHgsO6qCGnUl+76k1tDUf6QCfWHtgwNK2kLE3vp8nt34Zmtd0=
X-Google-Smtp-Source: AGHT+IF2y1lqKu0zNAq5+pc5AmNeJuy+GM8qwk/AUViqS7GEZE33nJ71K7sX8BOomTDP9Jo8cfMGULyG5RhhmNC5Woc=
X-Received: by 2002:a05:6402:2548:b0:5d2:7270:6128 with SMTP id
 4fb4d7f45d1cf-5d7ee3ef3eamr6741760a12.25.1734533100769; Wed, 18 Dec 2024
 06:45:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218143334.1507465-1-revest@chromium.org>
In-Reply-To: <20241218143334.1507465-1-revest@chromium.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Dec 2024 15:44:49 +0100
Message-ID: <CANn89i+e8w7ERQ38O+-C+G-BNf=nWw1-+=cvka=4wvJFUgOKGg@mail.gmail.com>
Subject: Re: [PATCH net] af_unix: Add a prompt to CONFIG_AF_UNIX_OOB
To: Florent Revest <revest@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com, 
	rao.shoaib@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 3:33=E2=80=AFPM Florent Revest <revest@chromium.org=
> wrote:
>
> This makes it possible to disable the MSG_OOB support in .config.
>
> Signed-off-by: Florent Revest <revest@chromium.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

