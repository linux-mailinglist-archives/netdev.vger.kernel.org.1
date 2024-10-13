Return-Path: <netdev+bounces-134881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61D99B7D9
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 03:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B5E282B7A
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 01:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9E17FE;
	Sun, 13 Oct 2024 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV3+paIU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8E10E0;
	Sun, 13 Oct 2024 01:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728782114; cv=none; b=IQWK+5VqZbEqK/+snfDUmFJvPDtV9q+ROKPfrWbmAoakRuNa6cwoDRmFm3Y15G7sc7hbpQmQC4MmkpaG8eWqaW2LdBphKSNH8d2JsK+9Z++AW2mJ4AxFOI9YN//CpTI1bThS4ipfTIJKcJdfE60uH/0LwkQNvK1IyAgOBPVHxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728782114; c=relaxed/simple;
	bh=hI+RFK23XFreeKY9FUlprlcvMGdSUwpqJuDTN7Kf9rA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fNT1Mo5T+UfrY33JJTLfLY340cWH+QbNtnjlo/T0+2EvDPLPuCpBET0RpVHRh+EEmC8G3QcMFb7TkBnijJfzTuC1xJNPH8oNB7CqGIP074kLykn0EwGtMa1LOrEb0kP2yBAH11GsxZkik7TP1ed/FiQNzySxo4iWYz0GtSWuxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV3+paIU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5a62031aso178781b3a.1;
        Sat, 12 Oct 2024 18:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728782113; x=1729386913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfOKYXOQp4fXxRUHk2Z9FRbeCws6T2uvmLPShtZiJ+0=;
        b=kV3+paIUabaOzgsnCRJ+L72vl5At9Az4G3UaaY7HBQDNYdPUF9kEzF5I3SxR//CpNy
         4b8+BHc3a9IOThzQ/Gm9ecB0lTO9aGevb2/LnFE+u38ZrVg5RSE6dVlDeskMHgVVS/UV
         DT+8VfwGWZ5OuhT4qWaULAD+JZCLxP0QTQ0Rk6zi1D11PcyhQL/KGwI/bs++SHYR9G5B
         2T+YjFx6wyQi4pT5ajNUQ13AXaEvhMoSCVaHgBMGoPsHz2Bp2fC8s9sm5aYJmTpCFKbQ
         AxB0SF22cOVRo4Z0/DWPbcIXGM4W+FMfaNuZAvKsh3cymjJ0CpnWfarWu4UtiIezie9z
         WKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728782113; x=1729386913;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vfOKYXOQp4fXxRUHk2Z9FRbeCws6T2uvmLPShtZiJ+0=;
        b=QrfwZCP/i4l5g3yZSqMbcZypf4Ay4bCpUd5E7XZr4rWVJv6QSNFfLlnvGLCtns4Xcb
         MiezV8hvuWdG80jbkicSE6yPFm/aP358JgBWpXb457mJzazi16+eXTPEovVretZhNXmT
         KWQhXbJ7fu7wtp21SE5Ak2sit/hrfJvRbpX6s13sKIQ4Qg6NfduHhdLIENEX/6p5VWrV
         CYP+hf6LMpo5mQhVI8m+lnsrs/cJxm9gmZw1UPoXgnRWO5Tfb/py5foT+MvceDOoe1GG
         IwC+wh8TWk22QYoUa1xqdGT8yX6Jc1Ie7u+bvHFBdwdmLo3JcTT0c20dLTdw3Ib3LJZ0
         adLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBm7g5UzpcybYDWUNW/rMo/IHvAehVcjU4rsJcZOxAzNXg0A4hviKrTnLGNuZjRLzpQnUE5qqE74NwcJ2GJX8=@vger.kernel.org, AJvYcCWAt379AMvzMvtZQCzzOoK1GAqlPb4dOVn+GfOC6BkxFtXG4PNBTKmKrI+LyitlszZW/YCvNvFrrxPG2yI=@vger.kernel.org, AJvYcCXDW+UdkywJwHrNAUWUY5h+hnlRShButITJwYUdZhq5cSw/KLUIBurw8PSSM4ouRu4KQeaKwTtp@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQeiT/2b/zjjEosCAl+28IoCE0D2XzbPoBjSqAiLNXMQPNYCT
	9ItrAUo44/9ZE48ERXB+2iN/29EF7cLLaOlbjuQ0QDWJMd4cuEg0
X-Google-Smtp-Source: AGHT+IF8MGP8/waFl3cBccF3SXA0TraE+bo75z636UeYYNOLyqP5JGZaLk0YZ/6D1teKS1bwUhajJw==
X-Received: by 2002:a05:6a21:9cca:b0:1d1:21a8:ee8d with SMTP id adf61e73a8af0-1d8c95d556amr6486473637.22.1728782112657;
        Sat, 12 Oct 2024 18:15:12 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4495aa80sm4501844a12.75.2024.10.12.18.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 18:15:11 -0700 (PDT)
Date: Sun, 13 Oct 2024 10:15:05 +0900 (JST)
Message-Id: <20241013.101505.2305788717444047197.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 linux-kernel@vger.kernel.org, jstultz@google.com, sboyd@kernel.org
Subject: Re: [PATCH net-next v2 0/6] rust: Add IO polling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZwqVwktWNMrxFvGH@boqun-archlinux>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
	<ZwqVwktWNMrxFvGH@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 08:29:06 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> While, we are at it, I want to suggest that we also add
> rust/kernel/time{.rs, /} into the "F:" entries of TIME subsystem like:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b77f4495dcf4..09e46a214333 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23376,6 +23376,8 @@ F:      kernel/time/timeconv.c
>  F:     kernel/time/timecounter.c
>  F:     kernel/time/timekeeping*
>  F:     kernel/time/time_test.c
> +F:     rust/kernel/time.rs
> +F:     rust/kernel/time/
>  F:     tools/testing/selftests/timers/
> 
>  TIPC NETWORK LAYER
> 
> This will help future contributers copy the correct people while
> submission. Could you maybe add a patch of this in your series if this
> sounds reasonable to you? Thanks!

Agreed that it's better to have Rust time abstractions in
MAINTAINERS. You add it into the time entry but there are two options
in the file; time and timer?

TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
M:      John Stultz <jstultz@google.com>
M:      Thomas Gleixner <tglx@linutronix.de>
R:      Stephen Boyd <sboyd@kernel.org>

HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS
M:      Anna-Maria Behnsen <anna-maria@linutronix.de>
M:      Frederic Weisbecker <frederic@kernel.org>
M:      Thomas Gleixner <tglx@linutronix.de>

The current Rust abstractions which play mainly with ktimer.h. it's 
not time, timer stuff, I think.

As planned, we'll move *.rs files from rust/kernel in the future,
how we handle time and timer abstractions?

