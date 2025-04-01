Return-Path: <netdev+bounces-178507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DEAA7760A
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7796B3AA270
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 08:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDC61EB1A7;
	Tue,  1 Apr 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Pa9GrgQY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740EB1E9B1B
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743495166; cv=none; b=OKVNGNM9TqV7PxbgdKWzsKW4ckvfzKDfPngwOAjJ9mP8UTnUjAfL1SlY5qQvWusvkH4DzM2Ze0n4YMg2DP7DcmmqAExkBBfIBw9xiccdiCZbmFedcwMXEKu59xn5fnDhK2RvIytTpqlIynZ1IeIPSrWYW/rOSd1KX5FgKlobZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743495166; c=relaxed/simple;
	bh=Q7BKqapfD6AxdJDkjzeoVlhT6jorL6pZj/n+hnRVzrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYw/pt4qls7xv0qrudy3hXYAtMGphr85V+zYLjkuEQzfwYfU1Fut4y+/GdRjt7ZjJFpzE9n+4OhoovSJInjy8gJpkuKWsPwpg9p6oSsNqtHzF/uJ+ju0zGjelySZf6/sGOrG4MZjgD9QHEEYDBQ3wnpPC0HhN7y6G2WCFfG6OjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Pa9GrgQY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf680d351so35183265e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1743495160; x=1744099960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4p3P+1/911O4XZnCq9FVI9Zjtz1ACANtbEDZFOoYNIQ=;
        b=Pa9GrgQYV0vw/MfwYWGt780JsX0dxDwb9VSjc3BptMrPdypWT4MOTQYcdaT3hr6P75
         e/n7NqfsyvNP4qKvbeAiTncdMVIQetF1fw+5vIHEwx5FstZ2zwJY2z62y3fqzbLgNRkQ
         BZBLJGJhA+41MwCoPp/cMHJiVRqcP+w1BiRRTaHkE0/bGjYH0FtN2TkUd/MwIV0hCC7H
         WH/A/+tCRQmKYSxtktGwRw6c2ztmP0fBLaMVyNYOGwNJOuPqKJ5u/x6p+1LKXoIEpI1K
         g/QkvxSEoJyXiLNcr3+tKkiCNZnYHMFcwLJK9Nuq9Pkj8igyknuffjyiL7zw70j7YSU3
         fjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743495160; x=1744099960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4p3P+1/911O4XZnCq9FVI9Zjtz1ACANtbEDZFOoYNIQ=;
        b=MtqxrtcdY7QlpIxrykVXbIQiLrTsHRaqgWtVqAADW+1qAxmWbzRlMxE/Z6/PnX1qe4
         xWBKmOtQDYw7J6hj1NouW2P6VT7E1uAtdSN87LDXIgU6O0y8OdmKW8UUCWs5OV43bL4Q
         ibR2jAkhkHx8pr7sq3is2wTSC32xQLEi32xEy3D8aIVyUzF7Yg6a+Bu6wxY1ZKCa7338
         JpTIA+PrCS66ZQ83rsVt22IluEQV02g2wGQ8DvYRNGSWzHk3X2orkHyD1WchkB2hkDun
         O76EVFoH27pmyfJLYQgRnAVlWWmO+YSX3LwkS4OSW/0Cgwh/8P6kRFKur3jw+q0DJEW1
         bQxA==
X-Gm-Message-State: AOJu0YxKx9qe+4UNxZOs1gTrXUeySTikMCpy5xscpUKZMvLUeGcisgW7
	9SXO7RufpA2GvEoEN7P0wpn81QXc/XOrseJ8YRu9VC+41iED3Sq+UrdzhB1eFv4=
X-Gm-Gg: ASbGncsX0JK+xQ//qV46pHNpFTze60czAr3v6Lc/6z7ic598PBKUYQ3zGZbgDhjVPeJ
	zcJ/bQqyhM74xFWHX/4Hnnu0obzAbX+eDkgrIYcrTGC/lqGh5tOEFD5LhfWGkWrTtL1sMQbJFrr
	KTtdg2KP24C5ZtUw9C01cU1jkrKAFiYUW6Fy9y5hU/jFB4GK0hhGpP8jn6MhIp6uXUOX5E6Hvxg
	ygHyPgEZdBfvL0NpPF74f1TIe7jo+1aAlueWusd04PB4L4JE2qQ5CGK5R0m8x5CFap2m8aE0PB3
	YiKqULIEqBoUuDYH2m/UZwbJ8bUlGL7d/8K7kXX0KwfClvAY/w5eg63jPfFzCYB36Ro=
X-Google-Smtp-Source: AGHT+IHPsofN0L3NqyV7NNJjLnBN+caNMjZHK7Rek25KHBJOQORDn/np2fxXKpMa9Y0VNxWPeQRZFw==
X-Received: by 2002:a05:600c:1912:b0:43d:fa5f:7d04 with SMTP id 5b1f17b1804b1-43dfa5f7d37mr109437685e9.16.1743495160467;
        Tue, 01 Apr 2025 01:12:40 -0700 (PDT)
Received: from [10.115.255.165] ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d830f5f56sm195318935e9.26.2025.04.01.01.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 01:12:40 -0700 (PDT)
Message-ID: <9187e9a3-fb93-4927-b02f-7f41176f844d@sigma-star.at>
Date: Tue, 1 Apr 2025 10:12:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: dsa: mv88e6xxx: propperly shutdown PPU re-enable
 timer on destroy
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, Julian.FRIEDRICH@frequentis.com,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 upstream+netdev@sigma-star.at
References: <20250113084912.16245-1-david.oberhollenzer@sigma-star.at>
 <20250114152729.4307e3a8@kernel.org>
Content-Language: en-US
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
In-Reply-To: <20250114152729.4307e3a8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I did some further re-testing on the fix, regarding the the similar race
in remove() as well as the previous question regarding the locking and
cancellation order. V3 already expands on this, and the point still stands,
the nested timer+queue+trylock mechanism is somewhat tricky and I manage
to hit the race window with just cancel_work_sync(), without the lock or
a different order for tear down.

On 1/15/25 12:27 AM, Jakub Kicinski wrote:
> On Mon, 13 Jan 2025 09:49:12 +0100 David Oberhollenzer wrote:
>> @@ -7323,6 +7323,8 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
>>   		mv88e6xxx_g1_irq_free(chip);
>>   	else
>>   		mv88e6xxx_irq_poll_free(chip);
>> +out_phy:
>> +	mv88e6xxx_phy_destroy(chip);
>>   out:
>>   	if (pdata)
>>   		dev_put(pdata->netdev);
> 
> If this is the right ordering the order in mv88e6xxx_remove()
> looks suspicious. We call mv88e6xxx_phy_destroy() pretty early
> and then unregister from DSA. Isn't there a window where DSA
> callbacks can reschedule the timer?

yes, this does looks suspicious, mv88e6xxx_phy_destroy() should be done
after the switch is unregistered, otherwise it should logically cause
the same issue.

However, I did not manage to trigger this during testing, and this also
did not fix the original issue I saw, but I will fix the order in a
followup v4 patch.

Greetings,

David


