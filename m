Return-Path: <netdev+bounces-236441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB171C3C4AE
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC5FE4F8EDD
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B19340DA6;
	Thu,  6 Nov 2025 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLQ91vS/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDD304BB9
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445355; cv=none; b=V+r04SrdoQ2XydDBqgMYBtYX28w8mcSzxKOVQB7eVs5AftjY3JG1G28kb4BjOWrWYmQh8nsgulhiGpUgzxPupXw2VxRW61n4eZ0KUB1gT7wkZDO6wRsy5wtppBNhWPWAY7W+PjSEm25oNOEp05fo26vPiK6+0EpSwHWsR135NU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445355; c=relaxed/simple;
	bh=MLg3hiFxO0FS9fuavJ/JSEbJ+y7jTxCzr2x6pNOCnlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsppUjelHCfyqPzJgL/z31q9R6LLEkObn0BPbIBWgBmT4dqUXibAh2P/H77MCO7k95zSeOqz5VVADZhdWg9AvlpiLvgnq/vYRV+OLnmz/bZKASBTt7N3spp08QSFfPVXOYupNDkYOcaycjquMfgiWlodOZl9bgUrK+lRJs0sHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLQ91vS/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640c48b3b90so1378311a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 08:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762445352; x=1763050152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G/WVmVHenIdK3KCEFMeF1CP0bfdkN9fPLWoBNVC7n1U=;
        b=ZLQ91vS/bfZom87cO0VH4z4+nLi/6M8Gm72aETRZONIbkQTPtPBK4H7c/LTYfvdbVv
         qCv+2hiCKAvHQzg8fDvaGjhH7uyICIY+xvaNF9hksHBzNaloHjxdqSOAVX13JZjkDSiR
         flvZAVEja5fGsu/PxE5N1kNKez8/aEYhXjGvlzRMMwQip5cnSgowtoag3PVSJY+YGP13
         +DPhbAjWTY940eo8J/ex8XGCACueuk+3h9Q94fx5m+7oR6ZwXeg2sJAv6FSTXwgVGg93
         XAWhfwOuHtyLNHahfF9THms6ouDceqDnehVv1k3pedkBgVSgXMsoSzgYdNHJ6W+IKTEq
         8Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445352; x=1763050152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/WVmVHenIdK3KCEFMeF1CP0bfdkN9fPLWoBNVC7n1U=;
        b=qtYSZvnWDX44szks6Be2i1hSADPFFXD2yfMCEVWKxU8C5a+0coBSzKqHYuDVVZLFkX
         ck6LQHs8rKuyXyYoGPgDedRhzcGcLQGyXtdiIxhFVhaNQE1gfaA9QgSPM57PNSeMVBkd
         1lqYxLBhi5nISDlxHzCjiQyoN3FMObcyp2oYJhq36idIIiDLzXydUk65SySTy7MLT844
         yANlWPKxLJ0aVme7rchSlu1G24z2jrHDFVoEJIip575te1QcfSNZEwx83bdEoEl/6NPw
         6odjZDdPxppJtVXuxJPNVGVe4uF/eDgOCIHTC6oxZ2HckS92sFipvF96shxts2hxeUfx
         TrUg==
X-Forwarded-Encrypted: i=1; AJvYcCWm0xpvAT1wL9oAKx3D53aLskTQzyFd+iQCgRknHutGpJBffkIMaARiM1foOkd1EXNGajgdVo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaS374f1Zo3OlIhXpMaVEw2qjakW5g3vzu3zUMMCphW+mk75UU
	0wwjvrztbR5xppEVFoFu2o4PA78cU105RM1J6/OyEAwNfEettO+6WzvHVE6B4po9vFY5papen5Z
	0VTDEG1QmZ2jfHsj6nGDuPhTnNTRMvNE=
X-Gm-Gg: ASbGnctAU2EooeZ5oKXfYwn1cveZO6vTAK3oOSB5SzsbAXJpVd7mnD4vIpcs1+tm6T+
	5UkgITQKB+OQUaNHaoWY3J1uHZ2J02wVrC7sA66WImeRZibWOIGxmK6tVw9i3Ehs5+ENIdPR1qq
	m+w6S4AWdJ8VE8u1aKFdoQgm7DAYE3bOSM9mFpyOOampgUjaV/enNw88MEfKN7iSmg2m7ha2KTY
	g4Qfkm7SPpEHjCIB14Wscm+81mv8IlUCupdw30vX4m3o0/aUyZ2oBiaM2q/itWXUhrasGsh18+F
	FAcMeNEDqknlSa95rWcFkK7i6ZUqADGaDxuaZNMkycC5J9hQosMcdxsEyH/4W9+YGw==
X-Google-Smtp-Source: AGHT+IEhSIJc5Z5I5NnrKkJBGLV9NZNcAoGr82x4X4tSXvlTQWMJrPj0B4VjrofC5qDWeUguEUAvAwWik8JyOF9e8g4=
X-Received: by 2002:a05:6402:280a:b0:63b:d7f0:d93a with SMTP id
 4fb4d7f45d1cf-6410588e1a2mr8115751a12.3.1762445351811; Thu, 06 Nov 2025
 08:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
 <20251028174222.1739954-2-viswanathiyyappan@gmail.com> <20251030192018.28dcd830@kernel.org>
 <CAPrAcgPD0ZPNPOivpX=69qC88-AAeW+Jy=oy-6+PP8jDxzNabA@mail.gmail.com> <20251104164625.5a18db43@kernel.org>
In-Reply-To: <20251104164625.5a18db43@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Thu, 6 Nov 2025 21:38:59 +0530
X-Gm-Features: AWmQ_bl5uAbPtelIBkdQOTDm-ZMeds5DYrYna8z74wPG5EKsLuiEbCWlKgzolEU
Message-ID: <CAPrAcgMXw5e6mi1tU=c7UaQdcKZhhC8j-y9woQk0bk8SeV4+8A@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH net-next v3 1/2] net: Add ndo_write_rx_config and
 helper structs and functions:
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, jacob.e.keller@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com, khalid@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 06:16, Jakub Kicinski <kuba@kernel.org> wrote:
> I wouldn't use atomic flags. IIRC ndo_set_rx_mode is called under
> netif_addr_lock_bh(), so we can reuse that lock, have update_config()
> assume ownership of the pending config and update it directly.
> And read_config() (which IIUC runs from a wq) can take that lock
> briefly, and swap which config is pending.

How does this look?

It's possible for the actual work of set_rx_mode to be in a work item
so we need to validate that dev->addr_list_lock is held in update_config()

// These variables will be part of dev->netif_rx_config_ctx in the final code
bool pending_cfg_ready = false;
struct netif_rx_config *ready, *pending;

void update_config()
{
    WARN_ONCE(!spin_is_locked(&dev->addr_list_lock),
    "netif_update_rx_config() called without netif_addr_lock_bh()\n");

    int rc = netif_prepare_rx_config(&pending);
    if (rc)
        return;

    pending_cfg_ready = true;
}

void read_config()
{
    // We could introduce a new lock for this but
    // reusing the addr lock works well enough
    netif_addr_lock_bh();

    // There's no point continuing if the pending config
    // is not ready
    if(!pending_cfg_ready) {
       netif_addr_unlock_bh();
       return;
    }

    swap(ready, pending);
    pending_cfg_ready = false;

    netif_addr_unlock_bh();

    do_io(ready);
}

On the topic of virtio_net:

set_rx_mode in virtio_net schedules and does the actual work in a work
item, so would
the correct justification here be moving I/O out of the rtnl lock?

If this looks good, I will start working on v4

