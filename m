Return-Path: <netdev+bounces-138714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313A9AE9D7
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2351128110A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5531E378A;
	Thu, 24 Oct 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEoZgFU3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417D1EB9EA
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782517; cv=none; b=aXhPHkyRKS2xr5vNQQW+U9ZCOT1dmQ14oDlOuNaT15k4WgeqZW+qROZ6XIvst3uc9imBqJ3FXSXCMMGyhr5FnoGNF/1g1U2UfOngATHTCajxigNyl2v3HMi4iqlm+PPJ98ZJUwZum+OPMs9fG7sJTfWMzBsTVn11pAeQuwgzSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782517; c=relaxed/simple;
	bh=dZC7AEXqzhR1/8EbxQbUc+nDzicwRm623DxnSpwRQvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjVIVKbFg1sousGJhYuwAYkGAKIGcnUuAwJVYutXV8NeAd8BorPp9QpjkSPATjgqAfQ9sPGRXOl8fTDxGxcBL5/RtWWkCThDV2uSs52mMapUI2QtsHOZUw1PJTtfgaODEbOLpB5pvQsZgR2CuUB4Jo7USjQA/g2R9Arvc3pETlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEoZgFU3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729782514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJ6qgkA++KPACh0CsNw2bjOe8nxTBgyxAETN6aKOom4=;
	b=VEoZgFU3RepQUKnelZTayFf7ULbDT9boGF+wQaXv6ttnsIAieBWxkxnhV2RM3rjDx5xSkC
	M5DLKja1SkKKIumo2k4Uo+EpI+6eVl66MnJRB69pE7vJGqIWoGUAkxbn4FTZy7naKMGT7i
	fJVgNDi8WXNpwWxJ0LtKpgIDB8lh0wg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-fC9fpDY3Og-GhW6met5ATg-1; Thu, 24 Oct 2024 11:08:33 -0400
X-MC-Unique: fC9fpDY3Og-GhW6met5ATg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a99efc7d881so68828966b.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782512; x=1730387312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ6qgkA++KPACh0CsNw2bjOe8nxTBgyxAETN6aKOom4=;
        b=lmS4NA7IQOjrt4QYVUFCDGsstfxGZw7RX5s89UBS/m4+EndAqLU2tclXuzTbrViUCL
         FtiepYaXLgrkWIVvLRALfifiuanxyc5d9UmRIS3FsB4GfLsfVrr+0/IKUEVTQHRstqTL
         vQsjiC4BxoGoGPxSj36euDiltlk7wJj2ZPwZpiIBke+v71o3LruQldQVDNQAJ+pCS5ju
         I2h1Ai1Zw7Qmd2E6edlklVv4aKwKe5wBqpIL62ppk3dnPoAedok+neNPfH0Qv/ChIO6+
         7UJhn4AHRsVTqxmwGWSWDUZDYws3EJrePrbCZbuyr1v6aqrgiJgYANWW5L0CXycOWTfR
         pC9g==
X-Forwarded-Encrypted: i=1; AJvYcCUSoByTgr04vU8iFkTQ/8PGefjTa3hxg3tof5hfvn5qF4356sfW//4JwZjKLUCzyzMU3uEoxLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9bUlgMJJJnlr8oZdFCAQuYYBr4PtUdqo/wBnhFcoa/din/rxF
	JPJhJQoUgRTdcyYTvmUblTwKyAIpivw2b+0sEdrFnWVnXFO1AMBFix5zyr1oDD6iG2o8z+VJzHv
	oV3jsZPK6OtbqIDmVKWb1KEYjzwu5ZB6FM59CHnxBSEkm6R362eFDCQ==
X-Received: by 2002:a05:600c:510a:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-431841a2ebbmr52875115e9.31.1729782092020;
        Thu, 24 Oct 2024 08:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDUlPKMBWZ2hd84/FQr1taFvesQFbh437FbAPlfySwXegE7R7aeY+SS64mmzNBDiRaLdXsJQ==
X-Received: by 2002:a05:600c:510a:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-431841a2ebbmr52874375e9.31.1729782091197;
        Thu, 24 Oct 2024 08:01:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55d753sm20941965e9.11.2024.10.24.08.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 08:01:30 -0700 (PDT)
