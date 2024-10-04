Return-Path: <netdev+bounces-132027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC2D99028F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136B12814BF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC12157A55;
	Fri,  4 Oct 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V27NLFGp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95EE1D5AD8;
	Fri,  4 Oct 2024 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042880; cv=none; b=Fe4p1bD1e5ihmWUWS4WcsbVcoGWAMZBNtt/4rAQDti/3pppcZNOMoskv/d+1o/tZeM/Cf54j7+qQtU8p7ha3IbApw0l4cnydD+V66DdLnCBQboj9/z4kuB6xn57lb1ckP9h1SHA9PhGT/+ftZf1E7sKtGsWbrXD0iQHfchYsi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042880; c=relaxed/simple;
	bh=sHRBsB/oGW5le7rUFRUXFj8GboC8+t8iEiU/5DXhNQo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JULbC3KLjmlOtys0AA/0gLVQQvbdObf51IAMePQCli6K/if/CHHvJr+6gaUOU96ezccaL6meDTt1rWn1LUzkvHHkQXnKbdlfPob5xnwe34bgRywYcha2sS8vug5sJhLHyTwUXLWCM/4A0Bapuh1Ljh9FtFcjKszEcrpoRQEbMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V27NLFGp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b7463dd89so22310865ad.2;
        Fri, 04 Oct 2024 04:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728042877; x=1728647677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yho47xxpxZXj0wsbEKv5wRr2EKRrQWlShug60WMwDfk=;
        b=V27NLFGppT3mREb89M6F4eOzsKKqPwfyJxaJHFlcRzkpsko+ZLPVvCZ3sZW89fKAJB
         J30+8Yrhbvc6JAq51T9N3carDiMelqrAf0Spzp1Us/1Ll/JSyRdvCPBhRI7DKtDAISdi
         G/zwhLm/EOLlofIaXp42iTu48dBQIdAt5ri90KOH4l3EnF3q9EA8rvKXJuHvKeB1SsE3
         ZbBlIbMYHRTvezff7ayUwdAiiUVw8uNQk1wwlappXLYuM2JWzO8+0+nz7vFBEDHRtWSf
         b0MAYSO+rk4LLq6lF9RrJzaZewHTIxPnameiaAURyD6AqOb7weHVPXCPg0HZaBtgf0FF
         jf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728042877; x=1728647677;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yho47xxpxZXj0wsbEKv5wRr2EKRrQWlShug60WMwDfk=;
        b=DrcT/qumrmUXynEEfkIwU/xKnvWnUurhUs4ajRtreauThL1+MXTCcLoA3/29CC+7El
         rjl4CZz9wNmG0gcePuiYh37Fk/UuF13d8yKpd8dKb+X+tw2a5FVMahalNGw4lEYcXxXv
         +IiqHRTn6FChfun1qlUK7Kb4tpDmxbdpT6bM/79BmitMID/cpvzxE3/Mh8dgaWTXjdQz
         vkwhsyoB+OHipNcrvsYvvi2XeSyj9E4lZOYlverXFZ68VN69fbEyCxc/miluoGHTHf+j
         mGmESrNdIv0kA4kCMTZxV26rjEfF1HHqC0arngnWGzj5223LcdxeJL2vE7bOdhvyLHg8
         J7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCU7GAoe4WIyJGatVBkPiIhMKgIS5Wc+5pUx/NbdxiocZdBiEK2xnfDtcEjsNLBf/MNVLWcfJJE=@vger.kernel.org, AJvYcCWz7vaPiLmuG/mJCCTyG6OO03FVs5++w4qPolzbEWYfV92dFjpvNHoD7a3kaDgG186PBF30oHbtGtQN5WhxMks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyToQGh8Kem+cfzE6yl65giOZAnqh167cHB0wHdJ4fBnWXJpLSy
	CNE+ctTmWrr4eBCQVlPLx3baYignSfIY5ox6NnxtxLXaR6Lch1m1
X-Google-Smtp-Source: AGHT+IGqj9IvqddoSchmXjdsu7q8P+IPa8Ewwtu+bxs5JF8TY+DmWxjgris3C4B96SjO795h5qSXdA==
X-Received: by 2002:a17:902:d483:b0:20b:93be:a2b5 with SMTP id d9443c01a7336-20bfe04ffa5mr35278165ad.32.1728042877036;
        Fri, 04 Oct 2024 04:54:37 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead499csm23031245ad.57.2024.10.04.04.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 04:54:36 -0700 (PDT)
Date: Fri, 04 Oct 2024 20:54:22 +0900 (JST)
Message-Id: <20241004.205422.282358302534878118.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: boqun.feng@gmail.com, fujita.tomonori@gmail.com,
 dirk.behme@de.bosch.com, aliceryhl@google.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: iopoll abstraction
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <f7906232-c2c7-4fd6-be6b-7e96bbfbbcad@lunn.ch>
References: <20241003.134518.2205814402977569500.fujita.tomonori@gmail.com>
	<Zv6pW3Mn6qxHxTGE@boqun-archlinux>
	<f7906232-c2c7-4fd6-be6b-7e96bbfbbcad@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 18:00:36 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> > fn read_poll_timeout<Op, Cond, T: Copy>(
>> >     mut op: Op,
>> >     cond: Cond,
>> >     sleep: Delta,
>> >     timeout: Delta,
>> > ) -> Result<T>
>> > where
>> >     Op: FnMut() -> Result<T>,
>> >     Cond: Fn(T) -> bool,
>> > {
>> >     let timeout = Ktime::ktime_get() + timeout;
>> >     let ret = loop {
>> >         let val = op()?;
>> >         if cond(val) {
>> >             break Ok(val);
>> >         }
>> >         kernel::delay::sleep(sleep);
>> > 
>> >         if Ktime::ktime_get() > timeout {
>> >             break Err(code::ETIMEDOUT);
>> >         }
>> >     };
>> > 
>> >     ret
>> > }
> 
> This appears to have the usual bug when people implement it themselves
> and i then point them at iopoll.h, which so far as been bug free.

Ah, in the next submission, I'll try to ensure that the Rust version
works the same way as the C version.

