Return-Path: <netdev+bounces-137041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46049A4136
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339CF1F24BD4
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921261EE03F;
	Fri, 18 Oct 2024 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COTMlYc7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D872A18643;
	Fri, 18 Oct 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261911; cv=none; b=cDmxjX91vQqZyRSO9bM/i6P0uSIKRtAMswgBZ53LfaEELJFedOJazkSGGK+o0QcXcbRSpcNS+b3hQAQWpM80yxJf+BDPJbTzOJHGfMonSHmI5EW99zYaAok0NBV8TOHo0Q61qStWCBGb9m9mTvsV16DR0e801dKCbQYhAQViyuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261911; c=relaxed/simple;
	bh=lk6+DyuoaJPZ7YVCRmtl2RgXqLNl2sAFoVc2fJS/8uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6CG/fOG7/rlPDseBjnByQvwngxLXKh3eTj/cICVzsh3p6UcearWtYOG9czzR86c7vfGLRLGXZa1EOcOG9WBEjaEcJdrpIaOvQP26VmqNYsypPFGvAoFJN0L6wrEneXaYxfeos7pSDI4j0AM8zLH6sX/Bg75SZjJlh7XV2U9GFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COTMlYc7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e3c0d1ccc6so241156a91.3;
        Fri, 18 Oct 2024 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729261909; x=1729866709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lk6+DyuoaJPZ7YVCRmtl2RgXqLNl2sAFoVc2fJS/8uk=;
        b=COTMlYc7EAAdkT+eIVzw7O8ymxdaIon8VzXPoMuR9xCMOOYoDeXzwkLxBfDX2JZ+fE
         XyrM9fL5nmRxT/vK51gRxqsd7+ATyxHrJJEj1xbmOm3K2EFhKB1uVeb/0un+CfO+2U1W
         FsJbccl2+z7f5QyeqyS5ivgdirqpmNjPuZyYc4Z6/JG7t/DU9MeKfisLqeDRfrXzrbeO
         kKmCehGDFLv8DQKurgG7m0XZAxQnbo+ZLHywcoZpr64xL09jkRawnImujYiUj4VJbHpJ
         opHoKNtZvsyup5mi5FPPPgGX610rK+VMDauXN0r3vptxkWphY9+ab1ql2KQ1dTRyJ/Am
         9yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261909; x=1729866709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lk6+DyuoaJPZ7YVCRmtl2RgXqLNl2sAFoVc2fJS/8uk=;
        b=E0sJtnHOLOTX80fLJuyfS6BPCdUa693jPNELWUZwT7cMa1C944HyRZekMCYS+iKlVC
         eDNjSGuq6LGaPt2rxEIo8FBJuDXLHe23/tGfoLmvNu1JWmH1FAKTxrld35+sn3gZ+NqC
         y5MiE4Y/Vc+R1skrwbCUMde3e9VJbQ0Fk/58xBxhU6q6t6kohT88Vf0n3glyYhOXl7pn
         pJNKCaM5gOUrt5gwz6Dz5+XVx6dMRAzONkpPtmuOp5Onv6dTS3/Px3i7ehtVQfXR+CEA
         Ak3g15GxHZ6tOYvmlj2p9jlffqs5QhnJh7dXYqe6965gawYz2s6cc/rxmSf+8IG8k6kE
         5Zsw==
X-Forwarded-Encrypted: i=1; AJvYcCVjsorKrcj9vrzIGd+g7K9BUWWi+VKEH5/0e1LupsuM39Qf+cDskFA2alk2Y4QmeXeuzQ2PfqIl64/67L9bsz0=@vger.kernel.org, AJvYcCVtR+rBwhWENrI22/nefLBwM6RNpNBB43nuWUeDKs4OkhdW7Gt4ljkCT+RjfLJhKLkl+ypCUNWT@vger.kernel.org, AJvYcCWm5G/goUOhh0jNZ5fZaMerA9fNwzuYem6p3TJ/Cy9/uSuPmIAvW0vE3ELQEtz0d88HCS/FpFojDmVwtBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNBwV5LABu8LAY35SPdkSalUVJHGl9K/Hipvqq/Wg6buGK0wD
	CMe3A3wKwNH6DUplW9XO5W0Gj4he3gn8A+tcgxXHaXrKV7qT+iwfimWLQH+ZoNol24xHKFAvD6t
	SIpWZjzCIDD+CY6Q0rslAQ2twnSbMaMI7
X-Google-Smtp-Source: AGHT+IE6AwVCtS8wCr7hW9IxbnDDZwoHZNPMOUU43Die0A8kevsXu3rEj4UHploq8tNCukIU1YN3JW+Iii5mbXoy/WM=
X-Received: by 2002:a17:90b:538f:b0:2e2:da8c:3fb8 with SMTP id
 98e67ed59e1d1-2e56172b2d8mr1472322a91.6.1729261907506; Fri, 18 Oct 2024
 07:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-3-fujita.tomonori@gmail.com> <6bc68839-a115-467f-b83e-21be708f78d7@lunn.ch>
In-Reply-To: <6bc68839-a115-467f-b83e-21be708f78d7@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 18 Oct 2024 16:31:34 +0200
Message-ID: <CANiq72=_9cxkife3=b7acM7LbmwTLcXMX9LZpDP2JMvy=z3qkA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:50=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> Wasn't there a comment that the code should always round up? Delaying
> for 0 uS is probably not what the user wants.

This is not delaying, though, so I don't see why a method with this
name should return a rounded up value.

Moreover, `ktime_to_us` doesn't round up. The standard library one
doesn't, either.

Cheers,
Miguel

