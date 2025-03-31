Return-Path: <netdev+bounces-178405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816C0A76DFE
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE3F188C6E4
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0F216E24;
	Mon, 31 Mar 2025 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IprQjvxa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830B21507C;
	Mon, 31 Mar 2025 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451915; cv=none; b=Zm1pX6//h0nks5tGkmcrJTf1WCOY+ASFsvlA9bG/mT0OZZQ7Y3YQpe2MeFLolf0a62/VttI9imDKCbmI2Awo81syZRwksb6RJYhp/BAIqR1haQPM6vHjzxDDZnC8ujE+kh3sSTVcu7fBkZrDpkW/QHO6q1Drd1ehJq+8ia9qmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451915; c=relaxed/simple;
	bh=OBzbiRgekCpil9D7mX+5gJrMZSeLnL5vGhu0E44lgKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hV6X5lDQR93EqO4c9Nl2qpR5+N/6llGAWbtXsBBDwjvXF9ufAW7jqUcmLR2jzKkAI8rD5SSRls9/qikOaBHOgIUS856JQFe6yIHWn/ansCKCG4T4A0gwGuw1HlVWXSI8xxlUPcMp2pe8VY6kLjFbAWGvAP/OD8PAfcE0EzG5bNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IprQjvxa; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e6cea43bb31so444981276.0;
        Mon, 31 Mar 2025 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743451911; x=1744056711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LR1OgG1N7YtLAYw3VdmcuwXI0YdDXSMCdXCbozGI5l8=;
        b=IprQjvxat1qAyqLiHmxeaRZyzVXqYEMHMMqw4EnSj8ST4VyX0fXotXr+PfDkWih1x6
         joQotgVIE/UHQT22gunaLiCVjSC17JElah1LiH7nJtW39Pyqs1crXW1sLrp1mU4TZ4SC
         JEZBV+R+0OVf0VYZZURkNJJCvDVB7AFNkgMOkwm4gqf7JzBAVwuHQPILkUgp4HMsz/Zw
         +kPA+gFgPklS4GDqVeJFz97VejRuDtDs6AhlPDDOe01o6S6Old6VpRi55w3WB1WZyikG
         aaQEICKZACdfP8y4MglHlfM6kHi0liIIcUpUAmhu2yihOsmcAFX+Vx6o/MLOpdSf2Sko
         65Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743451911; x=1744056711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LR1OgG1N7YtLAYw3VdmcuwXI0YdDXSMCdXCbozGI5l8=;
        b=UOuzQ9be2uQsXKpr2cFtPku2ny6u/tbPlz0JIY5gO8ATCvqN/Td9XiGtvj+2FIHtCV
         YwEM60J7swQeU0RQd9LHKzRUxIVezYf6W+46SmsnmYtY/AzW2r8+v3bsUc2Jp4JjPO8N
         slHKxdZnm1fE2W+NoydxbYVqTuyrbxqE6LGucbrVSnn7mUyn2PAaIVPYCcQY+sRv9JpD
         VJTsnV7kINH4mKbBRnOyKpZ6e6uSSQycG7E+9LZ2At+jtqEQueSeOKVAu2EIpYlxRikM
         gSjYaT5/kv6moZzFAZ3BaA0/zSqjeIc6NI8k0B59qrPFzl58FuwytEovn9ZB/W79O6cn
         EGbg==
X-Forwarded-Encrypted: i=1; AJvYcCUc8BYzrnAvt0D2ccjPKoE4ePXzeQf9E00XKv0vSdR66GhGvs7L6rANt4kAcVa0M+NVoDid9swNQypB6QE=@vger.kernel.org, AJvYcCWHIk+gCrgSfJ291q1J4JxTy07t/P+cq9gn0niJSaCE5FHn/EdXLAElpnxr/m01cMgX9RRMTTP8@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNQ9oJ7Om4xTOukit7RQU2u5NZQQS0TX8XWkPePOUsRk0+34P
	HCfF5ydfzphhWvnmzMQlyUCyNNDOXr0muXW3dWixK/tDp6oy302G
X-Gm-Gg: ASbGncuTjx1dssVVpudKajJ14sZn2fQ7Tjun1QYXVupOCv4eSW5tLsdrDm3uObaSd/6
	rns6xuw+pEa+YW5yToeA09QMa56ndqgNUnn9ygQ0jerBpefc2+1mb6Oi0qfOCr0biUaMjrCA4mj
	1u7bjrEMBpcFGZF3k5cPVjkVWvtGbLF23rA+WiiLUn/ZukrEzyz8Wau2QUG1lQRL52qhs5s7/JD
	QkqXmVhWsyX26kKKmFd4aofyYRT5fyOrkFHzW0gyKGpRvsI3LqsZamhPPjidsfCo49FYAr+2NNV
	hxqeb1Vr99nMJ12Ld32JQbwbQ9x8hC9V+u6LNxNIeiJc2DDtEqjm+9CLhi3mwS+5//k=
X-Google-Smtp-Source: AGHT+IH766RK/hwM7mkPwql2PqHI7sNoGHRERLD30OsqqydvJaXG//mcrrrJ8IvYqM/qPgbCxFEohQ==
X-Received: by 2002:a05:690c:6f90:b0:6ef:94db:b208 with SMTP id 00721157ae682-702572ffee4mr138081477b3.24.1743451911527;
        Mon, 31 Mar 2025 13:11:51 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7023a341a69sm23270557b3.25.2025.03.31.13.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 13:11:51 -0700 (PDT)
