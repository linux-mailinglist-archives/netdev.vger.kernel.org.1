Return-Path: <netdev+bounces-204592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B85AAAFB503
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CA01AA5654
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45BD2BE7D2;
	Mon,  7 Jul 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dl1wiALK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4942798E3
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895908; cv=none; b=KOptWoiBca5MvtDVngLwmN8eg/bqg/gKesGeFoxjDXIrdkzuTXuUJHEQ7G7AiCyTF4bEj0WcgTXkeW6AWSzSYR2xbgFpD/2tWYQa6E0VCeba5qA2Vbmga7h84o8HtsnWNvHW+7XKxhysQT2wLOfkOzzQ4iXC5KoxDBxA9W7GDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895908; c=relaxed/simple;
	bh=4nWoZbXOa3P4G9LNEOg28qNQ+DH/iPMz3tL8J2Ld194=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9lyC+ekbjzO4Xl3Ukj3InIuMCWDue7y4CY54FePUX5a7aTXmhsebVpW0RyoF1a1Eml/GRfc2QnSFls9551QSEU8auGgOimUwr+7os8+eH56ig6tp20bOdZN69IBi09YIYtfj/8LyCgTTkwB9eZB7CHNB2hFrY/rEcA1e99TPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dl1wiALK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751895904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tvcFV1GeeG+eHTh3R+owfSySEvVbzEe5U4S54265WlQ=;
	b=Dl1wiALK5DKszWr5C+7k25yDQ84fbd7xRjvLOZxFyGbXK3Drk6+YFBwLRwOVkSHZsAUHf2
	/U/PfTwm2ErKShYnrrkgVxvTYHG/oPaPGaMHKV96z2fY3ExRCmm+LpqW3rhF3cFJTgxQ3r
	Ux6Hm341auugWLboH1Wq49QrhbgREJA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-0-457O_YPJKodBMekYPXbQ-1; Mon, 07 Jul 2025 09:45:02 -0400
X-MC-Unique: 0-457O_YPJKodBMekYPXbQ-1
X-Mimecast-MFC-AGG-ID: 0-457O_YPJKodBMekYPXbQ_1751895902
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450df53d461so25496145e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751895901; x=1752500701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvcFV1GeeG+eHTh3R+owfSySEvVbzEe5U4S54265WlQ=;
        b=HPCCLHlMENOMcvdXClvNPRx7U8SE2X6Xnw6eSuaZ2AjucqFoTzZT+dV2bFoK99+wg6
         Ow5KANoq/DXnxHQXC5aW/vW11wPgMqQ0zNRyCegTvJPKQkWlicD6Byo1nwzkZrMm91Ts
         fujTk5rW0RNPRIXlpjd5LJJsBcYNc+l9mSPjAu7kB1zhojOZV58yRlzug6O9bjgnIV7p
         xFWebb19muRJM5ltzVsOPnSQHTcg90NbqS+z/p6VXGxHxCdLJeWVq+lVSbLeydT1YKOD
         lIyDxruNLHf4JjCHE03gmXvH4Xdb4ltvFaUkLWg3KSabC24zjqjFa3fpZD4Qo7Tq8HKj
         vyjg==
X-Forwarded-Encrypted: i=1; AJvYcCWaMdWf9bljAtY9PM5wFUfrzQoVvW4vQkF74Hg4O+8yuD5NEo/l/fsZfFZquNBPm+9VlNHYzUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgcOZP/WHPiz2hJ22CDjic8dGz8QjGTQTp0vbQaMnYnb6vfbOR
	HGp85z4S3VpcvJUUELUNiX///XjaleQ+vs3djIvLLie8H1aVG2MBrbtmU8YEnuX2dwIwN87yM39
	+wFtck1Y/5DkqlvyTDrlcjA+7IBzeWt/NCpRtDyPgBMMDCcciQvAce1Ag3g==
X-Gm-Gg: ASbGncsz3dUWXA4KOn9MzOd214bAb4gHzAfYaXGWMpWzkRTKfjFIZ9sKwAm2i203URa
	zQ84Q5QDQF643r54I2h9e8q3E1gAIZQdtey4ZEDiTEqd/JpfE4NBCpFrltQJVREZHfgRh9i+RVq
	x9q28xDl0MV/tWlJbYviC3XAvxsbDUF2D6i3cDzDv20Z+IKJGVRT5ov8ezIrP0/X+XvLJt1AvoN
	eU+3Bl/84A0+HebqfsAxrz1pDN+AAIXOrmj3w7MNqxZkoHLhAWH8swTz4jkinCyAFfL1c3C1wG2
	v/mbNjlRjTgCtQkz0IWjoXXTUqMa
X-Received: by 2002:a05:6000:2dc7:b0:3a4:ed62:c7e1 with SMTP id ffacd0b85a97d-3b4964f4d29mr11481319f8f.12.1751895901421;
        Mon, 07 Jul 2025 06:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiCATki+fxjScyrWgdR20S4tEFICHWDwdGQaRK/ERz5vFB0AIkRXK12Rj52ppnflqLQWuEzA==
X-Received: by 2002:a05:6000:2dc7:b0:3a4:ed62:c7e1 with SMTP id ffacd0b85a97d-3b4964f4d29mr11481287f8f.12.1751895900730;
        Mon, 07 Jul 2025 06:45:00 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030b9desm10348678f8f.19.2025.07.07.06.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:45:00 -0700 (PDT)
