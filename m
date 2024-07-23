Return-Path: <netdev+bounces-112582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DC893A0F7
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22C3B22656
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A7215278E;
	Tue, 23 Jul 2024 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSKvyAbj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568EF152783
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740357; cv=none; b=kJ5ByQ48i1UQypGhM7joPho6/M1LVbFhVIEZVtmSsYVOu/Z4K8lHZB1OVLBdmWBE2pe8X9hASoE8WdUcJ4X54A5vX6sqYzmNJG9C+O9URn/Wt505PqhjGr0Fb2vBGfWnY9/00zabZEQhpd6CCG+DlZz4zVWJYmySJCWXgpgmqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740357; c=relaxed/simple;
	bh=P2j8d6eFKzRWuwItkFDaEUzgLQXpBAwb/Dty+bXecJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abdYkCbmOqcimjb6ZfyS8tY32O3ab31ZuNFhdc/NC2AbQy/4f8yyzD4ijKQ70saeBcA1fh4TgUPf1UQi8TIPu1/6mWLwx1dk+SIadLWY/Z3eHR98l9ljWjrPTEI00SDvNESv98kJIhRlvC66iE9LTkarm5CHwMvl0Qh08qW5eZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSKvyAbj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721740354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcOGbN9Ybt+tZ7q9UK3ai0SCqDCCOujNIoM+e7gmO/I=;
	b=HSKvyAbjr8Tn6DZQ9ANtiZqaA7RYCT37Yn1ASisGKCYnwL4YKN024Z8e3rOWh7WBk5NTqu
	00dagweZGGmmEMNeXU1EoxWDODFhh41Igy6qKpJcq4sW/ZQO4Cg0BrCW9hlN8owBTYi8AM
	fXq6QzeiQ25NttOHMiZ7qa3s1on+2ik=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-8P6I6xHPO0ia2-gvYKLThA-1; Tue, 23 Jul 2024 09:12:32 -0400
X-MC-Unique: 8P6I6xHPO0ia2-gvYKLThA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36845f43a96so921572f8f.3
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 06:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721740351; x=1722345151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcOGbN9Ybt+tZ7q9UK3ai0SCqDCCOujNIoM+e7gmO/I=;
        b=wFdw4JB+0Q+2SELGAuFoQQE05Jp+JgA7JeC9qW7MeyN2DIlIgXnGT9HLxwgr9z4oCy
         +2UzHLLz8IC0fA7FrySguHLkMaF7dVRGOhjGXGGhvWKGvwO59QmCDgOFqAYzzzygbFms
         tc0RMRPNCtOoIzVgRkmkA0p5Cetl/9Lgcw9wdfas6PWZJfXuMKiBI/lCNzD3lq7ufBZ7
         sRGMw1Ao9E1QsdIYGT9yipfkJCUEG87h3gNucSTHoH5L39vVLn5IR/sBXyB409JtOfk2
         5BklyZ8mKMXWT6edY42SEwuWchWlNZCnETdTfAy7U6NhXgk65+yojF8T/snfLqG+KreK
         DO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBdvn9jyptqM1uzN+Rpcv3JmF1hqVByx4KwPAzZgE+zwk1YXWrujZDa3mYCBHKFoBybff9WmcEJOKj67VDh8tFsKb66ANl
X-Gm-Message-State: AOJu0YwqD3KDj0BQqaOa5L40sfS3VDib/BePE3DzlFZw5GaTz01XhBk7
	ZEzsRGPTcuTGd3TOi+4H7tYNdIR21voDlOrhdfzOfgOTJciY3proXBsk5pTvBPSsY6F7HTu8CXu
	PBd/HJ+9KfznTpRYZllJEIszTC2E+2EmXLtBJs5IpMO3j4emlQGqyHQ==
X-Received: by 2002:a05:600c:3b8b:b0:426:4920:2846 with SMTP id 5b1f17b1804b1-427daa7b9ccmr48211775e9.3.1721740351115;
        Tue, 23 Jul 2024 06:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEds36UijHSa7qdDYF1CcpfnZplXs4Q3j7iuOIyaXdqei5TLjn29+cP8ba4IlqVaEKXwAZkVw==
X-Received: by 2002:a05:600c:3b8b:b0:426:4920:2846 with SMTP id 5b1f17b1804b1-427daa7b9ccmr48211605e9.3.1721740350660;
        Tue, 23 Jul 2024 06:12:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a638bbsm190387705e9.15.2024.07.23.06.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 06:12:30 -0700 (PDT)
Message-ID: <4286c2af-2262-4894-b745-71e18e56b498@redhat.com>
Date: Tue, 23 Jul 2024 15:12:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bonding: correctly annotate RCU in
 bond_should_notify_peers()
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>, Jiri Pirko <jiri@nvidia.com>
References: <20240719094119.35c62455087d.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
 <0b0cb62e-4e10-458e-8d21-8a082f94aa4d@redhat.com>
 <310c8cfd1dc1747cf8ffc1f5be8994d0c87a008d.camel@sipsolutions.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <310c8cfd1dc1747cf8ffc1f5be8994d0c87a008d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 13:30, Johannes Berg wrote:
> On Tue, 2024-07-23 at 12:25 +0200, Paolo Abeni wrote:
>>
>> On 7/19/24 18:41, Johannes Berg wrote:
>>> From: Johannes Berg <johannes.berg@intel.com>
>>>
>>> RCU use in bond_should_notify_peers() looks wrong, since it does
>>> rcu_dereference(), leaves the critical section, and uses the
>>> pointer after that.
>>>
>>> Luckily, it's called either inside a nested RCU critical section
>>> or with the RTNL held.
>>>
>>> Annotate it with rcu_dereference_rtnl() instead, and remove the
>>> inner RCU critical section.
>>>
>>> Fixes: 4cb4f97b7e36 ("bonding: rebuild the lock use for bond_mii_monitor()")
>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>
>> Any special reasons to target net-next? this looks like a legit net fix
>> to me. If you want to target net, no need to re-post, otherwise it will
>> have to wait the merge window end.
> 
> Well, I guess it's kind of a fix, but functionally all it really does is
> remove the RCU critical section which isn't necessary because either we
> hold the lock or there's already one around it. So locally the function
> _looks_ wrong (using the pointer outside the section it uses to deref
> it), but because of other reasons in how the function is used, it's not
> really wrong.

I think we are better off with this applied on net. No need to resend.

Thanks,

Paolo


