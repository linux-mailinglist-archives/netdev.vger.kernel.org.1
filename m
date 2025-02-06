Return-Path: <netdev+bounces-163559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FB2A2AB0E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730373AA599
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4F6227572;
	Thu,  6 Feb 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="uZ+qeQm9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C31C7017
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851740; cv=none; b=nUiDX0I/k9DeEGWJLmp3344YYP9VsR6TuD4B55tCX6nN6d4KmNbE1RFrBOK/vfAVavyZktWza24vc+8XZmnkJxl4iuwQX3nxn//R8kNsos6+YTtvod4ainO4PgLYMZgz8UmGlORCUXk07c7sUefWYfu9kFCM1xtuRWbxjIPyPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851740; c=relaxed/simple;
	bh=bi07utj+cl2ojuyIDCD/sVJyWBo4xWIZEqhSrnnju3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkcPQLwkqOVBm6EbZkzANvRe5nXIuaochCHjtzp+4jugW712nBrP7N5zpiPB8+VlsB6As6H7PWSnDmpRwT9XMI1rvMQj5TgkCFjXKzUls79tBWjqno6+usy6g+XuSQXuoP6boNTzJIaPl/YZ7qF9nB/5QEK2TkuAUcgE9EJFfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=uZ+qeQm9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so142212466b.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738851736; x=1739456536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qy52E7wooPVVAtEuLO+Qhyc2iLHEhNjVLiIzlhHyrWs=;
        b=uZ+qeQm9brCkwUX2IlQbdo6PogOK5wqma0tQpCl5QXM9OTv3+zPygQModsM9Og6xS+
         ZQAgt/ONb1PL5Niqi+awOJgIuFcYBl4yEj4lzr1IqS55psmhB3Fp8tR0s7ANVy77EQoQ
         FAgZ0oiOZQNCLctnAuqOra4sJGN5VwxnbtMKkUDHnVgj/hVJLa6Y3wEGZnEEKJvuWWAG
         E4RgLV9A83clu45ydks0UgZXY1XRJoL5z3ycfydyC0FasUdOCFtYwKcO3PFHPug/xTOV
         NiBHrFZPuB+wAyJ4n9YXBE6CqZW7DD6LcXGYZrtwAI3VR226ooJn9+FjOFTjg4hTlX3G
         /yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851736; x=1739456536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy52E7wooPVVAtEuLO+Qhyc2iLHEhNjVLiIzlhHyrWs=;
        b=ckeHKtD2NRVvP6ZFQ02x/AwnNA33mHd4pjKcmK9TbYMBQxv3uq8uSBEYWFlOMmDoPW
         r738R4akCqIxgeSWJUWFjTIveo6muwMC3lDsBszj8HAI+QpDvEwbqh+rwe3XdOqlkF1d
         G+14+GiOSxx0CNkZl+ebXvZ9x2fyXrJHz41FfuuRlCFuIHPxD79Wa3migGkzlATz+cx6
         QzIfLIkHtwINJqfglSCmUGpM+vRdjBH/WohiNNvr8lg9SILNR6b8rW+b55JWhiEWmW9d
         joEM4SR7gevjrm2Si0dokGmbF/Gw8ytYb6OApenalJrLiAo3gapy56Ixx7FHk4DZCu81
         OQQQ==
X-Gm-Message-State: AOJu0YyJBgM9ro4Qy1N9fIK/7GJVAAnZVX9xVOXA5G24rRfauwkkIW+F
	RJkwHguj1dpdQYarDHzBJOhFZFMSuePAtIwUMotyFdruhEAF4j/Wuvh9lQzw26I=
X-Gm-Gg: ASbGncuCrVOiafMRsAfIG71wrRz+SyV42ggvKyOnM8IgcgvfqrposxHXCK7zEiFYUIg
	de08cDk3e5tHpIYC2lGw4nlpdeusDIsPfhvtB2BNC3dAlDb1dq6zzxXrZv/D1H0mA7eEvupClhL
	Z6/pYjvd5NJ9XeGdw55lpHbpFTRs9/KiydNI0jjDQwieFzz2LOVBAbLgpzSAHrQJL916mAozUez
	PWFuLBZuZthWsXUI3YJUMylP/9crJpLwEe0XX10VKDi1JfNWSexoEbb9Ffu7pBBNS0oc5iTOYdI
	mkqSN4PpaWu/l5UL/3XEk5BPz3Yc+nTwpLfVx++OU0OfIn0=
X-Google-Smtp-Source: AGHT+IG6aiDjgy1nFvIKHnHHwV2g9kBo0v+xziTDZFU9m8b3NS4nlzYz1Qp3ZZ0dcQwrhEvWNvqV8Q==
X-Received: by 2002:a17:907:7249:b0:ab6:36fd:1c8f with SMTP id a640c23a62f3a-ab75e2f655emr719799466b.39.1738851735691;
        Thu, 06 Feb 2025 06:22:15 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab77f5f5a0esm40785966b.155.2025.02.06.06.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:22:15 -0800 (PST)
Message-ID: <cc8b741a-72a4-4059-bbcd-3f32c7ef56d0@blackwall.org>
Date: Thu, 6 Feb 2025 16:22:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 13/14] bridge: Introduce
 DEV_PATH_BR_VLAN_KEEP_HW for bridge-fastpath
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-14-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-14-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> This patch introduces DEV_PATH_BR_VLAN_KEEP_HW. It is needed in the
> bridge fastpath for switchdevs supporting SWITCHDEV_OBJ_ID_PORT_VLAN.
> 
> It is similar to DEV_PATH_BR_VLAN_TAG, with the correcponding bit in
> ingress_vlans set.
> 
> In the forward fastpath it is not needed.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  include/linux/netdevice.h        |  1 +
>  net/bridge/br_device.c           |  4 ++++
>  net/bridge/br_vlan.c             | 18 +++++++++++-------
>  net/netfilter/nft_flow_offload.c |  3 +++
>  4 files changed, 19 insertions(+), 7 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


