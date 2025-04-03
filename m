Return-Path: <netdev+bounces-179042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82175A7A2CC
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 14:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE5F3B20DC
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A9324EA83;
	Thu,  3 Apr 2025 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyAqiKtu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18924BC14;
	Thu,  3 Apr 2025 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743683020; cv=none; b=iLJS77Atw839LRps8g/069KgaaPpZ4a96LBMxD8wmas8nafE3TYkHZAZyHZm38berR5rs3+Ih8dNspKHJyEjMimc0fZNP8iPXp4sGy5zawWHL3BLEjX+GtjFg0cdrr3wb5clr/Xby8MgAM6EMWfMW9yrnZyvMXkcJnZHxh7/OcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743683020; c=relaxed/simple;
	bh=75jP0jjWRAn+w4GK8dONkj/SHDBrOsKdM4Zl9GE0ymM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Xzz3NY79VAzbvI+aefdohYBbWQe1ZG0H5dkZAYFNkQVXHn2r7f4TR2d/QiXYKWlYKd0MA+06CV2eFMJ/EyyWkTjlKVKsTe5ykvOPcmKUqfh6wTOdDxtdthIvnxzxO6aZ6GqgSux9/qwxHNdAY1LYy8dilALqEeMcyw8ZmaLTE9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyAqiKtu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af5cdf4a2f8so639582a12.3;
        Thu, 03 Apr 2025 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743683019; x=1744287819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWu7/YhckerqLoieu5Vj2zXv6+3iK41HvBe41obBUw4=;
        b=jyAqiKtu2Nq9KUzyzazKO2AMKDORnCctGoB4YKRsR2I+r9nbF0KA50RA/oFzIvu9Gy
         7wTXuGaEZuk52YKfhgH60l3ZAwqZlGhH5US4GVY7vsM8VzeE8pSdYdrzxFtYntc+PHCe
         Xu4/Uuk489SYKEVZWly2eZLzvchKxvTowqhjiRexbGb+TOSW4voeGPLOgfWQQQYTHPbI
         tLGxIsoTrJxGrfhnA7OgeGNJQLGQ7TmNGAMEhFRCiwVjvxVKRNl87nStZuHFc6/nXgXL
         eTmN5Fz3qloAW7/8CBFh0Mw4Chzf+oK29liK+6cRc2aMUEWbYc7Vjbsmm0QjpSGIbbnV
         GhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743683019; x=1744287819;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uWu7/YhckerqLoieu5Vj2zXv6+3iK41HvBe41obBUw4=;
        b=OedKsfUAYo9ggL8rVxRA1J7QsCVoUIWk0tUaPsDWIE1hWOf78R0fZoCeYYU1OaWjBN
         4+ZEIw63ce4ugAnjFw4tqByDosctO/NPmug1Vi2ogZZ+qD9JEbfbdY3jLGbLLK9PQjvg
         mHStMSV/3WXqCDwMFf96ZlQqqUBux4se6tMN0TL+Sr9lPax7ZiY/VrJQ6XtXEyleiMQS
         VgAJLWy88YVesZ9VDUrOiH7KVnQHmzO+rTUesn9BGZ8X0/Go6W+ux/8f6s0GEOh5zs83
         ERpughKZ5CpTqh+8f7GkrNXtktkMo8ZZ+60+zHofbTKIPvafnOE3MXD1O+h0jyzf7N8l
         1j0w==
X-Forwarded-Encrypted: i=1; AJvYcCVb2HhDvpyN8e81bCGL9dKkVi3by7jp8eFXlcbfMkupoeesxLZD4LhQp714g5bdIqEhjYQlvRCttG1f8bA9IcA=@vger.kernel.org, AJvYcCW6ofGz6cKbhACrOUdtfHkNV4Hg0anH/liKap86q++HUI1HMVKz+/DtMyZY5RMZrBIdwvVDA8Ow@vger.kernel.org, AJvYcCXJGFSRIjozeQ788QYF3/WXW06aqVtWm8LWBT2SuNC3jHP289A+/k2X77OHYaJtR4j/e0l4A0f9LEzMRWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwHNG6LxDeXlwTh2p/q8oFhw7qZxZVSRgKhfiqP0DdbrcxhQBV
	u2S+RFiMKlNxSlBejowEkYJRAsa6DnPhqIXEkcjZgIHCsP7mESfU
X-Gm-Gg: ASbGncuxQooIH1KvbSfFgWwE8/ilAgRewf1AZEgEl6q2MhiqXq6zESCUOCDdfiwuKXN
	G94EXyYa0ukIBK30RQgwbXRaOUuspcIm7uEEApd+2wC6ruN+MyGjcgk/o69R4FV6QpWDr0J7oHc
	xsKPmUKrPudob1eLon6QwW9xHVFrcyorrv+KaoLtWjU2a1PX+tUZxUKxsz40hc8uJofEirGusX1
	k3wmBOv/cstLOsFf01njtwwPeAZdN8bu8Tc2yDa9FPBqlPkrwTO0AMJnZLOTgeSycLU7JTnrNWu
	05AXNCl+mtLB32pc6nb1xb/FpiAe62O++8DMB+jnthYlhv7i+LF6GQvQdLoFvDB/NuTO2iW5WFI
	8H3Z+pWCdGa0oOg/LXzWfsAXN9G0=
X-Google-Smtp-Source: AGHT+IHWLK7u10H6D/cVi4q6t3KxterddYAML60wsBpmngVZJjls9MS5MkrlB/PbbH20ExQsFasSFQ==
X-Received: by 2002:a17:903:2a83:b0:223:fb3a:8631 with SMTP id d9443c01a7336-22993c1cc8emr33592245ad.24.1743683018706;
        Thu, 03 Apr 2025 05:23:38 -0700 (PDT)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785adaf9sm12964285ad.27.2025.04.03.05.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 05:23:38 -0700 (PDT)
Date: Thu, 03 Apr 2025 21:23:27 +0900 (JST)
Message-Id: <20250403.212327.2029028318504480690.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 daniel.almeida@collabora.com, boqun.feng@gmail.com, gary@garyguo.net,
 me@kloenk.dev, rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com,
 david.laight.linux@gmail.com
Subject: Re: [PATCH v11 4/8] rust: time: Introduce Instant type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87cydtv85r.fsf@kernel.org>
References: <pk-Wz6K7ID9UBJQ5yv7aHqGztuRNqPlZv0ACr8K6kOMOzdan60fYn3vqlQFrf4NwwY5cXXp0jnYlX1nKpdlaGA==@protonmail.internalid>
	<20250403.134038.2188356790179825602.fujita.tomonori@gmail.com>
	<87cydtv85r.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 03 Apr 2025 12:41:52 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

>>> As Boqun mentioned, we should make this generic over `ClockId` when the
>>> hrtimer patches land.
>>
>> Seems that I overlooked his mail. Can you give me a pointer?
>>
>> I assume that you want the Instance type to vary depending on the
>> clock source.
> 
> Yea, basically it is only okay to subtract instants if they are derived
> from the same clock source. Boqun suggested here [1] before hrtimer
> patches landed I think.
> 
> At any rate, now we have `kernel::time::ClockId`. It is an enum though,
> so I am not sure how to go about it in practice. But we would want
> `Instant<RealTime> - Instant<BootTime>` to give a compiler error.

Understood, thanks!

If we need a compile error for this, I don't think that the enum
works; I guess that we need a distinct type for each of RealTime,
BootTime, and so on.

Once the current patchset is merged, I'll work on that.

