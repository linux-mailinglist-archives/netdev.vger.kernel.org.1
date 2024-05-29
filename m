Return-Path: <netdev+bounces-99042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC498D3883
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A481C2029D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4530A1BF3B;
	Wed, 29 May 2024 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd+hkrMu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9310E1C290
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991184; cv=none; b=Kzm1Ha0FWqV+aC6bZ/NuchS1PLmamB0WYCYiaAkhX4OhWrK/Uxq9W9yO5JLw1UfHg0o1n8iUfDsvrWfoRrR6lemVX8bhQAJhIPtG5D1mlIMYwy7HU1XBrZzk53efIU75JMEkX0jmc9Lnbf8ZXM8GXOGpSxH2WzdP0HPVDVpwdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991184; c=relaxed/simple;
	bh=E/uv3IBfCXv3xHeD/VmgWefVGMqSj70yynSgtrO25E4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=vB58Oujk5XkG9N5NWQTXx/Cx57XByRyJJuIk9p+tECLHIHDOF8DR8BmZPw41GwZGi0CnYsgClQCQ6Dwer7WWZQ+D/MWXTAwYKgeti5529ZrbIjESCVY1O+DMe4EWlw6kxZAg0DWs+Gh/FC6XCiiRHoYDUyetHPKPzCbrlfmP9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd+hkrMu; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43fdfb3e0acso4771171cf.2
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 06:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716991181; x=1717595981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RR9wnk1nvTh3mVnqoKvCTYqJATUfflqATyi9ja2wHYA=;
        b=Nd+hkrMuYapZLNFKApjyhT52cBJov+VryE7tbhdQ7PsMDSOSygv/L/1+12d24CuVA1
         +TxF1ph7pHd3c8gRI/ULrzhlbdivJa8fa5zvquvsBvBxYUM/DY0luWngPV/X7F/Ey9kZ
         Y7eHYBHm2VLl7qPt8zSvjGCoXBsEWG3jDF03BdWtRcPiDDT35wlcs+sNiUAFB80aqJxU
         i2GwMv3ttZbO9nN7U9bUF6D7mYUjc8fyQKI+ABLvNt6a7oev8rnBo+hd2ys66tqg8Og5
         gxKk1a3CfnN+y7sYQkPddFOiH9n7LUeq47x6Mp4j2WVoWnHgS/UrzZWFXcHSgh0+jRBP
         kTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991181; x=1717595981;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RR9wnk1nvTh3mVnqoKvCTYqJATUfflqATyi9ja2wHYA=;
        b=YZ+1/vatAxegMZ/6c6dB1T3GmTLY2nPb2FrarA8pVZIVjsbGwNr7gZYdJ/Jb5AjtLH
         pvPhYQvhbR2f7T45knzXu4amEvjp0oHovid9t6HCN1oYyB1JFyrUktEABdcJ+0nhRhuY
         I8eNaB2DnxRyLB2qYcGbY0Y3KRxStH2OKknFJrj1pr7aJgAixuPEWbhGwVU5V/okOV/L
         uPlBSNGqtDpibJ2Ll/u7cuKoO83j0rqOgRhpIuSSkdywgRMrX1EgUkjNy44NRndxK0F3
         aKtidBStX0a6hdn8SulqAQQycp0ROuQKn1IdLovRl0UWu58IEKKZ/MF3yuivfdMyWEB2
         /VYg==
X-Forwarded-Encrypted: i=1; AJvYcCWPHCRrEi4WzwqXWyzMGrVtsuYWCKg0x2s4n2FBvEL5JzjAmirS1AT+PgxWD6U4maBcYtF7LrWJI6xe4XkRjXP52mZmd6yG
X-Gm-Message-State: AOJu0YzaKq7EfLiUdy63TqsotnuULKphlFx/NUJt2Ck91WU/2P6ezIXk
	c5qo8srILB13/ZY968Y4UBn8eExfe5VKgBK2R1QERccUwnGyR5fB7GJsDw==
X-Google-Smtp-Source: AGHT+IGyYITVSdRht9y9XQyh/9MU5jRCkxuAjH1qwkPnRcKElDkS/PM/h5Ee5j2RemeEaP0SeD28Iw==
X-Received: by 2002:a05:622a:10e:b0:43a:dd5b:d306 with SMTP id d75a77b69052e-43fb0f0a811mr191524471cf.55.1716991181487;
        Wed, 29 May 2024 06:59:41 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fe63357cbsm2810441cf.25.2024.05.29.06.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 06:59:41 -0700 (PDT)
