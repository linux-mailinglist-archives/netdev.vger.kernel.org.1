Return-Path: <netdev+bounces-213583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0FDB25B5C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5AA5C2853
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 05:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F22E224220;
	Thu, 14 Aug 2025 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drMEm+Bt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C11993B9;
	Thu, 14 Aug 2025 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150810; cv=none; b=gHvZ97uOeDe7XtmmgfrEI5uHV5d8Q2hwFjePS134HCJQAldpvp4xbNlIQKnYKyNMIqF401PzV6DFgmhRPIgT8VQF2qC+F401bX6jW/Ao6tov/06B+45Fw6I357bJnfbo91K3z0uKalh2p7cop/xLdd+FEBkIoyQ5+VrF/1J/sqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150810; c=relaxed/simple;
	bh=6adqea4GhIXGOmF5MfSXsSimmVOG8gIRKdr8/MyOQiw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oHwtLwVUkPzQBkfJt+U/CLfkYmovpSlnu/SynhfIAPA1Bh8CXy9lJEQNcBBNniR95cdvuPObJ2zoNQwmE59gFvIMP1Mz1LLL2f8OiOlQeAXVkNttztuArQzDtQovY2+Rse0PoIe78u9e5eVEs2U8vITwI9sIJ6/jGF0+rRqrlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drMEm+Bt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso601844b3a.3;
        Wed, 13 Aug 2025 22:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755150808; x=1755755608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqYhRuNqPqJ9ur4OBBFMvH3TILkl8nxpwAKTyy4UuTM=;
        b=drMEm+Btu+DG6kRQlrlx4rw0CGnabSFcAG4DdxyXeVfR1MHO7OLEUqM8cND3cLYcZI
         Th0CiGdvOWyldFJEomIgKnv8UjlaNdcUb63fWFq6/fMQxzz+4HP0LXQjJA+nqBonX4l1
         vDs2bzR5lFJclxoMzLTyfxWfl3Zb8q7/gKKv+pUrdm/cQiBZIkhkVbGgJs4eCQBAsURj
         U/+hKAIIy1n6krq8uhQWjIkrUbiX5JZRbnF57O7W0KA8fDEZU6U5irEvVqxwNK1RTFPc
         4Mre6P9r9KSOIP/em75X724LrpD3io2RIY2/kU197vOxbICjRTLSSQcrv5VxKU5OP7Ip
         XfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755150808; x=1755755608;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KqYhRuNqPqJ9ur4OBBFMvH3TILkl8nxpwAKTyy4UuTM=;
        b=Exac3DNgWV6q7tNeV767UFeKmEQepAyagZebw+6KGlmYA6hTNxLHB2wkiMExPNaO8M
         jmWtmK3cwO+rSqc/evBYXqtKdBWlBZBKEHyF3f+djnkTRTevJE3c/SY3W9UJjg3zsmly
         LPLOVrkMuh9WCAqP0jzKfykben6q+mEpRjU87QbwczjAib7iXCgTpkL6oCYv81a3F5Nx
         X1Eb9ZumguZWdpiDf+YjfMEhOEThSCpsk+uUaZOXOPvY7/kqVQWlTd+T8MZIBYT+qo7R
         ZA0xNum94TqDn98Ziiiadj1Qv1pMY9DeShZOAQv4aP3cyt55/5ZTCsR+Kr0HtW9yv7Y+
         KJAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxyWG1/ZhzLpMCZCu9NCzyyuWA2xMIJacv7LqLvSyIAgrkZ1ZKpQZp7u21eM63aUWNk4i38Gwj5SDoct8=@vger.kernel.org, AJvYcCVy/qKriA25tY2jB4jLI3ZL1WrKwAtb2a3OyaJTQ4mWYEzkUV/X42TTTXGvlfAPkyIjWHrw4WX3HhSOc21O4qY=@vger.kernel.org, AJvYcCWgfMTcmdSzA82PwT+sRiQ6HqKNaG7jEFFLhbXyxL58fiCTboqwNTvPJ8Hdbl6b+oHXhczRqlMw@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWK+kOb68rPc3O6zxM8/hwVXxywgJXsDPyxHoG63byGm8ynV/
	qoWnTeEhMtgdkX/ziTcqQu2bnXi9yZ4dw2eceRxGGcgXvcgY95fYVmUqSzSk8rkB
X-Gm-Gg: ASbGncuXBOQQcJ/B0gY3i3yC2/ekYUXKQYHy5gAzYlYqB3/kIK/RjI1thXa1AE/PcoJ
	EEEDskHYpOKQ69c49G38JERoNWMY4lkH6MRtXbOFQvD67V3lAy9kZjN0u8ZPa61xaS0L2zd/3Ho
	KCBl7PF/QEeUb5p6ci3Z63++f2iUq1vajodwWHvWjlLlNlLjyRNCNv/JJEQHpiFae3386RE3/JN
	mOg5dLfjR6govNJTeoIMSZ8nCWn7sqqFcST8gJ+8d/WVJruT73PC8azCUNvH8Kqq9GOKfWXYzPb
	p1J6zXOcJMPn4n+Kj0NA8LavHZeSyV5xGadrlls0dLQdmYk+OcktdE9Dmyv5qZq1CVILvIBI4Eg
	8NZzgTegF8opw5gjOGLbygV/ZDedoz32SEo+2wxX8VWJGM+TUztt+oljP3DLsPTQ7SeJkdr8iF3
	zG
X-Google-Smtp-Source: AGHT+IHog791igqliEoqszyb8l5Cw0JJ8BUbMHP5SRxTZ/fdAGK+R6bJxJOoYp21eBkF3lNYfYepXw==
X-Received: by 2002:a05:6a00:84f:b0:76b:cadf:5dbe with SMTP id d2e1a72fcca58-76e2f5c1b40mr2945355b3a.0.1755150808217;
        Wed, 13 Aug 2025 22:53:28 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd7887522sm32503028b3a.20.2025.08.13.22.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 22:53:27 -0700 (PDT)
Date: Thu, 14 Aug 2025 14:53:09 +0900 (JST)
Message-Id: <20250814.145309.293965922516473208.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, me@kloenk.dev, david.laight.linux@gmail.com
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <878qjqgpnt.fsf@t14s.mail-host-address-is-not-set>
References: <huGw-FNRjvsPJK5CIsoI3puxml780Rr5GbJB6xg92PGzQOCMRTwC_utxTpn8u7G1sNjqq35iWOTNANpVUuip4w==@protonmail.internalid>
	<20250811.105320.1421518245611388442.fujita.tomonori@gmail.com>
	<878qjqgpnt.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 11:42:46 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

>>> Could you document the reason for the test. As an example, this code is
>>> not really usable. `#[test]` was staged for 6.15, so perhaps move this
>>> to a unit test instead?
>>>
>>> The test throws this BUG, which is what I think is also your intention:
>>
>> might_sleep() doesn't throw BUG(), just a warning. Can the test
>> infrastructure handle such?
> 
> As I wrote, kunit does not handle this. But I am confused about the
> bug/warn comment. The trace I pasted clearly says "BUG"?

Yeah, might_sleep() says "BUG" like BUG() macros but they are
different. might_sleep() simply prints debug information.


> I think we should just remove this test for now.

I'll do in the next version.

