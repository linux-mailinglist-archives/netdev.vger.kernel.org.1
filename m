Return-Path: <netdev+bounces-83045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235CE89082E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 19:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21CB290F30
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43314136E2D;
	Thu, 28 Mar 2024 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ARG4bkyD"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720CD132802
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650205; cv=none; b=n2iDAHxi/UJOdYcfTOKCY/zDJXaFqSQLsIb2ypZxxZkgRgcCg5hXcxVtC8YaCf92p/kSv/n9nAox1ZjFZC4GQ/NeOamc4QE6ADRmPfOFUzdQBH5/aoE64u/7Z4V/ggLNIvORbXgecdFJdBox3OsdW13yzoi1VfLlizOabWhIFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650205; c=relaxed/simple;
	bh=rhMs+IW+LjgjgJG2bjuDC2kRA/YBDohWPyTnq4wTmlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Mm5zmmW2Zr3mVNKgjXJ7KwPgfyyAW1qXm7Iy6lEtjQqISzBGXs28SfV7rcm1bk0tRd5xU16SC38lvbYrfdGlRI5+TybCdcRr7aYBpCTOxjbOBVpSek4jfKvDbx9fbzxb0t4BMZ+hZ5ZYZwC5DnTnj47nOOsQ9+ZCXoACjsV/1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ARG4bkyD; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <16b32b53-5a01-43e8-93db-64778378fa09@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711650197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvccjBgvV8FPnWLETfwa5X6p1gUwr/hfB1axJ8LOH4E=;
	b=ARG4bkyDA/Vzrk5HPV4L8uXDHlS+KGa6BXgc+OWOCZOzz7yMadsTRX1+yWr1QLiRWQXK4Y
	5FJJjHUw4vhZdXTsHFY817EuoGtAsGuiYKpCMm0rH7CZiEEOUgYbNTM2iUAL002W3KPZEb
	LZaNF09ZJ9DXkVnlxWO0mx+/2tPYIlA=
Date: Thu, 28 Mar 2024 11:23:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem
Content-Language: en-US
To: ast@kernel.org, yonghong.song@linux.dev
References: <000000000000c8d6b00614b599a2@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, andrii@kernel.org,
 alexei.starovoitov@gmail.com, bpf@vger.kernel.org,
 syzbot <syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com>
In-Reply-To: <000000000000c8d6b00614b599a2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/28/24 3:01 AM, syzbot wrote:
> Killed
> make[2]: *** [scripts/Makefile.vmlinux_o:62: vmlinux.o] Error 137
> make[2]: *** Deleting file 'vmlinux.o'
> make[1]: *** [/syzkaller/jobs/linux/kernel/Makefile:1141: vmlinux_o] Error 2
> make: *** [Makefile:240: __sub-make] Error 2

My second syzbot test attempt passed the build stage and passed the reproducer 
also. https://lore.kernel.org/all/000000000000b7bdd80614bc433f@google.com/

Not sure what caused the syzbot build error in the first attempt but should be 
unrelated to the fix. I will post the patch.


