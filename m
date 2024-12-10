Return-Path: <netdev+bounces-150570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7AF9EAAF2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3E31889D54
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8541B230D21;
	Tue, 10 Dec 2024 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BO2Vrb/G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23B2309A7
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820402; cv=none; b=XcoUXaRXhJAESbR0OFyC/+dm3FEjMAFV0VSIW97oW5sYauLaAwgDIiLTzStf0+2sT8Kv+jnNSnaOYf9B9qYUhX/OHMsG1ztVQz7p2pc/XSDobqi16V+4SulkBWvT33y0l61gVFVeNAluX54o6poOJHMz4ifpIaBzI419cMBrMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820402; c=relaxed/simple;
	bh=Eba7fbqt2ZQeeRKH2zJBxl/+3tg7P1GPjMOSP6Xj+h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SepNrJ9hIxr5LRsPB/v5IBwsNW0CRnrFc7jpPc6vW4o017kH2CtsrLmMvA+G5jxMCs0EtdeNMWoHgh2XufPFpVOqJ/BEUe6z9EcALeIEsAwDe4RRc3O8nuDnWljDqAXw4yN6Hqjz1T/Ku40f2OHOKRfZYVJcaq8IHFKv/M2ijRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BO2Vrb/G; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so3917122a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733820399; x=1734425199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qUZ+ytQeipLxCRqR/rU3YK4R6Z+4ZLrxv3Y3omcsV4=;
        b=BO2Vrb/GrS35cj/cXq+9pb1lzx1wh1xnito75+kTE3cSGbYplrCDS20l176mXnlW8D
         CRRcRvSMBgM50rSAF06PO+bzd3ROV12dOfov3FxV9OxvHbGGMOwnfx0me8vsclrzErNe
         EZ2qkMtMGt/JnEcyvus/dWMO2nfG1Fopwin2+KNt69D9hNcJp8DbY7nfmRdVd2EDQJIY
         6vSKiP1ASl+DXrqkdESz+T8Y+5qTHYhWJRmUQ8B7PNde0N7nu2YStfExwNcMM0rEWne8
         PnYCKfKgEuuwdttbHBK8OTMrYEoJm5PVZGS0CFvI+Rkp01O0Z9q/60wpxoNw6Hdt6Vul
         BRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820399; x=1734425199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qUZ+ytQeipLxCRqR/rU3YK4R6Z+4ZLrxv3Y3omcsV4=;
        b=fYtBSLrvjtB7UGIDMQVqAnGHb4PTGH4zid+9x2PPZKNT9znN41zJ8AM6/LRC8nQFn0
         CfW2dUQhcX+FT2Gd044xgJD7AcNMFTWZ4nv/m78vJ7yOAB7sXddxWjyZucgNl87Ql05a
         K6p+DWw6QU+fcXn8E2hmNfywzdQl2snYWVkNNo5uESGgFZ7fCE2o3rAv8gOxRWTgAzKH
         utBAW4m14ukdAO+xyGu0UMUfxixDq2ebzbs104GKf1w1XGeL9VinN01x9B0aCYBWkwoh
         hr7l5IJmGS33ofQfqqOOAAC2peu4j9VhlcRCM73gJ0P9Hf1IkMry2CluxeBsnQNOGEC5
         9aNA==
X-Forwarded-Encrypted: i=1; AJvYcCX7vHswNUiyrLyaeBrPK0Htq3J+ETyp7DpvVqMfF5g6SCb7yLZLXzAE7NInkuKICmogG3ngmJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdC649IYX/KTH3BGGoRLzORmahCa6EvfbSUuAXU+n4pjEwiuR6
	7xbbAEPxcxtaD5N9JTBSNv3HridIVGwFnGOJJrRSrqFzGY8t8AlHrouPX4PCF11+6DJVgGPvz3O
	zomiKHkit/l/gbpgSpEu8F2Dh4WSDO1woBQJRHXri4IYLCaEBajYf
