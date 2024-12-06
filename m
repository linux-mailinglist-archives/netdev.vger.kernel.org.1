Return-Path: <netdev+bounces-149741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9939E7180
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 15:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E101887687
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C4514AD29;
	Fri,  6 Dec 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="V6spZwOc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD31442E8
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497001; cv=none; b=NGkrQyA/y7S2/5wmIa1jlyHxKUdcw63TEAVek2I6KwBqdMXLeRoF08yXdchyTCfIlgKo2bQ2SrhRgldSVwmCD6Mn2SHQ01k1BOB/yvUG2QBJkHj0kL2KxDl7P2EU41r3tskax2tOPN7XLdxZjFjXIB9GW0dnpEMbUoW6cbpsmDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497001; c=relaxed/simple;
	bh=O9IQ+oFR2euLolp5B1F6Haq3FB/eiVaKdDFisrNJrOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PupPanzbY91POCMSVUN8igAZMRPS6gUl+4c5jHdoUGe0lggnvMZK+teh5chgCeLQg1vDQ35ol3ugMd3jllaRu2RRR/nF/Vi7vL7jZZApoyZObD/RnQ+bvuI7g9MvmLhoKPJ4VVuT2FtCY7/jJDcwNVpdUQsnmwfvvnSZpmP0S9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=V6spZwOc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4349ec4708bso1572175e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 06:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1733496997; x=1734101797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nQqZXSy8ZfCyy5C2qpB8Gpa22XGIvl7F7aNCqiLPVzo=;
        b=V6spZwOcD11ZjRnF3hsWqoBWkJzA9vn1/m73zxB3MSqOQL9t6WA2UmMKUkJfhHCDNx
         M80cqyQGmYmY2CGpA/L0T/lgcIQLoFAgb23BJjwYEn/ZpTnQ0GbagsNKaEVYVQBxkSDN
         ZfaPqZNVTuBCyAFajn0lVxmi9BRbApOWvL/q2axcONx3nZu2uX92O0/diKRQNfZMG4Ex
         RTSLVveybKI32MbDRzr196R2rIi+qN8dMmfl4OywuR6XPrWSIEyUWx0aAvurSsc77aCw
         1PKv+NlMGv8qhJIoaUuAc6NFTZWk8usZlDYpMErfpZnBWd9uHDSotJlVvqxa210r/aJJ
         CaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733496997; x=1734101797;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQqZXSy8ZfCyy5C2qpB8Gpa22XGIvl7F7aNCqiLPVzo=;
        b=qy46VpMIarcXMcKpBPLvi979LBLV8a6yX/q9Z7/PLR1E4Q5OL/HNZxy0xskOYGdXBp
         I2Exf4ux63xcN4N5Vkc3QY1iuy8rzBhTmSs2LM/f3mnB80kCx8PIIwXPazRG9B8m8Q7C
         oVh79uA6TNh54yU0o+C9aJZtsg9GxvtpT/uwrwTLbYlBSA7PKsmjKme7BU8OYPxSnYr1
         3GDXOAXZN6RRbHNyjrUu7XpgYtWlQAt07ADBvhVHVDWeR4g+uxDeMY4Od/FL5ofbjCgu
         MCt/NQZTdGZImRMSb6lDthcS2ecVSlHR/nfm/IXhxGd3nv2VvG7VW3LTRsUJ+k+SEx68
         lU2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQwdCzIVFo60B7k620II2IosDqMxnDpB9NS6LeaRofoRKZZtdxJkm+ZPzObvV65DPr0CJZyFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwregJ/TdoC0U06z0DFlUxfK5c8aYBV+sf3tXursWxKHoyIBaLd
	ytkqy/QrZ8IUOSuJjLHyk2j1KnRlKhQM0JiYquntsaPObGBqz1jVta36dbq2lKk=
X-Gm-Gg: ASbGncu9zVr2hDhdOgpIq672QhbKhgYbl05JoArFkSy9jY8K+i+6DGGwK06DEJ7MJmy
	7tO76GvhZ4LsvrtHe4DuAIE6ZGZkpZtqtUh+EMhf7HU8G/blvZMDMvCpLOJKryB8Tx/V5hNVq5c
	vU37RW+HJ6dPaJMP9Ifr78oMgim8XKXfmYFyzwa2hARVlcrI8bW0+ZH5ex6tLSt9js3ansJbt1Y
	JRd4gk2zmNMnql3kxDMZJGZRJGHLH52SK5MwITNpeprg60VV0FACxnDfIYJUJ3jpnWItUBXt61q
	WVaivc9ee1NP5CyV3MwDECOd7/A=
X-Google-Smtp-Source: AGHT+IFbpT7B5RWAedqr9Y4LyWq7wWvZrK8AN8pluhAMDtmXJUBDQvDcRbf8TdR6jrdlWntCQf/eJQ==
X-Received: by 2002:a05:6000:2c3:b0:385:fc00:f5f5 with SMTP id ffacd0b85a97d-3862b3544b8mr900015f8f.4.1733496997111;
        Fri, 06 Dec 2024 06:56:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:234f:9b13:6d13:5195? ([2a01:e0a:b41:c160:234f:9b13:6d13:5195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d05d82esm1770836f8f.40.2024.12.06.06.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 06:56:36 -0800 (PST)
Message-ID: <1c769e7b-cb55-4a36-b795-926efe671408@6wind.com>
Date: Fri, 6 Dec 2024 15:56:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next, v5] netlink: add IGMP/MLD join/leave
 notifications
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com,
 jiri@resnulli.us, stephen@networkplumber.org, jimictw@google.com,
 prohr@google.com, liuhangbin@gmail.com, andrew@lunn.ch,
 netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>,
 Patrick Ruddy <pruddy@vyatta.att-mail.com>
References: <20241206041025.37231-1-yuyanghuang@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20241206041025.37231-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 06/12/2024 à 05:10, Yuyang Huang a écrit :
> This change introduces netlink notifications for multicast address
> changes. The following features are included:
> * Addition and deletion of multicast addresses are reported using
>   RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET and
>   AF_INET6.
> * Two new notification groups: RTNLGRP_IPV4_MCADDR and
>   RTNLGRP_IPV6_MCADDR are introduced for receiving these events.
> 
> This change allows user space applications (e.g., ip monitor) to
> efficiently track multicast group memberships by listening for netlink
> events. Previously, applications relied on inefficient polling of
> procfs, introducing delays. With netlink notifications, applications
> receive realtime updates on multicast group membership changes,
> enabling more precise metrics collection and system monitoring. 
> 
> This change also unlocks the potential for implementing a wide range
> of sophisticated multicast related features in user space by allowing
> applications to combine kernel provided multicast address information
> with user space data and communicate decisions back to the kernel for
> more fine grained control. This mechanism can be used for various
> purposes, including multicast filtering, IGMP/MLD offload, and
> IGMP/MLD snooping.
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Co-developed-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> Signed-off-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
> Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.att-mail.com
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

