Return-Path: <netdev+bounces-258261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO6SOy1njGkdnAAAu9opvQ
	(envelope-from <netdev+bounces-258261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:25:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A837123D5E
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63B713004D84
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637C36BCD7;
	Wed, 11 Feb 2026 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+G+MI1T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0ea0vSC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225C36B064
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770809129; cv=none; b=Fx4crck8Kca+E/mDZRk4jZro23MYfKmeM4h5eDpNDzZty/0oWAddBNUh3aCkl8Vz2E5QDSo37aNq4XC/ivUa7CGqhT0ssFXpNAQQMIij+Rhkm2jt+Bz32XMdBxUPLEalVg6uJCZAFNRoPqD5KcJp4B0qxEB4QpXgj8jj0uLqp+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770809129; c=relaxed/simple;
	bh=7d+AXoxTsWN4BbyRET87gH+U/G1P7Vts/X3P1qNoGQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NDpD9k6Eaz63P5UTApv4ZQsUuIlgVKIrX4U+FDDnds8Gc4NAuofvMRjaq3iY3HHJUkHbfg5NxIvINXmaDJz2VonVFEl6c0BRrDcbOHcjW6K4kAgedWrtxbdiv0FdbbjnNSk1/rOO4+dYLQJKI+UDyxzzCLZeMrGumEcEsHT0CO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+G+MI1T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0ea0vSC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770809127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8I9uY7De/Owfo1cyJYQXzE51IMCqg83AFJdtL17VQAQ=;
	b=G+G+MI1TolSFZ7YfYbkie0WolHRcO0Xf83+kZMLwjdyER3dgWhiddJYbtefbYrEDkUVz2L
	VqSsWpJUMQW2OT9VBseiGDzoxs5mziCd92yNJJzsPk+cyVa5GXKc/DCo16MytVd03aRHXT
	Umg+MDfuGb9gGZz6dlt6ZfIONVhiZCo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-Z1gS364zNQirR4j0zH74_g-1; Wed, 11 Feb 2026 06:25:25 -0500
X-MC-Unique: Z1gS364zNQirR4j0zH74_g-1
X-Mimecast-MFC-AGG-ID: Z1gS364zNQirR4j0zH74_g_1770809125
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4362456500eso1374757f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 03:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770809125; x=1771413925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8I9uY7De/Owfo1cyJYQXzE51IMCqg83AFJdtL17VQAQ=;
        b=b0ea0vSCJZyGEkDyQ3QN4LetvFrBsBfu1VzWxbRktNYXUyxIz4bNZTr6PeKMYURRdr
         vHiSWK4MCSH4tlwCBck9B3sA7dGhpkrctNjrENQ+PmQoIHiaG6Mc3roDEBgluz9EiRgT
         tuc1YI2RsasgGkDpEEpsbmixZtcBR6ZiXnFRznIEEsXd9cUsmGeW/Tr4y/ryPll6wjBn
         fM7J+oqpAFdfOymD8Zuaz3nNhfXkmqHiLi7gPiD2dSxZCWU1rp+5uLh8zqjow+xOjfAu
         zSNbxj1vs34Pcy+xmJAyILyY7fHA9eHDfpQY14nGdtaLwBFyEJnTP3gkT3UAgMatPIPi
         WqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770809125; x=1771413925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8I9uY7De/Owfo1cyJYQXzE51IMCqg83AFJdtL17VQAQ=;
        b=V2N9KPEByVvkpco8jup7ZFr/sw6+A9xl+lskoFUQKnDtCmvptBaSgjSS+JSqkvMiiF
         1h06Ysq/yqDpdhRxXnmX9k782w0v1W80mlQMVxegMoN3+VZVv/8J3MGGPGNUDsLNFqwb
         S/kr/N/aDnscbrDtKw7RXTSFEB9vzYjXUq1xaAuiKb52lnMdVHNopLjeTmdcdESe1Fuw
         oRv2U40DHiJSgw+4oMoZx1k1EEy7I/qOEq631wCuRYoVQ+FD5xVcOGXZgCWvyYSqsHsL
         mQb/QlaniqOa98f5RyyZkAy7M6PgSdIejWjpb7I89LdutHk78KI2YEFRl6goro2LpLkj
         25hg==
X-Forwarded-Encrypted: i=1; AJvYcCXCUKIBlBgGsGlwOA2xhP4psyW4v2ZOJ4LFJo/4V7gwp1zb87Lah6NKZZvH2sjjtJW0dynhA1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OU5c/E/wQVEQBOpeDeaBtQZB2cEx+iZl0CiYuXX/fqgYERqX
	TuVx6swg1ZgB9RNXYQeEQomTzbHATYshnOVkjVFnTw8QhCL4bLPfEtTFSgHEK0DijqMsar/rQjQ
	MYk1XGuTigqd2mtio8gwdaiBy4EmIjauc6EDkuDEimzIhh/ieeq7IxAG9pg==
X-Gm-Gg: AZuq6aJrnYSIC0egwjmIjaTj7dptVduNv/XejmUFBlDeRwrwhvHasUpQnic63HPLJF7
	1kxKfXHUXaN/8Kdu/vADq/Hd6WTZrA8HVIxhGXC8TL3JAaWaqkxF3KkSgTxfQApMTCbmx4ezBZz
	l0zg5qbkX5r9uCY+rY6HbgRAOHEGe8EEsG8OPZoRJAlKFTXWpGBF8ziHX05Tlxw2qLVhwyEVUMF
	fa/yMhzJs0FsfGizfLgcMvS9AqJSO812t3V5mDBytAff+nj4LzXHrG/bFJ/ZrHc/NZtVnEKt70W
	oMAsEr/CPcwVUBi/vyPOIVtLsxc9epbYlWzLbvZXhl7ZhKvIpyivCTkh9dk8E7zjZHHTY5X3xfX
	Qx2NOQ07RNmoFN0SQ2D80RsUwtA==
X-Received: by 2002:a5d:604d:0:b0:436:3563:499b with SMTP id ffacd0b85a97d-43635634b2cmr15873133f8f.2.1770809124563;
        Wed, 11 Feb 2026 03:25:24 -0800 (PST)
X-Received: by 2002:a5d:604d:0:b0:436:3563:499b with SMTP id ffacd0b85a97d-43635634b2cmr15873097f8f.2.1770809124074;
        Wed, 11 Feb 2026 03:25:24 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc55dsm4109270f8f.20.2026.02.11.03.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 03:25:23 -0800 (PST)
Message-ID: <8eeb1478-4dbd-4b03-b675-91df18c8d26b@redhat.com>
Date: Wed, 11 Feb 2026 12:25:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ppp: don't byte-swap at run time
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260207064705.208612-1-dqfext@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260207064705.208612-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-258261-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A837123D5E
X-Rspamd-Action: no action

On 2/7/26 7:47 AM, Qingfang Deng wrote:
> @@ -312,7 +312,26 @@ static inline struct ppp_net *ppp_pernet(struct net *net)
>  }
>  
>  /* Translates a PPP protocol number to a NP index (NP == network protocol) */
> -static inline int proto_to_npindex(int proto)
> +static __always_inline int proto_to_npindex(__be16 proto)

