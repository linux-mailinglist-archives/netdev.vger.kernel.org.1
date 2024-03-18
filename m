Return-Path: <netdev+bounces-80416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBC887EAC9
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 15:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6F3B21805
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44E4D9E1;
	Mon, 18 Mar 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0ykzTtmx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507E94AECA
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771714; cv=none; b=gKnSxM1vHKJEI5OuyRznV2pQZ96+OIcCygob87V8RA4HrvDwREQtLWw4zV+t8GkbMMpdMtQfepbveCD3hQFywkbLKJNtwZ1AsTywCBmIA749SiF9D/0erdTFkhsXTghItiAT/RYM8NX2PCx5vdsCj+Xh2tPs9vR1j0BzyXyA91I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771714; c=relaxed/simple;
	bh=VLtYY8MpGMpH/fXASqsg1v/m5d2j+LdOnAoJNVQEWXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTEwopwbvyaaoXhtV7Wbv5pECcncCwGjKi1stJAKi2w0Ld03DEoJWcJk88TD3VPz7sNuqTXQTFALmz8W5OHqHDKLJYlwRzMImsai9WX0ydQg1gynRDyowNHIqymHbAZWXSyR2p1BQ/p9s5zxCHKo/SIagK3NeyI/gp8f6Jr+JAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0ykzTtmx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46cf8f649dso66884766b.3
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710771709; x=1711376509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=di7sib/siHoLr5CpBl1IAJprN/fIFu4btkdEpjYPOgw=;
        b=0ykzTtmx5heSPoXk8q4Iw/K2npWdcLK1zzvXlQfqvmS1jVMoOFrVDKPDBgBcwMqMfi
         WDDKKZLT9QKqXPTyJpB6so9+xhAX0E4iOpWjZgZ30qAdH3eR0LjtYqxmqKYiA7uNwaOd
         inZo2jV0spmqQhLJwG9WDY19FX5QC37B2V7ehya5k/kvpZ2/GXMt2hfkm4P2I/Dbv9cn
         gOYW9/aONKEp/EoaPsDVkQY14F8j3Zvh9K6NoVHUwzsNQ74KSdMGnAZ6yLQ/bbjjZPQR
         idaVzk93ZtSBVvzkFfAD37WeEq7P/C/cNBzYI7e4VuzyW1RCqZLSOKdSLZ6JhcYJfPVW
         QELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710771709; x=1711376509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=di7sib/siHoLr5CpBl1IAJprN/fIFu4btkdEpjYPOgw=;
        b=BiSV73Dmlxy0Qu5zvHkfLp8SZG5ZP0WLRXF6EzcUyACJeudE1r62QTLwTit0wpvxb4
         JBasCbgh9q9do7DUrudidkwq478nTSeSXLncrHSVYwZ48DIJL17sYxxEJzrSX1BtBTcb
         vVrBUYWB/Nk7helpa4jZwN2l6R0GGcjaurVh+BfXNYQq8ZZjhVeFhhFxgW6oGwE8Nl8y
         Q37PUHh8Jfp4wQUnLNJs3knAGGkULELGH7FuDpGruDaTwgC9HNdCUchf3llLWsKRmJPX
         9AWk3Y5z7og8n/rmJcmj4wNkr0D/elkr9NWZOxPCI+wokcJTFg+X2kbW7VgaqYSBxahT
         VnWw==
X-Gm-Message-State: AOJu0YxDmbSWauF4Jmrf9Dn2ZhStHJTRdbDvk06Cp54px+2ZjSYvZ0la
	Xp8bmXAl78zK62NBMONv01oBl5tthbocekVZavtxZDBWTmqoCcZtsVryJXS/BB4=
X-Google-Smtp-Source: AGHT+IF5tf00vAEIwnwbvzJCu5JAhPezKcAjnD0zeHabMREEiNg1W5qjOCLZkKK/U3TuRbkNmB8XmQ==
X-Received: by 2002:a17:907:7850:b0:a46:aed5:2552 with SMTP id lb16-20020a170907785000b00a46aed52552mr3088371ejc.45.1710771709480;
        Mon, 18 Mar 2024 07:21:49 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id cu2-20020a170906e00200b00a4660b63502sm4969465ejb.12.2024.03.18.07.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 07:21:49 -0700 (PDT)
Date: Mon, 18 Mar 2024 15:21:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>
Subject: Re: [patch net] devlink: fix port new reply cmd type
Message-ID: <ZfhN-9pZdeZkVBug@nanopsycho>
References: <20240318091908.2736542-1-jiri@resnulli.us>
 <PH0PR12MB548144194C053A632B9397FDDC2D2@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB548144194C053A632B9397FDDC2D2@PH0PR12MB5481.namprd12.prod.outlook.com>

Mon, Mar 18, 2024 at 02:57:21PM CET, parav@nvidia.com wrote:
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Monday, March 18, 2024 2:49 PM
>> To: netdev@vger.kernel.org
>> Cc: kuba@kernel.org; pabeni@redhat.com; davem@davemloft.net;
>> edumazet@google.com; Parav Pandit <parav@nvidia.com>
>> 
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Due to a c&p error, port new reply fills-up cmd with wrong value, any other
>> existing port command replies and notifications.
>> 
>I didn't understand 'c&p' error. Did you mean command and port?

copy&paste :)


>
>> Fix it by filling cmd with value DEVLINK_CMD_PORT_NEW.
>> 
>> Skimmed through devlink userspace implementations, none of them cares
>> about this cmd value.
>> 
>> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
>> Closes: https://lore.kernel.org/all/ZfZcDxGV3tSy4qsV@cy-server/
>> Fixes: cd76dcd68d96 ("devlink: Support add and delete devlink port")
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  net/devlink/port.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/net/devlink/port.c b/net/devlink/port.c index
>> 4b2d46ccfe48..118d130d2afd 100644
>> --- a/net/devlink/port.c
>> +++ b/net/devlink/port.c
>> @@ -889,7 +889,7 @@ int devlink_nl_port_new_doit(struct sk_buff *skb,
>> struct genl_info *info)
>>  		err = -ENOMEM;
>>  		goto err_out_port_del;
>>  	}
>> -	err = devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_NEW,
>> +	err = devlink_nl_port_fill(msg, devlink_port,
>> DEVLINK_CMD_PORT_NEW,
>>  				   info->snd_portid, info->snd_seq, 0, NULL);
>>  	if (WARN_ON_ONCE(err))
>>  		goto err_out_msg_free;
>> --
>> 2.44.0
>
>Subject should start with upper case.. 

I don't see why.


>
>Thanks,
>Reviewed-by: Parav Pandit <parav@nvidia.com>
>

