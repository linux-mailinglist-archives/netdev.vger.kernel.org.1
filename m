Return-Path: <netdev+bounces-152795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D1F9F5CCC
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837F6189298A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADC745979;
	Wed, 18 Dec 2024 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3VDwfe7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D543597B;
	Wed, 18 Dec 2024 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488726; cv=none; b=qsXf3KirBflxeSGxP0L0D1QQGavZZvrUCJOIYfzjLf7qx9Nc//1r6QHyypb+bEWp0z6GO1ChXQgwL65CIWsoxGSVsS3XPUipoDyDLEot4E9bfNXdE+rV1nh7+eYchyAyDUIWNZR+tGAPlEL78Jc+4aKDR6BygHsP4Ga28yfmWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488726; c=relaxed/simple;
	bh=71Dq6rzIOZ3NXz140Sm2skWGi7f/eobv91vUjfZ2K78=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kPmppzh0nDOC546E9ojTuBsNsA7Ao7iQmDNcftvd5MVcIihX6G2GsfdoQXRYd7F5SbnsGGjaVdKQIK8gwVSAhmywjk96nSSWXz71+7seDe7j3ODO2zUCuZO0LGuZZO2jWyP5znO78YkexUWljoYmsxXpvbozjZhlSEKHjjX1BQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3VDwfe7; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee51c5f000so4196251a91.0;
        Tue, 17 Dec 2024 18:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734488724; x=1735093524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7zVVV9lr0cdzHhef6MywPZq2FxB2TN+LVKaje4ZqYE=;
        b=E3VDwfe77Xbo1x3TUCXlnKK2hoPx3TbpOGr4eOg+Jn7z2M3M6r/TmTc9XF1/t/hRs1
         Ygwc7atgqbV34XnN4wQnEP17K5o4yrmfyQUi/R3WqtrcNEUJ9CXKkGlALSFSHXyZWWqj
         A9Cni3JfttNRzaj+PSWRNYkdKin0/uHy/wmAz5LxVa53cgi6zGtT/49Xap8zSV30hEN/
         LHC/OjZ4D5rZbGbM13pMkwdKTg8DjhKDUcrxpdFFvC64F38vCmP0YpJgTwVdhSEH+O/d
         /tfEvgmA+4wmsa16IfeUjVTNdNc9p1ryLRGPHTRMKKGzZ/sQ5c3zBs+D8F44aYM/GC/p
         nEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734488724; x=1735093524;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U7zVVV9lr0cdzHhef6MywPZq2FxB2TN+LVKaje4ZqYE=;
        b=DDuzgDeMgwditdM1rTtwmJiJRdukwHsToOc8ClqWyTnIfQjTBa/sqwcTPkXyYOuX9w
         Qf9dCPjpPX171cxZhx/ku4y8ToI+EUgQpbaOAkGuHYYxqLpTSyuoc8HbnVFPgMgAm0e7
         yQ4AdT7v2X2oYSI6LvUVlNT2Hny2Z0OiPU0W8Jauz37Yx3ghPpeurJhvN8mO6TAk6J0K
         cLSm3e8jf0eYVvi+AJ+xtW9Iw29acBznwJXH7XhCnij8YNXIJGXJ+J0jO2Kjouu8JJxq
         J5oplBVGF9tnmB4Wz6TBONza3nUTVXMhgWfTWb3S8ULmRtkcmrCYZ8iDWDfk/clpk/qx
         ZugA==
X-Forwarded-Encrypted: i=1; AJvYcCVKFfKmm7sjSNCDQPncZQN4s6rtJkk1IQxUZ3F8KA5s5ynMbLBA00PMgfXxrPQtxnqqgSlZ7mqgZljxtbDTNro=@vger.kernel.org, AJvYcCWAaK7SaNgXaetdd8S3Fd4bh4zrj7B121lWtXAekbyhNynp4RQiEzQXgjiIGV41fq7UkUoMyOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1pElM0vzuvZdm9lzAQ7yRas0VZVS+xgvZoQx8CA7OPJoQPKzO
	4sQGCGi056bEcnNHTsOrFjYw07hFZqnsjo66naRkcIu5lT8zGV6f
X-Gm-Gg: ASbGncvnsTi1SiU3ukb/Aka4gR50a+5ktxbAdXatITb2JEC6B0ptsT03cMAHUqs335I
	PolY4uFe+kqqEk+zbv3mQ+a/QlSC5KI5Fmr6tvpeUffdHkKb8FZibRaGWMDvqJU3MFm7hzicvkf
	MT0ZMzutYtHzsHcUIrqxKsOAA7OEqZ+6Oh/+vfJNX4zLuQ/UrUtasIa0mdwcANHiFG5M12O5maE
	xqX1cNBGy/7QKbh/qy1vwffn5WL5fUtD+jPEwHg6/WrEKC+83Rg1RroB/5AOPmaWJnQcHNmkFTy
	2RLTWVGIYyO+4Hul0g==
X-Google-Smtp-Source: AGHT+IEsPj6pDo840pSz/bOVARaDmCG/nbaH1I9K4ta3O21g2Z/LZ3uEm22JHFqk6NyJj9uz0Mmofg==
X-Received: by 2002:a17:90b:5246:b0:2ee:b2fe:eeee with SMTP id 98e67ed59e1d1-2f2e91dd06emr1883790a91.15.1734488724343;
        Tue, 17 Dec 2024 18:25:24 -0800 (PST)
Received: from localhost (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26b131sm232316a91.44.2024.12.17.18.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 18:25:23 -0800 (PST)
Date: Wed, 18 Dec 2024 11:24:42 +0900 (JST)
Message-Id: <20241218.112442.597481561044471700.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: pabeni@redhat.com, fujita.tomonori@gmail.com, davem@davemloft.net,
 edumazet@google.com, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, aliceryhl@google.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] rust: net::phy fix module autoloading
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20241217085124.761566e6@kernel.org>
References: <b701482d-760a-437b-b3fb-915dc3fc2296@redhat.com>
	<20241217074400.13c21e22@kernel.org>
	<20241217085124.761566e6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 08:51:24 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 17 Dec 2024 07:44:00 -0800 Jakub Kicinski wrote:
>> On Tue, 17 Dec 2024 16:11:29 +0100 Paolo Abeni wrote:
>> > > I'll look into it. Just in case you already investigated the same thing
>> > > I would - have you tried the rust build script from NIPA or just to
>> > > build manually?     
>> > 
>> > I tried both (I changed the build dir in the script to fit my setup). I
>> > could not see the failure in any case - on top of RHEL 9.  
>> 
>> I think I figured it out, you must have old clang. On Fedora 41
>> CFI_CLANG defaults to y and prevents RUST from getting enabled.
> 
> Still hitting a problem in module signing. 
> Rust folks does this ring a bell?
> 
> make[4]: *** Deleting file 'certs/signing_key.pem'
>   GENKEY  certs/signing_key.pem
> ....+.........+++++
> -----
> 80728E46C07F0000:error:03000098:digital envelope routines:do_sigver_init:invalid digest:crypto/evp/m_sigver.c:342:
> make[4]: *** [../certs/Makefile:53: certs/signing_key.pem] Error 1
> make[4]: *** Waiting for unfinished jobs....

Generating a key (openssl command) failed?

> allmodconfig without Rust builds fine with both GCC and clang.
> 
> build flags: LLVM=1
> config: https://paste.centos.org/view/0555e9dd
> OS: Fedora 41

CONFIG_MODULE_SIG_HASH is same on rust build and non rust build?

Looks like it's the only kernel config option that might change the
command behavior.

I can't reproduce the error with the config on Ubuntu 24.04.

