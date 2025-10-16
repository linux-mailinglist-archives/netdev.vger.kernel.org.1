Return-Path: <netdev+bounces-230040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A10BE32DB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FE934E530E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268FC306495;
	Thu, 16 Oct 2025 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMDCwGal"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD22741AB
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615460; cv=none; b=fcSuvfp6ofQEEe3rS2bhy89oj0vfTTG5n2aRYTxm23phbHvWxIsQ/Uxs4RmlaMKx9O9M+t+DuajJ13UCDbx8AC6epe3e8gBPcjD//qapyyJ7VYAW1T71jMV0ckZ8fWUB/+Q0JtkVzTtuL04tZ1UrpVYDzcvTfXttOJRQ26xUgBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615460; c=relaxed/simple;
	bh=q+wBn8yn+mYQCNRnz8bEBcCoMW75rYoPMrHguwTi1Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pS/FiChkJRd4iqZBbu/RLG7KoFOc99Hqa8CBIFg2V0gpm11iDhlDHHHbDEhqm+PJb87ZEaOaRpfO7P/JmOiuuaUiXUuQG3+BEnDpTOa93weAz8QF8D5Cuzwa5fBZ3WMXuPN710sDbPfq2KrNKGNKoKch7+avxLWIoL4bC417etE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMDCwGal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760615457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMuzKztY5hY+fArekCTQ494rxfe9YMMf+adfI/eoyEE=;
	b=YMDCwGalrjI2xu9VdJNZFHATOL5bsbq6ZPKkA9RKue0f1GYYJgdafNonNw6seZbV77WD4Z
	qXwNKr4Gho7BaPqkuDc6tNqG5TwE/2FiTPvt9ZTyAJmxUPw1zFR5uZRBqaj6eAnU6wygVC
	jVL+h70zPIRjJ9MH1ZCD2T8KvrMNoFs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-L0XgSg-hPm2510SD35H_0Q-1; Thu, 16 Oct 2025 07:50:56 -0400
X-MC-Unique: L0XgSg-hPm2510SD35H_0Q-1
X-Mimecast-MFC-AGG-ID: L0XgSg-hPm2510SD35H_0Q_1760615455
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47111dc7c35so10827525e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615455; x=1761220255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMuzKztY5hY+fArekCTQ494rxfe9YMMf+adfI/eoyEE=;
        b=EBNx7VKOKiJH5xvwwFmuWvWuZB71RsoaEuyfabIgqZwG0SpkBVmHjBg/Im0fmuTpto
         9Gru1Fq1B1vP1j8L1g5y9oV32RcVshnvLaSV4isLZ/PxBrDEJfAZB9QuU/jllpjoLG1g
         Pa2O736sKM911u8ETKQALRSlu8XYen9CBN5lOy8jC0oExEkU10hKsf+/C+sSpgagr/dR
         UXAMKameUBYRZ/6zt7nkSDO9WQMYvODO9wmQXdNPV7H683M5RXZ6rLMl60OdmsZm7Qjl
         UT7B0xWP6+LMcv50vl4rPKHyAAjDYxk8LysLIZ3AM6OXbt3o5fFgHM+nvTCNwB/GlvXS
         Uj+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEeL6J46E00PHLn60Mg55DGrrOxa6pE+k6BUaOJNUvfF0Ud/hKQbT1XFL9CjXE1lfNmTyNSJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5gK4ZT7kRmUfkNToz8psM88T7UwHH2wVRJh5OJnhduvj/PoW
	X2o2ARw25sfJ0vKpWhgH1WQBxrZO5DnlfutDBBPtIMXLr81xqWN/MVuEjES9xCohkxajFoLw9wz
	gTgVgMW2O9yO3Jn/5jjK18J8RskbpjsQqnphS9yzMJcpmAe9XCMnhf5cQjw==
