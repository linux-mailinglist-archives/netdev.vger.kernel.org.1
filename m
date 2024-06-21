Return-Path: <netdev+bounces-105662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69A9122E3
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B5B1C20F2E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41E5171E4B;
	Fri, 21 Jun 2024 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="tl1V2JbR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE374416
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967546; cv=none; b=MsxzwugkM3kule/FWprlf75FeXhhLt4cJSfK0Z5zfKYik9Jwxiux0OuK75HUVZUEir/pCrgsFuhcRp+AfGMvTiNYrsDzpYtNV/awOiCM4VRZe/qN5kYYq6cX0HWy7nmhGqYUVRzhNARvcmfG8eVld+g44+lL2a1uqeEbvubAqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967546; c=relaxed/simple;
	bh=UbcHEehOhY6Kaaw7gEASkLbxyOslwmbGjY9Xl51wmKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibVILyA7s6RfJEolOYi1VQ3Fa60g+H94MtwpL0EwecJu+IixoHg9RQhMwB9HCTg5k5P2ICkYccDN8/0VmHgn16O+M/6vAqk7CrX2wopUEDCDzDXg0CXR3g19EqqrxqB4/9D8T/1poUwOmpBqulT0UL+U3JH9HsXSVZsEbif+Dl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=tl1V2JbR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d1012e52fso2107352a12.3
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1718967543; x=1719572343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uz5XAGtC4s4uJKJAGGTmFHpkVxyO1Ao8Cp4QAP+oyTY=;
        b=tl1V2JbRHq4tvpAKpt+BO80Pe3j8xnpKYRrTfo/qfPkKPVZLgGDQ0KKenO+uEofQ3K
         QiuoQK6w0JYBnEiRewb4h51JUADxOI2nbjl09ILKGazuO489EmbXVH6xVpKBlsK9K0es
         EdPt0/L9Co0B54pIo+ptZnHR1kIguF8lBheGELcWx4uYLkeiULQzVKtZ2V963uCgdLJX
         03tY2CogqPnC6t0GPNsoDflFMJDOiDvHXItUrIbJRDHMt2JItOYDlnQogGwlxGtrSwON
         ReAdiLUirqP1m4zMPCu9I7IfQFZt0S37wWtpQ1joa+Bp2Xm/et5TTzrg1lo0sX6H50MX
         xvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718967543; x=1719572343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz5XAGtC4s4uJKJAGGTmFHpkVxyO1Ao8Cp4QAP+oyTY=;
        b=FYWyETt3kV0RuwkJrIKo/eefnIaLK1ueawDyl8N8WTi8pj9Tmj8UWjsIBqSBLNrehG
         m2aP2SDVWS82eaFi0yrTC+K3vuHFqD4Sxe5ZV/IGC8Xw4zOSLD8yNxdJtDp0A3LdGxMq
         N8V0VqNji/cib6LYAYap1yWcJEuvq+plzSt2g2XSZsPcHw0/aujRDPeAZjoTYMlJTXtM
         DBn15JB7sq9vgwFojR50jY2btnjFYOv/4Duz3SfEt4jybg6Dj7L7J1M/98sDiKUy4BIy
         uwCqNse0jY2nuBaNJrUGULHpzVI21SxQB055UPprcmMAvpUXRZ3ihJlHFkj7ckG4sf6Z
         yp/w==
X-Gm-Message-State: AOJu0YwRPsu/Tb0L6QNpJILB94KNFerPFwB4czVAevCUaMGmIHmKJLR0
	VCOgACrH9BUD5h225+SCc9LqxuaxOcQYTE3KI2lb4NVzQal5Od30JvZ/KsMT7qU=
X-Google-Smtp-Source: AGHT+IEZ0k+0qF1h/P+C2B2ZK+g35UyEcl3vgxcQt+qeFkbV6tACGreDkSeqm4hcJF6BB/jOgQeGdw==
X-Received: by 2002:a17:907:c209:b0:a6f:467d:19ec with SMTP id a640c23a62f3a-a6fab613cafmr615195366b.18.1718967543018;
        Fri, 21 Jun 2024 03:59:03 -0700 (PDT)
Received: from [192.168.118.62] ([46.211.252.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b4d2sm71922866b.73.2024.06.21.03.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 03:59:02 -0700 (PDT)
Message-ID: <0c2211fc-0a24-46fa-b143-357d826af6c1@blackwall.org>
Date: Fri, 21 Jun 2024 13:58:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: 3ad: send rtnl ifinfo notify when mux
 state changed
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
 Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>
References: <20240620061053.1116077-1-liuhangbin@gmail.com>
 <1b9fd871-e34a-4a7d-b1d3-4f3fd8858fa3@blackwall.org>
 <ZnPxoFXHKQ5dAq5K@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZnPxoFXHKQ5dAq5K@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/24 12:08, Hangbin Liu wrote:
> Hi Nikolay,
> On Thu, Jun 20, 2024 at 11:47:46AM +0300, Nikolay Aleksandrov wrote:
>> On 6/20/24 09:10, Hangbin Liu wrote:
>>> Currently, administrators need to retrieve LACP mux state changes from
>>> the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
>>> this process, let's send the ifinfo notification whenever the mux state
>>> changes. This will enable users to directly access and monitor this
>>> information using the ip monitor command.
>>>
>>> To achieve this, add a new enum NETDEV_LACP_STATE_CHANGE in netdev_cmd.
>>>
>>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>>> ---
>>>  drivers/net/bonding/bond_3ad.c | 2 ++
>>>  include/linux/netdevice.h      | 1 +
>>>  net/core/dev.c                 | 2 +-
>>>  net/core/rtnetlink.c           | 1 +
>>>  4 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
>>> index c6807e473ab7..bcd8b16173f2 100644
>>> --- a/drivers/net/bonding/bond_3ad.c
>>> +++ b/drivers/net/bonding/bond_3ad.c
>>> @@ -1185,6 +1185,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
>>>  		default:
>>>  			break;
>>>  		}
>>> +
>>> +		call_netdevice_notifiers(NETDEV_LACP_STATE_CHANGE, port->slave->dev);
>>>  	}
>>
>> This will cause sleeping while atomic because
>> ad_mux_machine() is called in atomic context (both rcu and bond mode
>> spinlock held with bh disabled) in bond_3ad_state_machine_handler().
> 
> Ah, that's why we call the bond_slave_state_notify() after spin_unlock_bh()?
> Where can I check if call_netdevice_notifiers() would sleep? So I can avoid
> this error next time.
> 
>> Minor (and rather more personal pref) I'd split the addition of the new
>> event and adding its first user (bond) for separate review.
> 
> Hmm, with out using call_netdevice_notifiers(). How about just call
> rtmsg_ifinfo() or rtmsg_ifinfo_event() directly?
> 
> Thanks
> Hangbin

Yep, I think that would be fine (w/ GFP_ATOMIC of course, if under the
locks).
Excuse me for the late response, have been having connectivity
issues the past few days.

Cheers,
 Nik




