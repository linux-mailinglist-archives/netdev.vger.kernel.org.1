Return-Path: <netdev+bounces-201291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E9CAE8C9B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0A97B023F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F7C2D9EF6;
	Wed, 25 Jun 2025 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKwRgoYE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABA11519B9;
	Wed, 25 Jun 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876559; cv=none; b=eVLByOMwbqHmInUnHYPnQzAIND1BijNA+vffs98nsnxPD0m7HwRwgXtF3SETmbDNNxi19Vvk0Kd4QJd20lmxWhICzhxGAGcUTnlHWmFAM2B/WMtZFKd525XMsuwP0wqCecXMEqMBsaqw9NfDJgsImWjbXPSeW1hYE2OQEzIWYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876559; c=relaxed/simple;
	bh=KlVx/CBWJM+mhaPMiWHGO8FY+LxvJPjIvW6UXoMQwC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKWI3zshL9lLnRWD2LO/1GNaZ3rFwBI7ufKC3/a8Eknw5HLBGoLo4gpXxfHdRZ+5y3lbCFdTU/bUKrCD/W+WyC0VKqL4MqQkZmCyq1o/Bqo4MoTC52qBUn+Q3WofHintD53NtZGIKnIppTHwQ3FEmtaBO4Pii8Tt1dhu4uWSViY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKwRgoYE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3135f3511bcso141354a91.0;
        Wed, 25 Jun 2025 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750876557; x=1751481357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKEZQc7yIfpLdKtwTzj44NGTDfdyacVv32KMxKW/gzc=;
        b=kKwRgoYEnXGhGEARnoLESlLeH+tqu0I46anVIsSG+4CLAdDL2RKhaUOvSvcmGAPm0r
         7JxGNe9b3O5nSqAC/dgPvtE3WdCzC4WDjZEuUivz90UXYeTEE7yycazqbODCly+ENBEZ
         W7FrZP9LOLuYGCnT8KKYQDEmik95NawUY5u9YJVpF1wahcBJM/Juky6PzhbKeoNHuYGN
         nyz4VKUN8fwr8+kwnJQ5EtTgi5LR7WZ5l+AgxKXbL4VBKIEVKFdR4+vq86IZ/nUEk6ia
         1PsoQL2N0pruWiHDR+o3+X5dab3RMpdMyqZm9YuMDNtpxhd7b8ySrmJbrn+6r3mN/nf6
         GtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750876557; x=1751481357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKEZQc7yIfpLdKtwTzj44NGTDfdyacVv32KMxKW/gzc=;
        b=WPRyaS5q0Q3F6Gway5SWPOv8yjfNqp0boNCzEMwqPjlsJ46Tb8p5Bfj6BD5xaKZVyE
         /KKHdxW9Jtjyur3SKP1DI3ihiKODnUBdGvYxZsIOjOLXswy83NcHxKyYWipy9X99mc3H
         8Cb8XnlhxarVX7AbBwp1yaEbGOppNUXnhx7qC/Vl/nlujFWNiU9S5D28hMiuYi9I9NUH
         Wf9fk8CmHMYuPbItI0grbaF8WjK5XHb4VRsQ9m8BVnE06v4w6Vi7WmrsWmq4ZwhiXpMt
         w2AeB26pPQzxjDRRVHYhzFJALVQ8m6Lgtoo5KwRdz5CTGVHAkXN+PPcJDi7BZA1p9FMW
         zFIg==
X-Forwarded-Encrypted: i=1; AJvYcCUqRIDrc6ojI1jgH7PGyfv2GD0oJQorfR0cS0RkWO3EQ43bR3FCfxq7/rw8ai5pANgg/3/J3I9E@vger.kernel.org, AJvYcCWtPh+I2nqnSDuaUXa5JDn1WGLONyAUsm/G7bOaLtfNsZaUHLCmAt2vZK5FrHJ88WRstB8NREiqkcOxGnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmntMMR9X4Az/ae8MH2xe1cWGxY8BF6IvotyPOsybKF7E3KGuz
	txqRCllhuwqEeYRhSaHwpe97R3vOjCHAcgP122fkoyPZJ39AkTjxmbg=
