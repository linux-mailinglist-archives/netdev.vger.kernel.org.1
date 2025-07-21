Return-Path: <netdev+bounces-208586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B902B0C352
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEA83AAD0E
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B602C08C2;
	Mon, 21 Jul 2025 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hva4HOgr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A452C324E;
	Mon, 21 Jul 2025 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097790; cv=none; b=XStBsiEENdZNaLcTZsfbIwQYw0FhwFuNMWYxwPkbIVxtd/DhtpB1u89zGaTZ8bx+m0+m4Vd7f6OuToXHsHjIROICHWkYu+yakAijQZVu2y7+fAc6g0TAHjEQM39Y3ta9lkp4czH1/wlvLnDMsCe2aNTV9JXmCyjev8XDS406PsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097790; c=relaxed/simple;
	bh=cv3cZimFRbih3moFYugSjrM7hRVrA1WVZg4pUK+6P4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+Om9wRM7FaxdjUV7Xtlca0Uq3RGguKFBIcRQOEVqiwdHcDV7/dEp142CPwFsEDmGudXoUACanqxbOyXAbRygI4S9Ro2axU3Z7tMHGtqbG59f6rf67WldRVTPyDt3D9re6X+rGpn54llEwQA+6nm9EQed2AcrEHba0SOFH0PUAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hva4HOgr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7490702fc7cso2536525b3a.1;
        Mon, 21 Jul 2025 04:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753097788; x=1753702588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ok31vjZ6354uwz9oviPoQ4N7zKiZWIkMurk9Gv3QM8=;
        b=hva4HOgrYtW3fo6rfFT5SxfiThNRlJm4t4U8znzXQYv8WuPMp/i3bbVZlpEobbIqee
         DCLx+nj9U2gNLUCDV57O9wx5gMVDJu76cRufp8LZgJ3IZONFqqTVfFn0o83QAjbsfuVD
         K/tW8KWi6ntvSZFpInwiPqsxSFis74HAi8zVis+PjuZIemPKUsSvNV5EzpL4nwuQSP92
         Trp2zQsr5hQBly7EO64SePY80BKhGUCrsi5DWXYdSU/RvFVx5YMnYi10Td9gxPuFf+5F
         J/otliHTCBpYbg43SLfztEHVcsy5OOE2dFQph3B0u0nyYpaeKsDoXqb1V8rycgxFBQrb
         mlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753097788; x=1753702588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ok31vjZ6354uwz9oviPoQ4N7zKiZWIkMurk9Gv3QM8=;
        b=lX4ZG8g47I5BfDBS7niCaoZlWJhjQTphYS4DZdN/AI3tHLCZnlFEXo0NavJQ6Dswia
         hhHG1kIPs54lXRULGuJ2P4MgISZdFgHY2Hsong6tas5MOnR9CsHfUtdTpUq9lB4rFpML
         QulOpB/AKZZAVJ57e6BCUOr4wL2If21aC/NxmjFAARplL7b5edgzrxdTbeDx8hmUCypa
         6Co6Zi2wCMz05ytcBSLLk1oxTb2JgY3b0iWkUh/88m2xDmM91P4/q+Pcubcf8smbS7GO
         JupUAFKCQKZefKHHK5V2fcixlVAWIosvStXfZDvO11VIaoO6TCdIo8BjRnAM0MntD5ng
         MdOA==
X-Forwarded-Encrypted: i=1; AJvYcCUYeNCUvu+7uVyqQ8zNQO84wZxigGSxxt1zwcYgWsOh+6F0HH2Jr+JqjssYDoR/pKgYTgWbW9owEewTfXY=@vger.kernel.org, AJvYcCWx0rWimYCeffPPHIfEl0yGHUwL9NDTlTj7PgP70PZuwWb1B8zYiQc1/oxbLvaCdLI7ZKydBSni@vger.kernel.org
X-Gm-Message-State: AOJu0YwiEtMLFYKda/YN2c0TNxPaqkk2W8pd1SEZXnoQvm+LP8PRhO9a
	Ij4yYR9DwNWUlnqz48yLfYG/0WmHhe4W122GUj1T6XQjVrB/hAq25u1boh/FaWsTIyUZ4sSzLBP
	hvlyYtjC1UhLC864+r5/bufWGX1DqSec=
X-Gm-Gg: ASbGncvy14zBjNm3d6/TtI/fLLE4hBgLc1YVtiMcuuZmVCnKAZTeqDAqoOliXpbfiYP
	NfZ4ejReJ/RXj+Mamw/FvnhRHSCLt7QX8pes5VU02aVWj1XEPcwQWd01T7n0k0waWFLKBflMavh
	aAy/Gwyv3yluw7LFEnvx/opSJgo1BBO9aU0mN9OmT59TZkpgDz6qTbaVplsUDFki1yTdwMUnzZv
	oB+RHb/pg==
X-Google-Smtp-Source: AGHT+IFA/pxFwryEf96K2Gee5sUiTxsekg8JQt2ES6cbvDkaPIRTiDbHon0i4EFoC/ytGXXHizhyN6waHxbKULiUcvk=
X-Received: by 2002:a17:90b:52c5:b0:31e:3bbc:e9e6 with SMTP id
 98e67ed59e1d1-31e3bbcea8fmr655973a91.19.1753097787776; Mon, 21 Jul 2025
 04:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719124022.1536524-1-aha310510@gmail.com> <20250721083011.zesywxhisw435g73@skbuf>
In-Reply-To: <20250721083011.zesywxhisw435g73@skbuf>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 21 Jul 2025 20:36:17 +0900
X-Gm-Features: Ac12FXzfA_mMHbGFP-kfTY7ETFr-C3kCCGfIhbY2olDYnWYzNFUV6JbJROL59jI
Message-ID: <CAO9qdTFwFpQh8O-sQuLDXj2eH7L_yBGTk6jdinZVGg9ShQtssw@mail.gmail.com>
Subject: Re: [PATCH net v3] ptp: prevent possible ABBA deadlock in ptp_clock_freerun()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, yangbo.lu@nxp.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> On Sat, Jul 19, 2025 at 09:40:22PM +0900, Jeongjun Park wrote:
> > diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
> > index 7febfdcbde8b..b16c66c254ae 100644
> > --- a/drivers/ptp/ptp_vclock.c
> > +++ b/drivers/ptp/ptp_vclock.c
> > @@ -154,6 +154,20 @@ static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
> >       return PTP_VCLOCK_REFRESH_INTERVAL;
> >  }
> >
> > +#ifdef CONFIG_LOCKDEP
> > +static void ptp_vclock_set_subclass(struct ptp_clock *ptp)
> > +{
> > +     lockdep_set_subclass(&ptp->n_vclocks_mux, PTP_LOCK_VIRTUAL);
> > +     lockdep_set_subclass(&ptp->clock.rwsem, PTP_LOCK_VIRTUAL);
> > +     lockdep_set_subclass(&ptp->tsevqs_lock, PTP_LOCK_VIRTUAL);
> > +     lockdep_set_subclass(&ptp->pincfg_mux, PTP_LOCK_VIRTUAL);
>
> Every other lock except &ptp->clock.rwsem is unrelated, and I wouldn't
> touch what is unrelated as part of a bug fix. That, plus I believe this
> breaks the data encapsulation of struct posix_clock. At least CC the
> "POSIX CLOCKS and TIMERS" maintainers in v4, so that they're aware of
> your intentions.

Okay, I'll CC the posix_clock maintainers.

However, I think ptp->n_vclocks_mux also needs to be annotating lock
subclass because there may be false positives due to recursive locking
between physical and virtual clocks.