X-Gm-Gg: ASbGncvuTzR8z0ovRU1O0xL2K+BSW6gWQ433t0Oz4+dfSBz5+L059X8v9v+Ofz9vRHR
	HZahTPWAyC/TrTyk/dqSgOXVkpRgLO+OG2+9TOzP4gxrGlr9Eeca4rXLK6CkAgle/WtvDzzRr6h
	ambvSAEaDCfPdQDsoo/yZ+eXODhEJHHA5Nf7cEwSonGIvneEugkWjYt9TSnuXjmeYl3MnN3cCIx
	RuXtWIArxf+jIb/KXEW8/3saioa1DRVI14foYBfM5SHJSqPskTPtsJKFg7rA2ZT5Bnl4BIhp3mL
	cX+XEEy8THGdroi6jp/wdLL98NJ6AlHbPo7CxQK00kNWXcAXXRq4GWWrcDmW8ZJ50dQBxwnPEtD
	MSOQ2Qcy3t0xNSwpR34mF/JQ/O+1tCpunPOcETB501u4e+pY=
X-Received: by 2002:a05:600c:1384:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-46fa9a89286mr249347475e9.6.1760615454908;
        Thu, 16 Oct 2025 04:50:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhUZuwlqAq5rRIV1/n6qnJWVyzAN7kVg/oRqlKffxhiQlm1iI9eUVKYKE3GOgLQ+l9fri8yA==
X-Received: by 2002:a05:600c:1384:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-46fa9a89286mr249347175e9.6.1760615454503;
        Thu, 16 Oct 2025 04:50:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711442dbaesm23246955e9.8.2025.10.16.04.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:50:54 -0700 (PDT)
Message-ID: <ef443366-f841-4a84-9409-818fc31b2c0c@redhat.com>
Date: Thu, 16 Oct 2025 13:50:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 6/7] bonding: Update for extended
 arp_ip_target format.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: jv@jvosburgh.net, pradeep@us.ibm.com, i.maximets@ovn.org,
 amorenoz@redhat.com, haliu@redhat.com, stephen@networkplumber.org,
 horms@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251013235328.1289410-1-wilder@us.ibm.com>
 <20251013235328.1289410-7-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013235328.1289410-7-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 1:52 AM, David Wilder wrote:
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 15782745fa4d..d1946d387e95 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -678,6 +678,7 @@ static int bond_fill_info(struct sk_buff *skb,
>  			  const struct net_device *bond_dev)
>  {
>  	struct bonding *bond = netdev_priv(bond_dev);
> +	struct bond_arp_target *arptargets;
>  	unsigned int packets_per_slave;
>  	int ifindex, i, targets_added;
>  	struct nlattr *targets;
> @@ -716,12 +717,31 @@ static int bond_fill_info(struct sk_buff *skb,
>  		goto nla_put_failure;
>  
>  	targets_added = 0;
> -	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
> -		if (bond->params.arp_targets[i].target_ip) {
> -			if (nla_put_be32(skb, i, bond->params.arp_targets[i].target_ip))
> -				goto nla_put_failure;
> -			targets_added = 1;
> +
> +	arptargets = bond->params.arp_targets;
> +	for (i = 0; i < BOND_MAX_ARP_TARGETS && arptargets[i].target_ip ; i++) {
> +		struct data {
> +			__be32 addr;
> +			struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
> +		} __packed data;
> +		int level, size;
> +
> +		data.addr = arptargets[i].target_ip;
> +		size = sizeof(__be32);
> +		targets_added = 1;
> +
> +		if (arptargets[i].flags & BOND_TARGET_USERTAGS) {
> +			for (level = 0; level < BOND_MAX_VLAN_TAGS + 1 ; level++) {
> +				data.vlans[level].vlan_proto = arptargets[i].tags[level].vlan_proto;
> +				data.vlans[level].vlan_id = arptargets[i].tags[level].vlan_id;
> +				size = size + sizeof(struct bond_vlan_tag);
> +				if (arptargets[i].tags[level].vlan_proto == BOND_VLAN_PROTO_NONE)
> +					break;
> +				}

Apparently there is an extra tab above. This has been already noted in a
previous revision.

>  		}
> +
> +		if (nla_put(skb, i, size, &data))
> +			goto nla_put_failure;
>  	}
>  
>  	if (targets_added)

I guess you should update bond_get_size() accordingly???

Also changing the binary layout of an existing NL type does not feel
safe. @Jakub: is that something we can safely allow?

/P


