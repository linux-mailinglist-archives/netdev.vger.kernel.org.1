Return-Path: <netdev+bounces-172987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D76CA56BD0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3760179B89
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5F221C188;
	Fri,  7 Mar 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlM00xpa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51F21A92F
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360918; cv=none; b=U69WICIbiEFXuyz1KbMQKNCu19vl/KpvIfcXIiNv7xu0CDdgInDvMiHSxqNWLbSQgFmFd0XtJQbKqXKLe+tbWZbC5jHVav8qPBwjV/LI7Q/pUI7v/iyvRK+SlSfQK+J7krqkZNXv39OR5vVPs/nZkisau+Mgv/23U7T8dBbQ6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360918; c=relaxed/simple;
	bh=DJM66rWszy8juxxYH+vrt7ZlcZ7HnuQkCG08KmYkw7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAO4tLlUK+EIQgzZIfZmjj92PJu+hXCbTaY07lmROB/WKIM7yVSQBArBtvTZtERk4nUqG+ImeYvncQnwimNyh1UGdWgynPQG+ht4BeHPe2mTj3njLNOqA93XN6aLrA/FzL4mbThEshExBIrNJHcXmQyCz6v7f+aPA4IQeqAsoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlM00xpa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223378e2b0dso29806375ad.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 07:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741360916; x=1741965716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHdkLhRIXBVpQgbyNCJqKjsg/rJdM5/FbuNB53B149c=;
        b=WlM00xpavJr8zU7CnUkuoUFuNR5eS961/GhoR2psaL/+miXvSX8I/iGiAoptQ9qDx2
         IDAXolfmOWAQnzoOmat7ao6xoU8cWFyixZ0k5oZM1Ds4GPTXIDfLfhvXxYQRkS5WTwrW
         dEqp+7OiLcENhchkOrk3+R2fQBcA0zokLmrpmJwf8aWO/RwxbFEY1cDqg/H47coOJjsF
         isshu1etX5vHCtYln5WRutfhkZNQ1reMXKYx2JQe6UI2GDwTgVh8UOWGPQptFcIX+JkU
         oq+ONeAb/S8ntr9O2gbt7cPrqfjzpcFGzQLH+U4H5fkXyarFoASnjcqG4RLZcnGbiq0w
         UhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360916; x=1741965716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHdkLhRIXBVpQgbyNCJqKjsg/rJdM5/FbuNB53B149c=;
        b=sws4jM7VfT7x8vhzS6JgHY1Xbr4n0ak447lpwRlVYX58+fao+3XzBfvJLdUj2Ekn8h
         vEuckDMNoUdYf0PRlLxuuFMM5O/1tkTLp8A5d0uZg6yYVfVY9Dmv/3c86TXknP3liDGH
         zkVJa9kG82F5YTVNRp95QOvWbqK8A7n2/LHTY2A38S9qd/2K2PN5lwyYQ0llilKASvel
         WBP6BYZYq11RrRh6+sm9OEs4lO+CMvD9pfl5P1q5DyvwcZ3y+R2yTwfI+mr3htbAkqPU
         nuq0lFCmbbCTVWLP73mjhvk6i/2mLXbokKVhyHJbB7z14+GpVGVsLfGScGu2ljaIPBw0
         Y41g==
X-Forwarded-Encrypted: i=1; AJvYcCUNOBhYSPcFSC+VYZ4aDbvbXBgv8kj00xKNGkUce+PhAC7GmmkNjSvjj3fTNLyqBRSpHLmeLyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/NXMkcoyonXip2ZJlC2NkftDBCKIgng9YRE8vOM8dP3yF6jp
	+yir/YwYdhFsA4Hkt2GIqZeKNIAfeDInVbh7EEdwQaQXXwrrXm0=
X-Gm-Gg: ASbGncv3q7JpnCgxCzAcdFHXtQZXfXL6vVwnRe6uTBcXd66pa+t+L3pxGQOFkqigzFk
	D4IH3k0eoUv4B27lArgnf3SWLcSVOear0xAfRec/ojS/tHuLd3Kn4k082tbzEYwXzS2wluLGiSc
	QGZSmV593f+/QyOmMb1rPJ7tjSkLkeCnGhgTj+gbvqj9RXGNXHx7ZBKU8oPA3lHShDkWNusyh61
	XleiHDvqhvVUXspzNhasW+fPGJuIaKUPDVoLis8OIsx6263ysqnh1b+PctWY5Xh7hYpsWqzBBGE
	vWIqZie+ELZmgygzxfI9QVOGYf+mICBkKVx7bu1h4ShC
X-Google-Smtp-Source: AGHT+IH5MjRZc259bLKDYpIINeRtq7U3Hjx0TWU+ZFMr1f3w4N0uSrZAypQGeT+a4XhVjhKD2wb5mg==
X-Received: by 2002:a17:903:1b63:b0:21f:85d0:828 with SMTP id d9443c01a7336-22428be5cd1mr65432785ad.41.1741360915721;
        Fri, 07 Mar 2025 07:21:55 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410aa543asm30903995ad.228.2025.03.07.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:21:55 -0800 (PST)
Date: Fri, 7 Mar 2025 07:21:54 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+0c7bfd8cf3aecec92708@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] bpf: fix a possible NULL deref in
 bpf_map_offload_map_alloc()
Message-ID: <Z8sPEqJ55AX7qKWN@mini-arch>
References: <20250307074303.1497911-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307074303.1497911-1-edumazet@google.com>

On 03/07, Eric Dumazet wrote:
> Call bpf_dev_offload_check() before netdev_lock_ops().
> 
> This is needed if attr->map_ifindex is not valid.
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000197: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000cb8-0x0000000000000cbf]
>  RIP: 0010:netdev_need_ops_lock include/linux/netdevice.h:2792 [inline]
>  RIP: 0010:netdev_lock_ops include/linux/netdevice.h:2803 [inline]
>  RIP: 0010:bpf_map_offload_map_alloc+0x19a/0x910 kernel/bpf/offload.c:533
> Call Trace:
>  <TASK>
>   map_create+0x946/0x11c0 kernel/bpf/syscall.c:1455
>   __sys_bpf+0x6d3/0x820 kernel/bpf/syscall.c:5777
>   __do_sys_bpf kernel/bpf/syscall.c:5902 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5900 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5900
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> 
> Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
> Reported-by: syzbot+0c7bfd8cf3aecec92708@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67caa2b1.050a0220.15b4b9.0077.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Oops, thanks for a quick fix!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

