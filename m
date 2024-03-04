Return-Path: <netdev+bounces-77257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 014ED870D17
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17AE5B26693
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9206A7C086;
	Mon,  4 Mar 2024 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RCaeJlM3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381DF7BB1B
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587835; cv=none; b=L8ElvaOeCHFrHpktYwy2x535tYq/LLL8a7IhMvFR8ao5PQlSUiuS9kn1VlSqYL/3jGrSuPBphIZRJAMCT3gAexslJubGO58pJAAQrsj2eNj0wUwINYMw6ujc3NEJeypVzJspaar5Gr1B7MCo74eFgPZjkLGfohIYwvkTYTCtBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587835; c=relaxed/simple;
	bh=yX+5EhE0Ujae7Oh5ESkRpBjwmDArdtM6tOSRBSmLJmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ci6orzSqzSAFtZI2j/DE+NNUwqldA96W5IakOV+cbbLtKvGQa5ZvOJfoKnbkR4rZUmcMDlmN/6vaKbLHwFF3yd2IM+NKi7XGlvvLM0r63pne7eNXnyhvHqtuxg+XRvx9wz9vu+Gu6IbAQx4XxlbN78HBOx387cMxaAhQI4wL+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RCaeJlM3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so7090231a12.3
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 13:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709587831; x=1710192631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jVBnPChPwoP39sM9QuqFiJBolKcBw+YfbpTlEb6ipPM=;
        b=RCaeJlM3CEwGMCAbgMhROeuaU6K+6vBuhQcIpncuKYvDT1mtETczjf9S30K3Un8a+a
         taDTPPWenKdG0Vi5KNDd+14jkb/8FTLnbqZhtcd4g2Wpybz/AQP9YRuo9FW7leHYlDHc
         uCfXLDDqs+7TIOp2OX4Wpb/L9Q+3cK+9cvtMkY6jP+6nrXlyc4Ngdleu2ehevwUtJ1cI
         DG3DJCV4U4Uo/EC8PzwyRS1gg510AUHd6NhQCmKNuaINJ9YiXsr8K/Birmi3jip9q/AU
         QsiQiDk/d3BR55q4H687NUY91V1HotPrsgRQtODOiRysZ8giR5jbA/x1X1YfKX63aSiU
         OgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709587831; x=1710192631;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVBnPChPwoP39sM9QuqFiJBolKcBw+YfbpTlEb6ipPM=;
        b=ZqR6Yz6o4kzlakjT/YE9+TnDbljJ0ehsx+BK7geeXW1lXILn63ojw/9nbvbfYTegFi
         5cS+ni704wOsv8FRSV1KaFICcU9vVjMdMqwexY1b+gH0A5n/eNllLY6hFWOaWEjxlq+k
         30/6Dfd2VtRLZdMq8T/p7GJObCSvHI3eScTLZ1xWdc/DY6aBkDWqwu03f6p5810KdBk1
         2XBK4K1QY2UTKrczzSxtFNpXX+r4P9Qx/z5uVulV5VNts76Jr/WJXmqVs39NnjkjsWvg
         R6oEFTdXUMO6ZvLVMOtbDWUceVqHPhq/pJ+t7T4Ay+y2+H5SCQ4ZpKrgP3QPMJ62LZot
         r+WA==
X-Gm-Message-State: AOJu0YzsuOuk1pmshdQMIwje2pFqFb7Gn3PQZ0JWaaeHB8hw+WgiUwP8
	zNMCPaw94j0vBO70pB2Eaxn8r7tTVvuovdEi/U4VgT+pVdTDcpHZwhUrftjCId4=
X-Google-Smtp-Source: AGHT+IFDwhYl98iysIc1yeDK+Vh2YxSdoknYwYyi4opQK6G1O0ueWt7rinYjLsl0WHoJwcFmhynozg==
X-Received: by 2002:aa7:d64b:0:b0:567:672f:6076 with SMTP id v11-20020aa7d64b000000b00567672f6076mr2098050edr.14.1709587831489;
        Mon, 04 Mar 2024 13:30:31 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:58bd:4faf:e5f:db69? ([2001:67c:2fbc:0:58bd:4faf:e5f:db69])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d54b000000b005676dc74568sm762184edr.92.2024.03.04.13.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 13:30:31 -0800 (PST)
