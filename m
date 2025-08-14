Return-Path: <netdev+bounces-213756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF3B26885
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DC35E7A34
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D803002DA;
	Thu, 14 Aug 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYJRLnvQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D072FB987
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179909; cv=none; b=oDa5q7kjt1lOogL63zL9UT+5NkJogQSlNEI6L/UQ2qWkxs/Q/NP6rslYZhoxE9I/MGfKXmPQ8SmcwwRVhiruPCi6wtSPP9KOxZOQnaoWsG4lPlTvIKyS9B9M+rvoaAUziDms6BFSdOMj0hAx0cGkRS8kDqJ6pLkGtH79UHNnPb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179909; c=relaxed/simple;
	bh=Sj05B51cgUZ0avxrLKp2IoXo48UYNcdTKdECpYc91ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJexF8jdMCnmod8Mrbibg7wFLk/oShboZbaCGOhBQ7H8mAuJ5YkxMLyRf0d9Cfr6OJKll6xLylJafs7BfNVH7VKEVtcFVFarMBUx2zeRaeIAiISxa/ZvPXtF+5ogaMuQClYFF0MKi75dCzRd1ojz6rkkKaOIeWAvf9AydFMZqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYJRLnvQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755179907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVBR8FmgN4jHo2BlS19vumM6w1Y3dIr/gXLy3u4Ko18=;
	b=VYJRLnvQrYMKSxhXhTAjf3jcQd7whfjxQ1j5RiGn0ehqqgs5iMj8mOmcCVnuL+1L3zH4kM
	NLvB3pmTmIASvh46W/zKx2YDGgmZQiFTz7YL/noiE6N7V7xAYqqEoScmc2i91u+aFESc0E
	zGgKksP85vQMuDUDn49gbhh+fQwyly0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-NNkhmXEUNlOsCiLyGTSyXA-1; Thu, 14 Aug 2025 09:58:23 -0400
X-MC-Unique: NNkhmXEUNlOsCiLyGTSyXA-1
X-Mimecast-MFC-AGG-ID: NNkhmXEUNlOsCiLyGTSyXA_1755179903
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9edf80ddcso374706f8f.3
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 06:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179903; x=1755784703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVBR8FmgN4jHo2BlS19vumM6w1Y3dIr/gXLy3u4Ko18=;
        b=kk1lWdCVhwhYp2iqOvIXXDLvq7GfV0rQHuk3DTD6TlRaYiQ7ZkqbEqPvHBP44FjMww
         E0Z0O5uVVuB2nOY1lyMgtmOHvXNZ2npbFdVStnZWuhn+Wnk5mBFOjk4Xjsj1fTFvPbH1
         c5mLcOJ4wcxb8clE4cSU6RqpqWvKVz2FP73Gh6evFdns1nkl/Nf1/pAaiQNEOnEFZi1/
         1RtjH95nsWnOvdyt5VSBmP0OGjwo0y91ZP6i7p53pUyXjxmj85K7Nskbb1a6KgkRnXpI
         Ki+C6XxWafWZP5gYKz45y8cMnl3mrZc2YJVG3gmy4mQKisCIxg2HqQ3sWy5edqgnZxmF
         hxoA==
X-Forwarded-Encrypted: i=1; AJvYcCVm3XfXbFp5L57fX/k3xaPzRoboUUCHK8r1uWhcOnJOT62IH26OKUX7KRpDSVgAuo8nS8Bj80Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgNEt70O8dPalZW+XE1YB6lncu9MAJr2kHztUs1HxcPzgXbyV
	n8IP5ri86v0Wp99R7IqG9KISFjun1aPcvA1Tr9kp3mvlJk9YLkEPuocBwMC160fcevu9Tu9/5uw
	gokHJbGO3J3t/4k8hSJfbaLVyRS75/vs4SKLGDAR30yeaHGq/zoHqH2tD2w==
X-Gm-Gg: ASbGncsMTpeSV2dWNy0mYbOh/orIAYsTW+YQOeyjIN4qRdu+DYaTMDa0eCnEwIpbqI/
	PIBmQydsvEg3kni2bYvLo8MpAl2PcUQfnQgJCiK0nzuCtZgMPhyy1vwfC30xYL7kw8uxG6L1VDX
	44XmeCHrJZ2HzZOSUlRDnjmunPjNNuj3mpYNXifyi8Nz8VCVE+sFTOIe3H/fo80yef2+bvR08RT
	awbd0RCvIrCtDiiSCjnholM/xXbuMlY2+Ti7gLgp1bm0bWQod5HBCLH4FqqNSnzOjcUBMRRwdZ0
	1sxnJ8Dyu3iR6CHFF+UL1mKKzI7zsRPf9EDNtYO8QGXpQLbxfbUR3fA6sY2uUTwHS0Q0O9RmvB7
	ZqRzLlA6NR/U=
X-Received: by 2002:a05:6000:40c9:b0:3b7:944d:e5e6 with SMTP id ffacd0b85a97d-3b9edf34a71mr2743322f8f.36.1755179902783;
        Thu, 14 Aug 2025 06:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXoEiflGNe3WmWcBowH2Gju0nBRddk8NqdmmOXtp4zIxXK7+h/vjKfq1VxVQ4Ii/mi9MO/WQ==
X-Received: by 2002:a05:6000:40c9:b0:3b7:944d:e5e6 with SMTP id ffacd0b85a97d-3b9edf34a71mr2743285f8f.36.1755179902408;
        Thu, 14 Aug 2025 06:58:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm28997994f8f.69.2025.08.14.06.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 06:58:21 -0700 (PDT)
Message-ID: <a6635ce0-a27f-4a3b-845a-7c25f8b58452@redhat.com>
Date: Thu, 14 Aug 2025 15:58:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 09/19] net: psp: update the TCP MSS to reflect
 PSP packet overhead
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
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
 <20250812003009.2455540-10-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250812003009.2455540-10-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 2:29 AM, Daniel Zahka wrote:
> @@ -236,6 +237,10 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
>  	tcp_write_collapse_fence(sk);
>  	pas->upgrade_seq = tcp_sk(sk)->rcv_nxt;
>  
> +	icsk = inet_csk(sk);
> +	icsk->icsk_ext_hdr_len += psp_sk_overhead(sk);

I'm likely lost, but AFAICS the user-space can successfully call
multiple times psp_sock_assoc_set_tx() on the same socket, increasing
icsk->icsk_ext_hdr_len in an unbounded way.

/P


