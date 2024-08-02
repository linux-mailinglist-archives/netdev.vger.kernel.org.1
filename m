Return-Path: <netdev+bounces-115396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DA19462B3
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 19:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6B31C20AC5
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CF51AE023;
	Fri,  2 Aug 2024 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQQKQQRx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271821AE024
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620630; cv=none; b=P7wXJUVl+20uUf9aNyGTZHrVhxosOGUqNyERn1lJD8UGZzfGsgYKcL8rnyZjN6eWcWeUR+SuC0n12GB55oCFhdAQAaBU0VVB0wjKpuAU909QOxV/BFqNAOmrc8ma2w+qJtYc8WjwAcoGi3wA78u2tHMcJM1X8CZZWfry4IOq6HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620630; c=relaxed/simple;
	bh=QC2hbCCMVxlPpFDNFEw4sECI2USp4mx8vVQfabPaVgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A05ur5+zM9vymppTvq4cxJ0mWIzgoWg9Nv4+2Mvj2NuzFmfb3b8C+COPE2J/h6RIw8zQ1SnWXvB1WvWiNTwuvDeEjkaxCm/MGZMdBvYZTZu/CJR+kbzsjBBy/7KuZ3CwMEp9RceNv72fddBrbv2cj1cNbkrvXVFbx4LAAqDCdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQQKQQRx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so1021585a12.2
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722620627; x=1723225427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec1bYTg1bnLZQJIeD1SL2fp09wnpy6Scrn+EDo5bQFM=;
        b=TQQKQQRxVQbVZixezQ+3W+MVShR3XExRBRK7IXh3TiUKgWQK3ObWRq+s5iGuzkPTjr
         Sy9E6CBm/b/XE8I61DVAAd2+BJbDHZeDgstW3UsjMfyJJOGbA+CtfecfEuGBKdbOCAjp
         aL4OPFnP0ft79RfTFjXY9UtcSs44XcvlNBPKRQPD2/ISjfQ/eXDIQR84j4/RVFqDxjDP
         6svt5ZaTjLIQLACQkHeaBksppHnzKmlTz2DvQA5K1pI0szNKtp2NWEXPoxGBsfysCaLL
         fU11tHXOAkPY+B0MQbT0L/zdej1Dfc/QMNCp3rp4U2vZa9EH1VUtuqHstC3LQn/c3NpX
         uUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722620627; x=1723225427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec1bYTg1bnLZQJIeD1SL2fp09wnpy6Scrn+EDo5bQFM=;
        b=pLpxhBrrP7OqHYfZsU7mPmWAzqSzxW3ub0zbP+XPVODNgGN50Daq1Mqau0X1Plg257
         RKpuryyHU6zqNAYzz7dOgCT7QrLAFjrw030QuV8R7O6mfF8DXeJ64WsTrq+obhNshq5F
         Ye6iFqO9PDSVYkShKGDDwOSXMI710y2DGemJeHobu73C2Vp/PwF+SzdJW2vx3nk1qdLJ
         4uPrXdDe8Zf9xYuqlXkI5JwQaGILT/H/DsH+/DL+PgcAw11eLj1hmAoWfQp8Vcx9QtG/
         qOzCD2Dv2wTMZ+xVN0BVLQEuhq3ffcYKl397Nrb+DBrd756E8wuKA5o8hLR1kDKnpOii
         ITZw==
X-Forwarded-Encrypted: i=1; AJvYcCXbWcyw5PgOjORFuVfGaG3OxoknD4WvuefzkAmtLgbAWGHm8/E11JX8TUZeyxICltQBKXIduqrJT/lWpZhgVutDG1caPCS+
X-Gm-Message-State: AOJu0Yx9zkyAgISc62DtUY2famLhIG/UjavhEBVfYS9Adycq+pKmlH0x
	8vJWgX9IjX97ti+yBgWAztgVIeXQ5DF7ipNIVl7zbY+I+xvANd4oZWrcs+v/J1pZLsq6lBGf2xb
	pWiAqq3QNCizDAIjCCHg6phZ0pkI=
X-Google-Smtp-Source: AGHT+IE5UAoR83ImNhZbRBbWSUz9lYEkiRHOr5+oty/Hjg4A6e2gjgDpZmhMtpwG4XrFXO3skqJQK/JGn62x9/9sjDo=
X-Received: by 2002:a05:6402:5254:b0:5b8:d362:3f46 with SMTP id
 4fb4d7f45d1cf-5b8d362414bmr1787044a12.35.1722620627059; Fri, 02 Aug 2024
 10:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802102112.9199-1-kerneljasonxing@gmail.com> <20240802083012.062e2c0e@kernel.org>
In-Reply-To: <20240802083012.062e2c0e@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 3 Aug 2024 01:43:07 +0800
Message-ID: <CAL+tcoBRTctayHNc8x1psjXyt4FYDTqqNtmbZz8vApYsmTqBAQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/7] tcp: completely support active reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 11:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri,  2 Aug 2024 18:21:05 +0800 Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This time the patch series finally covers all the cases in the active
> > reset logic. After this, we can know the related exact reason(s).
>
> What happened to waiting 24h before posting the next version? :|

Ah, sorry, I didn't calculate the accurate time, but I can make sure
next time I will wait much longer and obey the rules.

> --
> pv-bot: 24h

