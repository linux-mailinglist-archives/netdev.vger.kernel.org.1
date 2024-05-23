Return-Path: <netdev+bounces-97827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094A38CD647
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9C81F21319
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2E9538A;
	Thu, 23 May 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6VGJm1p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0163AE;
	Thu, 23 May 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476220; cv=none; b=ac5nIZtmfffaT2yoYz9Ccsp12CT+lyVmDjI3oZv5UokSSL0B6kArBxY2Hfr+GY5BwNc2kUlH2OeLe0Dt0Bl1trVjlGT5jav2nVS13EFPXu5n9i8K5kFbn8Tggd51ZabwWYIR0FoRfwnM7ZKzfeh9VwFmKIU1VvvnaxovRk8qqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476220; c=relaxed/simple;
	bh=1Uyd6Gp1YnOEExiV+9mu+CUUEcJwVrOLr4XhnQB6PFQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OldeY/3vfa23YcafUf0sFg/bCBwJYR+VRff6xGn5qh0GARUcY5veaHmhPDbdoCsLAfjNSpdho1XmI3nmPxmI0c18C48eDvWMbCkFL4vxwRvQrk6kgx/kTb/9J5pRzmOSenlUyT8NDGIiY+2gVjBqm8b4yhLVc0yGSd+3MLNmyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6VGJm1p; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6aad7449f22so31327736d6.2;
        Thu, 23 May 2024 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716476218; x=1717081018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+mePM4Xne1E4x8+ow+ZaszHQg+h8CNowkD8wINqySE=;
        b=N6VGJm1pWHNZhMlxt97oDp3FF244YWfeNuc+RpTUgK3ARG2pj/JdQdYhMIx3Ojo9SV
         JZ0AbV3f51XDobIytdCUAXfTq+Rj9dRI6wMTUjN9mNo/1Bk4+WNCQNeNLzYD34D8F8XP
         FgiQDWw+G5Bhy/Af9yDo9pqMULiygR9IpYpR34mIRD8q0JMuISP2mCH6Ux+XjNau9eK7
         aUipKQn6eX5mpzodD1WmXtQpbpQ94aJjS4iWU8YblsVc2QCCG91U441HrGdBPJOyq5wB
         XQxe25K/bkr06MbTlvakPQyqckaercL5WB1GEpSeW+JkbE/CQbU3tciFLBQ2QOguHbEz
         3w9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476218; x=1717081018;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q+mePM4Xne1E4x8+ow+ZaszHQg+h8CNowkD8wINqySE=;
        b=HEWiXGeteDFCf5r0rd2wDq1/OLtYlSHbhJM/GG9BsSwuIHtwany0haeoHXn/zN+nce
         cmZCVUTLsrg3CU4PYtN0BW6gB2LwPfI5W4OZDIGu8Ogj2wKE5jcLVMZ5UO7havCyAO92
         Z6kP7eU4uo1+WW3m+jLS4SAB/J0G6/6uxmFiwYKypNpkaDrOxkpWAOQ+zjnhLbzQxCij
         FBq/gcpe5Om+kO14a3axIHb3G/GwUaL6p2js0a/ax0oZHWsESWME3pvCZg4iKb/eVrLR
         xYSIznxMlq0GjpC0JRvJrfEcmCGb6jLXd0AqYs5da+ciDFJSV8u7PZ7yWyHLJsMp5SUA
         dz+A==
X-Forwarded-Encrypted: i=1; AJvYcCX3Sl0//fvRITuwAht5i6NX6lXtFP0OLa/FEWig8VVohPyussIY/a+NVwmdqSQ3PyJs3oGd6gJLB4w4ZnmJ71QSPewLkjEg4ADVGn0pp8uCXZwl0Q2ug9uFIKJfWv6mm7ss34us
X-Gm-Message-State: AOJu0YyZbauVVjo/IWWJPyAv0r5CPqROY3Zf5mAjJO7ZMVDig6Qf+fI7
	YqdiX0EsFV2JtGbsHDjZOYgg/l99isrMceilK6oVmYIdnhUm0Afd
X-Google-Smtp-Source: AGHT+IFXHl7FOkYyWnd4ZupbCLRP21rTO/GIvxmkXy2yhkFSoR2n70m8wSzwulJ7ytty/xslaMX4Fg==
X-Received: by 2002:a05:6214:53c4:b0:6a9:d1b3:9790 with SMTP id 6a1803df08f44-6ab7f354d44mr74996986d6.22.1716476218042;
        Thu, 23 May 2024 07:56:58 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ccd4esm144437886d6.97.2024.05.23.07.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:56:57 -0700 (PDT)