Message-ID: <517236bb-fd03-43cb-a264-c7d191058eef@openvpn.net>
Date: Mon, 4 Mar 2024 22:30:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/22] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-3-antonio@openvpn.net>
 <1f63398d-7015-45b2-b7de-c6731a409a69@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <1f63398d-7015-45b2-b7de-c6731a409a69@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 04/03/2024 21:47, Andrew Lunn wrote:
>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>> new file mode 100644
>> index 000000000000..a1e19402e36d
>> --- /dev/null
>> +++ b/drivers/net/ovpn/io.c
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*  OpenVPN data channel offload
>> + *
>> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
>> + *
>> + *  Author:	James Yonan <james@openvpn.net>
>> + *		Antonio Quartulli <antonio@openvpn.net>
>> + */
>> +
>> +#include "io.h"
>> +
>> +#include <linux/netdevice.h>
>> +#include <linux/skbuff.h>
> 
> It is normal to put local headers last.

Ok, will make this change on all files.

> 
>> diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
>> new file mode 100644
>> index 000000000000..0a076d14f721
>> --- /dev/null
>> +++ b/drivers/net/ovpn/io.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* OpenVPN data channel offload
>> + *
>> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
>> + *
>> + *  Author:	James Yonan <james@openvpn.net>
>> + *		Antonio Quartulli <antonio@openvpn.net>
>> + */
>> +
>> +#ifndef _NET_OVPN_OVPN_H_
>> +#define _NET_OVPN_OVPN_H_
>> +
>> +#include <linux/netdevice.h>
>> +
>> +struct sk_buff;
>> +
> 
> Once you have the headers in the normal order, you probably won't need
> this.

True, but I personally I always try to include headers in any file where 
they are needed, to avoid implicitly forcing some kind of include 
ordering or dependency. Isn't it recommended?

> 
>> +netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
>> +
>> +#endif /* _NET_OVPN_OVPN_H_ */
>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>> new file mode 100644
>> index 000000000000..25964eb89aac
>> --- /dev/null
>> +++ b/drivers/net/ovpn/main.c
>> @@ -0,0 +1,118 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*  OpenVPN data channel offload
>> + *
>> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
>> + *
>> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
>> + *		James Yonan <james@openvpn.net>
>> + */
>> +
>> +#include "main.h"
>> +#include "io.h"
>> +
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/types.h>
>> +#include <linux/net.h>
>> +#include <linux/inetdevice.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/version.h>
>> +
>> +
>> +/* Driver info */
> 
> Double blank lines are generally not liked. I'm surprised checkpatch
> did not warn?

No, it did not complain. I added an extra white line between headers and 
code, but I can remove it and avoid double blank lines at all.

> 
>> +#define DRV_NAME	"ovpn"
>> +#define DRV_VERSION	OVPN_VERSION
>> +#define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
>> +#define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
>> +
>> +/* Net device open */
>> +static int ovpn_net_open(struct net_device *dev)
>> +{
>> +	struct in_device *dev_v4 = __in_dev_get_rtnl(dev);
>> +
>> +	if (dev_v4) {
>> +		/* disable redirects as Linux gets confused by ovpn handling same-LAN routing */
> 
> Although Linux in general allows longer lines, netdev has kept with
> 80. Please wrap.

Oh ok. I thought the line length was relaxed kernel-wide.
Will wrap all lines as needed then.

> 
>> +		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
>> +		IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
> 
> Wireguard has the same. How is Linux getting confused? Maybe we should
> consider fixing this properly?
> 
>> +#ifndef OVPN_VERSION
>> +#define OVPN_VERSION "3.0.0"
>> +#endif
> 
> What could sensible define it to some other value?
> 
> These version numbers are generally useless. A driver is not
> standalone. It fits within a kernel. If you get a bug report, what you
> actually want to know is the kernel version, ideally the git hash.

True, unless the kernel module was compiled as out-of-tree or manually 
(back-)ported to a different kernel. In that case I'd need the exact 
version to know what the reporter was running. Right?

Although, while porting to another kernel ovpn could always reference 
its original kernel as its own version.

I.e.: ovpn-6.9.0 built for linux-4.4.1

Does it make sense?
How do other drivers deal with this?
For example batman-adv has its own:

#define BATADV_SOURCE_VERSION "2024.1"

It helps when compiling the code out of tree.

Regards,


> 
>      Andrew

-- 
Antonio Quartulli
OpenVPN Inc.

