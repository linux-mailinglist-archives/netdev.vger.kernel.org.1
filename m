Return-Path: <netdev+bounces-76198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB686CBC8
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 15:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAE81C21864
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248E31361D8;
	Thu, 29 Feb 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrAyZ01p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19513D31D
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217640; cv=none; b=tnTf93CDDd1MsARVBFky3/hAfEB2nupcnOE7f0k0Fkm6QAclILqv/cT4wsc4+ba74tpMoPurvOgY8vCGGziJHjDKa6yiUQaKEdAurYWF4bHf/DaaE3qCPdQe6L0kgjPHV1YzaowYDHwo+t5j76fKD9vlpLYu80WcpaTl6WZ3HsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217640; c=relaxed/simple;
	bh=p2DX8xubba2iuV/dOoMIWytAJpO1FcXWNbLHMDea4O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhgQBrxOsT/e1+cHaoYPOCu4hobCROIaJicxedtWsAvETL/X0W6sJxKty7N975aWiMm8eYGeo5qKuSeuVekLNGv2ZExOQBx9rhCDnzJcaDbP+NCsC0nWhVTGgCWl8D+Xg8fGGVOnK4YzlDO+0Ik+D1V6xvx4TjfZsih6qRgI8Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrAyZ01p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709217637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QyWEFJ+yNqsYLqP/8VLeQ0BF2PSGGH8euQh2ckEVwzo=;
	b=UrAyZ01pvn2EJGvYnTd4GGtNfIr/cJETA+atBl+3jnDTsmwITEJ4gIAOGWJTBtRJFaGVbG
	Uheib6RIm+zIyyH69o8g5VGhSutiithKqpq+oYoz5HotrmRSXzojL+6oIGXu6KL846gEpT
	qmFItPnuALM82JOzRRLunzd/4+0Fn5w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-em1A2A0XMIOfLSIVioc9lw-1; Thu, 29 Feb 2024 09:40:35 -0500
X-MC-Unique: em1A2A0XMIOfLSIVioc9lw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68facaf1c37so10253046d6.2
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 06:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709217634; x=1709822434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyWEFJ+yNqsYLqP/8VLeQ0BF2PSGGH8euQh2ckEVwzo=;
        b=nQQYtXzjdXjldKeYONLcktistVXws9sN3mEd6Xq83EkIL3n7ApdYF8LApL+YuGUCEa
         adnQVr3k0/AGG8qM4hZzIzshkl/ffKH+Q8Ms5Hl4fZa91Z9YgJBdvUxZ618TpCeL2hLu
         WqG6m5V1zoyvszQIfTq5GAi6Z/2yMwYUOrLul+Unl3anyvL5YtGQqNUQJFtM3YaBj/OJ
         /juvZH54oQKK8isINGBzkd4AbmiMo0KQGfuad5ZBvXW/zn+C+YsDO+kBefTkhx07A6Eo
         Jwms/J9FW8JXNsA2Ig/kI+TfccJwPLYR+xjkwLbZZAXmESLH7DiA4sK/J39OzP+wE3Of
         ynsA==
X-Forwarded-Encrypted: i=1; AJvYcCXYJ3vNksZQPBnYeuWdvgNdqHNaQYQidTG5GMqa2KVxhMXXx/GhmSP6OR+LyfMWWL6bQdrcQc9d+4aHVQ7TjC4KzeVYx5e3
X-Gm-Message-State: AOJu0YzA/cD3Jmw6nmsXtZHiRI62Mz2eUMikl4qyapS0oxWZhFDIYoW+
	D0hgobYwBb24HdUOjmf2PjUEbFzZwmUzpF6VLds9DH1yCi2q6utfmnCttIuHNBmJqwAqJ1FX7HR
	Ur8Es9ARKgHvb97Av/gp0EnRZnFKBIq2TDVcMu9gpWFzM/keSPY0CUlRCxLKDvw==
X-Received: by 2002:ad4:4e33:0:b0:68f:6f85:b1d5 with SMTP id dm19-20020ad44e33000000b0068f6f85b1d5mr2373659qvb.9.1709217634604;
        Thu, 29 Feb 2024 06:40:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdYyFRszf73jgTS8NKBbYyKil6pr8MJMzM+bEc/R2duxhWCgviXSBTbwSrroPnDmhzr3tfGA==