Message-ID: <5d93f576-1d27-4d3f-8b37-0b2127260cca@gmail.com>
Date: Mon, 31 Mar 2025 16:11:50 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 2/3] net: bridge: mcast: Notify on offload flag
 change
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-3-Joseph.Huang@garmin.com>
 <d9a8d030-7cac-4f5f-b422-1bae7f08c74f@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <d9a8d030-7cac-4f5f-b422-1bae7f08c74f@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/2025 4:47 AM, Nikolay Aleksandrov wrote:
>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>> index 68dccc2ff7b1..5b09cfcdf3f3 100644
>> --- a/net/bridge/br_switchdev.c
>> +++ b/net/bridge/br_switchdev.c
>> @@ -504,20 +504,41 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>   	struct net_bridge_mdb_entry *mp;
>>   	struct net_bridge_port *port = data->port;
>>   	struct net_bridge *br = port->br;
>> +	bool offload_changed = false;
>> +	bool failed_changed = false;
>> +	u8 notify;
>>   
>>   	spin_lock_bh(&br->multicast_lock);
>>   	mp = br_mdb_ip_get(br, &data->ip);
>>   	if (!mp)
>>   		goto out;
>> +
>> +	notify = br->multicast_ctx.multicast_mdb_notify_on_flag_change;
> 
> let's not waste cycles if there was an error and notify == 0, please keep the original
> code path and avoid walking over the group ports.

But we do want to keep the error flag so that the error shows up in 
'bridge mdb show', right? Notify should only affect the real-time 
notifications, and not the error status itself.

> 
>> +
>>   	for (pp = &mp->ports; (p = mlock_dereference(*pp, br)) != NULL;
>>   	     pp = &p->next) {
>>   		if (p->key.port != port)
>>   			continue;
>>   
>> -		if (err)
>> +		if (err) {
>> +			if (!(p->flags & MDB_PG_FLAGS_OFFLOAD_FAILED))
>> +				failed_changed = true;
>>   			p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
>> -		else
>> +		} else {
>> +			if (!(p->flags & MDB_PG_FLAGS_OFFLOAD))
>> +				offload_changed = true;
>>   			p->flags |= MDB_PG_FLAGS_OFFLOAD;
>> +		}
>> +
>> +		if (notify == MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE ||
>> +		    (!offload_changed && !failed_changed))
>> +			continue;
>> +
>> +		if (notify == MDB_NOTIFY_ON_FLAG_CHANGE_FAIL_ONLY &&
>> +		    !failed_changed)
>> +			continue;
>> +
>> +		br_mdb_flag_change_notify(br->dev, mp, p);
> 
> This looks like a mess.. First you need to manage these flags properly as I wrote in my
> other reply, they must be mutually exclusive and you can do this in a helper. Also
> please read the old flags in the beginning, then check what flags changed, make a mask
> what flags are for notifications (again can come from a helper, it can be generated when
> the option changes so you don't compute it every time) and decide what to do if any of
> those flags changed.
> Note you have to keep proper flags state regardless of the notify option.
> 
>>   	}
>>   out:
>>   	spin_unlock_bh(&br->multicast_lock);
> 

How does this look:

--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -496,6 +496,21 @@ struct br_switchdev_mdb_complete_info {
         struct br_ip ip;
  };

+static void br_multicast_set_pg_offload_flags(int err,
+                                             struct 
net_bridge_port_group *p)
+{
+       p->flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
+       p->flags |= (err ? MDB_PG_FLAGS_OFFLOAD_FAILED : 
MDB_PG_FLAGS_OFFLOAD);
+}
+
+static bool br_multicast_should_notify(struct net_bridge *br,
+                                      u8 old_flags, u8 new_flags)
+{
+       return (br_boolopt_get(br, 
BR_BOOLOPT_FAILED_OFFLOAD_NOTIFICATION) &&
+               ((old_flags & MDB_PG_FLAGS_OFFLOAD_FAILED) !=
+               (new_flags & MDB_PG_FLAGS_OFFLOAD_FAILED)));
+}
+
  static void br_switchdev_mdb_complete(struct net_device *dev, int err, 
void *priv)
  {
         struct br_switchdev_mdb_complete_info *data = priv;
@@ -504,23 +519,25 @@ static void br_switchdev_mdb_complete(struct 
net_device *dev, int err, void *pri
         struct net_bridge_mdb_entry *mp;
         struct net_bridge_port *port = data->port;
         struct net_bridge *br = port->br;
-
-       if (err)
-               goto err;
+       u8 old_flags;

         spin_lock_bh(&br->multicast_lock);
         mp = br_mdb_ip_get(br, &data->ip);
         if (!mp)
                 goto out;
         for (pp = &mp->ports; (p = mlock_dereference(*pp, br)) != NULL;
              pp = &p->next) {
                 if (p->key.port != port)
                         continue;
-               p->flags |= MDB_PG_FLAGS_OFFLOAD;
+
+               old_flags = p->flags;
+               br_multicast_set_pg_offload_flags(err, p);
+               if (br_multicast_should_notify(br, old_flags, p->flags))
+                       br_mdb_flag_change_notify(br->dev, mp, p);
         }
  out:
         spin_unlock_bh(&br->multicast_lock);
-err:
         kfree(priv);
  }

Thanks,
Joseph

