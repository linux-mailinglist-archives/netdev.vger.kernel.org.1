Return-Path: <netdev+bounces-250102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E49D24090
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08432301E1A8
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E292335087;
	Thu, 15 Jan 2026 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMpOPtq7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+CHu08Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EB235E553
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768474790; cv=none; b=ps4WryhHlkLo4J68QajNbwpTrjlie6BhJxEt9JXzYq8lh5auH5FU9WhkEuk7oZVxGHaLeT4bHDcBVseeyKtTLFnqZkz415NYhYu7KKlX3PSS1N48eEjwAiey9z/oIkUn8KNy7/emaB9z9pLUR82cUI26bn8SiWz2Q/thLLeTtXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768474790; c=relaxed/simple;
	bh=CAKbJAD4oIm+N7JrjIcvupaT10s1lWECUUscp7JIm1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmCGP0KClI8eXLdv5vZs08Ethae89377fMIByROsiN86hjTyZUI3knKepGHDravOVi3YpW85Nv+6EX80JQhDaoIclv9ID8iGFgW+PpeYV4sdb0QzORLd/M7e76JIfJHe0IbujiKgD0OUI18rqkDC6NDqbkY/IGivaMiwQr8OMtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMpOPtq7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+CHu08Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768474786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H2uhWiOU9sr/3RaYIJxLhBZXX5ft69qZ13Y2qAxVi3Q=;
	b=RMpOPtq7UVKYjYtMhU9qvoBB6z11nsR93DZmXN9JN6idVMHXv2WIKRPM1rS4paW10alQu0
	4a8Thg135xx/Bd2P0nRW1IUiq46kIsFfJ2X7s3PTl4ijWBdLG5Y2gd+YmCRIk+I/glrPvj
	GprZ8uYC1t4fS9EZIMAEC3kX5DY1vXM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-Z-Ep2y_TOVi32Vw0bJIfdQ-1; Thu, 15 Jan 2026 05:59:44 -0500
X-MC-Unique: Z-Ep2y_TOVi32Vw0bJIfdQ-1
X-Mimecast-MFC-AGG-ID: Z-Ep2y_TOVi32Vw0bJIfdQ_1768474783
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fd96b440so482064f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 02:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768474783; x=1769079583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H2uhWiOU9sr/3RaYIJxLhBZXX5ft69qZ13Y2qAxVi3Q=;
        b=N+CHu08QUFPWccPdZkMrprq4SKIrzrc0MDxABpyhbGcWYvQlJkxKFYyLmfhGBYrGUh
         KkS94q4XDbVryKO8qEcWvx+IRQYkle48hESIRs3Lrfw4WB6H89qdI2HUiSK58TWt0HfW
         fFJvOKmT+7kVWx+cjoWfcvjJXfBRL5AfeM/94YTqMgoMqHC60klWpGOVHdztDw1JvIZT
         X4SrbzfPO8luZX3GXNEMaToPhh0aorx4ozHaKXQ2ZwKIlXwiB98s0B/1mM3u5su9NLlv
         KLvkm6iyyCBmdfU8xRFtXEe7R8x+FCk0fH780dzRA5GEtEEAQ76VGLpJo6pUntVqBXSE
         hYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768474783; x=1769079583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2uhWiOU9sr/3RaYIJxLhBZXX5ft69qZ13Y2qAxVi3Q=;
        b=jJFrV3k3s3qawyzMnHBLLOEv6ZLjALIt03k/EteU2TXSUY/OEj9DdllLENOcp/S5rE
         aFnnMzhIIhKTbnV0/3TbXyviPNzxtazkaVmB0q356bO3GzZP/8g7PKNH1btJwqdhUWs1
         4SzcDyHdtxQVFUZC2P4cJpmsrZGrrGYufss1+gPNxmYURdxmcjaBTliBLiydhmVxysNn
         xhVM5TrbTgPXp/+zLlzdNvdsVYiuYxo7DMITsKC7u2DLnTD0oKq4m87rO0HIJGxvnsm1
         tUjEHiqpSLzW6FHW1zCxeYWeRTXyUy0uZARMagzr2tIXiQo+mtC7gVH5SCnKAgTaYU9M
         WE/g==
X-Forwarded-Encrypted: i=1; AJvYcCU/YVy7zjJ0/Q7h0V1+RztJIJznk2lc1u0N/V6hguTJWLxeotrgZnZNebSy0zb3HrRIUhFNRlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHm4jZibMGWhRXEYfxOnjbt7pM5ZkwPvpEvDoFR38ZVXVy/Bjr
	4X5cKfSdIds4Rx4p9LHHKc0Yh9XPbHTe8XvHwptLjAJKumctwDlI65AMSI1kvYJ8h9MalIeLl9r
	XPL2IwkYu9r220zBQLviyPq9ndrOkJvQbqtRo43K06qtrzWGSPuHmSBVvAQ==
