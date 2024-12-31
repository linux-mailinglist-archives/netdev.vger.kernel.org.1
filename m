Return-Path: <netdev+bounces-154602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6862A9FEC23
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 02:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2515B7A0F8F
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 01:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DEEC2FB;
	Tue, 31 Dec 2024 01:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHgqBNVX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C873C2E0;
	Tue, 31 Dec 2024 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735608785; cv=none; b=YTihTzTB1UjcsOTNwqW+YFe3mMHREOCaQKru47IcFpbwo30SvquS0tIZJ76IlqEoTZo7NpkKrzR/80pBe2dnEci/Q0yak7pjLvx3FHKICUGpwU/uI/bJWRaNOOFZjaaPksuF0zLeQRU2eHIrQ8lq25/FpWgBX9QJvwMLEE5IHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735608785; c=relaxed/simple;
	bh=kmI05++x2YCZ4ALontX+UYfW6swMzCW5Ui6lQRwtsI0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ialHHf26yN/I9k10rLg0gvpeTc6CtvxuRGrNvY3SyBsu4rt33oSI4dMv3Y6+gq8hHn/Gf8Y0uhkGZ/Fl1dZpiQymam76ylgPt3ltYCq/QhNtvkydk4b32K6/1ItNL3ZxC5rCK/lZyDJQiS1ULik2R133Zfu1Uqjsb0wmFW2PYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHgqBNVX; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso9903671a91.2;
        Mon, 30 Dec 2024 17:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735608783; x=1736213583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bURA9RbgsoFW95cALdVT1EYSpePj2bP0DC/3/CQRk0c=;
        b=mHgqBNVXzIt2whWtQGi2l42t1AaqL9HxPEiGO8uwaLru5/JYRubyCZslG1KRY7GQgh
         qO3iJRN0lh0N/m6v/yW6Ywj1M3TRIas/Ie5fGUjrJ+h0N+WlvN1YpaeuCipCq71ZBeyl
         9GCA9Zemwl/yVqJF4GTnYQvA+mq6eqBlSGj/4gEDH5tQ9yoyscrqmtCwHBCSFoeZ89c6
         hfnWZCB0BWU/XMaEPLHW1Et1x21ASYSt8fD4AHt7wHVyWcC+NWrogpPsG5fAjBgqYrQ3
         kEbY7evaaFn5jrr4DYpcMDRuJyG3HSIVvM9B0GzZJ6sqVQLAPuys2oet9PBm/gbA5ILA
         zIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735608783; x=1736213583;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bURA9RbgsoFW95cALdVT1EYSpePj2bP0DC/3/CQRk0c=;
        b=b8pGNqWios1s1Hf/s3Xmr7Bvdt6Jy0bsXMfxpS4G9xrMi5vvtq3W0P3u1x6kFh8+QA
         FjMmgCQV0JK50U3uHwNMOkM2VVCWKmdgkwxHsifhJLmZa9EsrKbuVof0OlfbGD32rfO8
         r4Rwh7fjowoiSnm5WnJpWw1g/JuBfdaBP0hvn+UQ/shSyxu6Hj+V8Khb3tBw9PWiQ/8i
         iWDPge4IS5KQ8GtCj0pISiBw7CUmGyhyd3ja4jles/IJlP5I91pgM3yQEiDDFWToKcwD
         ynLPNjOesyOMpKo5fCePVUKcGckYCzdoSFEH2TLHIpR6xxntBNwGu+jbD8xb7+cPg+DZ
         yA5w==
X-Forwarded-Encrypted: i=1; AJvYcCWCNIa/t0qUDdPsOBe+h8xvTsC/mliJQbBenAGu/JfKnZpVVq+wbpSy+uquleH3GfzM044/jwIm@vger.kernel.org, AJvYcCWo7KUlNplYjLd8gQMHGNy0ligvBrhIFR/5DWIUvgdrDvR9ow5uJg0SsJRWZelmtmA6XmzeAxAxE0Ixr/o=@vger.kernel.org, AJvYcCX7j6gQjncGfXhPSGVQ4iyNwrpWRamAP8g3W0xN+epUwf37A5bkqnbHx+jJXDWiFR73RW/8zSTEQqACEHJNIaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ03gYqy66OAMIyxeHUqDwxXA9aoddKE15nvYi+o/AJ9NTSDzN
	b6q9Y7SC62GYyY5+TbqqiDIeVKun+AEPDvBiPOFQiD/Y1VgkxGNF
X-Gm-Gg: ASbGncvaaVz4lCzuYgbQ30KX3pMJkylfeImbo8r7d/pXrlv8JrFB9Ip+6NxpK4BtqmS
	F7dRXGQbkd+KqnAu4lJmxyi31s/BRW0BjrutVO1eqEiV5eNh02xoQb/S16QJ+0nwWnvchqimVtU
	5L0OVmdA2t4W1yh23wq81fM38XkwRg8fQTbpBui5Q8JYVIiL0nr9/Ee6IkA1Fx7UzPrRuYps1uO
	/Mn7ZP6X8wozyPP8ZJQarT80/t8+pQe4mH8PZB2XOURCtwaQ7q9kzs3i9TPfVPK9pUj7gCRBpfZ
	YfVkcZycolBFhiWtZPjENGI2N9tq2RAqfc0a1g==
X-Google-Smtp-Source: AGHT+IFA8pK8bnKKJqCKfx7Qf7lo9xziETU74gLd8HePthS4Q1LgeThkLI31ZYIHLJzDKKSrlAevkA==
X-Received: by 2002:a17:90b:2e4b:b0:2ee:7824:be93 with SMTP id 98e67ed59e1d1-2f452f02694mr48346325a91.34.1735608783548;
        Mon, 30 Dec 2024 17:33:03 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96ebabsm184935985ad.84.2024.12.30.17.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 17:33:03 -0800 (PST)
Date: Tue, 31 Dec 2024 10:32:54 +0900 (JST)
Message-Id: <20241231.103254.684624162379372838.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v7 6/7] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Z3Lp6Ce0YJa5yEYZ@boqun-archlinux>
References: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
	<20241220061853.2782878-7-fujita.tomonori@gmail.com>
	<Z3Lp6Ce0YJa5yEYZ@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 10:43:52 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 3e5a6bf587f9..6ed70c801172 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -8670,7 +8670,10 @@ void __init sched_init(void)
>>  
>>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>>  
>> -void __might_sleep(const char *file, int line)
>> +extern inline void __might_resched_precision(const char *file, int len,
>> +					     int line, unsigned int offsets);
> 
> Instead of declaring this as an "extern inline" I think you can just
> make it a static inline and move the function body up here. It should
> resolve the sparse warning.

I made __might_resched_precision() static and simply fixed declaration
in the following way.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6ed70c801172..d9ac66dc66d3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8670,8 +8670,8 @@ void __init sched_init(void)
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
-extern inline void __might_resched_precision(const char *file, int len,
-					     int line, unsigned int offsets);
+static void __might_resched_precision(const char *file, int len,
+				      int line, unsigned int offsets);
 
 void __might_sleep_precision(const char *file, int len, int line)
 {
@@ -8719,7 +8719,8 @@ static inline bool resched_offsets_ok(unsigned int offsets)
 	return nested == offsets;
 }
 
-void __might_resched_precision(const char *file, int len, int line, unsigned int offsets)
+static void __might_resched_precision(const char *file, int len, int line,
+				      unsigned int offsets)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;

