Return-Path: <netdev+bounces-158855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A61AAA13907
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD29E1688D0
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB29E1DC185;
	Thu, 16 Jan 2025 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaI4rZm9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9C1CD3F;
	Thu, 16 Jan 2025 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027155; cv=none; b=s1ovwu2OY8FdhAoxA+nnpwONk2hyE46akLakQQMTy85QaWKbDBxmR3VtyB0rfO7bDPdLkRuFlnbD94wniRG7q/6GMXZQk8y/j6mULx1FEd67AtInojGZXQbvVnbkzJmc110+/1XJz5SrWROV6a7HjmiQRg4doJCpPexs7wwivSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027155; c=relaxed/simple;
	bh=JJL/sUtA/uVGSKwc6MwwRs+nwsEDOPgmUOOBO7r5sQw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dWznrLStJDzcrBo9lpJFDxd1Rzy/K0I5GoKQJxqyozuz2agzx1oDkmWyOuCHNVRFdjdGLvlVRehWrPS7JJGo2NtJ2/znkOxnJYidbpJy71MozzWlNS/DmcV//V6KoPlBurmQz3RB0uHWOeY46x2dzCWy7Oc5HO1HrVN//DPBfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaI4rZm9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21636268e43so17053135ad.2;
        Thu, 16 Jan 2025 03:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737027153; x=1737631953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mfi4RE1Nw8hsfpi/Y0q4xFfnNFJ/4aJ1BN1jpC9WcX4=;
        b=HaI4rZm99/C4biMaSKDYFXp/oH7PnysqTGOSAZ01y1bf5hehl2x92ZWWV1YTrbUR7g
         oClw1WEr968BqmOKxgAMU0Bw+D/n8mZypzzbWGv4/Y96z6dAKjgNFHfWPY+1LK5ipc2D
         03j9WTMdmKUkqOzFwphKGajRCJ1czBre4a0ooUYUT1lD1fQ5JcwUdLtyjeEEXSfFkGOm
         uqMCNIbmZV+3Mywnz0diamfrflKE7Jbn+MmnJo4jlpyDUWBLrrsrZYN12c8564CrzRox
         1/DH+vh348scYZoDqAT9O5OEJJs5HhtqS3EpmQpR1X68A6rEaBJvYtQ1dNosXQkKxRcL
         k78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737027153; x=1737631953;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mfi4RE1Nw8hsfpi/Y0q4xFfnNFJ/4aJ1BN1jpC9WcX4=;
        b=FRptZFZnuv3aqSCYwXqRIFM5dl/DjtJiRHZPVFo14RRs6nBqfgLFOSTxecZJqjkU1P
         I0wXgLf7k8K2XiTuuS4kmJxmXli6lT+BdzSBOONRU+iWCcwVXIkPnG5BEG+TDR61DaDT
         5LkBxWgoY3pkzBc5P8k+1nr21Q33Ow06TEVzei5VYDnZL5DOTW2w/Bx+TwGDFxMF4fWp
         ESf6vtQA+vmoxQMaCzY3TkP2V1VQKxIuMOuLf7pkbrP8tKE59cXZEEfHvtOezNIqLxaO
         ZTiW23THQfp4kkGmXiOirVyFQ2qtWatiFp7n/427xfl3PrW1SyDMszB/xp6VhPbCKvv9
         5+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVSP9WXAwXPFEKESvunB3XaUK+2P4c3VBwEx1b+vnB7mezpungba5Zu8vmvzNqnH6xGL2hu3MFcx0+1thmwe/k=@vger.kernel.org, AJvYcCX0JuimaKERUrglNKJNVvLgyCwgMViAEnM6ctStCdpX7Ue5fpESEyfrHDSt+m1HBjqoBSlI6Crz@vger.kernel.org, AJvYcCX4aV2a14AvXT5u7SUDtUHQk9wDgMK1VTXXMxjnddLWcxd3OW1BNPxdcx28Hhkqy5jM82MAFcWazdIzSbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb6iFFvlWqh3Y4mrJtuk9ceMPmsWwHL/SMnZx0nmCZDNsuq7YC
	OTgQPIVo51y5k+xt48FgVU48zY+Yaf+BZP7Vp3T9+7RPdOSFR5ge
X-Gm-Gg: ASbGncsqxvdjpbcLsnosI/r7puKfovH7FMFRYp+6MQkve69GJt1cYxvDEtCIZvHt9tJ
	c3mQkg2BRfuZrgHBEiOQlV2D4E3k824tkVCAbc9CErDuzmRe79kvpqWdXW7RViWsiBYazroVq6S
	yIn0WR8mr+sWkrEIksLOOqOLWI2G6a4G4sS/To2BdEBGz8qymsY9T3hN0iWoh34BErPRM8neWDf
	wDlb4s1fud/zSc4WaOlnC5b2eQr5Qo/YYkaj+/iRA7a20wTi+Z1ENSdgOMki/o31yicyR3KXn45
	OLbHVGOu8fIelT7V9yzjPuK4EVy3Aq+noWVqwg==
X-Google-Smtp-Source: AGHT+IE4XnFPkU7cb2Cjp30f5sbemF/zAe3zm+PRbI1P0HvbpNdbAQQA5gYUd7S9ntmFXg3ctPosKA==
X-Received: by 2002:a17:903:1248:b0:216:5e6e:68cb with SMTP id d9443c01a7336-21a83f56bd2mr487648975ad.16.1737027153433;
        Thu, 16 Jan 2025 03:32:33 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21a04dsm97187035ad.151.2025.01.16.03.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 03:32:33 -0800 (PST)
Date: Thu, 16 Jan 2025 20:32:24 +0900 (JST)
Message-Id: <20250116.203224.774687694231808904.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 6/7] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgjoAzv1Q0w+ifgYZ-YttHMiJ9GV95aEumLw4LeFoHOcyg@mail.gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-7-fujita.tomonori@gmail.com>
	<CAH5fLgjoAzv1Q0w+ifgYZ-YttHMiJ9GV95aEumLw4LeFoHOcyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 10:45:00 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

>> +void __might_sleep(const char *file, int line)
>> +{
>> +       long len = strlen(file);
>> +
>> +       __might_sleep_precision(file, len, line);
>>  }
>>  EXPORT_SYMBOL(__might_sleep);
> 
> I think these strlen() calls could be pretty expensive. You run them
> every time might_sleep() runs even if the check does not fail.

Ah, yes.

> How about changing __might_resched_precision() to accept a length of
> -1 for nul-terminated strings, and having it compute the length with
> strlen only *if* we know that we actually need the length?
> 
> if (len < 0) len = strlen(file);
> pr_err("BUG: sleeping function called from invalid context at %.*s:%d\n",
>        len, file, line);

Works for me.

> Another option might be to compile the lengths at compile-time by
> having the macros use sizeof on __FILE__, but that sounds more tricky
> to get right.

Yeah.

By the way, from what I saw in the discussion about Location::file(),
I got the impression that the feature for a null-terminated string
seems likely to be supported in the near future. Am I correct?

If so, rather than adding a Rust-specific helper function to the C
side, it would be better to solve the problem on the Rust side like
the previous versions with c_str()! and file()! for now?

