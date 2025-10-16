Return-Path: <netdev+bounces-229945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5CFBE25BD
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2998425D38
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BB9317715;
	Thu, 16 Oct 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSTaDQek"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E830F556
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606717; cv=none; b=gX4rKU7gt/+OD9KzU9Q7E+S+NMOYR7ZAS2O6zR2jG0cT6mg2iCNEEFjKyYDK3aEarE7pAij1pVraFf4y/+d92WrkhQ8KWCGGoD5k0UPR5dVqgErEvaHGHRVlB0webSa3JXpy1BZeAgDTV3w+hMiyQJm9Zz8Kv/WfyECJPdr6g30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606717; c=relaxed/simple;
	bh=m2KeARvuTRmdyoLiLI4saJD6ImG7emQEBqfOCbuYQQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bcaWUzSZp00ERvJbAOGq59dmB1ldZrChZXh6t2HpbPAwh/vQHVfuN0FDfmwQisqyS9A+xaNSQWIfvV5Ko/H7KzV+YzHpYu1CeKooodP86KT6RenHI9L52ID6rEMA8OAUgCCrQuF0Fmo9q5nsTt71yg+EJMI6eSsMSMKBsiq4QIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSTaDQek; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760606715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6o+0dlH/LO6+L4uMhml00siHNkD8OlJHU5sP6Kvv18=;
	b=eSTaDQek2oTD3PVM0czpshNy5k/rwwx6oX58vfjOAzG58pSAAc98VxgHXYrUDZOi0j//kr
	AZLvyDyscINLZkmMXRPtdPUpeJOR557sfhVsCK+Wkx8WOtfycRYhQXnRKvHH8FiICm9fwG
	y0lho06z5ng/UL3uhZqYQLSGtGadHjg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-dnEmwdANMpilXBWvNkHuag-1; Thu, 16 Oct 2025 05:25:12 -0400
X-MC-Unique: dnEmwdANMpilXBWvNkHuag-1
X-Mimecast-MFC-AGG-ID: dnEmwdANMpilXBWvNkHuag_1760606712
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47106720618so9171955e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 02:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606712; x=1761211512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6o+0dlH/LO6+L4uMhml00siHNkD8OlJHU5sP6Kvv18=;
        b=pdwiVIQaoF/0dYm+ewqYHceXXbOpGzRfYrDLEFi5rJl2hivbvEJuCL9sEzmuENq3Gi
         PQCs2Urm9YxLmCTSlHR59qKeDLafo2lDAZtCYfONipFDw7J7M9v3xE/eD0M6ID9UeayH
         KHlXh2QxtDON+1OswS+xL3YfEtIEk4NoxBKR/yRVQmWGlD9Y0i2IycQ55mqjTB8Hrqs0
         8qXzU/iQZrRqbBIfpU8hvBGDSbimLwvRoGPCEzTV09YnCy9FSzxo30j6hAgz+UrTMkLB
         vrT8pZovo8xGviZ17w9CQCFyVJqUwlL4ecW7rjf78bJedeTXP2hbU+s96H/+KZJ8iUKf
         tUAw==
X-Forwarded-Encrypted: i=1; AJvYcCXau4PYDj3ZH6AFWQAdSWWFpDXbjfw1swrds1i+xhrHZIL/tzQ7Uj+7/4krQXFUrF9SryoLHQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+F+EdwOlK3sb0LUnwNQX45MS/ReA5UANT3ulEH+RhKPRLpKmO
	giBYukTlLchgg2/mys9eXNCUEZsrtYP8sR3ifnend53kLf7AdKkSTgOUulLyWYh10SVD15nN8Mm
	P6SXs8FQs/ePGpEpQJYvI0vEAsZzM5aXUMmFDSXQ9pSiw5ZsG2BV+tqdedA==
X-Gm-Gg: ASbGncv5a92CqXSPD+0s9kkS8oDI5Cdm1ZxIPXhlOXyi+f6AZiErrHBNCvRkWcnf/4X
	lXrc5uyadlZWq7t3vP7r5KO07SkZ4au1rGlFiizmmLL9QThSZZJrVM/GVJi9UA3ZuQ7DeXG7uKs
	2bDMDnho+NDOKkGXdKAl4X7j+YIwHhe0NSfRecX4f9sBy/uVDTH402F1vmTtsDSK2fC3p+gV5CD
	lbl0QggbFKhdSZACUDKj+rNKhQz11naKio/U1Q10H9bWDotk9yeSW2vQ1e5YdmqkEBxHGDhVOrn
	32aNZ9G+MUCB8HqfDfnNJKltvh9TmbUnJOIw/1ITFOHvw8x1Zg1ffPaegA91cAFJS3USFRsedGN
	Am+tlsY7+6Kj56zE6B4Iaj5XZVw6SOT4tf3bI2ZirQPTxIyE=
X-Received: by 2002:a05:600c:8487:b0:45b:80ff:58f7 with SMTP id 5b1f17b1804b1-46fa9b16570mr237048725e9.36.1760606711789;
        Thu, 16 Oct 2025 02:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHODLXNXbl09HgER/Hf+hYD5m43sAstxJrTZCO15jaacFlZi4yisRDZcg7tAy/BjWtv6IsDQ==
X-Received: by 2002:a05:600c:8487:b0:45b:80ff:58f7 with SMTP id 5b1f17b1804b1-46fa9b16570mr237048295e9.36.1760606711423;
        Thu, 16 Oct 2025 02:25:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114428dbfsm14687365e9.5.2025.10.16.02.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 02:25:09 -0700 (PDT)
Message-ID: <9ad5cdc8-c900-4ada-ba62-5ee313829bac@redhat.com>
Date: Thu, 16 Oct 2025 11:25:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 12/13] tcp: accecn: detect loss ACK w/ AccECN
 option and add TCP_ACCECN_OPTION_PERSIST
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-13-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013170331.63539-13-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 61aada9f3a6f..edfcce235d2c 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4808,6 +4808,7 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
>  
>  static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
>  {
> +	struct tcp_sock *tp = tcp_sk(sk);

Minot nit: An empty line is needed here.

/P


