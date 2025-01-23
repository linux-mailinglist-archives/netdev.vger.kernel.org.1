Return-Path: <netdev+bounces-160557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AF6A1A27F
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 12:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA1B160A53
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4335B20CCE6;
	Thu, 23 Jan 2025 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK5iadzA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81E820E009;
	Thu, 23 Jan 2025 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630252; cv=none; b=ugEOmoDQiINQWV+myGFipHaXVLW5Pm5uNaTjg09PP8clnnp3qSeF9G1npGvdiAQpfgrE3P8Bki5XepPBFS0weLNmasGrXdwQz7C+XfBIzCcLADrZyhqwt9unzAN+GBgA74bh+cbm+yJIXbjsxbo2s+YQNmGNUv2rl6LKZrev81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630252; c=relaxed/simple;
	bh=Fzo06p7LbGOK4VfFKjg4NmV51POOKOUCBXzkkK9h//o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3MQR2LvXi5Cf3iFPjgNV5ituLMyYfFoFxZDQen3o++OSV9sKx6gF8mhwN1PrexZVjejojXHD9XgaLvG1733RIwOpE7oV2fIYONvCyXFA+nTuKbaAGPLuGF8qH3MwVWbmtpj1MpwH6VeVT7aqLXu24ghvSYmrbGOH1D/VnXJj1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK5iadzA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f45526dea0so180202a91.1;
        Thu, 23 Jan 2025 03:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737630250; x=1738235050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzo06p7LbGOK4VfFKjg4NmV51POOKOUCBXzkkK9h//o=;
        b=HK5iadzAbSEOl+9/YoFLR0A5r8Q9nEsH6QtVrhX6ttBmiPtPeCcJGj0rstV9QKFUFe
         Twwmt10WhnoHHp+wtRWEVemKtpJwWTI3YuWjw+q7Tay7+XVU1GnZguZvZvOiFDzEHMCf
         gFDlihhd8hkL16xZJbxVOuTmY0DgVcNvw685CxU7Wyc47k9eNIF2pBtJHlKcwwPiDkqE
         YowNouP4+0+4e/YsixVi4Wfq3jtCGE4V+PwBKYGo8KqFZvyyzTVi9TYJi5CvYVBVNb6P
         /Yw2BW2Vy709YZ+TSKArYw8z08emoHrvN6piZ3bfOuHPvYie+SMUzGoIud1Ei05pobiq
         Ovcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737630250; x=1738235050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fzo06p7LbGOK4VfFKjg4NmV51POOKOUCBXzkkK9h//o=;
        b=lum1Z2sBhKrJ27sPB3gak3OYz7B6TlBn3mj4TpmMo4HZ7kTc9/kp2xUjfsdUuuNrba
         k8/enSVQKJ+5LO9XFu1I2ahJGoXaTE7cRs07dIUajoPKp2KJucEvqQgvZFkQaJOG98BR
         s9nSYZ39JF5698isXIRr9oDB1f6+5Hv9hSTA895GhMhf+Xe771Z7x6EBpBW+3iBe7xzm
         EtR3i/bddgMn3ImfmXImTFb0haI9cl1jkl9V3Dg6HPmZsXOSbTCTf3hoin+BHkrXMU31
         SOZ+DTy3ujmDIQFPA/Qu+oMj4acjG5JZYkAVlXU6ZqGJTP+knuW643/Q5SZQbI59fcxV
         a0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCULsxgU4D+ZasEVs1n3UJjP/ggN9N6CYIgBeLDF3kyTI3hePoDLyFSh0QDC4lDoiWY7zqcTKLqB5C7bPsw=@vger.kernel.org, AJvYcCVWqufx/avNYgnuO9KN5ewWf1AiYlv8OlULzaW1mKGh2Q8ElJdWU7k9IrwVPpblEHjBqMEHd+GU@vger.kernel.org, AJvYcCX95miUE0r6PllEhD4CR+TNdhpQKTXghJ19Ka1IleMhF8Uded7miZExLgo2V9ChO4dVeetw4e+WqubDMgmlY4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd4HZSxYAXlWymzzyKb9z7swd8ORs2LFIFNTEXUINcGL7T/0w+
	IXdqWqnI6YvLuxVjUQmSI/aOO2mI5KDEeGpAW53tmxv9t1yDZXtOkwXfqXC9V6+/Ouey8Dqwch0
	yLjINSTaabvXtHaMnWMlgyTwF5IN5pgZ2
X-Gm-Gg: ASbGncsCZfefv/GYqELXs60Je7JT6l7oTERZJUVJ6IL7Vlr4CjBTxYNRWUFzg6puPOL
	F7zhcxdSWND3qHD6rfKgOYZQrYfg76uk07YO0863ouanvwWfp/mqw2Zfr+kdZ6A==
X-Google-Smtp-Source: AGHT+IErE7Mk/Hv4lR4bn+1BCQ6wuArrQjSwSOVt/rGhgOGYV9tJ4eUVFee3uzk+5C0oyr/HJR2OHgdGbydMLnxUp/A=
X-Received: by 2002:a17:90b:534c:b0:2ea:5e0c:2851 with SMTP id
 98e67ed59e1d1-2f782b06d93mr13769040a91.0.1737630249985; Thu, 23 Jan 2025
 03:04:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLghgcJV6gLvPxJVvn8mq4ZN0jGF16L5w-7nDo9TGNAA86w@mail.gmail.com>
 <20250122.194405.1742941306708932313.fujita.tomonori@gmail.com>
 <Z5HpvAMd6mr-6d9k@boqun-archlinux> <20250123.174011.1712033125728284549.fujita.tomonori@gmail.com>
In-Reply-To: <20250123.174011.1712033125728284549.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 23 Jan 2025 12:03:56 +0100
X-Gm-Features: AWEUYZnSN-u14_3F504620wE10KcsGXv_0aa4VFT7rZTZHgaKbu-nyKZWm7z3bw
Message-ID: <CANiq72kbv2BvQHKWeLV89hmjqL479MpzkE6PKDj8SLm9ehZE_Q@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, aliceryhl@google.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 9:40=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Thanks, I overlooked this. I had better to go with [`fsleep()`] then.
>
> I think that using two styles under rust/kernel isn't ideal. Should we
> make the [`function_name()`] style the preference under rust/kernel?

Sounds good to me. I have a guidelines series on the backlog, so I can
add it there.

Though there is a question about whether we should do the same for
Rust ones or not. For Rust, it is a bit clearer already since it uses
e.g. CamelCase for types.

> Unless there's a subsystem that prefers the [`function_name`] style,
> that would be a different story.

I think we have a good chance to try to make things consistent across
the kernel (for Rust) wherever possible, like for formatting, since
all the code is new, i.e. to try to avoid variations between
subsystems, even if in the C side had them originally.

Exceptions as usual may be needed, but unless there is a good reason,
I think we should try to stay consistent.

Cheers,
Miguel

