Return-Path: <netdev+bounces-287185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDa/JNo+A2qr2AEAu9opvQ
	(envelope-from <netdev+bounces-287185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:53:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD404522FFC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92A3331B01CE
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F243A05D1;
	Tue, 12 May 2026 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSzLwKcp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+JckVHu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB23A48E5
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594317; cv=none; b=acDElu3BMZmbUOm4VxAPOQj9+apkLHavu7dRZIeLm0ug76IeBEUYOg5EE5sMVSE5LRwzjLg6dUtitFmvSAXYZUA+ma3fqFuuytzaTQS3aNjLNZKKCI8x587l0dJohlT+uG7fWTmMMAMkz/AdCAKq6hcswPOwk/rju81KRjoYGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594317; c=relaxed/simple;
	bh=beBaFWnPlfzZYXJ1j1qcJkPi/P6JOAav2skAWYAtYIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIKisEbd8zQ+QencXOUguD0I4UFYfttCz8WXT1BDWFeEqs7a5spejORaIvwKyfW3pC4OWJjUnCehkR7yV3BUJpaG1KpcidmXySXCKjM/7f+2bU9KBdusewV+L2K0N1n4zoBySxtoPWJclH3pr9cRvtgemxSeOo788c55jWwdGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSzLwKcp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+JckVHu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778594314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SO7uwB/59cp8ViAfTobce45IfmpXjuBRX6FFhYJ0cN8=;
	b=jSzLwKcp9fgldejVKvcMNeEDmLeLfC1LCUUzSfOmXr933Ryk668l0oCyI/Q14V71s489pl
	/rHNwXd2Ftcbgc5JioIjfW2sfISg8sdZ0meTCEV8Durp6VAsKK39hckxzG/w882TrXWYB1
	gnqviz5tpJr/Cq6PtM8YsNQR85h72WU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-1iSwg4ixOlWki-Nm1W-06g-1; Tue, 12 May 2026 09:58:32 -0400
X-MC-Unique: 1iSwg4ixOlWki-Nm1W-06g-1
X-Mimecast-MFC-AGG-ID: 1iSwg4ixOlWki-Nm1W-06g_1778594311
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48e6af7a9cdso28160055e9.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778594311; x=1779199111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SO7uwB/59cp8ViAfTobce45IfmpXjuBRX6FFhYJ0cN8=;
        b=Z+JckVHun0brI6fyU7IB4ax+adM0D8DdoHpbGyoCtaKbgvvoj4GZRB2d4rjpUWjdXs
         LDeI1hYGE1OAS68OkT2coxO61YScWk9ZgLBDN6KfGLf3H0d81tk9PBlioUfWfVZa4WEz
         K43yvBX2v6GnGo0VZvaX+MQRoxWBtok8qj9UxzRHk1ia27fiw7LvQJC/W1LcrmN4zG3h
         jjXzyT7/BSi2DPJx5KvmFp5ocIvlQXu9cAy739LgLpURuqhwMSmJyc85AlG415AY7o5R
         kA78sceSXIAAghgNVv+UTguaklHyDN0o6oT153Fb0vsCxRrmEEKmQhgm9FSJJZmWfpRr
         mgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594311; x=1779199111;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SO7uwB/59cp8ViAfTobce45IfmpXjuBRX6FFhYJ0cN8=;
        b=brGVqpHvhwL7bkJx4QaZlqQwdejIfH3bNwHrdYWC9w/RrreWCXlFefgqm3ZndOj9QV
         IsCkmWnoP24OQxNxK1BxEEt1AxP7gAMBlCRA751Mcp2CsDc/gKp52gwQnT4TFLUjnmNS
         3Rqq6yCBn7rAVJ6K2HTNuYbndMYHInPingbXlLwLmnU4DRYI/S8Gh2A0eDpB4BzAcGOC
         gGLR7vllhManJ88Lowom5HSSBhMOhVjp7piZkeJxIvlHYVOkXnasv0WvFoOwmtkbetH8
         9b/hyhXe6IkJtDRAJLTsp0/04Mvy95M9tTAU5zFUdkBrRlfQSNQd8gEwNvkOvHZwzbrW
         duVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2+dVP1pk+PBe/GgBcsvdoOHheweE1pvIETdiT0M50PvbFjrsjurzgDsZ+EN6bN/SEUJgSuf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwAl3+CUh8kEElfZVUaGYeLdKMbgUYfR0C7GgLc937/heO4ki2
	Kq5D+wuY9ZJyK5638NK67ORfM6hjB/2F7lxa2gyhzYPRwtB2U44EyXRsRWL6bBHGS99JObfE6qy
	Ilo/uhXm2Ryuv6qTEfdqpdrND9KuhM9saGxXRAyASiEuqiEfERkRUM7Tkbw==
X-Gm-Gg: Acq92OGeregU3uq9WwDVN/ANVvN/b5R51janKjMhmg8AbN2z+1F9Y1WWm5uUvKbscTo
	YngHerliemK30ZvHQ9/HuNC/Aclflh8dohTuWHwRudjxyLqw9YmrXJiViL4nyTbg6tUh0Lf/Pdg
	w5xeZfJFd+eNpgbi0uN+9rAZTqMXKUVYf3u/4cgCGTEEbUp0aVnB99v6FU1Ph6iIbGtXo7C5ikY
	1A3msg2iIoTgsxlP+zlal7jA922C7K0AY1+frU16SS6YG/4xATLNUrbiw+wjv//Wo+Gq6+PLhNB
	hfu8kNwF8U8PImgtQuC0FS925BfFG44b8EIYKMQIxddMvN5PmYrFWtNjioGkI8TbdwVNhJGYDEr
	PfYG4eNG05rRNvLLrkNE4muKN2eysOISnCrf1YJVx9DOPGO9vlrii3yE=
X-Received: by 2002:a05:600c:3f0f:b0:488:a797:f0ac with SMTP id 5b1f17b1804b1-48e9007290cmr51762775e9.28.1778594311036;
        Tue, 12 May 2026 06:58:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0f:b0:488:a797:f0ac with SMTP id 5b1f17b1804b1-48e9007290cmr51762245e9.28.1778594310452;
        Tue, 12 May 2026 06:58:30 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f41a8b1sm28490495e9.7.2026.05.12.06.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 06:58:29 -0700 (PDT)
Message-ID: <a5b3ac22-1515-4642-ad55-1f8b564cc140@redhat.com>
Date: Tue, 12 May 2026 15:58:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/2] net: pppoe: implement GRO/GSO support
To: Qingfang Deng <qingfang.deng@linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Kees Cook <kees@kernel.org>, Guillaume Nault <gnault@redhat.com>,
 Eric Woudstra <ericwouds@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Richard Gobert <richardbgobert@gmail.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-ppp@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20260509030507.387050-1-qingfang.deng@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260509030507.387050-1-qingfang.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DD404522FFC
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
	TAGGED_FROM(0.00)[bounces-287185-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,nvidia.com,redhat.com,gmail.com,nbd.name,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/9/26 5:04 AM, Qingfang Deng wrote:
> +static struct sk_buff *pppoe_gso_segment(struct sk_buff *skb,
> +					 netdev_features_t features)
> +{
> +	struct sk_buff *segs = ERR_PTR(-EINVAL);
> +	struct packet_offload *ptype;
> +	struct pppoe_hdr *phdr;
> +	__be16 orig_type, type;
> +	int len, nhoff;
> +
> +	skb_reset_network_header(skb);
> +	nhoff = skb_network_header(skb) - skb_mac_header(skb);
> +
> +	if (unlikely(!pskb_may_pull(skb, PPPOE_SES_HLEN)))
> +		goto out;
> +
> +	phdr = (struct pppoe_hdr *)skb_network_header(skb);
> +	type = pppoe_hdr_proto(phdr);
> +	ptype = gro_find_complete_by_type(type);
> +	if (!ptype)
> +		goto out;
> +
> +	orig_type = skb->protocol;
> +	__skb_pull(skb, PPPOE_SES_HLEN);
> +	features &= ~(NETIF_F_TSO | NETIF_F_TSO6);

As sashiko points out here you need to use NETIF_F_GSO_SOFTWARE.

/P