X-Gm-Gg: AY/fxX7nXLcE7c5JQcqoUV4rSYJQVs4yCKz3UC/ePiLsFcHXNmgMZe95arl0fABUDHR
	BivC3cD3NYBvU8G3lZpjLwfcRHFrwPSKFPIIknSmIEFYl/DSL7MkEMv+TmCOYMnR7A2MMvVf851
	aTlOSPZonQxw9Srply/HX+0m3zZly0uSSIOy9ZfV8ONmTNRdPegYZRnSwtBHWsOPf3arFNmIMeg
	W3g1EZUNceInYQP4mX3yXaio3B+tiuBHUuF72x8RO92+g8Eef3tLVSEGBwCSzvjd3cDZmdNmosj
	hLtO6hgARK4Oi2Gkus0HledgffSTqUKCLLfEGbN3wQ6J2UobNYsLnrLIBRo0clldu7MlyWXDSKc
	vV3KtdicvcYv1ynS8C33diNA2e48mwFmasIwJH5je+sCeRrnncMPN+yAloJX4CNId
X-Received: by 2002:a05:600c:6489:b0:47d:4044:4ada with SMTP id 5b1f17b1804b1-47ee33441a5mr61634895e9.13.1768474783072;
        Thu, 15 Jan 2026 02:59:43 -0800 (PST)
X-Received: by 2002:a05:600c:6489:b0:47d:4044:4ada with SMTP id 5b1f17b1804b1-47ee33441a5mr61634725e9.13.1768474782697;
        Thu, 15 Jan 2026 02:59:42 -0800 (PST)
Received: from debian (2a01cb058918ce0031a07ba3ae782cb2.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:31a0:7ba3:ae78:2cb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428be2b6sm41607815e9.9.2026.01.15.02.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:59:41 -0800 (PST)
Date: Thu, 15 Jan 2026 11:59:39 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+7312e82745f7fa2526db@syzkaller.appspotmail.com,
	James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH net] l2tp: avoid one data-race in l2tp_tunnel_del_work()
Message-ID: <aWjIm9SDLjHztAT-@debian>
References: <20260115092139.3066180-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115092139.3066180-1-edumazet@google.com>

On Thu, Jan 15, 2026 at 09:21:39AM +0000, Eric Dumazet wrote:
> We should read sk->sk_socket only when dealing with kernel sockets.
> 
> syzbot reported the following data-race:
> 
> BUG: KCSAN: data-race in l2tp_tunnel_del_work / sk_common_release
> 
> write to 0xffff88811c182b20 of 8 bytes by task 5365 on cpu 0:
>   sk_set_socket include/net/sock.h:2092 [inline]
>   sock_orphan include/net/sock.h:2118 [inline]
>   sk_common_release+0xae/0x230 net/core/sock.c:4003
>   udp_lib_close+0x15/0x20 include/net/udp.h:325
>   inet_release+0xce/0xf0 net/ipv4/af_inet.c:437
>   __sock_release net/socket.c:662 [inline]
>   sock_close+0x6b/0x150 net/socket.c:1455
>   __fput+0x29b/0x650 fs/file_table.c:468
>   ____fput+0x1c/0x30 fs/file_table.c:496
>   task_work_run+0x131/0x1a0 kernel/task_work.c:233
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
>   exit_to_user_mode_loop+0x1fe/0x740 kernel/entry/common.c:75
>   __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>   syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
>   syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
>   syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
>   do_syscall_64+0x1e1/0x2b0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff88811c182b20 of 8 bytes by task 827 on cpu 1:
>   l2tp_tunnel_del_work+0x2f/0x1a0 net/l2tp/l2tp_core.c:1418
>   process_one_work kernel/workqueue.c:3257 [inline]
>   process_scheduled_works+0x4ce/0x9d0 kernel/workqueue.c:3340
>   worker_thread+0x582/0x770 kernel/workqueue.c:3421
>   kthread+0x489/0x510 kernel/kthread.c:463
>   ret_from_fork+0x149/0x290 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> 
> value changed: 0xffff88811b818000 -> 0x0000000000000000
> 
> Fixes: d00fa9adc528 ("l2tp: fix races with tunnel socket close")

Reviewed-by: Guillaume Nault <gnault@redhat.com>


