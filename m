Return-Path: <netdev+bounces-106757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A4A9178A8
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9007B21A82
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 06:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C580614C599;
	Wed, 26 Jun 2024 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="dqpkTktD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576138D
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382371; cv=none; b=laBMOfMyfOAvfXMujW6FFyK7RPYSr0EUsZYmbuci6mAFK7henxVT8zC1ZSoFmQzLqL4Py1Bc38zNCIGRN0YnTpsh1wtle+CfEjxuuVhfokSDVw5xPPi6PmZgPCvAesIjj3WFaUCQkd5dQ2K/9d5FqHFWhbekycQUxZpffPRzmoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382371; c=relaxed/simple;
	bh=QCwUaoSI7q4KByEGxUOBExDGV31+V3qfzBd4y5DE/3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DddEvf1COjRapagNe3OsGa9JnSg+nvUIqDgCHtvx4+iDbm1DSHrFd7FitRCLvaBSmTcXL+aYmT+Ieiq/Hf8Rns0fUJzluK01xzphq4aDec/m7eJByp6AK7fGa95Jt83asf2rGjJMw1hOzRFyGD8t/GtRjFBJ5Maj5QzKuhboNMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=dqpkTktD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d26a4ee65so6260805a12.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 23:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719382368; x=1719987168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jz5BvTRcYsROqH3oi5fHfEWYRIupy3OOSnElngCn8v4=;
        b=dqpkTktDZIE97Ab2nvM6ozrRZk8JRFP2fME7YSwC3nhLMHEkNbhdyQ/5LiyrNxDj4B
         /dwCl/HcQs5Y7Drt7PajTW/uYzCnJ43uCttZTQfJ39+AZPHGw1ejLHMHXjxdKFdvjfHV
         LEXjgX/+p1QefYoxsrnciV9i2m3Mi9HMfx2aYqdBFvdCy0oN1K60KLIYmoK3fVMHw3Jw
         nJz/vG5PlXAa2Wtl9fMD/NvyTXlNX4MbDE26ffDW1JTN/e0gCEYLhIUwKr9gK7Yy4TWk
         0QEE+T3p7p5Z5ge77kkvuyqohEYzIZiH3KtOxE0L5VGbY2hBesMmpUUyuwx7tE4qvzdJ
         SLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719382368; x=1719987168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jz5BvTRcYsROqH3oi5fHfEWYRIupy3OOSnElngCn8v4=;
        b=IaJxHq0VKaSKjL5yHCkLOxyxhMY3CXULltdwimzOeMm0EVHSSdz9uh9f0x31EUr6+e
         K7GgMzTv50hWsLGye7YCUt8e2mwPKqEaVSbBvKyPe6ow184GmT5mH7tkEJBO9SUHqizE
         7+My0zXDTMCdWe+MBXA1OvFJ2In6FPYTUIKzhCSl/3es+SfKKwX56g2ndz53y2N5a0vp
         3NiXG5RqdamV4Py/xYpzMQiuDHuBId9BN/Ct6XF1USCLdE5Va1IJIz3IkS6XLrhE1UAk
         MnTmNZ1u/UcZs+VE2Z+jCgKSTTXa3sHfA5efjGyZVDa4F5RtUWksVebUgRUkOCqsKuTT
         E5KA==
X-Forwarded-Encrypted: i=1; AJvYcCUwHT46hw2Z3M2hhHkiIRL7OqnCAg3+tru/SLRz6ycdjEDovzzvAhAcgDO6ASvWb36YEc13QedpHDzIAG0TVMlHNWWbfhL8
X-Gm-Message-State: AOJu0YzdJI6ac1kMr+U4L9/AGYpUK33LBlRsbZLJaeewzi8S28+wi4/a
	NFsRwUmWNkwMI0eAz2OCmm7mkjgJ5RquWFRE89Pb5jfEijWZiROwtGQR7Y+JeAo=
X-Google-Smtp-Source: AGHT+IHQhfBiHMkTP0SXBskFPNCsTfOuJqqud4AlvseRjNChrX80vmRhrNT2ZXc1RZa0CVTFEH/EDw==
X-Received: by 2002:a05:6402:270c:b0:57d:6079:3916 with SMTP id 4fb4d7f45d1cf-57d607939edmr6437777a12.26.1719382368470;
        Tue, 25 Jun 2024 23:12:48 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-582c03ff362sm1046120a12.92.2024.06.25.23.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 23:12:47 -0700 (PDT)
Message-ID: <e47210c0-0c9e-4ed4-8885-957f39deb7f4@blackwall.org>
Date: Wed, 26 Jun 2024 09:12:47 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2 2/3] bridge: vlan: Add support for setting a
 VLANs MSTI
To: Tobias Waldekranz <tobias@waldekranz.com>, stephen@networkplumber.org,
 dsahern@kernel.org
Cc: liuhangbin@gmail.com, netdev@vger.kernel.org
References: <20240624130035.3689606-1-tobias@waldekranz.com>
 <20240624130035.3689606-3-tobias@waldekranz.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240624130035.3689606-3-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/06/2024 16:00, Tobias Waldekranz wrote:
> Allow the user to associate one or more VLANs with a multiple spanning
> tree instance (MSTI), when MST is enabled on the bridge.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  bridge/vlan.c     | 13 +++++++++++++
>  man/man8/bridge.8 |  9 ++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



