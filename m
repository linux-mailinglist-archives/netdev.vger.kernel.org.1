Return-Path: <netdev+bounces-219094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661CFB3FC6C
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B89D176DCA
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9D28135B;
	Tue,  2 Sep 2025 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClKJqehh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5624E283146
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808894; cv=none; b=T14a0lPAdBVAqQSSzjVHUA2VLAO3ZnAvdGuGl49y9ZI9fIyJ31jrTQxpl3KaGKgH1hXapzUgzL7ayQ6A6LIxDStQeuHguqlSH2OuL3BRINUXBjtnYOFgZrrbSZZYw8NiCIOkkKDHtn4dmGx4ngUhsbE+YI1Zu9vN/E+3dgu30BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808894; c=relaxed/simple;
	bh=Ha+llnZUSuXuNF5zzEsL8ePc2SzhsCBTekYAn/uo68o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OA3cM0BEN9atN82oQYItypT0VmtgqkqKs4oCkik7vypKNLbStISFNrW5FLY9BlOpq5tzRZCWJ8qyDH2lXsNyZF3Izoc1a5eweMLT1DNqZTg8sSfblacy4BbDxttrHqYhebjK+Z+dyNLeaqsU/mC4xlLFRaJQCPbg+TTLXZZNLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClKJqehh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756808892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/mMPe0tkYtjIYYtj58PmOaCzuw4Q8+Ip+1jV3dRFGc=;
	b=ClKJqehhkPA8lnBF95n5ANosWZIrF2OJkGMit5owZL8phc/jELIzk7XzcgUlSjvEw1EUc/
	wDnHB6WhCBvOObnFE6lN8tm2cqSmXirBjAzJ4oTYT3YLC+oUBhB7EG9BAUDoBZ0r3+QyCK
	eglskQysmfxu9Nwn944EzQtEt2u0NQA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-AG9gu5tzNIiuhosomI5LeA-1; Tue, 02 Sep 2025 06:28:09 -0400
X-MC-Unique: AG9gu5tzNIiuhosomI5LeA-1
X-Mimecast-MFC-AGG-ID: AG9gu5tzNIiuhosomI5LeA_1756808888
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-80593bfe0a1so183709285a.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 03:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756808888; x=1757413688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/mMPe0tkYtjIYYtj58PmOaCzuw4Q8+Ip+1jV3dRFGc=;
        b=XJB+UjpnMshVhPHn7Y0o6CpNnN8C9UagP/E0aCIQYf9saCoy5vgj/kEAzHUKN4mp8Q
         DMaMgV+yxNw1FvrxmiBklog+v+AHhd2Hxq4m8jFky1u+uXjUjQm8Nto+tqPqXftUNSRq
         3nTvCjLOOZxrnLASvYWPyTkLohPelJLbxGkCC2z1REm/yxpiPJFZ86+WVET45lIE0k81
         Y9MGeIk4ivph0CENvg6xtnOK5M4JOUv/+sFH0GQWVhpfLpTUhYJGxTQok6/aGF/G/PhI
         FIuqEyWhx7hitwQnVGl3KL0tdqBj9Tx9XCvcPftVUv6f3W5PYtzw2t8oRd6Ugt1F6OnG
         xigA==
X-Forwarded-Encrypted: i=1; AJvYcCVqqE4tJJ23FYoTqzym5p5sCJxQpyPf/Nnp1c32OjHMdUSO7+RJWRJAT4xvaqYDJqgx74aF1vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwD+DZdEubq1i99OqTvEg9Rn4q7mRrLDn6gsMyTy1dxjgyC5P
	9v8P4zBU1FW8q4WZkokVhQZVcpuW2qshqe8QdWBuN4NyF4/MnZwMOL3SQu0cEpTEjG6DHOK0PaJ
	mEigUvilEO/OCdBd9ZYtwbF+XW8z9KbxVF0RoSJvAuaqNyEdKJ2p05AX8Uw==
X-Gm-Gg: ASbGncu0fdqVZU0MAGYVnYqtoS4U7Wb01pdAEbcIBlra8+bTg9KlolXZph2OAMmVEA8
	SobmKXYg1x0mU/xd87nfuNtq9cfwKcZ5jPJ6DZJG8g1BW9bQCRLB9YdLNfMz0Xuan3QvXc8wBz0
	zQswrYFSZhKRMoxY1s9MtI3B6uzyM8E/2mhcDMzT2FQILRTU+H5xUpM6JBKU9BXEJTCphqKna4O
	2GY5yQAURqQ497h/A+/zJNkJ4nWSl6kKIekqAJBrN4gJzle8F7R9zna5x/cxdnHzFiMo7RkLgww
	nZ6JKJRKWnMbTu7JF0ppzSi9yFMem6VUeUOxUtXewIqbGP+LrOjSEcuksuc/FFdHvCvFGYG+Psx
	zkBhOvd1fwLI=
X-Received: by 2002:a05:620a:4729:b0:7e6:5f1c:4d7e with SMTP id af79cd13be357-7ff2b69dfabmr1245155885a.64.1756808888578;
        Tue, 02 Sep 2025 03:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx6b3w4Y/TEljyDA3whJQLG/UqQPQvZ2V+FNmJx9SrygSDCUMAOyzQuCldvOt4IWqqB1QYDQ==
X-Received: by 2002:a05:620a:4729:b0:7e6:5f1c:4d7e with SMTP id af79cd13be357-7ff2b69dfabmr1245152885a.64.1756808888012;
        Tue, 02 Sep 2025 03:28:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e00:6083:48d1:630a:25ae? ([2a0d:3344:2712:7e00:6083:48d1:630a:25ae])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac2657afsm9685606d6.1.2025.09.02.03.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:28:07 -0700 (PDT)
Message-ID: <ba4e41ef-2d68-495d-8450-8f27e3d0b8e7@redhat.com>
Date: Tue, 2 Sep 2025 12:28:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 17/19] psp: provide decapsulation and receive
 helper for drivers
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
 <20250828162953.2707727-18-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250828162953.2707727-18-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 6:29 PM, Daniel Zahka wrote:
> +/* Receive handler for PSP packets.
> + *
> + * Presently it accepts only already-authenticated packets and does not
> + * support optional fields, such as virtualization cookies.
> + */
> +int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
> +{
> +	const struct psphdr *psph;
> +	int depth = 0, end_depth;
> +	struct psp_skb_ext *pse;
> +	struct ipv6hdr *ipv6h;
> +	struct ethhdr *eth;
> +	int encap_bytes;
> +	__be16 proto;
> +
> +	eth = (struct ethhdr *)(skb->data);
> +	proto = __vlan_get_protocol(skb, eth->h_proto, &depth);
> +	if (proto != htons(ETH_P_IPV6))
> +		return -EINVAL;
> +
> +	ipv6h = (struct ipv6hdr *)(skb->data + depth);
> +	depth += sizeof(*ipv6h);
> +	end_depth = depth + sizeof(struct udphdr) + sizeof(struct psphdr);

Why aren't you checking the next hdr being UDP? This could potentially
match unrelated packets.

Also I guess you need pskb_may_pull() above.

/P


