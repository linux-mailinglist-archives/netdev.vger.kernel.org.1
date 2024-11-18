Return-Path: <netdev+bounces-145702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BC49D0735
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 01:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19851F2121E
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 00:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA3B819;
	Mon, 18 Nov 2024 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="Gu4Zuf19"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E84A23
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731888710; cv=none; b=fDndG+q1ER4HbFyvoRH0T0vVoH9xQsvpKjH3RTWAvqNB2W9hUcB+Bm1i9BdFEeSTera/pGMR13aUxDXdUl5K/jKpVjdNx4wMKDEW/0IGOEpHwd8u09QumJV6Sen+DnEL2GgQlreT0yzU990sk5np6vmnilxflGX2+R+XWWClKHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731888710; c=relaxed/simple;
	bh=SoiSwSD49lv0IM/8lxFpHyYRjD/sbJDFjhrLAiQDzxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeEeiZNl+z/7p2rcd+x6vqYNODSpa/Iz6mcuhU0sXg8CVVSEWfsIy8ZjYlFMDshT7r46roXCJS8em7RTA7xr7UkBXEr8Ss+1ZVIZPPhlgPITW7x64Nz4kSvpNL5KNUYro9VXCl6HqxXQFX1m4oCAdaDozHqfHigPrBHr9SguKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=Gu4Zuf19; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ce65c8e13so25499875ad.1
        for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 16:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1731888706; x=1732493506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fzm439oR2uLsNkSgKqi/IwHWxPKHwC9Szch4YmaJqco=;
        b=Gu4Zuf19xD7wEZztbR94q9cks+9MwBC71zPvxPDdrh91SvmD1TW5//EWdkhWfSV4tC
         EekkYtEBNvtuqCCsl9jb+VhWBuZyc/BB/iGuLL0Hxz0n/sXWmhsxs/HQdqKv446+ahll
         pJWcgm+8EHF8HJefDiZNP85jc9MrUvnNJU7Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731888706; x=1732493506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzm439oR2uLsNkSgKqi/IwHWxPKHwC9Szch4YmaJqco=;
        b=Q4MKYIPJTiTWbChRWdG2XWMv6Tyi4/zXTh+u5NtaIyEzZ0pWSSA3+1eIDAFgL1KiD6
         tmWG8REPa0m5dn6sdyPIqe5hgohrLuZTXSA080zrjyen5+zN/YV6RWNVRyTkeNhrMvG1
         f7QxvFhjtrb7RVv319Ky1yDvWNkB69ZBuCgXZuEvQVHZ8tZFdZ8t2q6tneilCZXogqzf
         70Cdda/IhRTJJ5xELhykpiPn8ANDyN5NQQC1z6X0uzv7VFPUAGkMxrQpPSBBZ/LpkUbp
         eYm3RDACR1u+qoXpEUgUKG57ZlZswkscwsibiXWA/N0/7D7hTf32rRynf6+RcYT8mRZV
         L4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUHk3fg/VUm3xtBxY8RAa7SNRlWyd6HdEbZF96MqZuBjoSFKL6kI1hVkZneyyIw8xhag9egH6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnlIfQMewcdJopSkzG4lrv+IsYeohUwpqG1nZ02iDtecKZ66MB
	aV5QY/rA9KwEEe15OcJEx7caNrrNHp3Kno3ir+kW6SGxekd29nODhdNP5X7boVM=
X-Google-Smtp-Source: AGHT+IEWvPNXF0LNjE2M13xB8ELSPmICXmcw9ZU6urY/s0XrAzOHzNs7phP0Ghc42LEvoQ5pq6eqTA==
X-Received: by 2002:a17:903:11cd:b0:20c:ecd8:d0af with SMTP id d9443c01a7336-211d0d5eea4mr149867975ad.9.1731888706270;
        Sun, 17 Nov 2024 16:11:46 -0800 (PST)
Received: from fedora ([103.3.204.127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211f6769057sm26344825ad.206.2024.11.17.16.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 16:11:45 -0800 (PST)
Date: Mon, 18 Nov 2024 05:41:32 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Alice Ryhl <aliceryhl@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] rust: simplify Result<()> uses
Message-ID: <q5xmd3g65jr4lmnio72pcpmkmvlha3u2q3fohe2wxlclw64adv@wjon44dqnn7e>
References: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in>
 <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch>
 <CANiq72kk0gsC8gohDT9aqY6r4E+pxNC6=+v8hZqthbaqzrFhLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kk0gsC8gohDT9aqY6r4E+pxNC6=+v8hZqthbaqzrFhLg@mail.gmail.com>

On 17.11.2024 21:49, Miguel Ojeda wrote:
>On Sun, Nov 17, 2024 at 7:26 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>> Please split these patches up per subsystem, and submit them
>> individually to the appropriate subsystems.
>
>That is good advice, although if you and block are Ok with an Acked-by
>(assuming a good v2), we could do that too.
>
>Manas: I forgot to mention in the issue that this could be a good case
>for a `checkpatch.pl` check (I added it now). It would be great if you
>could add that in a different (and possibly independent) patch.
>
>Of course, it is not a requirement, but it would be a nice opportunity
>to contribute something extra related to this :)
>

On 17.11.2024 18:56, Russell King (Oracle) wrote:
>On Sun, Nov 17, 2024 at 07:25:48PM +0100, Andrew Lunn wrote:
>> On Sun, Nov 17, 2024 at 08:41:47PM +0530, Manas via B4 Relay wrote:
>> > From: Manas <manas18244@iiitd.ac.in>
>> >
>> > This patch replaces `Result<()>` with `Result`.
>> >
>> > Suggested-by: Miguel Ojeda <ojeda@kernel.org>
>> > Link: https://github.com/Rust-for-Linux/linux/issues/1128
>> > Signed-off-by: Manas <manas18244@iiitd.ac.in>
>> > ---
>> >  drivers/net/phy/qt2025.rs        | 2 +-
>> >  rust/kernel/block/mq/gen_disk.rs | 2 +-
>> >  rust/kernel/uaccess.rs           | 2 +-
>> >  rust/macros/lib.rs               | 6 +++---
>>
>> Please split these patches up per subsystem, and submit them
>> individually to the appropriate subsystems.
>
>In addition, it would be good if the commit stated the rationale for
>the change, rather than what the change is (which we can see from the
>patch itself.)
>

Thanks Andrew, Rusell and Miguel for the feedback.

Russell: I will edit the commit message to say something like, use the
standard way of `Result<()>` which is `Result` and keep things consistent wrt
other parts of codebase.

Andrew, Miguel:

I can split it in the following subsystems:

   rust: block:
   rust: uaccess:
   rust: macros:
   net: phy: qt2025:

Should I do a patch series for first three, and put an individual patch for
qt2025?

Also, I can work on the checkpatch.pl after this.

-- 
Manas

