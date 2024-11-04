Return-Path: <netdev+bounces-141380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6449BA9B1
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 01:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C49281A2B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 00:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C88B382;
	Mon,  4 Nov 2024 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3KULfUO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAEB2594;
	Mon,  4 Nov 2024 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730678946; cv=none; b=V8o224tH02v684PoEB8EpVbEQ3sPhLVpar9L+bgW9gDxI4y4IbSZLXM0YK+CP/MM92uNE6MDlz26q6YOg/54833xN0r3IhCMFYkXQKbSuNxhO/TSkdw5APRV+DW+aa1lZcaXTvvYudaj+tvxqFxf2M+uRnYS+IvpRwqicPMpcVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730678946; c=relaxed/simple;
	bh=g3P8YTzB6Y88wmELwzImGVKqks84YxL6j8F2uU/UbVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcLVmLuZDnfOPVbJf/P2qEh/W4CUGQuXRecDwK6LC4lJ0aouyVIUnG06nz1FpqKhh8gGrBKyJo9BYd/ec8n/3fDn3DmSAOHPW/G8WKL2WSFCdstnTZmUT8E2nhknoQYnmSNCUxtSxFnrKKhPUxNrKxjFfeEUvz2ICQkf9OJ8+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3KULfUO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e5a5a59094so32932127b3.3;
        Sun, 03 Nov 2024 16:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730678944; x=1731283744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PX6+JWTSLsRsx6aLOO1HsVjRWrGwh0LXWGLa/mQmJQ=;
        b=H3KULfUOnQjBhfn+y0eW9rOEcRQeTRYXSp1ObXkkfB8dsugeOxAtnlGJLP1n8opRl0
         6lim+1pLwOgCXKPPHbsKu3H38YNCPbppZ4Kc/jQeZaeoz1bpDKhzzW9gVeWvjUQusEGd
         Ka/t+nBQH1EEg6GsaJYqNBgTIxznQL/dEXSGV9iQqwhAGxzNMXuXdqukVz2HFQ6MTJlG
         zu+Xvdmnk0hg8LxPhtyjVF+eSskIa69RANSg94RCh4eKTNyWQmsttDk3VC0DUumdezhy
         Tq+g/EMBcllGgwHoteJO06Ub1OeGTAi5OSCGVsEJ+xd5iPfwaiX0vwAJw/g5pMQhXf6d
         u6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730678944; x=1731283744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PX6+JWTSLsRsx6aLOO1HsVjRWrGwh0LXWGLa/mQmJQ=;
        b=cFhj94JIpQ3LXR3I8VMaesspPd6rAlIrlsfcMmt8jIM+/xQVukyAmgcyHPgMYG8Jbm
         2JaYzGDwtNQWyOJpy9qHK+Up/rZ4JHVKAXmwMPaD2LnCL8WXVcsBNU6tZ0qivYsjPGnN
         zQhqC+khMjrCaUFf9aKPew+BvCCj4wU5+vglT/rjQnkv40nbH6sqHLDkPV41fbHimnOZ
         C1PIFcnJ2TIIaepT4UIvqAggWiKy3hUy17+6aYC2/7ihQVGOXlMeUnrx0uKqM6TWySiM
         jZalyg7Q0Znxa/ku/xi617xQP2gNKlN/fLJLyGSaLoJ4SDNVX5bBZ3yOemB8q393gEXo
         VAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIXRFfntCRcrLcIdGhjWjRjDlsohoioDx5ZEEa2oHfxPjfN0Ht2bRO9ZLiOnQvakdpoDZfr7xDTDMr9xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1xt/penUSMoCizu5ucemtT9qm/dhtdShUlO2Kxna2HtdV+uaZ
	vSOgukwa91spazztob9LLvaSKu74sgf2y5JujSkTAaq4iHe9a+dwqrrzm8Avj032wUSENZMTzBC
	t+XIFqG3ktSNs46p929A7CHYV98o=
X-Google-Smtp-Source: AGHT+IGsZJ5dSBT4uscp0sJ895Q/4hXkOhe1NnNJK8zrIRKTYSQw2U7nVsoSrLZPdUn+QtN+SmO7pEwL+0DgKVHgdss=
X-Received: by 2002:a05:690c:610c:b0:6e3:26dd:1bf5 with SMTP id
 00721157ae682-6ea64b0f17emr95678177b3.20.1730678943985; Sun, 03 Nov 2024
 16:09:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030205147.7442-1-rosenp@gmail.com> <20241103135958.28eba405@kernel.org>
 <CAKxU2N8bO4j-2++NH-4Ju4aXgSWXcdSJ9EDfUo=U-hxVF+AXvQ@mail.gmail.com>
In-Reply-To: <CAKxU2N8bO4j-2++NH-4Ju4aXgSWXcdSJ9EDfUo=U-hxVF+AXvQ@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 3 Nov 2024 16:08:53 -0800
Message-ID: <CAKxU2N-AkTDOXt6mBS3Sk3jVFBY036P3+rPX7fM-mVstebYpXg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: bnx2x: use ethtool string helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sudarsana Kalluru <skalluru@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 4:03=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrote=
:
>
> On Sun, Nov 3, 2024 at 2:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Wed, 30 Oct 2024 13:51:47 -0700 Rosen Penev wrote:
> > > @@ -3220,13 +3212,13 @@ static void bnx2x_get_strings(struct net_devi=
ce *dev, u32 stringset, u8 *buf)
> > >                       start =3D 0;
> > >               else
> > >                       start =3D 4;
> > > -             memcpy(buf, bnx2x_tests_str_arr + start,
> > > -                    ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp));
> > > +             for (i =3D start; i < BNX2X_NUM_TESTS_SF; i++)
> > > +                     ethtool_puts(&buf, bnx2x_tests_str_arr[i]);
> >
> > There are three cases - MF, SF and VF.
> > You seem to have covered SF and MF, but not VF.
> #define BNX2X_NUM_TESTS_SF              7
> #define BNX2X_NUM_TESTS_MF              3
> #define BNX2X_NUM_TESTS(bp)             (IS_MF(bp) ? BNX2X_NUM_TESTS_MF :=
 \
>                                              IS_VF(bp) ? 0 : BNX2X_NUM_TE=
STS_SF)
>
> VF is SF.
hrm so BNX2X_NUM_TESTS returns 0, 3, or 7. Makes sense to do an early exit.
> > --
> > pw-bot: cr

