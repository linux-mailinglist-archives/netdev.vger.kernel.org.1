Return-Path: <netdev+bounces-213636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC18B26049
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1874A2411F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D62FB974;
	Thu, 14 Aug 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U42Yl5U1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7502FB97B
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162046; cv=none; b=mhpgZSrEvNN4otbDBrqXjQUEEw/BAYQ0peBFzXo5ghtdtGYSk1EETb3qg5JTOkECzagbyVjxLzGTTk1iITXZVMC1hqWd5SF/WQjb2m25+5bnz5CMd+Lw0Pd293vaVdQspyQQDCqL+HkTy3OQXpChlo8LeQjMnlkbXotFc7Vb4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162046; c=relaxed/simple;
	bh=jXHTrctaRUJ+rNdL5R+fKUrnGy7zCy3LLz/mJWb0zkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZASptiOelF5+boSWtZ2mdRaoWQVW8QpD00oA7ldHrEAX3fw9cZ3QzminYQSN5tWnJe5iDfA2dW2YvlYVH8n/uFHdsbRviGKGE1QhRaYzHq0S1acQh7dQDfj78Ye4dcRfPJY/xcFs5LjiUWvQArnG//G84ygRNvkcAdU4rT7gL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U42Yl5U1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755162044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5trfn4iHxRO1zMl4s9FM80236skcBNbVF5zMFumNqQ=;
	b=U42Yl5U1FIPJlIYWId2b0a/pMcDdALrmqzsaSnWlxnBvxb/czsH4roYI0gREX0xEaxzDpK
	XFRma3lxY5FmUsjsHcYsu1gl4funC3RixZSP5J7oCgtQI2r0vHSCBEPoVvueQs9Wq0EO+c
	Jmn8ayK+HqzPc33nOiBkeshQ4sO6BzI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-dsIMMpzhPg-vQjRYDEcYOg-1; Thu, 14 Aug 2025 05:00:42 -0400
X-MC-Unique: dsIMMpzhPg-vQjRYDEcYOg-1
X-Mimecast-MFC-AGG-ID: dsIMMpzhPg-vQjRYDEcYOg_1755162041
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0bd6a9so2804185e9.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 02:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162041; x=1755766841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5trfn4iHxRO1zMl4s9FM80236skcBNbVF5zMFumNqQ=;
        b=kKXzvUOLIyBaNvyN8MuaLaff/GilcCe2xVEo470b+KFTJm/5KbpYUiPdPcjP4jQDoF
         CpNczQDwL2PUBt2OuP0AdoA09BA1oxANfqV7eDJxTxqutbaJZIsjsdlsNnm3QgRVQYbe
         MX7F4LCnj7LmyHjKgEMLKjqogh5I0yOdchW4Vg5SmMaX2brGSusXrfpmh53r6kl3gCTC
         Hm8sJt44fqyLhyP0+KELP4OBXQUngp5NaVNw1x5tcsaWtXZwt9VGOyGhYj7xqFQjTEwP
         QqQX6AR3HdiWkb421/xlxIje32+IFrt2EvPa6Qf+jV5ye79daH9XVfcPiLwMUK9admuM
         Fefg==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZVfrYlW5nWuZPYppT7O4tKRCG/pd5xGdl3oxcf2M6Zy5oo1RYenEiMfjXdIzAe+RK9ItTWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22xTC1xVwyM6q/B/O1chrBaF1uc4aKzRvHHSmhVZWf2K3oIvv
	suquRB3EO9nIHpoMxsiaUnPoThOWJH3SfjM6y4oMzEPCU8yRrqj9vIcCOL+61fzWG1Hc/V1yIdj
	aC/hhxFvCoDUn7bXyhRytgdVtcQ1JOz8BuXVj/Q+cORKTS6BRBcgutKCF5Q==
