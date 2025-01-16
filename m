Return-Path: <netdev+bounces-158808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0C8A13565
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B79697A21CF
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF2719E97C;
	Thu, 16 Jan 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKEUsfLq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA0A19DF7A
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016376; cv=none; b=XUkLXehmwpW9oQB+xMhPbW8M/gP6rBU2MIbH2n6onIhQBHPlwDxhNdn4V9lTiWY/HXByXnPcWXXlnmgPhOgKbhRdryxjf9tda1brcBqSXnpVc7lVF2ZP62Lmc1h+ANAQGPQr4oFgE2GuBydMeTySn9qHBL1hsXQSYzNFTOZK5mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016376; c=relaxed/simple;
	bh=kJ6CIe/Y4H7WjuSViRjZaVlg02+ifEvjHsN/NCSpWIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpQsSiZy46hqe195cDyWu7dKdZBQob10fF7jvluqv2h3DqlSLK2NRMDgqXGTALVfeFQ9WmTzIxkhAi8LMKWkvOXED8amuwAPbMxW1ce1DMoKG5afSQt74tFef8vXBKcs7Mfh5hB0/7s4cbDkMegth31FdrCHeuJcuMLkyJFX2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKEUsfLq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862a921123so461364f8f.3
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 00:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737016373; x=1737621173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ6CIe/Y4H7WjuSViRjZaVlg02+ifEvjHsN/NCSpWIA=;
        b=aKEUsfLqfk8/fOnFvOEGk55nJ0K/1w2uUVgZ76rle33eQSLbFnooykJxgE8nyzkgE7
         ESxpsjjOPyInxU637HJjYqm5PM3Iwx9FwTnEI7KoczZPeuvBL6qagqKcSZf7YYXcqUPb
         yDshcA/u0yH2OQfd3uOimg8+7x/2rzzS98tguNdcGOlDZ1gVW5qSBXxKXE6OWr27iTKg
         4rnibIH4eN8xUFmhtRvMr1omzbfW3daoEySuPVpjA/aKB3UwcAb8ok0phhR1Z3N/fgwe
         w6t+n71ETuX0qvudAj0nfMALytrd+TrewNb3nSDp8U0k1EuyF9+SfZlUBLmDNLC1YfIc
         HRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737016373; x=1737621173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ6CIe/Y4H7WjuSViRjZaVlg02+ifEvjHsN/NCSpWIA=;
        b=DMKWcjWqg/KWYEYJAdbppi2fL9obByBmxymGprg+x2WnTJWMw6VziXLFJ417oaDU1A
         +7NutV77sZYHlJToOZ1LZKq8AaqI/Av2a8POTBP/FSy6YZD7glZ/xGllQp9An8E5nhwm
         6xYiALcDHFVEv9dPjbrSt4kqWyLZrkmHCmPMFmFiuA8i2JkGmUisvCCFYhMXIv5D0j4o
         VUVoQG/UYK3WTdQbbYy6FoDnsb+quvkUCwDSSueE2higBxRwSvFKV3RXh08C2DtL6SeW
         ZbxzICpi8o2DrcS5cUeCgTTTKFXh5uNH6l94oo6rREikMfMLYAn/pzBfCGS+2hsplGtI
         tSwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH3ZRNTWsaCTtI40X8WcsNUcUs+ynfbY06KuWGqZJqlC9iRzUQ7Od27qpZJCBRf3WnZOhQ3l0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4mLUTV4KE19LokcpqGNfYUWDii5CC9JTHMY+5/24mUrZeNhK
	DhNAdCYX7prIaBDX2BlN370GstBB0RIcxvr53cBjXIRAl+Xi8bMyufm0wFTQKoNQb+2pf0MBQ4k
	4kyOC+pNZZ3LKn33tKNHgGCRyRz7Sx66TdCi+
X-Gm-Gg: ASbGncuobVwjS1KuHdEVlONe3cuk7Pem3XQrbGY1Ef3iDdbA2g5rR1jQuskjgYUF713
	f9XmLdGMazWmv9uDMHXcVWR8hfzpBxjNQzd6/qUNqoEE3XVtkHxatbnlctX7WCYjGRTc=
X-Google-Smtp-Source: AGHT+IE+jsBrPXZGdbayPbLY/juwtdV1VqWJKNOBWq8IuOIMNKuq9E3g4Mq1uE3OxPN8wLJ5UzDSOrorgrze70of89w=
X-Received: by 2002:a5d:648a:0:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-38a87313097mr28319779f8f.33.1737016373051; Thu, 16 Jan 2025
 00:32:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com> <20250116044100.80679-8-fujita.tomonori@gmail.com>
In-Reply-To: <20250116044100.80679-8-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 16 Jan 2025 09:32:40 +0100
X-Gm-Features: AbW1kvZbmRmM2Oa_zh0mN65XvGmmvLS9EV3qIH4ExHRuACPP5fFY6xEcjuHFX4M
Message-ID: <CAH5fLgiAJL12HHxRmmJNer4JirJ8Fex0Jbazem17uafp2gtidQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] net: phy: qt2025: Wait until PHY becomes ready
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:43=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Wait until a PHY becomes ready in the probe callback by
> using read_poll_timeout function.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