Message-ID: <b232a642-2f0d-4bac-9bcf-50d653ea875d@redhat.com>
Date: Thu, 24 Oct 2024 17:01:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/3] ipv4/udp: Add 4-tuple hash for connected
 socket
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241018114535.35712-1-lulie@linux.alibaba.com>
 <20241018114535.35712-4-lulie@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241018114535.35712-4-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 13:45, Philo Lu wrote:
[...]
> +/* In hash4, rehash can also happen in connect(), where hash4_cnt keeps unchanged. */
> +static void udp4_rehash4(struct udp_table *udptable, struct sock *sk, u16 newhash4)
> +{
> +	struct udp_hslot *hslot4, *nhslot4;
> +
> +	hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
> +	nhslot4 = udp_hashslot4(udptable, newhash4);
> +	udp_sk(sk)->udp_lrpa_hash = newhash4;
> +
> +	if (hslot4 != nhslot4) {
> +		spin_lock_bh(&hslot4->lock);
> +		hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
> +		hslot4->count--;
> +		spin_unlock_bh(&hslot4->lock);
> +
> +		synchronize_rcu();

This deserve a comment explaining why it's needed. I had to dig in past
revision to understand it.

> +
> +		spin_lock_bh(&nhslot4->lock);
> +		hlist_add_head_rcu(&udp_sk(sk)->udp_lrpa_node, &nhslot4->head);
> +		nhslot4->count++;
> +		spin_unlock_bh(&nhslot4->lock);
> +	}
> +}
> +
> +static void udp4_unhash4(struct udp_table *udptable, struct sock *sk)
> +{
> +	struct udp_hslot *hslot2, *hslot4;
> +
> +	if (udp_hashed4(sk)) {
> +		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
> +		hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
> +
> +		spin_lock(&hslot4->lock);
> +		hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
> +		hslot4->count--;
> +		spin_unlock(&hslot4->lock);
> +
> +		spin_lock(&hslot2->lock);
> +		udp_hash4_dec(hslot2);
> +		spin_unlock(&hslot2->lock);
> +	}
> +}
> +
> +/* call with sock lock */
> +static void udp4_hash4(struct sock *sk)
> +{
> +	struct udp_hslot *hslot, *hslot2, *hslot4;
> +	struct net *net = sock_net(sk);
> +	struct udp_table *udptable;
> +	unsigned int hash;
> +
> +	if (sk_unhashed(sk) || inet_sk(sk)->inet_rcv_saddr == htonl(INADDR_ANY))
> +		return;
> +
> +	hash = udp_ehashfn(net, inet_sk(sk)->inet_rcv_saddr, inet_sk(sk)->inet_num,
> +			   inet_sk(sk)->inet_daddr, inet_sk(sk)->inet_dport);
> +
> +	udptable = net->ipv4.udp_table;
> +	if (udp_hashed4(sk)) {
> +		udp4_rehash4(udptable, sk, hash);

It's unclear to me how we can enter this branch. Also it's unclear why
here you don't need to call udp_hash4_inc()udp_hash4_dec, too. Why such
accounting can't be placed in udp4_rehash4()?

[...]
> @@ -2031,6 +2180,19 @@ void udp_lib_rehash(struct sock *sk, u16 newhash)
>  				spin_unlock(&nhslot2->lock);
>  			}
>  
> +			if (udp_hashed4(sk)) {
> +				udp4_rehash4(udptable, sk, newhash4);
> +
> +				if (hslot2 != nhslot2) {
> +					spin_lock(&hslot2->lock);
> +					udp_hash4_dec(hslot2);
> +					spin_unlock(&hslot2->lock);
> +
> +					spin_lock(&nhslot2->lock);
> +					udp_hash4_inc(nhslot2);
> +					spin_unlock(&nhslot2->lock);
> +				}
> +			}
>  			spin_unlock_bh(&hslot->lock);

The udp4_rehash4() call above is in atomic context and could end-up
calling synchronize_rcu() which is a blocking function. You must avoid that.

Cheers,

Paolo


