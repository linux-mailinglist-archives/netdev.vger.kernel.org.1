Return-Path: <netdev+bounces-163465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C209A2A4F7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B0D3A6D2A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3722756E;
	Thu,  6 Feb 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h/aPps5Z"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8BE226193;
	Thu,  6 Feb 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835181; cv=none; b=eFqYXqXNZQnVJEmfEzPbuHOh5y1h7NWMkr9MaQ3uhx+1CflLoV44gWdhb5oHmkVBRDObo09B9bIIF3d9qeLL/WHPgkBt+1fJggx/9ntE+ez9jDgKU3PPGj5p0hAxC/GgtZkAXF/BlR1bT9YJngixcsvHaKdPFJz95FV05g/2ov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835181; c=relaxed/simple;
	bh=OciwV88ohOu6tEga8w5/A7cFo03Xlfs4DGnqeIwiR/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JScltmne14Ee8J4YjC/OGZRH2SJmB4Npa0esh2puOsN2jrLygvFrpuJiUNxl9t7jncpG6/jAC/Sas1a55xCwU90NeRvv8uRUeu8wttm/NWx1iiS9meGA+OtaqErncYR/iKD9335HacxgUuLFzk1yP2gK4rchBr1PGjBt414Uub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h/aPps5Z; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=HFB+Bawv3lBqMs7vEm+2pmHpbYdR99g6fi3SDpxKfB8=;
	b=h/aPps5ZJ+I20lNC0VHDQ/kPCevoAKLrxhrSuMBrsLNRmyl5ZiiVhcg336TSyx
	om0tVKJhSBdOozwLA2pCvtyoRcXxrJD+9NvReSSIu3jnCjxpMvfsmu9JsksKVJ17
	aZIsu1hOKfZqleRpkiRQwuiGBzHoWbnKxn6AdETGmDrQM=
Received: from hello.company.local (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3jWuZhKRn7M3tJw--.17672S2;
	Thu, 06 Feb 2025 17:44:58 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: kuniyu@amazon.com
Cc: buaajxlj@163.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	liangjie@lixiang.com,
	linux-kernel@vger.kernel.org,
	mhal@rbox.co,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2] af_unix: Refine UNIX pathname sockets autobind identifier length
Date: Thu,  6 Feb 2025 17:44:57 +0800
Message-Id: <20250206094457.196837-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206085834.17590-1-kuniyu@amazon.com>
References: <20250206085834.17590-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3jWuZhKRn7M3tJw--.17672S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWDWr13urWDCryftF43ZFb_yoW8AFykpF
	W5Ka43JrZ5ArWxKr1Iqw10krs5ta15t3yUArW8XFy0kF4agrWxJF1SkrWj9w1DCr1Iqw1a
	qr1rCa9FkryqvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUx-BtUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/xtbBzwvrIGekg7ALjgAAs6

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Thu, 6 Feb 2025 17:58:34 +0900
> From: Liang Jie <buaajxlj@163.com>
> Date: Thu,  6 Feb 2025 16:19:05 +0800
> > Hi Kuniyuki,
> > 
> > The logs from 'netdev/build_allmodconfig_warn' is as follows:
> >   ../net/unix/af_unix.c: In function ‘unix_autobind’:
> >   ../net/unix/af_unix.c:1222:52: warning: ‘snprintf’ output truncated before the last format character [-Wformat-truncation=]
> >    1222 |         snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
> >         |                                                    ^
> >   ../net/unix/af_unix.c:1222:9: note: ‘snprintf’ output 6 bytes into a destination of size 5
> >    1222 |         snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
> >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > snprintf() also append a trailing '\0' at the end of the sun_path.
> 
> I didn't say snprintf() would work rather we need a variant of it that
> does not terminate string with \0.
> 
> 
> > 
> > Now, I think of three options. Which one do you think we should choose?
> > 
> > 1. Allocate an additional byte during the kzalloc phase.
> > 	addr = kzalloc(sizeof(*addr) + offsetof(struct sockaddr_un, sun_path) +
> > 		       UNIX_AUTOBIND_LEN + 1, GFP_KERNEL);
> > 
> > 2. Use temp buffer and memcpy() for handling.
> > 
> > 3. Keep the current code as it is.
> > 
> > Do you have any other suggestions?
> 
> I'd choose 3. as said in v1 thread.  We can't avoid hard-coding and
> adjustment like +1 and -1 here.

The option 3 would result in a waste of ten bytes. Why not choose option 1.

I have a question about the initial use of the hardcoded value 16.
Why was this value chosen and not another?  sizeof(struct sockaddr)?

Its introduction felt abrupt and made understanding the code challenging for me,
which is why I submitted a patch to address this.


