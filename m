Return-Path: <netdev+bounces-228077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4E3BC0EA9
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 11:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F6E3C55FC
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 09:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D717A2877EA;
	Tue,  7 Oct 2025 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk0mX2po"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F0A221FA4
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830558; cv=none; b=c06xcLO62M+LVyKC7hsyDVjC1H5U+QF0FGgndtJfhLMvmTmwU4XgbhVDlk5BqY8KX4L173JAoeUt6epr2eokQSjOVX0OXRyOYcqyBoqocKpYo+PV0bb8bpLOO1XM2Z37bnMioVpmoGEuxsttGT61Fclq2d/glYCrfeeZEUhhujQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830558; c=relaxed/simple;
	bh=ANui7nSl/Xkn2ryxgPBWTRhh5bFK2D731iJyqedJeoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOtcbb3QyCMNfutQMhieuvYZwscYENqfa68YJvJqYQim8f0TOEnMdJI0UmQniHFC518JzYE95hAh/1tadqOGcq17KJ2sAAZ0IohWwO0bY4gSAgEyldtRQYla9y9V+mG/dTcvt9xzuioVDl0m1ZyaX9KSJZ5mxC03ZrWJthrF7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk0mX2po; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so1010996866b.3
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759830555; x=1760435355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ueLJVSJGp+dH7ceTx92kybEsYvh5wShqzWyQZKOf6c=;
        b=Kk0mX2poGQA2CWwjSFblfgjNFKZBEagFMVfqQLdG0MdzCAszip7pWWdYxUR5DgxtFT
         JBG6g/vSM6XKV8WCQhD06GaLdYmODIIW/lbzhkPwuTMVFaMNUB1rsRySjga9FThcPXZ3
         xLwKXo3GectAcbOEtSGBoPwjlZFGGIz3gIkPYiaw1/Gsdra4Ld2pllhPSNWeDjSPUPE/
         l5fdNCXTCt3wYVfZ0vweXq+e1fGEzuB0GVGk800OypkBo5+DO1inBFXVMjElVGqEyJy9
         ZAUdFMc/s8haZOHH0Z5LnHs39sKOjvGub5u2qf0TGXBVJN1lWb3sZbquU2UyfsjS5I+G
         AzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759830555; x=1760435355;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ueLJVSJGp+dH7ceTx92kybEsYvh5wShqzWyQZKOf6c=;
        b=EoQ/0bELTTy5FxRFkP6ireN+ZT+BA3sPFAEpNLQIoGED23IeYZnR7ILPlhfMH5F5YW
         VX5SAO1jk5/cKqb5oJqP1DvamO5PEz5Eh5mRaK7sRQtP3Z3b4hleb5KgVhp4F43ihvyy
         xjmxPt7dawu7dI2gpInLa1/+oviyGIs9GOzsIcZn5JCVBpFCDp0lS/5xBsufrhTHdxMh
         MPSamwgyg/nj5qp88b99ByiiOxc7zcFgdvnxdZn+vUqwwHbB0TOlGKS/Zte2J0KtXFA5
         M2ztCMBW2W3MfS93R5gVX8//oa2J6/FVkfOAfMeX6k54d4JHPpnJW3ZaCEs6X41nNeTa
         k1gw==
X-Forwarded-Encrypted: i=1; AJvYcCXIIiVxPsedi4jokmaXuZfDKF4h6HfYc9RT/sJXJW23E5V0atdQjS0Ckx4ajUcMRsjnkIjRhZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDiWx1i7Fnzjsp4pb1MFG2tVtusMr7vzw/PvDudpOPBYIelwf3
	1ZIkB7HWItw54FHQvnfvm+2/PN2z54qu6JYO+MAmkrMH7Uo5vmTM/8PB
