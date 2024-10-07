Return-Path: <netdev+bounces-132584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CC0992412
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7EA1F22EAB
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 06:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63AD52F76;
	Mon,  7 Oct 2024 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc8juExq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F8A31;
	Mon,  7 Oct 2024 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280915; cv=none; b=lQc5Evg4yaPlq2nVLpTzkR8UantXbf6IVIMcPvsyHpSCH57mCBkqnXY0sFmbJNSu+Acu8W54Xq0vbhCLVsbz9ktNL/SQl8OFVN785uBGaKmcdL8kCOYfaT1nARuxwyKWrqvz+koFdGJ3MZ7c9XUMX2T7JIqbgEpOuPT6+Kfud34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280915; c=relaxed/simple;
	bh=KYNOeI9N+sOifMy5pLstLILjwARWC2MFr7qfMAQ3dI0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GCkUY2Sb/rostgandzmfB6OdexPTAdb3jSo8koIs4Qr+vK4jsfJdE4A64m1tdIruK5M7F8wloMq1zzu8yTZi0nOUVSKZpa+3nKrHnKXuo2k8yHhbkCnEWXixDfNBtRbw/pQvwfUovjgedcIR/IzrUIYLNGVP0ksFOO/cXaKqe08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc8juExq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e18aa9f06dso2816211a91.0;
        Sun, 06 Oct 2024 23:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728280914; x=1728885714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzX0UywappLJKLK2XrwCSa+6DnJKn2Rts/dAW5nMYjU=;
        b=gc8juExqCbDSgntNZd5jAOlKPApeI+JMcuZS1ck8EYn9JEomLj31Y1o8azR2TzbWqS
         W3wf1p8z7zI1k9UIjp8eFnUH4EOifUMk0ohBcTzUBdf/jLg+fAjauGOgAT5Xc/sQG0BR
         OmxNMBnADuT8X+T1jmRzKDkC6Bjue5nSJk0KnSccbLLcr7TuA0Ig0ffOMwxkwIHp4/VC
         50Ku/j4IZg9UzSKIUKOnVuM6A+zpwMFVFd7txSuExmMDIOKdfuvGcRCt5QVH4HZq60nj
         Cfy1i0cO6NDpU8iYI3nLsDIuAl6pujWNmp6+z0VhVSD2CuPxQIh1M/Tbngrir+SNPyF0
         TXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728280914; x=1728885714;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QzX0UywappLJKLK2XrwCSa+6DnJKn2Rts/dAW5nMYjU=;
        b=nKW8VbVIljmNJQhvp0QuvNbEbaoX5/vDmAhuBzeC/0Ywt7/ok5SdFRqmdwv3lHs4V0
         M9uTaygBq/X8vk/Ych57Ww4BJjDUdzLolM/obZIFXLoPTydqM8cj1EW56CzwHF/85ZFa
         PcixoqzL6lbiXzuEo68hin89wVWiSPU2swbEUuJvTUVnLt0+D+8PHqPZU4rm3xjgceZh
         VN5kISYKgrnvyQBTNQXxBbMf+Ft94QBnOR9DIZlkLFV/r8taW1ejDOEE7JVZAA1ZaKNZ
         pAkpGpNz5HiV6Sv47Osw1fxkZbulD7RdSSYcfT8Z1s+M41W+MLd5m6qzpMNTnWndxYo3
         HdMA==
X-Forwarded-Encrypted: i=1; AJvYcCUGZcD6+UbjJapSifgJ2sJEdxjS/vGygNJV3n58OznK0KBSKbeARmHX+l+SGXeSHfPeC2SqbC2LA+OpiLF4rkA=@vger.kernel.org, AJvYcCUgnNey2IAuh9+YDpfF1sX/bexsZkazBSkT8JXWx/ar0a3MEsz2OY+njfYhtKDacdNSIxNJwsIlVNeHaHY=@vger.kernel.org, AJvYcCVZLFATdJcqwtrpPTwBUfzBloGi6vNldDxpT7XaZSvJLc3eDF5ZVLIDMu1TtEFlQeNNHOJx/pCp@vger.kernel.org
X-Gm-Message-State: AOJu0YxESQzqLVPMG03ifCGTw4qy15EWNYBZLq6ZsZZrGjUnuctzaasX
	5gNd1DwG0+/XFEjGAbPnUWUIfeI7zkaJTdIXfUSn01WFgW9mq0wt
X-Google-Smtp-Source: AGHT+IGdElkbOFUhxRqqOKaFkrVvZi9IrVm6Dj0UpNbZIP7loO1uN+Yr9NYs1JnsBE9EtInnvTOHfg==
X-Received: by 2002:a17:90b:3709:b0:2e0:7b03:1908 with SMTP id 98e67ed59e1d1-2e1b38c7582mr22177385a91.10.1728280913706;
        Sun, 06 Oct 2024 23:01:53 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138d0cbdsm33022735ad.113.2024.10.06.23.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:01:53 -0700 (PDT)
Date: Mon, 07 Oct 2024 15:01:48 +0900 (JST)
Message-Id: <20241007.150148.1812176549368696434.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] rust: time: Introduce Delta type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <3848736d-7cc8-44f4-9386-c30f0658ed9b@lunn.ch>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
	<20241005122531.20298-3-fujita.tomonori@gmail.com>
	<3848736d-7cc8-44f4-9386-c30f0658ed9b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 5 Oct 2024 20:02:55 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +/// A span of time.
>> +#[derive(Copy, Clone)]
>> +pub struct Delta {
>> +    nanos: i64,
> 
> Is there are use case for negative Deltas ? Should this be u64?

I thought that logically Delta could be negative but considering Ktime
APIs like the following, I think that u64 is more appropriate now.

static inline ktime_t ktime_add_us(const ktime_t kt, const u64 usec)
{
        return ktime_add_ns(kt, usec * NSEC_PER_USEC);
}

static inline ktime_t ktime_sub_us(const ktime_t kt, const u64 usec)
{
        return ktime_sub_ns(kt, usec * NSEC_PER_USEC);
}

>> +}
>> +
>> +impl Delta {
>> +    /// Create a new `Delta` from a number of nanoseconds.
>> +    #[inline]
>> +    pub fn from_nanos(nanos: u16) -> Self {
> 
> So here you don't allow negative values.
> 
> But why limit it to u16, when the base value is a 63 bits? 65535 nS is
> not very long.

I thought that from_secs(u16) gives long enough duration but
how about the following APIs?

pub fn from_nanos(nanos: u64)
pub fn from_micros(micros: u32)
pub fn from_millis(millis: u16) 

You can create the maximum via from_nanos. from_micros and from_millis
don't cause wrapping.

