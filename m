Return-Path: <netdev+bounces-255450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEd0LMchfmnnVwIAu9opvQ
	(envelope-from <netdev+bounces-255450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 16:37:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73990C2B5B
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 16:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08709300B3D5
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA3305E3B;
	Sat, 31 Jan 2026 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKLL/PF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474212D23B6
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769873860; cv=none; b=qkKy003ihL9VENXlKPeAYIjitlms8vgx+XRMXoywY8qrxjM7wZ5VmYU35wXc1MZ4E2riF2ueQmqjpDUuPctmaCpakJA1u/J2AgztP3rj6p0SuTRs5yI5R3TsvrDiFyW8KYlK5+Yc6yxOrdJjnHUpKGAkMvu8Jf3PNdjIyoh2bMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769873860; c=relaxed/simple;
	bh=lFbN1ibUBCn+rfsJwuXg8x9jgyMUTQsXiXRrAR+KlJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfCameq7PkTRrViEQDd4tkBs4vWO6XF2mCumyN4ABFLGrTg8BB5FqCf2W3x1Vdizvl9MGAfAg3Fj6Oh3am0c/2OSXZaA/4abU/LlLApCt88NLh5s8WfvMhY9qsrRO+KCWkO5G5dhXF8g6f8twMZjIekFA1tbDGQg6dLoKFb62+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKLL/PF3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d28870ddso1845611f8f.3
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 07:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769873858; x=1770478658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiS78dJ3E+O9/koHhs6/YjJ5zOTAaZI2BPhavS+ZM4w=;
        b=LKLL/PF37LNsasvQeiStabOoc4MTAqg5cxw12Z16BGRdPsZ3k8BNy1lZii6+vmer0P
         i3A9u6wqNIqmHtP6GWciy6QnpDt/n7wiQ897b71obCRHaxQPBsrLj8g++OenDLgSl0JU
         4QnwMbgPAL8JknhbNTmjiu4oRqiK90lNogDknzHfnYY6GhnCYt32gNSHkGwOsinGgwM2
         S/1uMXzRvVBhywF43Zp7BOcGsRplneaOZ5iyeUTwEzhmX/YAvlzLLiSabuBukDXL7VNg
         ydZrH+up0+QphBayWrBIY9WKsYoZDGSznlURirDIEVGX4yPGI90m4GWN2mv/fy5T2rSw
         3K9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769873858; x=1770478658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fiS78dJ3E+O9/koHhs6/YjJ5zOTAaZI2BPhavS+ZM4w=;
        b=orxX7K90qi4iLL68LHjUCvCsHrzm50J4ZV/7p7G3tvCwPR0phC9dBsYPf4aAu/GRIX
         Dz3ki7ZKdnTl2xZ70IcqEubtJfvGYr9/SHvVn+zDaTyPXTqQGrOIxV0w4CQt6iqsiCU0
         k0qheMYa4WFBOm4fxMm+l1NCkwBGWXQ0sKu82G3KP7ya4Ob/0s6UEP0YGehsjwFUKzNw
         8S3xYvQiH0xRSmggBEmrVf79MVQjO+VFLLZ93gXiagG3j5RpOB+G/r+5uff6Qlx6c//6
         K9Tf8vodl2yqcMYcdPXmVesKqHQwj9hUOXA3FI3kzpmJ+mbbqOS5lo9UmrDv8q2GDj8Q
         GaLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGeYOAcYE8c/ZpM91D8PCYQBfeTpsxmjCfv4ItD/EWa7ULNCe5quPHm+ShSR8XJgLqyPyuRAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6rjORN3e89OhB6xUx49ruvcnGZcK+mAHz7hieKZqhwCCyxoN3
	aF/PtZ7JtzCIzE4VAYnG+rNDGoGUih2LE4ycHWrT+iFJwGCtAEd/4Pq9
X-Gm-Gg: AZuq6aJNJOWEjdLXnDQa5U50O6QhR4bclZ5NOuovCgpaFl3PPglCCPcUpyTXcqQTFY4
	hGgjaDNT+zJ8Th9e1LkczD7oFr8+Qn0CWIY5GX5ofg6CD1kkZg+qNv3O4r+C0aD5Vk0SgCLXpF0
	YOUxZ+ev3YJ+eE8hXDWbNUyn1ztQeni3Arvam16K9txY4OzJiQ3XZtdHXptYaNiB86RT78X9fS5
	pf8Cd88zR6bQ9RnBDyMTi36fozo7KU1OtHYpd8BtiIDCfHzu0kQx3tgIYgQgv+kSsur35I9ZZyY
	qweeFnfrH91mkTHZ7RwM1lL3Crpr/DLMrXgyQDW1/0e51xPv3CIINmIN4G7fv4qVvN2Wl+POwDN
	MUIfqFMwBlMxo9yIGPBT/aqVX4dmHH37/UCiiCWXz+IzKPt3YEnV9LZM1muLCLnCIpMwRyAi1tC
	3My8UUJmZA0dZdlM6uGr6+gRv5243/wNxu/20TvLtRJpadMcQO1s1oOH9D1kmgEto=
X-Received: by 2002:a05:6000:4285:b0:430:f3ab:56a1 with SMTP id ffacd0b85a97d-435f3abaa14mr9728576f8f.42.1769873857412;
        Sat, 31 Jan 2026 07:37:37 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e48a6sm29620829f8f.8.2026.01.31.07.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 07:37:37 -0800 (PST)
Date: Sat, 31 Jan 2026 15:37:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, metze@samba.org, axboe@kernel.dk, Stanislav Fomichev
 <sdf@fomichev.me>, io-uring@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next RFC 0/3] net: move .getsockopt away from __user
 buffers
Message-ID: <20260131153735.3c9273a8@pumpkin>
In-Reply-To: <CAHk-=wiiPxGrVxFzzf1nbx7_0abjZkhmd9oPximUxUyDM7gwug@mail.gmail.com>
References: <20260130-getsockopt-v1-0-9154fcff6f95@debian.org>
	<20260130205227.6fb1d9ad@pumpkin>
	<CAHk-=wiiPxGrVxFzzf1nbx7_0abjZkhmd9oPximUxUyDM7gwug@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255450-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73990C2B5B
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 17:19:55 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 30 Jan 2026 at 14:40, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > There is not much point making the 'optval' parameter more than
> > a structure of a user and kernel address - one of which will be NULL.  
> 
> That's exactly what we do *NOT* want. Because people will get it
> wrong, and then we're back to the bad old days where trivial bugs
> result in security issues.

It can still be a (semi-)transparent structure that code isn't allowed to change.
That is no different from using iov_iter.

> Can you point to an actual case where setsockopt / getsockopt would be
> performance-critical? Typically you do it once or twice.

IIRC a really horrid one - I think for async io.
That is also one of the few where the supplied length is a lie.

	David

> 
>               Linus
> 


