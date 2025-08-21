Return-Path: <netdev+bounces-215627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C0B2FA45
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31AD1622270
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370CD32A3EA;
	Thu, 21 Aug 2025 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyOsq4jR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046B327795
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782265; cv=none; b=pyvOiNgwXZzPlgVK1zn1F9WqpyxmuyEdWlxFqYAF1oT0obrymJb3Z1gGC2qh0qvuAzyJiTLHbkryb/J1PKyMvhscXweVb9IH2SwrKuc7IloNR5rsxiV3vKLr/ovTlCuTxaqLhVfDjw5Cp30Myzy4i0LZqWOPjwPAsa3jQDh8nGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782265; c=relaxed/simple;
	bh=bwFAOQRH2KQYfE+CAuwfRyBLCaRld0/730EcCpxmlXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzVUdMs4ydazl19Acxsn1D9VZTjIkpRYJtf7enU8xyxtS19w+APxTcrYb+x3s65dxdDJt8Bf6fPemxXHjbMc/24+Y5ITmVVAtlG6D1WgebIrMPQQJ6TW8bE/T6bNxhKY7qPNsj9yjG6Jj42D4bPCuf4yZVAzmPMqT7KmGwrutwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyOsq4jR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755782262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Afy5XNBwcOSovwamEVwVUrdjuD01YmpHvgt60RHlLnE=;
	b=eyOsq4jR1L7RMyYyieJUSi74e76lmx617mH0FSPpCT6VMogCWcz18iQrQHcdFRXrWc1caA
	0BnTgHRc+j/dJMiPXgnVb3NgaDEgRO3IzxLOh8x7yOVqURVFXsHqQIa1eSPhP1LSyz1vj5
	aozmNRcVr2c6W6GyBuFyaS32qZEplZo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-8U89kmcfPVurE4Wcg_tgkQ-1; Thu, 21 Aug 2025 09:17:41 -0400
X-MC-Unique: 8U89kmcfPVurE4Wcg_tgkQ-1
X-Mimecast-MFC-AGG-ID: 8U89kmcfPVurE4Wcg_tgkQ_1755782260
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1ac1bf0dso6186025e9.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782260; x=1756387060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Afy5XNBwcOSovwamEVwVUrdjuD01YmpHvgt60RHlLnE=;
        b=Cd2FaPgYsWsltpxDYghjddLOMivrt0tn5LyfbWNlwv+boEegZHw5eewtdFoM9zjro6
         2tn8FlZUGtmkHpK9un+lgDcB8UcChTfUHV6dE/OG/JgQPxN/8HYeDWOvm9alE+rjLu4o
         Cuo6CoiLUbyueWni0MgsQbg9JYmOwZb7Uj7r0BiBw5Pe2bMsNbcFvgdDIV0qgy/Yqcmt
         +30JCSnYZ8QjN/C5waGb21XTkgYcG8OXn3wuVrISzvUR/RcAFwpaOXn67s0ML5g649hM
         JEZ9JUuXBAVs8kOLt6HR+m0W3nXVs3dxpRz/u5IPW0xzmE9WhS2WoH8XAg6XwXoWyzzD
         aWaA==
X-Forwarded-Encrypted: i=1; AJvYcCWvhLflDp8lGGFOzawhEmrc1DodYTgBWcPtbmxoCOW8bHk3HXS93mHx5YEpGxyu2nXPwCdJYgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3qHGsITnorpcGOl6FbasFpUnKC/Y22rMLMezWkAakdQBMx+m
	x+UmmTpdNLWyPREl+FnofZ//mHCfwIAtBl5guNTWpaC14n00m4313HbfKlVUq8UIub2DyIro4cA
	erulCHvJonw64dD0N1IrmGvIJ/BaA1dkEn8lB5gFtfP6z8jjS3kcIYJEAcg==
