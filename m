Return-Path: <netdev+bounces-161080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24283A1D3B0
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E0D3A3D85
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143D1FDE1B;
	Mon, 27 Jan 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PeZgFuKM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063A1FDA6B
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970918; cv=none; b=V8lzbkhHGgovJLTAb6bP5IyHVdfigKy9yrCS1P4/hx82d61vy5Rat3Uft81N2hVyekVWHdqzgGby1EBQy9kOpI9gsmIfbwKqvZUEl69GGQza2Lff1osiDtdKQVFtew1vMy0M1If4wB/j1vpKqytyr6KfiyG1GuZ20MVQ9NlmnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970918; c=relaxed/simple;
	bh=nzKCGhIBGbAovNqP/cTvBZ+hhK7tqCGzqLIrBTkSOls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIpG/5BwRl26H7MpN8nu0JqRD2mfgBsUhxwJvj3LrtI2KbB1InfN4sY3CdF7bjVE2/7ptMtw38PsORiCN+lstq4scsF19M9cbyeRu+djexR6kQhbgzMOryKoDk5jCldLi60zGI+PJIW815Xj/tbzwgdcIbKH8L2E+9XVahKY3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PeZgFuKM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so2972130f8f.0
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 01:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737970913; x=1738575713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzKCGhIBGbAovNqP/cTvBZ+hhK7tqCGzqLIrBTkSOls=;
        b=PeZgFuKMjYajZKF1JQ2KC6NF9pv23nJ1WhjRQGBNkJaqo7pYEF2lhKz9nOqPa3TH0k
         XHsEuAp+IR10vBVPdWh94lkStKIomGAgJSTMZrotma8Qozhlf8kk71joVpnsc1H3i6Z7
         T37pypgccTjzD8vuLl2HYw3uQd3eoy6vE+sdlvTT4u5u3N14E03UiSCFikW8mjnILKl8
         D2X1fpFqhGddvYFD+yRp9lHRQ6CIJii1aGyu/5LBpsRP839l/r9L/HIaXee23K8OMhou
         +SlkByT7LTEiZZDQW6B9rbEgGt1RKyWDBpE5ACpBPfhSfjRla95MkLGO5Nv3q1yX6EMa
         w03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737970913; x=1738575713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzKCGhIBGbAovNqP/cTvBZ+hhK7tqCGzqLIrBTkSOls=;
        b=wJqenOJ1DEUE0aEhvWuceuGIwynnWy70JFU1vsBAsm91dxmj6fsL1XCUW0s8ZxvqGA
         QF9ieodR7ORypdULrH8m2miyrCOFDcLvlZSzt8/9Q83yOVHJU+SpYBT+vXZ/g4JxNTwM
         2I2UMTVfzkEKnDnTc6pELLrqGzh/1IyibSI6AXKCwT+waNVypm2gbYqVCHZNmzSuXOXV
         43NQK2fp0s3Xbk/ZXw1ue0lzr9wi/MxMsBFZK+6xtWTljz4zL36eoeBGnvhRR93g+LUE
         Q1GI7E0qX2+RjCWSfcPn1Oj63/Np4/q4aK0bx29oyxu7sUyA02L7LnNjGK8TuKe+8nDo
         9PMA==
X-Forwarded-Encrypted: i=1; AJvYcCVgMHhyookw5CxMCbd/AbbvhX+2kKP1mbNudXFsBtkTEdyRSKbJIdDKRn/p/3vcwQswdYkKBVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwrtCvydBH/bWhK+ntHSReB4QqEY4/doEvUiSfWXU28E7j9c2
	x0C7udCz0GzrZIe3takEjXooVBiw/nDfAczQx99ug8lwrT1Fr8yPVYmGGiiiPf6lWgscsvQ0hI4
	xWjN7B91UHql6U+mUFh90QFbPUuMdSQ+PP49i
X-Gm-Gg: ASbGncsOz1KKOS43I7n3sOM/gkz6yH2XDhFBByY25eAYfT3DmT4enlLhJUusA7vToOa
	6DTg7P5NRoKItQ3gcrM3zahOraacNASyos9phYLSKIbOSnirNbgWANgOW60Fzsmg77n67KvOgMD
	ZRZom6JdP3nmNzwENq
X-Google-Smtp-Source: AGHT+IF3Fa/51VjEvqTXA2TBuCWrIRI5p8GDJMR5Gi8qMiYR++SQ9kcT6R8GJw9EmMPbFNuETF8j5XHiPrpKHxrhbZ4=
X-Received: by 2002:a05:6000:1faa:b0:385:ed20:3be2 with SMTP id
 ffacd0b85a97d-38bf57b608amr43395804f8f.48.1737970913119; Mon, 27 Jan 2025
 01:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125101854.112261-1-fujita.tomonori@gmail.com> <20250125101854.112261-2-fujita.tomonori@gmail.com>
In-Reply-To: <20250125101854.112261-2-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 Jan 2025 10:41:41 +0100
X-Gm-Features: AWEUYZnXe5T7ez17VITh2Lj7-kTBM3pYabt7E1YxWy6CPYBARJB7HR2901cVEHE
Message-ID: <CAH5fLgjVuSu=N3iVLTvx4BjPHpvBrV=TOUtOJ1Qu2JrVZpiifw@mail.gmail.com>
Subject: Re: [PATCH v9 1/8] sched/core: Add __might_sleep_precision()
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	tgunders@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 11:20=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add __might_sleep_precision(), Rust friendly version of
> __might_sleep(), which takes a pointer to a string with the length
> instead of a null-terminated string.
>
> Rust's core::panic::Location::file(), which gives the file name of a
> caller, doesn't provide a null-terminated
> string. __might_sleep_precision() uses a precision specifier in the
> printk format, which specifies the length of a string; a string
> doesn't need to be a null-terminated.
>
> Modify __might_sleep() to call __might_sleep_precision() but the
> impact should be negligible. strlen() isn't called in a normal case;
> it's called only when printing the error (sleeping function called
> from invalid context).
>
> Note that Location::file() providing a null-terminated string for
> better C interoperability is under discussion [1].
>
> [1]: https://github.com/rust-lang/libs-team/issues/466
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