Date: Thu, 23 May 2024 10:56:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chengen Du <chengen.du@canonical.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Chengen Du <chengen.du@canonical.com>
Message-ID: <664f5938d2bef_1b5d2429467@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240520070348.26725-1-chengen.du@canonical.com>
References: <20240520070348.26725-1-chengen.du@canonical.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Chengen Du wrote:
> In the outbound packet path, if hardware VLAN offloading is unavailable,
> the VLAN tag is inserted into the payload but then cleared from the
> metadata. Consequently, this could lead to a false negative result when
> checking for the presence of a VLAN tag using skb_vlan_tag_present(),
> causing the packet sniffing outcome to lack VLAN tag information. As a
> result, the packet capturing tool may be unable to parse packets as
> expected.
> 
> Signed-off-by: Chengen Du <chengen.du@canonical.com>

Fixes tag and Cc: stable.

As discussed please add more detail to the commit message that
explains the bug. And/or add a Link: for instance to the github
issue.

> ---
>  net/packet/af_packet.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index ea3ebc160e25..73e9acb1875b 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1010,12 +1010,15 @@ static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
>  	if (skb_vlan_tag_present(pkc->skb)) {
>  		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
>  		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
> -		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +	} else if (eth_type_vlan(pkc->skb->protocol)) {
> +		ppd->hv1.tp_vlan_tci = ntohs(vlan_eth_hdr(pkc->skb)->h_vlan_TCI);
> +		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
>  	} else {
>  		ppd->hv1.tp_vlan_tci = 0;
>  		ppd->hv1.tp_vlan_tpid = 0;
> -		ppd->tp_status = TP_STATUS_AVAILABLE;
>  	}
> +	ppd->tp_status = (ppd->hv1.tp_vlan_tci || ppd->hv1.tp_vlan_tpid) ?
> +		TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID : TP_STATUS_AVAILABLE;

Don't move this out of the original branch and don't make the valid
conditional on the value of tp_vlan_tci. Just duplicating the line
to both branches is fine. Here and below.

>  }
>  
>  static void prb_run_all_ft_ops(struct tpacket_kbdq_core *pkc,
> @@ -2427,11 +2430,15 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  		if (skb_vlan_tag_present(skb)) {
>  			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
>  			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
> -			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +		} else if (eth_type_vlan(skb->protocol)) {
> +			h.h2->tp_vlan_tci = ntohs(vlan_eth_hdr(skb)->h_vlan_TCI);
> +			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
>  		} else {
>  			h.h2->tp_vlan_tci = 0;
>  			h.h2->tp_vlan_tpid = 0;
>  		}
> +		if (h.h2->tp_vlan_tci || h.h2->tp_vlan_tpid)
> +			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  		memset(h.h2->tp_padding, 0, sizeof(h.h2->tp_padding));
>  		hdrlen = sizeof(*h.h2);
>  		break;
> @@ -2457,7 +2464,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
>  	sll->sll_family = AF_PACKET;
>  	sll->sll_hatype = dev->type;
> -	sll->sll_protocol = skb->protocol;
> +	sll->sll_protocol = eth_type_vlan(skb->protocol) ?
> +		vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->protocol;

For QinQ you probably want the true network protocol, not the inner
VLAN tag.
>  	sll->sll_pkttype = skb->pkt_type;
>  	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
>  		sll->sll_ifindex = orig_dev->ifindex;
> @@ -3482,7 +3490,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		/* Original length was stored in sockaddr_ll fields */
>  		origlen = PACKET_SKB_CB(skb)->sa.origlen;
>  		sll->sll_family = AF_PACKET;
> -		sll->sll_protocol = skb->protocol;
> +		sll->sll_protocol = eth_type_vlan(skb->protocol) ?
> +			vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->protocol;
>  	}
>  
>  	sock_recv_cmsgs(msg, sk, skb);
> @@ -3538,11 +3547,15 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		if (skb_vlan_tag_present(skb)) {
>  			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
>  			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
> -			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> +		} else if (eth_type_vlan(skb->protocol)) {
> +			aux.tp_vlan_tci = ntohs(vlan_eth_hdr(skb)->h_vlan_TCI);
> +			aux.tp_vlan_tpid = ntohs(skb->protocol);
>  		} else {
>  			aux.tp_vlan_tci = 0;
>  			aux.tp_vlan_tpid = 0;
>  		}
> +		if (aux.tp_vlan_tci || aux.tp_vlan_tpid)
> +			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>  		put_cmsg(msg, SOL_PACKET, PACKET_AUXDATA, sizeof(aux), &aux);
>  	}
>  
> -- 
> 2.40.1
> 



