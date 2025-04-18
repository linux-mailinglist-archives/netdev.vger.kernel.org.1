Return-Path: <netdev+bounces-184104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEBEA93585
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4988E57FE
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4F120CCFF;
	Fri, 18 Apr 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1IQ74fU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B620897F;
	Fri, 18 Apr 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744969632; cv=none; b=o9PFsPsoEhqzjRYUEGq5F+CgLWufXWk9MtBg2lWYK9hUjDbca79rBcQCsmfJrYObDSYw0/BPigiTFn9BGcqDNP/T7rcRnsvWwxgv1UmA8XPrD13EwoEY8TxWOftEnswQL/YzjvVSyl0TeauJDii9GHMpZSGxiFYD2DduG7v44Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744969632; c=relaxed/simple;
	bh=IsdWxiZS31kfCBTYu3SYMt9D5lTJ6nKK4vWDaC+BEWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W62RzMrcgbljLZaBhaBj8qKITtx+pdPS0ZjQ9ZYmO/FvqAae3XXMjeXFZWpm8DzZRxBPvON5jVwIHIlj83ctROCi4jfZ5jHb43dXIxdI/ozxSTZTwCRDDdpiMH/O7DqH7ePa1nS9IplUa66Z5dbg6za1t6ZoZM/z3hcB5rojCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1IQ74fU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-aee773df955so2352354a12.1;
        Fri, 18 Apr 2025 02:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744969630; x=1745574430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFqtDSAV+GqgKe7cL0I+DybIP+9Z5y/azi2lPjnQI6M=;
        b=D1IQ74fU4kmKYu/JgYkyqV69kUY1ZF74/MSztXxyfuZ9puFZYMoZSpOew6Nkqp9+j7
         zDGKC7Rb1nnzsexoH0BKhPsNI2ekZ19A27B1AWR5OhRNmtkYHSKucxbnB93foSIx696m
         lQFRKoTXOK/0dH2EE0oLmMN8PtwzYC6XufS9KUNefROKyibj2XV7M05oRAZaJrF0Skwv
         oBdgG7s/JdnGKqCeMPB5fWl/2CbnemHQ+xK8cnu+NtWmXvhIkPtO2Keri1CBiztOcM8v
         3pEHUwtut16rUEWgb3IWIPz0eCWtwMWUbCc2a4dn4C3VYKF3kdmXLqfN2+6ova2gmaAc
         u9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744969630; x=1745574430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFqtDSAV+GqgKe7cL0I+DybIP+9Z5y/azi2lPjnQI6M=;
        b=TVzO1D38A5ZHaZVzDAlCzjNA4eFxtUBaEV4D4dK7OjVCkCNv4v6KkFIrO+qx4Ea8dN
         4JSL9+9rxZiXLUlBVMHcBlrD3uooIzdn4pafaMG+/PE2Tx9V5s4eAQ+c/+myLs0vUigc
         nTH1QkDB7u2xO0MR6U10Bn3I3VTQr9b0BElcCruCTn1KTAQ/N6LSTPrZAFjVG8sAMclX
         WzBRElKZM4Dc2ITxU1EjkB15w/ejZvoHWlrckZi0aAfrKUq31MFFfgoQ1x8p7o90jcpo
         p6Q3hCxmfKtQt3sOwp9PVt3XPBg1VsXjPFbK6QAfkKqzlzZciNDjej2K+SzoTJicsg4L
         e+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVjm4FfvBXyG6vG/3YBr9Zk0DmrK/61YuEjFABMjxEnqRTdW5eyTeErXXx6htFCyQAQwcCL3W+7@vger.kernel.org, AJvYcCXMCepMKnwLW+F56jQekO8u74qVT3J2S+kGH0MUkE8JJyGqFg+04HAYucJRXjsWZDexGDqN8zKGCjBUHng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzs18dhfPadkID2O1QREA9w0CRgOm61zmQJL+1PE12vdWgG2Ap
	sohNKGjwXO81fCQXMUahEgzXfQfgonmVHpcnoumHU7Fdh/Ls6m+78whcNeSM
X-Gm-Gg: ASbGncsv6qQOejsS2t0CVP9IiDjvSeScLwITJnTSF7S0EydUoav/vubqQ+Q24ioWBZV
	0rkcUcAL5FZU5+OnKCnMR6xphlWrkE2/3P42gvPnig3OCwcT39Vvn2JhrKC/1MWoE3FqO01u1ig
	MLFc6G2l/MH8eVcPRN3oA8PdfdMUzd3DSLMuqnR3zgnClYjos9octF/+K0OqVe10PyEvTETAcie
	S1wSyfYU7WMGG6avkp0b5PDSpZfeF1L3PQ/wSeSPrNqAiv3e6rrvWKCZQOlJoAp2gbPEniKxqOQ
	5UNc8BAN/OZ+I0AUPDTxNvnCb5pwmiEfj7EV8/Jbr2um0vwzU4bAQFOyOR/io62VNc5V9d173Eb
	/EWuCFgW6cFDi
X-Google-Smtp-Source: AGHT+IF4IuZ7FFRG+HATIJMT1B6LLqyPSK5ruvIyoo92+LPdf4kBWyVDYQRIc+dX1p9RW9k99YpPrg==
X-Received: by 2002:a17:902:f552:b0:215:b1e3:c051 with SMTP id d9443c01a7336-22c53e7a319mr25183695ad.11.1744969630089;
        Fri, 18 Apr 2025 02:47:10 -0700 (PDT)
Received: from ?IPV6:2409:4080:218:8190:3fb8:76d:5206:c8c? ([2409:4080:218:8190:3fb8:76d:5206:c8c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf3eb1sm13414755ad.82.2025.04.18.02.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 02:47:09 -0700 (PDT)
Message-ID: <9220c4b5-ba0c-4bfe-a6d0-5b52631f4ad8@gmail.com>
Date: Fri, 18 Apr 2025 15:16:53 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipv4: Fix uninitialized pointer warning in
 fnhe_remove_oldest
To: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <20250417094126.34352-1-purvayeshi550@gmail.com>
 <20250417220022.23265-1-kuniyu@amazon.com>
 <b137f4c6-9cbd-456d-b839-bc77d6ef9079@kernel.org>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <b137f4c6-9cbd-456d-b839-bc77d6ef9079@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/25 10:33, David Ahern wrote:
> On 4/17/25 4:00 PM, Kuniyuki Iwashima wrote:
>> From: Purva Yeshi <purvayeshi550@gmail.com>
>> Date: Thu, 17 Apr 2025 15:11:26 +0530
>>> Fix Smatch-detected issue:
>>> net/ipv4/route.c:605 fnhe_remove_oldest() error:
>>> uninitialized symbol 'oldest_p'.
>>>
>>> Initialize oldest_p to NULL to avoid uninitialized pointer warning in
>>> fnhe_remove_oldest.
>>
>> How does it remain uninitialised ?
>>
>> update_or_create_fnhe() ensures the bucket is not empty before
>> calling fnhe_remove_oldest().
>>
> 
> agreed. Not the simplest logic, but I do not see how oldest_p can be
> unset after the loop.

Hi David,

The loop always sets oldest_p when the list has at least one entry, 
which the caller guarantees. Smatch doesn't catch that context, so it 
flags a false positive.

Best regards,
Purva


