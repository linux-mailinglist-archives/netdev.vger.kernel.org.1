Return-Path: <netdev+bounces-97227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5420B8CA206
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 20:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16111F220AA
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CDA137C58;
	Mon, 20 May 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgW2sbOq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E16CA4E;
	Mon, 20 May 2024 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230124; cv=none; b=spFDwuqoJBZWMgOtM3WEUttGhphPap5w8RozQJfBxWz+CjktjJQp46P7l7Njp+R+54NxAaI913dT7Vm+zUbyraHOz4nySxGs6N3Z9zYnPT+6QSQPS3gCx4sWXajvmLFA6DQiJKIDPRus6oxbpB+6WGco4sB2RyONLBnmiy31MKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230124; c=relaxed/simple;
	bh=AwKbCrAPiKfPAH09TMrveLnSLPV594VcHa1Y+1Hn4AY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GUZUDMawhl8axpzCzMmcKys2W6CPHDavH/LMPUkMZ4Lo7sDCXO8Vp0L1ZDfkOmMs6+TrRzxso2Mc3EVQiFfs/IWDwUM/woIu/Z1kzv2Z+wBem5izpMaE7f5BvlNjxL4+YRHKZsxVO9C6CQ5zlFNx/GrfnBaq0w9X6uP/iUI41T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgW2sbOq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7948b7e4e5dso57282185a.1;
        Mon, 20 May 2024 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716230122; x=1716834922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bf+hsNbN2/mjYGQxpMdBxi0kuuZ9kpvb2TZzCvDfgnE=;
        b=YgW2sbOqMV8mfhT9P0djVoVALsPx71gENrbg4Q9gwSKXbkSuzr25sb2QQzcJZMdLAq
         i6OYMJ64cRTuugM8QVsBZc775pjxyhJnc2OecZmrIUpz/THeQFE0CyjJvaKxeSLZi/mn
         Mbcuh8oedf/uOyasQlhSQkj+SIzuLPGesRNZGju3a1/Gw3bPgw0brbqdktCtuGcReTPk
         0IBUT6VOHxFpVj4MK6Fg3VYlYaRDOoMPtEeLoL2NHhJCHb7lcVcWP9np2NUSbr0qiyoV
         LQYN2i96a2Qj0GEHYoSYnkl++tCJHl0kHQvZAWc/TAhrnsqH90srFuuTwjRKg3gN4p9Z
         o1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716230122; x=1716834922;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bf+hsNbN2/mjYGQxpMdBxi0kuuZ9kpvb2TZzCvDfgnE=;
        b=ejSX+szrCil8npGWFtyU/uLfCQ5v7HD+500bw4bzV1CxvIEf7KWV+Cj6zp6MY2DG0L
         0fkcCpxZ9lepXHeo1rrQnieA2CUETRUn+lR0Z/x4S/dzxAfR5uR4FOXsV5R3mFk+owBv
         hGKcTXQM9Ol6xW3ClqQMT2xoo+xivZrRO7v7nVVoKOscGQjcPYsaYONLpr4VtPioEgsP
         Y2hfy8341p6ly1UIq2l6/IvBwkXX9mPGN+CVZC6rjSSO/r+v3Y1muVkAZpThexSAhc0H
         s8SGWu8F1bg07BMcedFAfq08o41FnzIqZDHgEe6hKKSce233xm1vOBH+wy29IjQYOKwY
         zJSw==
X-Forwarded-Encrypted: i=1; AJvYcCWu492a/ZDrJ+Ep1RaFXfJYYEbLFansFpGp1SAOy3AO3+DlzPvSOPzISjc5BLffQX3oCnLRP4SdTpMjVMXwI93dkhc5mWQ1P7b6jXZeGZOt4JB3o0sveeADuXpjkIl0ZmHnE58A
X-Gm-Message-State: AOJu0Yzk1ElCaLBfNVVX4dm4OBRVBZ8tMNLgZ5AsyJPl12VjfYUNCq1k
	L7pk6nCTrDurvYdYZMnOo8Pl4lBd7vMyEwodPBqsgWDm6viL7C3x
X-Google-Smtp-Source: AGHT+IGohNXtz0LEPJwjnemW9t/G73Jo863jyghex5TJqlI74yTIlf327PoYSqeNP/21C3RA1KvZ+Q==
X-Received: by 2002:ae9:e514:0:b0:792:d9f0:5572 with SMTP id af79cd13be357-792d9f055a9mr2476427185a.20.1716230121669;
        Mon, 20 May 2024 11:35:21 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27779fsm1209368085a.21.2024.05.20.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 11:35:21 -0700 (PDT)
Date: Mon, 20 May 2024 14:35:20 -0400
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
Message-ID: <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
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

This is changing established behavior, which itself may confuse
existing PF_PACKET receivers.

The contract is that the VLAN tag can be observed in the payload or
as tp_vlan_* fields if it is offloaded.
 
> @@ -2457,7 +2464,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
>  	sll->sll_family = AF_PACKET;
>  	sll->sll_hatype = dev->type;
> -	sll->sll_protocol = skb->protocol;
> +	sll->sll_protocol = eth_type_vlan(skb->protocol) ?
> +		vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->protocol;

This is a particularly subtle change of behavior.

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

vlan_tci 0 is valid identifier. That's the reason explicit field
TP_STATUS_VLAN_VALID was added.


