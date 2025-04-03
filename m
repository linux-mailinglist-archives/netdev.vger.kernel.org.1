Return-Path: <netdev+bounces-179163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FCAA7AFC0
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 22:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9780E3BB4B4
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 20:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A32264FB6;
	Thu,  3 Apr 2025 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNEQIhWh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EECB257434
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708783; cv=none; b=eqoiIlZx7fssTsYHnRkrDD/Bwk9/VS5VxJu0AYbPAgooz06iizKAGSS/regchi0p+o/1ZIV6TcOFn/90TZM4PElomOdIyM5hxn0UAYblEz1JPw2lm5OsKy6upHUl/wzpdJndP3njBbdcwsa8ViVhNMGicXbsjtblP7TYKg2ndqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708783; c=relaxed/simple;
	bh=3CgQkx8UWwaD7m8AIjs2T1Fy5H8UYRM2DMDxPk4fp1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzT25G4+ISpSDpkj+WEG2LT3b/78U/oiThTeFFxwi6fwBBaPqN/kGDzuN0+08hZmPbe0Pg5iWEq1IJJIKcBjK2qPO1obN/P8HeM3AU0fd1GYJ3CW07q+vfsZpa0pa/xgueu4uHUqAQW0cgp4Z2GpYoZ4z2TpnnHwb+dv01M4bno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNEQIhWh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2243803b776so19612135ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743708781; x=1744313581; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hBVGkwIN3bH1YdJRremHwWR90E2XpYOKI37roaIorwA=;
        b=PNEQIhWhsFaWMOEIUrsADvCBgFsn5tImzQp5oX9AGrY4WmLlQHB3tG3FVjkFYqEdYA
         pvB2zbOv6IZdLY6+5DMEbgzPtjOkL7SLKzRp20iLQFgfnqbBeydUFhJv7uU5fLbepaAI
         n+XXaK0g7KPq64oJZbZrUjmnPYD4ns3pqDjoNjoTix3w0E6I/2YwXE+wn6jWF8S/gz/t
         wsoUWbGRjPM+8be7SC5IcsaPweDHnhmEIgXnTc2CfrUNO3JQwav45eleMwDw+tclILu+
         v4jRQb/rlDzOOLve/2F1lIK6hm7M3RtUZqLnVsczpYw3voXuk0SA996r0fgTUfcCRZ+Y
         naIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743708781; x=1744313581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBVGkwIN3bH1YdJRremHwWR90E2XpYOKI37roaIorwA=;
        b=o+v64ng6QhYWsxyoF9K6fAExpZhP9mWV+lESBQjCegzdE1TwHw9u0ypMmsTA3ZZD2a
         Dt60nfJkbZ/SqYJWLXN3uvIA90qyzW2jpO1NbLe+c9+EvL6xOE40HytKHbBUZyK79nFi
         avAbF40IY5oDPTHAvVohF9KxG0NbcTDiJBYsGOjonTM2No5CArmXsJX3MyQ6zQqGIUww
         3xpLL7lSs9dfFtPsdEfyQRBP8ziNbEMf6BhG0UWTwTRsuDIAOMCDIFr7YmYVfTXCS85h
         lYX4B5f4NeTajf3/JwERwslwTLcNtwB3sfAXzzQnaA4UF9jb621nJKCCRPRK3BHRCrcu
         4JHQ==
X-Gm-Message-State: AOJu0Yyit+01M6i3RxU7grN5aab1uW2+zmJzj82PE/a9Ct866V8awwCn
	K2p7GkG6/IXNMdhZQaxuFemgcbVKAGP8OxxjsXurP1fWMeMXabXgmRj0AQ==
X-Gm-Gg: ASbGncsmH8dreOsT/mCNaRxKx8/6wiKSTzuXLSKPEsy4rYPnx+gRNnozJ9BbwEpaA5B
	szVuSxq/XAOSoMYFRWw9CDV1hr6QLofPthdoncbY1obrX//Wiy/KZmzDxdN00obYvXpNaRsewPZ
	OLfrPYI2rsi/ePsNgg0r1d+FtQoPmvZZu2M/9Rh3pokfhE2krDZ6hLs+3+YKdhZcXojJdapTIwo
	gLh/0px6F9GYMmWPcoEtWmE+5U//2qALTgZ5qPRFNGRqXsaz/jzoRV1Coi3keJ6Sx/lF7IBwRdc
	2a54HSs74qkQdKp8wXnUyxjv3KImOymaij9rics+5Q8vYtoh
