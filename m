Return-Path: <netdev+bounces-211047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7179B16484
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 18:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B97F166987
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36B61ACED7;
	Wed, 30 Jul 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KeRRsbGa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A168DF71
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892468; cv=none; b=u1oH2ZBqQ4ufYcDrxHEhz5WcOB4rDUohsHx1R4vfxtabpZZSaXCDR1HNTGQ4AmPnlb7cIEUUuddr4GbKWe9zEzGYStyR2fquf+xxlgAQ/ePpHFSfdYEpzIEdopsITG1uDHKAjIZelOVv2L12SHPfcCiKBWZEpHr3UQOuvbDf0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892468; c=relaxed/simple;
	bh=43uGzvt4ob7grTZb2tT0nh21mLKwphtCkU+Kw8genDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQTAQtlPixjBmPvo6YgG7Rm7Ga4TRGN83P9fehcGFIq88WiQmPy7SJIWDxQUbCNI9KJuI3VV9PYznd/R3uZntNrP/hjEeCGu4DtNE4qBXnqkl2qXfvF4RNSw1MMhIsgSoxfjAs3ty3kWbEnJ2FZLC6rfk4sRNaCAZbbNugpPmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KeRRsbGa; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61543f03958so4665724a12.0
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753892465; x=1754497265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NH/3GagQyynALf0TJNfWRtPo9NIRhr2hMw8M+oi+jAw=;
        b=KeRRsbGaSPUbsRcEcMLlmW0Hw41oCYe0wQCMDfyzQSgRdzsfj9GEoaaMV9FvMWq3u8
         SjJVnvr8R0A/uyH60KqXukTSlxc6Rxxi25DnnFvJt4yno3p46wyYWIsp/6Gb2/qu3TjI
         okzZmhJBJumKNoY0fB601c9RK1ATaET6+pnjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753892465; x=1754497265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NH/3GagQyynALf0TJNfWRtPo9NIRhr2hMw8M+oi+jAw=;
        b=JYjn2KEHCtIQBFQkLY386BRUv9o8snJKOaP9q5UHB0w889SA5UxeKFegQ3EaYQdJHz
         0WEKEUJ70xUcyLSpQepM+q3NVdTg+4EpJpqCbeUG+3yXXOk8UnKn8p7JLpHVr16vSo96
         aGlzzFTV1Bgz/ELIHwTXkgCruGv5F2NlcUEtC9HV0hoALDdWRs/ui3bZlXKA7hS3GEfz
         wlR6b/5NEsH4TvQ0L1WQOefZ6s5tV+gKio3PYOzSP3QGhsbTX+HA9q/PAKEWpvqXkXnb
         HYccBISwydEQEA7fkHn1cdegsAjwtywSjoG7t6fShTb5cwEqC/2RsyHMjDPKbRU3jpM/
         Iucw==
X-Forwarded-Encrypted: i=1; AJvYcCXBqbibCpw2cMZ0GO9K1p3n9Z14NB2xvd7mM9XjD5YHC6J0q29B2mYt2hGiuPg/Fgr63mBGpr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKWNpqGeZ/qlCj/P63DMGTaXyYmeN4u7HrX+xul5hpPSQ8S85y
	4ttYTA4CtItnXGN4I1rcbVPC53vN+D8lNw5Wk4jDP2uKAWQrzmXDKNNMd1h+8k00sY8/Sr5kfb+
	AKwoW2So=
X-Gm-Gg: ASbGncufioZG/DPHBhtX+Rc+l4FMkS39FviFULg6yse3fwe4SeFbXLiNBbcIuNNTCq6
	rax2gpeQqWSoj/g2tC064oKSn9m+tDjwfLqiDbc2FN3JgozAF1k3tZXK/dLo690bK/aORZaNQg0
	k1oZzj1cFYKFIf9IBmzWIQY+3GzC+z/JIM4POu0kA/e4UJ/tS5uEd5s6F3h8yp9QPt7bT+WSQYE
	PBcY8l0RM7avpW3B9i6lkoiWipadPbcvPLOFhTMc87Xnz5EVY94RArZHg5NNu/+a1ey8EZFVlBw
	G+Cn9gUnn/HK3ekpazatdrHfi2bLDJBoM/hu8oBczeFK0qz8A8qBygjnRJ/ZBFMSzXph60n8OpS
	Khu1zYaW/itPj2Uk53XemmvitT2sv0fYN8cVus4yVNh9EyNrzBUnjH66f+p6TV6aiHCw7WOwI
X-Google-Smtp-Source: AGHT+IF8U2pWotsnOSB/jQFzQxVWbrk2oWDVii0U0n3OhpMwn5QovKZc3m94vs4cjEf21s3vX543EQ==
X-Received: by 2002:a05:6402:51c8:b0:607:77ed:19da with SMTP id 4fb4d7f45d1cf-61586edd68emr3851458a12.1.1753892464807;
        Wed, 30 Jul 2025 09:21:04 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61556326ee7sm3170904a12.55.2025.07.30.09.21.03
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 09:21:03 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so4461350a12.2
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 09:21:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFCf6AUysuas8W13eEVGL6n7oOHxEiw6NxBZ9NbgiMhJq5zS9H52nIOCRVJcmDRknCTPwj/BM=@vger.kernel.org
X-Received: by 2002:a05:6402:1d4e:b0:615:a3f9:7be2 with SMTP id
 4fb4d7f45d1cf-615a3f996c5mr542955a12.19.1753892462648; Wed, 30 Jul 2025
 09:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727013451.2436467-1-kuba@kernel.org>
In-Reply-To: <20250727013451.2436467-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 09:20:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnXTvh2b0WcNFyjj7t9SKvbPtF8YueBg=_H5a7j_2yuA@mail.gmail.com>
X-Gm-Features: Ac12FXybTQ2GnQWYUYI6uVtMHGtsdyuV7m6LIaAejVL-Hc0-6S3c4N-n3CkDkzI
Message-ID: <CAHk-=whnXTvh2b0WcNFyjj7t9SKvbPtF8YueBg=_H5a7j_2yuA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.17
To: Jakub Kicinski <kuba@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Jul 2025 at 18:35, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Networking changes for 6.17.

So while merging this, there was a trivial conflict with commit
9b0240b3ccc3 ("netns: use stable inode number for initial mount ns")
from the vfs side (acked by networking people).

And the conflict wasn't hard to resolve, but while looking at it, I
got very unhappy with that conflicting commit from the vfs tree.

Christian - when the "use stable inode number" code triggers, it
bypasses ns_alloc_inum() entirely. Fine - except that function *also*
does that

        WRITE_ONCE(ns->stashed, NULL);

so now ns->stashed isn't initialized any more.

Now, that shouldn't matter here because this only triggers for
'init_net' that is a global data structure and thus initialized to all
zeroes anyway, but it makes me very unhappy about that pattern that
ends up being about allocating the pid, but also almost incidentally
initializing that 'stashed' entry.

I ended up re-organizing the net_ns_net_init() code a bit (because it
now does that debugfs setup on success, so the old "return 0" didn't
work), and I think the merge is fine, but I think this "don't call
ns_alloc_inum()" pattern is wrong.

IOW, I don't think this is a bug, but I think it's not great.

               Linus

