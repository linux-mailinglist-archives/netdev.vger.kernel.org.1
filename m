Return-Path: <netdev+bounces-131253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D5A98DE13
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AAEDB2A42D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2151D0B97;
	Wed,  2 Oct 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biNXXWtV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5A1D0F47;
	Wed,  2 Oct 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880758; cv=none; b=S34bzjKQoHxtDleMznjMWyqXMJqs//6FVhwSfw1s433bqicxNkgBY80DUYA9v6DLuN2zZa8lv6KbcNKWAFJJdjGv6qgORbp4YcdF6eRqSZYdMVN/SY7lX1vNvLgGKUrHj+x0IE6QZ2ZmF3tEULAd/qb0IlLhiGEwk5/q5ndBrCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880758; c=relaxed/simple;
	bh=V+a2veyXwpcFA01Tv6jtjqp3J5q5tTJ8RuaGZfKU7OU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUD2006ji9A4GhnVWuP7VT30CfQ0Cwo+3RXPxoEKbF030G5agZUxUreSnqfwg/ynUczaP5N2b8iqI5ZMo4+uv74mhslpwsQnDk65/e4ejsHRDJQnpWcCdqZQg/aDxeY4ycGDKU+YwIlbrabGb9MnlxGUJTC57jCRwexyjLkvPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biNXXWtV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20bc65aae97so689015ad.2;
        Wed, 02 Oct 2024 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727880756; x=1728485556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+a2veyXwpcFA01Tv6jtjqp3J5q5tTJ8RuaGZfKU7OU=;
        b=biNXXWtVjzEkCJSB+5C3qAqP9GbZgjS4DpGYn72dUr36OW3WOcriU1AI9L+4NSUTNN
         EYTFE2banteHb7zCrlIEcq6C6/QSiNy4rnAQngUcA6J0NzPFR6p0L9GgRGsxglulGOS6
         L38qMUytmvXpQKrgr6RTUaD4q7RGDoeQfzMUCSEvdtwARrH0T69ROiZ8inNO1qSSkEAs
         btPNxHGLcDBEsKQpUeRWdJBTxU6iSgNzrfR2HlmGTzPdlAgAm2iIVKYZptQDy2R62q2C
         muoGg5XbtP34E3woU5pvLWOt7Hqk+h/pYqVNqCLkRLESpy0M5Gcm2JbVxFyo5YcvdCmk
         Dcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727880756; x=1728485556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+a2veyXwpcFA01Tv6jtjqp3J5q5tTJ8RuaGZfKU7OU=;
        b=riXFoVNF+4lphvAHsxxlxojdnAEqAP5xxjG5c7dUMFf29TUBxPV1hiJogeINXIT9pF
         Zk3W6Id+EJsTMxfJy6k+rjzYgwpN57Emk+BiciJcut8x6enydir+Z2xysD7BbhRHBrNg
         MSCe/6pNlmMToQFnOS23vkSlXqpIl8Er5RCQdpev3ObHt5UHuFuBLsie6jmOSxaoz3SK
         /6adY5v5huH2tOk8KNbKXTJEQWjVQCg0OWHOyjV+DdsRFPVJXXpvwq/9GndtZP2bCgYi
         LlDYRBZ9AJccU8O36AUEQBLFdFpFA6/65o35Mu3Lgw2nRbxrwokg6HGHNGOv31QbRt+R
         d+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDU6IHurdEdhdUtxmIqUuwZS2BW2ryxPwj/sjjMq2eCEpHbQra0pxtlG7SpT+cchT9Zxf6LHAG2K2RAGxxa+M=@vger.kernel.org, AJvYcCXaX1B/OhY1Z1q+1DjpU0AkyhX5xd0fQ24WnaNzDfzumeYyXuK2N39kor9fOL4asOYVZPHSf0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7bfG3lUtKVCWMO1cZNSB0f/z23RBEsWy9c0ituSiIBDpO9//T
	jSpqzFTgSS5KQ2+PiUDAXfoqFhFNTWsNRWd3fHMej5Ii32RIpE2nifdogOp9j80znAfd25yy/Hj
	JdlRZPGHFj/JKay4cknFUek6/v2s=
X-Google-Smtp-Source: AGHT+IGBSWEXRrkLaJTQxphWH+pfguG+tnmGutePFceBlsU+TluwKFQM1OND/iepw9eJFICmKyP43bNLmU/KahcT+HU=
X-Received: by 2002:a05:6a21:788b:b0:1cf:2be2:6526 with SMTP id
 adf61e73a8af0-1d5e2d2d301mr2324621637.12.1727880756560; Wed, 02 Oct 2024
 07:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLgiB_3v6rVEWCNVVma=vPFAse-WvvCzHKrjHKTDBwjPz2Q@mail.gmail.com>
 <20241002.135832.841519218420629933.fujita.tomonori@gmail.com>
 <CAH5fLgj1y=h38pdnxFd-om5qWt0toN4n10CRUuHSPxwNY5MdQg@mail.gmail.com> <20241002.144007.1148085658686203349.fujita.tomonori@gmail.com>
In-Reply-To: <20241002.144007.1148085658686203349.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Oct 2024 16:52:22 +0200
Message-ID: <CANiq72kf+NrKA14RqA=4pnRhB-=nbUuxOWRg-EXA8oV1KUFWdg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: aliceryhl@google.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 4:40=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Sure. Some code use ktime_t to represent duration so using Ktime for
> the delay functions makes sense. I'll add some methods to Ktime and
> use it.

We really should still use different types to represent points and
deltas, even if internally they happen to end up using/being the
"same" thing.

If we start mixing those two up, then it will be harder to unravel later.

I think Thomas also wanted to have two types, please see this thread:
https://lore.kernel.org/rust-for-linux/87h6vfnh0f.ffs@tglx/ (we also
discussed clocks).

Cheers,
Miguel

