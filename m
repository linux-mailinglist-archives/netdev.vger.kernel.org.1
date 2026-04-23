Return-Path: <netdev+bounces-280825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFo+CC1a6mmgyQIAu9opvQ
	(envelope-from <netdev+bounces-280825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:43:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B31F455AC4
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0FB8305713B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46583A7F45;
	Thu, 23 Apr 2026 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dukD+omR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYTmrDui"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3842AA6
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966021; cv=none; b=ZacjTEYqPYWe6TKfoagVwlcDCyQ7rvp/KfjMMPS+PAquhe7awskAPgjScctr/6ynFbcM+kSzcUlN8ksgN3b3XWgs1P76L8WNSuIuynuxUxOD3Jt3ADI7zzN+5y12dBeUtuqapvDDip4SKWndKLitd37hgGr7znB2oJYuhM4yDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966021; c=relaxed/simple;
	bh=KQAh+QMuqAhpvDHw88zlMyK4p+lE6/dqHN69iRlOpJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NlwJ25rbLaDBcTrNKmbSsktmLwSzpN3xNfSkufrWl5zf5gFinPOu81TYeWaaFiss0UmdotkXPXLIS6ad3uzDIQqIuUj4v8GeTbbhBqKal6hfWX8Ad1pUyHvzLggN02BoBlY0K7/8ABHtviei64vNVljur9wF92hkZLZ1P0WsaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dukD+omR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYTmrDui; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776966019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCdvgZToTbAv0JLg8/PC704VUmnH0RtfX94TlcMSW4g=;
	b=dukD+omRMMPNsX7qHdxviZSLXrC5hI4awHJt0KtbyrchgqWtLJ05Rb3wdLZ5dKBJ1n5VEW
	n3aFCcKXbv+JgT8JNID4qmfScOFZGNz1A3yN+7Y0fw/Z/WRgF47QAWIKPQuAlezsnMwTYF
	mNhJxTVRvLXrI0nlxLXcwOwL3w9Pl0I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-qdMjRv72NjS8fFnF4m-NOA-1; Thu, 23 Apr 2026 13:40:13 -0400
X-MC-Unique: qdMjRv72NjS8fFnF4m-NOA-1
X-Mimecast-MFC-AGG-ID: qdMjRv72NjS8fFnF4m-NOA_1776966012
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so40686635e9.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776966012; x=1777570812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qCdvgZToTbAv0JLg8/PC704VUmnH0RtfX94TlcMSW4g=;
        b=DYTmrDuic9G8SOGwboCazIucKkemKCzSNrF2QLPuhV3bhPbsVrkD5+aCxE4I+H67gj
         FTXnP8XJri4E1qVPjgrT+aDhC452niCzW+fJo0yMcbAVc43ymJqNPR2JC09OcyNyRpDw
         Ogq+gRCB8gmmdrbVPZD7SP5FBXvBT2EYNXvpoJzuJEqktuEMACEWzS5hpRWkwG/Dbp6s
         FHdVHsLgEsjhn9O/+MdVxaOH3SoxwUxiaF1E4OqZQyHPFpvFZatwTV42X1YAcW9I6RSd
         d8AUfBCaNPw/7AtRywe8KZKJ2Gc1IvI4ieBcd6bMKa9T8YAyfE/GJEWHoKqvleAuJnGf
         G5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776966012; x=1777570812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCdvgZToTbAv0JLg8/PC704VUmnH0RtfX94TlcMSW4g=;
        b=ShPlXBgu5pL+IOdZmRsXe1EYW40TgFipsD3HbW0Hq12bIzY28+Lobiwc3VO5UrEfG3
         5hT/tfgcxqcEQ0Lk6/Y9CZSrl6fnkBR4ir6BGCHzkNJlm6zRvQkqXlcM/u+k+zZ+UvOi
         xfffiYFMvXE9Z6sBsLB5l4WjijbLyb6tNQ2JxX9Kd8noWGAa4Mh3zDrGUVjDMy627sNj
         iXE2kpWlPrvYNPpUC1UYgst9/gpxGH2o2VHpIaabzsyKUtBQkKLca8arfl52EuKLAJna
         QM4rFn4i5UhxRoeVTUARhjmEwWeWizB626+UquDA5qVMumTTpzfCQP90sDcksT3ym2Dl
         vxRw==
X-Forwarded-Encrypted: i=1; AFNElJ8lRxhzQNlhuMasJ1yCZs4z4fF6IYdXSKGbajJas0yXdBugJrNkzFp1CVVM1egKfoSQ2Ce5AGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy409WIDVD/lJONYA4rDkd1iaomDeR6Aa4oXljDB6D6kNCaBChw
	g+wrTIqH+Ood7xzgaD+ay3Tm/th6eIXHmxYFaegFSf83X5biJVvr/bnJ8XqBDidbzdm5FBge5sr
	6YQXSrwFtdjaeEOUiiL1ZgbfMmPRzyMUg3hqY5atJ05P1/qdd4wTHh+QVxA==
X-Gm-Gg: AeBDieu+GI1x6fUuLd4oLmbY3sW1EYJXPtcdYeKXXEl09NV6SHzRqi7r+K0RjYlmXhb
	HmJAFC2LW7bNE6UeWWzoYvhwSMtzl246erR3EDb3Rdjokhn4zQxtY/CyZqNP2UFYPpKMnamOGmL
	mCaBjTZF4vh3NjLwovlWWWn3SHtWd4tZV3p6AQH31Yft5OU89CZlZcz5icg6ev+6mRXZ8po6erd
	I/GLOSOsGv/84OgAJJtzTDj38+qGdhoMlZl9puYpLtImH8UvI+eq9FR/q3j4hwTkfO7QkpCycNO
	pOuTbpU9e2mzL7D7psZMneLEZlITrkTVSau2xiwZnIsAWEiliJZ7Lotbpi76pJbRe9UoWeHwIQS
	/vXzsQWZjGCPswQ+vyUQ6EQ6H7PkaFKXLwQKiRKDYl/uyiKrUzNiFDhu2K9bA7MF/JZ4=
X-Received: by 2002:a05:600c:64c8:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-488fb7a0d24mr426776585e9.30.1776966011859;
        Thu, 23 Apr 2026 10:40:11 -0700 (PDT)
X-Received: by 2002:a05:600c:64c8:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-488fb7a0d24mr426776145e9.30.1776966011366;
        Thu, 23 Apr 2026 10:40:11 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7b2634sm168387025e9.28.2026.04.23.10.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 10:40:10 -0700 (PDT)
Message-ID: <e6aa13f1-4284-4ae0-9dda-1a506e729156@redhat.com>
Date: Thu, 23 Apr 2026 19:40:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
To: Dragos Tatulea <dtatulea@nvidia.com>, chia-yu.chang@nokia-bell-labs.com,
 linyunsheng@huawei.com, andrew+netdev@lunn.ch, parav@nvidia.com,
 jasowang@redhat.com, mst@redhat.com, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leonro@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
 <20260417152642.71674-3-chia-yu.chang@nokia-bell-labs.com>
 <69750ae3-3b0f-41c7-9731-6d49f5f6d319@redhat.com>
 <e5d03a71-cfcd-417b-a3b3-94dbd6600f9d@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e5d03a71-cfcd-417b-a3b3-94dbd6600f9d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280825-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,nokia-bell-labs.com,huawei.com,lunn.ch,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B31F455AC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/26 4:19 PM, Dragos Tatulea wrote:
> On 23.04.26 09:30, Paolo Abeni wrote:
> [...]
>>> ---
>>>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>> index 5b60aa47c75b..9b1c80079532 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>> @@ -1180,7 +1180,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>>>  	skb->csum_offset = offsetof(struct tcphdr, check);
>>>  
>>>  	if (tcp->cwr)
>>> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
>>> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>>
>> Here there is an open question for nVidia:
>>
> Sorry for missing this question in v3.
> 
>> Is the above enough or will later segmentation lead to the wrong
>> results? I think/guess the firmware is (still) aggregating the wire
>> frames using the ECN schema, i.e. the first wire packet has CWR == 1,
>> the later CWR==0.
>>
> For mlx5 HW-GRO a packet with the CWR flag will flush the previous GRO session
> and will not start a GRO session for this packet (napi_gro_receive() will be
> called on this single segment skb).
> 
> So this change won't impact the current GRO behavior from the mlx5 driver/hw side.

OK, thanks!

For my education: doesn't the above also means that mlx5 will never
build GSO packets with CWR set (and so the above statement should never
be reached)?

/P