X-Gm-Gg: ASbGnct0HRJZoETKBTLJxDKXwIHmqinNI6otK88oK1Z6gtRNEM+r9Bd2XtM2WFmLqBX
	RpFGxdmFjl9lit/OY6NCzoYd0e1URuToZS8Y+iHkolU/xwVPZoh1hkPlUZwG4h4G8B4wuQ/xRcl
	1tRHTgVK3fp0GG9ouxHvMZbk7kFAOx3BmzkQxIS67VmhBu3x2a+YRCMeM3gzA0Zf71LKewcUvD7
	nK9ZHmc1sdzxXAsYfnXhKOrN+8qBkgJJBDsgtF7jUpuRSDmLPbq4RtASG7EkAms/cJQe5uGW6Ko
	T2lFpO5tGvdPwknvxN/cL+iDBgP7oelx/YXM+WKBRlCYYz1KWJ6ZmCfFbfrDY4tXT3eqO9lxB3W
	FJM4Mz7HE6b0EdJ6Wyu8QpbE=
X-Google-Smtp-Source: AGHT+IG0+y6VI8b76AblGI9SIdsd+trwQ2Nl5nSU1iNMAlpciV2iB5PsVuJmS+gVp4bOK9apWyRh9g==
X-Received: by 2002:a17:90a:c890:b0:311:ff18:b84b with SMTP id 98e67ed59e1d1-315f268d08cmr5921667a91.25.1750876557336;
        Wed, 25 Jun 2025 11:35:57 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f5386e67sm2421622a91.3.2025.06.25.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:35:56 -0700 (PDT)
Date: Wed, 25 Jun 2025 11:35:55 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, willemb@google.com,
	almasrymina@google.com, kerneljasonxing@gmail.com,
	ebiggers@google.com, asml.silence@gmail.com,
	aleksander.lobakin@intel.com, yangfeng@kylinos.cn,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] skbuff: Improve the sending efficiency of __skb_send_sock
Message-ID: <aFxBi55GlhVdHzE4@mini-arch>
References: <20250623084212.122284-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623084212.122284-1-yangfeng59949@163.com>

On 06/23, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> By aggregating skb data into a bvec array for transmission, when using sockmap to forward large packets,
> what previously required multiple transmissions now only needs a single transmission, which significantly enhances performance.
> For small packets, the performance remains comparable to the original level.
> 
> When using sockmap for forwarding, the average latency for different packet sizes
> after sending 10,000 packets is as follows:
> size	old(us)		new(us)
> 512	56		55
> 1472	58		58
> 1600	106		79
> 3000	145		108
> 5000	182		123
> 
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  net/core/skbuff.c | 112 +++++++++++++++++++++-------------------------
>  1 file changed, 52 insertions(+), 60 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 85fc82f72d26..664443fc9baf 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3235,84 +3235,75 @@ typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
>  static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
>  			   int len, sendmsg_func sendmsg, int flags)
>  {
> -	unsigned int orig_len = len;
>  	struct sk_buff *head = skb;
>  	unsigned short fragidx;
> -	int slen, ret;
> +	struct msghdr msg;
> +	struct bio_vec *bvec;
> +	int max_vecs, ret, slen;
> +	int bvec_count = 0;
> +	unsigned int copied = 0;
>  
> -do_frag_list:
> -
> -	/* Deal with head data */
> -	while (offset < skb_headlen(skb) && len) {
> -		struct kvec kv;
> -		struct msghdr msg;
> -
> -		slen = min_t(int, len, skb_headlen(skb) - offset);
> -		kv.iov_base = skb->data + offset;
> -		kv.iov_len = slen;
> -		memset(&msg, 0, sizeof(msg));
> -		msg.msg_flags = MSG_DONTWAIT | flags;
> -
> -		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
> -		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
> -				      sendmsg_unlocked, sk, &msg);
> -		if (ret <= 0)
> -			goto error;
> +	max_vecs = skb_shinfo(skb)->nr_frags + 1; // +1 for linear data
> +	if (skb_has_frag_list(skb)) {
> +		struct sk_buff *frag_skb = skb_shinfo(skb)->frag_list;
>  
> -		offset += ret;
> -		len -= ret;
> +		while (frag_skb) {
> +			max_vecs += skb_shinfo(frag_skb)->nr_frags + 1; // +1 for linear data
> +			frag_skb = frag_skb->next;
> +		}
>  	}
>  
> -	/* All the data was skb head? */
> -	if (!len)
> -		goto out;
> +	bvec = kcalloc(max_vecs, sizeof(struct bio_vec), GFP_KERNEL);
> +	if (!bvec)
> +		return -ENOMEM;

Not sure allocating memory here is a good idea. From what I can tell
this function is used by non-sockmap callers as well..

