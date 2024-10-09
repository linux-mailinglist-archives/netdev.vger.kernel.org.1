Return-Path: <netdev+bounces-133707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88251996BD7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DBA0B227B1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55539196C86;
	Wed,  9 Oct 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQFVHPT4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3C195390;
	Wed,  9 Oct 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480556; cv=none; b=O1Yp+LjX1WaU/0oMeRHYN02DcC7Axq5FLTYHN+15onXWmsNYQuZGlfk+Byp2hH6PO89qg+oZ1PQ2U4XiEJbPw3BFoOBYPvnHf0kzpewKE1rlBjK1s+FoFgP5235zpqsa/umq/GKx3Vc+mSH94TX20zwQw8oIBJNENIIyodkgbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480556; c=relaxed/simple;
	bh=1k5Z6P4xLrJ1uUuXsTql97RdplxvApmoHIaD0t5c50o=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W+J8V68yHZlnWNssVL5BrCF4M+hglCxNdGNi4to2uxiwOog0X3vdUpHg76vceup+M7vef1EFyqkYtjKdv09FWsRa0AyLcQXXnSCcxV6HbWAfkqyuXUZJi5xVUlB8r4JFyMdFlPKPK0hSjQ/6eP0dURYbRuQykFTLQlz51lf+oq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQFVHPT4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e0cd1f3b6so2172347b3a.0;
        Wed, 09 Oct 2024 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728480554; x=1729085354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BT2pvzVWlUY5HlQGpJ61u66kO+PlnsR6y06HdfcaLM=;
        b=UQFVHPT4QkgXbUrTCrlcxgL2cSFpGivBH6oL0KdY1nx9ITIzK9+Nx0aW/hvWkZw9v/
         OmUM8Efgr2K8eSUpAZVJPL3qlNoKsQ7c/MkdjwEa5lmwJV8uw3mQBXbvR3wOtmz7yPwk
         6J6BHrYToSvfQg2+S5H/M17EcVdq8MbnyOD47/DHRXFyk1OZ9nxRP1wiKGglLo346IhC
         W4KkFtWbs/ldOVDWbcR6FRHJ4qBXY6SPj8fGujqsDtkgvylXp+Da9UdVkohYJWeVbIqC
         aR4givbwiVODDmtnR2THNdGvbopFCmFk6d5XwbA+vul3uHAShqcYdAPQI6YrigChvBad
         YmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728480554; x=1729085354;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+BT2pvzVWlUY5HlQGpJ61u66kO+PlnsR6y06HdfcaLM=;
        b=BmfShfQJbnrdPVjIQjqVlcTofXcJKj3W9zPXwdu3cb7a9ypAf30f4aquiDcvtHeWDG
         3sY8QVWZtO8PdJYVBgtTYPas0JrE8hI5j2HRtHYRogGgkBo7WbAuwxkOtx1EZ2GHg6s1
         KIHnPiUYriWqPEOXFc2EIrXrlr6f3hjaaIeffj8NBHDjNGpH4k12HIZX8dnYlLq1ul0C
         1bf2ALd7dCOkU+nK5oiFkaa9ySmW6eOHfC8Gjn1OcUb+Diwt7bPBFhi61JWJ1sjtpNTW
         ZtdNmelGXa++6d1bcw49/UHoNOVSnC3w7aWQsA7GlVH7JQ/E7rvVOUvAf/Q6pBvLnTfF
         9/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUP9RCKoeCq35DxuD4iqi5KCxEi6LqaZCzf/6pwJdL9BQOCN8e4cUM6r5TSdXx1WyNBdXaTk4FF4v+fQxk=@vger.kernel.org, AJvYcCWiw5w1bCHpEU3X/4eNPNtv8pTgbtvbZtMZNDvsgmeVvYnG1P/6e4MZayum9IbfRTME/kYf4KZuhbqyXywLB90=@vger.kernel.org, AJvYcCX0LC3vtHVHcl87wlnWtyyfziywiM3So7xwt2Qyfn5BnN7mZL/b0JIiZKTP3IwsPdX3KUoKTzQv@vger.kernel.org
X-Gm-Message-State: AOJu0YwQP9Fa1/xMWUD1HLcrexH/k2a5abWq9twkkRbqgc3c6B6RlfB9
	X5nJPC4PDOPKXjoOXj4GYxwFCwHZVv7VKKQxEpcIK0ryBU8En0qx
X-Google-Smtp-Source: AGHT+IFkO1nr0stApKsPfqd6wtGEH9NDp4F0QqRs2k+1iFAiYLwP9nloCRJk+2dFE7R1fTva8WXpKQ==
X-Received: by 2002:a05:6a00:2ea9:b0:71d:fd28:709a with SMTP id d2e1a72fcca58-71e1dbc7bcamr4265810b3a.23.1728480554009;
        Wed, 09 Oct 2024 06:29:14 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d477d4sm7764244b3a.134.2024.10.09.06.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:29:13 -0700 (PDT)
Date: Wed, 09 Oct 2024 22:28:59 +0900 (JST)
Message-Id: <20241009.222859.1405378592312581525.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/6] rust: time: add wrapper for fsleep
 function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgjTifsDKrxZTUTo74HR34X1zusO_7h0ftWWH-iZR_NXNA@mail.gmail.com>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
	<20241005122531.20298-5-fujita.tomonori@gmail.com>
	<CAH5fLgjTifsDKrxZTUTo74HR34X1zusO_7h0ftWWH-iZR_NXNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 14:24:03 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

>> +/// Sleeps for a given duration.
>> +///
>> +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
>> +/// which automatically chooses the best sleep method based on a duration.
>> +///
>> +/// `Delta` must be longer than one microsecond.
>> +///
>> +/// This function can only be used in a nonatomic context.
>> +pub fn fsleep(delta: Delta) {
>> +    // SAFETY: FFI call.
>> +    unsafe { bindings::fsleep(delta.as_micros() as c_ulong) }
>> +}
> 
> This rounds down. Should this round it up to the nearest microsecond
> instead? It's generally said that fsleep should sleep for at least the
> provided duration, but that it may sleep for longer under some
> circumstances. By rounding up, you preserve that guarantee.

I'll round up in the next version.

> Also, the note about always sleeping for "at least" the duration may
> be a good fit for the docs here as well.

I see, will add it.

