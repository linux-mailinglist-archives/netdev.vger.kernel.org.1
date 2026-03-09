Return-Path: <netdev+bounces-265455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNiXEcCZrmmqGgIAu9opvQ
	(envelope-from <netdev+bounces-265455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:58:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B491C236A7F
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D56630088B6
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 09:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888E3859C6;
	Mon,  9 Mar 2026 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CDbOn1tZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC473815E6
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050286; cv=none; b=IB+Lq8CeUz/erPejUApubSeTyO6rQlqQheeIs2LFP6TyydIO32yYBw3arx9iDDVTyd2ZE6EWNt28HSN2pk06kOletjVCS2o0xudMWJ2B3CootKiLhTO2jpAdNPkAEfW7hgys79MiH2C+THVlTVz6He7+/HOQA1+GX1ppFWslrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050286; c=relaxed/simple;
	bh=/cusK6uUT0tB3v/1gQr2okzkXaL3CNhhf8xkPa+xN90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1GM6qQmSQs61QScLWGTEle/wrSOFtEkE2I+fLlu57J4ytkNfmOQANExCRj2sp4LjGUSfP/742F96kDIWImwi/KYQmNy4C7rAhSrcl7DRVegFVl6QzfJtVeb1o1Ei68RWL9SA7p/KK7L1FVmpiBG9BZ2FVCvNrGiA3aAKtjZ8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CDbOn1tZ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 9 Mar 2026 17:57:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773050273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TceeNjJusAWfwGzlU79ZpIWRyKWKQ7R2YG/ZX3AO7Mk=;
	b=CDbOn1tZ12NrfcxllHrmHj9vJ48ou4Ytjo3669DTy4tHZb31I4VWaXjp1Dg6EmGcYuK1Zj
	9b4GldZx04JMtngQEGzR78KwiSg7OzJs33DViyWO3EJiRNVJfDZXlDJ1UCqCnLHTGtrTQ/
	kFxClFn9dPTK7kAvm8N5hJot8J0bYeM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kees@kernel.org, mingo@kernel.org, 
	tglx@kernel.org, jiayuan.chen@shopee.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+f50072212ab792c86925@syzkaller.appspotmail.com, 
	jiayuan.chen@linux.dev
Subject: Re: [PATCH] atm: lec: fix use-after-free in sock_def_readable()
Message-ID: <jx557w6llomwcm2tbwz7u74get3uvl4ebo3x2gvhghlfsjd67m@76yu4bwvcdhv>
References: <20260309093614.502094-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309093614.502094-1-kartikey406@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B491C236A7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265455-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 03:06:14PM +0800, Deepanshu Kartikey wrote:
> A race condition exists between lec_atm_close() setting priv->lecd = NULL
> and concurrent access to priv->lecd in send_to_lecd(), lec_handle_bridge(),
> and lec_atm_send(). When the socket is freed via RCU while another thread
> is still using it, a use-after-free occurs in sock_def_readable() when
> accessing the socket's wait queue.
> 
> The root cause is that lec_atm_close() clears priv->lecd without holding
> lec_arp_lock, while callers dereference priv->lecd without any protection
> against concurrent teardown.
> 
> Fix this by:
> - Protecting priv->lecd = NULL in lec_atm_close() with lec_arp_lock to
>   synchronize with callers that already hold the lock (e.g. lec_arp_resolve)
> - Using sock_hold/sock_put in send_to_lecd() to pin the socket while in
>   use. This is safe because send_to_lecd() is called under lec_arp_lock
>   by lec_arp_resolve(), preventing concurrent NULL assignment of lecd.
> - Using lec_arp_lock + sock_hold/sock_put in lec_handle_bridge() and
>   lec_atm_send() where the lock is not held by the caller, with proper
>   skb cleanup on early exit to avoid memory leaks.

This is wrong. send_to_lecd() is also called from lec_arp_expire_arp() without lec_arp_lock.
  lec_arp_expire_arp()        // no lec_arp_lock held
    → send_to_lecd()
      → sk = sk_atm(priv->lecd)  // UAF: lecd already freed
      → sock_hold(sk)             // too late

The sock_hold() is placed after the dereference of priv->lecd,
so it cannot prevent the UAF — the dangling pointer has already been followed.

> Note: Patch testing via syzbot was attempted but the test VM crashed
> due to a QEMU AHCI emulation assertion failure (hw/ide/core.c:934)
> unrelated to this fix. The QEMU crash is caused by syzbot's disk I/O
> fuzzing triggering a known QEMU NCQ emulation bug, not by this patch.
> Compile testing with "make W=1 net/atm/lec.o" passes cleanly.
> 
> Reported-by: syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f50072212ab792c86925
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  net/atm/lec.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index fb93c6e1c329..7e051174a92b 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c
> @@ -131,6 +131,7 @@ static void lec_handle_bridge(struct sk_buff *skb, struct net_device *dev)
>  {
>  	char *buff;
>  	struct lec_priv *priv;
> +	unsigned long flags;
>  
>  	/*
>  	 * Check if this is a BPDU. If so, ask zeppelin to send
> @@ -154,10 +155,19 @@ static void lec_handle_bridge(struct sk_buff *skb, struct net_device *dev)
>  					/* 0x01 is topology change */
>  
>  		priv = netdev_priv(dev);
> -		atm_force_charge(priv->lecd, skb2->truesize);
> +		spin_lock_irqsave(&priv->lec_arp_lock, flags);
> +		if (!priv->lecd) {
> +			spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
> +			kfree_skb(skb2);
> +			return;
> +		}
>  		sk = sk_atm(priv->lecd);
> +		sock_hold(sk);
> +		spin_unlock_irqrestore(&priv->lec_arp_lock, flags);
> +		atm_force_charge(priv->lecd, skb2->truesize);

After the unlock, lec_atm_close() can set priv->lecd = NULL