X-Gm-Gg: ASbGncvi0f7KltL3NThQ0BePUtw6DCW8ndE83wAIM8XdCL6m5YrJ00hmBTxcMv4GRxx
	pYkuXCM8zq2WqjXg1S75BSupp3cUFqwOpxpwxppBUF+/XlhuGwmdtwTeVdCs3BC5QN+6+B8Fi4R
	hPE9lt7f/TUMopDRuqdZUFFj+QYZh6luKtmNhk7Z4lq4Ky1VxWKyLhwmP2Gvapst5KxuJ645Cyh
	Bi+0FKw+P5sXFk23gJL4o/jslFclUFpJCK65uEfiAoFm8BbrYp7ES0HYJS9hDW0pxelgsOOaLvi
	2JGqv03CbpSXljT9BHh2O25+si/EbWz/DRwObt8goZKey28j6xZtsy1nOFX7dOs3YfH3LFbdfBC
	RBLHCBDYcW04=
X-Received: by 2002:a05:600c:1d01:b0:455:f7d5:1224 with SMTP id 5b1f17b1804b1-45b4d9e900amr21732995e9.9.1755782259956;
        Thu, 21 Aug 2025 06:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKup3Bv+uTuJGCC0dd8vM3UgErwkB4o60xSOsgAT0YbFG9UXZs/zd4wk8y+8JlORfOl0DGxA==
X-Received: by 2002:a05:600c:1d01:b0:455:f7d5:1224 with SMTP id 5b1f17b1804b1-45b4d9e900amr21732515e9.9.1755782259493;
        Thu, 21 Aug 2025 06:17:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3fab22726sm4908227f8f.37.2025.08.21.06.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 06:17:39 -0700 (PDT)
Message-ID: <7cfc62a6-b988-400d-829a-306211e1a156@redhat.com>
Date: Thu, 21 Aug 2025 15:17:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/15] quic: provide family ops for address
 and protocol
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, linux-cifs@vger.kernel.org,
 Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Benjamin Coddington <bcodding@redhat.com>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1755525878.git.lucien.xin@gmail.com>
 <d208163af2fdd4c6ca5375e1305774e632676e5b.1755525878.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d208163af2fdd4c6ca5375e1305774e632676e5b.1755525878.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 4:04 PM, Xin Long wrote:
> This patch introduces two new abstraction structures to simplify handling
> of IPv4 and IPv6 differences across the QUIC stack:
> 
> - quic_addr_family_ops: for address comparison, flow routing,
>   UDP config, MTU lookup, formatted output, etc.
> 
> - quic_proto_family_ops: for socket address helpers and preference.
> 
> With these additions, the QUIC core logic can remain agnostic of the
> address family and socket type, improving modularity and reducing
> repetitive checks throughout the codebase.

Given that you wrap the ops call in quick_<op>() helper, I'm wondering
if such abstraction is necessary/useful? 'if' statements in the quick
helper will likely reduce the code size, and will the indirect function
call overhead.

[...]
> +static void quic_v6_set_sk_addr(struct sock *sk, union quic_addr *a, bool src)
> +{
> +	if (src) {
> +		inet_sk(sk)->inet_sport = a->v4.sin_port;
> +		if (a->sa.sa_family == AF_INET) {
> +			sk->sk_v6_rcv_saddr.s6_addr32[0] = 0;
> +			sk->sk_v6_rcv_saddr.s6_addr32[1] = 0;
> +			sk->sk_v6_rcv_saddr.s6_addr32[2] = htonl(0x0000ffff);
> +			sk->sk_v6_rcv_saddr.s6_addr32[3] = a->v4.sin_addr.s_addr;
> +		} else {
> +			sk->sk_v6_rcv_saddr = a->v6.sin6_addr;
> +		}
> +	} else {
> +		inet_sk(sk)->inet_dport = a->v4.sin_port;
> +		if (a->sa.sa_family == AF_INET) {
> +			sk->sk_v6_daddr.s6_addr32[0] = 0;
> +			sk->sk_v6_daddr.s6_addr32[1] = 0;
> +			sk->sk_v6_daddr.s6_addr32[2] = htonl(0x0000ffff);
> +			sk->sk_v6_daddr.s6_addr32[3] = a->v4.sin_addr.s_addr;
> +		} else {
> +			sk->sk_v6_daddr = a->v6.sin6_addr;
> +		}
> +	}

You could factor the addr assignment in an helper and avoid some code
duplication.

/P