X-Gm-Gg: ASbGncvlGha4V9oKxZL3g5M4l5u6tX0TSXbLQ+cjYMK5myyazk3klzUxQrnHTTWvCCB
	9iSZcDFD4xpz4IkjNs1XVp+YqH8y1jjX9zpb+SpzBMkAzF2aNgPZd34wASEneTjlX1p79nRxUYe
	eyd55qqz5XjtHKpgisR2bj3kdU2P4F6Cbyxg0N9Pf1aipUVHFxZ4ED0iFldYEnMZTqp/e1BO8cF
	ipYKM3XHFVOw8mrTHso3hnXBmm53+lOY1n9EZnxsdhCdHBAv3vKZQVsmW7pz7yO3PEOJuZLRJp6
	78Z/pbaXx5FbJm9YMIRd4TM0U2+tV49iVZxSPiq+iUBdrqvvTlMs8SW/5+PQatB8APCdt/C9LIU
	+YCB78URKOykjPcb0dX3nd+fnUmvXvTrqWwm99KKsfIXmC8Z9YrpoUqIxxKGIFtRUcKRkbaMrWE
	+xUmcGITSZ7xIoMlymiklxHQstJHkmBI8ysuNkrBOZRlE61/b4B9sJfSNKHwye/qDTMjjkfpJ6S
	Heb6lvFBnk0kJ57fKKvUld2
X-Google-Smtp-Source: AGHT+IHdNBmo5UGL2aStNRTSljzwJlK0kWlaY3a8GMcFcknx+xKS+ZYnKBtQkBIZn2wOkHQpRft7Cg==
X-Received: by 2002:a17:907:d78a:b0:b3e:babd:f257 with SMTP id a640c23a62f3a-b49c1d60ce8mr2043921466b.10.1759830554682;
        Tue, 07 Oct 2025 02:49:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a177c9csm1357244066b.89.2025.10.07.02.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 02:49:14 -0700 (PDT)
Message-ID: <5b332473-b552-489c-acd6-d0b67a1df098@gmail.com>
Date: Tue, 7 Oct 2025 11:49:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 nf-next 2/2] netfilter: nf_flow_table_core: teardown
 direct xmit when destination changed
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
References: <20250925182623.114045-1-ericwouds@gmail.com>
 <20250925182623.114045-3-ericwouds@gmail.com> <aN4v1DB2S-AWTXAR@strlen.de>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <aN4v1DB2S-AWTXAR@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/2/25 9:55 AM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>> +static void nf_flow_table_do_cleanup_addr(struct nf_flowtable *flow_table,
>> +					  struct flow_offload *flow, void *data)
>> +{
>> +	struct flow_cleanup_data *cud = data;
>> +
>> +	if ((flow->tuplehash[0].tuple.xmit_type == FLOW_OFFLOAD_XMIT_DIRECT &&
>> +	     flow->tuplehash[0].tuple.out.ifidx == cud->ifindex &&
>> +	     flow->tuplehash[0].tuple.out.bridge_vid == cud->vid &&
>> +	     ether_addr_equal(flow->tuplehash[0].tuple.out.h_dest, cud->addr)) ||
>> +	    (flow->tuplehash[1].tuple.xmit_type == FLOW_OFFLOAD_XMIT_DIRECT &&
>> +	     flow->tuplehash[1].tuple.out.ifidx == cud->ifindex &&
>> +	     flow->tuplehash[1].tuple.out.bridge_vid == cud->vid &&
>> +	     ether_addr_equal(flow->tuplehash[1].tuple.out.h_dest, cud->addr))) {
> 
> I think it would be better to have a helper for this, so
> it boils down to:
> if (__nf_flow_table_do_cleanup_addr(flow->tuplehash[0]) ||
>     __nf_flow_table_do_cleanup_addr(flow->tuplehash[1]))
> 
> (thats assuming we can go forward with the full walk.)
> 
>> +static int nf_flow_table_switchdev_event(struct notifier_block *unused,
>> +					 unsigned long event, void *ptr)
>> +{
>> +	struct flow_switchdev_event_work *switchdev_work;
>> +	struct switchdev_notifier_fdb_info *fdb_info;
>> +
>> +	if (event != SWITCHDEV_FDB_DEL_TO_DEVICE)
>> +		return NOTIFY_DONE;
>> +
>> +	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
>> +	if (WARN_ON(!switchdev_work))
>> +		return NOTIFY_BAD;
> 
> No WARN_ON here.  GFP_ATOMIC can fail, which then gives a splat.
> But there is nothing that could be done about it for either reporter
> or developer.
> 
> So, how much of a problem is this?
> If its fine to ignore the notification, then remove the WARN_ON.
> If its not ok, then you have to explore alternatives that do not depend
> on successful allocation.
> 
> Can the invalided output port be detected from packet path similar to
> how stale dsts get handled?

The flow needs to be torn down, when a wifi-client moves to another
bridge-port. Both old and new bridge-ports themselves are unchanged.
And in case of the flow being hardware offloaded, the flow also needs to
be torn down.


