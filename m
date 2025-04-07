Return-Path: <netdev+bounces-179861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AE0A7EC26
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E491887AD5
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C4B26137F;
	Mon,  7 Apr 2025 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDe7pOnG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED82550D1;
	Mon,  7 Apr 2025 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051238; cv=none; b=Lup4f+hRuKBCw3nSTIHKHyVO4Km3UrjwKdm6atRqpCQd028Pz3WhNf+SxPevUPbnAMSamba+bO3ZbdqcMxhsWHbrXABPTN6EccbxVCtixFd5PSu+X3Ni2mBS2R50lU25AUQbXi7C3h7BoICAMExg4JlzkvgUQPRr1+y8P/W8yQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051238; c=relaxed/simple;
	bh=KVvTyyF0VkafWFfOugua/YDD0iLrXHMzMWGuCOsrYSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQugTYZ7unLP0YaJTqRdajapxPq4wEvXhffo5AKHvu7vkfS0TS+hQryhSyP1fi6rR0zX4AjZ8z9FLvpNUQEG9TEho4iwBgdgbluNg8hG6bs22k0JGnlpIL+jhpEmEt/yxuImaM6BCngF7BkdiNjYWpaseRr1cfmSckO4sj8I4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDe7pOnG; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e6df32ad351so3867835276.2;
        Mon, 07 Apr 2025 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744051235; x=1744656035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KJ1Yxh0RTA5B17N4EwbA//OrbDLUv7EVB4eL3fHgUo=;
        b=dDe7pOnGefynPP4DrcE7D5MGivvfnvbWok0qT64HCzgLODhPBiyp0z7Lds5tYJjayf
         n1U8GnruNI9s+9eKDq15Dvhkn2Zn5E9i8vNRbydtkMDFvwKMiZSEXx35TKOqLTn9qAEz
         6eq8qrhtG8V8PvvrrOPeB/c0/mb0Ly2rdRjmudYZfFGSYl8xJEeFU/CXOghvU028R2Gb
         VgZ8OIhMDypQsrBdVwKPbH1i7ZWlWD+QZAg+exz/maz6m2A3OsdhFMqWUiPvWr9hsdRA
         QKepbqiEl+Bev0fvI2HQOgsY6x3DMrNgbEzoj3DWaFfA5gQwLenZWa6aSU8HJ6t7+7Bo
         omqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744051235; x=1744656035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KJ1Yxh0RTA5B17N4EwbA//OrbDLUv7EVB4eL3fHgUo=;
        b=S304U+/NT8+nPnsXy8RrIdAaMVgZIxm/tcCMXwDGk5oPWhu2l+fHy6h5uNHPaROAZU
         Y2JZRcqVugCvcT0MOQl7GTOBdYVVEYP7KvtYD7uorJfRhTu8ow7Ufw1AqwviUuoC2+xf
         9ULCfPJxjdmtLkxJRnYEcZIKwbHWw8H1k+vVeLoT+gxIxQ0kDTZfiSLzbmuOVNxLIQco
         ft5u5xyrv3x/stnLh4D11e+qm2s7ycpkQg9M/9bPJPZ9jboSj/TIZRxaMtFPe1UinLeH
         jFqQfP6r86FsdJPVX6HN0Z1XMOsbgaF/acczgFEBxLrzt7B3q4anzruZyWXk8fe/hkcE
         TocA==
X-Forwarded-Encrypted: i=1; AJvYcCU+n60672H/G6yOf6i0/u8rRKhoY/Idmf92nR3gb1r55COnV+XyY8MncDLGy356CXZGQaQGFWxe@vger.kernel.org, AJvYcCWQqVeaiyX9IgoLHSU8c3smjlxuOPdolXb1ShMu43Uhylkm2GlkiWbQJ2C8BXegxT3+JJrnERP0xSfqY2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmK9KbRt0P1SBcv+h59qfc1SES93M2lmGgDAv+IyKfzsC4AoC
	qpkOw10OyRqlsIupXhwe1L0lr/D9TmyigzbGgZxMUG9WiAliSGwMn4LwkZsy
X-Gm-Gg: ASbGnct14TjN0QdEQ/Bi40N1w8V8PVlTvEI2J3vwcKoPH2NVuoa6cvn1hSXI77KRwoQ
	x2Uv61qxR3xRNKt7vGvGVbOupfUyhzpl+XTcFR/5WUDImwbmGKv6uG3hVr3xOsLle2c5WCk13U9
	byONA+utmECFMxBCI/dgtmaoYoiVrlCKEznDnPomm8m1pthW199kGuZe4+30A0lMrHU5dv6WfCw
	MahqvvBhWo6JTA9ATKr/kWeFdD43d3oaJXGGTbQlIKkwaY5phLXTLH6OYehS+H6V+DnVf9N7bkJ
	70kW+jO5DUwDUtzP0X0RcG7e+9KgFC2Sk3vsEO74++Nqx9UWNt3W7FMI6TvAX6MmyIg=
X-Google-Smtp-Source: AGHT+IEA/4VSGPViRd6mU6bh7fnFDXSOD8VnOzbhsOivdiFta/wUWZmqwIG46N9Ui62wNQSHOr70hA==
X-Received: by 2002:a05:6902:a86:b0:e6d:ddb7:357c with SMTP id 3f1490d57ef6-e6e1c457da3mr23929156276.48.1744051235400;
        Mon, 07 Apr 2025 11:40:35 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e6e1c22c23csm2145425276.42.2025.04.07.11.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 11:40:35 -0700 (PDT)
Message-ID: <70d1fca7-5549-4b3f-b376-38443ca3a171@gmail.com>
Date: Mon, 7 Apr 2025 14:40:34 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 net-next 0/3] Add support for mdb offload failure
 notification
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
 <20250407102941.4331a41e@kernel.org>
 <af01e665-08bb-4b60-ba0b-1784dd8a5ce3@gmail.com>
 <20250407113758.2fee3e4a@kernel.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20250407113758.2fee3e4a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/2025 2:37 PM, Jakub Kicinski wrote:
> On Mon, 7 Apr 2025 14:15:31 -0400 Joseph Huang wrote:
>> - Should the re-post be v3 (no change) or v4 (bump)?
> 
> Doesn't matter much, but probably v4 is less confusing.
> 
>> - Do I re-post after 6.15 is released? Around what time frame (so that I
>> can set a reminder)?
> 
> No, no, I mean very soon. Like tomorrow. The merge window is when
> maintainers merge their tress up, rather than when we merge code
> from contributors. It's a bit confusing. Merge window open ==
> normal contribution closed, and vice versa.

Got it. Thanks for the clarification. Will re-post tomorrow.

Thanks,
Joseph