X-Gm-Gg: ASbGncs6h1VEgSHJdIbEsgzDeDViFjGRRvzVB3HDbJ94lgyd/VKYvmoeNWv8nOQeHMT
	2eNY4LIHn+kAeRe8MAsMP1GDOwIXJVkrOc3G9iqih5nuRf5W0s3/cVnIlhEDDOKeqFdCMcqznio
	jJN8Kur1JKCwjpdB1TsxzQQ58O6gA9Qmtyk8uMGROJdd0Lia+CfpUwiV06mKD4NFQrvev3iyaEI
	YQdIsnzp67QqTnQXKBNJDnJK5EBiOCyY9Hdz/edr/7aMoQA+zTYoTs0lLjdPAIbOsZnJw4w6zOB
	rJqRDgivMO7LbN/+PH2UB+f4065EHDIgSJ7H/uB1i9JGIvUR1bzKoq46lu0bjsu6PX4EG84K+wH
	rfGuo8hDwOkk=
X-Received: by 2002:a05:600c:3507:b0:458:ba04:fe6d with SMTP id 5b1f17b1804b1-45a1b60ce04mr16322825e9.14.1755162041208;
        Thu, 14 Aug 2025 02:00:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVVy9am9/UlgY43tmw9UZzdvnaAXe/8fLqN2816UAATsJnujlFSJXt8PJWd7UcchekR92kBg==
X-Received: by 2002:a05:600c:3507:b0:458:ba04:fe6d with SMTP id 5b1f17b1804b1-45a1b60ce04mr16322435e9.14.1755162040749;
        Thu, 14 Aug 2025 02:00:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cd044sm13924075e9.9.2025.08.14.02.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:00:40 -0700 (PDT)
Message-ID: <706bb6df-7cf9-41d1-8041-4248252404dd@redhat.com>
Date: Thu, 14 Aug 2025 11:00:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: pppoe: implement GRO/GSO support
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20250811095734.71019-1-nbd@nbd.name>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250811095734.71019-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/25 11:57 AM, Felix Fietkau wrote:
> @@ -1173,6 +1174,161 @@ static struct pernet_operations pppoe_net_ops = {
>  	.size = sizeof(struct pppoe_net),
>  };
>  
> +static u16
> +compare_pppoe_header(struct pppoe_hdr *phdr, struct pppoe_hdr *phdr2)
> +{
> +	return (__force __u16)((phdr->sid ^ phdr2->sid) |
> +			       (phdr->tag[0].tag_type ^ phdr2->tag[0].tag_type));

I'm sorry for the late feedback.

I see that the pppoe rcv() code ignores the type and ver fields, but I
guess it should be better to match them here, to ensure that the
segmented packet sequence matches the pre-aggregation one.

You could cast the phdr* to u32* and compare such integer.

> +}
> +
> +static __be16 pppoe_hdr_proto(struct pppoe_hdr *phdr)
> +{
> +	switch (phdr->tag[0].tag_type) {
> +	case cpu_to_be16(PPP_IP):
> +		return cpu_to_be16(ETH_P_IP);
> +	case cpu_to_be16(PPP_IPV6):
> +		return cpu_to_be16(ETH_P_IPV6);
> +	default:
> +		return 0;
> +	}
> +

Minor nit: unneeded empty line above

> +}
> +
> +static struct sk_buff *pppoe_gro_receive(struct list_head *head,
> +					 struct sk_buff *skb)
> +{
> +	const struct packet_offload *ptype;
> +	unsigned int hlen, off_pppoe;
> +	struct sk_buff *pp = NULL;
> +	struct pppoe_hdr *phdr;
> +	struct sk_buff *p;
> +	int flush = 1;
> +	__be16 type;
> +
> +	off_pppoe = skb_gro_offset(skb);
> +	hlen = off_pppoe + sizeof(*phdr);
> +	phdr = skb_gro_header(skb, hlen + 2, off_pppoe);
> +	if (unlikely(!phdr))
> +		goto out;
> +
> +	/* ignore packets with padding or invalid length */
> +	if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen)
> +		goto out;

What about filtering for phdr->code == 0 (session data) to avoid useless
late processing?

Thanks,

Paolo


