Return-Path: <netdev+bounces-300936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cOIQNiCOOGqidgcAu9opvQ
	(envelope-from <netdev+bounces-300936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 03:21:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B08B6ABEEB
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 03:21:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=T9yoE8hC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300936-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300936-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B07D33002892
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 01:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52913243951;
	Mon, 22 Jun 2026 01:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55B24293C
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 01:21:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782091293; cv=none; b=mQJMfxxheFPQvyfSUl2ww+ugiVIlXj90G35CC9hgeoEYk+fKnqzu0bz3UCkYyx5rwWP/XjyxCl1GN3qRaNHYeZxxnIwUH5p0JvXfoQK2y8AVPbBifa+B4BuF0lrexY5lQpo2sYu92rfqnkzsqDK1nA7daQT8yRePyTJZFj1Aj6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782091293; c=relaxed/simple;
	bh=Jmc1eoXsgZDimuJgTelp6JB8lwcJG7/8AmTws2Cg8RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGFVxXV2RMFAUTjSlTo729juV4CdrGNjeER9JGd36kpqxeInjwbYKWUhOlMs/gcEjKP6AQ/eB1/JMDj5bPmFG2bx/3ezhB3aGID0IQiHij5GlQfHNsYdbOIPBSeRpyhLpz7BY28ygmCiq3Qk0YK2hJrZqiApxz2cYVVISyj8bDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T9yoE8hC; arc=none smtp.client-ip=91.218.175.185
Message-ID: <7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782091279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QpWB7h+OAc4xw9YXh649wA7kd08Md/GJlPTwgijKks=;
	b=T9yoE8hCwBtPkDuxJ6uCh0Q1MfjVBZ+b2cspeZ+ElPapbtFlxWZhvf5NU1FvY6WWVoE+Xo
	AP/n0fpxX5T5eSHUiju0lgDpCx/wKZrUyuVXC1XdtH3kAvyFzeuBVTc/NENNlx/95E3xsS
	s9DRXX+Y7R1qhpgZ9EyM2JENFx8Mnqs=
Date: Mon, 22 Jun 2026 09:21:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net, bpf: check master for NULL in
 xdp_master_redirect()
To: Xiang Mei <xmei5@asu.edu>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Jussi Maki <joamaki@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Weiming Shi <bestswngs@gmail.com>
References: <20260620201531.180123-1-xmei5@asu.edu>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260620201531.180123-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300936-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:hawk@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:joamaki@gmail.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B08B6ABEEB


On 6/21/26 4:15 AM, Xiang Mei wrote:
> xdp_master_redirect() dereferences the result of
> netdev_master_upper_dev_get_rcu() without a NULL check, but that helper
> returns NULL when the receiving device has no upper-master adjacency.
>
> The reach guard only checks netif_is_bond_slave(). On bond slave release
> bond_upper_dev_unlink() drops the upper-master adjacency before clearing
> IFF_SLAVE, so an XDP_TX reaching xdp_master_redirect() in that window
> still passes netif_is_bond_slave() while master is already NULL, and
> faults on master->flags at offset 0xb0:
>
>    BUG: kernel NULL pointer dereference, address: 00000000000000b0
>    RIP: 0010:xdp_master_redirect (net/core/filter.c:4432)
>    Call Trace:
>     xdp_master_redirect (net/core/filter.c:4432)
>     bpf_prog_run_generic_xdp (include/net/xdp.h:700)
>     do_xdp_generic (net/core/dev.c:5608)
>     __netif_receive_skb_one_core (net/core/dev.c:6204)
>     process_backlog (net/core/dev.c:6319)
>     __napi_poll (net/core/dev.c:7729)
>     net_rx_action (net/core/dev.c:7792)
>     handle_softirqs (kernel/softirq.c:622)
>     __dev_queue_xmit (include/linux/bottom_half.h:33)
>     packet_sendmsg (net/packet/af_packet.c:3082)
>     __sys_sendto (net/socket.c:2252)
>    Kernel panic - not syncing: Fatal exception in interrupt
>
> The missing check dates back to the original code; commit 1921f91298d1
> ("net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master")
> later added the master->flags read where the fault now lands but kept the
> unconditional deref. Check master for NULL before use; a NULL master is
> treated the same as one that is not up.
>
> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>   net/core/filter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 40037413dd4e..6037860d5283 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4430,7 +4430,7 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
>   	struct net_device *master, *slave;
>   
>   	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> -	if (unlikely(!(master->flags & IFF_UP)))
> +	if (unlikely(!master || !(master->flags & IFF_UP)))
>   		return XDP_ABORTED;


I recall that when I previously modified this code, I removed the 
!master check

because this is on the fastpath. However, since this is a triggerable bug,
I think adding it here is fine.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