X-Google-Smtp-Source: AGHT+IEe+k1a5cqu5WMjT/nJJWCpVKiyIM3l3KRdzo0Jf4Gi7oxOdVhuAq9l3mVN+FI3zHvNUliaOw==
X-Received: by 2002:a17:903:3d0d:b0:224:7a4:b2a with SMTP id d9443c01a7336-22a8a045ceamr5367905ad.11.1743708781184;
        Thu, 03 Apr 2025 12:33:01 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc41a65asm1590659a12.69.2025.04.03.12.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 12:33:00 -0700 (PDT)
Date: Thu, 3 Apr 2025 12:32:59 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	edumazet@google.com, gerrard.tai@starlabs.sg,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [Patch net 08/12] selftests/tc-testing: Add a test case for
 CODEL with HTB parent
Message-ID: <Z+7ia0FZK2F232gu@pop-os.localdomain>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-8-xiyou.wangcong@gmail.com>
 <3a60ae0c-0b5f-44e9-8063-29d0d290699c@mojatatu.com>
 <Z+cIB3YrShvCtQry@pop-os.localdomain>
 <9a1b0c60-57d2-4e6d-baa2-38c3e4b7d3d5@mojatatu.com>
 <Z+nUiSlKoARY0Lj/@pop-os.localdomain>
 <CAM_iQpW7f5QJRXBpEMAmMVNvF5aGk_2YNLVF=bcnoZhMhjDU4A@mail.gmail.com>
 <90069d47-8963-4caf-acdf-0577c19e999d@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90069d47-8963-4caf-acdf-0577c19e999d@mojatatu.com>

On Wed, Apr 02, 2025 at 10:23:22PM -0300, Victor Nogueira wrote:
> On 02/04/2025 21:40, Cong Wang wrote:
> > On Sun, Mar 30, 2025 at 4:32 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > 
> > > On Sun, Mar 30, 2025 at 06:05:06PM -0300, Victor Nogueira wrote:
> > > > On 28/03/2025 17:35, Cong Wang wrote:
> > > > > On Sun, Mar 23, 2025 at 07:48:39PM -0300, Victor Nogueira wrote:
> > > > > > On 20/03/2025 20:25, Cong Wang wrote:
> > > > > > > Add a test case for CODEL with HTB parent to verify packet drop
> > > > > > > behavior when the queue becomes empty. This helps ensure proper
> > > > > > > notification mechanisms between qdiscs.
> > > > > > > 
> > > > > > > Note this is best-effort, it is hard to play with those parameters
> > > > > > > perfectly to always trigger ->qlen_notify().
> > > > > > > 
> > > > > > > Cc: Pedro Tammela <pctammela@mojatatu.com>
> > > > > > > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > > > > > 
> > > > > > Cong, can you double check this test?
> > > > > > I ran all of your other tests and they all succeeded, however
> > > > > > this one specifically is always failing:
> > > > > 
> > > > > Interesting, I thought I completely fixed this before posting after several
> > > > > rounds of playing with the parameters. I will double check it, maybe it
> > > > > just becomes less reproducible.
> > > > 
> > > > I see.
> > > > I experimented with it a bit today and found out that changing the ping
> > > > command to:
> > > > 
> > > > ping -c 2 -i 0 -s 1500 -I $DUMMY 10.10.10.1 > /dev/null || true
> > > > 
> > > > makes the test pass consistently (at least in my environment).
> > > > So essentially just changing the "-s" option to 1500.
> > > > 
> > > > If you could, please try it out as well.
> > > > Maybe I just got lucky.
> > > 
> > > Sure, I will change it to 1500.
> > 
> > Hmm, it failed on my side:
> > 
> > Test a4bd: Test CODEL with HTB parent - force packet drop with empty queue
> > [...]
> 
> I see, this test seems to be very environment sensitive.
> I think it will be better if we do what you suggested earlier.
> It's not fair to stall this set because of this single test.
> Can you resend your patches excluding this test?

Sure, will do. It sounds like a good plan.

> I can try and figure this one out later so that we can
> unblock.

I really appreciate this.

Thanks!

