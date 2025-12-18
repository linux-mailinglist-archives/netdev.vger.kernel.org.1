Return-Path: <netdev+bounces-245450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0F3CCDBE6
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 22:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E42F3010CE1
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 21:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C861E7C34;
	Thu, 18 Dec 2025 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDSEvCwo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440113D539
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766095196; cv=none; b=F6Nory7i0wrfX+ViGLaursHHEUetTME/aY4/FLcypbfqiZBZXiQQcS/WJkfHGpgFbZApEsR0kIXlkpgL/zeH8rsDX2Nv2VwDDYV+kzAvujcR5aEc8KhqJ/vhLWa4/6tz2KlHGst4hbNs5T3SkagBmm5YLKifXiG920ESNv9OTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766095196; c=relaxed/simple;
	bh=XKkT2tZz7eWrLkWjuPs0kYDLhUmTVv+sxfAAI2qI3aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgEX3AHGZXLYCrf1u+zQ6LIJfh1wGQuowjFp2hL6BmySIYgRrhEA3KI3KibABPgihmO0WBo9JcKs0DX6cxjkvgU/9SZQOgQcr/Ratuan8NA5DkdF2rXnEe3GqCW6BWWodPU52kEXZKCOz3lR6Lh0dNphn7eILU9cLHXuhA8nbO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDSEvCwo; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38107fadda2so8873791fa.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766095193; x=1766699993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/sjp0jU275es5lIyrSH+clAsUhfyndmb5HbMmt8PNE=;
        b=CDSEvCwo/RmhvQBSD8MBhkABZQrRU5MH1ISYQPvmoA/6IpisOCDm+l9tjrnSs9Bygf
         JWIfSpTu7APfUU4qyOihTtWOyrnLuETicJLfYaddKRXCg9UW9tdkFg2Ta164NC/e5yHb
         0bdVVXVzfJU8knNwmAur+CVYHfdJY6A9aL8OIpqmCH0Pk5WhBxFx2h1OzWhEJPOIlnIE
         iWLFp7M7ff/pnuKGJWom/nPusu9uH+2JB+meiQ1EGy2sDCdVSpO29ITYvRY7U+FFAO+7
         KFmAjgk52hXzliC7zwO9WNdehg+xlpDJVv7oKBtvIYoC3yFWpBwSZ0Y3RUg8ZKIpj5HE
         Zp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766095193; x=1766699993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t/sjp0jU275es5lIyrSH+clAsUhfyndmb5HbMmt8PNE=;
        b=TIa542+p7700I2doFwGzO4KZbcqsq+e/3wWrI6qlM04QsUjrDRslVEBjkz2z8fAJ0Y
         mHHSQP9jc6+ebqsHe6KNm8OXIxeJKV616/yd2PgxdjJx8spcdRffQvcMrMZ+nMfAzjea
         Xi3oB/NKXVIymtc61pNzOi4iAkEnSumZCbHfB0661CWrgcQDlkItAAX2hYUseho34a6A
         oq/rVi6lDJ0OnjZO65XibQpIVEvVeRYt9bWIGBhIgvnp0r2k9c6QsvKHN3vZqvZHMVul
         XJbg7UD9J1g8ghQG0m/CQPnvVR7x4635IeLNnYCWg0WHIzWPszKaGhu4LWflnq7i5XAv
         7+4A==
X-Forwarded-Encrypted: i=1; AJvYcCXeOlzlUA264aRpc33FUvgFfMhrgpQbk+OiGs7hVa73MET8nP6xzGsuZVtfwfgTbxM2DhEnPRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb79iCld/B930ZJ0wlOAVE4EpNZqUg+UJjd0/p+qOVwYKcbUF6
	PJvtQS008BCDcRkfyjZ4vlY8GhVQ/WcuiHh+d8f13j/K/JxJsDFiOXnh5NJBQw==
