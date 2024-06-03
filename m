Return-Path: <netdev+bounces-100060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14528D7BE0
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7034E1F218FE
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6222943F;
	Mon,  3 Jun 2024 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="eZIDzN61"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE506374C3
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397524; cv=none; b=U9O4zx+Mm/yiE1fEQMRuXQWFZ5+w2BU3mxqZS40J0cXYXvK7+PnPpFzsCENUtCJfL0RR3H0rgmOK7EYk9cz8m1ds6C9N3Xf/JCgS76O3qVbcfeG619dT7JML9RMrt8VGyIt/yBmwMJq0r8OqBbRttngGuq2SLqgqAwsy2BIeyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397524; c=relaxed/simple;
	bh=pBLH2mMSraRi2KpusE2I4Qlfq4oHP8hJLVd36IxuLT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjlUkDD17FE00I1HWPdt/WD/GsX5YF9Q5HRJCc/g1F0h41hL7Rz1BOhxGGfTpiEEDrawf7+lHLpXYRBf0ZP5dRMOJ7TDx4M+gklo9752f3iqy0/jcMkyY0AQQG4M335BRYNOzRfmaQ6MtfeCPh5tl6RqvXip4nmRNkiW4Iu9PuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=eZIDzN61; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4213b94b8b5so5700015e9.0
        for <netdev@vger.kernel.org>; Sun, 02 Jun 2024 23:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1717397521; x=1718002321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qtAerGXJV52H8XPL04YyadUpIeZOtwQRXX7c73AqkD8=;
        b=eZIDzN61fICiVPeEhWZX8cC2RQzMeX4RKGINi+Um1kgz0xxO0lXQ91Aab1PVkmAZny
         gDhJULVM49FabMS+R8J/qWb9XfymptOQ2S76gKRRthVzrmmv+vWx2vzR+N1EPknhIQjZ
         Y9J9sdTWwTzZ7qr5Zhij2IwCt7V4HakrEUgNN6bfQ94QIRDZKwGzq1ujtooIxZmC7rgc
         tuPyn32aXEeBbBRuB0oLTTfbia689nnKDKDKye5wv/DQVYsePNqoUNqYYtxrg1VjdNZz
         wT0RIqTCzH1RJ45i1+WS9ARitxLulZNiGZrXIY+dDYLVaxYdTnoPrrUGNrjwmyBDAIyW
         gULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717397521; x=1718002321;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtAerGXJV52H8XPL04YyadUpIeZOtwQRXX7c73AqkD8=;
        b=mGZkm1qreP4CvQ2CYYYfQIlIX89S7LA0UHhxjPsojiiHVJUqlhmOhBh7sqoQqLMDQn
         lqvS9M+LUY43wfzUtNX+xoDYvO/gZQD0yQNmCPz5VD7oJ1PxXzh6j+6kYZ/Ob46+qgcd
         j9OUVjWEnGkL0UupTBVA8mv9iSB/l62XzFgFC4ti5kdJXoIo0PRGbI1rjOvfl1TQE/vQ
         6Rjj6spF664YBkFAlAmM3ye5/uMjezhjTgyPoC+bHwosIAI60uoajaHZtIhh1Weyn0Yg
         VJsD4OwDZ94VnrJ/y5NFwZ9sUzfgIr+1df6gp7QQZJjMNcbrsD1aXmL+1q772E7ARefV
         M8bw==
X-Forwarded-Encrypted: i=1; AJvYcCWmqDaQyXgmaCpRJG5HctbHxe2rabbjh/lzmLZWIt2MudOe2vAVDScDhPS3HfTFhQZqTNuzLldbOWb/tTP6gmQgykih3CK/
X-Gm-Message-State: AOJu0Yzl+qNhVIDWp4oty5iEOYPmbwBIiQNPJiWktFIbtKnjH/AUr3xB
	IlsXoU7BZzXO4rWiRtoN5mcxAiR5cQEnmp7sF2KGhiRHkFAo0LIOaluRfJzBakM=
X-Google-Smtp-Source: AGHT+IG81wM87zji4p0D+MiIts2WON3PJClKnVI/8JUd6cpDepfeZpU3kf2iWKojL5gwCaQ59G7CcA==
X-Received: by 2002:a05:600c:5488:b0:421:3464:dc7a with SMTP id 5b1f17b1804b1-4213464df71mr50803985e9.39.1717397520792;
        Sun, 02 Jun 2024 23:52:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:703:22:2537:ab5a? ([2a01:e0a:b41:c160:703:22:2537:ab5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0f7esm7873691f8f.22.2024.06.02.23.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 23:52:00 -0700 (PDT)
Message-ID: <d67d91dd-7a6d-474d-8041-5367f3bf8d26@6wind.com>
Date: Mon, 3 Jun 2024 08:51:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 2/4] net: ipv4: Add a sysctl to set multipath
 hash seed
To: Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20240529111844.13330-1-petrm@nvidia.com>
 <20240529111844.13330-3-petrm@nvidia.com>
 <20240530180034.307318fd@kernel.org> <ZlxUZcDdLanjcGAb@shredder>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZlxUZcDdLanjcGAb@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 02/06/2024 à 13:15, Ido Schimmel a écrit :
> On Thu, May 30, 2024 at 06:00:34PM -0700, Jakub Kicinski wrote:
>> On Wed, 29 May 2024 13:18:42 +0200 Petr Machata wrote:
>>> +fib_multipath_hash_seed - UNSIGNED INTEGER
>>> +	The seed value used when calculating hash for multipath routes. Applies
>>
>> nits..
>>
>> For RSS we call it key rather than seed, is calling it seed well
>> established for ECMP?
It seems standard for me (we call it like this in our products).

> 
> I have only seen documentation where it is called "seed". Examples:
> 
> Cumulus:
> https://docs.nvidia.com/networking-ethernet-software/cumulus-linux-59/Layer-3/Routing/Equal-Cost-Multipath-Load-Sharing/#unique-hash-seed
> 
> Arista:
> https://arista.my.site.com/AristaCommunity/s/article/hashing-for-l2-port-channels-and-l3-ecmp
> 
> Research from Fastly around load balancing (Section 6.3):
> https://www.usenix.org/system/files/conference/nsdi18/nsdi18-araujo.pdf
> 
You can add some others:

https://www.juniper.net/documentation/us/en/software/junos/interfaces-ethernet-switches/topics/topic-map/switches-interface-resilient-hashing.html

https://www.cisco.com/c/en/us/td/docs/switches/datacenter/nexus9000/sw/6-x/unicast/configuration/guide/l3_cli_nxos/l3_manage-routes.html

