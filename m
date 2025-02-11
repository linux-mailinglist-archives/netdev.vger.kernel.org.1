Return-Path: <netdev+bounces-165219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 553BAA31049
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC783A0311
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7896253B4C;
	Tue, 11 Feb 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvYQuI6c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03BA24F5AA
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289168; cv=none; b=bXkO06vTq4ooEHcdVXWL25KKgPEDDW46F9q1l2seM8PngOp2RzeS8SM3Mrq3LSU4wHOz71lOv8mxlbQoOfORvn0T+CxBNG+Eo+yPaVwyd85UhTsYclooJUI19NQl0EhykMIIWqmdjxcNArxBXWEPb3A0zy0q4Mf1aY3FzKlcjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289168; c=relaxed/simple;
	bh=hirMgTGHSHqUkgshgRKdz/hvRvF8KEyXkXtK7FAOlTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ydfrl1rS3BvHXY9ZhUjXN1XngTB6fWQ3AyM61BYNXRnMjZX0k8R9rmrrvI57xoI4BvhVbr0IVzVPZKxvG7vxJmWCvfOQeY6fOjNBM5v3EIie2M0zjE66DCYCSBWekabDQnFo5DwOAqEqcj1GZG46n6z5DkxCAPJ0S9hiFjDZJ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvYQuI6c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739289165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JFOkigcOlo+cPqITq6LOOyh+gSUjUpzKOs27gpxkAQ=;
	b=JvYQuI6cmMna0iekW3/upa57mtIFF4RHrCTF47Zbj0OzQQkasJ0w451Au6kOE936zBWz/x
	s/G6NHKp4wO4GA6MQBOHJl/hVWOmufRs3lISxOqCPo9VNFVkK4tJ/J6+5oePbSoeYO1H5w
	uefQRn8oBB/kakWXw6taylk6RPrWnpk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-SuWmXLN5OjqW-pBnJK12gg-1; Tue, 11 Feb 2025 10:52:44 -0500
X-MC-Unique: SuWmXLN5OjqW-pBnJK12gg-1
X-Mimecast-MFC-AGG-ID: SuWmXLN5OjqW-pBnJK12gg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e180821aso33036235e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 07:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739289163; x=1739893963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JFOkigcOlo+cPqITq6LOOyh+gSUjUpzKOs27gpxkAQ=;
        b=R9DJz4E1MiGzhZDnRmSaHaYLQsSH5J3WwO0YrbqpH3fkB4Wdo4lcdVQ72uU+/YOX0Q
         GwkVDR/UKkjt1cz+vasSq6sUDEzn+wMQRbYzEeOiYtL5No8/IZvOtE+tc4l07LMFGksI
         QFgEz1mCAotZmyfIhKXG2pVef2bF5M4feQp1XDHo7FR1TxFpY/nb6Qku+i2LmTXoflVK
         ttuugRG9nBo4qbdgAFHTcKKKLvebTnx8SUlXwf13rOop9nYLSIAbsxWfxyQ8xHSJ4rZr
         QXrBi9z3bRtrH89sTIbwe2+jsyChr+3/Bkjik0Tgs58BgX4SMymPs22QMkOtjBsdFt+q
         YcTg==
X-Forwarded-Encrypted: i=1; AJvYcCUytkx5guzT17brQfJ7rUW9F73grOft2+Q+XKU95o+7FAqsdpUoWhwzdwY7a/9McSR/RgK6BO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGejwVNvfqVMOSTUe8VYFDx3IZUC2xO7k9Sn5KljzZ6alBMHl
	cfAXil/a0yfXDYqwm3i/eHERD25HbmPsjQ1XktFbZcd35Hy1OL9oqEbdb/OIqU47hzOpXoq4SF8
	XDJR7jN85TdhhfjmD19yh1EuCi+1OXOzIfp5auegKkJy0n6N7RDhBoQ==
X-Gm-Gg: ASbGncuOaAqBXp5+LSX1kupdEhAdUHlT8BvyG6atxu7ysYbnTwNCysgLZzHOTXDTZ5H
	GyHauwmaVZ9CSp7zewetfSdLPlMXbdyxk2PmPURgIIiDXPkEUzUPR2BfGLTJJ9PgZ+f3mTbA+Ax
	V8vrh3cYFXGWFBYG+p808VEG7yU5k7fbUj4xbGxjkRan2mb5v9DeV/x2gRPmudRrL7klmGM+cC2
	fibAiR3JkjKYK+AhKnk317QvjznDmRCPWoMKMKVdgPc9IS2IR7fvQGRIO+UA5DaU3xKLNXDIpQy
	vi2IzVWb0RmXblxNtD2CE5euuIstO9Wu2Es=
X-Received: by 2002:a05:600c:1e08:b0:439:448c:6135 with SMTP id 5b1f17b1804b1-439448c6335mr74900845e9.24.1739289162951;
        Tue, 11 Feb 2025 07:52:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA9mQSQnJdpEhXnycku90Q0Y08EptbfzMXWvn4BFrnfHJzfYqnB8u8BnMyOePHpOt6MUjZCA==
X-Received: by 2002:a05:600c:1e08:b0:439:448c:6135 with SMTP id 5b1f17b1804b1-439448c6335mr74900715e9.24.1739289162602;
        Tue, 11 Feb 2025 07:52:42 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394328fcb8sm70371815e9.32.2025.02.11.07.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 07:52:42 -0800 (PST)
Message-ID: <aa210895-61d0-468d-b902-93451983756b@redhat.com>
Date: Tue, 11 Feb 2025 16:52:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] vxlan: Join / leave MC group after remote
 changes
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>
References: <cover.1738949252.git.petrm@nvidia.com>
 <6986ccd18ece80d1c1adb028972a2bca603b9c11.1738949252.git.petrm@nvidia.com>
 <a800d740-0c28-4982-913b-a74e2e427f25@redhat.com> <87seoksdjh.fsf@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <87seoksdjh.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 3:56 PM, Petr Machata wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
>> On 2/7/25 6:34 PM, Petr Machata wrote:
>>> @@ -3899,6 +3904,11 @@ static void vxlan_config_apply(struct net_device *dev,
>>>  			dev->mtu = conf->mtu;
>>>  
>>>  		vxlan->net = src_net;
>>> +
>>> +	} else if (vxlan->dev->flags & IFF_UP) {
>>> +		if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip) &&
>>> +		    rem_changed)
>>> +			vxlan_multicast_leave(vxlan);
>>
>> AFAICS vxlan_vni_update_group() is not completely ignore
>> vxlan_multicast_{leave,join} errors. Instead is bailing out as soon as
>> any error happens. For consistency's sake I think it would be better do
>> the same here.
>>
>> Also I have the feeling that ending-up in an inconsistent status with no
>> group joined would be less troublesome than the opposite.
> 
> This can already happen FWIW. If you currently want to change the remote
> group address in a way that doesn't break things, you take the netdevice
> down, then change it, then bring it back up. The leave during downing
> can fail and will not be diagnosed. (Nor can it really be, you can't
> veto downing.)

I see.

> I can add the bail-outs that you ask for, but I don't know that there is
> a way to resolve these issues for real.

The main point I made was about consistency: making the
vxlan_config_apply() behavior as close as possible to
vxlan_vni_update_group() as stated in the commit message.

Cheers,

Paolo


