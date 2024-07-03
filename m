Return-Path: <netdev+bounces-108697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 884EF924FF3
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 05:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3FC6B211D6
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 03:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D25175AB;
	Wed,  3 Jul 2024 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgtJ3KLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D917BA2;
	Wed,  3 Jul 2024 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978466; cv=none; b=DQ33ou6US1BZJRVVw3zJGD8rqi+a+d7HkMBqsbaWz7b2kMIWk+e9k9YjgAiNYhKV4o27ZRveAdAMFtHhYQyzbov4Ei+z+1xDrjX4LO3VtkqING158wVxRY5oXT/k+ax7lw9EoHPWa4NXuJb3VLTV6l7muzmgMlyf27H+Ec3mieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978466; c=relaxed/simple;
	bh=Mfta5ZS+DFrKrihafOnOYbWhIpfl5aAsXUrw+M+i3gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1ya6l9Ae/ESFWeKF2pxkjyiZnriTuW5vJ67i8EaT3+rcjQmuUUtD6FyjkDAA6iV/LU8ywBODrVehdo0oYsRsP2bAQIIEwjrKjfpO5ulUov5rfcJScEAIrCPEpkO5oUNPW0PJIXd/HtEhVYw8WkAyioKImfWTpgxWXcw5OhIt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgtJ3KLz; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c45d13e658so119963eaf.0;
        Tue, 02 Jul 2024 20:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719978464; x=1720583264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iURdNYcFvmNwVS0VrudWTADWoeH5iatB5JmIJP1JiW4=;
        b=OgtJ3KLzFHcZr4Fua1/eirYcSrZm04c5OvJKxKxa2FW5zoT9izqRWnSnAI6LGdHOdp
         sJs49zlEoUX2/D7BRQnxi0kuTakOLs/E76iAHYy7SCQWoHgEh+d1W3v3msvMEv7nCE+p
         tUdzut+3GpYAlT/UT8YFp35yl9H2bZv9MB4iYdCcsB7ilUuaEVwsTCfxCfdL7NXK1fPq
         hSLa5I798CwZtE4d1xUDJb8uRbcj5FIg+NMIZ2BH1gbWR6YDBWqVDzhNjyjrLneOsxkC
         tRqoiz2dCwTFZNhiDyy+kXVlBipf2ZIqcNG25MIZ3UcnWRjui+hiiaalT3VUTaaeYbRp
         D+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719978464; x=1720583264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iURdNYcFvmNwVS0VrudWTADWoeH5iatB5JmIJP1JiW4=;
        b=FCOgJSlBvJmpzfI9a4D1StFbmHNeMUiNoP7e1m/5OMKT7yY7v/4/hHYgKFbnZh5KRe
         OzCs4XsyUCSR9cSFibDd2UDcsTOLaA8bKt8hHqvpeLTFxm6ymQ523lm2iEg91hKkCyiX
         yWDp2q8g01aTvxWXJx19dkp/WD31Dnr6ttFvvqn+8PeonohqLcfeVFPZlgRFjTXgxN3v
         2ho+RDoB6c8Q69rnQaJ9Z0ihvQE0RJpng5g1bYQ5LOte85Jp+85hq8crm65CkYzpgp+f
         nU2l/djErZH36JN0PfeNO8MnX08rtXuHHyUHMRH1ZAkms7l9QJlUd/XUzv+vwrE+8lMC
         23wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNXyJPxSRBC2I+C7KI9JA4ihZF5VWmOvU1f2jgJSM82LEJdIWLXk5BNy0KH16S1HaRJMX26/ttyvXv3838clHMNeMaEjuS/6i7gC4lF54NzXlhdrfmSaRY3+UZx4qp8OcSkAilL+YTa3AepiFJEOw0+A9aZJnvl0UM6N0XBbpT
X-Gm-Message-State: AOJu0YwJ+wedWbW1yWAUxIH6fUCvd1gAYlYhrxmVruziw9JmRatTBCSA
	hjD29/hw4A2puopH3n+Q/63ERfcq9r9I13CEdJ5UVooWJozcQzrqzacEggF+9bOyapMA6EfvpSC
	4o/Qwf5MRWh8ymCmq5z2FeImTqIVNjqTS
X-Google-Smtp-Source: AGHT+IH9mV18ddvbPMOjO69mQKYvtVbSuEbdxsNxUPnnlevChXiRSAL5m0HPo8/1V3nADp29+AIMupKUjk0kntlFAos=
X-Received: by 2002:a05:6871:24d6:b0:259:8bf7:99dc with SMTP id
 586e51a60fabf-25e1034361fmr261237fac.8.1719978464216; Tue, 02 Jul 2024
 20:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701100329.93531-1-linux.amoon@gmail.com> <20240702184220.306d8085@kernel.org>
In-Reply-To: <20240702184220.306d8085@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 3 Jul 2024 09:17:28 +0530
Message-ID: <CANAwSgTfHhFwGtMMGUOpoNo7SGnVyOt87puXt1HJE3_d7OiHqw@mail.gmail.com>
Subject: Re: [PATCH-next v1] r8152: Convert tasklet API to new bottom half
 workqueue mechanism
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

Thanks for this review's comments.
+ Allen Pais

On Wed, 3 Jul 2024 at 07:12, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon,  1 Jul 2024 15:33:27 +0530 Anand Moon wrote:
> > Migrate tasklet APIs to the new bottom half workqueue mechanism. It
> > replaces all occurrences of tasklet usage with the appropriate workqueue
> > APIs throughout the alteon driver. This transition ensures compatibility
> > with the latest design and enhances performance
>
> alteon ?

Ok copy past the committee message, I will fix this in the next patch.

This patch is just follow-up on work done by Allen Pais
[1] https://lore.kernel.org/all/20240621183947.4105278-14-allen.lkml@gmail.com/

>
> > -             tasklet_enable(&tp->tx_tl);
> > +             enable_and_queue_work(system_bh_wq, &tp->tx_work);
>
> This is not obviously correct. Please explain why in the commit message
> if you're sure this is right.

Ok, I will gather all the feedback and work on these changes.
And update this patch.

> --
> pw-bot: cr

Thanks
-Anand

