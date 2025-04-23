Return-Path: <netdev+bounces-185104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1201AA98871
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A8F1B60C69
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BCB26FDBF;
	Wed, 23 Apr 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2pMewPWH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77026F474
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407437; cv=none; b=S7U4LEB4Zg5aJw++cI7/ebJf8frh8HwjCtay/k+SlBYYcNjbgyVZeveUrStcDmEt199Qojs4jwBvk6pbgGp3stnsnRXEEaZRMSqegTKV2mFCy+M6RQRzqqr9eOzqkN9xziDUWh6Q9SAP/hqwe+VpN7BILwWMuKoM5Lt++e2HjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407437; c=relaxed/simple;
	bh=l8LGg0F81+N6cw41X/lKwbp5W4xYBAtha90hu3ShKYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9oZnygKIT2AnYjXrvklpvWlIHto/ekwqxGDTjriMJpw6no+nNddAKxPCMk0k+B2Gmq4+ODqdU9emXYq4+IRAIu/vnkc0iI5anT+Kz9I9J/ZiBe1DRfU0Y0IOZEiXnoBK6LUNd3PJuY1elm+14Zpe19MO/P2KG/cTewqsoE+VHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2pMewPWH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0782d787so44474075e9.0
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 04:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745407433; x=1746012233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lWGbXtdFd+dG2FXpu6WFOM3oFNsG3znjZmpVHsQxo0=;
        b=2pMewPWHmIdXo0K1lMshPN8AZLkf3tWxQmeyQcw7aKzcpz4J+E/TtLHB8aA3JQLH5S
         skKZWHYlC8NcztXOmtVIbzH0P83sA7cYOvN/M0YAQERzuOOhAZJYsWr3lFaJCNiJlCyb
         5xxfT2Z0TfhGIz0VXChW1zyDEB60EhKBT7JrIuUJ+4NMyKL4lKYoiVvE/7dmS2qms5bz
         VK3pz87MnANxGEguPPmG7Jr/+oofsUJCP5LkGK47A3aNHR5WltmjmbSVv/avsw4cXPPK
         CApjl7p92YIEjt+uif1sQXWrGJ2Egi7WawJAmhyyoK3fdETNLaQsTlLTcQPcA59PZhAk
         oU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745407433; x=1746012233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lWGbXtdFd+dG2FXpu6WFOM3oFNsG3znjZmpVHsQxo0=;
        b=hMIbCe5Pi61cHnH+8NcqJg+IhIJAvuY75dx0SWXjV2INX/Ucp8WScyPkxB4rlyW0fR
         vQ0Iu6qaPNJkS+rjakttJr+Q0+oAN1IpAk5jWyTkmaf1LmhUjkEtOuTV++8i/WK0d1cB
         M4FEEUYNYS13ZXUy/Y0Irhe2QDfKjeC+PsnCk8QLI29LT/5EfhXzGSW5so0Z1dkbd2V1
         XHBtSpHE86Jcpd5ZCggpS3l4NbVtmQAOR/M3mtfOzM/9ynubae1JdtIQCDjskfA+nFUD
         crecg5Zw5xEzZU3e0wcrzN5VOYnVGZ94K1bNZA8hioN7MVJeVWqd0cxXw+PwPEeWpofB
         Jsnw==
X-Gm-Message-State: AOJu0Yz3CnBivvQN1U3ikgf4ttjGqhoxKs4BwIacwxSYOxKo+/Nt4IaO
	OPC1WZr16/i/+kOYIARv0czeWAHO/70v58WxezUDWzLIaW5bZ9POL7tXNRoeX24=
X-Gm-Gg: ASbGncve/yf1UXL72J8R9nyZohS1ULWU6Uct11X/EcbMO+L9oOf5TEmtm4e2PhdigVO
	Zpi2J5xFtPPbRBIZ+efslUcWfzQ6EFXwDOE6Ov8LHoSiRtc4qg0B56RZksYy2QXQ9yBdCx5Ks6l
	YMD2EudU2wUUtkQxGQKaItyUysTFnFjAUWpnISf8OvVmugRLFPzYTK2D3Prony+WlYC15WstN3q
	vQzXObvaWqnn06RLkFfIcdwOqhqmiq3uJ0C99R4BulSrL+UtDAXYXUqCQOulT8s/+y2Y2YjZNnL
	BppYxvgw+c1zq30KN7Y3P6q1F8vQXSNmamVZd65rAFcQbYIn