This has just 2 callers; does the compiler inline it anyway?!?

> +{
> +	switch (proto) {
> +	case htons(PPP_IP):
> +		return NP_IP;
> +	case htons(PPP_IPV6):
> +		return NP_IPV6;
> +	case htons(PPP_IPX):
> +		return NP_IPX;
> +	case htons(PPP_AT):
> +		return NP_AT;
> +	case htons(PPP_MPLS_UC):
> +		return NP_MPLS_UC;
> +	case htons(PPP_MPLS_MC):
> +		return NP_MPLS_MC;
> +	}
> +	return -EINVAL;
> +}
> +
> +static __always_inline int proto_to_npindex_user(int proto)

This is slowpath and definitely does not need the inline annotation

>  {
>  	switch (proto) {
>  	case PPP_IP:
> @@ -332,44 +351,44 @@ static inline int proto_to_npindex(int proto)
>  }
>  
>  /* Translates an NP index into a PPP protocol number */
> -static const int npindex_to_proto[NUM_NP] = {
> -	PPP_IP,
> -	PPP_IPV6,
> -	PPP_IPX,
> -	PPP_AT,
> -	PPP_MPLS_UC,
> -	PPP_MPLS_MC,
> +static const __be16 npindex_to_proto[NUM_NP] = {
> +	htons(PPP_IP),
> +	htons(PPP_IPV6),
> +	htons(PPP_IPX),
> +	htons(PPP_AT),
> +	htons(PPP_MPLS_UC),
> +	htons(PPP_MPLS_MC),
>  };
>  
>  /* Translates an ethertype into an NP index */
> -static inline int ethertype_to_npindex(int ethertype)
> +static inline int ethertype_to_npindex(__be16 ethertype)

This has a single caller, please drop the inline annotation.

I'm not sure the code churn is justified by the gain; please include
also actual perf figures in the commit message.

If you are willing to invest a significant amount of time in this area,
I suggest to implement first some self-tests and than reconsider the
locking schema: I suspect RCU usage could avoid some lock(s) in the
datapath.

/P


