Return-Path: <netdev+bounces-255587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CQ1ClkXf2nkjgIAu9opvQ
	(envelope-from <netdev+bounces-255587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 10:05:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A647C54F5
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 10:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CE51301B737
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA17331D399;
	Sun,  1 Feb 2026 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejGiy0yY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s9jbkz2e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF42FD689
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769936713; cv=none; b=Yvr0dJmo/0nJKhy2kLsEX9YODPF0B/J3F2oACcP7G2WR7Ngdg2oSEqNVwX5HyHyq63Gbee8U8LiQrEaPnxeEqTYzAmvGXta7cojRXp7orN3+E7e60L3Dcd1Hh2CDk7PdUkF8uE+0SeYLrBxXMMX/uCALZe6T9lZZ9Ff/MLFMuV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769936713; c=relaxed/simple;
	bh=QEWaTUGYIM3AUbjp29sbAba2kUUYgtptVEBxmi5dzvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnSH1TGbctS6xf+hHYBpz64YluDxIN0HWLzzf0EHTF2YRmWWM7x4iDcE6OBKJSpZITupV1oM0rr8/ZDQDasXG0brp6n8Vp1godtvrlsI0fkZvP/GeqzyHVt66auTnESY60tn1IrEyyMtlQCIbLJwBWBL+kYewOKP2noby1L1w/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejGiy0yY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s9jbkz2e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769936710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n3PpGZtslxQ3EtKo9C9Fdk6vH37O76cwSZfkhQe8fSc=;
	b=ejGiy0yYrlzERbxn0s2DBF3yBt8IdYwD/wc6fstiXSGud87n2f//XjK6JbPl+8sN0CqxXh
	e5RnJobBpuccb2BgpDlvWNN+Y49gydQtD8bou+OoRdNJdeCEG3plp2zxAzVxIIRU65rQn7
	fXo2u1zIfUNIwTjqlAJukEWIKD6zlN4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314--ReBEflUMTyyuMiCpgtdcA-1; Sun, 01 Feb 2026 04:05:09 -0500
X-MC-Unique: -ReBEflUMTyyuMiCpgtdcA-1
X-Mimecast-MFC-AGG-ID: -ReBEflUMTyyuMiCpgtdcA_1769936708
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fcb6b2ebso2681990f8f.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 01:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769936708; x=1770541508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3PpGZtslxQ3EtKo9C9Fdk6vH37O76cwSZfkhQe8fSc=;
        b=s9jbkz2eN7gN8syjeRgCFBcAIhMN4Cqa7RPo2gQzAk7QQaEaNTrdAEQ3fo0ittNrUc
         tWpHk2fyq5itdr4wZDZ8TYYruwRCJbdGhZ97rsSjgO6Cc9eHzgynsc5xxHa2kiebCW3T
         3pFO7TBti+J8H2dgL/KU+qk8Lrz36ii3SyNG5cxOC4UlsqnybTlmPXpwtEDOHdS36pJf
         J6PFL9bjzJ1oKiYQ12pzv/S0WIlfQ0H4rldQtethFVKKlCYYZBvqKSHuRhew8xL7KGmY
         sxD+oxG70O6OG90PBqxLRwTOUtfO19jRRqRlXYB/Dpt016wHR/C+9wrJztGJdDtmf4yW
         Ijog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769936708; x=1770541508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3PpGZtslxQ3EtKo9C9Fdk6vH37O76cwSZfkhQe8fSc=;
        b=IXWXC6ic19RohC8rSP50ZIvuKcXUN8u4DBxmR+l9ZQ6QAIvKqPoWCQ7c6GoOy4wD8N
         mbwim8mgfIr1RHLMjxuL27CiCbWf8FV7nLzc9GdmOylBjEatJNcJhziPJOu4p09UrH9V
         TBpA+0rDQMxwxGV7qOu1j4IzsH314MnFOc6VhNC3IyNaGEjBLFZ9WfnlF+CDG949QLDq
         vpvzOGcOQtEenOxkjYd+aT6pYLRhEIyNfHNAIk2H73KzksiQWNjB2Dvs7CsbKLzdoZjE
         eBtE5FWwWMKRit6dRmAMdfbXRb+MMdpR5hN5Zzf1FpvoBDLIXpMviovwhCzsigZI9zgb
         /J5w==
X-Forwarded-Encrypted: i=1; AJvYcCXCtxbUDFJiKUHr5UN1xnooTK2XSer0hED4w+4HQ3/SW1BRdR8feYpo7fPz+gKbdiTCm9x/s3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/ZHeiufMHu7xwLLAS8LgHwpI9f6TAyB31IFWi3LjymOYARVU
	QRkzRWFzhQt+ViE5cLkwgsOa/VXIKBXqZEIHlz4h2xw9Uf+6FMFH/rKV3PsnuIXjNlzITKl4wG2
	Uu0uk8vBL9ETFRZ0KXHG4K2COArg+Ot6vK/hnjV/hpc/aWil0GPsbD5HeBQ==
X-Gm-Gg: AZuq6aLi0+G6+Z+OXgV4795uDeh+jElFtcu1R9oQuABfKUJkHZvEwimxxoCqV7g9j+8
	LGoYc+rALder8gTBBgPgs2gWJOayFZW619Me16zAC0T83GbFtGj0NwVc7RnhlqSwR7gahUaE2Em
	5fHjF5L5Gs4pgXCRUYcS1scklXKUb1rzjPctfoXD8O06RUZ+SZp9LMuwz0QNWmKKThlfH4MqRhn
	PqEWePU49fAmP2YZQgja92P/KZN0HnmjYTZc8Uzmx7Wmhu68b9vTLYiDEmhiU7hgtw41miM1IKv
	dcreI0oAxHoByBZp2EHItP++eK7nZ0N7ZtKdQ3GGMJyTfq/9cSsV62YBIcqq8z8df3C2CdyGEU7
	T8yE4Ul71riiyIPEGHcX9/EjPLgy2Xd5dlg==
X-Received: by 2002:a05:600c:4e56:b0:47e:f481:24b7 with SMTP id 5b1f17b1804b1-482db47cd9emr108399575e9.17.1769936708009;
        Sun, 01 Feb 2026 01:05:08 -0800 (PST)
X-Received: by 2002:a05:600c:4e56:b0:47e:f481:24b7 with SMTP id 5b1f17b1804b1-482db47cd9emr108399225e9.17.1769936707599;
        Sun, 01 Feb 2026 01:05:07 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e04c13a2sm61038245e9.5.2026.02.01.01.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 01:05:07 -0800 (PST)
Date: Sun, 1 Feb 2026 04:05:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: tariqt@nvidia.com, linux-rdma@vger.kernel.org, shaojijie@huawei.com,
	shenjian15@huawei.com, salil.mehta@huawei.com, mbloch@nvidia.com,
	saeedm@nvidia.com, leon@kernel.org, eperezma@redhat.com,
	brett.creeley@amd.com, jasowang@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
	kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
	liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v1 net-next 2/3] net: hns3/mlx5e: avoid corrupting CWR
 flag when receiving GRO packet
