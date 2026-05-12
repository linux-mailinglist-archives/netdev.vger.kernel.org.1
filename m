Return-Path: <netdev+bounces-287040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLXNCD33AmrezAEAu9opvQ
	(envelope-from <netdev+bounces-287040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:47:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8243F51E06E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FBA13009508
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5532D2F90C9;
	Tue, 12 May 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AgHAkiT7"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E980B28C2A1
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579258; cv=none; b=OR65L/i9mQC6STL2a+fLouCu8EYgN4Bw5u2gY4hPuHJbc0QGMwpeFwCwTTWmsMEf55wd5U6my5zI8aw0kTtn4oGhfX/+nk+I0I35uDVkcivtJZtVnuRYtS89zh0b4os3NTQIhaFK8lG5cNLYRBTfrTmvfwxwWdNjGfu6DSkGSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579258; c=relaxed/simple;
	bh=oP+lMTpCs/MmCwIYHBt69Rx7OGgXh1o1Niw4wj3xXv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJd+/EodJCKdaat4wuHiXxEXpE8Pzi1+yq/GiuwVCN7y70IyzKwMF18/8UpDY6/VQ2RMjg2vpMs2YInAchjVUeLF44If0XUqBsSivGHwY8Gnm59Re/yxkJ6BlmnC9f86z6CItrX9K3ppKlSZfw/YzYTsmsc6m9QeJHnVgk6RQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AgHAkiT7; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e683a7db-b465-4b34-b002-8f22031c77ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778579253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvrH+Ii9BjHSgJDxxEyJuHR+FWTHspsLDdnJSbT4jsE=;
	b=AgHAkiT7KixQP/FeD0poHKsx5Dep01WrHLXHY434tmofh2griLBM+z7tLjN/RTd0qLAdee
	SOAUP0TwZ2xxb/j75elDqp8wnaAsozzfA8zqPSsAOV2wUO2jUgQPYKqqiL0KIOJN9DYTdy
	bhpJniS6bqnmABez6b8u8oMg2Y3WjpE=
Date: Tue, 12 May 2026 17:47:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 3/4] net: tls: fix use-after-free in
 tls_sw_sendmsg_locked after bpf verdict
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, sd@queasysnail.net,
 john.fastabend@gmail.com, bpf@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260511174920.433155-1-kuba@kernel.org>
 <20260511174920.433155-4-kuba@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260511174920.433155-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8243F51E06E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,queasysnail.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-287040-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action


On 5/12/26 1:49 AM, Jakub Kicinski wrote:
> bpf_exec_tx_verdict() may return having modified the record
> and the plaintext/encrypted sk_msg pointers. We must always
> reload those pointers after calling bpf_exec_tx_verdict().
>
> On the wait_for_memory path after sk_stream_wait_memory() returns,
> the post-wait contains a shortcut:
>
> 	if (ctx->open_rec && msg_en->sg.size < required_size)
> 		goto alloc_encrypted;
>
> which dereferences the cached msg_en, which can equally point at
> a freed record if the prior bpf_exec_tx_verdict() split the open
> rec before returning -ENOMEM. Drop the shortcut it seems to have
> only been an optimization to skip trivial intro of the loop.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")


Is the blamed commit correct? I don't think I touched the following code 
in this commit.

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   net/tls/tls_sw.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 3bfdaf5e64f5..360f71fd7884 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1112,7 +1112,6 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>   		if (!sk_stream_memory_free(sk))
>   			goto wait_for_sndbuf;
>   
> -alloc_encrypted:
>   		ret = tls_alloc_encrypted_msg(sk, required_size);
>   		if (ret) {
>   			if (ret != -ENOSPC)
> @@ -1255,9 +1254,6 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>   				tls_trim_both_msgs(sk, orig_size);
>   			goto send_end;
>   		}
> -
> -		if (ctx->open_rec && msg_en->sg.size < required_size)
> -			goto alloc_encrypted;
>   	}
>   
>   send_end:

