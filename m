Return-Path: <netdev+bounces-114746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D755943C83
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0914EB27317
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 00:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB101C232A;
	Thu,  1 Aug 2024 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFMZTY2l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8114D299;
	Thu,  1 Aug 2024 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471437; cv=none; b=Zt0GK/A386q6RbUcpV9Bs6th26ktW2CAxutgzfYYSS4vFQ4p+34clqZjN6SamU5ouAhSVLzIfZ9jCuozLhYMYXI27XBVmNkzvfZismN0WHKIzLJlkBibOMBuemxppf5qR0K4SOSJOLbl88f19+uHIRUYVPP/nlJ/WWy/gzwXCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471437; c=relaxed/simple;
	bh=IYspwW7YNUrm7Y1GNVql7lY5g17MF7Ugyk3VDZ+psDU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u9eRrtZXHF1lKaVkuJsNBy6v70pJpbKkyCaIU+KElxAnUjOfADHpURKvFBeACsIqftsdQWYvV5X7JbFPsbcJ/YpUWfKSGbO1QnSgSspdDPG+gDbhAJMwGf1Qd2bOsG7aMIaq62Owj1Z4FWRJD8P/7x/zw5GgxuiMJAHtZ7vD0nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFMZTY2l; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc71a8a340so2713145ad.1;
        Wed, 31 Jul 2024 17:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722471435; x=1723076235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyeC2as6J/faxOJNovA3/AHFf6/+t2xx9LH6kiJNvMM=;
        b=dFMZTY2le9GIW6xS3hxDXAPQ4bB8C5sKxnv5SXmuXoCWS+oBvqvSKCIk/cRduN5nxI
         FOs9ynYfR0rLM/j01EjWvkNl4bcQkiUhA196CTIhD/Nr4yPjyho8+y1+r+nRIhCktz5p
         YZmaWM3vhN1vVSeGP9WzhahOql9idGa+3XPAbI4Ymb+rpm48FGGlTlupsu5Hv90+b+iB
         lJGIY7GDE4dEeE6mbTLtS95Usg5QtDgn/SLFgY/mkhk5nLhr7B2vQjhtMF4y49Xf5U2t
         V/Fm9TZc2zSs0C59htV+JforWY59hr7WuqfvKWNxC/2YYkddBwITb/quDum5nPVonSjA
         Mn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722471435; x=1723076235;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jyeC2as6J/faxOJNovA3/AHFf6/+t2xx9LH6kiJNvMM=;
        b=aHCB0vyTAPXvQpKgfNnDjtPuqDEQJuMtQGpd1Vd2wpWPPgR/olxwK1lUoI+32QTjkV
         No4fCQT5QkqGKPTbvToD7mOny1zNRTHN5nPWQLtq+c95KWWQKHelFM4t8fSpaA7M9QVF
         WrMn7+XyvLgOJnmZwIeNCaS0wRPuJQ1u89r/vXH8QLI1TAO0vLmj9TznZ25BY3pPoMe2
         sK+dYc7Lovs0m8XRMeu8jEG4L0e563rS4m/+dDagPlcxJUSM6HJ8rT7YUXYNu14WA8tq
         zKm0Bog4YpdDmjYvtH+ek5t0miMp8gC9R33VoajX3lvhFM0t9el8uuIQ60vTua/HNP+m
         f6qA==
X-Forwarded-Encrypted: i=1; AJvYcCWCJPMg/HmwRHpq8sZS0b8dFzFNXdhfKh0JCDgdeGf8S/omiguDbqd/j8yD5ABJQXAK9qRcUrkYNV8clG6dlU76XhUS917wSkmUx0Mf6EwAYyOxH932mzPuqVi9sOXbK4FPOsK+YNg=
X-Gm-Message-State: AOJu0Yzg1PDOcUvY8o5PseA53JjSnHUFV9jG+bIWx8PhjTn8zK0ohGrF
	KGL+NimYkrXJCggBWQlhf/5BPMtBWp0LtOXHQqWXfmKhyq45pA1e
X-Google-Smtp-Source: AGHT+IEPlqE26PRl3UcExmIQABRt+N+m77HDAvY37g1w1IV6BuMu971p/5e4UhiuYtIfMlbAaxLqKA==
X-Received: by 2002:a17:903:18d:b0:1fb:1d7:5a89 with SMTP id d9443c01a7336-1ff4d207bdamr7190555ad.5.1722471434829;
        Wed, 31 Jul 2024 17:17:14 -0700 (PDT)
Received: from localhost (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fda4sm125958135ad.22.2024.07.31.17.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 17:17:14 -0700 (PDT)
Date: Thu, 01 Aug 2024 09:17:08 +0900 (JST)
Message-Id: <20240801.091708.676650759968461334.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me
Subject: Re: [PATCH net-next v2 2/6] rust: net::phy support probe callback
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLggyhvEhQL_VWdd38QyFuegPY5mXY_J-jZrh9w8=WPb2Vg@mail.gmail.com>
References: <20240731042136.201327-3-fujita.tomonori@gmail.com>
	<5525a61c-01b7-4032-97ee-4997b19979ad@lunn.ch>
	<CAH5fLggyhvEhQL_VWdd38QyFuegPY5mXY_J-jZrh9w8=WPb2Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Thanks for the review!

On Wed, 31 Jul 2024 14:32:18 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

>> > +    /// # Safety
>> > +    ///
>> > +    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
>> > +    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
>> > +        from_result(|| {
>> > +            // SAFETY: This callback is called only in contexts
>> > +            // where we can exclusively access to `phy_device`, so the accessors on
>> > +            // `Device` are okay to call.
>>
>> This one is slightly different to other callbacks. probe is called
>> without the mutex. Instead, probe is called before the device is
>> published. So the comment is correct, but given how important Rust
>> people take these SAFETY comments, maybe it should indicate it is
>> different to others?
> 
> Interesting. Given that we don't hold the mutex, does that mean that
> some of the methods on Device are not safe to call in this context? Or
> is there something else that makes it okay to call them despite not
> holding the mutex?

Before the callback, the device object was initialized properly by
PHYLIB and no concurrent access so all the methods can be called
safely (no kernel panic), I think.

If the safety comment needs to updated, how about the following?

SAFETY: This callback is called only in contexts where we can
exclusively access to `phy_device` because it's not published yet, so
the accessors on `Device` are okay to call.

