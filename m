Return-Path: <netdev+bounces-83933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8A2894EB1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE67E281495
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 09:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B3B5820C;
	Tue,  2 Apr 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="pp2t2qtC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3476958105
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050124; cv=none; b=XxgjYTEVrkQQZtonTKTe3VmoDsC6Isy7hGMUFw3Q8InZ5j58+98Za6rZkUEEcUvs/yFtppw8jufs2JQQX4PdHPPG79mLlmm5BxBbvf56Y3TgZWaq0uZB3dwDgl4QfIiWWDpAUwrw9EelnayuUTWge1EVC32hJ5K0Ljvd1YcHN1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050124; c=relaxed/simple;
	bh=SaHdWyZMielfHTNhw3NZ6AoIsZ4bpjd1xazWDgacU6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XU+ZCTXUIh6bjblkUxEKAaXHuXKqey/IIVrErl5CIr1b28V0pDCCooKOQDgQFD4tW+q7nIjdBAX0SpoEOy906wXvtn4dM+/YRGCxeqSB7Yn/toQDs1i6bC3LWzW5gqoFVbC1c3WEyMPgBZ3bUK9xAcqve+s+CoME/DaWMXAbcqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=pp2t2qtC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34372e3db28so143139f8f.2
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1712050120; x=1712654920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHNO1hVo3g5ZBLDGdpQZsS60/lEQyobzAsIONNu4tIs=;
        b=pp2t2qtCWDiGQLyQqPARVDwxvcBVwwGYo33TajhoD42IISsp//iDcUz4u6a4zqhKKf
         uWGC2gL1pux+vBTZ0ASUY8L1+YHccWVioFhBRef8ntUZJbmwTiLDqrOtw4bmnlmHxKFw
         pHP4F1ET9e19HWOuBGQ/JemjjzprfCd637XEjibbz7WE5JfPhd+yDUPVe4OR9OqKTped
         /g55uo9sD+dQgdEc7y0R5yCxYXcI82GZvbcKjVi9+EY+n3BdGOI4scvfzfQh2jLod/sD
         PNiyFimgXDdvYX9LvwIle1OsFAlgPg2V6D+sZGVEkurvTetYxr4LQsxuPH7xuzpHNicU
         hoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712050120; x=1712654920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHNO1hVo3g5ZBLDGdpQZsS60/lEQyobzAsIONNu4tIs=;
        b=DOt3lRVVJFj4Xvt1DIK4cmv1lJuP2DKnH07kRrTAnS1oxGIyYS+b0VDuU6lT/OMY0i
         x3qN0VfO38IXpmpUTmj4Zl2Kc19WvNPAf/qKfTycreWXQ3939Muq38F7wcZuapZHCKui
         ZzNZkt/Tmok9NfnzzLKac0u2IcBZ72XuxcWiED7Ss/vQXrc8bQIB1chaj0xs+W0QzVPd
         hHXJw8x0lH1Fv9HuPykAVk/yOjv///3zlSC8aEbtvHnalXaoBVe+Y/hkyo4WLqMSZj4l
         ERmgv9o9AHUTgYTdNnrAz/mw+FkD4Gb/KyQI0HykMc+zWz+i12KuZrmR+5y2qjoSNLLQ
         YA2g==
X-Forwarded-Encrypted: i=1; AJvYcCXIggTHu5AnO1eAYT623F0cKpEfxrOYESLGmlu5iPADcJLZzIGaItzz9RBCtmNTp7WjiK+/47QnW2Lo+jtNMBjkvmi9TEh6
X-Gm-Message-State: AOJu0YxlUdJwH4ckVU8IRJlGXMpyK6jfRkWi8MB5TZwJ0em+Si4a/WgT
	+N+GdiYmkvXtL2TvVZXLkLSYVvKgM6ZYcKFhbfoXkWqwc9fGOXTsFFQ2UNDJQp0=
X-Google-Smtp-Source: AGHT+IEI24f1p1p1BLDEE6iJrpvuBCcj4zOyiUqGHCc+h7DoytXVrqcMxVKkFly4F3F5rVn71rvUOA==
X-Received: by 2002:adf:e011:0:b0:33e:7896:a9d7 with SMTP id s17-20020adfe011000000b0033e7896a9d7mr8560010wrh.67.1712050120249;
        Tue, 02 Apr 2024 02:28:40 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id en19-20020a056000421300b0034365152f2asm1170910wrb.97.2024.04.02.02.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 02:28:39 -0700 (PDT)
Message-ID: <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
Date: Tue, 2 Apr 2024 12:28:38 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Content-Language: en-US
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/24 03:10, Joseph Huang wrote:
> There is a use case where one would like to enable multicast snooping
> on a bridge but disable multicast flooding on all bridge ports so that
> registered multicast traffic will only reach the intended recipients and
> unregistered multicast traffic will be dropped. However, with existing
> bridge ports' mcast_flood flag implementation, it doesn't work as desired.
> 
> This patchset aims to make multicast snooping work even when multicast
> flooding is disabled on the bridge ports, without changing the semantic of
> the mcast_flood flag too much. Patches 1 to 4 attempt to address this issue.
> 
> Also, in a network where more than one multicast snooping capable bridges
> are interconnected without multicast routers being present, multicast
> snooping fails if:
> 
>    1. The source is not directly attached to the Querier
>    2. The listener is beyond the mrouter port of the bridge where the
>       source is directly attached
>    3. A hardware offloading switch is involved
> 
> When all of the conditions are met, the listener will not receive any
> multicast packets from the source. Patches 5 to 10 attempt to address this
> issue. Specifically, patches 5 to 8 set up the infrastructure, patch 9
> handles unregistered multicast packets forwarding, and patch 10 handles
> registered multicast packets forwarding to the mrouter port.
> 
> The patches were developed against 5.15, and forward-ported to 6.8.
> Tests were done on a Pi 4B + Marvell 6393X Eval board with a single
> switch chip with no VLAN.
> 
> V1 -> V2:
> - Moved the bulk of the change from the bridge to the mv88e6xxx driver.
> - Added more patches (specifically 3 and 4) to workaround some more
>    issues with multicast flooding being disabled.
> 
> v1 here:
> https://patchwork.kernel.org/project/netdevbpf/cover/20210504182259.5042-1-Joseph.Huang@garmin.com/
> 

For the bridge patches:
Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>

You cannot break the multicast flood flag to add support for a custom
use-case. This is unacceptable. The current bridge behaviour is correct
your patch 02 doesn't fix anything, you should configure the bridge
properly to avoid all those problems, not break protocols.

Your special use case can easily be solved by a user-space helper or
eBPF and nftables. You can set the mcast flood flag and bypass the
bridge for these packets. I basically said the same in 2021, if this is
going to be in the bridge it should be hidden behind an option that is
default off. But in my opinion adding an option to solve such special
cases is undesirable, they can be easily solved with what's currently
available.