X-Gm-Gg: AY/fxX6XSV96DeBXpnYTfuPcNphbATkResCWgX/vrcud+HoTXrWnoyYkdZ6f5Z04GAQ
	5e6gMhHpUmPC6eM1gCfrh7DiaDLOYYnC8ETPXFwnY759dEfmkeaWTy2AsikYuCCJe6y5sw9HTLA
	n2Wzu91cphHP+0jSzALNavhl5zUpMQAyKYaHaK6gUnjwZ0Tg+uNvzbUL4FqjnM6czg72dfBJEeP
	y9pd7OE4dTIkkM3PLn1LTjJ9HAlXjS7mMU0i4T3gX1FGKZTkYljRrYgoEvr6Wfx7tbTQrJRmtv6
	bbZdGwcVxHkrjYhEta9d5vnPlGSfs1tKpHIqi3Y8jUJHWH/D+hLffQKYRFW9UA9VDFC2XRLGMk6
	Qt/sNn8uk16Sk+uAA+aWEr2bsf12wmZKTE/Vm5wt6ihNJtdu+TIbv4855vzAMGzqZ8kjuHHW5Bp
	cSnfpUTAPixXStO0ZKJ03kB6UgIQZTUrBcOY1WhtXUr0ayw8hQU2QV
X-Google-Smtp-Source: AGHT+IHQbU+iOqzaiFiPp8MK9D9JLLWz5I3nysW2I9Q92SyiIPFWBxMnrn97EMLGECK7bx8NAmxYpg==
X-Received: by 2002:a05:600c:4fc6:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-47d1953b768mr4547825e9.6.1766088919259;
        Thu, 18 Dec 2025 12:15:19 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27c2260sm56813515e9.15.2025.12.18.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 12:15:18 -0800 (PST)
Date: Thu, 18 Dec 2025 20:15:17 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 44/44] net/mptcp: Change some dubious min_t(int, ...) to
 min()
Message-ID: <20251218201517.2f2d91d4@pumpkin>
In-Reply-To: <cd5d45f7-0d76-4f82-849e-2f2c1544d907@kernel.org>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-45-david.laight.linux@gmail.com>
	<cd5d45f7-0d76-4f82-849e-2f2c1544d907@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 18:33:26 +0100
Matthieu Baerts <matttbe@kernel.org> wrote:

> Hi David,
> 
> On 19/11/2025 23:41, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > There are two:
> > 	min_t(int, xxx, mptcp_wnd_end(msk) - msk->snd_nxt);
> > Both mptcp_wnd_end(msk) and msk->snd_nxt are u64, their difference
> > (aka the window size) might be limited to 32 bits - but that isn't
> > knowable from this code.
> > So checks being added to min_t() detect the potential discard of
> > significant bits.
> > 
> > Provided the 'avail_size' and return of mptcp_check_allowed_size()
> > are changed to an unsigned type (size_t matches the type the caller
> > uses) both min_t() can be changed to min().  
> 
> Thank you for the patch!
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> I'm not sure what the status on your side: I don't know if you still
> plan to send a specific series for all the modifications in the net, but
> just in case, I just applied your patch in the MPTCP tree. I removed the
> "net/" prefix from the subject. I will send this patch with others for
> including in the net-next tree later on if you didn't do that in between.

I'll go through them again at some point.
I'll check against 'next' (but probably not net-next).
I actually need to look at the ones that seemed like real bugs when I
did an allmodconfig build - that got to over 200 patches to get 'clean'.

It would be nice to get rid of a lot of the min_t(), but I might try
to attack the dubious ones rather than the ones that appear to make
no difference.

I might propose some extra checks in minmax.h that would break W=1 builds.
Detecting things like min_t(u8, u32_value, 0xff) where the cast makes the
comparison always succeed.
In reality any calls with casts to u8 and u16 are 'dubious'.

That and changing checkpatch.pl to not suggest min_t() at all, and
to reject the more dubious uses.
After all with:
	min(x, (int)y)
it is clear to the reader that 'y' is being possibly truncated and converted
to a signed value, but with:
	min_t(int, x, y)
you don't know which value needed the cast (and the line isn't even shorter).
But what I've found all to often is actually:
	a = min_t(typeof(a), x, y);
and the similar:
	x = min_t(typeof(x), x, y);
where the type of the result is used and high bits get discarded.

I've just been trying to build with #define clamp_val clamp.
That requires a few minor changes and I'm pretty sure shows up
a real bug.

	David

> 
> Cheers,
> Matt


