Return-Path: <netdev+bounces-147779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8739DBC18
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 19:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE5F163CDD
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C171B3933;
	Thu, 28 Nov 2024 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YA+S6PaX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5A13BC35
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732817900; cv=none; b=jKIEC5BPQPVGV6dZZkTgt5W843bw/6Ewr1sQnG5SYso1yobw82we/OwO88CljvDavl8ZwEVkMp/Nd/I5wflpyAnot8sIjkyJIioxZL+II+icNRjuUsZ1mymG/4wpAIILuUjMk3+o7T3oZVvvt6ICiEUvFD8jvVnjaaZo02Bzv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732817900; c=relaxed/simple;
	bh=PvLQicWhQLqcii2/+LeRW0W4katNa2QM/tAe64jJLA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLC4yNDG3JeE15xIM3qe0UizX+m1mfBStIWUiqkgOqqnFgP9yYkXnk2zvY5lngL1YnqH+mj44OvtsEMhgesgc4ECbR8cgo65mSgCaCR0/bly6TSU/I7ZyFaJQ8sdg6Fnb0OFmgbLbTxYDt4lU+qvZOc/Tyu5NaYSRIMH/OwXGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YA+S6PaX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfa9979cd1so1193663a12.1
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 10:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732817897; x=1733422697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OWYPygSA8U0sevMCRXoVQRbK8c6ufmDSCTRB6zqB+ts=;
        b=YA+S6PaXu2LLtCo57voAhgHGOLaHu7NAKEFRIoncpfw9WO3VsAw23ZhsW6Crb0nrUO
         OLagAW9sL3M/klSwBSEpMnwOnvct3tFHNWBqGjC0wY4a205jpQ+hi8x5v5QB3iBd23aX
         HriyuAZpnEco6dLqMUq5nWg9qOq88+PPRbtec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732817897; x=1733422697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWYPygSA8U0sevMCRXoVQRbK8c6ufmDSCTRB6zqB+ts=;
        b=ncSfoZq6V3bGzt5wlPVxQpuvKa06AkY0NIo/J++cGdPOPpZxmzQtei0qCZiy284Vkc
         PTIyZ+YC3tgmgxzZzo2TacnK/I8YHzD5kTL3kH6EgynJ/DR1G2lwPrL6b6jH1zmzX8EX
         F5L4Dp9gd7vBDtXXDx5YG14WyXXEMjtk3BaC05MwKCWRjY04OPDwbBVYAiMy8R0lPEec
         dTgjjGvgT6C/Sx6Fnfah6YeZWBs20SbJ4JSQCjIMhqAtGQWt4IjOEoxQ9AH7g8UAGlld
         JL8Zg/s0fhZ1wEMSL12kPoJUJpCd0t/tAT8gr/Dg8Z8B7JhkCAX8FGgWfoaMmf8E5y4+
         d56A==
X-Forwarded-Encrypted: i=1; AJvYcCXQT5oCXBLg53GG+CSEoi+tCMxa4pFsD2vyzqv5SXP/I2cstGkF0h5AqSv8mX4RT4MeTYdAEEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyigV/FCXHnxlc//CzvyghoG8DwiZMFdSlpLC/YgDNBeWgfBEr6
	WAUr3aTnM3PdoXlfm/6olcgpsosY36eVGrB7CMMaCUMccRESiZrV3R/UxBHo+EcvfGqoYho8JA7
	YPFF+tg==
X-Gm-Gg: ASbGncsiieRi6s27ZVrg6+a1qfzmF5MoPB7RqPzcp989H6xa0sCtnxBNhS/IBycLoNX
	dAZUXH5roWO+DIUXITlNdJAV7YEoij9qYMCFb6sQA9SqOJfK0bluKVLuNu8cF3UnLE7kmR7aGe+
	ZQOQPmuv8h/z//Bi8bwmTZX3nFRJXfnx38hIqUszEH0aACgwQKXrhU8iE3mclH7w8Xg23Qw0fTI
	4Bz68Nag2dzpFqJwGLmhTaG2CT6IziEJOVUgdE+w6dRgRGw24yGwwylraIIN+Lk+M8mD8fmtu2f
	8uPacksRe4Q4T9FCWrvs+Ipr
X-Google-Smtp-Source: AGHT+IGj6AN4k1p5j74l6vEHs5lwG5WwvOpGNVQBQdGD1dqwJVNifUXtXzCbZsmEKs62u8Lre3e8SQ==
X-Received: by 2002:aa7:cd56:0:b0:5d0:79eb:867d with SMTP id 4fb4d7f45d1cf-5d095154958mr3848872a12.15.1732817897152;
        Thu, 28 Nov 2024 10:18:17 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097d9f5basm950448a12.1.2024.11.28.10.18.15
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 10:18:16 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa52edbcb63so377608066b.1
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 10:18:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWktpOOHEwBodTn6QZpNviPgOMcdZL0IhgxuOk/Ib6KWoQX9JT3b4y7jiDyLCk8ZoRVyD83Mw=@vger.kernel.org
X-Received: by 2002:a17:907:7615:b0:aa5:358c:73af with SMTP id
 a640c23a62f3a-aa5945075fdmr511317466b.6.1732817895101; Thu, 28 Nov 2024
 10:18:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128172801.157135-1-pabeni@redhat.com>
In-Reply-To: <20241128172801.157135-1-pabeni@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Nov 2024 10:17:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whuZtQD15GO6ZoU3X-V8Wq5tPm01NhpojspaMTefM5fsQ@mail.gmail.com>
Message-ID: <CAHk-=whuZtQD15GO6ZoU3X-V8Wq5tPm01NhpojspaMTefM5fsQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.13-rc1 - attempt II
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 09:28, Paolo Abeni <pabeni@redhat.com> wrote:
>
> The only difference WRT the first attempt is the fixup for the build
> issue reported by Sasha. I'm very sorry for the additional noise.

No problem, this got fixed really quickly and is much better than
finding the noise later. So I'd call this a success, nothing to be
sorry about,

              Linus

