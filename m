Return-Path: <netdev+bounces-198498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B8ADC6F2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6CF61632E3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD928F519;
	Tue, 17 Jun 2025 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmZfYm5i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C8217F36
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153731; cv=none; b=U8ckLmNQl4ODBuKr+FEcQ+R5VsvFsDx7GMWfz3s4TI8K3MLqRNGfx1Rgq33RVAULaTgG5VKP6Mennpzv00S0qTAW3fxJN01iTxi5JCiuzQmDgyqpy2GifNqtAItQ0+Kq3sNoXFsNX/PWJPkXp5pJjkuIBUd7IerNZmesTQIogRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153731; c=relaxed/simple;
	bh=9DkuysWlNaEvoYWvlSH0B5y/tCvLrBaUM02uJS2OsWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxSCabJ9FJI2UGJCV9TmsbyvzhmEWRplFzr+RwAV5ISU33FJq3Z0k2HPWXxL07Zn3ASwXZaV6V3fpP2yp2Z8fynOcaGOzza6HdyT6uXd04HuJkG9iCcP53YqH4evRO8g+6U9mSRbDNYQ+1J98f0OYHsYpYvWzPEXNWsBuyuZqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmZfYm5i; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad572ba1347so870763266b.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750153728; x=1750758528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DkuysWlNaEvoYWvlSH0B5y/tCvLrBaUM02uJS2OsWk=;
        b=OmZfYm5i3P/kBr5xwu+qyYsYSkNpQJE8MJGezWTQLaVs0uoN4BxzIpabIodaU7Twfk
         ShMp3wpqX1QXPfQZsACT45UPEDHNfaaLI7+oi/1D7k4bNbxH6a6KMHbZyfSjT7qC2xoi
         7uMo35nsHEHXi+LwlZFV1qDaOqe6JkYza3WvYbGfY/mZ208EOhKY77fqE04vA6lzyybE
         urKZCqkiC4qIUUJ3tCvRKsuUXYswcRiCF9/7ybhYXfdlNBPS78dU/p6Ks5gS468Rfxvr
         6GttEFfZ68pMqXspqI0lcmaj7FwZsKeSUoOEEJs31kubsGlEXuKXmLcGNMb7q9HOpTlV
         oUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153728; x=1750758528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DkuysWlNaEvoYWvlSH0B5y/tCvLrBaUM02uJS2OsWk=;
        b=HLNZxkYT2ipPEspfrMjkBYvWoVJvxZhNsYZ6u9oroLnh4rikf/uYnVuXDak6OV69ys
         pvvaxlTqm5KXHMKg9N1SFt5SA6SWNtbWHTvc9K5lIya4o8kup/eHQWqNueNN3dDdpZIO
         nIh7WfY3ERKbTdd607GDPOrQ0r8CjnTABtfNbsCA8qol0wpqwPRnKVd9Kspc4Z4bAAUM
         ggq57DFPFHh700SldqAh8iHfkwqBidaOHkOuvveveWF5j3VQ4Fs+6D9lHqCi6FSLwbgb
         zo58LihSAes6eddFUAAa6Z8VNyrOlsAYPT2f0zCmi4hwX8YiRJz9x31xX+BbJZ6qSwty
         w56Q==
X-Forwarded-Encrypted: i=1; AJvYcCUs74sSCfyqvBfxXyl5Fu5rflyk6D6DGaTb6BkYm2NR0ICrqW9LL/AC5kXEW2Y933XFx20ANXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuys9T9hzPye6EszpzeagY+fDloI8K1ZzniXVTT7Wvqc94UioP
	Hr4Se/Q/EK9R4BIeA3WDLbma2eJ8V8OoNm/LieMotflOdIB8zhNExA9sTYq9VwGO2BbVXGmlb39
	bU178SviaqPC9jMvX3AnsRpQEUS/H08TyNfSKsbCy
X-Gm-Gg: ASbGncv83pitGhJ1O34lzLHRcMwXic7EkW3LTNSHA6aGK/ZrRy0Ji2EEb7ba2Fpakao
	KKCYE05Sf4R8g8gTIduuTW02YfJPPyGk9BdA4QmGg3MmqYIxtBR24HU8T2alsB3RmKKfvQmXEIC
	9hiQJJ7mGojUtzQA925oQitoyBzyL8H15GVif0X9b4JciSPl3+3S1pS2knETpk4X9OprgEfk02W
	Exi31LdaP4=
X-Google-Smtp-Source: AGHT+IGxJ/+hSyr2gNBDCExA5aN7uTYi8ZegfjnYTodx8GGEjXxZ5WnT4AkolwnayQwqylcNFPloTyiWduziC9USG5A=
X-Received: by 2002:a17:906:c105:b0:ad9:85d3:e141 with SMTP id
 a640c23a62f3a-adfad52b9e4mr1223752866b.53.1750153727535; Tue, 17 Jun 2025
 02:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6850d3bd.a70a0220.395abc.01fa.GAE@google.com> <CANp29Y68ZaQnb0R2fZSLjcCxiOE3uZyW4b7wLEYMAycF0WHNUg@mail.gmail.com>
 <97d6493279ab5c63e8844e8b0f349b2528d2832b.camel@sipsolutions.net>
In-Reply-To: <97d6493279ab5c63e8844e8b0f349b2528d2832b.camel@sipsolutions.net>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 17 Jun 2025 11:48:33 +0200
X-Gm-Features: AX0GCFv6Czlrb0GcMMCvwTkEltQ2PwbAAXxRRCc_-jICqq7SqhBA80DDGlCg2CY
Message-ID: <CANp29Y5+W426u0jUz0PT=zVde+QqSD9H1fLpTuaKSzCLrt5FcA@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] WARNING: net/mac80211/tx.c:LINE at
 __ieee80211_beacon_get, CPU: syz.NUM.NUM/NUM
To: Johannes Berg <johannes@sipsolutions.net>
Cc: syzbot <syzbot+468656785707b0e995df@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 11:43=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Tue, 2025-06-17 at 11:34 +0200, Aleksandr Nogikh wrote:
> > #syz dup: WARNING in __ieee80211_beacon_get
> >
>
> Not just this one :)
>
> https://lore.kernel.org/linux-wireless/20250617104902.146e10919be1.I85f35=
2ca4a2dce6f556e5ff45ceaa5f3769cb5ce@changeid/
>

Ah, interesting :)

FWIW, in this particular case, syzbot sent the duplicate report
because the WARNING format has somewhat changed in the latest
linux-next. So before we updated syzbot's parsing rules, it had
managed to re-report quite a few duplicates.

--=20
Aleksandr

> johannes

