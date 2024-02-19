Return-Path: <netdev+bounces-72852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F2A859F38
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3719A1F22759
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1F2376D;
	Mon, 19 Feb 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XFFiFisl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA6223772
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333584; cv=none; b=VbG88ZCYa83lDzRx368SsA50FbErIHPQKNM/fpdGnvCK1WOun8bPPHr1LGSs4gRjhm4yhGwpamTrlhwbxgkiOD1pO4B2/119pXAc4OxysqTyR2NG655c+d7KVNeqlzAtQ7aqoG4icb1TldLxMdX9h3Er2nzQHC5SF6qa/BfHPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333584; c=relaxed/simple;
	bh=vNA86siiVYo98e7OxqMMGWmjpnEWBdjaSnb8rCGzy2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL0dR7QtMmD50xioE1xQV3uN1n7Q/Ip3SgBiRakCj/YcR2X7Vw798g1eKnFrhMHeKHyi24Rd9pwuES4vmraVdJQb3IM5E4yMRLp1G+ikA+eGC5MGc444effnHuDvC5eHjpal4Vzy21dLZAvIP6EyUwjiKvHm6UYDRcG/UekaTHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XFFiFisl; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso34755271fa.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 01:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708333581; x=1708938381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGF7UvODRbTRcWLN9K5qWP6OVu/M2POJV7aO6clY4Ho=;
        b=XFFiFislTwAvV355yGKqHz+KxoM75/lIK8+Bh+VVqi3sLiF1ehyQMljs8BP8tLKEiT
         prigyT2+ZH72XFS9+QwqlTdfpmF+kKz/HU+puHiNXl5emBdcoWiJEm1O3GXasc/dTE2Q
         nB4nraynxnuvT7JWzwAtqD0g+9oXFWcMjzF/J1mnLhW06z+LbV0WSZluc38qiZePeQo4
         dTcjPaEZLWhiovR5GcPP0X+Ncc/piZiF72TxjZ8cZqimx3K3KuotV9szE8h1ySwfMm5i
         +ZIHOUOL7IadkFFgfi8VwAsOX2k8W7nO/iOqIs/5TPrHSHfXbajzGpXW9XSAVHNoqHtm
         Uieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333581; x=1708938381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGF7UvODRbTRcWLN9K5qWP6OVu/M2POJV7aO6clY4Ho=;
        b=HdE/TYpzYTW6rl7yeWZNgUefkWQ/KN68gVRZMoFc6UlAqJtGxE9RJGX7WRM9oGOPxo
         TzT6otfMJh0Bk2wmR28RZiUOq8TKNQ1UDc/2+HqVb+JkRXhKIBe5iHJHE7c1p0AkdY52
         BqTJfU5ebeSmbSkoxb+wxiHAcbiBH0f47pYeAI0BTdPNe8atkCSP4ylqtYlQQDE1kewG
         NdQFqEwARJm3VxMRPhvFcn5WCmgftd+ZJlIAGBSInyBt+apD0R7N1ck7LCjThav8ApaY
         H2wWU9KHFgE3qTtxjLrHtyy3YWqS30gU/gFkYcoUN2TGzJJOuvVGUklaBKDEuqfqQHfS
         8jBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0daZ51r8AedHHpXrOkb934HRp6XOkewKB74huMUv7NTbKnH4W3XuuMrLWvceABpU2czOrefNXZO/y4e9r64UmZ9tKxVhF
X-Gm-Message-State: AOJu0YwkW44xfrFViui+4t66YKHMAiWXY8W5iAMxFy34CaqdgxKr+eA/
	VnkIAABbs6NvCHRiqTKsdCpjIj/KsWpOynpcYQy8S2dhlsDXs552TsUxsbkAVlQ=
X-Google-Smtp-Source: AGHT+IEwOvxFmRZcL+F6DuZWGSdJRa8yr4JwlPXMX/9UC7iKJJyLeRQ69t7NWT4rk+eLq3Oq6uaV5A==
X-Received: by 2002:a05:651c:509:b0:2d2:215e:157c with SMTP id o9-20020a05651c050900b002d2215e157cmr5261144ljp.7.1708333581016;
        Mon, 19 Feb 2024 01:06:21 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d5184000000b0033b4f82b301sm9866724wrv.3.2024.02.19.01.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:06:20 -0800 (PST)
Date: Mon, 19 Feb 2024 10:06:17 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: William Tu <witu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
	bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
	saeedm@nvidia.com,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <ZdMaCfWRf9qpDSGR@nanopsycho>
References: <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
 <Zbtu5alCZ-Exr2WU@nanopsycho>
 <20240201200041.241fd4c1@kernel.org>
 <Zbyd8Fbj8_WHP4WI@nanopsycho>
 <20240208172633.010b1c3f@kernel.org>
 <Zc4Pa4QWGQegN4mI@nanopsycho>
 <20240215175836.7d1a19e6@kernel.org>
 <Zc8XjcRLOH3TXHED@nanopsycho>
 <20240216184332.7b7fdba5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216184332.7b7fdba5@kernel.org>

Sat, Feb 17, 2024 at 03:43:32AM CET, kuba@kernel.org wrote:
>On Fri, 16 Feb 2024 09:06:37 +0100 Jiri Pirko wrote:
>> >We disagree how things should be modeled, sort of in principle.
>> >I think it dates all the way back to your work on altnames.
>> >We had the same conversation on DPLL :(
>> >
>> >I prefer to give objects unique IDs and a bunch of optional identifying
>> >attributes, rather than trying to build some well organized hierarchy.
>> >The hierarchy often becomes an unnecessary constraint.  
>> 
>> Sure, no problem on having floating objects with ids and attributes.
>> But in case they relate to HW configuration, you need to somehow glue
>> them to a device eventually. This is what I'm missing how you envision
>> it. The lifetime of object and glue/unglue operations.
>
>My desired lifetime is that the object (shared pool) gets created when
>the first consumer (netdev) appears, and destroyed when the last one
>disappears. Just like you can configure huge rings on a NIC while its

***


>closed and that won't consume any memory, share pool shouldn't exist if
>all its consumers are closed.
>
>The tricky part is to come up with some way of saying that we want
>multiple netdevs to not only use a shared pool, but which ones should
>be sharing which pool, when the pools themselves don't get explicitly
>created. Right?

Yeah, also, there is limitation of who can share with who.

>
>Gluing to the device is easier, IIUC, once the pool is create we can
>give it whatever attributes we want. devlink ID, bus/device, netdev,
>IOMMU domain, anything.

I'm confused. Above (***) you say that the shared pool is created upon
first netdev creation. Now you indicate the user creates it and then
"binds" it to some object (like devlink).

So, do you think there should be 2 types of pools:
1) implicit upon netdev creation
2) explicit defined by the user?


