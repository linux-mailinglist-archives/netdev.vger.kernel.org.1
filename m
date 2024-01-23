Return-Path: <netdev+bounces-65256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872FE839C47
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 23:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDC61F2525E
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90C652F99;
	Tue, 23 Jan 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC5ET/ik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68552F96
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049064; cv=none; b=cmep0DBrcp6lygdOMLCuuufrsmwo+0iG3jEjQs4u5sxGSsi/sk7nqnka2WBfbxYIoO9sbQHNlb7UZ0qFujEYiyGW/R4PT3lr/o0dspX2bVbcTS7zVhOAXjTc07+R9WCpvMvmQO5o3nHU7f6zgBVxs/cXCPfWHy1o1IH40HWXkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049064; c=relaxed/simple;
	bh=27QrjbCFYQxgIz+71cK5tFlYHtqHL/9WUIR3zagfShg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWp8e8AT/Ai2rDWCq5MH1HCdV/+aCafLEcjoM6AvuMEwSFwy3poexOQgbwUZ2/isxNRcszklov2Iiqt+4Wkmm5EoyPOVfQiQZWmQYJ/E6LtnFkdrN+HeXQIwVH8rlaXIWT6MWnwESlTVZLF3tU4Z9NHOzj51Fs3vTda+TLyvr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC5ET/ik; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51008c86ecbso1325124e87.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 14:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706049061; x=1706653861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=27QrjbCFYQxgIz+71cK5tFlYHtqHL/9WUIR3zagfShg=;
        b=kC5ET/ikuPcs1SDu4QSCADNXFK8NTAStlNpn5/Wjulu2650vTrHRX6MMklFJ3OPbAR
         IoAN9qUCKtC68DrT0FNPGMbrWP5v4iydcgR0ce/Ujzn1R4K1oXZ42RYEKaOccptl6Jt+
         zSz7ssP5cNjoLFTOcNtK+FHT04l6KhNUxX0Jqb1ApoDEsHD1XbgkDbofokjri9gDdKqA
         GQvSRZ7f151DEw0gJ7r0coDjH4o9sSgem7TPXp/LyXUUs9om2k91jdTD1rNqBsjXFJgL
         cQcrkAqLIqGCl10hROVtwBNaAcFfnO6xxJ0rTN58wzU2fKzURct/hqle0wD74WXD6bu7
         T6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049061; x=1706653861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27QrjbCFYQxgIz+71cK5tFlYHtqHL/9WUIR3zagfShg=;
        b=gx3N7dpikPLRxYHuE83daYRsTVY5ML1zbZhoH9zJ+2UU20dRia2PSqJfi3vKcWLGB0
         MGKPPd1pBk3Nl0hnNXVESq46yFdEZYcUkgbobwSi6KYUAJey53AKTv5ZAjzFEvdq6jyG
         e9vqPOOixMOCLkxzjsKn9fLfgra1R6eywWR2FGKDsgxk4QUUbkLkiwDE4LJSeL9JdN/z
         dWrUN1fI9zERb2LaJ6jrf7baA40Fey7xBMmUdgcAaqNWvkfCOHwMI/Svtmt3jf6AKrv6
         ZspkAc1MpB2E9pZ8Yla6IQb9OtrEKoU57gCtJCdBechMznAF8oucV0VdN1lzicOIEKF0
         Ncmw==
X-Gm-Message-State: AOJu0Yz6Xa9UV22VRbZuoo6kKGuaIonMeH08gBGok25h24XYftNOuzXf
	Fkvd+jqorZXVPxFnnw/mTJoPRWpvUTp/WlD5bbCCaarUlfu5i2Gzxuqhpjyy1s4E6ikpO55bk4y
	MzmLWcsipSoOAVwZ2IFkKf3WKgT4=
X-Google-Smtp-Source: AGHT+IEaIOVT/lNO4rT9Pmbd+hQPDmPyxNUYIiDMGMsWSLsPVq+P3EiHdXdqBd835aSi/MvUJ4KVsXya5WDf3SmGGZs=
X-Received: by 2002:a05:6512:3cc:b0:50e:b65b:4944 with SMTP id
 w12-20020a05651203cc00b0050eb65b4944mr2646924lfp.21.1706049060549; Tue, 23
 Jan 2024 14:31:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123214420.25716-1-luizluca@gmail.com> <CAJq09z4H5TmOq4tM1RifGrVQPrSs57dR7yCv=1+gnxZadFobbA@mail.gmail.com>
 <CACRpkda=zELXRSvXT98FiQh8jv9xJ3HU_Rn9iJLGzgBWmNeb+g@mail.gmail.com>
In-Reply-To: <CACRpkda=zELXRSvXT98FiQh8jv9xJ3HU_Rn9iJLGzgBWmNeb+g@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 23 Jan 2024 19:30:48 -0300
Message-ID: <CAJq09z4WBqURH8YaLW=nqW0mOFLJubss5v6x4_xJuV9do0uDHg@mail.gmail.com>
Subject: Re: [PATCH 00/11] net: dsa: realtek: variants to drivers, interfaces
 to a common module
To: Linus Walleij <linus.walleij@linaro.org>
Cc: netdev@vger.kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Why not check out the "b4" tool? It helps with this kind of
> stuff.
> https://lore.kernel.org/netdev/CACRpkdaXV=P7NZZpS8YC67eQ2BDvR+oMzgJcjJ+GW9vFhy+3iQ@mail.gmail.com/
>
> It's not very magical, from v4 I would create a new branch:
> b4 prep -n rtl83xx -f v6.8-rc1
> b4 prep --force-version 5
> b4 prep --set-prefixes net-next
> b4 prep --edit cover
> <insert contents of patch 0/11 cover letter>
> then cherry pick the 11 patches on top of that branch
> and next time you b4 send it, it will pop out as v5.
>
> OK I know it's a bit of threshold but the b4 threshold is
> really low.
>
> Yours,
> Linus Walleij

Thanks Linus,

It definitely looks nice and it was already on my TODO list. I'll try
that in the next round. I just need to test it a little bit more.
That's why I used my old workflow this time.

Regards,

Luiz

