Return-Path: <netdev+bounces-161297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EDBA20874
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82345166924
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE0019CD16;
	Tue, 28 Jan 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="ZGtnOJ6W"
X-Original-To: netdev@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B08719CC39;
	Tue, 28 Jan 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738059955; cv=none; b=XL5gNj6JakJ3K4FlSIeKDpBInJk0lBjYBh0pNwVO1hwzgpGpto+qTvl1KiD05pQqRZyTAT6oPThteq42nE7khONhCHR3HZ92BjbMVoVMN57GWkkeszCtWYQcLqKiemIRCYhJKZ/Ufw33piWW/MsvfbDtjDDb/3rcfhIsUL8PHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738059955; c=relaxed/simple;
	bh=0CRVawz/dYCvEM6VfJnrHDdnSeZWFhblHzntQn8AaNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkYJBWFKgcq3SrJtxBj47hOSsJxUwfJ1awTyxLj8Y6vHceAU0MRHTjiHymONcuRKhPBqf6ccT2yUe/JR3w7dhem6uu6mCybR7fo+roZ3MudFrmxCXm3WLIxQtUgYiGgs95KM5YFVqa8atoPkYs29SntB9sFziZygViXtlJfwpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=ZGtnOJ6W; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1738059950; bh=0CRVawz/dYCvEM6VfJnrHDdnSeZWFhblHzntQn8AaNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZGtnOJ6WmEq9rI7CcOoPkI0Ka6btu4bHCh6zk6y2fjsKAe7alCDXFRp7aP9gzlihj
	 o+SN5+TjA3q4GhxsKMdCjkdvDbns2RLgJH8snjT9XPwxHxS6nYwTL7nFD81GoiAdrt
	 5w6gSKPmfsXyjvZo4/W4I6LwevakvcDexwhkcK5Y=
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 3/8] rust: time: Introduce Delta type
Date: Tue, 28 Jan 2025 11:25:48 +0100
Message-ID: <C8EE4BA7-2DCC-413B-9183-2F7C0D890544@kloenk.dev>
In-Reply-To: <20250125101854.112261-4-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
 <20250125101854.112261-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 25 Jan 2025, at 11:18, FUJITA Tomonori wrote:

> Introduce a type representing a span of time. Define our own type
> because `core::time::Duration` is large and could panic during
> creation.
>
> time::Ktime could be also used for time duration but timestamp and
> timedelta are different so better to use a new type.
>
> i64 is used instead of u64 to represent a span of time; some C drivers
> uses negative Deltas and i64 is more compatible with Ktime using i64
> too (e.g., ktime_[us|ms]_delta() APIs return i64 so we create Delta
> object without type conversion.
>
> i64 is used instead of bindings::ktime_t because when the ktime_t
> type is used as timestamp, it represents values from 0 to
> KTIME_MAX, which is different from Delta.
>
> as_millis() method isn't used in this patchset. It's planned to be
> used in Binder driver.

Thanks for adding millis, also will use that in my led patch :)

>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

