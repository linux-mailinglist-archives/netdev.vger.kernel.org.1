Return-Path: <netdev+bounces-176806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83761A6C347
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 20:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C3D3B9CC1
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 19:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A419A22DF84;
	Fri, 21 Mar 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE0EAJgl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8628E7;
	Fri, 21 Mar 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742584738; cv=none; b=Jjc4Lp9rivsE1KSTlC5p5+GWbGxW57X8SVnVe2Ov8bWf7rjchR7O+3IsR7m6mPH3bNd0ulU8m/8EHdSVrBz1F0TfNUBT0WmJojNRN1OV6JiEnXQT6A0X1tq+bawcUHgEONNCljvQiFERzHov17QcDs3hUBKflh/WVzJLF+SfO/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742584738; c=relaxed/simple;
	bh=kwD7MR+rGrovtAo0fkYYuoRLcegajzfCbpQFh/xOghQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rYRtoA4tiHzCradXI5/+4rxOHMD/q3gY7PvsGCtPGaWMbhZBwMokrEkGOH7KhkX4JSAwoZE7G/y4ZBPB2xcQ4gI9+mcHGAQqUeXyGNe1xxgTxVFhJk5xBeroHJXIjVYMtMqPrR123f6aU2SJXetwPtXOpukvdEf1NFuj4IsWvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE0EAJgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46DEC4CEE3;
	Fri, 21 Mar 2025 19:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742584737;
	bh=kwD7MR+rGrovtAo0fkYYuoRLcegajzfCbpQFh/xOghQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hE0EAJglBfUC0sBwOprABZNiYS5tWf9IwRFAJ/Ehi99uDXzNWBFaR9ibEX3rno4GC
	 lCz8Sassv1921ieUfcrbLGVgnW6y3NEI8VhkuNJsnZ/ntu9TQNjO3ZwPBj5kxM7HFT
	 fMCoiXkocvzlauZVgKsMhgrr/YKK/TI1wlBLgAc3c2vQGH9LH/lqzoamBEGAtiAOMU
	 lY/v/kmKfDObgQ2e8lSAu3Ri1ark1se+QMJp0gEwVw8NOjW2fv4V7IL2RYhj8pVfF1
	 knz3ipnM3j6Nb1Uj0M+AmBRaoZPb9Ywla1XLnEWJZYpUAeW7ee1L6b1Bd9nYQIsdPu
	 sEo9t6XxAYLAA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
  linux-kernel@vger.kernel.org,  rust-for-linux@vger.kernel.org,
  netdev@vger.kernel.org,  andrew@lunn.ch,  hkallweit1@gmail.com,
  tmgross@umich.edu,  ojeda@kernel.org,  alex.gaynor@gmail.com,
  gary@garyguo.net,  bjorn3_gh@protonmail.com,  benno.lossin@proton.me,
  a.hindborg@samsung.com,  aliceryhl@google.com,  anna-maria@linutronix.de,
  frederic@kernel.org,  tglx@linutronix.de,  arnd@arndb.de,
  jstultz@google.com,  sboyd@kernel.org,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  vschneid@redhat.com,  tgunders@redhat.com,  me@kloenk.dev,
  david.laight.linux@gmail.com
Subject: Re: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for
 DELAY/SLEEP and TIMEKEEPING API
In-Reply-To: <Z9xnDzwixCbbBm0o@boqun-archlinux> (Boqun Feng's message of "Thu,
	20 Mar 2025 12:05:51 -0700")
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-7-fujita.tomonori@gmail.com>
	<Z9xnDzwixCbbBm0o@boqun-archlinux>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Mar 2025 20:18:38 +0100
Message-ID: <87jz8ichv5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Boqun Feng <boqun.feng@gmail.com> writes:

> Hi Tomo,
>
> On Thu, Feb 20, 2025 at 04:06:08PM +0900, FUJITA Tomonori wrote:
>> Add new sections for DELAY/SLEEP and TIMEKEEPING abstractions
>> respectively. It was possible to include both abstractions in a single
>> section, but following precedent, two sections were created to
>> correspond with the entries for the C language APIs.
>> 
>
> Could you add me as a reviewer in these entries?
>

I would like to be added as well.


Best regards,
Andreas Hindborg




