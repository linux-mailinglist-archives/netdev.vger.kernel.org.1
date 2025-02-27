Return-Path: <netdev+bounces-170445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E8A48C5B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D719F7A4DAC
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 23:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF623E34F;
	Thu, 27 Feb 2025 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcyfu+iY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6122576A;
	Thu, 27 Feb 2025 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697563; cv=none; b=fkVaIKZN65bGtT/R6RH3rHSVIkr2l9M3vpyCISCbnSU1IScrTfjvjBACZPBbygIJMbziyvON6I/pVuOkb21QbNb6NNct9RyDdCZfUPw9CjH2argiUNZyn0GzCCWHVEFU4YY/aklkN47lIwzh16pSZ2smksVh+rDPh3O9BuRPzfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697563; c=relaxed/simple;
	bh=rgtrLuHOSA+BJDhMAVUtsCdxF0mStA5rtZm9Atuab/Q=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cpOwHrhbD67XIUQtsUAiIW5sXkUMJRMoAeduyQz7SbAjR3NDspcvUgpEdLjWOdWIDjvOeYE7maATSsoLXbAs6fZ1Jn94p46+nhGAm766QiQadFp5EDAIEvjlptFEWIwR/DVHn/JHsyw9HU/MhxTn+s+3M4DnakgJbMUyOS5I4cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcyfu+iY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2212a930001so38778175ad.0;
        Thu, 27 Feb 2025 15:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740697561; x=1741302361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jiu1ZZXw7IbtEQRSg1vKDSS8D0FLIfuwYf9MN3udZxQ=;
        b=bcyfu+iYnIRgtf0B/ehn7hMHaZ8L3mTza8LSasSCvlCkmlDITQiNh1N1UTFBbsSk45
         65f0fB8MMjYuBkc0LGZPVpi0oG2Ga5a4/EFOsxYYLEn47S943+D4jzv1bjW6MiKWCsmx
         /ldA+AmiOxvX5eOwmitXCoPhWvxcdGMUmm3CEUyWvWojzbdNcJzDqY+kuNMj/mWAALPE
         AmtXp6ONafno4sZ2mirXM35f2PASUwx/dlht7bPqJZ8IP2ZBYIVp7z+iXuI5+CHNAgCH
         NsXV45d0zbSuWifKY8CUn5e6EeZTOxNjvVAgy5wnMCnvgWeT0DfGN2rzf6iVjTZGkdo4
         LUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697561; x=1741302361;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jiu1ZZXw7IbtEQRSg1vKDSS8D0FLIfuwYf9MN3udZxQ=;
        b=g80wSyB+NVhY2NqpQxK/1lrIVOieM5vLCqyXsUYHtPveTF05H4MpD8bcFaxDSqgSrA
         H6oA/HlVZ3ZTLLnhPovEKuzvT25fqU/J1ggv1XUeX4cOuqJzpCZo4GGJ2xszhzHLLMsJ
         m7KGEJ+B+V3YAruAnnCovHSappgbKSrwWBMondCByZUQhmCRy669Bmgy7hhxiMVrFIfR
         /4gXGYge7je3PGWXGqlLm4GMZlfgy5S3nHRNR03gG7GuL7iIaxt65d4aWhtfcEY4YlxX
         4+dNXTKxvogZ4DfAJs213gSQHgML7xGIa2e4bhYEAmOvdHUQaGl4608DDLlhnoQOzirf
         DTzA==
X-Forwarded-Encrypted: i=1; AJvYcCUeL8OPASt395C5FJoSRSWNP0vlJfLqC3y5/XyRUyylAs6qKfiJSZcJV2mthOo7wjjjWzKXYSNQ@vger.kernel.org, AJvYcCWOg4pCJtmumohQ/TLGl+r39mOhBZuAIObDDbFCuxMF9fTC6aMnNWGWpgr1tbOPHSrNxAhXyI10+t2+kv8=@vger.kernel.org, AJvYcCXZTtGHBwMO085r7t0bA9Y8G/AiJyO2UH3bUj8a8E1fi81NwoBK//qOC8cKuHm/kokMazkmg7SgQeJBvvyCxVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE6GXit1EjcfKpk320Ajf3JiQFR4uNlZ32ddqpKv6JebWzy0CA
	IdmFnIcpYps+ipV88GW1B9v9dRIQLhpD+wxFxq/B9qgfSaZa3P5w
X-Gm-Gg: ASbGnctDbaijNlSWgUitXFNakYM1uYLl2BKF1uFd6856zXtDAjFobPXRNKbq6ARu9Zt
	cWIc5FeXdbR0Uumt2Y0nK+IaM7YTulggtmrkNjRbkAePNwgFtMTCnDWo9tPcbBE43LvnuWV395S
	umge3q+uk/ETSfq4AAYzuoGzGwmgGRjplYr17m3GdBtPzjAKvEgd5t2uz28VqB/aV8NUe8sdwGD
	hW+lYaeqqJYCue0hg4FcMMZi2oZ5xo7O3Ya+l9bVvqdjYavGP9OJW5TWV7Ze0u3Y8mIOWAieN88
	aYp1rOK4tQzVmWn5g7lD2foa6dJJR3x2hi1+8ha40NIpkeNmMerJdFPDju49HWMbNAXypIciCPF
	z2WygE6A=
X-Google-Smtp-Source: AGHT+IFR2YCuurIowDt0hjyfCW8MB2cgilAQvppkruAaln0xxOMIftrIrBwIJmpCsUOH2jxFnOuCGA==
X-Received: by 2002:a05:6a00:847:b0:732:516f:21fa with SMTP id d2e1a72fcca58-734ac36f3d1mr1877980b3a.14.1740697560726;
        Thu, 27 Feb 2025 15:06:00 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a005fd15sm2298487b3a.168.2025.02.27.15.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:05:59 -0800 (PST)
Date: Fri, 28 Feb 2025 08:05:50 +0900 (JST)
Message-Id: <20250228.080550.354359820929821928.fujita.tomonori@gmail.com>
To: daniel.almeida@collabora.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
 david.laight.linux@gmail.com
Subject: Re: [PATCH v11 0/8] rust: Add IO polling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <4647720C-28CA-4E18-AD1E-55844CF078E6@collabora.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<4647720C-28CA-4E18-AD1E-55844CF078E6@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 14:29:45 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> Would you be interested in working on read_poll_timeout_atomic() as well?
> 
> There would be a user for that.

I think that I can add it.

But I prefer to push the current patchset into mainline first. I need
an ack or nack for the first patch from SCHEDULER maintainers.

