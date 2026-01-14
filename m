Return-Path: <netdev+bounces-249872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E550FD1FFAB
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBD8F3003FDB
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73123570C6;
	Wed, 14 Jan 2026 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWKKXER5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F07399A60
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406047; cv=none; b=JsfDaYMIr29llE7UQtgK/Gw3gUi/3OF2bKrZW1es9A8EgNOcZuaR5nv6Ta1Ej0pDmhdcZQcRKkAJ8tFahCf2JeBiNE2odOh/Vm9RHjW27tvzOOCC4i1RGiOqhEeR5RB+UC1QlfYpkDj2L0YM20ygqV9Yinq+9blYuHMYyi7M6MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406047; c=relaxed/simple;
	bh=drm999Z3WAnH4wE5rwcutlUbtlEjBk/jhuN6Mff/FEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mkt09uhVlZFfXPJBYWPI5EI9/miHge+K/PeoHi8Hp9uCjurlEW0hSccmVfjTm0S0/HYXbJLJ1uffv35nsmAY0yeqJdsyktSuf1lDgV/GwFhSYXdhXjIvL51i2LcSMmPkZXFVXpWPsrKtgNjaohY7xLx0AYL6NDmFVSmdJ+B8Asw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWKKXER5; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b8718294331so57449266b.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 07:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768406044; x=1769010844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TxRavD2CHBey74glO8jcJSiamTPypq/lM19n9w55O+4=;
        b=MWKKXER5tWtpqXK1NmKMu1V/zr26rQpdv5N3yzKnBOSEmsRYE2VPrUpO0ZNk8nObg8
         9wqQNkwucOHLMO8yEij4w99z6bvPZmDVcYpp2j3I7jb96BO4REpPI4idmUecCsWw6hAR
         fLEVMKAunTFKNmo4Lqxn2/Lj/J5xRjnrTew4+/BIOoST/5Wn9+nU8OzLKWZda1aqpoHS
         7g+kma3V5q6qTaT+YEh8rSzFyqKQCpbl5YmfoGAPp0L/hJZHRWXw6KUfmAFwRYf+ppHO
         i+PIWTcAIxcClrY1qr6tBE4HHm8FYU/zozEdQaYTJqfzYsGNWwhMUPQpG4Z6fK+m56Gg
         rnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406044; x=1769010844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxRavD2CHBey74glO8jcJSiamTPypq/lM19n9w55O+4=;
        b=M2dVwMlqD9LWXbKiSdPwmDlN2v0wkDO7KdOCvB85GtIW3bD6hpgaHxM6OjcWcjCglE
         3QxEJlX+FJGzu9roMRoWSfTbcICWAtnaHakOwoUP3KYJQvWiHz6e7BUMqQBpaamCZII6
         sq3Pqe2G+yJPxSVTJo+rMX7fmQ7dGhtS/rqYkNrKVbRwiJVvn2syLhGsdzeTWnoOSh8h
         YT/Z4W4QRoxQBsBWnsHcvsBNVelYvWdAOSaNSiCtkRwcyweXi4hq9gD4LhutQkdSVh11
         pVaOkRoKPMwHJ1vCHfUAW7uQvAZAT2CvA2KBp24RVL3AMIU6SriccLJYLmWJ8wDjqhjf
         pyTg==
X-Forwarded-Encrypted: i=1; AJvYcCXZpeUboNowlTfCLXOiyMtPivkhTxmg23r7ETo9CEZ0jjn4Kmdf/xfZDJ018XB0qcSNxxYP/gA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtu5+Fjyh7ASt3PZXsU6U+bs1b7u2TArRJYC10aUGDRRKrm8a3
	P6gaf1p7J965rQrEMzPxhxrAq2TgqhRzFgOoYdBixFDDq+Uhqm4wZvfo
