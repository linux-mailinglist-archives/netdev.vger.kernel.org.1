Return-Path: <netdev+bounces-196765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9D2AD64C0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4525F17DACB
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4A343164;
	Thu, 12 Jun 2025 00:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvEqefY6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555A26AD9;
	Thu, 12 Jun 2025 00:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689341; cv=none; b=li7Bf19WlkLKqey3sN7hU1x9X79ONvI0YmbdCSzYWWQ+uYV9qNOC97AwiUwRUwFO2gvqw+Wo73+f5/52v+Zxcl3pZygT5zqs2eSyyB5bVmUDzCldUI0NmDjZEyyCdh+IupqUTn1YlQCbJ5wW7ZHKoKMGClXoNU2mOrZKvjEx9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689341; c=relaxed/simple;
	bh=/yHgCp2Nj87O1+hE+z6Wjjusqd4RBegdP1jqfyeqfZQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f7Ajf8XQKXHo+LYowz8n6uH5HjuW7uI0Wg1mSu6xhry1W3AszhtH/hrrAODhTYJ4jDFlA3CRf2oeszkZmwuXdLm/QTykx2ftqbRSAqimvxcrRj15zenaEeP5bmbHUEKeeMACI4Cb7Y9B6R5mzoX20yXHGxv46mzR06aw67zyzlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvEqefY6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso597399b3a.2;
        Wed, 11 Jun 2025 17:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749689339; x=1750294139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnVzuSAi+VGLwZqj+6jW2zhew4ye4rLcStPcRTu5cuk=;
        b=AvEqefY6MTyPCo3kGuYo4Vk3HH30915VAkCroEvsJ5rG/gSzWdiLXjzXqJwNmWr/jY
         Ir8T6hVkyoC46zx775XQxQu1Wu7uv6iEkhbrKC3lYs5HKC7BoqNeFEBsZ1zpukV4d3gY
         CW3N8R92oOLDS4pFFP04BpdlIw0owQWBCeLinoojfEQBBsbQErRAlqKidJaeLxMvAslN
         bVUIOpaUyAVSOCMh+LugAlbGPoqbAinPLWEiWm9W6e1saLtnxjQNqJv8EEQS0QI1DZvc
         1gvOgfYS+5AiJRZcUBqd5RHhR3oXpd0O0XsQh0mmV3Yp2TELUh/dhHNJ+CyD5c6kyUeT
         thTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749689339; x=1750294139;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BnVzuSAi+VGLwZqj+6jW2zhew4ye4rLcStPcRTu5cuk=;
        b=dC0rYjzTjm2xc8WDUlZiXzHMc4ZJYD6H324xOYy1ndCJ2FmeL4f2ZJO/sGFJEXzFlX
         6N6+ukl+ugmaAsYpuT18uYHWm7D62H4GCT6lDdwkWNj49MrfqX8y6TmTgggBHRBN8KiZ
         5YzHSbsag2Ed/0S21DsqolLAISPxQJ9b/0tQVr3WggrJGlKC2qse4M94Fh8N0ysYBeNT
         mf8L/Otp8L18Iae+INVeloQvnEyAq8jI0jeB9wMgjU8KNHIjCmr7y2vQck4eedMB+0bw
         PL0xgmAV68FzLoxcntc0+FmrFfArwUZRE81wIwEaCkflJ4le+j+cd2Uqy47NP5R7k66N
         eKpg==
X-Forwarded-Encrypted: i=1; AJvYcCVvMZB94hx1NirGvCa/yzRZNe8gQYFw7a2lwMKDzC1OxHOOQHhsWT8/ovUKqwir3TE7+kta+pR3@vger.kernel.org, AJvYcCXWeq2PzHvqTsnl5gVZHRbpvCNLQjNfqw5WRFKw+S2DWh7rQ/ouBITNbkvYZS/oTV23nSmfmsZm5TFkOJg=@vger.kernel.org, AJvYcCXpK57Yknzna9a02iFlohd/CP7B5LYsF/2blwFW0N+zk0ON+3NW6jT1wRMGptNQjwflQTxKNfoyB/TBGK5Iug0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxioXv4f0VzU6RXMJM0fJDmXdhIxEy6IOhmBKfLqxgwVbgeo58L
	WUXXDm29uhsOOQkQCmuKxXGRQgWFgfiKMFjRL9HKNH6xucgbvTRA+FyR
