Return-Path: <netdev+bounces-153145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2569F7053
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 23:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3111687B9
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 22:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84731A238B;
	Wed, 18 Dec 2024 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="nM+dm36d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2F45005
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734562269; cv=none; b=JJJCn8Z++5X7q2W1EeKyWFCiXiqgzMNzJgx54iYFwK+WA1IIeOqj2zgJ5znN6lEA1a4xMguX+wFY2vVA/Ew8uP7fLgFWFeKboOQK/Wh32Ae6bAoLTwpbOZ58To5rwRlkKVrMx1lktIxaXW/PdISuOcDc7zszUPtjmP5/8wpRl5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734562269; c=relaxed/simple;
	bh=pfeu6CphBx8XYONSfLNbyc2r+5uhzWSh9Moeo5Nw6iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYeYQumzKsDAZ3/iEJziLjhtH8CT+KRQNdcx9zMUcH3dbe5Nh6wkCk2nWDf3LXx7LsRhQUMUWAZ4sGqCgzDg2dt5XnfS8DmFp16WkdoLcsgbaA0xjDeoPZ0oXX5PATGirC88gyS3I1BJRzc7XlEk8EI0CHI0aawOBkalYAtjFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=nM+dm36d; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43623f0c574so1085755e9.2
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734562262; x=1735167062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Sh2lkKWrEXVfvaNZPxnHHh567ZFTU/Ul8OTfVOu238=;
        b=nM+dm36dwpttIcDtb2Tc7U5ZJu7J0m9nJoRwZX4/oosWLteLLnBgfxQhUiB1WKiqHa
         dBS7SdFkH/7+kV1RhEwST3b6WAu/YspYXPl1mecuAj1veBNm1FOcCLUqQYWycURZHlMb
         xr3cIFM6L9ZFWg8RVfOdNe0F07z+xz6QU+UxIlGanMCpC5FFqxeGVPaDB7398YPddvMg
         OR9LP5sOkcvRBVa+PHBRTJj8rC9o7XRHUXnYVwGxs4ccZMd757ku6W6CAMafiYTNGqH1
         ELBtpGPnVSmRplWuaAGZ8yALMv3rHBhQQe4e958wXE8AzHkDJdz8zK8V7Jgd3piANXD/
         CIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734562262; x=1735167062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Sh2lkKWrEXVfvaNZPxnHHh567ZFTU/Ul8OTfVOu238=;
        b=RndZJyZ9cUGa9H4V2Bzg75RaYxJbWxuG/AlyNwBVUR10by/d0p8l9ZUrNLWqUqxrjz
         Smb8C0V2oSOXJ6+ZogAOGKc0VRCkKMNogQuS6NHzb3zVCW+zPIGkIGsNGN9iTng4gk38
         YNruMpNpqE7rTgoIwrc6nXSMQkczzTgDetic8u8S01xvToLx5eKPo8hrfLYdC5Lmom/2
         5svzM8xdwAwFLOvv0vTITfSm3FQu7mtKS/3vgE7/0vbsqzJFbrmkaY0d0bbfpvbOMXHv
         MFJtk2TQ+mEWRttbC04OE2SMK3O/sxOiAa60B9Y3UiiDOt24lYA6turont9uI7GJGA2X
         MGmg==
X-Forwarded-Encrypted: i=1; AJvYcCWjc1gvV+cPFWHIV7MWu99Nk7R4JHEnLKIqVPA0qpwlc9k/Q/n5pKvuTusUCVu+q4ArWWvF23k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHRuPeVUYBPV2MnijYhLkoDPS774EA2sY3WOtJxpfNOxMCTI9Q
	MXW1VjGmbOlibpf3l3DMSkJ7kdLteNNYp7DsyZc8luiVuFx5hmXAL9caKlp79+A=
X-Gm-Gg: ASbGncv1JBY3ZPJNhwVEn9Zp8EIfaHQejrw34Jfm4Biq7rOm1/p9H3MeJYbac1aTcJm
	zhLnxk9Cgd+zukb7qZbMeeK7UAdpKV7jTRGKmro7UFx71tHTR7Ta9W0f9N7DTttgRA0BO24KAfU
	qmEmT7RKaMzIN4nIFXkMtMCCpbcwOZQLbT1a2WxySsUd+8RLQpoEmXFuhYpFgojsnrE60xbImkF
	nq3Ch0lE2KtlAI1C6U1RIGf8wS4pFhU9b8KdUQDTLCgc/iLuhA9Xh+JEE2nHOr6nqRQYWWmEs/K
	hn+3nqD/AFpJ
X-Google-Smtp-Source: AGHT+IHuZVsxI+GEQrhRWdTxRTCg3/MtW0+1GHNr42Nv6drkEzWGgoKTkPpYOZRJlGGFAR5E4/1P7Q==
X-Received: by 2002:a05:600c:1c1f:b0:434:f1e9:afb3 with SMTP id 5b1f17b1804b1-43655347f59mr44852415e9.3.1734562261748;
        Wed, 18 Dec 2024 14:51:01 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6d02sm34241395e9.1.2024.12.18.14.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 14:51:00 -0800 (PST)
Message-ID: <0b0dd0fa-cf7b-4654-ab25-3e6d80615bf1@blackwall.org>
Date: Thu, 19 Dec 2024 00:50:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: bridge: add skb drop reasons to the
 most common drop points
To: Ido Schimmel <idosch@idosch.org>, Radu Rendec <rrendec@redhat.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
References: <20241217230711.192781-1-rrendec@redhat.com>
 <20241217230711.192781-3-rrendec@redhat.com> <Z2MEOvn4dNToq5Fq@shredder>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Z2MEOvn4dNToq5Fq@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:19, Ido Schimmel wrote:
> On Tue, Dec 17, 2024 at 06:07:11PM -0500, Radu Rendec wrote:
>> @@ -520,6 +522,16 @@ enum skb_drop_reason {
>>  	 * enabled.
>>  	 */
>>  	SKB_DROP_REASON_ARP_PVLAN_DISABLE,
>> +	/**
>> +	 * @SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL: the destination MAC address
>> +	 * is an IEEE MAC Control address.
>> +	 */
>> +	SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL,
>> +	/**
>> +	 * @SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD: the STP state of the
> 
> s/SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD/SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE/
> 
>> +	 * ingress bridge port does not allow frames to be forwarded.
>> +	 */
>> +	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
>>  	/**
>>  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>>  	 * shouldn't be used as a real 'reason' - only for tracing code gen
>> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
>> index e19b583ff2c6d..3e9b462809b0e 100644
>> --- a/net/bridge/br_forward.c
>> +++ b/net/bridge/br_forward.c
>> @@ -201,6 +201,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
>>  	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig,
>>  	      u16 vid)
>>  {
>> +	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
>>  	struct net_bridge_port *prev = NULL;
>>  	struct net_bridge_port *p;
>>  
>> @@ -234,8 +235,11 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
>>  			continue;
>>  
>>  		prev = maybe_deliver(prev, p, skb, local_orig);
>> -		if (IS_ERR(prev))
>> +		if (IS_ERR(prev)) {
>> +			WARN_ON_ONCE(PTR_ERR(prev) != -ENOMEM);
> 
> I don't think we want to see a stack trace just because someone forgot
> to adjust the drop reason to the error code. Maybe just set it to
> 'NOMEM' if error code is '-ENOMEM', otherwise to 'NOT_SPECIFIED'.
> 

+1