X-Gm-Gg: AY/fxX5AfDXPkTZHBfdskKOYK+NAgwl/UTpk8a/6U0tDmr/u/9j2j3WBGasQGGlcyXT
	sSl6i4EjZxb1mhNGS1ViaRFFaoTcvOU3KNKvfmtqod52riduTiO/SROoxH6+D/q7cRBNTMcIqOR
	4zPdbM3G8q4LoSPtQK64K0NQv3hcI+B2epJiFkJpX8Bk2Kct7Wt2Yut3stsTTlhqMkHh+OMd/Ra
	LSU6Gcu+kY3izKKpfSN1UPPif3ZNfIdkhjO1DH0v6lnUT2q5EZAlqOIjvw121Lqq3FMXCjrquBD
	svypDvgDHIwiqrRM1K8SmpaywN4GRKUDBVSKvN0srZQO53wupV+RmIAyLNp/ycaQEHxhgJcPSvB
	esQ77877gkM/ktIAx+CyY6biqmhXxZRDXtA535BN82iGFYLUt4eylZOY5xG/8VNsVkpkAjZ5Xkr
	nIpS4BWsOx
X-Received: by 2002:a17:907:6e8d:b0:b87:301f:6172 with SMTP id a640c23a62f3a-b87612b615amr137912666b.6.1768406044076;
        Wed, 14 Jan 2026 07:54:04 -0800 (PST)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870e33259esm1030507366b.8.2026.01.14.07.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 07:54:03 -0800 (PST)
Message-ID: <7e99edd2-f725-4226-b686-9efbd9adc2e1@gmail.com>
Date: Wed, 14 Jan 2026 16:52:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: gso: do not include jumbogram HBH
 header in seglen calculation
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20260106095243.15105-1-maklimek97@gmail.com>
 <20260106095243.15105-2-maklimek97@gmail.com>
 <3e3ef9d0-f1df-4568-a207-2a121ca76def@redhat.com>
Content-Language: en-US
From: Mariusz Klimek <maklimek97@gmail.com>
In-Reply-To: <3e3ef9d0-f1df-4568-a207-2a121ca76def@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 15:14, Paolo Abeni wrote:
> On 1/6/26 10:52 AM, Mariusz Klimek wrote:
>> @@ -177,8 +178,13 @@ static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
>>   */
>>  static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
>>  {
>> -	unsigned int hdr_len = skb_transport_header(skb) -
>> -			       skb_network_header(skb);
>> +	unsigned int off = skb_network_offset(skb) + sizeof(struct ipv6hdr);
>> +	unsigned int hdr_len = skb_network_header_len(skb);
>> +
>> +	/* Jumbogram HBH header is removed upon segmentation. */
>> +	if (skb_protocol(skb, true) == htons(ETH_P_IPV6) &&
>> +	    skb->len - off > IPV6_MAXPLEN)
>> +		hdr_len -= sizeof(struct hop_jumbo_hdr);
> 
> I'm sorry for splitting the feedback in multiple replies.
> 
> I think the concern I expressed on v1:
> 
> https://lore.kernel.org/netdev/a7b90a3a-79ed-42a4-a782-17cde1b9a2d6@redhat.com/
> 
> is still not addressed here. What I fear is:
> 
> - TCP cooks a plain GSO packet just below the 64K limit.
> - Such packet goes trough UDP (or gre) encapsulation, the skb->len size
> (including outer network header) grows above the 64K limit.
> - the above check is satisfied, but no jumbo hop option is present.
> 

Could you maybe clarify what you mean?

This check is for the outer IPv6 header. skb->len - off is the IPv6 payload
length so the packet contains a hop-by-hop header if and only if
skb->len - off > IPV6_MAXPLEN. It doesn't matter what comes after the IPv6
header. If the TCP payload is smaller than 65535 and it is the encapsulation
headers that cause the IPv6 payload length to be above 65535, a jumbogram
hop-by-hop header is still added (in ip6_xmit).

> I think you could use the `ipv6_has_hopopt_jumbo()` helper to be on the
> safe side.

Sure, I could submit another revision with this change if my explanation is
unsatisfactory.

> 
> /P
> 

-- 
Mariusz K.

