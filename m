Return-Path: <netdev+bounces-222646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0014FB5540F
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B602AE4D69
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5FA25CC63;
	Fri, 12 Sep 2025 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jV9MPGx+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07AA24C077
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692103; cv=none; b=TQt9V1mkr93w7YwLE5YT5gPlVzA8cXsP5csYq5Bg6KBgYVJx8ogUAPl4k+99XssjAi9ZVnvbKUvO/xRq22wpNGYNc7fBH6E8+/wlGts5NFTCyhUF5h0RWQ6mXYGvfWXO2PnHdz4Al/x9gXeudLJl7Cpa/7T5Q+yoJ8OJ/EKSZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692103; c=relaxed/simple;
	bh=RbLzZXUDKdtoMOxlK5YmFgxc0BfVDgobSDrwaYWN4pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhFQ9wQeMldPqieeWS1fgdY4rZNlnqbj6McfYyASbLlEz47dE59AY7LjeR2Gk5qBbpoKmH3A8FbbLlY4wsQoXo8D4CaDs5UJz3b5VOuODRsSpqixMeRKquBEiDSDlq2XOqabkI69DNJpVRwqygSJSl9y5VY+foimBzKwjIwSRKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=jV9MPGx+; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ea3e8290621so431692276.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1757692101; x=1758296901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfbgGBBMYGg68oCj5G3EZlHrGq2oPkM1jjFJ+fAhFNQ=;
        b=jV9MPGx+bLGCep6ktiQ8Z/xCte8qOvPctx8YNMBxA/BE6QF/P2GbALo6Ttq966F8e8
         ztP2knEciIn5ehNavXz1Ibm/xPI4pP95KoVJUDxUEK6i+vOHuWQUN/fwtZEaZ39cu0ed
         gn/A1+EpBLO49gOLxS9UzB1M4PhBF6ltl/vea85R3XDftSe7LRsc6QSbztPM5MwZD/rO
         0FMMo3knjW2EN4co2ZZ/nqoP381VgnYijkxoQ0KJC4XWsrOx1gVktAA3UjY/EGPd49HW
         +Rn8jVLdlijxXynFTVEK20zMoXa/JCYtVJJC1lKgCteKHGl/gMKh0q3kG6mU8Md7MyIb
         in5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692101; x=1758296901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfbgGBBMYGg68oCj5G3EZlHrGq2oPkM1jjFJ+fAhFNQ=;
        b=glnCSwVpDd6BBDE3BgXoaJkN+iI97FiZ/3Zqj0JzmTx5R7VscX5KlkaWYmb/oEq7S4
         vesnl7LehURHxw8cHm9W8xjG0E2GBoqtQqVVlQGdGwMrX88HIawiEGQvKgDxSh1mjC1p
         8qaI+FsRUo9q0XCUxaOktdQ07maw3uchYLaJR0+XOzIavG8ReHZ4V/nn9ikCD20tQtJt
         21SPgb1Gh7E6I2/as9TofrlZVSULaewTXn/Pv9e35SAkr2Aotob4nzqmY1rKHNehjh4t
         kmSYNQslRVW89oE3prNEbvOZx9qxaqjram2yBTa5axPDFh9JXAXUw56CAF0Oq7+RzoZl
         BzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDqABoYloKoAAUC0QBcQyvpLRNZpRbY1xR+9AjRs3dbBvmJGrkhqnMvOt3i42ENCqRASeZAq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJuGu4qwSaIqVAh2m1DlHVX90NPPLllXRSYg0TMZG/wrFLzFF
	5tF2vdJFzwSxhqOZHrNGuzOb71TQCtR9FPamAOLTgOB/QyeieuVW6bv3P+rqK3aQZx0zS59QOzx
	/kdRMSEUxMCsVyKOMdsiGshjWS7dGqBGS3oDlhqUI
X-Gm-Gg: ASbGnctCBHKUVQ4IUWStLOfyVHztwcXyY6FLTay3s+YC78imRBSPuyRYeM7ZYO37Rsq
	N5sm7aJ4x1NpdGyGqrs8XptIFIijhY5LgwnFYEtvlOaxs8uSarDSKQf3thbMTPh2VuVeo/JWrzj
	6bmLgXUSbGfD8+m84SFV/PZovDBy+4vG5u9dSncvqdr4Bp8geH6IdbEmkyu8IJNLwXObIa/Ene7
	5NriYFuP/rzk9IVD6ow3iQ+KSSiEXIQCl3SNebhnZ+s3YY0Ow==
X-Google-Smtp-Source: AGHT+IF6Q/GqYPARlPKW+chzw2SxMAw2OXtjxX/NKdJ5PJVQiou486iHGOfk5/JdejTWQ/ejlX/XAPPIhQNvWDW9uOA=
X-Received: by 2002:a05:6902:4187:b0:e9d:6ab4:92ee with SMTP id
 3f1490d57ef6-ea3d98e86dbmr2712494276.3.1757692100762; Fri, 12 Sep 2025
 08:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
 <CAM0EoMmJaC3OAncWnUOkz6mn7BVXudnG1YKUYZomUkbVu8Zb+g@mail.gmail.com>
 <d5b7afbf-318a-49c8-9e40-bcb4b452201b@gmail.com> <3090258.1757650744@famine> <CAM0EoM=Q6ewcUbdM_GahUmubxvQeJWAwxPu+3hmC2U1KjPb5_Q@mail.gmail.com>
In-Reply-To: <CAM0EoM=Q6ewcUbdM_GahUmubxvQeJWAwxPu+3hmC2U1KjPb5_Q@mail.gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Fri, 12 Sep 2025 12:48:10 -0300
X-Gm-Features: Ac12FXzZ1dwkWRDiM8Yew_EFRmG58xuYhuc9TEo2QHjDAleMgHQLRu2R8dfradw
Message-ID: <CA+NMeC--TzdxWC=3mXT3+NJE_gSQ3D1htFGMo2HHZVC7pcxkYA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] tc/police: Allow 64 bit burst size
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>, David Ahern <dsahern@gmail.com>, 
	netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 11:31=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Fri, Sep 12, 2025 at 12:19=E2=80=AFAM Jay Vosburgh
> <jay.vosburgh@canonical.com> wrote:
> >
> > > [...]
> > >You say the change looks fine but at least one test fails meaning
> > >changes are requested?
> >
> >         Yes, I ran the tests and saw one failure, in the following:
> >
> >         "cmdUnderTest": "$TC actions add action police pkts_rate 1000 p=
kts_burst
> >  200 index 1",
> >         "expExitCode": "0",
> >         "verifyCmd": "$TC actions ls action police",
> >         "matchPattern": "action order [0-9]*:  police 0x1 rate 0bit bur=
st 0b mtu 4096Mb pkts_rate 1000 pkts_burst 200",
> >
> >         Which is trying to match a returned mtu value of "4096Mb" but
> > the new code prints "4Gb"; should be straightforward to change the test
> > to accept either returned value.
> > [...]
> >
>
> For backward compat we need to support both. IOW, if someone was using
> an older tc then a new kernel should work fine and not fail because of
> different output expected. @Victor Nogueira wanna take a crack at
> fixing the test? Then when the iproute side is merged as is - both
> should work.

Yes, I just sent a patch making the test work with both Mb and Gb [1].

[1] https://lore.kernel.org/netdev/20250912154616.67489-1-victor@mojatatu.c=
om/

cheers,
Victor