Date: Mon, 7 Jul 2025 15:44:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>, fupan.lfp@antgroup.com
Subject: Re: [PATCH net-next v5 0/4] vsock: Introduce SIOCINQ ioctl support
Message-ID: <yx44jpqxyi5yujwgdvyzajsjyf6rjqht5ypvp7q72imc6cfs2e@7yzhohzyilpq>
References: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>

On Sun, Jul 06, 2025 at 12:36:28PM +0800, Xuewei Niu wrote:
>Introduce SIOCINQ ioctl support for vsock, indicating the length of unread
>bytes.
>
>Similar with SIOCOUTQ ioctl, the information is transport-dependent.
>
>The first patch adds SIOCINQ ioctl support in AF_VSOCK.
>
>Thanks to @dexuan, the second patch is to fix the issue where hyper-v
>`hvs_stream_has_data()` doesn't return the readable bytes.
>
>The third patch wraps the ioctl into `ioctl_int()`, which implements a
>retry mechanism to prevent immediate failure.
>
>The last one adds two test cases to check the functionality. The changes
>have been tested, and the results are as expected.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>
>--
>
>v1->v2:
>https://lore.kernel.org/lkml/20250519070649.3063874-1-niuxuewei.nxw@antgroup.com/
>- Use net-next tree.
>- Reuse `rx_bytes` to count unread bytes.
>- Wrap ioctl syscall with an int pointer argument to implement a retry
>  mechanism.
>
>v2->v3:
>https://lore.kernel.org/netdev/20250613031152.1076725-1-niuxuewei.nxw@antgroup.com/
>- Update commit messages following the guidelines
>- Remove `unread_bytes` callback and reuse `vsock_stream_has_data()`
>- Move the tests to the end of array
>- Split the refactoring patch
>- Include <sys/ioctl.h> in the util.c
>
>v3->v4:
>https://lore.kernel.org/netdev/20250617045347.1233128-1-niuxuewei.nxw@antgroup.com/
>- Hyper-v `hvs_stream_has_data()` returns the readable bytes
>- Skip testing the null value for `actual` (int pointer)
>- Rename `ioctl_int()` to `vsock_ioctl_int()`
>- Fix a typo and a format issue in comments
>- Remove the `RECEIVED` barrier.
>- The return type of `vsock_ioctl_int()` has been changed to bool
>
>v4->v5:
>https://lore.kernel.org/netdev/20250630075727.210462-1-niuxuewei.nxw@antgroup.com/
>- Put the hyper-v fix before the SIOCINQ ioctl implementation.
>- Remove my SOB from the hyper-v fix patch.

Has I mentioned, that was not the issue, but the wrong Author.

There are also other issue, not sure how you're sending them, but I 
guess there are some issues with you `git format-patch` configuration:

$ ./scripts/checkpatch.pl -g net-next..HEAD --codespell
-----------------------------------------------------------------------------------
Commit ed36075e04ec ("hv_sock: Return the readable bytes in hvs_stream_has_data()")
-----------------------------------------------------------------------------------
WARNING: 'multpile' may be misspelled - perhaps 'multiple'?
#23:
Note: there may be multpile incoming hv_sock packets pending in the
                    ^^^^^^^^

ERROR: Missing Signed-off-by: line by nominal patch author 'Xuewei Niu <niuxuewei97@gmail.com>'

total: 1 errors, 1 warnings, 0 checks, 29 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or --fix-inplace.

Commit ed36075e04ec ("hv_sock: Return the readable bytes in hvs_stream_has_data()") has style problems, please review.
------------------------------------------------------------
Commit 4e5c39e373fa ("vsock: Add support for SIOCINQ ioctl")
------------------------------------------------------------
WARNING: From:/Signed-off-by: email address mismatch: 'From: Xuewei Niu <niuxuewei97@gmail.com>' != 'Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>'

total: 0 errors, 1 warnings, 0 checks, 28 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or --fix-inplace.

Commit 4e5c39e373fa ("vsock: Add support for SIOCINQ ioctl") has style problems, please review.
------------------------------------------------------------------------
Commit 3eb323b2d9f4 ("test/vsock: Add retry mechanism to ioctl wrapper")
------------------------------------------------------------------------
WARNING: From:/Signed-off-by: email address mismatch: 'From: Xuewei Niu <niuxuewei97@gmail.com>' != 'Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>'

total: 0 errors, 1 warnings, 62 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or --fix-inplace.

Commit 3eb323b2d9f4 ("test/vsock: Add retry mechanism to ioctl wrapper") has style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.

>- Move the `need_refill` initialization into the `case 1` block.
>- Remove the `actual` argument from `vsock_ioctl_int()`.
>- Replace `TIOCINQ` with `SIOCINQ`.
>
>---
>Xuewei Niu (4):
>      hv_sock: Return the readable bytes in hvs_stream_has_data()
>      vsock: Add support for SIOCINQ ioctl
>      test/vsock: Add retry mechanism to ioctl wrapper
>      test/vsock: Add ioctl SIOCINQ tests
>
> net/vmw_vsock/af_vsock.c         | 22 +++++++++++
> net/vmw_vsock/hyperv_transport.c | 17 +++++++--
> tools/testing/vsock/util.c       | 30 ++++++++++-----
> tools/testing/vsock/util.h       |  1 +
> tools/testing/vsock/vsock_test.c | 79 ++++++++++++++++++++++++++++++++++++++++
> 5 files changed, 137 insertions(+), 12 deletions(-)
>---
>base-commit: 5f712c3877f99d5b5e4d011955c6467ae0e535a6
>change-id: 20250703-siocinq-9e2907939806
>
>Best regards,
>-- 
>Xuewei Niu <niuxuewei.nxw@antgroup.com>
>


