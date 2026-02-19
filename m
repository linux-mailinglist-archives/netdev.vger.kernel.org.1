Return-Path: <netdev+bounces-259491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F1kMG8jl2lvvAIAu9opvQ
	(envelope-from <netdev+bounces-259491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:51:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 084D015FC5A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 213FF301AA74
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695B62FF67A;
	Thu, 19 Feb 2026 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0Cgn5bv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lLNXH0gl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351673271F0
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512658; cv=none; b=ra2uilm98iJzyJQHfrs7aVAzYrqx7wQACTWJjpyswhSi6UHT+czFfC/blechDgZon3oEhQQ4XfeTtoTholEhrciTt45vcXRW/IGUaPaLdvur9SLlnd5mbDqSXJvQC1AKqm0BN3QFkCQW2/SDwQ/icF/ptW/PAfnBkIeYigiHwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512658; c=relaxed/simple;
	bh=IUKUe8GoHBuGzxepuqMAXSFVIp+TGQPP0FqUh2pe8x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MheuEME8c78Dn0sVMGhJo4+c1/JjapQLJPwz+3HH9RYy7j0KdgxjkahS4Gyj75eyHm6ITVd9eD/lY4RAonT+1gRi/06UqkvhPqbIlDnuaJ1jhvIhbm3UPY01/dHzmhsZSATC5/aW3yTegL31hpwvF34W2IuXBHsXpyktDaRPwe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0Cgn5bv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lLNXH0gl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771512656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2WZ9tx3rIcSueP45jXVYlGnSogEcFBgeLMEKKVsSp8=;
	b=T0Cgn5bvxdidutRckhOciMHSLAEtLpVccNl6dDDF/KkG9KmcVW6FJCG5vjpv6KR2gI3+rO
	Ihux/rLT0dEWGHT7Z+n+Oky4Y1rlygWAcZkAMYlrVN3Dc0Wx2Vv8sZwCHk0EZ2PM7sWUPG
	SrapOMF90xQIWu6hMCEn6WFF6P/mtqk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-5ja74xgfMkm8kG9fYPSrww-1; Thu, 19 Feb 2026 09:50:53 -0500
X-MC-Unique: 5ja74xgfMkm8kG9fYPSrww-1
X-Mimecast-MFC-AGG-ID: 5ja74xgfMkm8kG9fYPSrww_1771512652
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435a11575ecso1100382f8f.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 06:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771512652; x=1772117452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o2WZ9tx3rIcSueP45jXVYlGnSogEcFBgeLMEKKVsSp8=;
        b=lLNXH0glyFEzKd1d+gB3V3jwDofM62I9B3ycbHc29rLlSi0ZI50U0HtYMy+pVY/TUo
         UyEfMrxJj9OIE3chSWdIrrdA2GkwhqSwvGXmypo5xBrytZcSzJuLF3HIpqa5lmHIp8oZ
         LIkTPYUd+i2F0gLsq49NR4KoQG5gGJUjqSXVUvbRaiua2F4z5mz/kl+B5YVvyeXX/ppl
         sbAvcIdX1ZKwtXEt87dJpiaGmTJ1PAi+UzSfjPAUIVAgQpNiI/IpzSKjdckNWCfrUHO0
         IPGtYRYldVc+N+ku6PRsZa+LA8abnHMisrSyn9UkrsrP3PpKImOGDLAVKMyIk+0iLNGQ
         W9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771512652; x=1772117452;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2WZ9tx3rIcSueP45jXVYlGnSogEcFBgeLMEKKVsSp8=;
        b=GL1utBLSKi4o+QLgeBJjQwL33Z0WXWuBqk1dJ4kzdnVlogTwZlV92fLPJPTUuepjG0
         ztwOHvvHRnhtbTbSowtC/TUmNE4ZVgFGdkyR0eWMMYhtmJxs2Q1pSI/3NWSJhkDLF3Hq
         yzumPs+Rg1EwXbww7qxhLD0LY9jneXgjK2VgJ4Om7vyUB9nUNg2RnpokyEz3eSKrzLtk
         /lF1hRM+jwfex9ViBuooiuk0T+SjNyL9ZA2gUSNjtqWwSdvQd/FwfpJcEqgT8/gLFZaM
         +qp1p3trOPW9/Ld/rSlnhNEyDkqDzTx9Ac2t4vS0o4sdwuKjel+YT+XhW5HBnjZzeaQO
         W2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv/fvLpesfduOoU1QCvpnbS3DdEjYcFJZfqgespEziS39oZXNxXJ9rcknmbCxY1BuNd9zMLlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWgDzo7Xq8xg+7iRp/UWMyhBwMJdQItQkQmliBsMQkDcHK5aiO
	7mnc+KDSkyRYJGbzvXyKPIyiQukFhPkHyY8O4NF2zhcaCIKhYqzv8afkT3cZKMn/lngiVzTbciM
	K6lml7MDihkCke3m4rGlFSvxgtoLZh/qlsC4hGLXugjqEIaoo5LO1GSGVzw==
X-Gm-Gg: AZuq6aKvrLA9MGXG/NnsFoTf7c8bslzDjE8vOR+aeFI3OsFYycmf5bxii1k0Am7XHd8
	bX2upvwTfgcZiULAqta3sWnWekrwOHVxRRTwLwWKhKTENjSZ3oDTdkxfner7mQtD8g3G0k82P+d
	omuLHKpY282VVlqkihHRmOwlJz1tvbp5NvqaTthRFUqdr/7cTPbv7BuaA2vNaU0MVTLpc8/l1bG
	vJnAGGOgPweiyzZk0a88QsyZoyukg5bQABQhPASXw9KNi+2xxmfqAhGrYFaTZxjfN+5bWFrKJqv
	VvZbcCI4PYBBBv2TyF9+LymGmwiz6q00cy7YygXayMKQF7O1zzfpWb8gHV/7v5JN3ZAihxzTFhC
	i2tLRdu4p8AqeEuHSb8klQ3QA
X-Received: by 2002:a05:6000:2003:b0:437:6dfe:1b89 with SMTP id ffacd0b85a97d-43958e58522mr10231021f8f.61.1771512651552;
        Thu, 19 Feb 2026 06:50:51 -0800 (PST)
X-Received: by 2002:a05:6000:2003:b0:437:6dfe:1b89 with SMTP id ffacd0b85a97d-43958e58522mr10230941f8f.61.1771512650975;
        Thu, 19 Feb 2026 06:50:50 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439567aad3csm15691609f8f.36.2026.02.19.06.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 06:50:50 -0800 (PST)
Message-ID: <62393422-bc8f-4676-bf3c-4d1be15ab800@redhat.com>
Date: Thu, 19 Feb 2026 15:50:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
To: chia-yu.chang@nokia-bell-labs.com, parav@nvidia.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leonro@nvidia.com
References: <20260216085143.40242-1-chia-yu.chang@nokia-bell-labs.com>
 <20260216085143.40242-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
Cc: shenjian15@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 linyunsheng@huawei.com, mst@redhat.com, jasowang@redhat.com,
 salil.mehta@huawei.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, Jason_Livingood@comcast.com,
 cheshire@apple.com, rs.ietf@gmx.at, vidhi_goel@apple.com, kuba@kernel.org
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260216085143.40242-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,lunn.ch,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,comcast.com,apple.com,gmx.at];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259491-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[nokia-bell-labs.com:server fail,sea.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 084D015FC5A
X-Rspamd-Action: no action

On 2/16/26 9:51 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index efcfcddab376..64fb829e1f0f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1137,7 +1137,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>  	skb->csum_offset = offsetof(struct tcphdr, check);
>  
>  	if (tcp->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;

Is the above enough or will later segmentation lead to wrong results? I
think/guess the firmware is (still) aggregating the wire frames using
the ECN schema, i.e. the first wire packet has CWR == 1, the later CWR==0.

Later segmentation of this GSO packet will emit CWR == 1 on all the
packets, making the egress stream different from ingress.

The above question is mostly for Mellanox person, I guess..

/P


