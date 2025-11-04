Return-Path: <netdev+bounces-235628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27DCC335EB
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 00:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15193BAF74
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 23:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2797D2DCF50;
	Tue,  4 Nov 2025 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQhqUswO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952662DC339
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 23:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298548; cv=none; b=QHULirX25lr973dJXllQugwt7utIomeF3LF/Xl1+yj2/0A9RrxyGZ7g1EMy+SD+znoSiKhDvW8F1cPIARo97T96Bb2UXehjrHkFjeIH7a4mW6IUaDjUw+YVWcOitbVW4kpnpmdAUdSZgtT8qasNumGODLqIarR7MZsMMitszXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298548; c=relaxed/simple;
	bh=7nfSPumsytiTRTmDQeIgSscuCD4jFGL/qPUnn97EP+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyQxc3lekVyYLuYQtzYqhJF0EnngIMvSHt2l2wc7fAU6whGoybk2P8O4sybyrCFo55nwKKBJazEW0IgPO+qhdeczYC8Vu1mXoZJ1OHNx9V5i49N75lKY/TYV+bad/g4g42gKq3d0JZL6rm4mRvR4R+77kyHDlJXxEl/k/xXriLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQhqUswO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29568d93e87so30888985ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 15:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762298546; x=1762903346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9B+k56MhML3w6peCidIaihxbl7v6WGNiwGQSlC8dp4w=;
        b=TQhqUswOLONh4bjxx7HwNfiElN/2ZG8p7OVRqPwdNHkcK70wTQJPvfANk3hw8ZW3lv
         5aUBCdmWZcBcJw/Nk4s6R/G63uIuziKjGHW3N5ro/W08VABapjGuGEXiW0TGkoQhSqy4
         oojIdA8UPbwz5VTjdwPHNvqr44gDKFhmMvmW185KeJGf6CcO0O+/hlQ710hkZVnJv5MW
         ZMFtkU5K9Zz4yuNZRWgSfGrsA7tEItfn0VYr4m9qCZvy/VWbv4gd0JqQTdXm5MHC4u0X
         R6fLX17WA7RxFXqE2Nw1o7d2rqqEk+7rA0niEe5/e/L2DbT3+hUhLB6iU4yGQgR9YBWo
         y1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298546; x=1762903346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B+k56MhML3w6peCidIaihxbl7v6WGNiwGQSlC8dp4w=;
        b=F2Ly1/VjnGEtMWDc7QXTdigEgotvuJLKrFfAD1m5NruugaZtUeDgR9c5PFhwC/txTC
         A5eGqNS0TjGHnBdNyMVPBQLYHiEC5HjAcDmAt4kTPM88GwT8lYA5zG6Id3KPRBFX2KdI
         FGSifpyihnA2BU67Kqkg1t5xslLxjf7Gm/NIWI6oMTjZAx05hNvs+f+5jbVIF0t3t0wU
         m4+HEx1lEtzqD6F5U1WdvaWCP64e3pPSIxQ0O2w+Jh1Hjlp4CL7tLXJt3Ifs7zZzrMrf
         uU61MlrQMXip34fK7nB4IeewkEr5rm0mHDy4FhQXHaVjTrORTDzxZJsOeTddZ6m7HbhZ
         cdNw==
X-Gm-Message-State: AOJu0YxoBX53+RlpzozwmYGsk7rAO5Z+ub6gDGOKW1aU3vCiYSQsJTaF
	orEUGgHKKtUvLeriMPdJ/aj2rWcuUI1D0oQxd+Q1pOHW8/jxf6tHkxM=
