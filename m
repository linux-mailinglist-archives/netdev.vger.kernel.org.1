Return-Path: <netdev+bounces-158880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1E4A13A1F
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7253A167328
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802F51DED66;
	Thu, 16 Jan 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1yHZtm3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FEF1DE892;
	Thu, 16 Jan 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737031434; cv=none; b=VvOFHiMlGCGt2Fxb+uGXcrod9blNqShUfMH2V/u2lTzr1hmZfkkP8b/R0QThaDzn5NOEJgweHpLY1cyt4YdxrkbjojkC2mK6Sjnbn7Q3k4PTmvR3uwpw3cOXngBo3ZXWtAeM+v8HaE17h1Sh1rN464hClvhoa3b02JLjUpsM6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737031434; c=relaxed/simple;
	bh=91faCPnI6BFBNuEQ1W5ciAABK9q4SQ7lWA8dOZ2SPLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UohYdieOTg8BHTlG/jkszrn6zq1zfyMQ7YkFU6HQBLaJ5A8ggPjemwF/tqOzIfVsL9bOVio0nTFLtmR2+vobYARWgLqN1VFb4x8l/8k8WQ1tnrnOCBbmTDoP7g5kqvQyQpx2M0EQJRyxhm7g6oHaM8u19ZOo8xc7ECnkMuQNO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1yHZtm3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef05d0ef18so195495a91.0;
        Thu, 16 Jan 2025 04:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737031432; x=1737636232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91faCPnI6BFBNuEQ1W5ciAABK9q4SQ7lWA8dOZ2SPLg=;
        b=Z1yHZtm3LG9yAvOkLZkq3vJ7UTqVbQNYfEYQ3Jr2ROMSunP1iKS1y7Q+NLns1Eohq8
         VSsRxUcvozl2vV2/ypvD3X9PGtov4SlUDiIMrcdaKHdt+iFvrpzLkkvfN1ldak9Kt7wB
         CgTaOZWkHzQ3NgPr3KwUViP3HU6UdndyeoKBUJyOcw6yTpE9xiNk2MLUjnHfJEPCnWo/
         VsR30cQNvtC28cdnmjjSYnm0vakXyFN6I8QBTrknjzKc06ZvtyG3YnDpOsZZI8jbPv8N
         8/rrjdxmUjbFURokE3ws7b+UVTFXnwypfhgEn4NmhJj3u9cMZMbyHKra6CoUONBH8Vtl
         QC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737031432; x=1737636232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91faCPnI6BFBNuEQ1W5ciAABK9q4SQ7lWA8dOZ2SPLg=;
        b=AsXVnCMkM4P8CKhx5JA13/KZcD7xdMWLE4UbCqXyFVCJmkXTQlL9X1VfD76PL7ufZG
         AVFlDpogCjoCDu7Nab/OafKXX1rpDzLAftfW8cGrDeBQJs+c+NBGvkcihyAfntArIhNX
         ABZslgCwbhRtzraOG8VV4exSTmYHnBwVWFpbpHU9+D3x741j7zThV6aOM+VLjGOhz7Sw
         yB6ZyLTHEpkxeN6IhFwW/W/4LdxfEyfZYhmAO0C9GVa7Cb67ZHkF3hnM+Vuc83os/xwI
         94c0H7EwUBrvid5NdZ/rzyQXybgt/+sebxnFcvZqsXFnfzdcc8KK0D4ikCkxJG2xlwPx
         zBrw==
X-Forwarded-Encrypted: i=1; AJvYcCUDBbv5gqnArkKV9O61x+jAkog2xtIRrRfR5ibBwFy7d9q9cjnLuUmt1k/X5uX44cFZtU8+CXrYa5ODNWc=@vger.kernel.org, AJvYcCWrbtzuF5ae5gTAasba8dclKHGrGKHqqzaOj30z6Bp0n3k/Uw/pwufkCtit2Md8AWDZkNbIaesJr0uu2WZ23Is=@vger.kernel.org, AJvYcCWz6jGsDONSmCeg47vz1diMCYrQVQD5iCUfCAB76MtPbJI+WcgQhMdFBVQHrPzGkORKC39gGEGj@vger.kernel.org
X-Gm-Message-State: AOJu0YxHUj8MvSl8/1F8T1N/PGtAEQ+Qu0bwH0497MZXHCYztniYzzz9
	/6jd9bqKF4Z67FMk7OZ0ZX/92cuvDDmaCF3L6R9i1cHKiKFG/n1d3RrUmozqtc7zDn+vWhEGTxQ
	Wj1yZwPzybMy3zTkDFgH5oMKeYUs=
X-Gm-Gg: ASbGncvljBunWH11DX2v1RHQWLoG5v5VGPRDseYubp5NGDcn75CbLJuWyth6UE0X6Pe
	V3bWvqW/zgPdaxoTRwfV2r18iqoXZfbQKOd/KRw==
X-Google-Smtp-Source: AGHT+IEfMzPUH0Gcuohd1YVqNHc9QJARY1WRjsvRhqrqjLIaqstfyo2D9zD8jhIfd+ioQeb52klag3s731FmZfSIpPI=
X-Received: by 2002:a17:90b:2811:b0:2ee:cbc9:d50b with SMTP id
 98e67ed59e1d1-2f5490ac695mr18452301a91.4.1737031432299; Thu, 16 Jan 2025
 04:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
 <20250116044100.80679-3-fujita.tomonori@gmail.com> <CAH5fLghAfovcm0ZJBByswXRSM4dRQY4ht7N7YGscWOaT+fN9OA@mail.gmail.com>
 <20250116.210042.151459337736478197.fujita.tomonori@gmail.com>
In-Reply-To: <20250116.210042.151459337736478197.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Jan 2025 13:43:39 +0100
X-Gm-Features: AbW1kvYt7d_iVfTVjqvF1od81AQIPrtxluUDw4bnVHdFin9wcMRIoz8lfthzIrA
Message-ID: <CANiq72k8=M-9HLedMatqA1U7vTa981MFpQYivYOh+PFWA27OQQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] rust: time: Introduce Delta type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, linux-kernel@vger.kernel.org, andrew@lunn.ch, 
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

On Thu, Jan 16, 2025 at 1:00=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> I dropped as_millis() method in v4 because I followed the rule, don't
> add an API that may not be used.

Yeah, please mention the intended/expected use case in the commit
message so that it is clear, and then it should be OK (at least for
something simple like `as_millis()` here).

Thanks!

Cheers,
Miguel

