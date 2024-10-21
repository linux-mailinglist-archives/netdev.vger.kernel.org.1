Return-Path: <netdev+bounces-137596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D129A71ED
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56FBB23406
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8773C1FA271;
	Mon, 21 Oct 2024 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUEGzAQq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E091FA26F
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533903; cv=none; b=P7yobGGMgn3gTZphMuykfw+U2IxdxxTIMmKB8GnRBobal5wa+DrSkTF9mgzxTzeQog4jrzv2HgEeKNa8TjHGkHfZ8O/9+I/AFtpQwzZW2iCote7QEzZiV+PrMO4yuXuf7CpitOsXkWsoQVT/zEPNBuRXc8gqVdJlIBa39FOcetg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533903; c=relaxed/simple;
	bh=f254UdbS5Kp+l0bTqUjtX1NKTMcU1diXDBWuKAgkiUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSA+SqORbKTzJxxOdf/Hb9bXD/RvqGWRSHgSxTlj9Gz6UJohQ9MfAOul1s/69vjgvPqiw18CtsmUpSRNdM2EKxjFIRpLM1/9nMmJb2oYa5YprIsYRYDUlLciaQm90btIMK4F3nsqSzXy/GdxDSTWfnxa5f0CLhQ+p4NGRjerzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUEGzAQq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cceb8d8b4so27110015ad.1
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 11:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729533901; x=1730138701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztFaIQorKB7mOAeuqRQAq5AhPcWa5TSnmyqVkSlvmxA=;
        b=KUEGzAQquBRNDNjVy++W9ZyT/Pv0HXyOvT+D0T6ve2zLqJjWxsXXO5rmuS6BcDIaz1
         hV7T5gl4/mZPrB9b2jonUOg+Bj3iTiubwvpDenzV64giXUNN4+dfWd+Dpw2QnyI+kuTH
         v/XtAVbA4lXWqqybb4KtIll2kanaxg1D03bhiEDGi0uHLiIUFop0bUF84oNh+hwe58jO
         BlkkDrTcaD6YGgCsG69YRF2f/ntvHvEfVk8z4y9BSG3GclzcC2QHs3Wp3lYH4YMyC58g
         az0fRbgktKrAFWB9UEUCyZKmRKWIk6XB5mdPnS8iwqogiGbKGPF4DiUUXUQM1lIGv9K6
         uP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729533901; x=1730138701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztFaIQorKB7mOAeuqRQAq5AhPcWa5TSnmyqVkSlvmxA=;
        b=YyUoJUEnulZn9I97QhT/Q1YAmK+5z9TdjVA7qnS1oge7Wv83usrtZuTzTJ++OPDEQy
         FayVXaPLJXhgn063FP6SUMUnKrEtBNl68BovWJKQQH9w9Er9zXdz4gRRm64sfjpwadj8
         BegXUrW15h9zTW4DyzsieTn983IRy48HNcyECLbr+yXedFWj4eBL3QyqG56gVeZA3F0A
         9ngv3F4UHBmPPt9Hn7+U8+1qiEQwIOC96ck9QRYnq+4IBDL3JnGyps5CM+Q71/2mzoGK
         +T8peQfaaSFs0rkILt0ziHYLeZdOlypbUWEUn/GiPja1Yc1Hv6g801W3E95In0wPIVdg
         fDvw==
X-Gm-Message-State: AOJu0Yz0y7K7EzDisf1OmJSN5ogxWkZepV7Tj+lJ+ySVBvkoxNVA6IEs
	2b8X+mo7CfgCqP9clY14iJ7fAmLLulxNuANTjWRFKQ8bUvo76dJDaW7kiMk=
X-Google-Smtp-Source: AGHT+IEjMEZu5mn3lrkl4uCbXqX8pytE8vq4I86yK1v1wbVZJ8VhL9INo6RWEMPG5WH6VfLVjGJlRQ==
X-Received: by 2002:a17:902:c951:b0:20c:76a1:604b with SMTP id d9443c01a7336-20e96fe727amr7116465ad.12.1729533900574;
        Mon, 21 Oct 2024 11:05:00 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0dd5d2sm28797075ad.202.2024.10.21.11.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 11:04:59 -0700 (PDT)