X-Gm-Gg: ASbGncvdkSkZi3eVdSFEGnW1U+Ecxc2OpR5f5fYZuetP+yT+8acDxmgI66+yjPZYsmq
	TYpg+iTU0pqZ2kI+bMyQWDnmqF/l0IDiM5Phcv5rgC5iX+Lb1aamsaIj5cxBQrzc+8ohNhiBYrF
	DhbeXgC3zf1lETwHguk6aWGFJqa1tSUXL4/q2teymc07KXhvVkKclLktxNmsYwbtExKZdXA6GKg
	8WAuqr4b+YCzITuKvD2mCq4pmOmnyMtZSmwNQWbKslT26Tq71tCJnczNTNtAKZC9M3ADKdMa7FH
	mnjCO3CMA1s0bLx155N4suEM6vVkxmMCBGwpCfwwbXyVRpa493JvU7RdHkGXt9QtBQ5pgaYupft
	208Layb3Pu0y8Nb/8XBipYkp5fGihj6Fq+/b6Gr2S8MCsr0iR//kZ6FTgXE6xI+4MrtnZInGTfq
	/6vMJk/+spy9LrhFzPBP57YgjqGHPLeqR0rrZ7qal5XfQQUeeN9PYcLpxs+jPeqBwPlnsoy8BiS
	sfkw8kr9FqxHwQMxMIlnb+13UxijDSA8dCH5ImYALWnXykWTsqEH2Ra
X-Google-Smtp-Source: AGHT+IHNP2zSm0iR5tnsW6DxXVYzXMNKSGdfZXQAgP6iuwMkLSQncO5CWHZG+W8pqjtvzK10tU+k+Q==
X-Received: by 2002:a17:902:e805:b0:27c:56af:88ea with SMTP id d9443c01a7336-2962ae93ffbmr14100715ad.60.1762298545481;
        Tue, 04 Nov 2025 15:22:25 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019729f4sm39075475ad.14.2025.11.04.15.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:22:24 -0800 (PST)
Date: Tue, 4 Nov 2025 15:22:24 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v4 00/14] netkit: Support for io_uring zero-copy
 and AF_XDP
Message-ID: <aQqKsGDdeYQqA91s@mini-arch>
References: <20251031212103.310683-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031212103.310683-1-daniel@iogearbox.net>

On 10/31, Daniel Borkmann wrote:
> Containers use virtual netdevs to route traffic from a physical netdev
> in the host namespace. They do not have access to the physical netdev
> in the host and thus can't use memory providers or AF_XDP that require
> reconfiguring/restarting queues in the physical netdev.
> 
> This patchset adds the concept of queue peering to virtual netdevs that
> allow containers to use memory providers and AF_XDP at native speed.
> These mapped queues are bound to a real queue in a physical netdev and
> act as a proxy.
> 
> Memory providers and AF_XDP operations takes an ifindex and queue id,
> so containers would pass in an ifindex for a virtual netdev and a queue
> id of a mapped queue, which then gets proxied to the underlying real
> queue. Peered queues are created and bound to a real queue atomically
> through a generic ynl netdev operation.
> 
> We have implemented support for this concept in netkit and tested the
> latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
> (bnxt_en) 100G NICs. For more details see the individual patches.
> 
> v3->v4:
>  - ndo_queue_create store dst queue via arg (Nikolay)
>  - Small nits like a spelling issue + rev xmas (Nikolay)
>  - admin-perm flag in bind-queue spec (Jakub)
>  - Fix potential ABBA deadlock situation in bind (Jakub, Paolo, Stan)
>  - Add a peer dev_tracker to not reuse the sysfs one (Jakub)
>  - New patch (12/14) to handle the underlying device going away (Jakub)
>  - Improve commit message on queue-get (Jakub)
>  - Do not expose phys dev info from container on queue-get (Jakub)
>  - Add netif_put_rx_queue_peer_locked to simplify code (Stan)
>  - Rework xsk handling to simplify the code and drop a few patches
>  - Rebase and retested everything with mlx5 + bnxt_en

I mostly looked at patches 1-8 and they look good to me. Will it be
possible to put your sample runs from 13 and 14 into a selftest form? Even
if you require real hw, that should be doable, similar to
tools/testing/selftests/drivers/net/hw/devmem.py, right?

