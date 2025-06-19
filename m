Return-Path: <netdev+bounces-199619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A479BAE0FC9
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 00:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260F317DC93
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 22:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F1828C5BF;
	Thu, 19 Jun 2025 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wozd3JfM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C728DF3B;
	Thu, 19 Jun 2025 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373701; cv=none; b=uUR+qj6HCemisCXePLIXBNyOQW3KdGaQyOy5dAY+C7evMz4Rr3yvtGmjQHTeZI842wJmIqmOiSN8JzyANKWVNLyL7s9X/KMylGi1a0minDBKGAwJieZ0COeHGvxfUZBrMcivzNeUMyUO6SiHqRKmRTObhZhFsDS94TRljjkIEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373701; c=relaxed/simple;
	bh=6sePk+G/EKaUsxFhwpkZ3tXruwwG27Ix5uopCUKZePs=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NjfYR+zChtqMHkN5iGE4YXsL80pAFJ7qzNQMKzttfB4gDI7/ydl+WttUTrMOQuzQ2FUQGsvS4XEky8Tx0/qI9Krb7oGEKawtG0WTHwViytFPQlP/A9B+6+/saKuwgER7+p9RpmwRvwR4kqzIYV6NJyxjvziZX+0AV3/WNRH5nvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wozd3JfM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso938641b3a.0;
        Thu, 19 Jun 2025 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750373699; x=1750978499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5LUh+vcUEz2dsN4kFQrgT/PUHpvK2pO4wxhl19yUFE=;
        b=Wozd3JfMotqqL63pgPsfa2tMmrqpDLQHO309SNkMKVPQLFpvbYJ/MH4n/MsjdaBH7i
         olraWhKWi8+YubLiMkddvnMWycDTRZ8j7Maxql0YGABtdnBO7SYx4Y5kqiK1BAJi0IUk
         6sDbT6u1dwCHnnsgC179+5BEqViZEmxPxSpjiTLdO/3xejX3yPN0wIj3AMHnF7naQekg
         zYJWgMoEv7g835toSoj0KcDEs5laoWp2/TA4n6FvvF8IrNaAaTW6XID9IVdLKPHZyTRC
         4fsCfRTm9V4PjNVOrg5RZwmP5PWS6nD/fD4FV18glGTSlhJOA7gOoNIJCtPVcumNjdXx
         v5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750373699; x=1750978499;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U5LUh+vcUEz2dsN4kFQrgT/PUHpvK2pO4wxhl19yUFE=;
        b=P7wBI3WwbIapD3habK2J+Gj2uQJuP1RaAdziGus/NuF3H9JcWZ7/IVJ4oIiaXupWN9
         oR9Zw9xShF2I/TlzkYUvUR3ZrOhrK6n9KlQRpvwpnSHULJNNtECKbrfZMPXPPTZqsrMK
         vn8MnNvRLrfTgviwnbXQ7FgBhuURBbqI7LdJp2r88rN+RydlEeKlwDAyOeIP2aQlYc+C
         WUYmPMNmYXNdebrF60QVTqvwWVoKKVM9EEVCHP0XZduhkqvT0r9q9NR4sNEvjd6nHg2r
         bfeVNrsuhvh0yhU+WI4xymAs9XB/ZEddYBkQzKPx9xx4mspV6mpOe1vcMEjj+Nik3/kH
         fHKg==
X-Forwarded-Encrypted: i=1; AJvYcCWUsZe3EflCN+pgYFErf6QmUvWm0DBnDv1qmGC8BG0OzmDhuiV22sAqDSeCXykV9FYfXMv2lZJKJ6j9EQwundk=@vger.kernel.org, AJvYcCXbzjzVQFFKNHuqGeNv4S1HL47bljwOR0gpdghB+755V5VzmmYrF/0GsaBpqy9ya2EIBLz1eaGyzsezAts=@vger.kernel.org, AJvYcCXdDfwJYNNIxxKSQxD7bBIsc7KF3V/dYnZ/HPzax2Hd5ECmXzd9mf6d8ny5qd+AB66QZliuywVt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx4JyJReWgk2/mly1vAtn/iT59y1jd4EzRE7yHf2lY/jPfZTGN
	wGkui+ER6/VsI65hawCQen+vGaKGGhnSlmU/uolnIOuLpWwtRIyXCfqi
X-Gm-Gg: ASbGncu95FzpYpPhFpCQfdR++3X3K6bRbQ+cWukesYaqevERpoYjISEQMBbij7iU4CD
	6/8NbIwsR+3cVq13/thCT9QzJASa8kQalN95lg0XiPP486mzZNkEPlfSSqJ99urOuagHTNJAYf4
	ZDscKxW1zV9UVxcwYrc/znY7yq5MpkQqidCmjFdrKR+MlteaPFNKWvwCz7WcwRqMhplbejTw5q4
	GtgsoH9sGQsbgmD6QdfL460MhSJLvNdFqqZLN0esIghd3bu3mmyJugU4gHJR2VNiB78ErOZYx3g
	wAqZ64DHXTJFsOGaMDTxKHW3+enoFg/ozFGtNsOzMM2S2BqsNOoENm+ZsE7u99rhKOKKKIR5KL4
	uCWzPzTdRbntNLFKMsPacxHXxxIlXgqEaFkvQf593
X-Google-Smtp-Source: AGHT+IGMOxrcLqORxCkCwjmK4ZO6AvSemKqlGQKHeZb8yFFS7F0PURx5NSiGPIe7ehUlW04USd49VQ==
X-Received: by 2002:a05:6a20:3c8e:b0:204:432e:5fa4 with SMTP id adf61e73a8af0-22026eb16ddmr843061637.23.1750373699399;
        Thu, 19 Jun 2025 15:54:59 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a66a763sm642168b3a.141.2025.06.19.15.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 15:54:59 -0700 (PDT)
Date: Fri, 20 Jun 2025 07:54:43 +0900 (JST)
Message-Id: <20250620.075443.1954975894369072064.fujita.tomonori@gmail.com>
To: tamird@gmail.com
Cc: fujita.tomonori@gmail.com, aliceryhl@google.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, dakr@kernel.org, davem@davemloft.net,
 andrew@lunn.ch, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: cast to the proper type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAJ-ks9mazp=gSqDEzUuh0eTvj6pBET-z2zz7XQzmu9at=4V03A@mail.gmail.com>
References: <20250612.094805.256395171864740471.fujita.tomonori@gmail.com>
	<CAJ-ks9nXwBMNcZLK1uJB=qJk8KsOF7q8nYZC6qANboxmT8qFFA@mail.gmail.com>
	<CAJ-ks9mazp=gSqDEzUuh0eTvj6pBET-z2zz7XQzmu9at=4V03A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 11:29:56 -0400
Tamir Duberstein <tamird@gmail.com> wrote:

>> > >> > Fixes: f20fd5449ada ("rust: core abstractions for network PHY drivers")
>> > >>
>> > >> Does this need to be backported? If not, I wouldn't include a Fixes tag.
>> > >
>> > > I'm fine with omitting it. I wanted to leave a breadcrumb to the
>> > > commit that introduced the current code.
>> >
>> > I also don't think this tag is necessary because this is not a bug
>> > fix. And since this tag points to the file's initial commit, I don't
>> > think it's particularly useful.
>>
>> Would you be OK stripping the tag on apply, or would you like me to send v2?
> 
> Hi Tomo, gentle ping here. Does this look reasonable to you, with the
> Fixes tag stripped on apply?

Yeah, if you drop the Fixes tag, it's fine by me.

Thanks,


