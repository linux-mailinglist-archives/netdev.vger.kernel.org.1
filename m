Return-Path: <netdev+bounces-251038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DF9D3A47C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A980B3004431
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652DA3563D7;
	Mon, 19 Jan 2026 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwXVk0Tt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmntxZNx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD3357A2F
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817653; cv=none; b=XJGBbYS6NwQkGenJnPFL0UOuoQ3OmyhUNtPYyHWlaEp58VpWIWC2/dATaLUgtMJDsRRzAjdRFssRBGiZfs22JR+dqWJqRDAQecMRirWMoBkYECqs9TaXK3gHGG7V/yVmimeR+wS6oOO0TVRai3E/oP+41JOGsSGy8Hnn29IxFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817653; c=relaxed/simple;
	bh=FJKLp9T2GQ1ZMlWKKP6hr7E/v9+djlPJ91saGf30vuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1umhiaEin3YkuR4NPMPvNEhJVqODYkjO+NWiZleNR+m5HRbifJlxkhSPR3BCzVQRJxKg6XwobKYaFahLlsweCnjl0GmI5xQ2UR7f9o0KtPzHjgj1DrgUxVjiG5fmkcvZzfX9tGjysmGZHPMoTBf36KVkw4HyjpdFiMhaExR7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwXVk0Tt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmntxZNx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768817641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p26BWkOPAj+7L7DZ9jtCbSDJq9mnYEMnR3590apuSIs=;
	b=IwXVk0TtfR3BnvOvSMePcpLf0WWd4l+WUoAYJCN0gPcIw3stqJEJFH+IiMd4kChgPFS+99
	YGtawooudgxwKRdf671B14kItiH904CQv6lcL+MZpWxSrbCHr/txtAFw7ME/mYRZuHxMgt
	8HO5IJEzhocVJ/Xztd8lk+aYmwKm72M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-JL4XegO1PlKEd_QUiFXluw-1; Mon, 19 Jan 2026 05:14:00 -0500
X-MC-Unique: JL4XegO1PlKEd_QUiFXluw-1
X-Mimecast-MFC-AGG-ID: JL4XegO1PlKEd_QUiFXluw_1768817639
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43065ad16a8so3229824f8f.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 02:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768817639; x=1769422439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p26BWkOPAj+7L7DZ9jtCbSDJq9mnYEMnR3590apuSIs=;
        b=QmntxZNxOY9G8msEgfehNVWdZcrGXp0aX+hj9yCWeK6Me2SEgR168+9zlj34LaDMMr
         gqssgrS3IYYHLTGTy5lXAHpmk8xMiiFpC5v2zeQXSURqr3MWvttoQi8J/mzgt8BFLgH1
         0iZ0HiEAuozgHi/2hLxr+Ndw0oAwMOKOZmVSfTrxruby4Hq36NNGegIyDedMr+1tBn16
         kge1jXj3OfhGcCZOQzQCWQ/VI6I/199S/j9VP/Mea4PSZQ3rAt+qjNPue9Tunu7MKFuk
         v2/rftTUTO9HEkwJRYnOZGeKOYMfeoKGb2bzNUId1kr0kwpF7kXFOYpl/ABdretu187y
         wfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817639; x=1769422439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p26BWkOPAj+7L7DZ9jtCbSDJq9mnYEMnR3590apuSIs=;
        b=EpFQxs8djlagHmYcJs2wgv21mpDj9O3WtHiiS+aqxy4CmzO0R5Kv6pzIUDNfqPm8cZ
         XJ7jmUdxNzDgtgeKgQG2q8W1aZcbx2uDQqQ+16QYbImj0PqlwHQtt6HvFJydZBBA3XWa
         Xe4R0hDJAXIgHdmSVNXWO8VHUgvJyQV4e6yGV+W/yOLtiNFd6Fzywec4TOeOAdKTXIIA
         GEW/JtbNrLdldeWHzYDt+BQcGmcqpj9DSbBc4NDIQW+0uhOrvzIbIkzFroPiPKKNS0bT
         z5nahfTCxpZnQ4rSKAHnkXqHy34fZxRNpUh0NahDCsd5CSyO24mWvry7ixEzqZyUxGPn
         8DNw==