X-Gm-Gg: ASbGncurzeyEN3B+pva9lPVH/ZjwmpuDj/KPg8+lTboqG2BFrXZR4uvZWHkch3vwYzJ
	9+9s8h8+pp67Z39kgmtTwJ9gFM+1MwONFewxJ4KMg1IBDPZNKBRbXzsYm+wUsScr8lhFd+qn6yg
	sZ16CUae0BPi/UfHA9qPcw3xtri3iMvpnGN2L4zgq/XNyUdVh8ud83kPEC0GlYZ2IQvSmPwSvVX
	8d2GvEqZmJEMyXac7VyQY7x6FV05MzT2mNH4g0Ld1g/QP5dkboLmXfsqkum/ksBNE+OHIylnTsm
	eFUF+jhjVgVmES+4JE9/QilUcuW9/jurWJwaiTcTJOvS7mzqFoneUK8IHgiCrKeaGoycHMzS0WX
	NgcW71E1W+8D6wRatqGnx/9oSWI6XuiscX+VyPRwB
X-Google-Smtp-Source: AGHT+IHkUbqDLQgmErzS/Fm0ohtqpYCXxdJOooNkrwjZOfmDhJCFlgfY+aV1we6nOyEVcpq2KHK6mw==
X-Received: by 2002:a05:6a20:2587:b0:21f:53e4:1930 with SMTP id adf61e73a8af0-21f86725dfemr7996776637.22.1749689339308;
        Wed, 11 Jun 2025 17:48:59 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748809ebb8bsm195364b3a.126.2025.06.11.17.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 17:48:59 -0700 (PDT)
Date: Thu, 12 Jun 2025 09:48:53 +0900 (JST)
Message-Id: <20250612.094853.1245231705823615660.fujita.tomonori@gmail.com>
To: tamird@gmail.com
Cc: aliceryhl@google.com, fujita.tomonori@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, dakr@kernel.org, davem@davemloft.net,
 andrew@lunn.ch, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: cast to the proper type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAJ-ks9kZZEWXSHX95=QrNXaQvEc-T1cTPTaB3mCjT2coGzpwUg@mail.gmail.com>
References: <CAH5fLghomO3znaj14ZSR9FeJSTAtJhLjR=fNdmSQ0MJdO+NfjQ@mail.gmail.com>
	<CAJ-ks9m837aTYsS9Qd8bC0_abE_GT9TZUDZbbPnpyOtgrF9Ehw@mail.gmail.com>
	<CAJ-ks9kZZEWXSHX95=QrNXaQvEc-T1cTPTaB3mCjT2coGzpwUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 09:41:08 -0400
Tamir Duberstein <tamird@gmail.com> wrote:

>> > > +            DuplexMode::Full => bindings::DUPLEX_FULL,
>> > > +            DuplexMode::Half => bindings::DUPLEX_HALF,
>> > > +            DuplexMode::Unknown => bindings::DUPLEX_UNKNOWN,
>> > > +        } as crate::ffi::c_int;
>> >
>> > This file imports the prelude, so this can just be c_int without the
>> > crate::ffI:: path.
>>
>> This has come up a few times now; should we consider denying
>> unused_qualifications?
>>
>> https://doc.rust-lang.org/stable/nightly-rustc/rustc_lint/builtin/static.UNUSED_QUALIFICATIONS.html
> 
> I should point out also that every reference to crate::ffi::c_int in
> this file is fully qualified, so I think this should be a separate
> change.

I can take care of this file.

Thanks,

