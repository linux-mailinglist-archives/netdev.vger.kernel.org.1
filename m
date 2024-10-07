Return-Path: <netdev+bounces-132624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 001B0992818
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569A0B22BB5
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8490818E05B;
	Mon,  7 Oct 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZwr4fUR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271121741E0;
	Mon,  7 Oct 2024 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293368; cv=none; b=HdkzOBm6i03dJfCyNYQoi6e3Y2iT1vogG28OWsnvAxJnewljY3H/hPum4vIN0XxSjmATdPN6pjCxisiLnnTVBRVhF4ttMXEAZsGX7NjIkUAHrMINCFRkuXI5SbPDFk0mlANsHt+Epl88ZuTEfblnMwdLO9so3/8P53ppMdlg1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293368; c=relaxed/simple;
	bh=qfOUFBTvqCB4FE9gv1uwZN2K732kdqC0ng7ZaNbM7SA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u3JCTwj0bpZV/RsLdEr1CVLED1y/iA4TqRbIDEh5cOJ3r9MecdkVKGp61QQbUilIQrxzUqyvHkpj6ZDH7BdydmVJM6xLwqBMoVqeYLJrC8aHrAKfT4pTpssw64xQQTvJs64q+xN+T9F/E5Box2F9jPKVPRC7+Iy+9gkCLUD/Spo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZwr4fUR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71def715ebdso1574052b3a.2;
        Mon, 07 Oct 2024 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728293366; x=1728898166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0mfmzLytCqyX5Ep3iM/eni/YkVGAzsnZDXJh44T6XY=;
        b=jZwr4fUR079yyBEaGJJfOXltidHpeDnTRSVBfeoLsQe8sVgr2XjYCUKf3ihdpDjmjH
         CU55LBvSK69HdLwGXds36tG1oDicAauLL0uBZzDpfaqp330rhpOx8+4+H1BKejglBCX0
         DbnjNBvM27D+vL71txdWDUKPhRxPqpkSAFCQ1uKEvikP70CRN5/YXEcHokZLvdXadPy/
         eh+NqYEAowkzSColrem1p49T5VSO7Y4nKFvxB1Z1fEWbtIzIR42aCmEXLlRFjGXHuhpS
         Pnm4MVnme14syyOJxudkSGFwuPmns8tq3/QkyqOMduKNHBHl5iAAICvYTPrIqhBK34VX
         PI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728293366; x=1728898166;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E0mfmzLytCqyX5Ep3iM/eni/YkVGAzsnZDXJh44T6XY=;
        b=aG4VIHtnt8Ob/moyc288GF3sIABzZFd5S1mwN5M3fuIfbQaOPsGpLdamxBAFD+iqtv
         eGHvJYvm3kPMPPPQgFrVmR0egiZx2m73yrtwm89k/0pyyzjw26r96lk80AXkReKsf4xR
         uAbEPBeQjYCH6Y1ggDFT0TLLssagBjm2owMXIX6VQgLxTT5F9GegyH5yZijbY+vWnuMI
         RMNTsQZyX4i/3p0Q1+nYV3gIk7jGn8ZQASAmLE2MQRM5q9YcJmZrceGmjEvhx1gISCNl
         9c4FG33fwaInTOnFlnRsrgsx+SyIHOEPBQyJCeeteuaNdDU66DOGLRZPnh6Lno3epy89
         Wehw==
X-Forwarded-Encrypted: i=1; AJvYcCURzEdghXfhrXv4y50FBZrw7mRxjjY+eGT9SBruZlbc/u2gWqYNrQ2lV8B1c8wwjdVF9gkKBCpwHv01aMJttMI=@vger.kernel.org, AJvYcCWTtym7loIL2XeKLy6YReMsX9q703V2gYCQYAEqpM2iIYC+FW10C1bemirnKdTj/9gcpsM/Fazo@vger.kernel.org, AJvYcCX3pq0FcrWIW7WhlE3zlOi9BKzqWNmoHJJqj8k3mYhUnwJOk/XOR39D9rYp5t0Xy4Hl0MIwl+aETSHnqMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3GuFJpJDbP98b5JehDSNE8xGPeuY4SZlEyQo8MmUBo70G810B
	0FZqGg31zOcIeHBCCAwcb7MZOttYs0CLgMCM35DBybn0qCWN3uty
X-Google-Smtp-Source: AGHT+IFXVeb2ghbbfG+zM1W/Q0//u2QoLcLVxkZCjJ356wpLdAbvlzyiXYHNnZhtURQIboAkpAqisw==
X-Received: by 2002:a05:6a00:1250:b0:71d:fbff:a4b5 with SMTP id d2e1a72fcca58-71dfbffa617mr9320131b3a.0.1728293366252;
        Mon, 07 Oct 2024 02:29:26 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e03288a37sm1478705b3a.155.2024.10.07.02.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 02:29:25 -0700 (PDT)
Date: Mon, 07 Oct 2024 18:29:20 +0900 (JST)
Message-Id: <20241007.182920.1572597460085693509.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, finn@kloenk.dev, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/6] rust: time: Implement PartialEq and
 PartialOrd for Ktime
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgirPLNMXnqJBuGhpuoj+s32FAS=e3MGgpoeSbkfxxjjLQ@mail.gmail.com>
References: <3D24A2BA-E6CC-4B82-95EF-DE341C7C665B@kloenk.dev>
	<20241007.143707.787219256158321665.fujita.tomonori@gmail.com>
	<CAH5fLgirPLNMXnqJBuGhpuoj+s32FAS=e3MGgpoeSbkfxxjjLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 10:41:23 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

>> >> Implement PartialEq and PartialOrd trait for Ktime by using C's
>> >> ktime_compare function so two Ktime instances can be compared to
>> >> determine whether a timeout is met or not.
>> >
>> > Why is this only PartialEq/PartialOrd? Could we either document why or implement Eq/Ord as well?
>>
>> Because what we need to do is comparing two Ktime instances so we
>> don't need them?
> 
> When you implement PartialEq without Eq, you are telling the reader
> that this is a weird type such as floats where there exists values
> that are not equal to themselves. That's not the case here, so don't
> confuse the reader by leaving out `Eq`.

Understood. I'll add Eq/Ord in the next version.

