Return-Path: <netdev+bounces-169286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E0CA4335A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 04:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6884917A0D7
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C9128366;
	Tue, 25 Feb 2025 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gg5wsJlL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77F63C38
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740452555; cv=none; b=ZKZH+wF5KeUlcVpu4b5HL36TqA+uxAn/+yrBfYIzmRCTtf9mpaCZPFVnv0a6YD0gBgqAdebykbx0XexMaNFsx92FG1cPJCLx+k6qwwEypX82eEUWwMU4O0NWN8zCj0T7e4HgFcSrLl2Ya2BS31+4r7SosiuZ4qdvEVNkPzJTUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740452555; c=relaxed/simple;
	bh=FU4TLM2MkO3S/lV0HkIT1xTCwvcyXAkDYFvO18orl/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7BJ9BaaWeC+NwmTlIgmiT/1aJv4YN2kAydfbKyoekNXpjUb25S4EvuqsJLkufdxNvCUQj30TYguXn8mZEJlYZR21BMkb4kurIORlMU3NZuhgkvHYERB/sbWgb1fi9kcHkEbgdPjN/eTcoOUAhTDFAkU+Fay9C2FUR9NJ9nk07c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gg5wsJlL; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd15d03eacso48582206d6.0
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740452552; x=1741057352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug8NwBfivrOgnYcA4EqL3bQC5MfA8YnwgBxaTB+IaEI=;
        b=gg5wsJlLyLnkSrmgR2Dm5PdeIs4qOjarqx1/Qpflnv/K/rGjBzycls2as+y13Jm2m/
         0PT46iSz2CUscBnunBmyjetKZXg0F6FrJ/ZFq1otDvh8c0x4ZpYn6OEYary67y3hgaMH
         aA5EFLPoc/k9ZLXFgpD1pY5TKgxINj6XdKVpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740452552; x=1741057352;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug8NwBfivrOgnYcA4EqL3bQC5MfA8YnwgBxaTB+IaEI=;
        b=EvJscnOU0aqbbZNdFtvuVGMetqD4HIQ4B4R7zDM/YCWSvw5TRc/ekOFnbLz1nG1nhJ
         vEZyhPu5eFV9KCItgofvohaku6dmqJMiN0zL89RHbsLY4My4NVaoq5yOn4z6Mw7WAJzu
         uAYuW26P69X7yH7YMmS8UT+BP1aux4jS/F0HINQyjim9fb6RqNnJPuLMEr7TYRs9vLnL
         VkyehQdMSojUXTbkOfY8ib35PMfwrJR07cAp5BgmRCZ64GCvkVSVfnQE4/ROa5YFvAOQ
         pSpQ2zEMPgKvs4rbFjSZqvOsHqnZueIF6SXAx6uUw7c+jRsnGklp0hbYAaLpXHXGaJD8
         NIvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGzfH0UiWb6muTHHMBIb+vjJRxusVOlxUPHI4P0Z5f4aOKd3vJuRU1lYclwHhT293PajOTy6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/lk8IZ2UMBMAYfitdUweokLZb/NpOpa9HMFmNSXwZUgpad9H
	HYwR0CFkA2Sm622Re135nksNUWctaTqpgkwPyptas7Ul349f5CwlDwuALz9DJ80=
X-Gm-Gg: ASbGnctFTXpIsD4P7FLP7heHnJ9Xgw+ucI/CFfcWQnEjtg4XD5RtOO3Yo/q/tEanKQS
	AdzY6uSjepQypc6N3sZwVQEEIcqziIPPlZlJiBAGud2GtGmj1I5kW4eFspSMH0AVM+3/Eeibhtl
	4utapRjFC8wJB5xfUWOsoX4uRUIlaBUr4pBad5yt4VLQ3mImaNlSAthlHRMualbCkYAbXU3qm4N
	i5/4I+e98aO7zHfgx0rG1PVXyYAc57iyxabK7iCsl628FxYggFnsKqVaMbqKu0I2apF6KOkYnpM
	AFfG0LfeTvZzwxT454wNXpvrTGC0a2eXE15NdUSnkjYScNG5Vc/1eRdwar+YkTVc
X-Google-Smtp-Source: AGHT+IHYq9JPhIIdjZAYeUQu/47H4+RNY26Q6928CpBQmOq+nEFJEYNIOOGzrUX7fNR1H7FwmZWc7g==
X-Received: by 2002:a05:6214:1250:b0:6e2:3761:71b0 with SMTP id 6a1803df08f44-6e6ae72d99bmr235451876d6.5.1740452552663;
        Mon, 24 Feb 2025 19:02:32 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b19a3bbsm4540516d6.119.2025.02.24.19.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:02:31 -0800 (PST)
Date: Mon, 24 Feb 2025 22:02:28 -0500
From: Joe Damato <jdamato@fastly.com>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH v2 1/1] af_unix: Fix memory leak in unix_dgram_sendmsg()
Message-ID: <Z70yxC3uHE6R_KOu@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
References: <20250225021457.1824-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225021457.1824-1-ahuang12@lenovo.com>

On Tue, Feb 25, 2025 at 10:14:57AM +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> After running the 'sendmsg02' program of Linux Test Project (LTP),
> kmemleak reports the following memory leak:
> 
>   # cat /sys/kernel/debug/kmemleak
>   unreferenced object 0xffff888243866800 (size 2048):
>     comm "sendmsg02", pid 67, jiffies 4294903166
>     hex dump (first 32 bytes):
>       00 00 00 00 00 00 00 00 5e 00 00 00 00 00 00 00  ........^.......
>       01 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>     backtrace (crc 7e96a3f2):
>       kmemleak_alloc+0x56/0x90
>       kmem_cache_alloc_noprof+0x209/0x450
>       sk_prot_alloc.constprop.0+0x60/0x160
>       sk_alloc+0x32/0xc0
>       unix_create1+0x67/0x2b0
>       unix_create+0x47/0xa0
>       __sock_create+0x12e/0x200
>       __sys_socket+0x6d/0x100
>       __x64_sys_socket+0x1b/0x30
>       x64_sys_call+0x7e1/0x2140
>       do_syscall_64+0x54/0x110
>       entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Commit 689c398885cc ("af_unix: Defer sock_put() to clean up path in
> unix_dgram_sendmsg().") defers sock_put() in the error handling path.
> However, it fails to account for the condition 'msg->msg_namelen != 0',
> resulting in a memory leak when the code jumps to the 'lookup' label.
> 
> Fix issue by calling sock_put() if 'msg->msg_namelen != 0' is met.
> 
> Fixes: 689c398885cc ("af_unix: Defer sock_put() to clean up path in unix_dgram_sendmsg().")
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
> Changelog v2:
>  - Per Kuniyuki's suggestion: Remove 'else' statement

FYI according to netdev rules you should wait at least 24 hours
between repostings:

https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

That said:

Acked-by: Joe Damato <jdamato@fastly.com>

