Return-Path: <netdev+bounces-79385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D512878E44
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 06:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65F41C20CD3
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 05:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9883A17745;
	Tue, 12 Mar 2024 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go6ol9IS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E2210A12
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 05:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710222377; cv=none; b=dcyKwwK4M43nf9uxNzF9gpoT1/5mxwI3J8kNoXxxskuf0OyqkrmYwxYtL68Qkk9Z3sNkU5a1ggJsdCpP3LCbzSXu+81co0cKOql4rp2momTAAVD80JKhLmsaiDhQXG1/tK1QSCHVrRujh1MKC+rRTNw6sR6onmoBoOd5ZQzCVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710222377; c=relaxed/simple;
	bh=SWe/ZRKTnHrcb0NunZNgjCeofNd2eXZXSFJ4P+ha30w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrJ3B5wkKnYVvnHBIQTHEhMLKRL/AZSh9gqerHk/43wSxeRFCAmfkWLrlIwDbZJsnWOhEuU+/RIn+mDaTH9VPl44NEwYSQKZ3Rm3eM4LEvZExU7a5cJphTZ17fdLzP9nLr4oqm6GFtpVuZb2DFxc6OlP+M58QQPSVOmJTppWO38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=go6ol9IS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d4541bf57eso3326241fa.2
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 22:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710222374; x=1710827174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4A7vDAxUsFHd25HLfMWuG7HgWuiuklxJSNpcXP21YU=;
        b=go6ol9ISr2ZWQZCsPkwIHV2QVmxLCLYbp6Q2fHLJ3JrBklpbBmMKJxgs7dUdPia5lh
         VG8svUy42VgUVPWV7llNeg6iMCTvplmmc1Fd7VKiGiIi3EkN4txSasoQQ52DgcrMrQO8
         RLn0hLLnswZLXQUzSEFE8BcAfVpVjUEjeJ1EKDo5GrSTHWmYgU6HQJaCsHHA4CRSGBWE
         UEzFdrntLIHmOxrm5AlvjubzJ6COtCwq1mBRFbwIK3+rOIZVGY2cixHLMb9YctDarqjo
         c5okOWlz9sM/hZfXYQQOjd47YYOaDPbFRz16bQWfC4vBQqvKeV+MNGNF3Ajoi+jTnNL5
         R/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710222374; x=1710827174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4A7vDAxUsFHd25HLfMWuG7HgWuiuklxJSNpcXP21YU=;
        b=EgeM8JRiMmYLaWwlKl6frfaxEQb92BkaPNABvYQjBEeskjrj0Pr8z2IKLAVHTrxbwz
         lpsrds2cXZZ0xBZ2DEDwc73vu1sPPWUC7YyUffVpRYht1pctvno4v3wGTJePwiaSbfk2
         /hmd2iOCOxBNdrLTuwA0F9bR4e5URBJO203Kl4NEXRHMJR3Tpfsgy2pXEHeM8KTfIdnc
         MpxmgsdXoED2tsCxNQzoRcDaODdkPIMKPcs5k8Ao663RVrAFtoH1w4UyvaHwbiqGZwqd
         lVZbMAkAW8Rd5xpH7ltXBQkBEDQKhtmFOogUELOB+r/M8huJuhGxORbWz4qqVDfTCTNc
         yfsQ==
X-Gm-Message-State: AOJu0YwoTF6LVy778gITuChGuj4uue+ykj9u63LbpCASUX7PGcf91MEs
	XBTeEeygPla1G6RnXVzHbEDo2nnzmfZLQlYfI2YgxJXQjpQPFUVg7pV90xb5PgdbsWWptRDFSQ0
	nbSwrTDi+Wf4Z2xLPwgEso0MW6y9tKziCaa4=
X-Google-Smtp-Source: AGHT+IGjrKYhZYq9qOKpakTocdF7IMInvlX/yqatA1ANuIot9rOMXmu7yzozJNFTABCN7EVAkEjF19R417OeC5KrWFs=
X-Received: by 2002:a05:651c:2325:b0:2d2:7a4e:f5ec with SMTP id
 bi37-20020a05651c232500b002d27a4ef5ecmr4534286ljb.7.1710222373795; Mon, 11
 Mar 2024 22:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF6A85__pPB_K1iuzVSrKXd+AWXkO4NDYBWbeDfGJEphvvuzzQ@mail.gmail.com>
 <ec033a36-c352-43c9-b769-41252ff18521@lunn.ch>
In-Reply-To: <ec033a36-c352-43c9-b769-41252ff18521@lunn.ch>
From: mahendra <mahendra.sp1812@gmail.com>
Date: Tue, 12 Mar 2024 11:16:02 +0530
Message-ID: <CAF6A85_31JO3-9UxYb=AqDW98bVgqhTufN3mUYtgtKuoyWNB2A@mail.gmail.com>
Subject: Re: USGV6 test v6LC.2.2.23: Processing Router Advertisement failure
 on version 5.10
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew, All,

Update on this:
We used 6.7.6 and the test case passed. However it failed in the 6.1 versio=
n.
So from our testing, a change between 6.2 and 6.7.6 has fixed the issue.
Looking at the change log, there are many commits and also related to
IPv6 and it would be difficult to determine a specific commit that has
addressed this issue.

Could someone please help if you know the commit details that might
have fixed it?

Thanks
Mahendra

On Tue, Feb 6, 2024 at 9:03=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Feb 06, 2024 at 02:06:17PM +0530, mahendra wrote:
> > Hi Everyone,
> >
> > We are executing IPv6 Ready Core Protocols Test Specification for
> > Linux kernel 5.10.201 for USGv6 certification.
>
> Do you see the same problem with 6.8-rc3, or net-next? Your first step
> should be to determine if the problem has already been fixed and the
> fix just needs back porting.
>
>      Andrew

