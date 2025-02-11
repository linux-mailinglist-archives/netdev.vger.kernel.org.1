Return-Path: <netdev+bounces-165240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE67A313B2
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E960E3A209B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF7F1DF992;
	Tue, 11 Feb 2025 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M61+PM/9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7C261567
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297110; cv=none; b=mwixcXKsTWbRe2jKqlP1VcJIN9Yy+/HzCGsMPc0XC7wF9Vwr2s4udhSAwsEQhz+KPvpIEYn0nmMGE9/PIImrEJ7Y6bUOAmQYR1iJr4od/iVF0+zKy4Q8lY5cIblulSdACPaMsDO3XOI9ecHxP4FBhRwzCXYJbHva45cHtRQIJyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297110; c=relaxed/simple;
	bh=jF9lf/bkKyTubAzPIxFZ6TcYeUfoET/FNKTcO0+MPKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mD2OH/5q0ZNEoj5mFmbLFxZeqmSGIYzDu4+GW5eGxQp5IZLLCLK9y8JxdgvW+85dtYdKrBwQ4TmSEFurHZ4Lapw9pttZxuCzNa/E817HcGE2UbJz08xdp6gQYcZHC7Gi2Ksa66wBOsh0veIEZizzDjsOUrALblVgcHEKuEeuAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M61+PM/9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38dd0dc2226so3314495f8f.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 10:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739297107; x=1739901907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8SVaFO/cnRwgNka2nJtzNolfs3wZ9VBPCuFWitOulc=;
        b=M61+PM/9R1AeJJMwMwP7LrqZ5LHK5ZIiXe4WArb86hsG6l7AgMxXMCs1sduHvvtw1T
         Owzkr2ptnDLPrdGPG9OGNp5prkpK+E67ManR2rsNPKvxZ9HRGk6/lEd4na+q/dDJgZ/1
         ROSUaew2+FZvNV9+khwwbhxIvXEOySD15srQQnnhp7bwF3aIvFOgnVZXW2N5PTTiZHZh
         54ulGke0QJCjCSbTJCa6FCTbVQOtHeHOmiSBsNwuNRtS35wBy5cvjbJTqIsFFPE1kNAX
         grcPKQHJvJtER/dw+NS4dVtc4NiuX21xWdaJ0OTdcvKdcmC1W6xDqXXW47Etyql6QA+R
         oDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739297107; x=1739901907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8SVaFO/cnRwgNka2nJtzNolfs3wZ9VBPCuFWitOulc=;
        b=UEAB/DKbxcGG+ueRFMvcuUWYI7USROi2poSgreGLL0L6SXtVABvjayc5kqQ3LE+jQ8
         FGedO5vN4TtnQHEjU4mShnP/brYrKNr3NwhV70ubdhnne48E8bnyxXVlbZbCd8LrpiW5
         aovo4bgrfR45Iyhl8gMm3MGb7mkbUZakes3TekWnl26urnIwEO1biRljW8mxM5AZSQPz
         +/OOK2xKhqoGrGIk0fJHsgtqZ2qa4ac61sFcAKKYYsTnk02t8k0t51zQOxfNTLFcbEdj
         QnEQIY8LC9KKGOYFZNVgNtu9AuAbhScdhl5q+UBcs3X1uOSITNE97c+Hju+uQCG5kUSU
         s0QA==
X-Forwarded-Encrypted: i=1; AJvYcCU2M6sDLGEF/tDTtf8Ufx/kOrKW6ZNhXuGSUOi08Wg/vbFz2bbEbCTV0tm1k7dybVWON6DFHFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPax0zouJEvL6EDCB5bsex8H8F+SbphRKB0OkqnyKChdqsqA0r
	4b62ROzKWaP9p3n1+YcrEgwOtadMPOo3vmXLZ9Y2gvtdkZJ7HmM6
X-Gm-Gg: ASbGncuPIHnYwwKKTUaOdOehKKWkrgUN+wPW2FEUhvbhfQ2qWMKpSbjmbm7V+hn7+Lp
	lPUQTJK1GH1bxWIXRP50PfANfUBH8+CcOtY8bGqhf9xK5/UWy7V+QOJ+u5NQSBeuvuOoBHJc6Tr
	L75EEdILSqcG2Ty9gE7UrTYBGbiXvPNmaeIMzBsyYev73y4TWL4yt5I1xxwTOlVOosDfWGGzWZS
	+3D+YH4jK1AUlEdwa356qsyGOMOPSeWhjbSJzegs7dnbo8f4Cf/XeZbM31nNqZyXX9wINvBzuaf
	nXtF8zGxHkkOYIrs7W9sW4y9O9lrGbhJ3SMQ
X-Google-Smtp-Source: AGHT+IGkWNBAlWK8MRRk3RypR8yIHGYzLHFTLHg6rnKAj/gFhAHYLddeSuTDAUleKhV6+7OOZiks3g==
X-Received: by 2002:a5d:64cc:0:b0:38d:d18d:262f with SMTP id ffacd0b85a97d-38dd18d26aemr12778520f8f.26.1739297105301;
        Tue, 11 Feb 2025 10:05:05 -0800 (PST)
Received: from [172.27.54.124] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4393f202721sm84932285e9.21.2025.02.11.10.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 10:05:04 -0800 (PST)
Message-ID: <1c187a13-977d-4dae-a9eb-18ef602f5682@gmail.com>
Date: Tue, 11 Feb 2025 20:05:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] eth: mlx4: use the page pool for Rx buffers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
References: <20250205031213.358973-1-kuba@kernel.org>
 <c130df76-9b18-40a9-9b0c-7ad21fd6625b@gmail.com>
 <20250206075846.1b87b347@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250206075846.1b87b347@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/02/2025 17:58, Jakub Kicinski wrote:
> On Thu, 6 Feb 2025 14:57:59 +0200 Tariq Toukan wrote:
>> On 05/02/2025 5:12, Jakub Kicinski wrote:
>>> Convert mlx4 to page pool. I've been sitting on these patches for
>>> over a year, and Jonathan Lemon had a similar series years before.
>>> We never deployed it or sent upstream because it didn't really show
>>> much perf win under normal load (admittedly I think the real testing
>>> was done before Ilias's work on recycling).
>>>
>>> During the v6.9 kernel rollout Meta's CDN team noticed that machines
>>> with CX3 Pro (mlx4) are prone to overloads (double digit % of CPU time
>>> spent mapping buffers in the IOMMU). The problem does not occur with
>>> modern NICs, so I dusted off this series and reportedly it still works.
>>> And it makes the problem go away, no overloads, perf back in line with
>>> older kernels. Something must have changed in IOMMU code, I guess.
>>>
>>> This series is very simple, and can very likely be optimized further.
>>> Thing is, I don't have access to any CX3 Pro NICs. They only exist
>>> in CDN locations which haven't had a HW refresh for a while. So I can
>>> say this series survives a week under traffic w/ XDP enabled, but
>>> my ability to iterate and improve is a bit limited.
>>
>> Hi Jakub,
>>
>> Thanks for your patches.
>>
>> As this series touches critical data-path area, and you had no real
>> option of testing it, we are taking it through a regression cycle, in
>> parallel to the code review.
>>
>> We should have results early next week. We'll update.
> 
> Sounds good, could you repost once ready?
> I'll mark it as awaiting upstream in patchwork for now.
> And feel free to drop the line pointed out by Ido, no real
> preference either way there.

Hi,

Patches passed functional tests.

Overall, the patches look good.

Only a few comments:
1. Nit by Ido.
2. pool size.
3. xdp xmit support description.

How do you want to proceed?
Do you want to fix and re-spin?



