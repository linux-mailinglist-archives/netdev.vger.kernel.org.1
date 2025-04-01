Return-Path: <netdev+bounces-178496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE14AA774B8
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 08:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B80168D1E
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 06:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEF31CBEB9;
	Tue,  1 Apr 2025 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="EAoiDVHp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B8642052
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743490163; cv=none; b=ZEnhqoToEIMp5GaKcNS5+dqdh1aJFVvHKgnTUaIi4G5Db9qvLa0sK6bhh60Uu3XsLk1nRzzSeSmM+b+SuWQo8BvAT3Omwv0dlp7MsnfqHX8DfausMmSzaFINss4yttQN2XTIVYlraKhZh9yhNGJPvzrVRtLbnxGG+yIbwPoP7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743490163; c=relaxed/simple;
	bh=19NqAsNMeTd9dQAzYg4gwKcYyPfAqdZa/VkYUFGvdIk=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=PxyBss6a7VqFOz0Q33nWQLe7TqUXDZekDt1+CexVyiEpFHuTxC+GLPyRR4yT6JoC3tkWnr7IA/+rZhSijhD0lIBvc0LwXtvgiWhLchSD2q0gBXqWTOXx4PyWYThvyvKHQfj3PstSz7pdguBZekAPmD6TtHPc85to0wkVuz9l9Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=EAoiDVHp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so459382f8f.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1743490160; x=1744094960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:to
         :content-language:from:references:cc:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPMIAVs3qOWVsyBtsGxXHT6n12gnPK6Ng3mzSvT++nI=;
        b=EAoiDVHprKpL8bnxeK2mi3D9vvM5G7a6BQZcbfqU6oD8vFnYv0u7FbbwHcAsEX7OmD
         A6L8H36bh2H5q7J7Yz21mfDtuoSRoS03DGBcgL7sE85ONOTKMvm43aYh3XhaPeZ1DCcT
         l/IctihWLydaEIyhrna+iwAxd4IcZ+lW8LDx/TDp2tNKMeoI9AOzO5gz6XygnCHfz/Vy
         +jInVOCFuTbgGB+UqzUTIJWfA8lnjgDS5VjJe9icXBuySfs1GJm8jV0DqYvqDLG0KbfZ
         QDBh2UXaJmKq4pBYOG0WGYjwJrFuV/r5kPTPQzHEKDoK+m/A6UhWVG+T6H6yPygg4aHp
         4lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743490160; x=1744094960;
        h=content-transfer-encoding:in-reply-to:organization:to
         :content-language:from:references:cc:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vPMIAVs3qOWVsyBtsGxXHT6n12gnPK6Ng3mzSvT++nI=;
        b=mpphpzAjEYuXrI1enCOi4Jl2FUeQ8q1jSxJyylTEGoyyF3/TVLjTc+Qe6RcJ445zUG
         Hcx1D42zNSfkwFZbToL2mVTkrAf18oMLMtSTdvT8xHkyIoj7ff92mtPnTWj4VLGL8K+l
         JfdMgg26jA14O/PjUarOBySytt0orKdVi1grg0e6rVuwDUy2LVzAq+u9YkKzGrE1Eae+
         JRACtW6pTUYVzFUIpdcwncuK3exyP21+DLKRhLo7+M6hB9a+jn3zlKDup367hDRjwQVj
         42wPJSvW+BsxBmWMwUy07m4w5zed8nj5z3vykXVWTsyizhnVQCFZJ/JdXQV2sjMkFEBQ
         89SA==
X-Forwarded-Encrypted: i=1; AJvYcCXjq2GNtNyDUj80+c4LGh0PrEKjUEv1QtvFDmukdZNfXUauAtUQ1mY03W29jZKgcXyMQ0bmekY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyufcRxTNC52NislQ+A0aF8AZykDRINt5lzCVs4tiH+UAYYAKk
	wX1S3ozRto0/IbMwCRfqIpxlu9SFP9TFl0N6EZybtmmdyXDX/+aMrk+MKXbS13E=
X-Gm-Gg: ASbGncvNR/lHvOm+n6HpWqRUYLhNorcLTgJpME1XN47B6qAUU4hf6Eo6Heweljeu5oG
	kVvehShpcJMyEsD9E79eEJrMbEyVqX1aeT9ULtWCsWjqA8i/cQvL/58186o1CDAC2BIV5410Rkg
	u7WQlWT+CW4KwVd8H/qLPvYGC756d0myPKCYec9uuGgT7ZyX+TsYXaL8VZo8pPQliZu7Ba4nEBa
	MIDrCksq9KcegYQlCtMAf+70bzeGn8aoC8cWtAhRoFcrKj4Cdhsq+pypkLp9HcbvaO9pwr5CZXv
	qMNeFfebI4iubU1FOLBeV5JnCDL8Trz7d2tUD0pzSf3HlA+rt3nx2OEVI3AuhzeO0jZlVovv8FC
	jIdVH0ZDlH/HuSwILwCvM53AWmJ4YEZei
X-Google-Smtp-Source: AGHT+IE7jpoepUT2i4HRtlJZ9boKfMMP++uvAeDbYxxM1bo0GvqONcbsJ5VntlNknnK+5rheBrgwLg==
X-Received: by 2002:a5d:6d88:0:b0:39c:1258:b36 with SMTP id ffacd0b85a97d-39c2483c1b6mr279314f8f.14.1743490160172;
        Mon, 31 Mar 2025 23:49:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:a98c:be9d:164a:20eb? ([2a01:e0a:b41:c160:a98c:be9d:164a:20eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fba3e44sm151339775e9.4.2025.03.31.23.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 23:49:19 -0700 (PDT)
Message-ID: <bb1a3cde-d4e9-40f8-b03e-0a757fb7a47f@6wind.com>
Date: Tue, 1 Apr 2025 08:49:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH iproute2] ip: display the 'netns-immutable' property
Cc: stephen@networkplumber.org, netdev@vger.kernel.org
References: <20250328095826.706221-1-nicolas.dichtel@6wind.com>
 <174347883527.227928.17713387159044503900.git-patchwork-notify@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
To: dsahern@gmail.com
Organization: 6WIND
In-Reply-To: <174347883527.227928.17713387159044503900.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Le 01/04/2025 à 05:40, patchwork-bot+netdevbpf@kernel.org a écrit :
> Hello:
> 
> This patch was applied to iproute2/iproute2-next.git (main)
> by David Ahern <dsahern@kernel.org>:
Thanks for applying this patch. Note that the attribute IFLA_NETNS_IMMUTABLE
will be available in the 6.15 release.


Regards,
Nicolas

> 
> On Fri, 28 Mar 2025 10:58:26 +0100 you wrote:
>> The user needs to specify '-details' to have it.
>>
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> ---
>>  ip/ipaddress.c | 5 +++++
>>  1 file changed, 5 insertions(+)
> 
> Here is the summary with links:
>   - [iproute2] ip: display the 'netns-immutable' property
>     https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e4e55167d004
> 
> You are awesome, thank you!


