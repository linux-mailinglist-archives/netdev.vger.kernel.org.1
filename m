Return-Path: <netdev+bounces-172616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA71A55891
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEB23A6EBE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F05206F2C;
	Thu,  6 Mar 2025 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqwsjTqm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F2F20469E
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295792; cv=none; b=Qhl2Nvmz028GFUxp9lq4GpwZDDWO7MvA83xydpiK88Rv51v/qLZYeNKeIsdd4Dom15ua5FnHyGy9QDfmi/m8NWr/dC7PxtsnwF/Cr7dP18sT8DMBDwEeZGT+xZVjL92+ikvosZlB6drCa6i/HEv5ocGp33uZNxsa/Ay23z0iZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295792; c=relaxed/simple;
	bh=n22ldQ/gG95WZO5zqXtM1DtP2/7I6Rt4YVNpfpSg5ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2VyUrxVsWMdMLUClo5QLadBPQPClIk3pGPam2aCoidlANtNW91CrSspiIEFG9nb3XdCb/ZPPxtppa8eKVGvEohGG+MSrNPEYa56oRKPXEKK70X9TLVWU8xVCoj7bduSIiLxuZOawG7zxoSenKryDXsEssB5Y7nIDAunXtLveoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqwsjTqm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so637257f8f.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 13:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741295789; x=1741900589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Euc97A5bwLX1GQ9VseyDcYvpTEdymLIFlOX4elkCbFA=;
        b=IqwsjTqmfGuDZCyYJZ4QP3CZQj39w/a6bxri/Bj+KaziDhnJ8pG25OXhNH5w2Fj291
         DmqGTb1xUzq0wcLhhAj0drq4Neatp1IP+aMuYWsCWQwPJcMazt6UMCe5j9kxy9rA4Al3
         5WfdbmVAWlqHS9kD92ZC3pe5bDL3oHQGssXeh+jAjYv4Z33USn97X2OJMcfWEqPnFdE5
         qgAPw5hCpvcWEBlBqetygMkcgRU33slnRqqaPOMaIkav0bPXEXaEwRk6pAEX4Y1VN2cn
         KMRw6VkI/uwrGtJ2MMdPN9eSw387qpl6CGDQ7KdOpg3ZVPG/sQU0+HsaNP7toVKbOUjX
         RUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741295789; x=1741900589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Euc97A5bwLX1GQ9VseyDcYvpTEdymLIFlOX4elkCbFA=;
        b=oPIeJ+Vrvd5RN8Ibo1b9BNPOjLgi9PjQTReOLgz0cgP2ncOaRXDomywS1viIdba27S
         JQ3MsSVcO9uM5iuxcuUVXfe4pbhccVOnuincPdIqbI7YUa10fr8kTlb4SMbEOLYp42VX
         ziw+awxgRtY5GePFq0Ir16nQJ6yDIWapz7JQ2AmtrBbhaNajpLbFRp63ntm7uGCTS0mC
         sYEd4opiY5gZ9sx+Qbwf5sjQ7vWzAHWOP1RJtEcO3OvdChUCwRfiDKGAZWfB9uXAJsON
         GTX7msnAB+r3bEKd5wHMIwV6Y1toGrP4J0kuT+pUlw078cTfKvaRNFPzA/0JqpRlt0ao
         xVNA==
X-Forwarded-Encrypted: i=1; AJvYcCXgQjsumjCf/WljIsJHudsONHWhNHd+wH0cqDRqkJ4MZCYLYMZmxFt3GP6WDtu26iZl3da5TvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIoByRMxolqPVVCB9wW0Brvu+eJpo2gs6HCYdXVG6nQNtXA7h
	9cPvJMTXAw4gJEIvmaoi4ZEN88U+nvpLy4iMg9DIi1NbqTVmCIg2
X-Gm-Gg: ASbGnct/+G3qrIbVGdgjTyWCnLfKVQATdlN+aRlDRK9ddkO126eaLq6uAf/31zBJKjV
	x3sDOobQtX5ENhNFqI13iaN2IOCmzx1kaIh/6Catr+Oxo9oDkz+Zlh/ffDHtvVCPaeYXFAXhfDI
	GwfRP9c7nhasT65ibWxnF+FB2OeDiHFeMt1cCDKxTiuXunqAeVaRe7rdK1hGYd9h4EXhsbF1Cmg
	8O8qpQMDNMdnhEQLnhqdyuWSPmAF8QmcwDmXDBRSgsHK0j3LaXIZ2dOHK7RPx060CdwGsZAq20E
	1vYVL5Zqo3UdcRlcfZexqetjmk+/XFjUemMCKRaCfekQuKov181/PmmXl5zgvK7hVg==
X-Google-Smtp-Source: AGHT+IGBy4eQXJf1D0ET+asqjlhgKEeSahw7txELxtRDP0dqj3cD0z8d2TmYlZr5ORgaYGu/HIrLLw==
X-Received: by 2002:a5d:6d04:0:b0:38f:28a1:501e with SMTP id ffacd0b85a97d-39132d75ec4mr478482f8f.8.1741295788746;
        Thu, 06 Mar 2025 13:16:28 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c101febsm3100753f8f.81.2025.03.06.13.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 13:16:28 -0800 (PST)
Message-ID: <7b9527c6-bb47-4063-a770-0e69f52856b8@gmail.com>
Date: Thu, 6 Mar 2025 23:16:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch,
 Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20250303133200.1505-1-jiri@resnulli.us>
 <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
 <20250305183016.413bda40@kernel.org>
 <7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
 <20250306114355.6f1c6c51@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250306114355.6f1c6c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/2025 21:43, Jakub Kicinski wrote:
> On Thu, 6 Mar 2025 21:20:58 +0200 Tariq Toukan wrote:
>> It's pretty obvious for everyone that responding within 24h cannot be
>> committed, and is not always achievable.
> 
> On the occasion that you are too busy to look at the list on a given
> day you can just take the patch via your own tree. It's not like we're
> marking the patch as Rejected, we're marking it as Awaiting Upstream.
> 
> nvidia's employees patches should go via your tree, in the first place.
> What are you even arguing about. Seriously.

Now this is a different argument.
For this, I'll resend the patch now.

Regarding the other argument, I still didn't see a single place stating 
24h (or a single working day).

Thanks.

