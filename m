Return-Path: <netdev+bounces-101566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D468FF714
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 23:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8201C1F22D02
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 21:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C7F7173C;
	Thu,  6 Jun 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHnZa/PG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53246D1B9;
	Thu,  6 Jun 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710835; cv=none; b=H5iFVIrcGha7KLdLI51UrnFTp8XykOvmrToQhHZ7q1HXcmqe7bXyQ6nTtNob7aFjt+I/pj/yh01xCdpSGb3+q9WNfgxmlIy6OknpxMzM9J/IYLc1KrAfDfyWeOSmykss8lM/bbCyQTwlJrQJBIobu+/G8CiyhqtTCJ6tKdlTMFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710835; c=relaxed/simple;
	bh=+Co+3LQoCWO1Xw8u2pGCzwkdJb7wrBqq6PbIkyE1eks=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HnMkqHCl1s0K7UhLpJ10ssoqHDo+HG+0BXgaUbuM658uUbIxZa/CPg5uYrQOMee8vX5dt1vNRjQbowoiZnOkxhlFlT7SBoD3fsrY6zOXNYGFJYVkVxWMCKYuUNoWZVSfT8CWps2s2MUizML2uah5NV7iXxRRk3EmFyrz7wM9Cqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHnZa/PG; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6af27d0c9f8so7174316d6.2;
        Thu, 06 Jun 2024 14:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717710833; x=1718315633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s57Ttr3JhqgkOLOGotPGuFFobFGXuZzfpQyblp0rsAU=;
        b=KHnZa/PG5IEb7Gzs5+RDf3Mt6tij+f8G03SN0Rmt42x1vj6Kwyeiw1+84xFCsfeG+B
         s0aRyuz/U/8Qw9vuaW9u0t9AofjLlEfJCvkoDL5WbSWCnHUJUKM3fZuo9IANvsEYESUO
         ofKRY36WkYKp7/70yqGtsUT/FwFygci2R4i1QcHO3cK1RaR+9qG1nvjHXIs2DXAzHD6N
         xbyV3k0XtpsRkPVorkVN5eTcAbSjQMCaGdC2E2JFdvZ+5AjnrBrVxmWFeTmc4faKKUgf
         qVofnBXdLwhdjXSQbmEBfKnb6Qyf6drRyAm50ydxPUj1BdtF6qdQjYVaRbDF11cfPd2j
         OqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717710833; x=1718315633;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s57Ttr3JhqgkOLOGotPGuFFobFGXuZzfpQyblp0rsAU=;
        b=YuPLb6BFSrBCdsnn/U3ARklFjgOwu0L9S5IAS/V01gz/a1KbHAwb9KzA5AOA6PBavS
         gT2weyLu1UdkGe7qkYlmaUqtZJPJaLZR/BhCPKV+uFIIbr4c4idY1+IvkwmvWLfu92rc
         Mrwy3bhh4vha47jeNt4fRXwkb9rjEolnFw0ZKuFf1SQKqYGVCeTxYPW6Fshhp+4hsl44
         kgOakbzWjDVq+G1s7rOlVAvFAIiuUpqOfhPdjOfdb+5R1EKPKA7ai3VIa6iueI6hPtrD
         reDa2zCnrtTVPSF1yF+Jja4uk0hiq9eRfHwEyeydvlAJ4vHPTFzzBhLFW1fGaTe7CcXM
         74mg==
X-Forwarded-Encrypted: i=1; AJvYcCWQTD6PtJ8a8P7nKuX9v1XE81+si0H8eseGq+FAnmDEjbuh3UxdWxry0QFRRwJr1GH+7N54qzALPg9I+NJjIZBhVSGUvPh+xG0Nqp+6s2hdDEY8Yxdh9HFPaWNL8hIgE6PGie6p
X-Gm-Message-State: AOJu0YztQb+VUj5gDbAqIu/ppY7ZjQpqJA4EBssbYFAsnyEJwVOR9JGH
	Bkysxt0xeMsIDzRcEyvFXyygdsDaxwYlaO/OawmRoXa/mbvsoZbU
