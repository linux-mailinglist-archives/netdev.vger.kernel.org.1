Return-Path: <netdev+bounces-131251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF3F98DCE4
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660221F25EFC
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712AC1D0DF0;
	Wed,  2 Oct 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PleZ1Iab"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D31CF5FB;
	Wed,  2 Oct 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880024; cv=none; b=MBWgKh+f4qHkBzEJHGHUz7l5NbKcBf4pn+86PyYrMe4cPvRS7Tz1YUrLqsfVVk+Bm8bvWTXWfOcA8WVOcpOtVNl9h4H9PrPMp72hrIOFXZxhwgmm10EsUgDYVeG8v9XvkmUnvsfrCEEUYhYinzJ6YG1R/7cKoV+5oYDXC1kqFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880024; c=relaxed/simple;
	bh=qw8OezMQaJAewE1bg2k5nq7x/9RBpa23tuknQGlEy+k=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tF8G93MdOrUxszNMb9LJmftwGXNeI8A1cxHKAAGOb5YlI3LQ5MC5H/p1zZc/QQo2QXCfvF41TohO0WHqsKpJWlHNAG4XclBf/e4I2e7eBQPL/SU1ltUWdcwOY3IatouTrOf65/+yrvjc3rBDVqzIBs65chvcKfGfHp04F4joBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PleZ1Iab; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71970655611so6258457b3a.0;
        Wed, 02 Oct 2024 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727880022; x=1728484822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSGQWdEu93oW+iwSS7AibpQVequI4+/KYQCSbMNlNoM=;
        b=PleZ1Iab6j3pLom3Z/Stj5gtkQbabFPH0ULQkkiabOlI96HqNCebO0So273SiohFFJ
         gh08NwR3Wivki9mAXJXZNmTpq7kyXNQhkmT5I2vIEjDgyz7O/BkgXr+8rfaP4oFuyiHz
         lF5sZxE7Xocpnm7m4YFfs21l4YX3Uq44cU0IOMS7EpHSkE0AjyvWJB8TB4k8MBYRibx6
         Yk7Qw8MVOHiC/lWUfuVvdSEr5U5BlRL+ImcK3EngnUITv4P3s8qq12XCvP8rLLnVRwgm
         6qgi3CpQth9opF4DcydP5assX7CxgjrCI6hz4snbFnD3VxW35qD4Eb6tPArrBfP5iBAg
         asZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727880022; x=1728484822;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tSGQWdEu93oW+iwSS7AibpQVequI4+/KYQCSbMNlNoM=;
        b=hblpxuhWQWWq3/fnSU2fr4/UAFtrmvryiaTaU6VPsSRyO6q7waAhb/sRPvSUnmq1Wt
         F3PCO6qRPVMzwVLuZG3NzB9bg7LYnuuf7SQxbvCHqTEy3biVsWiaYBZIxdbl6eoYcanb
         ZsRml5A4qTmS6mL58cP+MWoQveGzhqRM8xtO8dAZ71S5LQV4cgNRgbUANA/oIRDzF0jw
         LKjebD7cOeyTRnyVdWgOBpgaNdDzQBoyhGZUIML26fvu4NXgVDynIZ5ZgidTzy/4k8Eo
         Jy54VFxNZE5D8IaXQ4F1+SZX4edtxCjv2bFy1jsdAlZYV9HtVsYoJpK7kQdVAk20pB3p
         jmLw==
X-Forwarded-Encrypted: i=1; AJvYcCUpPtp6m4sz8xEwvDvKuGRlW+Ea38YkaRlgmE3vWB8zrbOyi48rLPArJecKK00zawtuX6znRA7EZsR4um/M2j4=@vger.kernel.org, AJvYcCWP3z42GBmNKV9goh2F5Yu/DGV+uzVgQEi8FHafoVbEAIIykFJVwxJZ/j8PXWYkrJTzsS8UWZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd/5f0FD4Jk0KQW5a9UisAqlBAjL4DTDS5Vap34McxgT5ukR/h
	MTRPNRv63ruRBq5Yx1eKSwfTkZQyURdWM6fp0zTOD/T1eJKHxcNWo8uoRWZ/
X-Google-Smtp-Source: AGHT+IHBgNfQpEm+5fYcb6Mi51taghrunL62pgWoenC/ZqT6v16QxbuxCHwvsUvlMuosSW6mR0HEwA==
X-Received: by 2002:a05:6a21:168d:b0:1d2:eb9d:9973 with SMTP id adf61e73a8af0-1d5e2d79c05mr5059397637.39.1727880022292;
        Wed, 02 Oct 2024 07:40:22 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26499743sm10252470b3a.18.2024.10.02.07.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:40:22 -0700 (PDT)
Date: Wed, 02 Oct 2024 14:40:07 +0000 (UTC)
Message-Id: <20241002.144007.1148085658686203349.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgj1y=h38pdnxFd-om5qWt0toN4n10CRUuHSPxwNY5MdQg@mail.gmail.com>
References: <CAH5fLgiB_3v6rVEWCNVVma=vPFAse-WvvCzHKrjHKTDBwjPz2Q@mail.gmail.com>
	<20241002.135832.841519218420629933.fujita.tomonori@gmail.com>
	<CAH5fLgj1y=h38pdnxFd-om5qWt0toN4n10CRUuHSPxwNY5MdQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 16:27:17 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

>> You prefer to add a simpler Duration structure to kernel/time.rs?
>> Something like:
>>
>> struct Duration {
>>     nanos: u64,
>> }
>>
>> u64 in nanoseconds is enough for delay in the kernel, I think.
> 
> That type already exists. It's called kernel::time::Ktime.

Sure. Some code use ktime_t to represent duration so using Ktime for
the delay functions makes sense. I'll add some methods to Ktime and
use it.

Thanks!

