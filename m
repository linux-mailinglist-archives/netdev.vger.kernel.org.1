Return-Path: <netdev+bounces-256785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIOEH6KCg2llowMAu9opvQ
	(envelope-from <netdev+bounces-256785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:32:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF5FEB021
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59BAA30305F4
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DA634AAF7;
	Wed,  4 Feb 2026 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFrkW+wL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E4349AF5
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226251; cv=none; b=OYvCj2mB55/PTZsMXKrUAc/KYbij3UgW57chkOnzbX7hQO+e9bGFvLOnvhuMaecXhK2Tcr3TCG6WGSbbdoJPfdRFV1C89q4c2U3xzLVf/+aU/qg8rrofwaXYkPykd46tFUDLpOhdsMRCLDAH/YVcsqpF8C630P9M+WTVkrchY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226251; c=relaxed/simple;
	bh=MDU5QO/Tn+WPiQlwRtuHo6iLlQ4fMKYFMHh7UOwEXdI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CVA3M40G8LI3WVh5GVyaX3vVIro+4EsRXVa/0Ys3B/6g/8Km4ZuGfkTY1xo9pADsFyDkd2lieo+SubvkraKAE2Q2UaesxF1PwyJ0D4x/p01nWgmSxIL/YnYVT6n+QKgQTvdJ/K6g0HIEHQ27we/oPFu2K2rWSmk+RNpRrxv/zo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFrkW+wL; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79456d5ebf9so71466597b3.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 09:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770226250; x=1770831050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDRlBfoRYtGK+4GBi1eow20sQAIRQFdvRCCoMgcrxo4=;
        b=UFrkW+wLyUtS1nFLbsO55FTR55NIpOvH4PiyRVPd+gC++MHzrzbYdUJvW7rb0ogOe0
         sRCmJmnaCpru0cKzT7v4fPgqCy/OGx5JARUz0AnJYTUsHGDKNMbXiaYRXC31bQmN+pW2
         VJe8IHAVe77XC1jn5kZNyWt2t8hcK6T47YkD30gLfsloevzC8Cxdoml5aYQH6cVHb2xk
         izQdeXpoMyAs+hqAvutmb1lxN87nfnIJq5QE284kShZjbDweUmVhwSn8T1k7KX6K0zGr
         oVGixXSWczzcbqfrc5/sjkGoeHhpvWfgAiTRp02l3zPuCwkXjQGvXe66MaiVyRBpUB87
         YmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770226250; x=1770831050;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDRlBfoRYtGK+4GBi1eow20sQAIRQFdvRCCoMgcrxo4=;
        b=lTuKPX9jwrFbJeW7Xv28tMVd/DUZMPYNW3pFv6P2lZ3xgsO8GdBBvex2QcZNEHcHu/
         hi9amO3RmMYRNTi2EcndaEX/+0w31Mdx/WUKKl1kVJjCiJsJ3iflCPYMH3spYc3JUXU8
         2vuwOgGfhcJy0QnobS2SFjjLRXiMxDyQR5fHaKb+DwOcXEeYQSKIy2x7jB7gT1W4UpVQ
         aDMiHltf70BQbNrndIii/v0g24J55rO+fdF43YFIYFtpeGTjUrf8HOn6HUNI4DBGTd/R
         2IdXCVPTtxLRJ1aYlpyAoIQki83hWy6uoFXVOlCjSiijbQKYW6rr5c+5P231ZYHv+KYb
         6qvw==
X-Forwarded-Encrypted: i=1; AJvYcCWZfdg5Kbvl1MqA+9IDCv14+OQoX8m8nBgRQhTpgIT89B7E49CwAWG6eib9/ZmM1dhF0YePq9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+40jSrySz0MuO+wwQDeXLQlB9jEW/HgDA9ussm9y5uzqYzI3
	w6TfkvjoZfTf8RJW9U0uY4R6l8SG47FoYFsUUoVoi6JZ/YNtI/2tzORu
X-Gm-Gg: AZuq6aJNuzljjEkWCFD6eoNtXx+5JVgPLNOhNsPQFTIrJhL+wV0bgNFzqgvnmTUUs+f
	dhQMjQVa2vJi9pTFlYlo+6EaQtn25th7HIjvyA00kY/mms0LRtcrvRwWtuAxsVqvRoSpw4Af0Am
	T8ClWbzwsvZ7AIyB98t9qHA+uIZmgXuWOoZ1WU/EfGXm9LVRwcuKzLWun1mdEdNqEFP8rSsaUoN
	kG1HTGG3vU6n3Il5yOV6QlutjNSciQRxIbxtjYRUmYi7oXh1GewN1nnC6O/H4ggFdGktCnmVKLy
	3FXb/l3r3U0JygRKvpcNt/kGdRPmqh4VbK3mbmfKJJPCr488yatU4xFcVprOEt2Yoj37DGhfXZ5
	4SuL3UcUdkpcqVf/0TH1DFK6jAMym3j9y8aFyHuaTN//mO9wyjLAmiH1fD15t4Se8dzg61rLiKf
	Pqte+ttIu7PN5IEpHwqrcxyKtEAfYtQ00wDmA2biIq1sqGtVeZocSXWZq8jXB89naZVfUdXQ==
X-Received: by 2002:a05:690c:91:b0:794:e839:ad75 with SMTP id 00721157ae682-794fe73f8bdmr35874807b3.42.1770226249676;
        Wed, 04 Feb 2026 09:30:49 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794fefe86e2sm25958327b3.45.2026.02.04.09.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:30:48 -0800 (PST)
Date: Wed, 04 Feb 2026 12:30:47 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <willemdebruijn.kernel.2d4b5c08dd442@gmail.com>
In-Reply-To: <20260204-hsr_ptp-v1-1-b421c69a77da@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <20260204-hsr_ptp-v1-1-b421c69a77da@linutronix.de>
Subject: Re: [PATCH RFC net-next 1/2] hsr: Allow to send a specific port and
 with HSR header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-256785-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CAF5FEB021
X-Rspamd-Action: no action

Sebastian Andrzej Siewior wrote:
> HSR forwards all packets it received on slave port A to slave port B and
> one of the possible two copies to the user (master) interface.
> In terms of PTP this is not good because the latency introduced by
> forwarding makes the timestamp in the PTP packet inaccurate.
> 
> Introduce a hsr_ptp field to struct skb_shared_info which can be used to
> store HSR specific information for sending and receiving skbs.
> 
> Receive (slave ports):
> - HSR_PT_SLAVE_A/ HSR_PT_SLAVE_B to denote the port which received the
>   packet. This information is only added to PTP packets.
> 
> Send (master port):
> - HSR_PT_SLAVE_A/ HSR_PT_SLAVE_B to denote the port on which the packet
>   has to be sent.
> - HSR_SKB_INCLUDES_HEADER to denote that the packet already contains a
>   HSR header and the stack must not add the system's header to it.
> 
> HSR_SKB_INCLUDES_HEADER is used to allow forwarding a PTP packet and
> preserving the HSR header by the sender.
> Cloning skbs requires to preserve the socket information so that a PTP
> timestamp can be associated with the socket.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/if_hsr.h |   2 +
>  include/linux/skbuff.h |   1 +
>  net/hsr/hsr_device.c   |   7 +++
>  net/hsr/hsr_forward.c  | 114 ++++++++++++++++++++++++++++++++++++++++++++++---
>  net/hsr/hsr_slave.c    |  16 +++++++
>  5 files changed, 133 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
> index f4cf2dd36d193..1463ddbc8cddf 100644
> --- a/include/linux/if_hsr.h
> +++ b/include/linux/if_hsr.h
> @@ -22,6 +22,8 @@ enum hsr_port_type {
>  	HSR_PT_PORTS,	/* This must be the last item in the enum */
>  };
>  
> +#define HSR_SKB_INCLUDES_HEADER		(1 << 4)
> +
>  /* HSR Tag.
>   * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype = 0x88FB,
>   * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 86737076101d4..52c847e490ee8 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -605,6 +605,7 @@ struct skb_shared_info {
>  	};
>  	unsigned int	gso_type;
>  	u32		tskey;
> +	u32		hsr_ptp;

skb_shared_info cannot easily be expanded.

This is too specific a use-case to warrant fields in every packet.

I'm not super familiar with High-availability Seamless Redundancy
(HSR). Perhaps you can use either an skb_extension. Or the skb->cb[]
field if this data is only needed within the HSR protocol logic, so
can be assured to not be overwritten by other users of the control
block.

