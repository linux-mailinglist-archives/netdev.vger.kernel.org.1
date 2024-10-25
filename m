Return-Path: <netdev+bounces-138973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5799AF8E7
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 06:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B1C28260F
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 04:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F4A18CC01;
	Fri, 25 Oct 2024 04:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="CMmcVlZP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419718BC2C
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 04:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729830558; cv=none; b=JWHYvpqIaakevvl1o+pHPRc5boi2M3LE09QWkmBEbmTSXgY8JoRFzajSxVDNQ/4CHCaYQ/3JenOt9WD4GAq8SmIINKRfzMuXC5rJtUxgMBUAddRVFfmzI2lJQQ8ODDUVeYha6SoEz/QjINSFvCk9IL530U8bO+mXbVgllRHkaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729830558; c=relaxed/simple;
	bh=EWCK8syvlG430LCfer51vMNGSWA+i5Z13fpF3yXP7Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxafU/07TU40o4vzWBIuhBwyLKO9TGXc5S+MibwjFIwg1EwqkLL10mhvKQu4fzfeLDNZpE88KjfhvQr0K36gNXkEyv5S+Ao4Oyj1NPQcYrgYZN1hRNugkbKfRkxdOupK/eQ+mrDzW2lFN2mOnnNf6aWBFgjfxUAstLGeKKGVw8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=CMmcVlZP; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e34fa656a2so17223327b3.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 21:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1729830553; x=1730435353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWCK8syvlG430LCfer51vMNGSWA+i5Z13fpF3yXP7Hg=;
        b=CMmcVlZPoAWmezduIuZGWyt/a7o9ZFPeE3mLACnXT9yfNlBUqSU143ypr3OXRO8Nco
         o5egG9DX8uVvqpdie+Sa53oN/VRC5ezxAx66u4LI5kHlz6BN2rfwYRXDV6ZCv5LvqtaI
         GxRw7OYVSu+BaiKqaXu3026KcGHmxqg/uZBaD36YFaqzUM5pyyOLEVuoJTFqzChMEwTy
         C6g9AOTkeZ+xzo8SMTJ1oxmXbUOIiZWC1rQw+A6FfUwAyyLl8Gk7lFQ5L6NvS4uN9fLJ
         m96y/CN/Br6ezL7/T+5KmcpgXAABNWVpbdUqczgoQX2nmgd3zXgmJklqq5il/bS6PVd0
         SkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729830553; x=1730435353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWCK8syvlG430LCfer51vMNGSWA+i5Z13fpF3yXP7Hg=;
        b=Qzpwj8/yR332eo8iCsqVXN6HhRgs/XhTaK30b4vNjYR5sd+z3Z63uUAo1gRVxlM+2X
         iOsmvpsEEKkLC65nS7Lz/y359f/Vsk+a1DLva8VG6QBg/XusqFo7EiBG42IJ0NFnOirr
         1JRCtodMglNgubNZcGEQy5TcRtFt4NJM/mnl3gjmFVgpwV/vx6Gq9lNIoT53nF5BJYM9
         /vi2VEuwWUjJVaY4g4zM6L0U8YZIv/5E5QP7cTOfa5ZkKbbBzDBUW5zFZDcaDD0RTLkr
         MNktO1uR/c+M0xC2QuCxJZ7yIJmKnlhEXz/kpbxR0DAWxDR+0YCoj4K4dUZ6hxMKLMrw
         Vkfw==
X-Forwarded-Encrypted: i=1; AJvYcCUaWX5FebpBpc+4/lSshp9KvfqGBMbxX3LKyKN62xQAyYVC9Rh8MmMvMG741gIgr41u2vpxJiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0R/uJBcn+DJXn0ZRCr2MniGuJfgIDGkqjmFCWJVHodtSVORp
	ZAjt8zpaiMUfCP4s4SYpq6uysHdmoKpE2p4L/voP8Pq6P9IsMB+fLDUOx5L2tvIBlQ088FHqnE0
	HdFc5WJaPqQaESeZA8uZRx/9ICCr0pNx/wt5uLw==
X-Google-Smtp-Source: AGHT+IFxXvvTdE3yugP3KWorwEDSHTOOfHgNN/Z+duUWd0Akjtp00/GgCjbXkozJntXhXwb5dgIWMV2hMm2N1FcFclI=
X-Received: by 2002:a05:690c:6687:b0:6b1:1476:d3c5 with SMTP id
 00721157ae682-6e7f0e04bbcmr104496997b3.12.1729830552972; Thu, 24 Oct 2024
 21:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025033118.44452-1-fujita.tomonori@gmail.com> <20241025033118.44452-2-fujita.tomonori@gmail.com>
In-Reply-To: <20241025033118.44452-2-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 24 Oct 2024 23:29:02 -0500
Message-ID: <CALNs47typNN-Zp=Lf44DUkS8vUQme08zt_qPtxO3mngmfrnnFA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait
 to Ktime
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 10:34=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add PartialEq/Eq/PartialOrd/Ord trait to Ktime so two Ktime instances
> can be compared to determine whether a timeout is met or not.
>
> Use the derive implements; we directly touch C's ktime_t rather than
> using the C's accessors because more efficient and we already do in

"because more efficient" -> "because it is more efficient"

> the existing code (Ktime::sub).
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

