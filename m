Return-Path: <netdev+bounces-145929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCEF9D1526
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB577B2E5AF
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1A1BBBFE;
	Mon, 18 Nov 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kT4Vfeyj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7BE199EBB
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946206; cv=none; b=GaycAyY7gOv14tST4pMnhWrVsZK5zA4ocyzZzJiaOWZlnwgQr+rLfm3V3aDo91+C/07bfyUPbzNGzdwszJ9wyDI4oBJKN403qsLFVU7xN7o7JF3r320vC6ST8ED3UF62gNeEHO01OhrOGvhzCBtOaBon6d+m/2zb1UdIZ71k4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946206; c=relaxed/simple;
	bh=QfPXYHL5fsdkIoYd0xVznS8WD1LBbFDqzny4ASgLKbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccbVm92pVcQkJpGBI3Kdhdmq5qWyQR0lD6zPRHzGPpd53rMt9F9HQ1X0u90Cn4sIeN+/HJBaWKlkINS2JLBSmA2nBJkPmddufQjtCIbT3rkDx4XsqjHve7yoXabl01WQ1WeFXUmdheFafOfXguOazfcGa9SQCSaTCd4HvToFUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kT4Vfeyj; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ebc27fdc30so1961160eaf.2
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 08:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731946203; x=1732551003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEQPAT/nZnphZ6rlK9fU/8h4DP7I7h6rQ06FLczHMWs=;
        b=kT4VfeyjDq2hCSc49aJrxb/3/ICQKZs6xx5e/vL8xTGZWjMlcHNC9/e0kbUECv3h0T
         +cuuysC88gtsxqoM0WXgpIGE9TNRFjwo75tqNVRldkEvF7TLksaO59Mp7/HhlUq7UU3n
         Rshp9A1IgKsM3XZADnTFgpHBoj+kVUsBGW8byq2V8HB2Tk2YNT7q6ta4bB0zyoF6aQgC
         sNaVMoITA5GVPVx1+XZIN52ATzc+I25GBvJBnyedzQi1MvWAA4Yth7RtuOhXCjhw4I9d
         KttJNal6oRolNDWRxxxkpfmOUX56rwyR6z3AVK6YstOgilx7+LuEIMKPykxS9AZCFrIK
         yN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731946203; x=1732551003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEQPAT/nZnphZ6rlK9fU/8h4DP7I7h6rQ06FLczHMWs=;
        b=RhoLZlAv19wGHdIuXwOg9A8f4OrLYrcaUESZUOgJt2UfdWoHe2xa0OSvLcYObWN/xS
         +Q3ubDtVW5ziQPlCLTSuF8yi80AkS8CiGtMxRkI4uS5mJDYRklZJz7hcUbxBSxFCNKwt
         KuclVIAWv5PA9+mMksFJoF1UIjuj/pHOQTN3Z1McCFkwVNInVSvKhF3+93BrWjPytGQz
         nWT/sl1FPDnx/yQnIpc4QjSNap/P8CDvTvnJyfxBhvrMv0+STjtKYaO4MU/CLCz2Fyqc
         JPyfpLlmJWHIK07mkWkKhVv3LhpWcNb4T3lN/zdWYcl1idf9n1RL3JKzCm7Zhmri64sx
         mAlg==
X-Forwarded-Encrypted: i=1; AJvYcCX+PGQhEytG4LFyUCyingGSLNw7IM6yg2l6izrDKtswNrVJOnSRFoQVkQSgo9BNPa0IIIhU13Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEs83cqIrgBGCArzJ6ZKwLV7mo966oB6m9qML1uBPRAr2O2A6f
	4mm026nzKe1XTtGfPZGkCclnbOzk7Wjl0Tw4hm/8YOs/7EXnX/QL674fF+2eRDU=
X-Google-Smtp-Source: AGHT+IHhbH8HnsWWc2oM5+X6l6Jxm01cBB+zT4adkJw5m0vc06zcpCay0UFQ6Bdl2zk+kGL7rOU9RA==
X-Received: by 2002:a05:6820:2018:b0:5ee:bb2:bdd4 with SMTP id 006d021491bc7-5eeab294512mr9840034eaf.1.1731946203194;
        Mon, 18 Nov 2024 08:10:03 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a78214f08sm2768949a34.70.2024.11.18.08.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 08:10:02 -0800 (PST)
Message-ID: <db75c787-8deb-4522-b4f7-ab26b164fce5@kernel.dk>
Date: Mon, 18 Nov 2024 09:10:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rust: block: simplify Result<()> in
 validate_block_size return
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, manas18244@iiitd.ac.in
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Anup Sharma
 <anupnewsmail@gmail.com>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20241118-simplify-result-v3-0-6b1566a77eab@iiitd.ac.in>
 <20241118-simplify-result-v3-1-6b1566a77eab@iiitd.ac.in>
 <CANiq72mzCSmLG0_Vqu=sCO7TBPzXtea3HPw5TjT_gYKEh7_1NA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANiq72mzCSmLG0_Vqu=sCO7TBPzXtea3HPw5TjT_gYKEh7_1NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 9:05 AM, Miguel Ojeda wrote:
> On Mon, Nov 18, 2024 at 3:37?PM Manas via B4 Relay
> <devnull+manas18244.iiitd.ac.in@kernel.org> wrote:
>>
>> From: Manas <manas18244@iiitd.ac.in>
>>
>> `Result` is used in place of `Result<()>` because the default type
>> parameters are unit `()` and `Error` types, which are automatically
>> inferred. Thus keep the usage consistent throughout codebase.
>>
>> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1128
>> Signed-off-by: Manas <manas18244@iiitd.ac.in>
> 
> If block wants to pick this one up independently:
> 
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

I can grab it.

-- 
Jens Axboe

