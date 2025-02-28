Return-Path: <netdev+bounces-170731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1459EA49C13
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A923118956AC
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AA626E946;
	Fri, 28 Feb 2025 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ur/oAu7Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038D26D5DB
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753172; cv=none; b=ia8+E/fZdsPI6F6XHu2HaDuiq1sWD6TmbjXv+tnbNQL+xLarQQRtOGds2Z145bQtpFUnYLeBmu4o8jMIMKbuFk3EaQsEA8agMghRnynZR4vBnMjb6InXesltusn8bsbhUd9JjU3f8RMKiBk8o5/p0zIZa4FKyxXiWDC8GOSopqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753172; c=relaxed/simple;
	bh=CkGIJQuiqe49itaAI2kGn76UNrSRVXquqJYxAstk/Pc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WPYFIvv223odLer+fV21VK7+fruxhm9LsUX+osiPfBnN8nqILZhEoXs/F3yQl8CyF9/EeIkxVag/VBMmc0UTgDCKUkhD8iR7RgFijsCI/REDml+zu2EhTbSYSY6I+nVS8EKfjY1rXu+nMsJN5U8uf6IYXXfFuygvt0i3rezLaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ur/oAu7Q; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fea8e4a655so6354029a91.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 06:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740753169; x=1741357969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7JGZceXrqb3JDH8Ghpfp/+cyR/E9//d9mR4kGrL6APs=;
        b=ur/oAu7QRC4Be+4mdE6EqiSJahr+hxc1yTy/FB8CA0VAUvaMu5PoEl1TrBK81r3Tdw
         W9RaTGXN/27ux35OjnhVv9sTlh+bL0hWrNyigjhsJU8eDGFga4rPA6ksFL43f8j160Bb
         pVDXK2gIpCEKemK2WZsaASZKnvuPoKGjwYMFtsuZcHPEGH7BiXIB9cy6gMBF6muiwiLw
         VUO0klylDXNjFkTSFK2A6l1h/hLD5qUDMqb/3mWLH0n1x8Hx9rwWM/7F3FoUoIlUdw+T
         LNzFGeJSdFIfPRYdZOnBVeb9DtfIbxR0lyDLb0/2dCwetCb0vb9SNDlIV+/3hIlfQfe2
         78Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740753169; x=1741357969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JGZceXrqb3JDH8Ghpfp/+cyR/E9//d9mR4kGrL6APs=;
        b=w1rn+waDYosqahx1VDJQNTuw28kzDd8vKxxeFZPFxeTGMLhdmf20Q2bAhbSg0LpNlF
         jzGpEV5ghVGVKAdGk0gKTuVkVI/dQWnHALYRXN153vBm4KitVoApNshX2B1BM22EHyo0
         oZs/1UW7GHosakmBu2PbmdUwRByMotFcX5UwQf73T+S8UOu1UDZzRuIXrbg/Jm1nOMpr
         i852O29b0o1f+zZ0V5L+H+AuQK7QoT0g3WW3cRswbznX5RAzE6BOYgjUZDe2PezK+G5y
         epoti5hMJ6e8bLCgcQSfj7AbyptjNwG4RuJF8rMFn7gQMM+3ueBnN3NDFozCKFlZBr66
         KMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMsUV21gP8faXDHyPvYcKuKWpU/FXo+EUbDOciTUr03/vne91KgW2ouvznCuid2zaJtqWiqtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeE3VZyXfyfDPi4Dz4sifEMI1luT+b8fafHR62XGP6rnWM6Qr5
	suBqz4K7oiupdyfT35lQ+vb6g7bx2nutcHB2tF8v24pg2gRyEYNBjAaK5F/ePs88DcN1stYTSTD
	J1w==
X-Google-Smtp-Source: AGHT+IH1DxS6eOUmZ9xvim3EQOmiQTWoEVkgytjLr2ne7i9BwMNqJZxk8yPz2qlW8r5e1PwFWv8SejB/SnU=
X-Received: from pjbqc9.prod.google.com ([2002:a17:90b:2889:b0:2fa:15aa:4d2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4acb:b0:2ee:45fd:34f2
 with SMTP id 98e67ed59e1d1-2febab2eca7mr5752926a91.6.1740753168923; Fri, 28
 Feb 2025 06:32:48 -0800 (PST)
Date: Fri, 28 Feb 2025 06:32:47 -0800
In-Reply-To: <Z8HE-Ou-_9dTlGqf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227230631.303431-1-kbusch@meta.com> <CAPpAL=zmMXRLDSqe6cPSHoe51=R5GdY0vLJHHuXLarcFqsUHMQ@mail.gmail.com>
 <Z8HE-Ou-_9dTlGqf@google.com>
Message-ID: <Z8HJD3m6YyCPrFMR@google.com>
Subject: Re: [PATCHv3 0/2]
From: Sean Christopherson <seanjc@google.com>
To: Lei Yang <leiyang@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, x86@kernel.org, netdev@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 28, 2025, Sean Christopherson wrote:
> On Fri, Feb 28, 2025, Lei Yang wrote:
> > Hi Keith
> > 
> > V3 introduced a new bug, the following error messages from qemu output
> > after applying this patch to boot up a guest.
> 
> Doh, my bug.  Not yet tested, but this should fix things.  Assuming it does, I'll
> post a v3 so I can add my SoB.
         v4

Confirmed that it worked, but deleting the pre-mutex check for ONCE_COMPLETED.
Will post v4 later today.

> diff --git a/include/linux/call_once.h b/include/linux/call_once.h
> index ddcfd91493ea..b053f4701c94 100644
> --- a/include/linux/call_once.h
> +++ b/include/linux/call_once.h
> @@ -35,10 +35,12 @@ static inline int call_once(struct once *once, int (*cb)(struct once *))
>                 return 0;
>  
>          guard(mutex)(&once->lock);
> -        WARN_ON(atomic_read(&once->state) == ONCE_RUNNING);
> -        if (atomic_read(&once->state) != ONCE_NOT_STARTED)
> +        if (WARN_ON(atomic_read(&once->state) == ONCE_RUNNING))
>                  return -EINVAL;
>  
> +        if (atomic_read(&once->state) == ONCE_COMPLETED)
> +                return 0;
> +
>          atomic_set(&once->state, ONCE_RUNNING);
>         r = cb(once);
>         if (r)

