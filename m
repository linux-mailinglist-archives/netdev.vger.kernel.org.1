Return-Path: <netdev+bounces-162643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0CA2775C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B6C1882A49
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2587E2165E8;
	Tue,  4 Feb 2025 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="T8mDouel"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636902153CE
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687113; cv=none; b=XVzVmR4vKHIl5mggn21/nYwIwXnntyUsdXIafrKXUgbR6jkmPtMRm4oMdMS1GzIA64kT4KD/nKvXPSJv3QSDgasdMtrmW4VjiKLWdl+lSxQYZovWCR0unz821TkJuyGMXfMQDYH8uPB/BgFDRgJs5Mt3oLWWrormKztL9e3DvoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687113; c=relaxed/simple;
	bh=EQbL0Sdt+XkmvZiR8nil4Iqbr37XXySmc0QAczpAAew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbxWI3AbURXGb1sZ6vZn/Ihv9/RtGDqtCirLaRCQRuvPkIxofVX1z8h5oHRWMUUUlXAT5pXDU/JQk+V4/tlN0ENfGnT958yXcIPJsjuUpsA0oV75MJG6YzaZdnqYP7MIJthh8JTHvRWg7ykJn0h1kqvduS42YkegZnd2fMb4vHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=T8mDouel; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dc7eba78e6so11036997a12.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738687109; x=1739291909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WdaPZc9CONkf4+pakm9O+8SJ7d8OZWZ0KmwGKhUgrys=;
        b=T8mDouelFqEyl336HHp0oqhrYaAm8YuiwfSqnL9WlEhgsxx6+lS17MaPIMcnz80Iie
         G65LqrYsQCZz6bqb367w95ogLV5tPrnEM0xpDD1fHyyWEdwK+cQuXTB8uwMit9dF6L6n
         wCyt+jUibl6OS/yeC9wnszZp/WgdFDNVqygO3BMAPYhrjtQaYPoWhnEpXbAjXJwC6PJf
         OaAcGlZOKjf3P4t92JGg8CiKhy4GoySUnb/CbyPFeO+mSCOOiWmziQ/14RXD2qpcym3T
         AKZogGaxaQ7siTVlNdAcxZmhWtT1IcII3F93Q0OJcHtEGEjB9Ci7YTqhWjhZ6Crp1HHq
         xU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687109; x=1739291909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdaPZc9CONkf4+pakm9O+8SJ7d8OZWZ0KmwGKhUgrys=;
        b=NQAZrfjsdqr4A7vR8BlqFb8SLCB3AoBKHhaPeseahDaDqFBw4WgxFWMy1sscg9HitQ
         GT8NmRZebB6ezg58xjg4pLTTBDmHfQompOACiuX0qce9qqeFao8vgBdHJvpEWVdnSJ3k
         hqn4jSlSZkdXwQSMG6reVjipEpoXIT5VrH8WUxP9XY8ZljU2vZE6ijCb5pkBqmqtSFUX
         Ny48fx9mYht4d2lnt2CheCAUYICeFEfEFytPnDzWlxGTdplSjk0kBTSM9WmX6FddLpUA
         nfwEaix6VEbKS/TOXnvwEsacjyOY2oSJezhaRXkhNcST+P9+fN9c5ZnF6xwubHznZHRX
         XfWw==
X-Forwarded-Encrypted: i=1; AJvYcCVQZMx0e2R5+a8IFcRDcX6zgySQe7JDaubqULefizgpFZf9rViwVj2s1iU9PatgGNKFdcpvBY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxskyxKXSOsleill/6RE7Y1T/BLskS5q3ShruujyjECD9EbUL3
	BWLc/f2RSItfUGMv3uDKrt1YvY+Oi/Simtg5+BGZ5umXj/NsVDCCx7E92llUG0A=
X-Gm-Gg: ASbGncubwQaq5YODKIcNt7GctX5InC7mY4Y7zikUVxxTiSuVrVliIZudf5TTmzUBuKz
	mf7962sq+wD1fCADHeWn5yom0MgP2yUd/Vdo8FnK+94R7/LlvDvHJvFCQoqe6fMbg5rExZCJlEI
	o0xNRar1YAPs/kwCvvHVb7QULMpj2DySB2O+KQiv31CGQRMZzhuVgOiNAm8FLwDgkR6Nerjvcfh
	F+1TP+F4TyvQlfIls52eyX6s9X0bYQkgIoxtauyWc7jOucGKswrQelXg4vUiOhcHyCwHAdTplCt
	eLU0wkJwuAMzi9YjuALr8GkfPl4RZljW06vElX+ec2hh4zs=
X-Google-Smtp-Source: AGHT+IGLocIbdb78F2HWWcNPuMfjMt24zZiSg9sDpJIkeGt7oO0IU+daxxESk6ArnPhnluLGe+Jjpw==
X-Received: by 2002:a17:907:970e:b0:ab7:ac1:5c37 with SMTP id a640c23a62f3a-ab70ac15ca5mr1430041066b.47.1738687109480;
        Tue, 04 Feb 2025 08:38:29 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7106178ccsm596142066b.9.2025.02.04.08.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 08:38:28 -0800 (PST)
Message-ID: <9c7c34e0-0c46-4ea3-9e01-738b92302532@blackwall.org>
Date: Tue, 4 Feb 2025 18:38:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] vxlan: Avoid unnecessary updates to FDB
 'used' time
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
References: <20250204145549.1216254-1-idosch@nvidia.com>
 <20250204145549.1216254-8-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204145549.1216254-8-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 16:55, Ido Schimmel wrote:
> Now that the VXLAN driver ages out FDB entries based on their 'updated'
> time we can remove unnecessary updates of the 'used' time from the Rx
> path and the control path, so that the 'used' time is only updated by
> the Tx path.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


