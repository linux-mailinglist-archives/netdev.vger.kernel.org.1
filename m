Return-Path: <netdev+bounces-163407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB0A2A30D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE69F1888026
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183DE2253EB;
	Thu,  6 Feb 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SpY9qOH9"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F771514EE;
	Thu,  6 Feb 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738829997; cv=none; b=VhgIQnk7D+9ycjhheyMQ68S4nHup8qnIqTSTOOkFP27gWF3AqSjkB41vwrwOZm4Jx6t6jzStMajdr+C+e5FPFj1Bc7bBgocVTrOi9pqaMvDlZgtgrmCKPP99qbSKcdqxc3CEjZ3MCdfNJzNnXfywG2GDu+GyUsXU5pzpOpwaNvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738829997; c=relaxed/simple;
	bh=L2gRW3mtn0VGLqNQM3n3c5dJ/52SMjaCVKCH6Z4OBLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLfaR0qmAmhVn5FhxLkCR71FBg+mBzhgy667102ZTeU7iZRzHWRe8hSfmw4Y92gCEX88AKQ5HjpwVeoftskk/OcjLcrxZIkOZ3rQ+pQCdAieEKoeQg39KAxILPQ3Jo/qXDS+z1bKA8KU77PiFGLS3PB7TGCTNQpc6jweLmuGqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SpY9qOH9; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=IJBf8XNwOo6fri2pdrpCdLIWZKkprwxpUeN1DLP/Kbc=;
	b=SpY9qOH9VUpshaAYhfV2V0uRz45uoJl0VptqXXBb2HiV1y6HosohbNPC3i68r7
	7Kd759O8vW2IPVPjbB+U9MFEYofayMvN6N4ty9vsG0FGySViaDB7YsXiXI19kFzP
	vXb/ge//rdGM5kPayH1uE0o3hZjcSIwYkTv3jgWQgw/M4=
Received: from hello.company.local (unknown [111.205.82.7])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnN+R6cKRnk1MLNA--.58315S2;
	Thu, 06 Feb 2025 16:19:08 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: buaajxlj@163.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	liangjie@lixiang.com,
	linux-kernel@vger.kernel.org,
	mhal@rbox.co,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2] af_unix: Refine UNIX pathname sockets autobind identifier length
Date: Thu,  6 Feb 2025 16:19:05 +0800
Message-Id: <20250206081905.83029-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206054451.4070941-1-buaajxlj@163.com>
References: <20250206054451.4070941-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnN+R6cKRnk1MLNA--.58315S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1kWw1fCr4fWFW5ZFykAFb_yoWrZr1DpF
	Z5K34DZrZ8Jr47Wr4xta18Crs3ta1rJ34UCrWxW3WF9F42grW8GF1kKF4jg34DGrWxtw1a
	qF4UK3ZruFyDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUx-BtUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbiNgTrIGekZbKgOQAAs0

Hi Kuniyuki,

The logs from 'netdev/build_allmodconfig_warn' is as follows:
  ../net/unix/af_unix.c: In function ‘unix_autobind’:
  ../net/unix/af_unix.c:1222:52: warning: ‘snprintf’ output truncated before the last format character [-Wformat-truncation=]
   1222 |         snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
        |                                                    ^
  ../net/unix/af_unix.c:1222:9: note: ‘snprintf’ output 6 bytes into a destination of size 5
   1222 |         snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

snprintf() also append a trailing '\0' at the end of the sun_path.

Now, I think of three options. Which one do you think we should choose?

1. Allocate an additional byte during the kzalloc phase.
	addr = kzalloc(sizeof(*addr) + offsetof(struct sockaddr_un, sun_path) +
		       UNIX_AUTOBIND_LEN + 1, GFP_KERNEL);

2. Use temp buffer and memcpy() for handling.

3. Keep the current code as it is.

Do you have any other suggestions?

Best regards,
Liang

> From: Liang Jie <liangjie@lixiang.com>
> 
> Refines autobind identifier length for UNIX pathname sockets, addressing
> issues of memory waste and code readability.
> 
> The previous implementation in the unix_autobind function of UNIX pathname
> sockets used hardcoded values such as 16 and 6 for memory allocation and
> setting the length of the autobind identifier, which was not only
> inflexible but also led to reduced code clarity. Additionally, allocating
> 16 bytes of memory for the autobind path was excessive, given that only 6
> bytes were ultimately used.
> 
> To mitigate these issues, introduces the following changes:
>  - A new macro UNIX_AUTOBIND_LEN is defined to clearly represent the total
>    length of the autobind identifier, which improves code readability and
>    maintainability. It is set to 6 bytes to accommodate the unique autobind
>    process identifier.
>  - Memory allocation for the autobind path is now precisely based on
>    UNIX_AUTOBIND_LEN, thereby preventing memory waste.
>  - To avoid buffer overflow and ensure that only the intended number of
>    bytes are written, sprintf is replaced by snprintf with the proper
>    buffer size set explicitly.
> 
> The modifications result in a leaner memory footprint and elevated code
> quality, ensuring that the functional aspect of autobind behavior in UNIX
> pathname sockets remains intact.
> 
> Signed-off-by: Liang Jie <liangjie@lixiang.com>
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> 
> Changes in v2:
>  - Removed the comments describing AUTOBIND_LEN.
>  - Renamed the macro AUTOBIND_LEN to UNIX_AUTOBIND_LEN for clarity and
>    specificity.
>  - Corrected the buffer length in snprintf to prevent potential buffer
>    overflow issues.
>  - Addressed warning from checkpatch.
>  - Link to v1: https://lore.kernel.org/all/20250205060653.2221165-1-buaajxlj@163.com/
> 
>  net/unix/af_unix.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 34945de1fb1f..6c449f78f0a6 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1186,6 +1186,8 @@ static struct sock *unix_find_other(struct net *net,
>  	return sk;
>  }
>  
> +#define UNIX_AUTOBIND_LEN 6
> +
>  static int unix_autobind(struct sock *sk)
>  {
>  	struct unix_sock *u = unix_sk(sk);
> @@ -1203,12 +1205,12 @@ static int unix_autobind(struct sock *sk)
>  		goto out;
>  
>  	err = -ENOMEM;
> -	addr = kzalloc(sizeof(*addr) +
> -		       offsetof(struct sockaddr_un, sun_path) + 16, GFP_KERNEL);
> +	addr = kzalloc(sizeof(*addr) + offsetof(struct sockaddr_un, sun_path) +
> +			UNIX_AUTOBIND_LEN, GFP_KERNEL);
>  	if (!addr)
>  		goto out;
>  
> -	addr->len = offsetof(struct sockaddr_un, sun_path) + 6;
> +	addr->len = offsetof(struct sockaddr_un, sun_path) + UNIX_AUTOBIND_LEN;
>  	addr->name->sun_family = AF_UNIX;
>  	refcount_set(&addr->refcnt, 1);
>  
> @@ -1217,7 +1219,7 @@ static int unix_autobind(struct sock *sk)
>  	lastnum = ordernum & 0xFFFFF;
>  retry:
>  	ordernum = (ordernum + 1) & 0xFFFFF;
> -	sprintf(addr->name->sun_path + 1, "%05x", ordernum);
> +	snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
>  
>  	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
>  	unix_table_double_lock(net, old_hash, new_hash);
> -- 
> 2.25.1


