Return-Path: <netdev+bounces-98453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D1F8D1788
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5C01C21B26
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49D13D89B;
	Tue, 28 May 2024 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UzhZOFAc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4C17E8F4
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889875; cv=none; b=TP4taqS3ZowmcDGbD8rCH9kvQ9r+zB1nET3ySThFO2RfzPyrvJfo9ggpBPfxhkgspaZIPh2c1r3//PozgcDUVimUQq+pGD5iWo5DY/CVtyIzOOQsBeBTDQPzrNm6U6DEvfXx+sDj0K0e920jT7C9D4u9nJj//1fUrkMZzYuQjhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889875; c=relaxed/simple;
	bh=JU3piwwWDnGNvMBVf2RzteFj95j2LOLHb8lXn+PWxAw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQnD6CGHmYKy5l94vJaMgC8Eczj9I9dccf/BjLrk1W3S2OpNEp6pNdXC/QawjjZqKUtfejlzN1dDMtK8lJFQlvSb6H7zy91q8I1tczt4yDw2MrN5+yWXPh7LORGP378oHYlQENOhnnV6VKDV6RNHqYhZFObFfz6i7pOdI9jI82Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UzhZOFAc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so4458335e9.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716889871; x=1717494671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOMADtoLxjzHsEY5TtQ05a0/T1hSTypXFShuTybFu8I=;
        b=UzhZOFAcE8iXRrGzF6Vshq0XfFUjnDh+YU08zGOUJpS7oDd/xT5XMGUlwi8EmoJCl4
         mmPMp6qs2WVm5DQqgBMeR85ERjC9gnpRquwVQ9em2GVSKGdUEjNcdBIkyFYq8sdvWqlX
         l7kw+h4CtKdwFQRokpTH6j58atiah3fIWw/QiJLHSoodyRTGiEIDE5Z8b5nQci55ZMFh
         SgQ0nRp7VGBAG3zHWl26l5pu2cLYktgP7+db+SFJd8vv3oLCZMLYj5N1pmD9Ccx6q7Yn
         kCAYy3cAtV9ODgxKxt/RtNgxEdUzD62OhRxlt4UVlEdQnUi6XrYo7LvGYtWlj8gExm4Y
         WKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716889871; x=1717494671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOMADtoLxjzHsEY5TtQ05a0/T1hSTypXFShuTybFu8I=;
        b=riOLEc60YhO4WCw3PshXmwelRQwoBfp7Ms9LN6AapkYoDPzjjEdV/klGtFEeqexNdN
         QsxfkEyB1VIlvVpSKUkhpTyx7RsxqJfFXm0XelimQwc/nLu08FLUtBFd4IFSu1y7XMZr
         FC703mFbP2EmZT++yPHtppcP85uQjVuQfrt9NG1VydPkbl2yR9hjdpYr8HfONVr7mlkk
         8j/kMcTMshdatNWR6pGmt7TQQBMNcTZ9Zdi5RmshDhHHmUc2/hhPZPnEA9196qzStVQW
         4ZUUYQQHfOZP/WuVTXzDqVBdrPij7XCgDwob9pHqhSy1cGL9fu5Gv2TeLHwXak797C7e
         STKg==
X-Forwarded-Encrypted: i=1; AJvYcCWVd3DHPXue1+8ZItLnx9mJHP2dBIsI3zLWXoIIzzl1S5hGq7vezu0h1Zrm7zWi4XEsO/gh533swX6phXXwh/5/KVgUSToh
X-Gm-Message-State: AOJu0YzTlkjJK0V1Um1do2wuIa8cv/jOqjP8qkzPAkOHpjShSRdaHQDN
	fpBhJZuPQV79fIVFtn4P93QsVRoUoHV2pwp7rCcjii8Nw1cwiOCTX65/sq0Sdw8=
X-Google-Smtp-Source: AGHT+IF1iZ7fRzvumXkXE9sSLGZIvaAZFZDfvWIf6ZUq4dr8v2NP/LY9fgTAxRxapBiCuGYnLQ05kw==
X-Received: by 2002:a7b:ce0f:0:b0:41f:fca0:8c04 with SMTP id 5b1f17b1804b1-421089cd231mr99790625e9.11.1716889871476;
        Tue, 28 May 2024 02:51:11 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fbb140sm169410525e9.44.2024.05.28.02.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:51:11 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 28 May 2024 11:51:09 +0200
To: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
Message-ID: <ZlWpDZSqKRJaqLp9@localhost.localdomain>
References: <0000000000004096100617c58d54@google.com>
 <000000000000f9561b06196ef5b3@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f9561b06196ef5b3@google.com>

On Mon, May 27, 2024 at 05:50:24AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    66ad4829ddd0 Merge tag 'net-6.10-rc1' of git://git.kernel...
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15c114aa980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
> dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17770d72980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10db1592980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/05c6f2231ef8/disk-66ad4829.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5f4fc63b22e3/vmlinux-66ad4829.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/67f5c4c88729/bzImage-66ad4829.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com

#syz test: git://github.com/leberus/linux.git hugetlb-vma_resv-enomem


-- 
Oscar Salvador
SUSE Labs

