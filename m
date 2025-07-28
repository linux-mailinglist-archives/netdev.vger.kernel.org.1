Return-Path: <netdev+bounces-210510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD756B13B01
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31952189B79D
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 13:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF282528FC;
	Mon, 28 Jul 2025 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQAO0Uff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18C16DEB1;
	Mon, 28 Jul 2025 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708106; cv=none; b=Sl6sc+VGlkCPUV7+iFSIVoV5irkA5t3+jjfODOa6AwU/EGUIWyGytDDhED0dAlXE8aU3HY3XsrlEh4UYww9H7/foWZTNn4aW1dlHWR02nZQqC1c9nmJ5l/c1w/dcyKO6c2rxFIqk/X93NxOkk4s1HQQsHh3kLuGiMuobJda8J20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708106; c=relaxed/simple;
	bh=iMQ2gSSoyp2aBblr7hNKDU6/FMt9VPphhAXmrVMkfGg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IsyQ+rnb/SW2xvX6iyKKZO7FnyM4boCMdf9cRYYSAPoenMn/LRvZdn7lU7kHkgPvDgI+dzXdMQs5Tsl81QTFS6ZxBsQVEufxDtfsxhlYLw7er+IkHSpYHi1TFG1bz5Fyy7X6N9E60fl5eqKC/BTjeFaftRn4VqomKQvo/zoO/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQAO0Uff; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b390d09e957so4713983a12.1;
        Mon, 28 Jul 2025 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753708104; x=1754312904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvXzQp3HRSLd9Grj9TWBsmvA8bTO5fCQD54/YW0fU6w=;
        b=nQAO0UffP87QtGNAgAAjjpJqqLMztzyA808LaHOOaS2qw23gd/uTaLQGR/wDOzG+40
         v97zNA/IVb02uwEjuKmLRIyXNf7PjuOMwGqLAosJYwpl3GQbQgbY/Jh9v/0yLUbhVVpC
         umzeE6cRv3jil2kfHuZ3gITKru5O1a/dj9JPOJIErv/CWcR/QHInNPvDZcB139yhs+t1
         KwRkSuY5KAZfEK6JwpAg4d++XqkjLVxq3EclYFuoGnaiBgvOY8bhWTmJea4dYMy/L+kR
         rZaJkTzR7qQrCMyHVtN02zJafGJ+buPN4Hid9cESDBUILTrl+ZU6g+G7OW4AJTxB9RAn
         ONEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753708104; x=1754312904;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nvXzQp3HRSLd9Grj9TWBsmvA8bTO5fCQD54/YW0fU6w=;
        b=fGC97weGuzzahqYEgpkenM+mAYQnP6+3DGxmmiO/ItVzIFfT5hSR1sBoSe3D0pvYjk
         MD4XJiwJCZcJMD1rdapTUhHNzSNN5t9NRUFNNl2vo/mrtwKYbuffnB/mFOaY7OqOMZEP
         Sy5Zl9d7E+dk/mVhpdXerQD9E38/YWxVM5ToyPCPhYIuT/8Wo0lPxOAqHICSiorbtI8Q
         MssdKYz9Jv3spRoZoKBXIzNUIO5cPebgG3gYvJS+cwEFgLIV5Gh4cvrZKKSk8LArEEDm
         82nJtqmFyMDUEbeG9NWZcG27vBkid4kDLgKyRzabLxUH99qbd+J4M+7TrGapVFnb9sqB
         Svyw==
X-Forwarded-Encrypted: i=1; AJvYcCUCph+WVIBDNf5jhkuzwmA9oxHgaEdYD+NY+xm/Y/Qc5/Iozu8w9dQki/lsuYBVQ4HFcQ/vPOH8@vger.kernel.org, AJvYcCUVxec4ymd7kOWqvSEhNi4hN7XMxDCW7qb95lnOpwwagt3SE4UNfkcWJSSnvmQp0ncvaDQEI/can5H5pHU=@vger.kernel.org, AJvYcCWz8b8aR9yNrEg8JaIDtsdR/E0K6ekLUyxdtn+Z866FGwCXTs1YF6pv3DY+LznC+6OgZsmKV91Xf6IgpJ/5D20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgsPAERbEomhz0hfE26SPQUULq/bctSUPFVbj6ExffGN7Qno9M
	xlaZrBLgPn5lDfNJm2M9LRZP7QspD54+zVjTVc5QA47NYE4s1WdLdUBr
X-Gm-Gg: ASbGncvDn1BRRdPjH8QkSZzj4Gc4Rx/yx8mjTjzJCLB4CxGjeTlWIaQa6Jh9CkpB1dv
	bbBINP4jqhCNjb59DzGa9EOOlH6VWf7uerFYvKr7R7iyzaeAxed2uO4Bepg0DfwfQPR4MfYBibU
	0VfV9ZYK3lH2FD9ccq6rh/CfOCTyyUoKf4KpCU95s2UYyomRm9yEessIJoQFcikkPS7ep+J8LrS
	bPAsNrIUMFSnCQYf7p6oRtFTQV5b9N86j3tyPq8lmAlGqBAFMaSJ16BXqhKkSWJ7ANXyHEfM7Qg
	x5mZlp1njukxtvfxZQGX7nLAXQAaGTtist6lSaSeiqbIAM+0N8L0BHWC+7ZQY8sHgm5Ku4YR3Dz
	EwA9HHTViPv8QKxulla2lmRGIvk5i3JP00eTgcgBnb7xQ4YCL/LswSY5otGip4qHXz+E2bz4QLH
	gy
X-Google-Smtp-Source: AGHT+IEkiNCkJ8stR7zgvSewomceNBr/0povb8y4/gBuqByqKBqX18b1hacItl3kNh25iMn0c6ndYQ==
X-Received: by 2002:a17:90b:5830:b0:312:e731:5a66 with SMTP id 98e67ed59e1d1-31e77a09df5mr13790266a91.3.1753708104080;
        Mon, 28 Jul 2025 06:08:24 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6635efb8sm9545101a91.19.2025.07.28.06.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 06:08:23 -0700 (PDT)
Date: Mon, 28 Jul 2025 22:08:09 +0900 (JST)
Message-Id: <20250728.220809.2078481261213859858.fujita.tomonori@gmail.com>
To: kernel@dakr.org
Cc: fujita.tomonori@gmail.com, daniel.almeida@collabora.com,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
 david.laight.linux@gmail.com, acourbot@nvidia.com
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <6c5b4f8f-c849-47f8-91ce-fc9258b0f239@dakr.org>
References: <FC2BC3FF-21F2-4166-9ACD-E14FE722793D@collabora.com>
	<20250728.215209.1705204563387737183.fujita.tomonori@gmail.com>
	<6c5b4f8f-c849-47f8-91ce-fc9258b0f239@dakr.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 14:57:16 +0200
Danilo Krummrich <kernel@dakr.org> wrote:

> On 7/28/25 2:52 PM, FUJITA Tomonori wrote:
>> All the dependencies for this patch (timer, fsleep, might_sleep, etc)
>> are planned to be merged in 6.17-rc1, and I'll submit the updated
>> version after the rc1 release.
> 
> Can you please Cc Alex and me on this?

Sure.

read_poll_timeout() works for drm drivers? read_poll_timeout_atomic()
are necessary too?

