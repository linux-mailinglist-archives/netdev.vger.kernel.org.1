Return-Path: <netdev+bounces-237375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E1CC49C46
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9425B3AABC1
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363982EC09F;
	Mon, 10 Nov 2025 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUwjJA9W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624F1E5B68
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817661; cv=none; b=fGft25XdbGCzEP+SqAI8/yX5qSnx/OJhktG329DdO2HpA/GbcNyUGYG2Y1fid+akLgE3/xsKJsQrrcm+z16fLxxDrbPc/6bZtOP6/4edwwJJBQjwe6P0xgBu1/0Lq+al5/gAxVYb7N7AakoURiWrBRc0PAqXk6N5OkUOAC5jF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817661; c=relaxed/simple;
	bh=K/cQ2C7Ez8KzP7o1OrB0lJTjPYc31Lv7MkdeLsPQ4ZI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EmF9Dd6x7cLBha56AOwI7FcDnDL8IovPeibCQJXMX5o5oAwDNmOzwHuxtYXqWU6EHm3nFDzdMcnyuQjtEzizlDVadIJjQLK7ppkGULkCKQhQYPgFo1IUXddhYHVyJSYiq1rl0/Pq74JGvfXPF/b9ivLL5fHe+A9trFseycJmuZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUwjJA9W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29516a36affso34567115ad.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 15:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762817659; x=1763422459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oy2n9G+dRBzJRRG/yf89aQd7NFJbeGk8QhHqO60fK/U=;
        b=eUwjJA9WWkc3CC8fxK/auzx2NRB21PokVYsBR7I3j74Qyjbiv2MmeRsMhkacCtWcxi
         tmFDeH3p1bva3gGWTVzMVBrHgvO2GrSvj/4qLnaJUKt9V64zddR+eLpaeTYsT4bC5aRn
         vWyQvVYP3tPAi23J/8VhN5OuC4EHmYzKfwyQBiWhbu5ZStTWbEaLucouODXpJQ85Y403
         aGX4Il4oeewRgnRfSEnxvq9blPtAd8nge6FTqCJznwEH99cjSe7Pj7MeC6sQBeXXBAKF
         flpq1RIOC6Y4flNpa/oNitWzDFuWULR+YhRvy9p35a2vxCH32e040ZU26UBnS3uJZOBW
         mYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817659; x=1763422459;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy2n9G+dRBzJRRG/yf89aQd7NFJbeGk8QhHqO60fK/U=;
        b=DQJPSJJc/zWbQ0bquArzVzit0DZrcFAN+qe1x5qxXiZBHY1phC5Uy++tUAN8OUWBkW
         7oIBijGZBTqU6n7HC/50bfwQSQ9DaGBvWnc0V3SpM+foEEPFQKL4AFRzTS30PXFtKImm
         +5GoWAhNbMZCQ+WghPvvyqZGdXR6X8Lh1w7UEhxrKHiHA4Sw1jLFN5krnkXXFzaiKjWz
         oLZWXPrMW1BmuJkibutQ3NAZA8IVwPS9nf5DAU1cDaEaauXOQzGVMklFPUJGFuN07D2S
         8Xbm9PW+2FEqP66eXf9a9MJyzl8BPUAqCCBGXDPGSGQrrmo3tFRZR7Vg252sihCJfofO
         Mx8A==
X-Forwarded-Encrypted: i=1; AJvYcCWs43gf0QUt69hfy7FErfSDZj9wHBB4l445rH2Mj14Lr+CWoxBACpj0F8ZWwhc8kdVIYPXcmrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZP9al+iyaQX8EDELe3K2ZAB58U2rvdKM2Ziz95MIPb9ypEzC
	HoUXtuCAK/6Oy0/2jxDJaxDjbXYWQGt7mttRh9PIz4CM6y8GVADkLpPw
X-Gm-Gg: ASbGncssRwAhIL15xrn8kzkP1ahOJy9WdTP7DY0TK1gjLH7rJ6ivPzsK8JY460Z8lbI
	VmjHTjFzyRePI5lsTW6frXmsjBT1eTDdhIheJWAGSzdR1O7Qw4jzUR0km4GIEG1KsmjMKoQgxFE
	+FC+/9TkLPqnr2LQdv8iMT9KDfwzopXH9v6PPn5MQal58zGieoo1a0/fg4ykWpGC4AcQTUwPKM7
	fubc5bbQYvUvV7QMRwQie9m4ufaKq7/jMqJY3j/CTPnRUgYOVwReX4aMqr19+CnCAo+isxsfOr/
	FRRvwA8srh8J524kRXFejvW1ZqsqAU/bvZFS4JsrGCU/v+CD7S3dT6PzDs78zTM25DlHyt6oJKr
	+hJmjj5n78086xRaKq3zzA6YB3klTi6Fm5zAUgTgSkSLa0rWWmOrEZ6G7eG2joxviUPCkUXhSz8
	oK06tJ0VcXeKN2+FMIDTqGl6aS136MV3zKclXLrbKKdJtWzlb/9uYPUsnmu8bdnwm/sIyF85ZmP
	Ec=
X-Google-Smtp-Source: AGHT+IFfD56UHqe8xJ4zib+kMNCisvMUrImAWMr08SYb4N1rj4ajxA2f4+9t3KbkudcD1BAlAqplWg==
X-Received: by 2002:a17:902:fc46:b0:269:4759:904b with SMTP id d9443c01a7336-297e570bf23mr118686635ad.58.1762817658918;
        Mon, 10 Nov 2025 15:34:18 -0800 (PST)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d4c54be0sm108297385ad.103.2025.11.10.15.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:34:18 -0800 (PST)
Date: Tue, 11 Nov 2025 08:34:13 +0900 (JST)
Message-Id: <20251111.083413.2270464617525340597.fujita.tomonori@gmail.com>
To: ojeda@kernel.org
Cc: fujita.tomonori@gmail.com, alex.gaynor@gmail.com, tmgross@umich.edu,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 2/3] rust: net: phy: make example buildable
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20251110122223.1677654-2-ojeda@kernel.org>
References: <20251110122223.1677654-1-ojeda@kernel.org>
	<20251110122223.1677654-2-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 13:22:22 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> This example can easily be made buildable, thus do so.
> 
> Making examples buildable prevents issues like the one fixed in the
> previous commit.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/net/phy/reg.rs | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/net/phy/reg.rs b/rust/kernel/net/phy/reg.rs
> index 4e8b58711bae..165bbff93e53 100644
> --- a/rust/kernel/net/phy/reg.rs
> +++ b/rust/kernel/net/phy/reg.rs
> @@ -25,7 +25,16 @@ pub trait Sealed {}
>  ///
>  /// # Examples
>  ///
> -/// ```ignore
> +/// ```
> +/// # use kernel::net::phy::{
> +/// #     self,
> +/// #     Device,
> +/// #     reg::{
> +/// #         C22,
> +/// #         C45,
> +/// #         Mmd, //
> +/// #     }, //
> +/// # };
>  /// fn link_change_notify(dev: &mut Device) {
>  ///     // read C22 BMCR register
>  ///     dev.read(C22::BMCR);

I think that some code begin lines with # for use lines in a "#
Examples" section, while others do not. Which style is recommended?

