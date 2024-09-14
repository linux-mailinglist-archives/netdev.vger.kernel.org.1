Return-Path: <netdev+bounces-128259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BCB978C40
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 02:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC0AB23577
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81CD4C80;
	Sat, 14 Sep 2024 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPlzuzl0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8C34C76
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726274623; cv=none; b=jp/UW38zXGioDT4vrDF9BpaiqDEbww7Q0rUqdQxjqQo7L06kjCIhs3+QeHnQQUzUX4e5YfSK2+lo+AxHwN9pNOHEQmUJAYyQuxlicWkUfiC4dXYGJyTXmWiDR2FHLtNQb42eOf8j0j3RaIZBt+MLpMSnw29HZAGqiXtRa4awxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726274623; c=relaxed/simple;
	bh=TUrY80ehNCka8U/7IMHBt62KZb3yd9vuXPbLAb87cq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQJA+hqQK+S7JvLaF4PybmlLpkzyShAR/GqSuIbSJ9+UuIoclt2ar1Yv6aaI9/TJx3p+874lgcEyY5j+lT4fwEYyWk/lAUi4sRQxBkk7Hk1yiuKyrW8GP8bgIBjXuIGXFwD5m1gnR+Ufr1q8UwFyn09AIM+Ye3xOc3HaWiVFz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPlzuzl0; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39d2a107aebso112275ab.0
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 17:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726274621; x=1726879421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUrY80ehNCka8U/7IMHBt62KZb3yd9vuXPbLAb87cq8=;
        b=nPlzuzl0Nc/X+2IaHPj1dbEl5Yce/9K8Swfnhzig9YV4I9dOASphObM/6QXZRvpTZI
         F4TM4iYbmzDoGrRZstzc0fQFf26pcESRMwct5Wj4YGECDEU7v8TEyljDBekDItSWKw3A
         gt9/l3u2ZDnS8szNqWiuiRhJTgtCUXK074P5GPQQrA7mYSRKZwaUd7mF825aSAaBA/RD
         YvMiLvOy9dtcCtZ4ltFJ7kakn1wl4WCg+beHND1VV4YqPN2oaYnlEXiuReS21xaJLwup
         c8z04yEfKemxmHhgpyo70Fl5C0eTNKthhBFyszTdXKo151Iu7cWpCmSpKbwUdB4G6nlz
         iNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726274621; x=1726879421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUrY80ehNCka8U/7IMHBt62KZb3yd9vuXPbLAb87cq8=;
        b=FrhxlYiFQscjfm9gTcwgG/+BUG8bVleMDJ7+N59Y5g5H+l2VmOUF+7nVEmmhyIe76Y
         YI0jHe73sGza4zfiOr+wuq3qPhjSZGOjyKyJWwK3BUxOYrDRg9WVgriMtmiPOYePKWqT
         Ekl9Lw5KfC4BOlcJx8LWi0Y/oxlttFoehVkHjYZXvbpCtW1v3DUcXKvYRhPBZw5xO6n5
         gxbg9U6NBhZgIXJPa3lz8mEHVMzZCDzyUqbcdUJ736/lT9oALVp2WPjc3Pu+6nk6Ruzl
         n3nKRdUqRyq2lunOjE3URKE/wnK+fN7ueW7vcZA4cAKz4zC+gXTfvsBeZ+8AE43eCdvG
         6iTA==
X-Forwarded-Encrypted: i=1; AJvYcCXKP+M3zbLThCvlf7qHn2sjohbqQqqtOKzRFF8dSlnx/phbG9CAK8Xh5+eImYDT/+jBU0EQWXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk2vgDu9IB6++UKPPmV1c7yDh6VrNKHH6FO5xUPX354ITtS999
	NfTCnRfD/Jw1bgdYoQbr9a0DUiyn6cwX5WmgMJuDimu5KjRTCFdbn/con1hJZO1wAuZvNIp+CE0
	QMCAW06u8jxIU8pz2IHvVZlCMoWOcsbnlhWC8
X-Google-Smtp-Source: AGHT+IHSaLglF5wz9mRniAwttRxI65kTwctZxzJQBTwNtA0gsvJL1chvFzwE6pyoct9NSOfvWET8xaMujC2vxvEZXKc=
X-Received: by 2002:a05:6e02:1c41:b0:39f:3778:c896 with SMTP id
 e9e14a558f8ab-3a0856908e3mr10731525ab.5.1726274621421; Fri, 13 Sep 2024
 17:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913213351.3537411-1-almasrymina@google.com>
 <ZuS0wKBUTSWvD_FZ@casper.infradead.org> <CAHS8izMwQDQ9-JNBpvVeN+yFMzmG+UB-hJWVtz_-ty+NHUdyGA@mail.gmail.com>
 <20240913171729.6bf3de40@kernel.org>
In-Reply-To: <20240913171729.6bf3de40@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Sep 2024 17:43:29 -0700
Message-ID: <CAHS8izO+AgUQwMXQ_17bRvLetcgSUJCXhOeQre2Z49XDd8kdrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] page_pool: fix build on powerpc with GCC 14
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:17=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 13 Sep 2024 15:20:13 -0700 Mina Almasry wrote:
> > I have not reported the issue to GCC yet. From the build break thread
> > it seemed a fix was urgent, so I posted the fix and was planning to
> > report the issue after. If not, no problem, I'll report the issue and
> > repost the fix with a GCC bugzilla link, waiting 24hr before reposts
> > this time.
>
> I should have clarified, the "please post ASAP" applies
> to all devmem build fixes, ignore the cool down period :)
>
> > I just need to go through the steps in https://gcc.gnu.org/bugs/,
> > shouldn't be an issue.
>
> Just post the link here, I'll add it to the commit msg when applying.

Ah, I need a GCC bugzilla account before I can file bugs there. I
don't currently have one and creating an account involves emailing
them and waiting 24hr. I've done that and am waiting for an account.
I'll file the issue as soon as I get access and post the link here.
I'm also poking to see if anyone around already has an account and can
file the issue on my behalf.

--
Thanks,
Mina

