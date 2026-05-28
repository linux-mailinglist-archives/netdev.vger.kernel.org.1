Return-Path: <netdev+bounces-292589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGq3LXL6F2oWXwgAu9opvQ
	(envelope-from <netdev+bounces-292589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:18:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 227455EE6EE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9C823122620
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536F034B68F;
	Thu, 28 May 2026 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dfeszqvy"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36B3164B5
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955744; cv=none; b=BejVjArfIIlSCbCFOjmpMXKRAk75Uo0k4+S2AaDaxS0L0qFCfsBJ9ettXH8OtTlWmvHPBzXK6tpB2YyBm/ySpsfgMb3M2GN+lXLi/vsLbIl7SOQhY9Q6m/tzinnbI9Pb7e82PqmYigfaUfSqONPKxFMg37ahknnCMXh0gjzNv5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955744; c=relaxed/simple;
	bh=ywpSA7iPLGiFlDaipMlZB1GLArQfRZzjT82xD/eSso0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5RQg3gMHqLoAwx2PWZKNYlNW2MfnyJAwQZihu9cGYM82OXiNeUFbPPwbFLoq6RyRFtI+FV1gSer7nXfycn0EBS5LF290w0e7J3ARXJ9ZnxWRYyh2sTAY+zQnCHCFwlrmrQjpBPm6Zb74voHTX58vsLLJwdWb0oJGAvJjAvZgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dfeszqvy; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <35878e67-d83e-4329-8c20-99caf95bbffc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779955730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pB5KWAha1i8/yYBgVT9Debw5k/YWw/CMk+cTddISws=;
	b=dfeszqvyn8pux3MkD92zb9p2j0uhYBuYVSHxNrxhDPxdwxa4f+MBasKwmBA+S6908g8RLo
	t5pK0M7xreqWGLldwvGuXPPg8r7lIqpkoFPKyCJm3Kz1gLEP9mN37aRgdx4dVdjGXvgIic
	1WqGt1bBzRHhr1WxFjVCSsQa2WKgbuk=
Date: Thu, 28 May 2026 16:08:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] netlink: fix skb refcount leak when dump start fails
To: Wentao Liang <vulab@iscas.ac.cn>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Kees Cook <kees@kernel.org>, Feng Yang <yangfeng@kylinos.cn>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260528073614.1169858-1-vulab@iscas.ac.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260528073614.1169858-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292589-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 227455EE6EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/28/26 3:36 PM, Wentao Liang wrote:
> __netlink_dump_start() takes an extra reference on the received skb
> via refcount_inc(&skb->users) before storing it in cb->skb for the
> dump callback to consume. If the subsequent netlink_dump() call fails
> (line 2440), the dump was never started so the completion callback
> that would normally release cb->skb will never be invoked.
>
> In this case, the function returns the error directly without calling
> kfree_skb(skb) to release the extra reference taken at entry.
>
> Add kfree_skb(skb) before returning when netlink_dump() fails, so the
> skb reference is properly released.
>
> Fixes: b44d211e166b ("netlink: handle errors from netlink_dump()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   net/netlink/af_netlink.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 2aeb0680807d..d904c1aad35d 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2441,8 +2441,10 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
>   
>   	sock_put(sk);
>   
> -	if (ret)
> +	if (ret) {
> +		kfree_skb(skb);
>   		return ret;
> +	}
>   
>   	/* We successfully started a dump, by returning -EINTR we
>   	 * signal not to send ACK even if it was requested.

static int netlink_release(struct socket *sock) {

     .......

     /* Terminate any outstanding dump */
     if (nlk->cb_running) {
         if (nlk->cb.done)
             nlk->cb.done(&nlk->cb);
         module_put(nlk->cb.module);
         kfree_skb(nlk->cb.skb);  <---- freed here
         WRITE_ONCE(nlk->cb_running, false);
     }

     ......

}


