Return-Path: <netdev+bounces-225928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CFBB996BD
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 12:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B0A3A9A88
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B392DE70D;
	Wed, 24 Sep 2025 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb1tmWjY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7722DC772
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709522; cv=none; b=swFeD+Fg3j3vaem8B6AAOtQz5ErNmZsnW0qmPwnmBB+Ep+VovqBwMYqJL9As1KlL8MB/Hw8nXyHlhK4sQBS1Fm9o2RK7HiLNvc/soDqeDwVffNuH+3nokRhrp7bw9xa60WV9LojoPWTON1CVVzgVe82XTb/gLd2vvB+vUWNyZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709522; c=relaxed/simple;
	bh=gQ8E927A4tX2ZNYrTzlCctAB5m47ibJs+IG1u3p+hbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EltvDJI4DT73lqnadyMHPyP697+1/kavhpYJpq0Syq2qA/m1bj+eL4Bca+wJNyHcIYhhwQ2KSZTRSBENWRthnnA4qsJY9+5rl4LeqG7D7jtktO41C+VO2pGKe8V607bnxNlCRdrgQq1xl34b7xPimZVs/ACoBBKsqdISSty1GuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb1tmWjY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78ead12so1001875266b.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 03:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709519; x=1759314319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ8E927A4tX2ZNYrTzlCctAB5m47ibJs+IG1u3p+hbo=;
        b=kb1tmWjYAxZHv1lEtKs53N0IKcqh5YZzGspNXeX//gkxLfgZyusc8wk+0qFHOItw38
         S86jENoqHKOS81W2wGHd6TTkCGehE+p4vf94nilorxKiWUMJt4eZ7/RR5/jfJ+JFvjTa
         n0795byLhWLF0n3lEGyBUbde3qRLhEou8OsZ8l+i0GvYZD7pi5/i2ustfabxeIDY1fPQ
         lf+XOX1z2eYQw8cvm7PgUk8ctP2KVi0dvFgGgBV5eVqrBTz3uoYR63xOvRLusRlRJfdl
         /S7AQ1TIGnVdpywQdcDjeQXGOynu6kX3oP/DQx2FWMTF07vdCANYW5B+o8lfhLpIUpY+
         EGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709519; x=1759314319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQ8E927A4tX2ZNYrTzlCctAB5m47ibJs+IG1u3p+hbo=;
        b=qeDzcXUXqdmtF6zaZtw+Rk1w8QGVnDA9bzmMFYdzYjJhvA1dbIXu+K64zDrY2G/dEW
         UYAZa6y0DbBlXY7B2YvescKr3FJChgJDWfghQD6SwD9mQyoR+f0/mapBJryXe6ZQiAft
         7HSCaylE17VTcWFbiKy3W7f2lBEU+bLOJO+6I8Nzf5p3S37uyk14z1L6eC3DhLJ2Jr5B
         5jr4n3JnCgQK50Mvm3YfEA9uHi1bjkIUfjM5j3+3fGCOJzy+rx+xqhEaCES9ZPs0f/CZ
         xPR0jOQNQHEznFqktG7qr6FFjADwRaLkeu0qagMnQAPXjlLzI0N5Mwst+64TJfkEV94m
         tSFA==
X-Forwarded-Encrypted: i=1; AJvYcCX3AVZk/vqbBeBMPfZ8XGEHTb4EA0+e4SUJiYriD2PyEAhN+SBloIxwID8kUFMx3F9wIiH3fQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKb2MCj2updCch1SAJUqrarVxiakYv6evI1Tx4gXD3Ds+tQ99q
	dBPrsCLk1Qt53T9oPRKXtQObromZPwhvLfleqxjSeYkH1nDnQ/PS9nKM9JRa8yW7+6/TLRx2vdW
	1zQhhjYmDgsCVjgYJcBtL325ucit0AOE=
X-Gm-Gg: ASbGnctcOeaxmoJObnq9sCL7xcNTNzzByKVmHNubxHdWVItHP1P63Db1RZoThZ7TD7P
	35xNPXahHGlOabC8X6FvRwrZAmi6hMPWhA8gZ0RpUmMTbw8S+d/gePI3v0DcThfaHLaiFi8U0Cz
	28Ybtr5uxMBUzZvM+kVg0TaLn0xP2d7Ts/+qXWQjbQmdw+8yXE4r87VrxY59zgcGnVxrsROnjfW
	IPlID28HCjGEXdONnCOFpYX6okst1uZEZgCcf0Ql0YcWD+CV0JRrA==
X-Google-Smtp-Source: AGHT+IE12lCZ7Wl/ftwQJZ/gaWQP8iDkebbGgJsyR1xTOQTAeL+WLTgk8+fgJ+TjcKwHn6/rpkz17KvFRLGM6maxk9E=
X-Received: by 2002:a17:907:3f95:b0:b07:b782:51cc with SMTP id
 a640c23a62f3a-b302cebc948mr516277766b.64.1758709519082; Wed, 24 Sep 2025
 03:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch> <20250920181852.18164-1-viswanathiyyappan@gmail.com>
 <20250924094741.65e12028.michal.pecio@gmail.com> <CAPrAcgMrowvfGeOqdWAo4uCZBdUztFY-WEmpwLyp-QthgYYx7A@mail.gmail.com>
 <20250924113653.5dad5e50.michal.pecio@gmail.com>
In-Reply-To: <20250924113653.5dad5e50.michal.pecio@gmail.com>
From: viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 24 Sep 2025 15:55:07 +0530
X-Gm-Features: AS18NWAdKXxMmFRzk01TMU60U3Xy0PNKUuld4uhrZt1ayU1Hp7kGVqqNqefl328
Message-ID: <CAPrAcgMhphs1U88_POpxAeAp0KzNCH6-xuvNiSBa5dn7ceSU4w@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
To: Michal Pecio <michal.pecio@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net, 
	david.hunter.linux@gmail.com, edumazet@google.com, kuba@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	petkan@nucleusys.com, skhan@linuxfoundation.org, 
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 15:06, Michal Pecio <michal.pecio@gmail.com> wrote:
>
> I think yes, usually in USB-speak "completion" is when the URB is
> finished for any reason, including error or unlink/cancellation.
> "Free" could suggest usb_free_urb().
>
> But I see your point. Maybe "finish execution" is less ambiguous?
>

I will use completion if it's the standard terminology

> I think it's an irrelevant detail which CPU executed which function.
> It could all happen sequentially on a single core and it's still the
> same bug.
>
> In fact, I just reproduced it with all CPUs offlined except one.

My bad, I see it now. I keep forgetting the actual urb execution
is asynchronous

Thanks
Viswanath

