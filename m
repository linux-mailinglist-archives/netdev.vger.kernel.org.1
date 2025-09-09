Return-Path: <netdev+bounces-221222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CFCB4FCBB
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8A03B6D1D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8230D33CEA4;
	Tue,  9 Sep 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoN72xWY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896C337687
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424339; cv=none; b=dWz5034QgnQ+6olvNB8Qle9NyD66Ua4Yum8Ocudqp35D0NdzFSaEi4EbGEX8iH7T2Fgkjdys/VnV3qF19V9xqyQaegrVZL/m1UbX/x2CGoMUUIR7h9G5Yn7Pi8R9oTEz5ToCLgG6bpZD2+Q7otCIsMgnu7guFFm3Wh/MeSXH8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424339; c=relaxed/simple;
	bh=PHsZFj3A24R+Tsg61gNznddz7d+TMF6S301QdrJLrNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTyRSatuj5kFvJBKBFdrY3RJfCpnGRisB0s/2oDhaVnMF5CjCCZG/cogWc43I01VOex67T1zb5CrxV/oBFvd9/r90ns8IVJqHKzw/i8etzR9tVarZ/YTY2Scg7FmLHlSVu6qZ67ZtQnVB9ubX0FwyoShV5BIMk4g5NxbIrHYqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WoN72xWY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757424336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+Hs4rOpg4WbHC4q0g7WKpxiCLXs9pr6tEDnx7pAsOo=;
	b=WoN72xWYhsy15KYRYbyRqlVv1ideLYXvukphgVcqlcJIYGAh96mttYPVGmSajg7X1eIHEG
	v7wdAWLg9KsIuqhohve3+kSiy3adM5UY/4aitg22OWijDp/xOXPXsiT94MdwCSxjet9mrA
	RNZt3DD5I/WzKIOfGvZ8epx6xy/W094=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-GL30rCKiOjyRgkU_v2dLoA-1; Tue, 09 Sep 2025 09:25:35 -0400
X-MC-Unique: GL30rCKiOjyRgkU_v2dLoA-1
X-Mimecast-MFC-AGG-ID: GL30rCKiOjyRgkU_v2dLoA_1757424334
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45de13167aaso25607145e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 06:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424334; x=1758029134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+Hs4rOpg4WbHC4q0g7WKpxiCLXs9pr6tEDnx7pAsOo=;
        b=GFbdqQ8CWV1TAnXlRmko6oNKJYnX+0bDc/mxvkdDv5ZMGs838CqaUtrRVMPOgOWjz0
         S2gLMwWe/fk9IFbr3jkWxLSZWjlQcpNQbdSAn0F81ErYxP5xatku1ExYFGqwLEbV/svR
         5sZY6GwwK4neX1N4xxa3FimDfcHLpJhuZX39mTcnOyBVJ76TaPtGEM/qn9cA+F9KGwAR
         27Dtz7ORsHGQKvnui25Xm0eN6lWZjYLNi+qbtyOglWgMfRdDGVSJElhjvko9QnajcYcP
         PeA7evP3zuqKpLmNR8/XT32j4k6mseKB6ojlWT4oO3wyHTL/lvXt/KidzRPy+sLmzUiC
         kfkw==
X-Forwarded-Encrypted: i=1; AJvYcCXP83xQ1y3EZmhWwkGZ5hLPxmXkRfkIfHRqmUJgIUosTAkIRsl1ZjXA0xWIAokh1H1vAM4jk9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsczpOhM3y5W8Gav3e2ofyZe0gyXnGDqbdRASwNCz4GAWKsyO9
	akOR4PEe7v1szetl7Twf6KKRf4XbvIfXa1S7tA4ekfuG87RVSoTiHpgj/NX/3NmCCKNLkgM/19z
	rqJElPHxcMc3qh4pehXArZqohVjLWtc3UqQjjnjcAx8A3um9YFg8iuRMrDA==
X-Gm-Gg: ASbGncuonDEzNIONjhjm/O+Bpyr5qdgHQeFhixHJR8VoQDhL7/LBl/Wg+zFx2vynPla
	bXi3UeEmfAfMc+taUiTu70Og2cxNMrZ4SAuxLQrIsYvQRHcuyYTWSKBU/F4Ne38iEYUF6IbKnew
	Mte0HluLcYfx7bXPXLIOKjo9xOPMaisAcWgHuPOhq871TNY2SuG0Ojvwu+SGA3RsT/cVUpUL6oP
	0TuqPLoN9LC2lgYDJ5enO9c19ReraOfSFytMtO9UsAS/2249YX7lZp1HCO6tKQemUjyo4QUxMTj
	TtZFyq2rrIbKDjGWgWzcpg1lz8FA1GyAOpQHhkiTODe8zEafh9o/nQCk1EHeNmJX6UBhq5tvHOq
	wnNfgEm3tjiU=
X-Received: by 2002:a05:600c:46ca:b0:45d:d197:fecf with SMTP id 5b1f17b1804b1-45ddde31722mr110690075e9.0.1757424334296;
        Tue, 09 Sep 2025 06:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAUusgweirRIMn1ab/TosjHHD245E9g/Uc4TJHy1KO/ihXXvdEZB/Vqcd7xZDNwm2XBDekYQ==
X-Received: by 2002:a05:600c:46ca:b0:45d:d197:fecf with SMTP id 5b1f17b1804b1-45ddde31722mr110689815e9.0.1757424333905;
        Tue, 09 Sep 2025 06:25:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd6891d23sm190151245e9.4.2025.09.09.06.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:25:33 -0700 (PDT)
Message-ID: <add4dcf4-b3c2-40dd-bc2f-de80619e7c6f@redhat.com>
Date: Tue, 9 Sep 2025 15:25:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/7] bonding: arp_ip_target helpers.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com
References: <20250714225533.1490032-1-wilder@us.ibm.com>
 <20250714225533.1490032-4-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250714225533.1490032-4-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 12:54 AM, David Wilder wrote:
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 27fbce667a4c..1989b71ffa16 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -809,4 +809,49 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
>  	return NET_XMIT_DROP;
>  }
>  
> +/* Helpers for handling arp_ip_target */
> +#define BOND_OPTION_STRING_MAX_SIZE 64
> +#define BOND_VLAN_PROTO_NONE cpu_to_be16(0xffff)
> +
> +static inline char *bond_arp_target_to_string(struct bond_arp_target *target,
> +					    char *buf, int size)
> +{
> +	struct bond_vlan_tag *tags = target->tags;
> +	int i, num = 0;
> +
> +	if (!(target->flags & BOND_TARGET_USERTAGS)) {
> +		num = snprintf(&buf[0], size, "%pI4", &target->target_ip);
> +		return buf;
> +	}
> +
> +	num = snprintf(&buf[0], size, "%pI4[", &target->target_ip);
> +	if (tags) {
> +		for (i = 0; (tags[i].vlan_proto != BOND_VLAN_PROTO_NONE); i++) {
> +			if (!tags[i].vlan_id)
> +				continue;
> +			if (i != 0)
> +				num = num + snprintf(&buf[num], size-num, "/");
> +			num = num + snprintf(&buf[num], size-num, "%u",

Minor nits above: 'size-num' -> 'size - num'

/P


