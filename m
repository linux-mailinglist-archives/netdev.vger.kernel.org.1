Return-Path: <netdev+bounces-140645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7739B7681
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF801F23384
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E6513A256;
	Thu, 31 Oct 2024 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lExqb/xF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851EA1EB48;
	Thu, 31 Oct 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363485; cv=none; b=er9irkbNkKsDWBoT5bo4wUTwmp9LbR81J5WzJ+V1DwIS3gdOfO2Q0JpqfKRJdqIf1zlGWNd0AfoiM0yadXf8sqLfdALWFa98Wc2WoK0OVN2Dn+D6u4dmN+2PQsYe9j5KvK8ZwPxNggWix6EUW1RNdkCMjpiIE0tXm0jFoKqJQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363485; c=relaxed/simple;
	bh=RrVh6paObLng6MITtP2Ne6UUtHn1hhLK61oceLKpZ60=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HT562sFjJCPesbbtkWUDxeoFdeMlKXmdjJLN94X9UvPcPKPYsM8gTKIKhzjZR4Up3hmZ5yFLWj8qAo63NbM2Hl25ldNNNQ0S+HyyNqmfguyD36hyHL4IgKD5U1y1coVDf0wHJ8AYCOv3chAgTOC+niwvYJNSo2aO4zDj9bNJGJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lExqb/xF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so518559a91.0;
        Thu, 31 Oct 2024 01:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730363483; x=1730968283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywj8wvzaQt63GgPIn1rB2LJiS4xtGBfmHV34wotqpK8=;
        b=lExqb/xFT2Q/WVqyWalYvOgSON0gaAWVfQhNNgnceP9O6gno7iTzYxfT7vbbUqhM1V
         5sqCNkFhsy0Y00NU2MU5VFS3LIELMnjTwpBo2e8CpnWY1tTYkuHNbfFWx4lUSxdsyV4Y
         Hl3X/yc9t5cYa62pVjNNUVlOZS2WVTjOc2NIDDNxiG4+3MWTIf8hACimisLYn1Kd871B
         EmbWrtlnvDF5yBzoRxnKS4VDo95O2HvMTmz5HmyRpiZr6rDGl1AbAxlmYXZx9GxWY0f/
         4EKWAu0HiKua0SfRaUpn7lsUFwBZ9V+allVgXOTtrYnmoD5ldMa9ZtM5jlFzEJ/zAAUY
         QJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730363483; x=1730968283;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ywj8wvzaQt63GgPIn1rB2LJiS4xtGBfmHV34wotqpK8=;
        b=QYIzdmSUAPDac1Iv3Z7iDbjryuH0AG4e7SUQZXuolq/WfmJzasHlAizlxda0ALBrJx
         csigGpn8XQlDXCllFF4kiMGVrWcEVHhFJf4GeZGiLEhu1T65rZMNu/TjQ0K1MRG/JAKL
         Vg+iu5A1WqHg9JFTRZDSKnE+0ettlwOvPO1ZfJl59jh1u9dVza87N23ecg6jTcq0wK29
         7AwjChc7yvKDQ+AaucJqwvtH23tZ9qDj4DDhPJPRgVcn3rQM1BsW+4fHN2q45qHByDml
         +VXZmbf7HsLhKESsOuXQkXzA70Nl0cRSe74lRbT+Urf0N9ZuypDhU+El6S90Ncrr+NQR
         LNcg==
X-Forwarded-Encrypted: i=1; AJvYcCV0GRXxgtj20KcFH4ndawF+gmqaFLUNckU8iRpxKLVlJEKHCmYccPoLiADbYmZ4HTaFWsqGkO2B4ixxelA=@vger.kernel.org, AJvYcCVlNsEDuAh775XPlIXRBh3y9AgVTl2IxrC2YeAoimW8LgUZYS258GIlnKWMMNnmn4ps2nFzbCbU@vger.kernel.org, AJvYcCWs9kANMBtUU5GdVEWb6x64OiUYJ1mzn2e635OqnhXMwS3b6N7z9Zo75B5HtQfUJ5E6vAB5drhV3juGFM2+ppA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzngUKzj8z+ORIbI2/4511YDiq1y/rpqP58MYzU9Sc1SCAPCqHk
	BekRFOrGfSEzq41GLheTt8VTlMAaqxpr1DJN6SEvSL9FU9rejGAr
X-Google-Smtp-Source: AGHT+IEDacsnggjecQc589iBpUB/jvOmBKjocTK0/Ghvd5+tRxLchFB4Asu+ohlz57HSIXsqLbmb0A==
X-Received: by 2002:a17:90b:19c8:b0:2e2:da6e:8807 with SMTP id 98e67ed59e1d1-2e8f11b8b8bmr20318847a91.26.1730363482662;
        Thu, 31 Oct 2024 01:31:22 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db4296bsm784451a91.48.2024.10.31.01.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:31:22 -0700 (PDT)
Date: Thu, 31 Oct 2024 17:31:06 +0900 (JST)
Message-Id: <20241031.173106.139587822701597209.fujita.tomonori@gmail.com>
To: tglx@linutronix.de
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com,
 anna-maria@linutronix.de, frederic@kernel.org, jstultz@google.com,
 sboyd@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Subject: Re: [PATCH v4 4/7] rust: time: Add wrapper for fsleep function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87cyjj2vi1.ffs@tglx>
References: <Zx8VUety0BTpDGAL@Boquns-Mac-mini.local>
	<20241029.083029.72679397436968362.fujita.tomonori@gmail.com>
	<87cyjj2vi1.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 08:55:50 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, Oct 29 2024 at 08:30, FUJITA Tomonori wrote:
>> On Sun, 27 Oct 2024 21:38:41 -0700
>> Boqun Feng <boqun.feng@gmail.com> wrote:
>>> That also works for me, but an immediate question is: do we put
>>> #[must_use] on `fsleep()` to enforce the use of the return value? If
>>> yes, then the normal users would need to explicitly ignore the return
>>> value:
>>> 
>>> 	let _ = fsleep(1sec);
>>> 
>>> The "let _ =" would be a bit annoying for every user that just uses a
>>> constant duration.
>>
>> Yeah, but I don't think that we have enough of an excuse here to break
>> the rule "Do not crash the kernel".
>>
>> Another possible option is to convert an invalid argument to a safe
>> value (e.g., the maximum), possibly with WARN_ON_ONCE().
> 
> That makes sense.

Thanks! I'll do the conversion in the next version.

