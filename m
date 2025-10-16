Return-Path: <netdev+bounces-230017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BADBE3066
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1A6E35619F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4825C2E1757;
	Thu, 16 Oct 2025 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgrJD+L+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88350261B60
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760613254; cv=none; b=L6YkfT+YMNucDFNVxKjEXyiuOjxOO2n0EciMjggoxflfFFpyttC/6ZJJlQ75jbqMQpOevc4+UYeBGX7dEWbnQGrY9tq3eXfSUTwyfp5KfxUCJvIrFUllZHkGpsM8wXbDuD9vsh3/cPcZ2OpBxmjQVV5GPuS7+9D0ufm63FSgNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760613254; c=relaxed/simple;
	bh=P7fSGy/zdHal0OeVAw5zv9cfgnbZupD6Qhg0sobiOwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8PQY1IfYRHg1SRDtN9DdK2cXpuLGCAj7Pt+fO3SnMDH7JipsUIRH2RG28balkVPCoJ++Wzm/WAPYSJ5/8w8fHxNVxFcH0aOKgb2XvduPy3UMASH10DYnpWEeFkILKaWloB5HqVMhnA4/quarVhqnJ2SWOhjcANlCCTkDEeYM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgrJD+L+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760613249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JZpzWmq+wMyw5B8wtun10oOUdPR4ezJ1rMpnwiZrOk=;
	b=BgrJD+L+e7JYWAHGbF/ihL00whkezRh5a8OEkFqcWV2d9dAJbQvtjvGfaHtXDSJstCUB1T
	kFSEzrOuGwGjm0tzDz3AguWBOuSRC80SEx5+v+L/4nTKCpfON5vwZIO/2pfwHHi1lhJGeM
	P2urcxFJAq4WkDVhKYS+41pI0Jrq07s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-EYhJuE3QPVWpYZTh4yiIsw-1; Thu, 16 Oct 2025 07:14:07 -0400
X-MC-Unique: EYhJuE3QPVWpYZTh4yiIsw-1
X-Mimecast-MFC-AGG-ID: EYhJuE3QPVWpYZTh4yiIsw_1760613246
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so4623685e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760613246; x=1761218046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JZpzWmq+wMyw5B8wtun10oOUdPR4ezJ1rMpnwiZrOk=;
        b=X8dTzO3vPq/D020v9KHYWuYcJ0WXe2h9jIgvkFrkzhChQ/ql9fs6+IAsWTAlQvC7Fe
         FIjCU5cNTrAQGc+7WMoSfPeV7uzZ42wbjNrrEUpbjiLH/7NEUmQNyCOJ77g5htTP6BHK
         rZGBORzk3Iwv1Wdnrws3T1Gh8DYlh5dLb879kJJV8WcqaL0v/Iqg7gI4bFvLMbvHIMAe
         /+Z7NMDdgy/9jEZcs97oZh6DCu2jSq+8XQbBBO2dZCoKGb2R3JtsKekUNU3FV9kNSsJT
         gVeRa9GxqagYS1hElrtquPbXQezEFG1h+Tgvm0TM/Oe+S3eGPy4NhoyyWyBHfIchmlHr
         WRFw==
X-Forwarded-Encrypted: i=1; AJvYcCW9pcxWrZaOGdut2fK35ou+0WDaaV7hIL0lXvd5KRT6j1VuAMuRiKqDkM3U7+YGnxJn2IwHRxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxiBx5qfZdwZki00DV+mZqGAA4phYWXaRpg+c4BBW/l8GcswwN
	liiJTc8npRR0RZOQqdByLAoTnz/7dOfdCnaC/fDZRQx4m624u7r3kflBVvaEFklwJgg+v67zXem
	Y0TfFM+HzoajB3KH1ViLdJJikrUEFXrnL4FRVRfk9iffe3V430PhdEC3c2w==
X-Gm-Gg: ASbGncuTwhlvcJ6yTba+3+ueuv7rVP6tKAvs0+bVFgiaEo78I2vQeNKmtXestAE3A/K
	NU0oy7+GAdZMcUH1MBF7iKyoQptgHL5DJqwaC/sL0s41L/pO1ViKZR8j8GAFiWh2vMl5fN2oxoX
	B8WreE8Etri2zxy3qgxAVcTqn9Sg4OJEfS/dF8ZQ/bLzvYGRNblKwL6ma1dxc6hFyUiMZ513Ztd
	y/Yy1p7okArkbZqNWxUeGtN4D7i9j5I7MwXm4vKv/znoLMG2aHaVd/6s/lhJ9Wyp53aVNyNsdCI
	5CJu/DkcqO9705LXKuzpbYV9cR8wQpe0sp5ZjF1ZkfngZGkGwjQxIjEQuB/thf/1Ajc1WZjakzI
	Ki5AfD4SxHpGhL7FDB7x6Gnlxx0cl07plEcjlhNf5dGSR1gA=
X-Received: by 2002:a05:600c:3507:b0:471:12ed:f698 with SMTP id 5b1f17b1804b1-47112edf982mr12593845e9.8.1760613245856;
        Thu, 16 Oct 2025 04:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFicLtpzJ8ptHvlghNNOEH33hhQEjuAkjgLQa8YTx5C4Ahn0GHW9fV7AZWr0tCDU6Llgl3HdA==
X-Received: by 2002:a05:600c:3507:b0:471:12ed:f698 with SMTP id 5b1f17b1804b1-47112edf982mr12593605e9.8.1760613245411;
        Thu, 16 Oct 2025 04:14:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f2f72e18sm12897213f8f.0.2025.10.16.04.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:14:04 -0700 (PDT)
Message-ID: <da385d5b-6ca7-4d91-ad8a-6adb5927a889@redhat.com>
Date: Thu, 16 Oct 2025 13:14:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 3/7] bonding: arp_ip_target helpers.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeep@us.ibm.com, i.maximets@ovn.org,
 amorenoz@redhat.com, haliu@redhat.com, stephen@networkplumber.org,
 horms@kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251013235328.1289410-1-wilder@us.ibm.com>
 <20251013235328.1289410-4-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013235328.1289410-4-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/14/25 1:52 AM, David Wilder wrote:
> Adding helpers and defines needed for extending the
> arp_ip_target parameters.
> 
> Signed-off-by: David Wilder <wilder@us.ibm.com>
> ---
>  include/net/bonding.h | 50 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 3497e5061f90..62359b34b69c 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -809,4 +809,54 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
>  	return NET_XMIT_DROP;
>  }
>  
> +/* Helpers for handling arp_ip_target */
> +#define BOND_OPTION_STRING_MAX_SIZE 64
> +#define BOND_MAX_VLAN_TAGS 5
> +#define BOND_VLAN_PROTO_NONE cpu_to_be16(0xffff)
> +
> +static inline char *bond_arp_target_to_string(struct bond_arp_target *target,
> +					      char *buf, int size)

I'm sorry for not catching this before; 'target' argument should be const:

	const struct bond_arp_target *target

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
> +				num = num + snprintf(&buf[num], size - num, "/");
> +			num = num + snprintf(&buf[num], size - num, "%u",
> +					     tags[i].vlan_id);

The above is safe under the assumption that the provided buffer size is
large enough to fit all the tags. The above limits respect this
constraint, but some build time checks could possibly help.

/P


