Return-Path: <netdev+bounces-87128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEBC8A1D24
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776C32848E2
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EF81CAE8E;
	Thu, 11 Apr 2024 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nadCtn/V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D048C446A2
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854122; cv=none; b=ZkB8GV7BG28RtNk/SftZn3gblsxP4kxvTmoZnJrams7iaWnhl+QQjsOtJKHw/k/7VArlNfP3u2uISgbrmJ4WyTKscJ8ZBzfPesxBOIWZ3lY0iSSfDI+TxY2lQi/82R69XSn12pZaSH0oxpsHf3XEr5aOzKitqyY4ZQ8R/0A3YzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854122; c=relaxed/simple;
	bh=2u8/BVLR0+6SADxB8m5uoRKPBtfkno7FHbjqUZr8zCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omKF59h+3gGGbciHYfvX3N2zWLcIWP0Ruj5EjKJJ/qDMC7Szltf0tQ8E6Ef/wSBGZY2GwEsOvOjWN8YDOP/Vd5hFNJYLjOQuPFZGeX9lzx7JbHaYqusFf/INa2n5JD/z42BhCp2139mhMhe9BsKy+85nGP+na9IDvRTZDhgfE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nadCtn/V; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed2dbf3c92so46336b3a.2
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712854120; x=1713458920; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hbUZVB9qFkHUH+TrArd+qSwKs0Y6WGXbLzrLWrHSOWY=;
        b=nadCtn/Vn5ThmZq38foo0X2eUNc18fnReG3t3oG3gHSlq0PSeumdH0SrPOLwPfRCHo
         gqYK8h0IXJyhZMZU5ugjyffJ9QHjd86nMOFxGv5lsd6dEtiJthl36tyf4nS6JJCAHZ70
         oBYK2rLQ+Ncjqtw5tnUaxhq93y4qB4OgQKzOoMo8Xiu+kYDNab8xW6i+JwbV3uMLXGbG
         nXzPNJ62GbgrpFBWGpcPeEYXyF+4RCKLE6fArkHpNMMv5b1EzZDpwAAaZz5A3dGzRwao
         mKZD6+6fYoYvpCWepG0u7oLU2aoCL3rwJMdJtzih1TVo2szeTsRz8oVyVSQQ3XEo79eQ
         hARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712854120; x=1713458920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbUZVB9qFkHUH+TrArd+qSwKs0Y6WGXbLzrLWrHSOWY=;
        b=WAPgI4rDbufdFKSswNz6uMTd6qq/xdFb/I8AySe04MFataYTUjhqOBtCh3DXwgZOBj
         lP9lPWqfVSjXBnUQU6Kdj38xjl4GS8rWiIUrJ1YN3oFr3/kU73XQFM65rbhB3s/KzA4x
         mZpAbJJqzWIhgWhOriy2BxRSLIohJfn1tyRs84QTQD0QZeEfyzxC01dNl1qjX4g30gHL
         5vUM2ZoC0CEZ3Tv1YoCt30Pa52UK1N20CfAtPAvNirJhBCT5CHSmakowlpNIsPejLY8O
         qeq1MqOOfNdmB+DQSd6hCjf3PF2wDxG44XVzsHiogh56M03TB43t/8o4aCHPlP4YcCFB
         e6Pw==
X-Gm-Message-State: AOJu0Ywp3uO4cemNsKkIs8OKVIfG5Hbcv7DSjcGSUxlOnG16tabJQlY6
	kLaJb9lHUVZTnOw89fdL0yQbl3znsX0LGpAFbgxcqMI1ssLm0o0C7Y1i0qCBGBjR/CTgug1tSFV
	ORSttfarfTjQ5fpk2jHkrgDKkOpkIS+4z
X-Google-Smtp-Source: AGHT+IHfOGLkiHAPnqr/WU+w/dWL5LsEYTkbqPit6GBkF7wMRFR9VnVO4hHoaEKaWzXEfy3T2mWXCZT3u/34QojNDVE=
X-Received: by 2002:a05:6a21:9997:b0:1a7:a86a:1132 with SMTP id
 ve23-20020a056a21999700b001a7a86a1132mr483689pzb.13.1712854120012; Thu, 11
 Apr 2024 09:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325064745.62cd38b3@kernel.org> <CAJwJo6ZQAEb6v4S_BgPqZv8W5W0hizvxyzv0K_M7domgOwTEJg@mail.gmail.com>
 <20240411083629.3eb2fc22@kernel.org>
In-Reply-To: <20240411083629.3eb2fc22@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 11 Apr 2024 17:48:28 +0100
Message-ID: <CAJwJo6YzsQemFCKyK0mmniv5ygGDLWJ_UrE9Aak40SYMTojXsQ@mail.gmail.com>
Subject: Re: [TEST] TCP-AO got a bit more flaky
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 16:36, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 25 Mar 2024 14:16:04 +0000 Dmitry Safonov wrote:
> > > the changes in the timer subsystem Linus pulled for 6.9 made some of
> > > the TCP AO tests significantly more flaky.
> > >
> > > We pulled them in on March 12th, the failures prior to that are legit:
> > > https://netdev.bots.linux.dev/flakes.html?br-cnt=184&min-flip=0&pw-n=n&tn-needle=tcp-ao
> > >
> > > PTAL whenever you have some spare cycles.
> >
> > Certainly, will do this week, thanks for pinging!
>
> Hi Dmitry! Do you have any spare cycles to spend on this?
> It's the main source of noise for us. It's not a huge deal
> but if you're busy I'd like to disable the rst-ipv* tests, at least.

Hi Jakub, thanks for pinging.

I have a patch that addresses one of the issues I saw on these tests
and currently working on another patch. I suggest we disable rst-ipv*
tests on Monday if I don't finish the patch set by Monday.

Thanks and excuses for the delay: my work laptop was running linux
and that was not fitting into corporate policy of having enterprise
spy software. So, I had to urgently find a new machine for
contributing and sending patches.

-- 
             Dmitry