X-Received: by 2002:ad4:4e33:0:b0:68f:6f85:b1d5 with SMTP id dm19-20020ad44e33000000b0068f6f85b1d5mr2373641qvb.9.1709217634333;
        Thu, 29 Feb 2024 06:40:34 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id lu19-20020a0562145a1300b0068fc83bb48fsm780149qvb.105.2024.02.29.06.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 06:40:33 -0800 (PST)
Date: Thu, 29 Feb 2024 08:40:31 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, kernel@quicinc.com
Subject: Re: [PATCH net-next v2] net: Modify mono_delivery_time with
 clockid_delivery_time
Message-ID: <5h23xaefpzjr544hw2lsiby7v4zokfnmxm5bye66yx7h3qn6br@te7gptkdamdj>
References: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228011219.1119105-1-quic_abchauha@quicinc.com>

Hey ABC,

One minor nit below.

On Tue, Feb 27, 2024 at 05:12:19PM -0800, Abhishek Chauhan wrote:
> Bridge driver today has no support to forward the userspace timestamp
> packets and ends up resetting the timestamp. ETF qdisc checks the
> packet coming from userspace and encounters to be 0 thereby dropping
> time sensitive packets. These changes will allow userspace timestamps
> packets to be forwarded from the bridge to NIC drivers.
> 
> Existing functionality of mono_delivery_time is not altered here
> instead just extended with userspace tstamp support for bridge
> forwarding path.
> 
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Changes since v1 
> - Changed the commit subject as i am modifying the mono_delivery_time 
>   bit with clockid_delivery_time.
> - Took care of suggestion mentioned by Willem to use the same bit for 
>   userspace delivery time as there are no conflicts between TCP and 
>   SCM_TXTIME, because explicit cmsg makes no sense for TCP and only
>   RAW and DGRAM sockets interprets it. 
> - Clear explaination of why this is needed mentioned below and this 
>   is extending the work done by Martin for mono_delivery_time 
>   https://patchwork.kernel.org/project/netdevbpf/patch/20220302195525.3480280-1-kafai@fb.com/
> - Version 1 patch can be referenced with below link which states 
>   the exact problem with tc-etf and discussions which took place
>   https://lore.kernel.org/all/20240215215632.2899370-1-quic_abchauha@quicinc.com/
> 
>  include/linux/skbuff.h                     | 22 +++++++++++++---------
>  net/bridge/netfilter/nf_conntrack_bridge.c |  2 +-
>  net/core/dev.c                             |  2 +-
>  net/core/filter.c                          |  6 +++---
>  net/ieee802154/6lowpan/reassembly.c        |  2 +-
>  net/ipv4/inet_fragment.c                   |  2 +-
>  net/ipv4/ip_fragment.c                     |  2 +-
>  net/ipv4/ip_output.c                       | 13 +++++++++++--
>  net/ipv4/raw.c                             |  9 +++++++++
>  net/ipv6/ip6_output.c                      | 12 ++++++++++--
>  net/ipv6/netfilter.c                       |  2 +-
>  net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
>  net/ipv6/raw.c                             | 10 +++++++++-
>  net/ipv6/reassembly.c                      |  2 +-
>  net/sched/act_bpf.c                        |  4 ++--
>  net/sched/cls_bpf.c                        |  4 ++--
>  16 files changed, 67 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2dde34c29203..24a34d56cfa3 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -816,10 +816,14 @@ typedef unsigned char *sk_buff_data_t;
>   *	@dst_pending_confirm: need to confirm neighbour
>   *	@decrypted: Decrypted SKB
>   *	@slow_gro: state present at GRO time, slower prepare step required
> - *	@mono_delivery_time: When set, skb->tstamp has the
> + *	@clockid_delivery_time: When set, skb->tstamp has the
>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>   *		skb->tstamp has the (rcv) timestamp at ingress and
>   *		delivery_time at egress.
> + *		This bit is also set if the tstamp is set from userspace which
> + *		acts as an information in the bridge forwarding path to net

s/net/not/ or maybe "avoid resetting" ?

> + *		reset the tstamp value when user sets the timestamp using
> + *		SO_TXTIME sockopts



