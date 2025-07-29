Return-Path: <netdev+bounces-210798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61D6B14DAD
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 14:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A3D542855
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 12:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C31DE891;
	Tue, 29 Jul 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atw9v4si"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C899217733
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792303; cv=none; b=R8aeqt3DNAzGspl5mi8dgNyPbJcvDH7MUKj4DtCtX0v73TRR6hgGodxJ2snvOJgZJ7+EnSTo+ApfR4AFwckNiLn/CrLpOBMLqkoquSZkdFkNNjYBvMPDarPdgtbLiyGVCkqJLPCmp0jwp7eV83jGcEA0cb4hwbAiwBRZmfWxx+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792303; c=relaxed/simple;
	bh=nl0fyWQvOAkEbP3iJvLPQhUb05DrsY9QSeYHW7HOYSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSdlsOGSKgg5jq6DacYLcBQhDqRdhA1LBZzh1AJMXGslGZpoeoJItFNSNkOPG8tQXutMKL8rgJiDfo+mbIwwq4A7Inn9qiBtLpUJapcLR744ser0FZnpRp1FZoVeBwW1rDW8hVFe0BtBIZStQVdAK+NBf3zxn53OVSTof9KMqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atw9v4si; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753792301; x=1785328301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nl0fyWQvOAkEbP3iJvLPQhUb05DrsY9QSeYHW7HOYSQ=;
  b=atw9v4siiqVziR00VeRtvnuvlqeJbeR5LhYaO9GnAD9UnCGjOdFJTCTK
   TbagO27kDz/ZmIoXJzoUZVn6I5UFkBmJS3bSptJIkbbfp4mM0/MIEHPp0
   wpLaloH4T6il7LHuwt8+E5MoCFM8SeN4ng/vBOaPpC09f37RQq7n5E0UA
   Lw7e98uKt/1DKoRCVUJMbaVK3hW8dY/gzIPxTnBN7mRS+rOgmbHmYKRqY
   JgNkmBIm7OGw5fKGz0ISdIGjFfNyCXkzMMK08qPn0/FFC2dCAJiLaY6/c
   s6/bdj9TJnjBGv7KFGxxpA01iK+Op8HcymMhXEwVjGO65zW/f2NNGLczL
   g==;
X-CSE-ConnectionGUID: OPmdg9OlTreCgloSL21kMA==
X-CSE-MsgGUID: NTq5qnzhTEitLWPxVf78cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56206115"
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="56206115"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 05:31:41 -0700
X-CSE-ConnectionGUID: kwnYKFu/Sbuum6SZWzDa1g==
X-CSE-MsgGUID: DF1X1T7tS1eP5oPRPJ5PtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="199840143"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.57]) ([172.28.180.57])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 05:31:39 -0700
Message-ID: <3c785bf4-b4b3-41ee-b0c3-5c3bfb4555f1@linux.intel.com>
Date: Tue, 29 Jul 2025 14:31:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pptp: ensure minimal skb length in pptp_xmit()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+afad90ffc8645324afe5@syzkaller.appspotmail.com
References: <20250729080207.1863408-1-edumazet@google.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250729080207.1863408-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-29 10:02 AM, Eric Dumazet wrote:
> Commit aabc6596ffb3 ("net: ppp: Add bound checking for skb data
> on ppp_sync_txmung") fixed ppp_sync_txmunge()
> 
> We need a similar fix in pptp_xmit(), otherwise we might
> read uninit data as reported by syzbot.
> 
> BUG: KMSAN: uninit-value in pptp_xmit+0xc34/0x2720 drivers/net/ppp/pptp.c:193
>    pptp_xmit+0xc34/0x2720 drivers/net/ppp/pptp.c:193
>    ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2290 [inline]
>    ppp_input+0x1d6/0xe60 drivers/net/ppp/ppp_generic.c:2314
>    pppoe_rcv_core+0x1e8/0x760 drivers/net/ppp/pppoe.c:379
>    sk_backlog_rcv+0x142/0x420 include/net/sock.h:1148
>    __release_sock+0x1d3/0x330 net/core/sock.c:3213
>    release_sock+0x6b/0x270 net/core/sock.c:3767
>    pppoe_sendmsg+0x15d/0xcb0 drivers/net/ppp/pppoe.c:904
>    sock_sendmsg_nosec net/socket.c:712 [inline]
>    __sock_sendmsg+0x330/0x3d0 net/socket.c:727
>    ____sys_sendmsg+0x893/0xd80 net/socket.c:2566
>    ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
>    __sys_sendmmsg+0x2d9/0x7c0 net/socket.c:2709
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+afad90ffc8645324afe5@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/68887d86.a00a0220.b12ec.00cd.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   drivers/net/ppp/pptp.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
> index 5feaa70b5f47e6cd33fbaff33f6715f42c4d71b5..4cd6f67bd5d3520308ee4f8d68547a1bc8a7bfd3 100644
> --- a/drivers/net/ppp/pptp.c
> +++ b/drivers/net/ppp/pptp.c
> @@ -159,9 +159,7 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
>   	int len;
>   	unsigned char *data;
>   	__u32 seq_recv;

nit: the declarations do not follow RCT, but I guess it might be 
additional churn to reorder in this patch

> -
> -
> -	struct rtable *rt;
> +	struct rtable *rt = NULL;
>   	struct net_device *tdev;
>   	struct iphdr  *iph;
>   	int    max_headroom;
> @@ -179,16 +177,20 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
>   
>   	if (skb_headroom(skb) < max_headroom || skb_cloned(skb) || skb_shared(skb)) {
>   		struct sk_buff *new_skb = skb_realloc_headroom(skb, max_headroom);
> -		if (!new_skb) {
> -			ip_rt_put(rt);
> +
> +		if (!new_skb)
>   			goto tx_error;
> -		}
> +
>   		if (skb->sk)
>   			skb_set_owner_w(new_skb, skb->sk);
>   		consume_skb(skb);
>   		skb = new_skb;
>   	}
>   
> +	/* Ensure we can safely access protocol field and LCP code */
> +	if (!pskb_may_pull(skb, 3))
> +		goto tx_error;
> +
>   	data = skb->data;
>   	islcp = ((data[0] << 8) + data[1]) == PPP_LCP && 1 <= data[2] && data[2] <= 7;
>   
> @@ -262,6 +264,7 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
>   	return 1;
>   
>   tx_error:
> +	ip_rt_put(rt);
>   	kfree_skb(skb);
>   	return 1;
>   }

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid


