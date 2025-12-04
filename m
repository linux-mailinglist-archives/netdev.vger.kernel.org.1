Return-Path: <netdev+bounces-243662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB3DCA4E59
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 19:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BE1930B2AC1
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E3D3612FE;
	Thu,  4 Dec 2025 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY4ORmZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179233612D3
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871121; cv=none; b=Ud35BBLVjUkd1t7sfqth5VjQDdltbUCnWNUM6IB0A89UcrMjf2Kr8U6ELyGPIxYS4MAUOHb9NbVxEV9cqmmm2fTW7nluPChdd5MtpE8TdvIWr1aBwdhgcZ2mUgszm/UOqQ+y+gXm783Exz9mQKroxlXgAILmQzqCXFdWwJAIlfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871121; c=relaxed/simple;
	bh=M61YqHUOtUork5VnW7pM/Mojz5Hm0vLf3JZ2HTVr3lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQtzsd7gVynM2WQJcjsdhZQyxsyz3K2NusNZtGqRvUSqv1M4BPM31zPIovwCdojEK8ULuUudViGpbwJ6Kl8FSe1oD6Hnk+NAwPT3IppyzKfDHHzpXEuvTn5e+NUmZyueKQonaWL2ZXo4U9RFd9j9no69CyckNIre6egrQsTn3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY4ORmZL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3410c86070dso926887a91.1
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 09:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764871119; x=1765475919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1pRj1+5/jO3PLLne9MyCDaDvNW1mVSp/lUv//X24Es=;
        b=HY4ORmZLBYzOdCUWObP7rSVJNZCX+aHieIFOY+XQnM/6dOsnZ02o7P4txafcZlkgGz
         0MbNeFn0fDCTerN5bAfHfJ4Qcqd5VXxaQ8iVWSz8IIYU2P4S/uBspS2fCfqWlAxGrojq
         5RRunddNABa8WgZHRxXDnN1vOnpJcHS5k7PDjFVXd4dpU86HBoNr2K/PCWTVxlKn/2oL
         jIBQvBRatRIVfVU/UogKDCeFlFofcWSQazAzuvl3BnDKt/+XgkxtBsy/0KOKncPDlPYV
         jDbCI1+Qhymnqh5+K4rap1GSp0WckFrLYv/0d/CznRy+CLPwhe8K/iPso6Vy2uA+lJJw
         0p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871119; x=1765475919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n1pRj1+5/jO3PLLne9MyCDaDvNW1mVSp/lUv//X24Es=;
        b=Am4lj1RER+GIgTUVpWZhggxP0lZA4c+2W4QD2Djcp/Cn9D18ovmgn2iQgDAAe8wOiM
         ho5jyRhzoy9hV808FqnO2MzxF3Hq4A39pPk1gSuBnWu+AuHyKSGXbqqDq90Wo6NftfLU
         lYX78wVHEFPZlKwI8Sx4pedz1C6bG7RJDB4s0Mr4jRkfRPa4nH80/kPb6Kz4wjRN7doj
         fimU2LiXlOa0eiRs45Z4oRR4+G2Q5mB5TLp3nG8PlyKy8jifgV+3Uxh//38EmPm3phHL
         0I+SysAq1PBSDu2T5afX9F+IHK+mQgsU6gdWVcBBu8bhZot1h1ZTrvvI8bt7up4wVOH1
         33iw==
X-Forwarded-Encrypted: i=1; AJvYcCUTaEAeBUU9pJN+WT/gvaDLUBS9I9BjGPU/XbAvbO2/njjAm2ndKqNmea6PZ98sV1Q+AXs5Z+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhyFqkefeJlt18OY31MlgOD5LPKPAwDfA0YxSvzt3Om75hQer
	3xjfRacONt1rZSMwRKyLeZj3NXi4FA0wTkyTKDCF6gu+LMEdEEHUVyIE
