Return-Path: <netdev+bounces-133682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5BF996ACD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D960A2893A6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75508199FB0;
	Wed,  9 Oct 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbLOS8LA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189419994D;
	Wed,  9 Oct 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478226; cv=none; b=GwnPHrdPg1/FqjfInEM7sKUjviQBtDQRoNW3P/bmgk4LRCyziDF4FerDgY3i/ItL4ebZsGJ8VfpfkmBiwKTqPi7qdHCpMkt3mz8ut+rLVNJtWh7Edc7eEQ53u7JVgmtjFHm/LfB6411A0oc6CgbYj9cATZJ7OroK+jpSHxCG54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478226; c=relaxed/simple;
	bh=s1mIiqMmmaEtZ0dP0CPxz2xMQYHzsDsHkZVkJ8OBgYk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dUegBy935F6BHFTTdzvMsInClU5azPCu2L53SZxzzirYzgoXxzzbYB8HWUWnoiv5EV/9BF2Pks7PKzPiUJPKihygLo3NW7QOvg9QYcOV6YTL7sa1CD8jN+zH7EWeWgntoGjp0TT3SCqRDfpRJTZFp4sPO+SGt9hqmOD4y0jZdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbLOS8LA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e053cf1f3so2806848b3a.2;
        Wed, 09 Oct 2024 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728478224; x=1729083024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ApKT91N+hZarPH0QWF7H2pMrlw9wQXXopki5JRgABI=;
        b=mbLOS8LAGJNNtca2vr9BLWmUtO089gku589pg4DEZ6z/ofD23BA9nly7ksYkwK/i3q
         4kyS046UKRaGRDu5yyvEN04f9CMcBqqFVU/7Ie86DvZIwbGRlFfBTDWlidxjUd0BLQIy
         TcZBMMb1lqYnLj9TY4yhE+SlqBKUPVsblY7w50brMuTP0NmOY9a+F6a7WWGC40HQuCzz
         SyUIgW0MzXkNDBCgVtnpem0r/yVY5Jf/ldA9IsG6ZDZtR7ulc/fU0qepeutC/L1F907P
         B+qmz7ndb+YsU0hN94QZ1hHgJ3qIhHCl/XI1JChbIamGBXk1HaI+k2VAe/HINt5+CnmV
         U1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728478224; x=1729083024;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ApKT91N+hZarPH0QWF7H2pMrlw9wQXXopki5JRgABI=;
        b=T8lWIcbThUyqxsCJS+zqAoabW8pAaXtOv1/pQaHI3q6MUp0T6Z8hu0sfKUfba6Fycx
         qXVM36w1Jddp2/eXlt9XJ6d05c9naNfy9BwuHfy0+uLJAzSdXUpOZmqfb5xAWBId5dgo
         Z7RjE6F63oqo//pVGZ49FggWMlk4RSoxshwUBklFK5u9lF9ol6EL3Eexoh1hO9AaPu8o
         wPgfHz5E+HwitAoEGvOufAG64BbTkYN9jOhFDdb5Kl1Y84UAI459gSrNTcj8bN+j3+HD
         g4qUD4aylvYaOrAhULyO/YSOS9ItP+nuFH8T4+12UcANz1331FBarV77sPvq61RoJdsd
         taJA==
X-Forwarded-Encrypted: i=1; AJvYcCU4sibkJCtHFU2bqT/qja/LI0iFjw1nxndlUBUv6sYHbeKGUj201IlF0rT9tIuCgyAcGYCK/UPDelX384Q=@vger.kernel.org, AJvYcCW4fxex1kVF7ekzSCxD5s7kfPmlRDbmi89JDd1MHa/8+NJWjqemcXoFk9pASbD/hhXSZEWbTrZi@vger.kernel.org, AJvYcCXBcOJ2NM24Lgw01bKDj/NZ/X0/bjZzsb5WTZRanxI9ziX6ZdzRt71PrQLHIuOp/cg9G+1LYsvXuWYbv/tgOvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7UdVvW+8rQJhYfpTzLMktYl+MSUJk+dO6WT4mrnjabeu0nTaB
	0cYwf6gOb5JfhoFHVfgfd8I+ZDEe7+ElXtMfDzq3cNjjN5VMX3Wi
X-Google-Smtp-Source: AGHT+IGBBVNYSoULlN6iyMI/oeDgYEpcddcsccCGoj7dipFWXC5XBHhHJ00hcK3HLM5V9FYXS4atlw==
X-Received: by 2002:a05:6a21:4d8a:b0:1cf:31b6:18dd with SMTP id adf61e73a8af0-1d8a3c86810mr4142684637.40.1728478223860;
        Wed, 09 Oct 2024 05:50:23 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4a278sm7952878b3a.140.2024.10.09.05.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:50:23 -0700 (PDT)
Date: Wed, 09 Oct 2024 21:50:08 +0900 (JST)
Message-Id: <20241009.215008.101897405575050011.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, miguel.ojeda.sandonis@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, arnd@arndb.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/6] rust: time: Implement addition of
 Ktime and Delta
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLghps=Aa69Aye5PCGu6LuoHomMcQYEN1USTd5JiBkLdJLQ@mail.gmail.com>
References: <CANiq72=YAumHrwE4fCSy2TqaSYBHgxFTJmvnp336iQBKmGGTMw@mail.gmail.com>
	<20241007.151707.748215468112346610.fujita.tomonori@gmail.com>
	<CAH5fLghps=Aa69Aye5PCGu6LuoHomMcQYEN1USTd5JiBkLdJLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 16:24:28 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

>> > or not (even if we still promise it is the same type underneath). It
>> > means having to define helpers, adding `unsafe` code and `SAFETY`
>> > comments, a call penalty in non-LTO, losing overflow checking (if we
>> > want it for these types), and so on.
>>
>> Yeah, if we are allowed to touch ktime_t directly instead of using the
>> accessors, it's great for the rust side.
>>
>> The timers maintainers, what do you think?
> 
> We already do that in the existing code. The Ktime::sub method touches
> the ktime_t directly and performs a subtraction using the - operator
> rather than call a ktime_ method for it.

I'll touch ktime_t directly in the next version.

