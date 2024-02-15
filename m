Return-Path: <netdev+bounces-72147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E49E856B66
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDA01F22217
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3594E1369A5;
	Thu, 15 Feb 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHVW2LIH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C8137C20
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019196; cv=none; b=ezNOLO9sfoNBC7r/L/RveEMUvCnpL4dGo+lHQB+3OT/3/9czfLPFiKKuuGBj5wjAAWPDLUHYszDtSPpydakcOoXZz2jZ5IDWHkZ4orXiIdqG5ER7uZ208j4Ge9aEYpNHRtc3uVogMUQ/0Lu70Y7y1iHqZd+nIp3hQMRuRSWcl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019196; c=relaxed/simple;
	bh=gP799Hw7NNkxb4OtI45g7vCZwtn/f/+WjXB46u2riWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqZH/Y6lCnz0gzsOGGZQJXHlEMUIwnFd7D0/2jTjh75NXNo5H0PBbpk9EFYBcqnC+4O1E0yJNF/UzaJ6B3e8gnocIv5sjp2xYzsOpMcd6SAudF8/sM4Zsy2NbRlR61ejWMiThNfDUv2L/4ZPm7lH/5CI/LpHig2pUWxXPWJiL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JHVW2LIH; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563dd5bd382so71a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 09:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708019192; x=1708623992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrbbgS5IFLC04j4ol7wixx3VoqSRukujNYOqeLy/Tj8=;
        b=JHVW2LIHAgQml2YcHHfBH2ivPdBHRGnl3n31WS96NM5TfaLyJdUWPfSriU0+Eyxe1Z
         qGgiiQM72lltRr5urvhsDVQeJ6Gav2AMRIZCCXl8YF4nInHYtCDpSiYX5FxVio3aUDC/
         uvYBveETyzvWWWwj3ldqetaIrWkwzSbm55L1646PTj81c2LEcTw3LBljcEhoHVdODJh9
         L24q4DAF6WOoFRcoTQBgNam63dORzrzkG2TcwUpnPvUnLZQLqWTSOJtA3N4IKy7sznMG
         bRkDOQg1Lr/laJLZKdM90To5ff1QsnXOyijVPOWHcub6f/4Ao8ECfQp2X1Dk3N0qBfvU
         38ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019192; x=1708623992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrbbgS5IFLC04j4ol7wixx3VoqSRukujNYOqeLy/Tj8=;
        b=GKhErled6pH+U6T3YdFEDHQqFXbOZUpSN/94KcQkii3FZP9g3xwgQfTVLSfDk5+rJ3
         0PWBU5PNx7drIRhL3O4BUeZpxcJbvV8QMcgdKK5hluEDgZ93JS1FL5IXYXb3b2n5mbR4
         3MZ8PH5QQcYwlOj5+T1TaIzx8P3iX+vJDClYuAzkI4SYr+hJ91sUyNrzdPuwsYhdlHMD
         JlCOderRKflnU0ee51fGp6iPFUjFwU1HQ/1S+LmpShSotQ7hq/lYTb3XxaqM5PZvhV/D
         LBlr2YJQOEyDNd8ngt5lInsifiVHYSIaYtmuPBuAxbTaSIMBTI3CYEwr9YlKAqWUAcp5
         6z7A==
X-Forwarded-Encrypted: i=1; AJvYcCWYtuXgrFvL0nM6I18itteTNXB2vmUy0jvy6kCdHoET7Z02O5JOu0vJmAgAPsj8xhWj7XoqGrHy2F2NJdywX4Rf4QQxGiYO
X-Gm-Message-State: AOJu0YygPlzGvxzP+JomPfYHDXcdTbI5UPGY1UAQF7nP2LUqVvMXxF7h
	08MtN84KcQtMTsWTzrSGFauK09rPxkPCLldGc71VIgcU4ZnoyrElE2mqbYMPSeO7HwE2QvTRh2f
	gMqC0c78i0in8tRXCernFJvnv5kkiNa+iOLaD
X-Google-Smtp-Source: AGHT+IGuia/mk6fNALuebkkgZMkpTELxRjyQnguWv9uSUuMGe5xGsAMLeMypQICyXEfv/RgEOaREduHcq6rWaBmJD0I=
X-Received: by 2002:a50:cd8c:0:b0:561:a93:49af with SMTP id
 p12-20020a50cd8c000000b005610a9349afmr5724edi.7.1708019192439; Thu, 15 Feb
 2024 09:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209221233.3150253-1-jmaloy@redhat.com> <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
 <725a92b4813242549f2316e6682d3312b5e658d8.camel@redhat.com>
 <CANn89i+bc=OqkwpHy0F_FDSKCM7Hxr7p2hvxd3Fg7Z+TriPNTA@mail.gmail.com>
 <20687849-ec5c-9ce5-0a18-cc80f5b64816@redhat.com> <178b9f2dbb3c56fcfef46a97ea395bdd13ebfb59.camel@redhat.com>
In-Reply-To: <178b9f2dbb3c56fcfef46a97ea395bdd13ebfb59.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Feb 2024 18:46:18 +0100
Message-ID: <CANn89iKXOZdT7_ww_Jytm4wMoXAe0=pqX+M_iVpNGaHqe_9o4Q@mail.gmail.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jon Maloy <jmaloy@redhat.com>, kuba@kernel.org, passt-dev@passt.top, 
	sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com, 
	netdev@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:41=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Note: please send text-only email to netdev.
>
> On Thu, 2024-02-15 at 10:11 -0500, Jon Maloy wrote:
> > I wonder if the following could be acceptable:
> >
> >  if (flags & MSG_PEEK)
> >         sk_peek_offset_fwd(sk, used);
> >  else if (peek_offset > 0)
> >        sk_peek_offset_bwd(sk, used);
> >
> >  peek_offset is already present in the data cache, and if it has the va=
lue
> >  zero it means either that that sk->sk_peek_off is unused (-1) or actua=
lly is zero.
> >  Either way, no rewind is needed in that case.
>
> I agree the above should avoid touching cold cachelines in the
> fastpath, and looks functionally correct to me.
>
> The last word is up to Eric :)
>

An actual patch seems needed.

In the current form, local variable peek_offset is 0 when !MSG_PEEK.

So the "else if (peek_offset > 0)" would always be false.