X-Gm-Gg: ASbGnctnDrJ+tqAb9T8Ey5gOaW5D7yS1GiU8nBTmuO2ZhKbpShoXG+qFIBIVR8zsV29
	0d7gBWMJqubNRF7JlTbXV7uuyZSckzK5bBg==
X-Google-Smtp-Source: AGHT+IHKSd7M+cMhyM4R0r1btFzb67y9gtbX3vqaTShlCnIy7i3kCaKghhku6FzXCTycnILsOvhp7umf4cg0YpdcdqI=
X-Received: by 2002:a05:6402:3587:b0:5d3:d917:dd90 with SMTP id
 4fb4d7f45d1cf-5d418502cc8mr4309748a12.6.1733820398800; Tue, 10 Dec 2024
 00:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210073829.62520-1-kuniyu@amazon.com>
In-Reply-To: <20241210073829.62520-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Dec 2024 09:46:27 +0100
Message-ID: <CANn89iKHE=ucDztegP5TPHM=6e0JaGApQ7J==4r1Q9nffm+-sQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 00/15] treewide: socket: Clean up
 sock_create() and friends.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 8:38=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> There are a bunch of weird usages of sock_create() and friends due
> to poor documentation.
>
>   1) some subsystems use __sock_create(), but all of them can be
>      replaced with sock_create_kern()
>
>   2) some subsystems use sock_create(), but most of the sockets are
>      not tied to userspace processes nor exposed via file descriptors
>      but are (most likely unintentionally) exposed to some BPF hooks
>      (infiniband, ISDN, NVMe over TCP, iscsi, Xen PV call, ocfs2, smbd)
>
>   3) some subsystems use sock_create_kern() and convert the sockets
>      to hold netns refcnt (cifs, mptcp, rds, smc, and sunrpc)
>
>   4) the sockets of 2) and 3) are counted in /proc/net/sockstat even
>      though they are untouchable from userspace
>
> The primary goal is to sort out such confusion and provide enough
> documentation for future developers to choose an appropriate API.
>
> Regarding 3), we introduce a new API, sock_create_net(), that holds
> a netns refcnt for kernel socket to remove the socket conversion to
> avoid use-after-free triggered by TCP kernel socket after commit
> 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns
> of kernel sockets.").
>
> Finally, we rename sock_create() and sock_create_kern() to
> sock_create_user() and sock_create_net_noref(), respectively.
> This intentionally breaks out-of-tree drivers to give the owners
> a chance to choose an appropriate API.
>
> Throughout the series, we follow the definition below:
>
>   userspace socket:
>     * created by sock_create_user()
>     * holds the reference count of the network namespace
>     * directly linked to a file descriptor
>       * currently all sockets created by sane sock_create() users
>         are tied to userspace process and exposed via file descriptors
>     * accessed via a file descriptor (and some BPF hooks except
>       for BPF LSM)
>     * counted in the first line of /proc/net/sockstat.
>
>   kernel socket
>     * created by sock_create_net() or sock_create_net_noref()
>       * the former holds the refcnt of netns, but the latter doesn't
>     * not directly exposed to userspace via a file descriptor nor BPF
>       except for BPF LSM
>
> Note that __sock_create(kern=3D1) skips some LSMs (SELinux, AppArmor)
> but not all; BPF LSM can enforce security regardless of the argument.
>
> I didn't CC maintainers for mechanical changes as the CC list explodes.
>
>
> Changes:
>   v2:
>     * Patch 8
>       * Fix build error for PF_IUCV
>     * Patch 12
>       * Collect Acked-by from MPTCP/RDS maintainers
>
>   v1: https://lore.kernel.org/netdev/20241206075504.24153-1-kuniyu@amazon=
.com/
>

My concern with this huge refactoring is the future backports hassle,
before going to the review part...

Also the change about counting or not 'kernel sockets' in
/proc/net/sockstat is orthogonal.

