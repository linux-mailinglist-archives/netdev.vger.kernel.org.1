Return-Path: <netdev+bounces-108616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3173D9249A9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE78B21A5A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 21:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC021BD01D;
	Tue,  2 Jul 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d47iLZ58"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1482886
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954021; cv=none; b=hCeA/7TIJQyFnEWuBbRGqzFrM9WkrdD026dB27l5mDUoZQu2Nlb177nbiHViSL3idi0rBx2Udhu3Gm92zjdJRfXvQcYxwbfY26cG3K6h4G/JhYUydIDziBXSJ3tQJU1B421xsyCGP3dFwDQkIwlGWSeSarZfggLsXzj7Y2fxyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954021; c=relaxed/simple;
	bh=bhmgdmXou6VIgHHcOK/jYNGwjYxbFMXulVA914qAwhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAOhr/zQa07+a9ScVtHoH362YtJ5bpLeSeh1QxkgW5XW99XPOHnqgqA4qXCp+Rx/je9AA9WpPApJWPAHhuyRq1/7sDfP61SdLgT4o9NXVgGhIF7EXHHkKOpw0k20klKKUym5BxwOT9a6ZpCgPigOftKYW2RocimjU1OJb30cIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d47iLZ58; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3651ee582cfso2637573f8f.2
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719954018; x=1720558818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7goz2jzLE6WQPWSuKrAMxR08D3RSpD1MEzXtxQ4iFvg=;
        b=d47iLZ58wgwiKYuPQ17WSZ6mfLs/vEOi1wR+j2WyikPjwri4+WBw9s8u/VRnG84is2
         JbVm35uoFhkdgmtzFn4iSIorpLqQCNBolMWVtbui+xjBSQBjNzZoNHMg7LBG4LdAy47A
         j7bOUqtW5Eu6+0tY1ROkpgOXT4zi9VUlhyOsCA2nWAXuzKjt/B6Vy1BjkxdGjA7Pb8RM
         7TSs+kogze4aJNYhbVYQzjSGq3dZAX1Z/UX3fS6RcA250Bc9LN/sxNsc8hYcsQdknRKE
         Cn5Xqg2ZX8TwHNz2Agb9VRu/0OS2+crw0Dsb8nA5jGTTDTRuKb7rY4Gf2lRTNZ9eG0N3
         ZoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954018; x=1720558818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7goz2jzLE6WQPWSuKrAMxR08D3RSpD1MEzXtxQ4iFvg=;
        b=LL8tmCgmrxpeS1iGfZqIuGxyH/q+AU1jINHc2YB93s0k0OfchjVVa7iEf44TM+Gsqc
         o/MB5Plf1eW1VvG/LMq9fMEvuy+CjxurEsANcfqMafGSAobhwVySMhDTabxWT3EZPgCF
         O1ZVrrN6rP4DfaDFBX7TLzdtab2TxeuVvaBH68VwxvjgzH4gcLMuFctyKNuxAKgfZx4K
         lpJht6LlKwX4tPcSX9zu2uSfMVk2DI4VtafMalSj5q82eCip07R6YNWqN0zSPeY5bMRq
         4njzc5w926HAy67L7J08CTYUsc3+68jxeCn7XutnOqvyBxtKVE/etgVK1fG4mwBZs224
         WxWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/brnmXPamE80iElkwfwyDSKDGd/csX74GWTws7Aw49SsfGR8sz5GuWSFhgVN4wkKpob5KVVdigkPhmcMCQUzMtYINWaTD
X-Gm-Message-State: AOJu0YyyMoZXU5w/a6DRy3Xho8VYcv0RMWHjFXyBs4frSEFTt2nNNvNg
	s1FP9nI1/ey7FE/vUYI1UzW+GrO00TBstq8iK54Sn1hYFfhE9u9gM1Verf/l+GppojvtMS/zJSJ
	3efjcQUDbhcm85uVtzBavAUF3MtM=
X-Google-Smtp-Source: AGHT+IEyuRXxqaGeOjyAneHpt93s595/zTnq1ERoJXXxppkRzAupFv8JvYqPl4fPZLiQ/dUvueG00ggT2sgTavuvF8g=
X-Received: by 2002:a5d:64cc:0:b0:367:8f84:ee1d with SMTP id
 ffacd0b85a97d-3678f84ef1fmr996221f8f.8.1719954018153; Tue, 02 Jul 2024
 14:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
 <171993242260.3697648.17293962511485193331.stgit@ahduyck-xeon-server.home.arpa>
 <ZoQ3LlZZ47AJ5fnL@shell.armlinux.org.uk> <CAKgT0UcPExnW2jcZ9pAs0D65gXTU89jPEoCpsGVVT=FAW616Vg@mail.gmail.com>
 <281cdc6a-635f-499d-a312-9c7d8bb949f1@lunn.ch> <CAKgT0UcAYxnKkCSk7a3EKv6GzZn51Xfrd2Yr0yjcC2_=tk9ZQA@mail.gmail.com>
 <e7527f49-60a2-4e64-a93b-c72ad2cc4879@lunn.ch>
In-Reply-To: <e7527f49-60a2-4e64-a93b-c72ad2cc4879@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 2 Jul 2024 13:59:41 -0700
Message-ID: <CAKgT0UfbUrVR6U-cbNxufQ0MN9Cna0tdC6dPMBJRAHSdj5=C8Q@mail.gmail.com>
Subject: Re: [net-next PATCH v3 11/15] eth: fbnic: Add link detection
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 1:37=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > As for multiple PCS for one connection, is this common, or special to
> > > your hardware?
> >
> > I would think it is common. Basically once you get over 10G you start
> > seeing all these XXXXXbase[CDKLS]R[248] speeds advertised and usually
> > the 2/4/8 represents the number of lanes being used. I would think
> > most hardware probably has a PCS block per lane as they can be
> > configured separately and in our case anyway you can use just the one
> > lane mode and then you only need to setup 1 lane, or you can use the 2
> > lane mode and you need to setup 2.
> >
> > Some of our logic is merged like I mentioned though so maybe it would
> > make more sense to just merge the lanes. Anyway I guess I can start
> > working on that code for the next patch set. I will look at what I
> > need to do to extend the logic. For now I might be able to get by with
> > just dropping support for 50R1 since that isn't currently being used
> > as a default.
>
> So maybe a dumb question. How does negotiation work? Just one performs
> negotiation? They all do, and if you get different results you declare
> the link broken? First one to complete wins? Or even, you can
> configure each lane to use different negotiation parameters...
>
>     Andrew

My understanding is that auto negotiation is done at 10G or 25G so
that is with only one PCS link enabled if I am not mistaken.

Admittedly we haven't done the autoneg code yet so I can't say for
certain. I know the hardware was tested with the driver handling the
link after the fact, but I don't have the code in the driver for
handling the autoneg yet since we don't use that in our datacenter.

- Alex

