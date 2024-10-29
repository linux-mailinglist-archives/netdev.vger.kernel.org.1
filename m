Return-Path: <netdev+bounces-140153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C059B563F
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5019D1F23B8B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39A820A5C1;
	Tue, 29 Oct 2024 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FaqYUbxU"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7320ADDE
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242836; cv=none; b=eXq+Z6jKnu6OzwSsEq2EiO5xOWq8W9Oe+LGDFkEzxGFfc4S4keo4P09R1DJOEFJeMzStUxHtyp4GjrkRjdjLVEg5lDtpK3VNc0vN0LKpER2hjLwnJreeKb6U7y0tARx6iJ3ZZ0AWaDlFCFM+7h6of5a6KMJrFYOLOVrz+YWaDrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242836; c=relaxed/simple;
	bh=FG7qZ9bNf5nLBm4jChJHcLpYejOcoirdg+mQHf3sgHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmH6zsC0KV4Rk2bNY22nlU6pPDLf7tnPMLrFQ8MOo0pDVGhbT+uodt7qEPZEE+vSuom+yDRiljVbTBLEVtk7QRstS913qv5Gc6lMS2C/FNzBbhAUGTXfgZFAHQ/mDMW+2gMApNSFwguAsqJPWh6SZe2TDUHC62QF8dC/CkGkQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FaqYUbxU; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730242830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sm9pdbN2CDCBpUdKeKObOpOza7qZjP6o3Dnd+2Pasd8=;
	b=FaqYUbxUcZtS4Yxt8rueoh5kScw4NTxb2auaDHwTuUwbEqoxPj/00fdHUw2E1QHD2xoFLy
	wNKgGFNaVIBEoTYKFILv2odpDX2K2dxEFoyi+Cb3si0D5lMcDuqFlVCpp3r2WQi2r5D3Bi
	nqkPjD40spzTHealghAowM4jZ7X5UNc=
Date: Tue, 29 Oct 2024 16:00:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Jason Xing <kerneljasonxing@gmail.com>, willemb@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, ykolal@fb.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241028110535.82999-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/28/24 4:05 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch has introduced a separate sk_tsflags_bpf for bpf
> extension, which helps us let two feature work nearly at the
> same time.
> 
> Each feature will finally take effect on skb_shinfo(skb)->tx_flags,
> say, tcp_tx_timestamp() for TCP or skb_setup_tx_timestamp() for
> other types, so in __skb_tstamp_tx() we are unable to know which
> feature is turned on, unless we check each feature's own socket
> flag field.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   include/net/sock.h |  1 +
>   net/core/skbuff.c  | 39 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 7464e9f9f47c..5384f1e49f5c 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -445,6 +445,7 @@ struct sock {
>   	u32			sk_reserved_mem;
>   	int			sk_forward_alloc;
>   	u32			sk_tsflags;
> +	u32			sk_tsflags_bpf;
>   	__cacheline_group_end(sock_write_rxtx);
>   
>   	__cacheline_group_begin(sock_write_tx);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 1cf8416f4123..39309f75e105 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5539,6 +5539,32 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>   }
>   EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
>   
> +/* This function is used to test if application SO_TIMESTAMPING feature
> + * or bpf SO_TIMESTAMPING feature is loaded by checking its own socket flags.
> + */
> +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, int tstype)
> +{
> +	u32 testflag;
> +
> +	switch (tstype) {
> +	case SCM_TSTAMP_SCHED:
> +		testflag = SOF_TIMESTAMPING_TX_SCHED;
> +		break;
> +	case SCM_TSTAMP_SND:
> +		testflag = SOF_TIMESTAMPING_TX_SOFTWARE;
> +		break;
> +	case SCM_TSTAMP_ACK:
> +		testflag = SOF_TIMESTAMPING_TX_ACK;
> +		break;
> +	default:
> +		return false;
> +	}
> +	if (tsflags & testflag)
> +		return true;
> +
> +	return false;
> +}
> +
>   static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
>   				 const struct sk_buff *ack_skb,
>   				 struct skb_shared_hwtstamps *hwtstamps,
> @@ -5549,6 +5575,9 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
>   	u32 tsflags;
>   
>   	tsflags = READ_ONCE(sk->sk_tsflags);
> +	if (!sk_tstamp_tx_flags(sk, tsflags, tstype))

I still don't get this part since v2. How does it work with cmsg only 
SOF_TIMESTAMPING_TX_*?

I tried with "./txtimestamp -6 -c 1 -C -N -L ::1" and it does not return any tx 
time stamp after this patch.

I am likely missing something
or v2 concluded that this behavior change is acceptable?

> +		return;
> +
>   	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
>   	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
>   		return;
> @@ -5592,6 +5621,15 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
>   	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
>   }
>   
> +static void skb_tstamp_tx_output_bpf(struct sock *sk, int tstype)
> +{
> +	u32 tsflags;
> +
> +	tsflags = READ_ONCE(sk->sk_tsflags_bpf);
> +	if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
> +		return;
> +}
> +
>   void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   		     const struct sk_buff *ack_skb,
>   		     struct skb_shared_hwtstamps *hwtstamps,
> @@ -5600,6 +5638,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   	if (!sk)
>   		return;
>   
> +	skb_tstamp_tx_output_bpf(sk, tstype);
>   	skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
>   }
>   EXPORT_SYMBOL_GPL(__skb_tstamp_tx);