Date: Wed, 29 May 2024 09:59:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <665734cce5a6d_31b26729414@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240528212103.350767-1-zijianzhang@bytedance.com>
References: <20240528212103.350767-1-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v4 0/3] net: A lightweight zero-copy notification
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> Original title is "net: socket sendmsg MSG_ZEROCOPY_UARG". 
> 
> Original notification mechanism needs poll + recvmmsg which is not
> easy for applcations to accommodate. And, it also incurs unignorable
> overhead including extra system calls and usage of socket optmem.
> 
> While making maximum reuse of the existing MSG_ZEROCOPY related code,
> this patch set introduces a new zerocopy socket notification mechanism.
> Users of sendmsg pass a control message as a placeholder for the incoming
> notifications. Upon returning, kernel embeds notifications directly into
> user arguments passed in. By doing so, we can significantly reduce the
> complexity and overhead for managing notifications. In an ideal pattern,
> the user will keep calling sendmsg with SCM_ZC_NOTIFICATION msg_control,
> and the notification will be delivered as soon as possible.
> 
> Users need to pass in a user space address pointing to an array of struct
> zc_info_elem, and the cmsg_len should be the memory size of the array
> instead of the size of the pointer itself.
> 
> As Willem commented,
> 
> > The main design issue with this series is this indirection, rather
> > than passing the array of notifications as cmsg.
> 
> > This trick circumvents having to deal with compat issues and having to
> > figure out copy_to_user in ____sys_sendmsg (as msg_control is an
> > in-kernel copy).
> 
> > This is quite hacky, from an API design PoV.
> 
> > As is passing a pointer, but expecting msg_controllen to hold the
> > length not of the pointer, but of the pointed to user buffer.
> 
> > I had also hoped for more significant savings. Especially with the
> > higher syscall overhead due to meltdown and spectre mitigations vs
> > when MSG_ZEROCOPY was introduced and I last tried this optimization.

Thanks for quoting this.

This revision does not address either of these concerns, right?

> 
> Changelog:
>   v1 -> v2:
>     - Reuse errormsg queue in the new notification mechanism,
>       users can actually use these two mechanisms in hybrid way
>       if they want to do so.
>     - Update case SCM_ZC_NOTIFICATION in __sock_cmsg_send
>       1. Regardless of 32-bit, 64-bit program, we will always handle
>       u64 type user address.
>       2. The size of data to copy_to_user is precisely calculated
>       in case of kernel stack leak.
>     - fix (kbuild-bot)
>       1. Add SCM_ZC_NOTIFICATION to arch-specific header files.
>       2. header file types.h in include/uapi/linux/socket.h
> 
>   v2 -> v3:
>     - 1. Users can now pass in the address of the zc_info_elem directly
>       with appropriate cmsg_len instead of the ugly user interface. Plus,
>       the handler is now compatible with MSG_CMSG_COMPAT and 32-bit
>       pointer.
>     - 2. Suggested by Willem, another strategy of getting zc info is
>       briefly taking the lock of sk_error_queue and move to a private
>       list, like net_rx_action. I thought sk_error_queue is protected by
>       sock_lock, so that it's impossible for the handling of zc info and
>       users recvmsg from the sk_error_queue at the same time.
>       However, sk_error_queue is protected by its own lock. I am afraid
>       that during the time it is handling the private list, users may
>       fail to get other error messages in the queue via recvmsg. Thus,
>       I don't implement the splice logic in this version. Any comments?
> 
>   v3 -> v4:
>     - 1. Change SOCK_ZC_INFO_MAX to 64 to avoid large stack frame size.
>     - 2. Fix minor typos.
>     - 3. Change cfg_zerocopy from int to enum in msg_zerocopy.c
> 
> * Performance
> 
> I extend the selftests/msg_zerocopy.c to accommodate the new mechanism,
> test result is as follows,
> 
> cfg_notification_limit = 1, in this case the original method approximately
> aligns with the semantics of new one. In this case, the new flag has
> around 13% cpu savings in TCP and 18% cpu savings in UDP.
> 
> +---------------------+---------+---------+---------+---------+
> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
> +---------------------+---------+---------+---------+---------+
> | ZCopy (MB)          | 5147    | 4885    | 7489    | 7854    |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy (MB)      | 5859    | 5505    | 9053    | 9236    |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy / ZCopy   | 113.83% | 112.69% | 120.88% | 117.59% |
> +---------------------+---------+---------+---------+---------+
> 
> 
> cfg_notification_limit = 32, the new mechanism performs 8% better in TCP.
> For UDP, no obvious performance gain is observed and sometimes may lead
> to degradation. Thus, if users don't need to retrieve the notification
> ASAP in UDP, the original mechanism is preferred.
> 
> +---------------------+---------+---------+---------+---------+
> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
> +---------------------+---------+---------+---------+---------+
> | ZCopy (MB)          | 6272    | 6138    | 12138   | 10055   |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy (MB)      | 6774    | 6620    | 11504   | 10355   |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy / ZCopy   | 108.00% | 107.85% | 94.78%  | 102.98% |
> +---------------------+---------+---------+---------+---------+
> 
> Zijian Zhang (3):
>   selftests: fix OOM problem in msg_zerocopy selftest
>   sock: add MSG_ZEROCOPY notification mechanism based on msg_control
>   selftests: add MSG_ZEROCOPY msg_control notification test
> 
>  arch/alpha/include/uapi/asm/socket.h        |   2 +
>  arch/mips/include/uapi/asm/socket.h         |   2 +
>  arch/parisc/include/uapi/asm/socket.h       |   2 +
>  arch/sparc/include/uapi/asm/socket.h        |   2 +
>  include/uapi/asm-generic/socket.h           |   2 +
>  include/uapi/linux/socket.h                 |  10 ++
>  net/core/sock.c                             |  68 ++++++++++++
>  tools/testing/selftests/net/msg_zerocopy.c  | 114 ++++++++++++++++++--
>  tools/testing/selftests/net/msg_zerocopy.sh |   1 +
>  9 files changed, 196 insertions(+), 7 deletions(-)
> 
> -- 
> 2.20.1
> 



