Return-Path: <netdev+bounces-171766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D73A4E82A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F011F7A7429
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253002BEC4F;
	Tue,  4 Mar 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Vm/wzv76"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F26298CB8
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107023; cv=none; b=IY05dYLRJvB3Tf4wDJ0ansKxz9r3NXlKgUY7qkiWaGbPi60rs2WH8rNz4e8WcLA05+mpHTELqEkKhRdzmDJ2UoaeTZqmyhfdpWvb68WcB5Zxpw8XVA97fFQGOLufx3BxDDz51Ig9WgCc+wledOdgj2GHxX2HV1MQNsvc97gwY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107023; c=relaxed/simple;
	bh=zrUZ2K6obbHVLkq6hfv8AXP8IsKmoHtrwEOg1loa8q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uegOyHWA6OMpkCX3E+2Xl6qdpnAR7jyv/t8LhG5xJg2sN8JuRQBUFJOEBKkX091N5zFeYx06QayNuLSQsS+rmOa5kCoZWRxtC0zD9li06Q6iMDtzfol6IbJZgZYwYDgMlW01vqlu+HJBKeLcpmARMyIPMHzvrj8wTB/QV7htDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=Vm/wzv76; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f674752049so863102b6e.0
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 08:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1741107019; x=1741711819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7tkrL+e+a2YbJa4w+KDK4bewexCr454QdQiczaO5JMc=;
        b=Vm/wzv76ieaZX2hnFuV+tlHt5eOHLM7h2glXcGiJNmS61bTW0SrTX3IjGuHlADB0vj
         ASs7BlP5mpkZO8Lg3dM0nY8YGHRk+j3vg26a8KkmME0hMZlx9liGM96dhIvjAtn9w2m8
         2+lEbD3u2sGg72n0q3/WoX2HawQJ5JXBKZ2QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107019; x=1741711819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tkrL+e+a2YbJa4w+KDK4bewexCr454QdQiczaO5JMc=;
        b=pZ0hJlPksyElW+Z7OqtxSYwQkFQzjMVedNfco3i1CVOXFdiRH1sptow6KF6bBQkvTc
         t8nYfh3RudI7+e7CjWDrVIqpAJVplHThROUw35QhaZQ83/ScRccX0uay7vU2AiasG2Jr
         9cQappUpZn7QOk+fYdhm25N5+7fNnzh5ng4BKuWQ/FQPX3FEv3/YOz+GrQ87EFIxr8AE
         ssNuBl+uh5KjKue7RT1T4KQ56w8JTAWFSXSeqN4UICo+mL/knVF6WG8Yrkjwa/J6UFmi
         VpmHMhvzILas0pEHBDC+a0MJGzIQxoMsSfA2EmpxsoUSqKzxroGoQ7bXZoSWbwWjcsJ+
         FhDg==
X-Forwarded-Encrypted: i=1; AJvYcCXhOVd3O5Bjh2ALeQnsMU5FKolmg4RiFwO6JuXd6wvTNXsOZ0l5RxdESqxUw/7kC4WoS4HJYhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpXu/Dzeeot1g1q5lDVa59F9rtvsNR6rHEqTSMmLqU2MNBscKS
	fe4Kf05r15Wo2Qol2AV1ZoZhYnnNQPju1lB3qK894Jy207A2HKsG/tULkhA5gw==
X-Gm-Gg: ASbGncukC4MukxTa5sMuRXBuwYoUBLyQe4wZY/P5eLMeZ1pyzlJ0KgJTPB290amSswk
	ZpbfQN5PNVQ97dmM8FHKT9tsANugPksNZfNYfoPaaNoelY+DY0CiJUuZcydB/cWEr3IHh5NbvmO
	ptRaBRf4DcxGFwL6YgzvXQSXuZszsrPrEbrB+Hs+Wy6b9mXzNz6lmdm0CB2oqbKD2NEWBED/+8/
	FyrKjGHw2ppfoHv8XRF4PKb7te0sSG0Yjodm7IXXGc9DkV8ak11mWJHOAUbEckOP/+beQlB3vgv
	TgbxWnb85RebhP7y4XpVYzIOmgoYXz/AyWUPJo9AQu2XOEAX8RArfbsZd4/pq5Y6jxi+Jzu7IiB
	uYh4=
X-Google-Smtp-Source: AGHT+IFWGzlfKIJoQMdZwPV2HzDzwdowvDtxXCUhLVhv6U+fgKXlNTeZeV9ExhknYcVynokP8VXzFA==
X-Received: by 2002:a05:6808:23ca:b0:3f4:cf:5d5c with SMTP id 5614622812f47-3f678f4ed49mr2747867b6e.10.1741107019054;
        Tue, 04 Mar 2025 08:50:19 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3f5506a0b92sm2255999b6e.6.2025.03.04.08.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:50:17 -0800 (PST)
Message-ID: <2246f041-3e42-4534-bf89-3630ca2426d1@ieee.org>
Date: Tue, 4 Mar 2025 10:50:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: ipa: Enable checksum for
 IPA_ENDPOINT_AP_MODEM_{RX,TX} for v4.7
To: Luca Weiss <luca.weiss@fairphone.com>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
 <20250227-ipa-v4-7-fixes-v1-3-a88dd8249d8a@fairphone.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250227-ipa-v4-7-fixes-v1-3-a88dd8249d8a@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 4:33 AM, Luca Weiss wrote:
> Enable the checksum option for these two endpoints in order to allow
> mobile data to actually work. Without this, no packets seem to make it
> through the IPA.
> 
> Fixes: b310de784bac ("net: ipa: add IPA v4.7 support")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

This makes sense.  The checksum option affects how outgoing
packets are formatted and incoming packets are interpreted
by the IPA hardware.  So with this being wrong, I suppose
packets (one way and/or the other) might just be getting
dropped as invalid.

This looks good to me.  I'm really pleased you were able to
get this working.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/net/ipa/data/ipa_data-v4.7.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
> index e63dcf8d45567b0851393c2cea7a0d630afa20cd..41f212209993f10fee338e28027739a7402d5089 100644
> --- a/drivers/net/ipa/data/ipa_data-v4.7.c
> +++ b/drivers/net/ipa/data/ipa_data-v4.7.c
> @@ -104,6 +104,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
>   			.filter_support	= true,
>   			.config = {
>   				.resource_group	= IPA_RSRC_GROUP_SRC_UL_DL,
> +				.checksum       = true,
>   				.qmap		= true,
>   				.status_enable	= true,
>   				.tx = {
> @@ -127,6 +128,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
>   		.endpoint = {
>   			.config = {
>   				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
> +				.checksum       = true,
>   				.qmap		= true,
>   				.aggregation	= true,
>   				.rx = {
> 