X-Google-Smtp-Source: AGHT+IHetAy9NzS/XaUnq+fr/dNyveb69TP7AxEQ8YrvIPn6sihglgf+F8GR5p1jyeAyP2jQIEGCPQ==
X-Received: by 2002:a05:600c:1547:b0:439:6118:c188 with SMTP id 5b1f17b1804b1-4406aba756emr143981255e9.19.1745407433317;
        Wed, 23 Apr 2025 04:23:53 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092dbfceasm22723185e9.38.2025.04.23.04.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 04:23:52 -0700 (PDT)
Date: Wed, 23 Apr 2025 13:23:46 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, tariqt@nvidia.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <25ibrzwenjiuull524o42b4ch5mg7am2mhw5y2f5gb6d6qp5gt@ghgzmi7pd2rw>
References: <20250416214133.10582-1-jiri@resnulli.us>
 <20250416214133.10582-3-jiri@resnulli.us>
 <20250417183822.4c72fc8e@kernel.org>
 <o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
 <20250418172015.7176c3c0@kernel.org>
 <5abwoi3oh3jy7y65kybk42stfeu3a7bx4smx4bc5iueivusflj@qkttnjzlqzbl>
 <20250422080238.00cbc3dc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422080238.00cbc3dc@kernel.org>

Tue, Apr 22, 2025 at 05:02:38PM +0200, kuba@kernel.org wrote:
>On Tue, 22 Apr 2025 11:18:23 +0200 Jiri Pirko wrote:
>> Sat, Apr 19, 2025 at 02:20:15AM +0200, kuba@kernel.org wrote:
>> >On Fri, 18 Apr 2025 12:15:01 +0200 Jiri Pirko wrote:  
>> >> Ports does not look suitable to me. In case of a function with multiple
>> >> physical ports, would the same id be listed for multiple ports? What
>> >> about representors?  
>> >
>> >You're stuck in nVidia thinking. PF port != Ethernet port.
>> >I said PF port.  
>> 
>> PF port representor represents the eswitch side of the link to the
>> actual PF. The PF may or may not be on the same host.
>> 
>> Ethernet port is physical port.
>> 
>> Why this is nVidia thinking? How others understand it?
>
>Because you don't have a PF port for local PF.
>
>The information you want to convey is which of the PF ports is "local".
>I believe we discussed this >5 years ago when I was trying to solve
>this exact problem for the NFP.

If you instantiate a VF devlink instance, you would also like to see
"local" VF port? Does not make any sense to me honestly.

Why PF needs to have "local" PF port, isn't it a bit like Uroboros? The
PF devlink instance exists, the ports are links to other entities.
What's the reason to have a like to itself?


>
>The topology information belongs on the ports, not the main instance.

It's not a topology information. It's an entity property. Take VF for
example. VF also exposes FunctionUID under devlink info, same as PF.
There is no port instance under VF devlink instance. Same for SF.
Do you want to create dummy ports here just to have the "local" link?

I have to be missing something, the drawing as I see it fits 100%.


>
>> >> This is a function propertly, therefore it makes sense to me to put it
>> >> on devlink instance as devlink instance represents the function.
>> >> 
>> >> Another patchset that is most probably follow-up on this by one of my
>> >> colleagues will introduce fuid propertly on "devlink port function".
>> >> By that and the info exposed by this patch, you would be able to identify
>> >> which representor relates to which function cross-hosts. I think that
>> >> your question is actually aiming at this, isn't it?  
>> >
>> >Maybe it's time to pay off some technical debt instead of solving all
>> >problems with yet another layer of new attributes :(  
>> 
>> What do you mean by this? 
>
>I keep saying that the devlink instance should represent the chip /
>data processing pipeline.

It's instantiated per-PF/VF/SF. For VF and SF it represents the
function. For PF it should also represent a function. There is a concept
of per-asic faux device and related devlink instance I sent as RFC
patchset that is on top of PF devlink instances. That is the entity to
represent the chip and missing piece. Does that make sense?

https://lore.kernel.org/netdev/20250318124706.94156-1-jiri@resnulli.us/


>
>> We need a way to identify port representor
>> (PF/VF/SF, does not matter which) and the other side of the wire that
>> may be on a different host. How else do you imagine to do the
>> identification of these 2 sides?

