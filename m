Return-Path: <netdev+bounces-208501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D36B0BDB9
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDED43AA09E
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 07:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03C1283FF8;
	Mon, 21 Jul 2025 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGGSv0HF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F528134D
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083320; cv=none; b=jbJwDGGc8gPyVlXAzOFWqA3+930jT/IkIYMCS0oXZqmHDmrjyS0KnVdLvxuw3FjSy7NiuU1WuMmybxzIc3Ns0LzLqr4QW0qvSoyG6gR0WouEtW+pZ9yC8l8+7qjNPKSaG1qclpSi1RHFbFbv2XA2ijM663YV5kAsW75DhJ0ex7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083320; c=relaxed/simple;
	bh=75yem3WjluK+t3HLkk9qsg5NT0tv+wkaJxCTWsY2V44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMZCRA3oyeVhq2rSSN8SWCpgiiJS7Zhu2dalJQmZYCHBkHLDjtYzzekwlqIXtgTvQFOBONmck7krH0T/VG2cPjz+DVSO1JAfP2ueAKPzUDow1xNtGuiI9Z1kyFDid6cHx31ghtMCIKWiLZ+RupSukwIVPTQ8OY4n95mRcr9+xtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kGGSv0HF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-236470b2dceso31114675ad.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753083318; x=1753688118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5dBnPu5UuatkXMTVj9BGvrncU8K1V9rUHxc0C/1nEk=;
        b=kGGSv0HFtXZDd/hf8OoliuSHGqTcVMDJmtt+p69A1UB+zSfVBODkqmNY2aiPHYoJ14
         jKSpkiU4TkRSUkRSbw0Ul6L+xEDsIRhAU14VTBOpBdsVfZ7bDP/mYjfhawa56kHmO+yt
         VfYUKhjdZ2yZAEx7YrVTb7EJhbrpEa4qkk/D+9qoZPDhY9pwkq+GWNJR7AA4k9U8D+cP
         FlcC0hoB9s2ztApoLKJoZi4qBmhHvI9z5cGSCjJzgfSWVGJrSElYYe8wV54Z7Y/UyQcg
         GrZva1rov1N6CJUCRIDCDHOpo6BODt7/TRHIWuLhSAAQYB8fZ/Trcnban2blXlBgKjbp
         p/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753083318; x=1753688118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5dBnPu5UuatkXMTVj9BGvrncU8K1V9rUHxc0C/1nEk=;
        b=vmGnC9lEM8cNbv++kj7NkQpPETyRTVDkkTgnYiUthZhEUcVUW7dT7uRD0QdIDr6Jc1
         Pt/I0WABlnZVxGZRKpbMmqbVecSw90D6urRcoHeYY9yxXFxYUtbzYPGlye2bj1zu7fjE
         4HRk1JSFL9pEWs3rdJIRC7K1VffdsiYUvEYPwDLo1/z7yz683X5GzDnLNkeXg/HngeTw
         7YL7Xnk0ZMDqT3XIvqf4Zb+/UkOA31sIcrB4amJb5U8ZS8vZjf0jhMt59GGl6ZpzsK5c
         6uo7boAW2nfZikgdsihEs63H5G2xjf5YR7zoge0x0b1aVB6qoAktRDFX+UwKmMoVky3z
         6U5g==
X-Forwarded-Encrypted: i=1; AJvYcCWcloFkSSgwdRPKPZ5JBO3z0D/NshiG2xNUT9KFSFUaUgpBdXWj3QjA8G6HYJkKR59vjbm/6YY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7WAmw6HBUbjrKvDFMTFz14TD7rmBACFqThCapG6KkF/pxviOp
	7F4Zncnm/RZuhUuYwm+0VDrKPFukXrc+e1xwLuNOVK2rLevJa0I2JpdOG7jb3KzJrtc=
X-Gm-Gg: ASbGncvae1+5LN/vgwFJfwziTqdyakPcgBUoN+8j5NNTOeBQqXPkmBB2IeUeHrZh6kN
	23IwQyXQW+tvFJ5RHfM3bvuekvcznlZ4sp9iWKVAVMPeez9HaEe9A5ImIAaCCTv8csES4lugIyl
	z+/mX7OmYz3t7L/q6BNaO3W9rWYCUCkDpG78eB/3Xj+JqkN2nU4m9zLHa59tTT6Vc5EdagozYFk
	8HsA8hcWzT2v3SJWYG8uYA4ccCMKbWEGDQJrsNEP6RNBNZbbqeuwg8JJ3g2Z3htjn/vVJk+gqi4
	8bOMptUutfFtGlu+ARfQsSHCgD0qsDxhjEpz32S/Vnv2dp5sOOfmS1ksnUIb+qFjhiYREeM+1XT
	HiXCZXVyaxhHOnAmKd90mdQumRtdAyA6wEw==
X-Google-Smtp-Source: AGHT+IETNDRZoddMesKOQhKRvcZzakzOmMfiCHJxW7eO5wvM2qbmpmfxE8rY5ugFlkzEUO27/HUOzQ==
X-Received: by 2002:a17:902:d58c:b0:234:a139:120a with SMTP id d9443c01a7336-23e2572ab00mr258734915ad.32.1753083318367;
        Mon, 21 Jul 2025 00:35:18 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d239dsm52577175ad.155.2025.07.21.00.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 00:35:17 -0700 (PDT)
Date: Mon, 21 Jul 2025 13:05:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/10] rust: cpufreq: use `core::ffi::CStr` method
 names
Message-ID: <20250721073515.2srip46utnyap7fb@vireshk-i7>
References: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
 <20250719-core-cstr-fanout-1-v2-4-e1cb53f6d233@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719-core-cstr-fanout-1-v2-4-e1cb53f6d233@gmail.com>

On 19-07-25, 18:42, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoid methods that only exist on the latter.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1075
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/cpufreq.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index e8d231971276..71d601f7c261 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1018,7 +1018,7 @@ impl<T: Driver> Registration<T> {
>      };
>  
>      const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
> -        let src = name.as_bytes_with_nul();
> +        let src = name.to_bytes_with_nul();
>          let mut dst = [0; CPUFREQ_NAME_LEN];
>  
>          build_assert!(src.len() <= CPUFREQ_NAME_LEN);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