Message-ID: <20260201040151-mutt-send-email-mst@kernel.org>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131225510.2946-3-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131225510.2946-3-chia-yu.chang@nokia-bell-labs.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255587-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: 9A647C54F5
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 11:55:09PM +0100, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> In Accurate ECN, ACE counter (AE, ECE, CWR flags) changes only when new
> CE packets arrive, while setting SKB_GSO_TCP_ECN in case of not knowing
> the ECN variant can result in header change that corrupts the ACE field.
> The new flag SKB_GSO_TCP_ACCECN is to prevent SKB_GSO_TCP_ECN or
> NETIF_F_TSO_ECN offloading to be used because they would corrupt CWR
> flag somewhere.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Not my driver, but a better format is something along the lines of:

Currently .... this is wrong because ... as the result .... fix this by ...
so that ....

the coding style does say that you should use the imperative form.



> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index a47464a22751..3a1cf4335477 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -3897,7 +3897,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
>  
>  	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
>  	if (th->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>  
>  	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
>  		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 1fc3720d2201..d174f83478a3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1311,7 +1311,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>  	skb->csum_offset = offsetof(struct tcphdr, check);
>  
>  	if (tcp->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>  }
>  
>  static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr *ipv6,
> @@ -1332,7 +1332,7 @@ static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr
>  	skb->csum_offset = offsetof(struct tcphdr, check);
>  
>  	if (tcp->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>  }
>  
>  static void mlx5e_shampo_update_hdr(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
> -- 
> 2.34.1


