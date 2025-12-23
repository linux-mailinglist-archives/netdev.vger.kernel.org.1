Return-Path: <netdev+bounces-245806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0691CCD8156
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 05:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 754DD3019846
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EB02EFDA1;
	Tue, 23 Dec 2025 04:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aARXnC5R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219F2C0F9E
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766465644; cv=none; b=ikHBxy04IoEvhBcK9UnwKA3lcWlira21q4aD7Lcva/cBDmsnjVhj2V9Io/1vegNyozATfy6jpRKUohGRZ2znM+YCckHV8tOGq4TsdrBixfjJdCAnFxT550h4LiV8CpOL4E1s1N+4iuZZkusQONPVApMarNjfqY6RjjALhujd1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766465644; c=relaxed/simple;
	bh=qLpP523aAmyAJ41p9m75RrcgnIuRG0JYZTi48i2BLGk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q3LjmMvMiHsmi8oeNMoaZnWulcOan8BDhuzw+v6K8/b5xo81yhS9233wUZ1r2GRez9ktfIjUS2iIl4Bk8Q6xI4SmISLL3FEZAZHDJ/6UORpI0581yjp0z4BKe9AooP4Y+rwiAtsL7qRMC4LJ0NG+cxUiCJvAbcrF0ojv9sg8KV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aARXnC5R; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bcfd82f55ebso2125938a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 20:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766465641; x=1767070441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq+2iFrosRcl8h/Pjv1SkVbM8N3eRAOAbbgT8dXVoCY=;
        b=aARXnC5Rwnu5Kjw4wc3Ekhvh3Ucg1gqNy2/Ev1yJ4pQqhT0lfpposnvYeqy1dWLM6U
         Hj5znCCekstPeX3iOIcaU7iJu/e9QOofkhRA5HQog9Ulzp/cyTj2IXRBlf5UX5L+ubHx
         JiFGtZ7Z0Yc1Ei04cY9mbZo6p6QxtNQPIHBhykbBhOY3qj8/EohEKHsJ0pQMzRItbo0x
         P3574ZepERegH/XxPkj87kDi7P5LzJ4JRlmXuSi7fUCdOzgP2wspDHMLhkyB8WmWTGum
         jYKQbdTodRGflVGE+0Wnnw/MbYW+gE9ypGIKkCaVnBVRwbY7lBb0A4QG1mtJN/95caOj
         iTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766465641; x=1767070441;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wq+2iFrosRcl8h/Pjv1SkVbM8N3eRAOAbbgT8dXVoCY=;
        b=MurXUxJ89R/H9QyIUX7pfnbjxKS6xDacWBEpqazYQmMEE1oQhyhU6Tf2b+oqdsDu44
         A/Ck9mw5YpfrrNxjGAhq67tnMEPVlxwBe/J9NtULKxNa3PF2kNxyNBjkngnrA6MSGWzv
         pT4VMjR83LrI33nJdfP9rFuWMN0CQJxs8zIJ8mOt39x1aHT9SPMvTvrzekew2+p3f3tX
         GT6SJAjI4gqt+octp/mKCysRIQYKz/dJIUfJaGgnxPkhkPWccwJ7o05Qp5DNgcIOMalN
         4Cp6HIoL4iT+NF9ABM49KUuOW/XbgI/Bhx3eIoazkJF1i8cJP0qErq6HXTRz+Gq3nflI
         BIeA==
X-Forwarded-Encrypted: i=1; AJvYcCWHQhv6D2Zk9EQbVdKGT+ce9aQzozILydm5RVA/rFcBBmIhBrEWVupWysxE64mMJaaa3p7bFKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg907tK+kFEF94lpfGRY1K1ALRfAtloM8eC6N5VzU6NmX8sy8r
	Ud+aG+RCF6m9H1wSIekXqLe9/Y2qjGM/8zQGNOceSeTQbp6LVQqw44Pt
X-Gm-Gg: AY/fxX6fBB+yO/rvzI24xl2i2D7Dumi1zOcAClki4vyRaMMyXjB/Zw07i3+vqLR1Kv5
	a+wEAazRMvQHM8xA+pPw12RBWg2eufYbpjeKUnmKBeWS0oehD5qf1FwU5wHeZ3Bs/K8jqqB8cTl
	32jmM+Ev03G0mrl57rA+f588Dld5MvfbCIJ8Adzn2zOM6MP+NtI4FneFIkT89FuqZV/ZHAzryDh
	Pbt6DInZ/RPpGclJJcY04Q0oq1kcaj8F8eD0M3Hmi5y64nmWxsNCiog10T/2hRmxeLyI//UBCfI
	a89lrGCnVivP23didjE9I8829bxjtxbP/NG5dEP6o2m5zPRzWH9jonhBZ1/MHTcpdVCeyF/7rry
	7Aa9lqJLMofgMS1XCK7HyVJZOOpvtOe8XVvOph6oFEyvRsxtso7q5CHx4WghyT7P1ob/d8GQ5ML
	5tEx+hFsZ9ErLmQjLL772k9uGC3Kn0vBTEaf3hyc1P4qqKXOPoexD+aGxeZmkbT/e+BCg=
X-Google-Smtp-Source: AGHT+IEnueW9XJWReJEoENzLygv/WqzFObA6mLnZX3ys+kdkGpI1RYUpgPanB28I1VK0QGm/vDzE+A==
X-Received: by 2002:a17:902:ebc1:b0:2a0:a33d:1385 with SMTP id d9443c01a7336-2a2cab16191mr172702915ad.17.1766465641326;
        Mon, 22 Dec 2025 20:54:01 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d776b2sm113451265ad.98.2025.12.22.20.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 20:54:00 -0800 (PST)
Date: Tue, 23 Dec 2025 13:53:39 +0900 (JST)
Message-Id: <20251223.135339.1140460779640053821.fujita.tomonori@gmail.com>
To: tamird@kernel.org
Cc: fujita.tomonori@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 tamird@gmail.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 0/2] rust: net: replace `kernel::c_str!` with C-Strings
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20251222-cstr-net-v1-0-cd9e30a5467e@gmail.com>
References: <20251222-cstr-net-v1-0-cd9e30a5467e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2025 13:32:26 +0100
Tamir Duberstein <tamird@kernel.org> wrote:

> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Tamir Duberstein (2):
>       rust: net: replace `kernel::c_str!` with C-Strings
>       drivers: net: replace `kernel::c_str!` with C-Strings
> 
>  drivers/net/phy/ax88796b_rust.rs | 7 +++----
>  drivers/net/phy/qt2025.rs        | 5 ++---
>  rust/kernel/net/phy.rs           | 6 ++----
>  3 files changed, 7 insertions(+), 11 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-cstr-net-3bfd7b35acc1

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>


