Return-Path: <netdev+bounces-211406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F258B188CD
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 23:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD1FAA1F5E
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 21:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F7E28EA67;
	Fri,  1 Aug 2025 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZJk/CQkN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC723B63F
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084078; cv=none; b=BO6TSYP2incIYKGUnybK/nO9PY5RIJuyGmY67xLguFQ57j50V2vWSctEyJHnj2Znc8tL/drWtsyIMIufqf0Mf6+oTGddqhC8yZ3OJ6ibLbuZWX2KVlpyUeiIG/Urb1cY4Nmz5vYpMTL6trCZaIlR9zmOWzCT5wGHCXj4h9ZVmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084078; c=relaxed/simple;
	bh=IZkwXQkh8YxYF6KhegHig00grekwiuruDFNARhibles=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1Nq8AJvu1iqTLTT5YtD7B55+pG5Rjg6Bzt2JY6awfgkvmRIwtFdOlKhZpMg6PPRNB4kz5zLIoSDL0MZQI/zhhjNV6cbbvakHGMPYa66VJLQa392KP3dnAbENpXAFFzFlqRdpPdZbI5rraMkzVkqB0JtaspIakMF0yP1W/xmqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZJk/CQkN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso1733266a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 14:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754084074; x=1754688874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WLFHL6fOZFPNrc7teT5UWCBGBPE4FkQnF2Ru0J7QGa4=;
        b=ZJk/CQkNn759zW48a2JZ+wnGAeFYF/65D4MSSLPZwRDZrb4H2z29VBipHbl/UpS9qM
         zM/NJ2LyQta0RPM94ipgCU7SJ6pKOHzTcl10VrKjt9Tua628qDUKWg7ZiVjYmaEZeSD6
         +MdGPgCmO1YSZCIMlC9v6WH/bJ3tyyR2voquc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754084074; x=1754688874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLFHL6fOZFPNrc7teT5UWCBGBPE4FkQnF2Ru0J7QGa4=;
        b=jhb9/nl24UGWSel/LmiNB/iVnEPSXWz3EHcyLKsH+bWrpfWq84U9IAI6dhNyOQwNhH
         Ai9WbisdrrWO2pZNzMn+4iuM/ljmc4MVuqfRkfx1/xjRDCMgf7ji8C6bymndPgTn4tEK
         RVsUG2tzu4Wx539gZofCqeh5Zg9gQBXkzBvLyOMDVNGSfC2nXH98t4CCcOcBwOOB86g0
         CH8+zPagPiM/EJqcS36yZkv+fqVBQTsiqqoA1cTwrceJ8ZrjpkDIdMpFMsUOqzhcApkR
         M+Iw+nCVFmhOH0LIh/8AFQJuCIF2Sh0d9GPdXDr3C2VpcdaJkFvuI+Ut1uNsaE0vBr80
         fTQA==
X-Forwarded-Encrypted: i=1; AJvYcCUFAkSFhZp8lLLyre8XcXu//B6wwq86jBQHqMZdvVG+sY9ECXHtvI45frIfKguN3q3rWJK733E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgw+YxUsBU5ZqxuNuTgAc4yQYbMrm8bK+FdEBHEbJw1gZCWo3R
	tcodryq8Yk2pcqgM5C2rOeQ9nKmGizVxum48DVzr4NqVEZSiy+jae8SWRftFU1l5Ox+LgHL+Q/1
	4v9lTJ1A=
X-Gm-Gg: ASbGncuKxCZPlpnt3vKPmK9N0aawkQHQ2mtVzakJgCR25s7lG/3+wrKSzpLN/JjxyO5
	sdqj9J7rYVoxPvkDSSJ0Bb3SgbQd7yWyfdryg4VXCqTSmHbsqq6krK+X0Z3DaUu+0FkbtXuucOl
	rfF0WRFqlLAwbJdTq/dqBiqVpIOPjhlGUZTlmYCvM2N45jQyanlF4+5Ej1bHf90FCoURMDLYX97
	eDLV0gPYI7CChs0eJ8aXecWgKlsbiRXvyDi6kXOHI0KupF3wGPbM38QPtn6f70e077XIiEGYsj/
	EYNgqrKNIUtGBz1akiXboQxD/T7EWxv3LP3pbxJKrjblrA+QUDQ5TnJAn279WVDpIWVkoMdkZJi
	CUJlqph9NwDzfS2Smkyev9CdZ6I3Ow0gvA2QzzM/Zk+ic6zaaVvL+hjpMCZLztYMgELbb8ckSld
	F40dYiDOVWyhnNsN+Ckg==
X-Google-Smtp-Source: AGHT+IHnvKAc6/CPi94LikkKvHzS8UPvhMvCT8LGFlWJR/IBuSQwLheEC2/NCOvojlABkeUCqGtG4g==
X-Received: by 2002:a05:6402:234f:b0:615:7a67:5e6 with SMTP id 4fb4d7f45d1cf-615e6ef19ebmr683132a12.13.1754084074106;
        Fri, 01 Aug 2025 14:34:34 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8eff8d3sm3296508a12.6.2025.08.01.14.34.32
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:34:32 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so3640163a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 14:34:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYtqZj22OeUv9qf3Tj86BJpjQ6tZ1stbw+2RPR7Y44kkDFjMH/vg5lYEcX8cOuXXLDZqluJsk=@vger.kernel.org
X-Received: by 2002:a05:6402:2790:b0:615:cc03:e6a2 with SMTP id
 4fb4d7f45d1cf-615e6ebec77mr689309a12.1.1754084072420; Fri, 01 Aug 2025
 14:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801091318-mutt-send-email-mst@kernel.org>
 <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
 <aI0rDljG8XYyiSvv@gallifrey> <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
In-Reply-To: <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 14:34:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRtKY+tk0mhnHzrC0YMXef0GtVUFQ6cGW0-4XS30mQ5A@mail.gmail.com>
X-Gm-Features: Ac12FXyaANs0webz-gagQ0r78-lvtho7QphOSO_s_LZu61Rm94DR5P3bHuE7Emw
Message-ID: <CAHk-=wgRtKY+tk0mhnHzrC0YMXef0GtVUFQ6cGW0-4XS30mQ5A@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com, 
	anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com, 
	eric.auger@redhat.com, jasowang@redhat.com, jonah.palmer@oracle.com, 
	kraxel@redhat.com, leiyang@redhat.com, lulu@redhat.com, 
	michael.christie@oracle.com, parav@nvidia.com, si-wei.liu@oracle.com, 
	stable@vger.kernel.org, viresh.kumar@linaro.org, wangyuli@uniontech.com, 
	will@kernel.org, wquan@redhat.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 14:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> My apologies - they are indeed there, and I was simply looking at stale state.
>
> So while it's recently rebased, the commits have been in linux-next
> and I was just wrong.

Pulled and pushed out. Sorry again for blaming Michael for my own incompetence.

            Linus

