Return-Path: <netdev+bounces-133732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45DD996CF7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B2B281B8E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1417E19995E;
	Wed,  9 Oct 2024 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUJr9uQw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E61922FB;
	Wed,  9 Oct 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482431; cv=none; b=IqYn3xBEewwaniWPUbDbs1LgKVLMaq7W4emupiVvGrLxiggg0VOTaCt8CwEc5ypgCkIJaJFWSKzXZF2ldhVqV0QyQMaydJuftwAJ1OTyZeZYSQp06L/CIjxWUL4+3Zd9KIxyvtKXy1ljZkGJlYsaZoRQ4TiZ8aO5irltexMM7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482431; c=relaxed/simple;
	bh=+V+s7Srq9vLA1gM09n8EHgIlxrrKmQnwTlNEBMNtAuI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fp6FNRiU/SgiYIXohpQtA3BeMzpeLAgMj0QsZGhzpCHr621bIWULWWa37Zlvd77H1H5vnMnjBv0FKtqbKNSIGXAXZ9noE/HSmkDc7GMqsvmgev0qZsDjo68I5L1Fq/Se02H8w/sYKaiFIIz3jQWqWaphM+T2NHl8ce6FZ7CsNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUJr9uQw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b833f9b35so59830355ad.2;
        Wed, 09 Oct 2024 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728482429; x=1729087229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5vA2OhWlyuOGNtFPXp4S7c9mKGYgplQ1cMVjq5m3Lc=;
        b=UUJr9uQw/qG6ZS+SUmwdEhxKUhyOXULkJjJLUbRSImEE+YinAWm7LQA5uW85Zy8BHh
         8mgjlhMdfRfVLM6IPNaQFW8YzZv/qpWfyb7LO73ph2dBlv64iFWoL3tFrpz99xxs9/NL
         AN3xc1RAeCYNOnuQ9DMaJ32KHAjhDMsfJf0hudPDjiz+aJGWVlyq5HW2nSIu0JS00iPZ
         /oGTHKOLIaEuvd4ffqNpdpe+B/49B6rbACo9gH/C4CZX+G1Tz+FnZvxncLV+KD3NTv17
         fLBFxOuY4KwQa2jNpfYsBsS1JXD13IWHUvzEnvN0YadMfV0WtVwttM9EMeKWcziR5w1V
         6JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482429; x=1729087229;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H5vA2OhWlyuOGNtFPXp4S7c9mKGYgplQ1cMVjq5m3Lc=;
        b=lFIXp+WgAsgmS6MApmWebZ72sIPZuqb3ZyFciMe34HWkhOxRM0kYaXdTKCOhLtS7RF
         MfAgntuWi7Ey1DcWQUkx5+TYKDBgHDkw9J5WST+mLWRpDU+mlLtPsRn4nLcTYNxPcTO8
         hFo6PQjuocX4gHVHZnsjOelVzu4UZkcxXF7HDfRbHEFam5eaC6gqITA54nMVP2Jn5o49
         +jgq6EcSdHzGVsOfZ5CYfVa04A0f1YSfC7leBARh2e395OmYFzaewbGccdHQ7Yes9KWC
         YJm+xMvOffgXTiOP+90LVZbHAvHHGQkWULkNf1RHw+gMgGppyXduYJHAH/ZowTJ7wZef
         mKLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbzpVyTzIozUc2uHpuRdwdX3TT2SrADlKrnhbADoZQasDRm+Kyd7uanC9n0OtL/s36HR0bySdX@vger.kernel.org, AJvYcCWTYQdhRLGGYZSW6SNdJVx9JgeGAtDzN4qGPR/cIH9AKpeCqBHOV0/ElIqM/WTMxocAHndPyvyfu+6aaThVrps=@vger.kernel.org, AJvYcCWiZLoNEDI7TENmr9v0UdgK21JzvAAso/VxQcryqc0ramrT463yLBbeaTRXIpw1IEP+kYxovXQB50m5yB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSosInzTd/J7Q5dh8jh0Efa7VWR6nLQ5z8xUgIjDDSjiJwjN3s
	OFAyQxd+gQo4vaZ2fu29UP4fomIXzYk4A6H5phgR8RAac0CHUNJA
X-Google-Smtp-Source: AGHT+IEpZSCbhrg1srXh3QSMteWYI+NTZsgF2+BZbM6t9NEXiLtRvcgTt6TKRNMQHDi4TmJZoUCAzA==
X-Received: by 2002:a17:90a:f309:b0:2e2:c406:ec8d with SMTP id 98e67ed59e1d1-2e2c406ed0amr453587a91.31.1728482428359;
        Wed, 09 Oct 2024 07:00:28 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5a7579esm1673997a91.51.2024.10.09.07.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:00:28 -0700 (PDT)
Date: Wed, 09 Oct 2024 23:00:15 +0900 (JST)
Message-Id: <20241009.230015.357430957218599542.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] rust: time: Introduce Delta type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <54924687-4634-4a41-9f0f-f052ac34e1bf@lunn.ch>
References: <3848736d-7cc8-44f4-9386-c30f0658ed9b@lunn.ch>
	<20241007.150148.1812176549368696434.fujita.tomonori@gmail.com>
	<54924687-4634-4a41-9f0f-f052ac34e1bf@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 15:33:13 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> I thought that from_secs(u16) gives long enough duration but
>> how about the following APIs?
>> 
>> pub fn from_nanos(nanos: u64)
>> pub fn from_micros(micros: u32)
>> pub fn from_millis(millis: u16) 
>> 
>> You can create the maximum via from_nanos. from_micros and from_millis
>> don't cause wrapping.
> 
> When i talked about transitive types, i was meaning that to_nanos(),
> to_micros(), to_millis() should have the same type as from_nanos(),
> to_micros(), and to_millis().
> 
> It is clear these APIs cause discard. millis is a lot less accurate
> than nanos. Which is fine, the names make that obvious. But what about
> the range? Are there values i can create using from_nanos() which i
> cannot then use to_millis() on because it overflows the u16? And i
> guess the overflow point is different to to_micros()? This API feels
> inconsistent to me. This is why i suggested u64 is used
> everywhere. And we avoid the range issues, by artificially clamping to
> something which can be represented in all forms, so we have a uniform
> behaviour.

I'll use u64 for all in v3; The range is to u64::MAX in nanoseconds
for all the from_* functions.

