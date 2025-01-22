Return-Path: <netdev+bounces-160218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D9FA18DEC
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22A9188BC93
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058711F76C7;
	Wed, 22 Jan 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/trVRql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537E74EB38;
	Wed, 22 Jan 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536274; cv=none; b=Lrf6ZDrTyVjaBR3RsIULOMC6uMGiRa4BGVZ3CBbcbNqd17pQAvOO6Idtclzx7BXQLp0HcHSGfL6+e91urwTqt2A5JdJQPt956rPiSq4LPvXDbTSJ3KKmrO3O55GS6efoTKS0I8R22Ws7naogsLp7oB7kzlGCfajhzRPbgeIUTtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536274; c=relaxed/simple;
	bh=sU298wtMU+gMgPfWkGzp++POQ1xOAgiZrBAXE8FB4LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLPGsxf9Hr0VdE+4jPjNo1rjA5NRSPqpiHv8D7v3AJIBOvr749DCkz9/Z7p9seR/32gFs0/rBUWGOSwlkPMd0WxRAgNaEbSW8V6Vdae82Y3oBPmpQ4zPSuzDOs+gdlR8+lkEsPW3U4b31g1mO1LbGNFZ5QT+DrMSfhsYuiF9ESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/trVRql; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef6ee55225so1363133a91.0;
        Wed, 22 Jan 2025 00:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737536272; x=1738141072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+4rWF4CG+aBfHBC/5V8BT3aj9TO/uoTwJ8l9BOGJeM=;
        b=B/trVRqlu3PV7QW8hT8F/szFSxqr2m7tnclTsgwxpB4823EAEKaXFpek/FXWriJ9JV
         XuNtG+AE1MULW4aUBT5zFJ91hl0lm/xv6VOfT4gyEKwHrbArbj6/x4uqDrLmPyFjcS5R
         GkTr2Ia4go+TlBy9dtmwHRZm3W4G9eAIPnqmZEeSOV5Ee2Y4WMXsopePAkgzaymIXcLH
         QVBwOAFbHVrMGUxRP4FcNCR512ZDiV2hRPnTr/Rnhh5DraubbIMpwH/oUGc5ssbMdZvE
         dcD82nrMfWT4unAfxDIJLU9tjOTAYMyk/knIt/NLy2Pa2GgOFcANp1rQixrQnkd/fACY
         4dpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737536272; x=1738141072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+4rWF4CG+aBfHBC/5V8BT3aj9TO/uoTwJ8l9BOGJeM=;
        b=YtawMkn5/CipssGTr3k5r3B/6rpWjBREQRwsjaI0qhBM9xQK15rw1Qey4+2OJ+jVZB
         L3sG/DriHKnJMHsX85ahrRBLDwyLo1iy1npr0t8YiVDQBylET+zxx0nMyDlu94i5fcID
         2pCHaoPSXHr0GODCp4oKum39qlKWHMDPwXsy/N6tca19efNTBvYdNKKFUpRnRB6xgP1H
         Zq/vzyGe1JwmDXT9CcAKSH8KtUSFvUpg8mPicMwJHw1LCLneuPKJDijpFB8rgfZVIIxU
         Oxa6T7kxkga8+ZCYhEetsDF4SdzoIXqmu2r9WAoU17A2bTTA/04CvIb8AWmcCsRZd7XQ
         CeLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcbTalkk8kOWUwaFRrg+ZL9ZNLcILHW/TR7eMgauRNH6XVAHR76dQcxyKlH0HurSlrkO81OwAO3aHbIAgYjfk=@vger.kernel.org, AJvYcCWDQbo8D71w/oC+ysEsgkZGULATRx8so9yxi/hgUkEyrqEBVtau9jljDPXclkCzjm71iS0Kp+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZ9x1bqSrImzcDW/+L7UbOEgFQ92V1Fncbr3lEI5NS8/7cQjV
	uhx9PdtINmzWOza/yMmFRauyzHI6vv43a62ujTEXIzkrg89zFu+BdT0HIt/50yrFggmVV84cF73
	PAe810PPNC/9DzoRjPjHDqgXkzNI=
X-Gm-Gg: ASbGncu+sgQLhKoj9OrT3nNM/9akHWfWtdJBhlfIKH+HNRIbsgg5qcFo6gNpcKKt9qw
	DznrWWBg3COrcRCqWPInXBnp2Ct5OIhjGVmXpb7Huo6vQ7nzGY+o=
X-Google-Smtp-Source: AGHT+IET9r8JSmss5wncs58ue1ECkJgLujCKETsp3piHO3mpOMSewKO+YqHU7WDcXQ4s/4pzCBVFG86fXm1njs0O9E8=
X-Received: by 2002:a17:90b:5387:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2f7e3e0fcf1mr1749187a91.0.1737536272516; Wed, 22 Jan 2025
 00:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
 <20250116044100.80679-3-fujita.tomonori@gmail.com> <CANiq72=kuZcLCgsSkKa6MrYCJY9UsWSV9VLvj2TcVOQEf0Cnmg@mail.gmail.com>
 <20250122.163728.1738626154854951916.fujita.tomonori@gmail.com>
In-Reply-To: <20250122.163728.1738626154854951916.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Jan 2025 09:57:40 +0100
X-Gm-Features: AbW1kva7CLhxOl4_GYMA5C5vdZCSXsUOyMdUnIwhKy-TXUNa6kTCcW4ZlzmNa0A
Message-ID: <CANiq72nL8JYDZx8xZoUzh9KdYWCeMZ28GWAoTOSUqRN2WT8Ovw@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] rust: time: Introduce Delta type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, andrew@lunn.ch, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 8:37=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Yes, please create such. I'll add more docs but I'm sure that there
> will be room for improvement.

Sounds good, will do!

> You want to add the above explanation to all the
> Delta::from_[millis|micro|secs], right?

Yeah, I meant to add the saturating note to each of them.

> Is there any existing source code I can refer to? I'm not sure
> how "module-level docs" should be written.

You can see e.g.

    rust/kernel/block/mq.rs
    rust/kernel/init.rs
    rust/kernel/workqueue.rs

(grep `^//!` for others).

In general, you can use the module-level docs to talk about how things
relate between items of that module. For instance, when I saw in your
commit message this note:

    Implement the subtraction operator for Instant:

    Delta =3D Instant A - Instant B

I thought something like: "It would be nice to explain how `Delta` and
`Instant` fit together / how they are related / how all fits together
in the `time` module".

> I'll try to improve.

Thanks a lot! (really -- I personally appreciate good docs)

Cheers,
Miguel

