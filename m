Return-Path: <netdev+bounces-232811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A606C09096
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 15:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC9C405018
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551732ECD05;
	Sat, 25 Oct 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8wvdelT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A786337
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761397241; cv=none; b=MoLMv4PeWCsJENiqKrQd7oErxp1uLfIowmLb5Djl9KezSqrgVvFsVOztIouV/EhMwckWXnMHSnYQrp95jloXdLVwId4BleR4QIc0MBkGeMDE29agRJY7GTp669YT6sqaMNOT11/e1r1GP9v+ONK5PRcb5y/cA209SNFLitA+m+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761397241; c=relaxed/simple;
	bh=EASrkkWI0JBpW6t2iVSbWSdDzPlBVsOxlTbS3n8qIx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bt1T84areU5MrqqiWkj+o2JR1oa2SXTXAqeO9uHToeIi35vAogdxdMtMzx6GlD5OlSvZU6W+lgQajid4yPcwo0XEmMcCe6dQl+C0YsKNAKXiTZ9t3ye/a8ZBVQvCk5yxD2ZeougICLVG0Z82mQeNTf3I5VTS1fxLoOp/hEQGCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8wvdelT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2930e04cddcso5868375ad.3
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761397238; x=1762002038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TFesFsglqC08jCidE73APHCSjqIZFDJA83IY2oNpTM=;
        b=M8wvdelTi/zVnVycWMTSNZQ0yhybu9RiJwgozMHICWYL3Rs09W4QGpcQzVpk7sgKem
         KHktEGICq4Qj/1KczZCrBLlR/P+uv1d0X0GhuWAcAbVJV96R98Ql2Ys8UWmLchJymW17
         Q+nKYNGWzMMljmNzRJFv3npTRyN5E6vVM75+XmScCPQqpn5izLBAZcH1aRNQMlCEW5i/
         KEEeLICKgEGCJjORe8nxyuAowSL0mo9dpMjuJB+b7WiMbaPQJCfc+1OKEQIQy7mWNfmX
         KqdobCeaMHtJKtoJ8oX35MukYEkNHh26nETVGDOVRxFnGfFihVBVVunwT+OwkjcDOhV5
         qiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761397238; x=1762002038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TFesFsglqC08jCidE73APHCSjqIZFDJA83IY2oNpTM=;
        b=D5XJ2+eeknvIwGe6ncyAOHc7CQwvw3DgCb2+OV0YGPxNnc0TVey9QLhJmQymaMUtIK
         1nm/q8yCMF47RNDTJcvR1qHw5EUdz87oYueFel5Pekb/eVfl4cY8a2mVH4xr6BC0eWla
         GwKkPrSDabC97SQ9YGGlmKsO3O/abhCmKNEx5slxIsCiFMoWZ+8QtSzOdsLiz1+GVZ/H
         ZqcrDyAlSXDAPIRNw6JxNQ3UHK1/QQkEUEA5YdWe3KWh8NKNwyPutnIZcnEgiHWOMM9T
         v6C+mbGKXRYxovk/4/8blWIPO9a4ADdky1WstnxWIPaVhAQzOw87sKL+ZOctm7VJDQY/
         PWXA==
X-Forwarded-Encrypted: i=1; AJvYcCVh+2mpDjXTYu6Wa89h386Qf31V7yHEKwWumzmeE3HSh1FNfx9mgWosieyOZst28njULgbm7KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbRtc6eqKkwRlyzduxMxDSw7RKmsH0+abosrR8kRtckBEWqak
	Y2YRgS1YPAOoJgr0WBdSSfZ/kdE1zI9D98dglDVESpjFNVHop5cNju9u+NMMNkvGoyW1LT/Dbi2
	pkkTV1FNOU7bZg1e9XAwgLvIuygT1pq4=
X-Gm-Gg: ASbGncsbdFsFsflZFM5xgkD8jbs4MqClcZYVwHTqc0DPwNncAQ8GCGHIy+AK6aqXeRw
	hhhTVe8T9ee4RV1QCn83XmbhCaB9lG9tlfK9Q9p9m1Y+u2VkfSXjUGeRWOwxaoz31RZwqyHRyZS
	/xjhWRBF7Ot8lNODGyBNdR22kWvYneLnonV9yxeFcOiLP0jdv4ZiIZ0qDl7f9+93kudFWPjPaxc
	VMVN5W8nFwz+4I75/zdMw1r76m3DPo6xoTzDRV2tTlOZeehW9vKMqGI/m3TOnpg1FpE9y+iudGK
	PmOCLIVsZwElgjxB7najL/kVWMpzKokui1F4n6eK2vABfFA/dZMjhjdHmv1p3whZQyQXbfS+bWt
	nH9Ghh6TRVhzn8A==
X-Google-Smtp-Source: AGHT+IEbLNoUs/7TUmb7QhdPzsK9jT8ZWrQxkiWqqM8zlucYBhznBt9a3wsSN3HfQJ0dcN6G5T51p7iEwBJO4hkdeVc=
X-Received: by 2002:a17:903:1965:b0:292:64ec:8f4d with SMTP id
 d9443c01a7336-29264ec9324mr156200135ad.8.1761397237982; Sat, 25 Oct 2025
 06:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025124218.33951-1-sunyizhe@fastmail.com> <CANiq72=d0zXWAryVXHUKLUkcM_dPoC_uPM2drMXAVB7kh1YSjg@mail.gmail.com>
 <68b53c52-9834-41f9-8e40-ad27f00436a4@app.fastmail.com>
In-Reply-To: <68b53c52-9834-41f9-8e40-ad27f00436a4@app.fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 25 Oct 2025 15:00:25 +0200
X-Gm-Features: AWmQ_bmJOsQ0f363KiSb1YhEOetWFbn1bZiw_EvFWfI2HmZUeHb0IvCaFzOzsSs
Message-ID: <CANiq72mfjbiJDSz=n3BR1quNwbzYB1ZZhADDU5P3b0bDmGEk7A@mail.gmail.com>
Subject: Re: [PATCH] rust: phy: replace `MaybeUninit::zeroed().assume_init()`
 with `pin_init::zeroed()`
To: Yizhe Sun <sunyizhe@fastmail.com>
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	tmgross@umich.edu, netdev@vger.kernel.org, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, dakr@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 2:50=E2=80=AFPM Yizhe Sun <sunyizhe@fastmail.com> w=
rote:
>
> It is. He requested to have his patches re-sent because he didn't have ti=
me. This is my first time participating in kernel development, so please te=
ll me if I did something wrong.

I see, thanks!

So it is this one:

    https://lore.kernel.org/rust-for-linux/20250814093046.2071971-5-lossin@=
kernel.org/

When submitting a patch on behalf of someone else, their Signed-off-by
tag must be kept (and then add yours too), since they are the author.
You can read about the procedure at the end of this section:

    https://docs.kernel.org/process/submitting-patches.html#sign-your-work-=
the-developer-s-certificate-of-origin

Also, what I would normally suggest is to indicate that it is a resend
in the part outside the commit message (written right below the first
`---` line), ideally including a link to the original patch (i.e. the
first link I added here).

By the way, ideally patches also have a base commit with e.g. `git
format-patch --base`.

And no worries, it is all good, getting these details right the first
time is not trivial -- welcome! :)

If you could please resubmit it with the SoB fixed, that would be great.

Thanks!

Cheers,
Miguel

