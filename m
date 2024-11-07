Return-Path: <netdev+bounces-142614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071609BFC75
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383FF1C21D51
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D75D26D;
	Thu,  7 Nov 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeRIfEfp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB92913;
	Thu,  7 Nov 2024 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945807; cv=none; b=tZG+62XaUjtpHfa5Qb41KUk+SNHsm4lfkl1/1F52vK2QhznqY1J2IwDqsHSeTLHJOxkDjwjIFo6Yj8RpwD53H5X2xHlhr7Vb6S+FsvoOMb48yAJaZ6zGzaUxyOPFgtdUuoBqM3ZOkyJ4GGcFHDHQRo1HCzXtKDL0dSUTbhLxSQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945807; c=relaxed/simple;
	bh=cihjkB+1TZxs8KK1U5TbpGY7J9YMgghKRPY8uGqz4u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUcdvJkk1izIBZ1EYfHbX1f8c+asB/9Yn0p4/8OaLENoJmVgH1m7flfKJTMN5ziPvBQIw6+0vE+KnYWAiBri4UNQgCaa22ZMmgCQr9kYqZ/BFbAo4QtxlBYBbWnEiT4CK3EjxIcJgaRT4bp6G7ZuL/Ae37hTQe2jXIjYGw46wsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeRIfEfp; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5eb67d926c4so265461eaf.0;
        Wed, 06 Nov 2024 18:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945805; x=1731550605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8CbRY+z6QebCFramzuCKSbhitY3898drP2Xlt2s5rZw=;
        b=jeRIfEfpLcy1tQD9b5dYDXliZwm57xoTt/0DQi9TbwIfXIQcOK9b6oAulhvB/UvAYv
         t5L8IrnyzsM98qL1F/IHwpOaNB7Tphd2UA+diiaHEfzyXT+0dfiIct8o2qm46/T1HqLa
         Kcp8SC34/oYS6wMX9cz5QgTBfga462AJQEo5j+teRnrd0CYv8fFYunWLz2AEFVvZAES4
         OnrnEv7YKqR9Hx3Kbz66wrut7mqE0s7P0Fs1J5Gy8EbASv8tllIPD/6ZiEvPvygkWcKH
         L2g7yxKgfmJleIFfGvBiW6iAZsrmmT1shB4Ohrwxx3seZksveZf0E7GbRfH1UdcVYjgn
         Xr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945805; x=1731550605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CbRY+z6QebCFramzuCKSbhitY3898drP2Xlt2s5rZw=;
        b=QhRllomahLFgAabTCZLUF0SruICSlgENdDY4oNPgHgvQFF9LagYKyqh5xqq25LX5i+
         Xe0SI7wT54+o3fJUk7JiqfYwo7Em+M0hPQe6jC9HEowQxYk73tsd+7EjKGWcQ4pQ39DZ
         eOMGvP3GNipEtSn7Kl0pm7zQy2yAhwD4cz0XUJoQdX/LjsYZ2e2gsIGJKexDpKvC2ZVv
         ZCPAMccGzOiTWykzV4bk/75Su0qI4w+eTl7LLOnVQFEorcbD4RsNhEJHPsAd+RpfhaZj
         YDu8H/ZYQ3akMQDeRJh5PAautwPSE832CFAQZiTtlg+AMalPCzxWrBJ7t3Sb72tgYBrB
         xcCw==
X-Forwarded-Encrypted: i=1; AJvYcCWtFa8vuCwaXjMqSiRt6WvyBP5TQAwUFY27WRUQFPh+sGHgdPTJIOCqx6LPq68kPVmjbJ01CJxqwyo=@vger.kernel.org, AJvYcCXMEGCPsWvn4OBYGafjCBPn0Z9nSMQ31Rjcl4v74fZy5+IhhS5IxwrLm03PeI2BKs9MN9kIHBqNArHs8jyD@vger.kernel.org
X-Gm-Message-State: AOJu0YwUbqxBcqNWHnvas6dygy1SOKA61zem0FF19fvBPAr4g+m51uAK
	tO8Bf7vlkBuSoYmFC8dh36YVkTviMOHXSaBsiNkUYav2GYqIL/H1mjADwlvEFuBtOSXuBRpzYrN
	wQGhenhCZKGDqOlc9Ao76/FbdW10=
X-Google-Smtp-Source: AGHT+IFsqsIMp6co3mQX71iJrw6CeitxnpS8rRyZKb4hj+lILrTg96zJrcG2OU0XjnaBFr0eEexbH34PWVL570piauY=
X-Received: by 2002:a4a:a546:0:b0:5eb:d48d:f172 with SMTP id
 006d021491bc7-5ee4693ab55mr920438eaf.3.1730945805221; Wed, 06 Nov 2024
 18:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106002625.1857904-1-sanman.p211993@gmail.com> <683c8ffd-6766-4ad3-8049-0defaff7295f@lunn.ch>
In-Reply-To: <683c8ffd-6766-4ad3-8049-0defaff7295f@lunn.ch>
From: Sanman Pradhan <sanman.p211993@gmail.com>
Date: Wed, 6 Nov 2024 18:16:09 -0800
Message-ID: <CAG4C-Om7ad+gnaFxJN0p-1YF=B-98z71Naw2ss5-Qmz85kSMpw@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org, 
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com, 
	sanmanpradhan@meta.com, andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev, 
	jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Nov 2024 at 09:32, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +struct fbnic_hw_stat {
> > +     struct fbnic_stat_counter frames;
> > +     struct fbnic_stat_counter bytes;
> > +};
>
> I don't think this belongs in this patch, since the PCIe counters
> don't seem to have anything to do with frames or bytes.
>
>         Andrew

Removed the unnecessary block in v2.

Thanks for reviewing the patch, Andrew

