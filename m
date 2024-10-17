Return-Path: <netdev+bounces-136470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A38B9A1E01
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBE31C20DB4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297C1D88BE;
	Thu, 17 Oct 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnnWAINU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D71D4150;
	Thu, 17 Oct 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156647; cv=none; b=qbKZs/3BdAhNa+o1apHdyVOLYgmnc/oyaY/ISFRFmUliF0Hz8qZtGJA8QQagRvl2R1CzsWdy+HwM4F/fvBy8N93h7UOQB3jRmcqJkr2XS73NacplYL0XZL2rh0/uzPKWp/knXsMW431cmjuBo5rtqNjqYfs19Lcyebl/XCXnqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156647; c=relaxed/simple;
	bh=tnGQZ6lVUra0MiSs7K66Y5k5frQFbVkK1r1M+VtYFT4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cirRxIXnV3rJNjVb6+g93K2YD+5lGspz8JFgmVFGx5URmzrzJ6VZzQ1lyVeq7tQm9R+U/eHbsaP+GigCzc34bUmi6PWgO+0ks73sdUN9+mBxloaghq8e3SqxbDTlhqaENYSXlgjX3Pu9M6EOBR0geXPmcDuPPEHcooHmVgtGddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnnWAINU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so607774a91.1;
        Thu, 17 Oct 2024 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729156645; x=1729761445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yH9xzXbkXQtIf26L75aCO7ntLQ/eZaOKeycwP5Fq5/Y=;
        b=OnnWAINUceeGGyoSOoe1wiEShxYin0CXrtOM+75IaeI1fb7DifQwpC1K2juTLsGcSO
         fZxUyX3kg2tfhv/ZDtOZlws0CUKIhTbZX+10xI1fgg7liceXzYeEWAvqmh0o2HN3xvDq
         Zz9wbugWTIJLTHMRsTPO05xR/hHIdZncGRXgDO2QGLXIQrDuNLo4Tud/jfjyCJd1IXC+
         2Y7aflyolOSXGUnHaoncHOME14AUDtdb2GIiVrCWzbXt5d7vdtTxN4uoMWluQ6mKgqfP
         mB+VKjiPQO1NtFgXtaRYpclk0DfX46pdM+Vk+KtVawADIht8tODp+pWmNqT7X/cQGstQ
         diKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729156645; x=1729761445;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yH9xzXbkXQtIf26L75aCO7ntLQ/eZaOKeycwP5Fq5/Y=;
        b=h1Q5T09t4Wvny3jph4uS+SKxddjZ7vI7D4tuTfl5mVIR6Sj3Dz/toM+HGz76B0azv3
         txz9SOee/d1BWFV53WM/MljuVNQxZQ+DAo2HBvBjBwcSxPWKYNDOMREsnMKiWrxSL5H3
         I0LAC6v7PRb/3bgjL8tV/VFKP3HggXCLi+2QBsyndRQIZkNZdE0JPedP/BmRwnPt2ZSs
         4nz3TT7vl5V7xRKPvVVRCTlUOoSTZRca4lQxI188FjYwM2VCeQhW348gCwWYRhBkXjzi
         w7S5xSpKtb2ii7FEpW25FNhxEeUUORasu6HFdmSXO9f25BzrW+uEYS5HXNWRhvIuSXl9
         7zYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMscER0To0DkLdRhNk6n8B2EPZZfxi26wjryjrTxk47Pk5iCKznJfR//Aw5pzDfsogzBJdnM9Y@vger.kernel.org, AJvYcCVoxiyb212pfwo2wRg23CSxeQPMO4y1Gg/hyVTSAiCUVRxIj8eXxaMOorqnufj/8ckupzF5v4IToJTh8/lhyig=@vger.kernel.org, AJvYcCXD5Gep2ChxVaJDPTVtlFqjGg+IIkuWlHR++5xPDoTsxMTo1L7nbfQWVQotOTCLg3A1KQaFh7AsLHWGEYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+tDJrO7xq0hGR0Q89D1erv+MS8ZYOVrkxRjp5t7SJoGhHUtkd
	tr8ObxybI/NS4SnXG8FfhU8a7QMdTSD/RQZOmaIKGD1qlHr5pqR0
X-Google-Smtp-Source: AGHT+IFVEcY1hgk/uwScEfhUWsPC7yT+/rSLWFxI9G28BBKV/hTtZtoqA+IfxcWbw3Do2sFpRKoAtg==
X-Received: by 2002:a17:90a:640e:b0:2e2:c681:51ce with SMTP id 98e67ed59e1d1-2e3151b77e0mr23884426a91.1.1729156645101;
        Thu, 17 Oct 2024 02:17:25 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e094bd0bsm1354958a91.53.2024.10.17.02.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:17:24 -0700 (PDT)
Date: Thu, 17 Oct 2024 18:17:11 +0900 (JST)
Message-Id: <20241017.181711.1319333992452672716.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/8] rust: time: Change output of Ktime's
 sub operation to Delta
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZxAcJEDFQ-n64mnd@Boquns-Mac-mini.local>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
	<20241016035214.2229-4-fujita.tomonori@gmail.com>
	<ZxAcJEDFQ-n64mnd@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 13:03:48 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

>>  impl core::ops::Sub for Ktime {
>> -    type Output = Ktime;
>> +    type Output = Delta;
>>  
>>      #[inline]
>> -    fn sub(self, other: Ktime) -> Ktime {
>> -        Self {
>> -            inner: self.inner - other.inner,
>> +    fn sub(self, other: Ktime) -> Delta {
>> +        Delta {
>> +            nanos: self.inner - other.inner,
> 
> My understanding is that ktime_t, when used as a timestamp, can only
> have a value in range [0, i64::MAX], so this substraction here never
> overflows, maybe we want add a comment here?

Sure, I'll add.

