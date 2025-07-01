Return-Path: <netdev+bounces-202898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C125BAEF974
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0594618850F8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB1B273D93;
	Tue,  1 Jul 2025 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="koBgbaPi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA112236E1
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374721; cv=none; b=Ws5sCG9EUyuHAP+jUFcOEHfep8/yjMhRrp7nvQeufIZ+agB1AshaX+5RE/1Tf5A8xDZ/ZETS/twWRgy/zw2PtJK4XuMZUlrUusz5LJMzTWET0Pmvl29CHNur7ep6KDQ2z4eFPV2flKgtLzeZXeNOSUF070jAXDIhEC4d6coltVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374721; c=relaxed/simple;
	bh=mIP2s1TIthBEoedLW1VYusPCUtoNbQjNy0tejxxUJ7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIAuHJd+j7jq+BHkDB93SUOgj1tdBTyfJW0URYOf/4mR/bbBmjmNzY2NK7HnK1x6qT3Uo99axW2wV+F0se2aSC3QwlzFieJLTeeVbSw/6ajFgBuYjoJWftEW+K5FSlCjQy08dACvyvGZYmdw0DmP1ho3Oususgfh0pvua+BCf7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=koBgbaPi; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d467a1d9e4so69570885a.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751374719; x=1751979519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ze37IfwTGTYDkV93HxTMG5nmfcE/GkCokySJR9DGq40=;
        b=koBgbaPilZsjM4+N5jM+oqS2ODrzlKeFZyN+yCZZfxr9zc7k6KdDPwdJblTnEiANTU
         HnuHkbLV9dSLqSQjFiGZb9ZzvMARwPaKxiTuUVZIUS6iggyWVgVAWKD0G2ZfRdEe+mHX
         K7QXvxy/Z/JGH9SMnX90ccltLMI4UxCZhY+y+Vh52jbnk2Lkk9bjJCXEPT1pK9fBc0vC
         zKqDtcTgPKuQ+/w6OxNLbFZ8wo9HjNtWuDnYBsMKrNibC+OuJHhIH3Gry7VXZOrwX1CD
         oGmL8bCtxhfTXp3T9SYH9kBmPmjDU52R13O0mpMEu9oefBreyqwDWxHRB/+38ox+zpJV
         tCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751374719; x=1751979519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ze37IfwTGTYDkV93HxTMG5nmfcE/GkCokySJR9DGq40=;
        b=BKz374QJOgvRwIKROz73+Ln80RFevEsR9kxMv2ykWriFbuiwaKmxdfV0YYrkJfqBvQ
         QcXo4xNK4UWwseStuunfKOfWU77kCNHQ6H6B9xGDotO6PF9nlC3W7NILOVi99VisyXRU
         OHWctZi3hVNVFuLsK2g4ktAF2xWy5WzvpZ75u4Dl/TEYrFqQrHCv9vmASrhvyNWPLILF
         6Uy2b0BJ/+PAy1Np01qNP47Ep08TcXePQvsg48RfOMMCGit7hVvR5jY24Oprdj63N1Cp
         rJyJcW0iwIxkXIMcXpfKqJCkx75u9FD0W5OfNfCW+jjmYzsWd9jRzpMfxAHND7G6lgzk
         19cw==
X-Forwarded-Encrypted: i=1; AJvYcCVz14S8l+hIUTJiyRu5yOXgz3zr85Z/JhlZWWWXVuNsb7E/umaKbv642EwLqZi0JBo7a4/HuJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzboizIGcQ2xHQQSmo7zHBUxFkZcIkYWVKinEj5zx6Bqta4KSPp
	E/h471VD6GCD8ZEltZGT+KeCpyjpI6Fs6BXjVxJuCe3N2xOU8pl8x4b8YGPtzB+Vme2kRnxFTnV
	bOqM=
X-Gm-Gg: ASbGnct5pVBWtcONWwHjsg/VwRwjOwsNwbgY1iOFTiRQ8gueWlI3xN154g/hIC6YEUE
	QB+gS6iZ9bhk1rMnqGSe5Fl3UaQT9jiU9hO1XTJAmYRuJOFAy121UwxI3G8cob4s0+NXLP8RgE0
	zHPgaL8twbUDPDkRglYk9yh4mpCqCyiAUSZFn+qFfakSJdO7fnWmhtUDduF+jzbAvnIRK+DxSLl
	FP12GfjSW6h7hYNGx93kWNt4rc4cEd6Nv76ixw8jBQRU7o2VUiSL/Q6wsXIGu9sNhfidAvLxfZH
	59BV0B03TZ/XwVA5aZ8nB/x/q6HJx7BwMNpe6LGAK9FgA9BDhrIXdTWuKkJxEOtxmrZ9BTAA/1+
	a2thz1e5rZHWw3jC74bVYL37eUIwnog==
X-Google-Smtp-Source: AGHT+IF9nRaLL1IcDFwlUDmDehyYO3oDlaIYVuKBP1yWmFUiLDwz2KPs+TnD+zB75w9A+bS5jCD1cg==
X-Received: by 2002:a05:622a:115:b0:4a8:1951:de with SMTP id d75a77b69052e-4a82eab431cmr50847661cf.18.1751374718679;
        Tue, 01 Jul 2025 05:58:38 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:ca4a:289:b941:38b9:cf01? ([2804:7f1:e2c1:ca4a:289:b941:38b9:cf01])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57c537sm74512971cf.57.2025.07.01.05.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:58:38 -0700 (PDT)
Message-ID: <13eecfb2-7609-485e-9ebf-fb3065cf10b5@mojatatu.com>
Date: Tue, 1 Jul 2025 09:58:35 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Lion Ackermann <nnamrec@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Mingi Cho <mincho@theori.io>,
 Cong Wang <xiyou.wangcong@gmail.com>
References: <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
 <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
 <aGGZBpA3Pn4ll7FO@pop-os.localdomain>
 <8e19395d-b6d6-47d4-9ce0-e2b59e109b2b@gmail.com>
 <CAM0EoMmoQuRER=eBUO+Th02yJUYvfCKu_g7Ppcg0trnA_m6v1Q@mail.gmail.com>
 <c13c3b00-cd15-4dcd-b060-eb731619034f@gmail.com>
 <CAM0EoMnwxMAdoPyqFVUPsNXE33ibw6O4_UE1TcWYUZKjwy3V6A@mail.gmail.com>
 <442716ca-ae2e-4fac-8a01-ced3562fd588@mojatatu.com>
 <aGMEsnYnv0lwBTcl@pop-os.localdomain>
 <2937fe13-d65f-4cb6-8535-3084b29af541@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <2937fe13-d65f-4cb6-8535-3084b29af541@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/25 09:41, Lion Ackermann wrote:
> 
> On 6/30/25 11:42 PM, Cong Wang wrote:
>> On Mon, Jun 30, 2025 at 02:52:19PM -0300, Victor Nogueira wrote:
>>> Lion, I attached a patch to this email that edits Cong's original tdc test
>>> case to account for your reproducer. Please resend your patch with it (after
>>> the 24 hour wait period).
>>
>> Or send it as a follow up patch? I am fine either way, since we don't
>> backport selftests, this is not a big deal.
>>
>> Thanks for improving the selftest!
> 
> Thanks a lot. Please just post as a follow up then if this is fine.

No problem, will do.

cheers,
Victor