X-Gm-Gg: ASbGncsyudFgNgO5ob3yg/z28/BmvYuruAbXJ9AMN8r/Fy2QbyMcIVShmkZiIfE7Da0
	de4CZjGvL7kfIBYfQ7xZCnWzCZwX6e0D/6+zzUnqTbu4shc4g45mC8Tw8zPLElSEwl7lJBGwQDs
	heo+Q8ndZK0Tq1ss6ZU3iTCxGZRUJuHT1w8CwnYAilxHV8fZ1zjqkkxfvFmg8xWRvKGhQAV+7kw
	i9nK0FEb2ytt6RjLeG7IuVEV3dtx8zgX+w6eIHUd/YK7EfGEeBlpiahP5fFweGMADMXwgCvx96X
	0aY1eAIOZWoobhUOcyetmdatmyughnKgCUE7wGYbQhwsz2HmFpfyPfSnHzUTP26JrDw1xKkEman
	4rWWTtfhUbU7EEDZFMCcvMyJ6P/+5MdLg7KdklyTd39UzPDY30deDxpZcgf3GrdtUv/daiowuYw
	EAu5aRUvHhuEyJ4ZAceaeU298=
X-Google-Smtp-Source: AGHT+IHd2CViZquu8rDIVJve8lgSXsL5f4xbCLXW1g3SwVu/83f5GjAIV9Uz6obIchoDu07uphYeuw==
X-Received: by 2002:a17:90b:3852:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-349126bd337mr6610930a91.32.1764871119341;
        Thu, 04 Dec 2025 09:58:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6817397d0sm2431869a12.6.2025.12.04.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:58:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 4 Dec 2025 09:58:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH 06/13] selftest: af_unix: Support compilers without
 flex-array-member-not-at-end support
Message-ID: <f58ae2ae-49f8-46cd-bd24-2d358cb36f15@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
 <20251204161729.2448052-7-linux@roeck-us.net>
 <20251204094054.01c15d1e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204094054.01c15d1e@kernel.org>

On Thu, Dec 04, 2025 at 09:40:54AM -0800, Jakub Kicinski wrote:
> On Thu,  4 Dec 2025 08:17:20 -0800 Guenter Roeck wrote:
> > -CFLAGS += $(KHDR_INCLUDES) -Wall -Wflex-array-member-not-at-end
> > +CFLAGS += $(KHDR_INCLUDES) -Wall $(call cc-option,-Wflex-array-member-not-at-end)
> 
> Hm, the Claude code review we have hooked up to patchwork says:
> 
>   Is cc-option available in the selftest build environment? Looking at
>   tools/testing/selftests/lib.mk (included at line 14), it doesn't include
>   scripts/Makefile.compiler where cc-option is defined. When cc-option is
>   undefined, $(call cc-option,...) expands to an empty string, which means
>   the -Wflex-array-member-not-at-end flag won't be added even on compilers
>   that support it.
> 
>   This defeats the purpose of commit 1838731f1072c which added the warning
>   flag to catch flexible array issues.
> 
>   For comparison, tools/testing/selftests/nolibc/Makefile explicitly
>   includes scripts/Makefile.compiler before using cc-option.
> 
> Testing it:
> 
> $ make -C tools/testing/selftests/ TARGETS=net/af_unix Q= V=1
> make: Entering directory '/home/kicinski/devel/linux/tools/testing/selftests'
> make[1]: Entering directory '/home/kicinski/devel/linux/tools/testing/selftests/net/af_unix'
> gcc -isystem /home/kicinski/devel/linux/usr/include -Wall  -D_GNU_SOURCE=     diag_uid.c  -o /home/kicinski/devel/linux/tools/testing/selftests/net/af_unix/diag_uid
> 
> looks like the flag just disappears. Even tho:
> 
> gcc version 15.2.1 

Oops :). I didn't expect that, sorry. Thanks for finding!

... and I guess it's time to set up AI in my environment.

Guenter