Date: Mon, 21 Oct 2024 11:04:59 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v6 0/6] neighbour: Improve neigh_flush_dev
 performance
Message-ID: <ZxaXyx4wV0EyN52R@mini-arch>
References: <20241021102102.2560279-1-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021102102.2560279-1-gnaaman@drivenets.com>

On 10/21, Gilad Naaman wrote:
> This patchsets improves the performance of neigh_flush_dev.
> 
> Currently, the only way to implement it requires traversing
> all neighbours known to the kernel, across all network-namespaces.
> 
> This means that some flows are slowed down as a function of neighbour-scale,
> even if the specific link they're handling has little to no neighbours.
> 
> In order to solve this, this patchset adds a netdev->neighbours list,
> as well as making the original linked-list doubly-, so that it is
> possible to unlink neighbours without traversing the hash-bucket to
> obtain the previous neighbour.
> 
> The original use-case we encountered was mass-deletion of links (12K
> VLANs) while there are 50K ARPs and 50K NDPs in the system; though the
> slowdowns would also appear when the links are set down.
> 
> Changes in v6:
> 
>  - Reverse changes to mellanox driver
>  - Rename iteration macros to emphasize `in_bucket`
>  - Remove now-unused variables and parameters
> 
> Gilad Naaman (6):
>   neighbour: Add hlist_node to struct neighbour
>   neighbour: Define neigh_for_each_in_bucket
>   neighbour: Convert seq_file functions to use hlist
>   neighbour: Convert iteration to use hlist+macro
>   neighbour: Remove bare neighbour::next pointer
>   neighbour: Create netdev->neighbour association
> 
>  .../networking/net_cachelines/net_device.rst  |   1 +
>  include/linux/netdevice.h                     |   7 +
>  include/net/neighbour.h                       |  24 +-
>  include/net/neighbour_tables.h                |  12 +
>  net/core/neighbour.c                          | 338 ++++++++----------
>  net/ipv4/arp.c                                |   2 +-
>  6 files changed, 175 insertions(+), 209 deletions(-)
>  create mode 100644 include/net/neighbour_tables.h

Seems like the series triggers a bunch of GPFs from
tools/testing/selftests/net/fib_tests.sh:

[  698.336499] Oops: general protection fault, probably for non-canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
...
[  698.336743] RIP: 0010:neigh_flush_dev.isra.0+0x5d/0x1a0
...
[  698.337531] Call Trace:
[  698.337560]  <TASK>
[  698.337586]  ? die_addr+0x37/0x90
[  698.337626]  ? exc_general_protection+0x1b7/0x3b0
[  698.337674]  ? asm_exc_general_protection+0x26/0x30
[  698.337721]  ? neigh_flush_dev.isra.0+0x5d/0x1a0
[  698.337760]  __neigh_ifdown.isra.0+0x33/0x120
[  698.337798]  neigh_ifdown+0x10/0x20
[  698.337827]  fib_netdev_event+0xa1/0x1a0
[  698.337868]  notifier_call_chain+0x5b/0xd0
[  698.337907]  dev_close_many+0xef/0x160
[  698.337946]  unregister_netdevice_many_notify+0x155/0x910
[  698.337990]  ? sock_def_readable+0x14/0xc0
[  698.338024]  ? __netlink_sendskb+0x64/0x90
[  698.338061]  rtnl_dellink+0x14d/0x3a0
[  698.338101]  ? rtnl_getlink+0x376/0x400
[  698.338139]  ? __rtnl_unlock+0x37/0x70
[  698.338170]  ? netdev_run_todo+0x64/0x550
[  698.338201]  rtnetlink_rcv_msg+0x15d/0x410
[  698.338234]  ? get_page_from_freelist+0xf04/0x10c0
[  698.338278]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  698.338315]  netlink_rcv_skb+0x58/0x110
[  698.338351]  netlink_unicast+0x247/0x370
[  698.338384]  netlink_sendmsg+0x1bf/0x3e0
[  698.338414]  ____sys_sendmsg+0x2bc/0x320

https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-10-21--15-00&executor=vmksft-net&pw-n=0&pass=0

Can you please take a look?

---
pw-bot: cr

