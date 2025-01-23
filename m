Return-Path: <netdev+bounces-160509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C40A1A00E
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA9216D752
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D4420C035;
	Thu, 23 Jan 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVRCMOQk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2020C016;
	Thu, 23 Jan 2025 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621623; cv=none; b=IznbuvA7ZiDLBsGZO3JvpNvKases0hodgvswValMCPnMPPeDXmjurHCRnWtM8KDO9prsRySNaUmK3wWiQUOT4c0DgrGwRBFWg4WSjKs2Zqv/HQzaj0blTzAYJHkeJ1mRa25oulLwg8lwRJ4/aV73E5mlFpSuxgkg5yZJ0NRijSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621623; c=relaxed/simple;
	bh=XD0aABv58nDK/2kXxubE7fw2Dd/4+FE2LNdabEGmXYw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IMnuLlhoca4DStPj5PZiHnNukMXP9ssGLuVJXu52LPWhZH8JrO2XdDduSaH1ESLzRXj/0spo9wW4UoT1dEyl8I25pmORPrKvcQWy1TQu8jj+RSbUS9ChNQ+Kv5o2e7WJCMXYFg5Dtr/uq944+42w6UhSEwxpS9vltiWT0LZkMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVRCMOQk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so1226283a91.3;
        Thu, 23 Jan 2025 00:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737621622; x=1738226422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9q1x174EflZkASpLdvzyaoyFXGYC2fkIourI+Rdf60=;
        b=EVRCMOQkFPZasNOSxQ6io/uLvk/Vn0DlYhRnQLSmBFi92uZHXTVszgCKEfr7H2FEYL
         gL+Cz/fl67+lpCOyIUal3hA8nNfbHrBzLG0ezIgLyFWNjrSufZuS9GSdOXryMS28fsp3
         NNKEHrTKSxPsc5DPH/u7UobDgZV7Vs9rSAKFf++lxUhUw69H0pluwYARA2Jmd+SUnWUB
         mJvTmmTSHHZ0AAv2lTv0D2dCAQ/FHiepZ6PaN6nb46wipnDvsX+aO099lDgaoo2xxYQO
         A7SNDFXUbs8ygxTNhkzG3Yz3NzL59g+ahvO2iDaJKw0gE+fY/ixJQ48R+8SU3oFi/rHH
         nzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737621622; x=1738226422;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+9q1x174EflZkASpLdvzyaoyFXGYC2fkIourI+Rdf60=;
        b=oFNr5q3/bma8eXTuMlnRyfheFbntrUZteO4UPvauq/WhzeBYKrewP5NQX6gK1c3jP+
         /TE64iK/GRmsX4eU5R0J/sLKObVKBeyFVMc8J2rPrNQnefLr2uyCk3qTym3gRAj06CQu
         B4Kd17lJJKsYdvgcd6hjxYjbuhQFsnVxod52I9Hf6Ctzd4f7TZjASKBqzlxFrcXuNVyA
         hJmecGkIwJp7BK5J3WScKEmROWT/2FdwZzgHf6AF40uYxEPj9j2a2d7V9bxmLUd9Y9z1
         z55Mu5UUdym00dKDNd2AR+gHJ1WUGVdEu9IoxY47/ta4BV4SwujKmID2NT0HLgclwHBQ
         Mo1A==
X-Forwarded-Encrypted: i=1; AJvYcCUFjdmXaFxOxoqX1A4eY2cwEOMN6XwEFmP5pzI1zR5KdYrjaon9IPPN/0IZHQ0LUBgFEh82+y1xiqI55LowUHI=@vger.kernel.org, AJvYcCUocykZI5riAHFrsTpgIMY4xxQuDT9Xq0eawWvurGKPPaiO/ujFvmwZ3Tt1y7kPzC4lJQZAAuX57juAUeI=@vger.kernel.org, AJvYcCXlCZIN9J7QpOoEmtu20taCEIcnbhosS7jhjLHqx80/qThyK2uuSt+MjT7aOY9LaWYnQsO04Fo2@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaqGsJz8eBjFRd27Pe6bpHE427JGeKiNds1CZnBMVBZH0mdIh
	3fr9/o6n312mfZHwDQjARZKe9h13+jBZtsCjarHVUTHh/6BOCvQN
