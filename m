Return-Path: <netdev+bounces-104694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F10890E0EB
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AD3284963
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC746B8;
	Wed, 19 Jun 2024 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnFbezg3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41E17EF;
	Wed, 19 Jun 2024 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757230; cv=none; b=c1BcBLVnkrJ1Jo8w2KHFLnv2wSUv0kClC3MqdTwIogf5BBDfDH9VO19vY18q92AjpqCuZQbwtY1NLOTArQmWA9B6JbJzAXz6D/9ViPXsGek+mutTtgxP2CUBSry1wMbs2+Hv9qRW5e7/Yt0pFCjRIkZ5+WwKo1YQA1wLCMVg0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757230; c=relaxed/simple;
	bh=Pb4JLdo3gFJ13Pxjpue/v58Qm6It3L+i7PlV1jPrhpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYLwgFpvp3mgNYot+Bm0FZ8ZfOgVqfppIVcH29cUnZKl+NdzhovSrQzaPX+22XSm85NPfULKeJfypmIU4uLWxVdBttDm/oa/6YG880WPUMae2XSeRy/vGiPHIfjtVbsFOdfP9camQTWytvgkfGxC1rpXRXpUOQABT1FMY8dcUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnFbezg3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6e7b121be30so4275943a12.1;
        Tue, 18 Jun 2024 17:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718757228; x=1719362028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m3oiWOLJM7deLlkebaAqeiYHflxqleb3beiEGAOnNoM=;
        b=bnFbezg3URvkE8jxSKkzmLMqoISx9/kOQRDGwp+xKlUYwpl/9Bm/9x3ApCrRt1f476
         BMATGd4V6ef2N2t9kR4HzZjgINRjr3VLZnJX696wAg82HxmprAh5DfnXAfHSKyhvA66P
         M5wWcrpkHnueAIcFxbqovKgNs68zpTUJ9mLyeyVLF4Bb+uVcraS7CdqXrEak0Jislzbq
         pilzfmnrzv4OMeKspnRCP1wvxvUsFPmad2hWtfq8CiZ8fCOc0uN7xZ/oymHHG/TrNX1H
         ZPuQYgFouhOvj1oQZjuFWn3OLkxi22K0W2UwK/exsCy0N8bAURFSg4lNnQ2Fd7xGORZM
         0kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718757228; x=1719362028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3oiWOLJM7deLlkebaAqeiYHflxqleb3beiEGAOnNoM=;
        b=FG4YySFNV4InPoyaUWBMjHPmFYcedkvcHypVHttfa6GKe1h0rWf7kq/86hy6R37U5s
         tlVT27ZMjU68uG2YlW7DeDz8m59L8Baa6iPHIjWWbD9jfDNuSt8QVASE7RUMx8SldSl4
         PnH2EToKhpjrLG1x9Q4V0kkgBi9fm4yvbOGik1K+SFaXLaJaulSidb2jdBTHcLzXbrdw
         ndprEZExTSXwfztgkV+Kt4n6Qr0ukBKT8XqQWLLcxoOdxp4veEkjuzOnY6aFWtDvp0CW
         lgXuNn2KY063xm6OocMOxFrmZPytQJWmO41Z+yf1Fwa3FjXxAGd187/7Ae21cwZQkN3c
         S6pg==
X-Forwarded-Encrypted: i=1; AJvYcCXbRDxVdcPkDC8MXawkGvl1OiGYVEEv8WAZDpWCukT9FmWE8G5rmomH4ugI6wiD/MD/fhstap/P+GaguMjY5wvXR1Q5
X-Gm-Message-State: AOJu0YzdqHmfOSxxdv6ruZsrJ/bBOptGiGye7XoX/uGiLqsbS0b2EwcP
	oeSdFlzVkFOyinglB5CEdkk4E5iYp4GFh+UrXMuAF7kG1aZ3pXGq1ERFBvgNHOTP3zzhFbpvWkc
	N6uYIofWve8lSRyc58tbemet7JCv3b2D6Ucs=
X-Google-Smtp-Source: AGHT+IHgCni4TsELnzyc+2Y/+B1wgeI3+uSNCIft4AICm4nvetwMHcVM9cdEsRKiNFZWyy+BNMyNgCmArNLdLe3y9hE=
X-Received: by 2002:a05:6a20:8c15:b0:1af:d40a:7692 with SMTP id
 adf61e73a8af0-1bcbb655a4amr1045418637.42.1718757228476; Tue, 18 Jun 2024
 17:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617072451.1403e1d2@kernel.org> <CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
 <20240618074037.66789717@kernel.org> <fae8f7191d50797a435936d41f08df9c83a9d092.camel@redhat.com>
 <ee5a9d15-deaf-40c9-a559-bbc0f11fbe76@paulmck-laptop> <20240618100210.16c028e1@kernel.org>
 <53632733-ef55-496b-8980-27213da1ac05@paulmck-laptop>
In-Reply-To: <53632733-ef55-496b-8980-27213da1ac05@paulmck-laptop>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 19 Jun 2024 01:33:36 +0100
Message-ID: <CAJwJo6bnh_2=Bg7jajQ3qJAErMegDjp0F-aQP7yCENf_zBiTaw@mail.gmail.com>
Subject: Re: [TEST] TCP MD5 vs kmemleak
To: paulmck@kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Jun 2024 at 18:47, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Jun 18, 2024 at 10:02:10AM -0700, Jakub Kicinski wrote:
> > On Tue, 18 Jun 2024 09:42:35 -0700 Paul E. McKenney wrote:
[..]
> >
> > Dmitry mentioned this commit, too, but we use the same config for MPTCP
> > tests, and while we repro TCP AO failures quite frequently, mptcp
> > doesn't seem to have failed once.
[..]
> >
> > To be clear I think Dmitry was suspecting kfree_rcu(), he mentioned
> > call_rcu() as something he was expecting to have a similar issue but
> > it in fact appeared immune.
>
> Whew!!!  ;-)

I'm sorry guys, that was me being inadequate.
That's a real issue, rather than a false-positive:
https://lore.kernel.org/netdev/20240619-tcp-ao-required-leak-v1-1-6408f3c94247@gmail.com/

Thanks,
             Dmitry