X-Google-Smtp-Source: AGHT+IESI/LNXKELGKm5sMKjBhfPLdMM3HXtMZiEvbteY5wnPr5/2V/foG6lsAOZK6ckJ3hcr79MLQ==
X-Received: by 2002:a05:6214:3f8c:b0:6af:b998:1a87 with SMTP id 6a1803df08f44-6b059f2c47emr8287266d6.46.1717710832621;
        Thu, 06 Jun 2024 14:53:52 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f660167sm10066966d6.33.2024.06.06.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:53:52 -0700 (PDT)
Date: Thu, 06 Jun 2024 17:53:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: joshwash@google.com, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 stable@kernel.org, 
 Joshua Washington <joshwash@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Shailend Chand <shailend@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Rushil Gupta <rushilg@google.com>, 
 Catherine Sullivan <csully@google.com>, 
 Bailey Forrest <bcf@google.com>, 
 open list <linux-kernel@vger.kernel.org>
Message-ID: <66622fefeaeff_1013529462@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240606192139.1872461-1-joshwash@google.com>
References: <20240606192139.1872461-1-joshwash@google.com>
Subject: Re: [PATCH net] gve: ignore nonrelevant GSO type bits when processing
 TSO headers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

joshwash@ wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> TSO currently fails when the skb's gso_type field has more than one bit
> set.
> 
> TSO packets can be passed from userspace using PF_PACKET, TUNTAP and a
> few others, using virtio_net_hdr (e.g., PACKET_VNET_HDR). This includes
> virtualization, such as QEMU, a real use-case.
> 
> The gso_type and gso_size fields as passed from userspace in
> virtio_net_hdr are not trusted blindly by the kernel. It adds gso_type
> |= SKB_GSO_DODGY to force the packet to enter the software GSO stack
> for verification.
> 
> This issue might similarly come up when the CWR bit is set in the TCP
> header for congestion control, causing the SKB_GSO_TCP_ECN gso_type bit
> to be set.
> 
> Fixes: a57e5de476be ("gve: DQO: Add TX path")

nit: no empty line

> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> index fe1b26a4d736..04cb43a97c96 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -555,6 +555,10 @@ static int gve_prep_tso(struct sk_buff *skb)
>  	if (unlikely(skb_shinfo(skb)->gso_size < GVE_TX_MIN_TSO_MSS_DQO))
>  		return -1;
>  
> +	/* We only deal with TCP at this point. */
> +	if (!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)))
> +		return -EINVAL;
> +

NETIF_F_TSO and NETIF_F_TSO6 are the only terminal/L4 segmentation
offload types that gve advertises in hw_features. So I think that this
will always be true.

If nothing else, it documents the assumption, so fine to keep.

Careful about comments that just repeat what the code does. More
informative are comments that why non-obvious code exists (where
applicable, which is not here).

>  	/* Needed because we will modify header. */
>  	err = skb_cow_head(skb, 0);
>  	if (err < 0)
> @@ -565,18 +569,10 @@ static int gve_prep_tso(struct sk_buff *skb)
>  	/* Remove payload length from checksum. */
>  	paylen = skb->len - skb_transport_offset(skb);
>  
> -	switch (skb_shinfo(skb)->gso_type) {
> -	case SKB_GSO_TCPV4:
> -	case SKB_GSO_TCPV6:
> -		csum_replace_by_diff(&tcp->check,
> -				     (__force __wsum)htonl(paylen));
> +	csum_replace_by_diff(&tcp->check, (__force __wsum)htonl(paylen));
>  
> -		/* Compute length of segmentation header. */
> -		header_len = skb_tcp_all_headers(skb);
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	/* Compute length of segmentation header. */
> +	header_len = skb_tcp_all_headers(skb);
>  
>  	if (unlikely(header_len > GVE_TX_MAX_HDR_SIZE_DQO))
>  		return -EINVAL;
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 