X-Gm-Gg: ASbGncvKXw1Qc2KuW5MPlGFG8s7tX7YgYsQoY7z30iT9RQ8wVG0OrAVhdTAf6wTOUNV
	wcXw4BudF+rMjb3NaeR2CGbzZHZIYHxz+wG3BCkLztAoox1wRrS8HlSSnA4aSNwWM4+u+ooygLP
	6pmnIDOajhriZo7S8EUq/zIa8qc+2XDswavZlJMBiZtkhN5onbFCpBbR2qI18y6J7X7Vi6z/hiZ
	9qtqpd78g8UDs205N0lU+zBqdmMdbVFDA4kdJWR89PbZ5DwqLThxwSSNb+YHjyiN0LPxKLnUi2+
	zmzoeswvcxbO8x3wsVo5rJAcHMeSFWYNw8lhnurzc78HNxdgczqZsHMZwx/IPw==
X-Google-Smtp-Source: AGHT+IE9dQ9Lgeq0kGoH1d4c485K3h8IpsrVnIVD0DCtLq9V7LZOCGwH41jH3uhoQxFFbr8rVadFjw==
X-Received: by 2002:a17:90b:2703:b0:2ee:d63f:d71 with SMTP id 98e67ed59e1d1-2f782c7252dmr41539965a91.14.1737621621721;
        Thu, 23 Jan 2025 00:40:21 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6a7def9sm3335539a91.18.2025.01.23.00.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 00:40:21 -0800 (PST)
Date: Thu, 23 Jan 2025 17:40:11 +0900 (JST)
Message-Id: <20250123.174011.1712033125728284549.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, aliceryhl@google.com,
 miguel.ojeda.sandonis@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Z5HpvAMd6mr-6d9k@boqun-archlinux>
References: <CAH5fLghgcJV6gLvPxJVvn8mq4ZN0jGF16L5w-7nDo9TGNAA86w@mail.gmail.com>
	<20250122.194405.1742941306708932313.fujita.tomonori@gmail.com>
	<Z5HpvAMd6mr-6d9k@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 23:03:24 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Wed, Jan 22, 2025 at 07:44:05PM +0900, FUJITA Tomonori wrote:
>> On Wed, 22 Jan 2025 09:23:33 +0100
>> Alice Ryhl <aliceryhl@google.com> wrote:
>> 
>> >> > I would also say "the C side [`fsleep()`] or similar"; in other words,
>> >> > both are "kernel's" at this point.
>> >>
>> >> Agreed that "the C side" is better and updated the comment. I copied
>> >> that expression from the existing code; there are many "kernel's" in
>> >> rust/kernel/. "good first issues" for them?
>> >>
>> >> You prefer "[`fsleep()`]" rather than "[`fsleep`]"? I can't find any
>> >> precedent for the C side functions.
>> > 
>> > I think that's a matter of taste. In the Rust ecosystem, fsleep is
>> > more common, in the kernel ecosystem, fsleep() is more common. I've
>> > seen both in Rust code at this point.
>> 
>> Understood, I'll go with [`fsleep`].
>> 
> 
> I would suggest using [`fsleep()`], in the same spirit of this paragraph
> in Documentation/process/maintainer-tip.rst:
> 
> """
> When a function is mentioned in the changelog, either the text body or the
> subject line, please use the format 'function_name()'. Omitting the
> brackets after the function name can be ambiguous::
> 
>   Subject: subsys/component: Make reservation_count static
> 
>   reservation_count is only used in reservation_stats. Make it static.
> 
> The variant with brackets is more precise::
> 
>   Subject: subsys/component: Make reservation_count() static
> 
>   reservation_count() is only called from reservation_stats(). Make it
>   static.
> """
> 
> , since fsleep() falls into the areas of tip tree.

Thanks, I overlooked this. I had better to go with [`fsleep()`] then.

I think that using two styles under rust/kernel isn't ideal. Should we
make the [`function_name()`] style the preference under rust/kernel?

Unless there's a subsystem that prefers the [`function_name`] style,
that would be a different story.