X-Gm-Message-State: AOJu0YyylKySw2n4sOgEQI887I/7DlxG5ZAQB/ysXYeeqM3CJxbKTesr
	IeCm1dygpr/l5KxL2zzH+bxHbnf+tMuL1a6pbVSfpusoChmVENh7paDJk5n0w6/jFnQPZNkK7+g
	xiPYRK03VIQYEtQXoergMqHkjaw1rGsvrLFqr6uD/9pScKHQtznIt3aGLkQ==
X-Gm-Gg: AY/fxX54WrqlS3QSFsjTu8uaXUQdjRU64wzs9s3rs+/CIEc685u9H7blfhpokkFEImC
	1o1KAoGuqaVE1fr1L22/OC++I/wEpQateDG3sdqiRmdGKDCNTQj9fHKEBkBgy76oAm8JaumvLLB
	RjhtagSpLeQyHb1GvWUXQxXUTaSQvCEfQ5UtOLKV+4jDIpPRybe++af9HPQdJyary41O8I7B0fN
	Fw8rWeCogQqcEBCgBh6FKJ1mNccxSBFVNawETkjbyI5fAvFp0TQXpgPa5MNHGP0w90matswdqg7
	wQrynwACUuQa/kQjqmoIxMeMTs88LVzcXb3xUr4OIjNXNOsd00LhBf7bHU8sSdk2dBtFtQVQwKY
	CZsFQsN3e4Uxz
X-Received: by 2002:a05:600c:8288:b0:477:9dc1:b706 with SMTP id 5b1f17b1804b1-4801e33a8fcmr115623975e9.19.1768817638724;
        Mon, 19 Jan 2026 02:13:58 -0800 (PST)
X-Received: by 2002:a05:600c:8288:b0:477:9dc1:b706 with SMTP id 5b1f17b1804b1-4801e33a8fcmr115623575e9.19.1768817638209;
        Mon, 19 Jan 2026 02:13:58 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8c0499sm189573555e9.9.2026.01.19.02.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 02:13:57 -0800 (PST)
Message-ID: <3892a971-6f0d-405a-a938-a8439e89b329@redhat.com>
Date: Mon, 19 Jan 2026 11:13:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 01/10] net: introduce mangleid_features
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, sdf@fomichev.me,
 petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com
References: <cover.1768410519.git.pabeni@redhat.com>
 <70afe1dc4404ef46154b684b12c59d4bc523477c.1768410519.git.pabeni@redhat.com>
 <CANn89iKk+BPOxCYr1+w85+hd3j7ugLB7EYmm+NdN=4XCsecAig@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iKk+BPOxCYr1+w85+hd3j7ugLB7EYmm+NdN=4XCsecAig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 7:07 PM, Eric Dumazet wrote:
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index c711da335510..6154f306ed76 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3788,8 +3788,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>                 struct iphdr *iph = skb->encapsulation ?
>>                                     inner_ip_hdr(skb) : ip_hdr(skb);
>>
>> -               if (!(iph->frag_off & htons(IP_DF)))
>> +               if (!(iph->frag_off & htons(IP_DF))) {
>>                         features &= ~NETIF_F_TSO_MANGLEID;
> 
> Nit : We could avoid the above line, if we always make sure
> NETIF_F_TSO_MANGLEID is set in dev->mangleid_features

I thinks it makes a lot of sense. register_netdevice() could ensure such
 this constraint is respected; I'll add the following in the next
iteration and I will update the chunk here accordingly.

Thanks!

Paolo
---
diff --git a/net/core/dev.c b/net/core/dev.c
index c711da335510..a028ef1a3bcf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11372,6 +11372,12 @@ int register_netdevice(struct net_device *dev)
 	if (dev->hw_enc_features & NETIF_F_TSO)
 		dev->hw_enc_features |= NETIF_F_TSO_MANGLEID;

+	/* Any mangleid feature disables TSO_MANGLEID; including the latter
+	 * in mangleid_features allows for better code in the fastpath.
+	 */
+	if (dev->mangleid_features)
+		dev->mangleid_features |= NETIF_F_TSO_MANGLEID;
+
 	/* Make NETIF_F_HIGHDMA inheritable to VLAN devices.
 	 */
 	dev->vlan_features |= NETIF_F_HIGHDMA;


