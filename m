Return-Path: <netdev+bounces-223237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CC2B587AA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBD9487F43
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E12D480D;
	Mon, 15 Sep 2025 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWf5L8e2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52F299A96
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976083; cv=none; b=poU/hSoKpveglczgAK/q6oSf4BFS+GEKZrZVPzv+8S3Pxie83GdUMsTtkfubQpeP0jzlngs7TGpFbBi9ZUBoR5zt3Gpza+AfrZhqJFYAaX4zrAEO8P6XF/PSlRpgTcDIhxHtRLi1icvgTUvIxmGSyx9Qn2ZGOrkEr6bEY74KItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976083; c=relaxed/simple;
	bh=/FpEkskje8VzgmQKrHZ28YlaYp7XOkF/46P2Reawgcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/ZlAQBWlAawDXtQ7OVkcnapGLekA9yBOQIDp1cuw6cHy3oqy6EUjmlrG9RZ5/2eUphaqgxtnyIKXfv/iee5u2QebYhlbJsb3K0s8SpmOnexLOM+7W4pf4QsmEoGRh0dsRyKOoHnFt01KniGWQi8DBxYLDIL9QXFpSNFy6+36kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWf5L8e2; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-60170e15cf6so3186399d50.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976081; x=1758580881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SASXu10pDfkgCCS289Wyjl4zMwympeKKk54Tf2B/jKk=;
        b=EWf5L8e2qgageF5LTvh0wsfFaMfjUNE3SvV0nn49XC3jIC72dvy04mtZhteuXRF+JT
         o7hphU8y2g+bkF4zlzxbkFBPU8cFv0g1YypsdZFguUqpoMcdS2olor7F1xJA1qWtTvoM
         py53QY6YAa7b2Q5p9szr1XWMKLD0TMBkkkAVXa+KWkvwLc8X/bKEkDwYxUgWbXv4jTSA
         XKWWF7wu2svzvfrgziljPomoWqr5axWeZP4mSRh9tIjJyHI8hdkraNx3s2YbKmr/ALPc
         MNpyuOZbNBz8s72uwoqsVxL7GVQWc+WQSajs8AyDgLi4Cmo4Xwj06es7X5FsQaaTWqqQ
         daPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976081; x=1758580881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SASXu10pDfkgCCS289Wyjl4zMwympeKKk54Tf2B/jKk=;
        b=ioHBS9gXL0eEzwDA82SkYj5nFRvQ8uBjxkwGWrrJcT2iqylqvmJhy9m/jVRWHFi2Q3
         csgSEfIiUKJ2gOcEiD2NDGqS6POilqqtKdfA5GAQB+Ji+jr3HS8JInOE8wwaCxWQyZSr
         01Nvyu0XWxNcQMrU2gxXDVfjnlREeNPxI3E4lBYja4Px6vR91FNybmsoW421zwI5HpCc
         BWqKb+k+5A6b7jJcSSiFWoZMJvOA6VF8NRBnxU9T8Ic0KsXzz+6zDjziH1pCe+jAQx9H
         y8qHOs45E6I2RZTL59P5lQsVkFlbC4MsHRbOreUYY4iRita7UWlDoFw7yls3HpVYiiRn
         4GAw==
X-Gm-Message-State: AOJu0YxM6gK9Xi2LKC/1zBtcg5KNKXTyDh+dvUsrXqIOYbzxngDN9SzO
	vSS9GrE0da98PyAmke9klWlK1l1QsnohphuVsnAnb1E4s85w/E+WXty3cagt5CC1
X-Gm-Gg: ASbGncuQMlUeCfaLOHrBPxaBreMi/D9AhFHovIOd+xWqs4/ad4TMInh3a218OrNYgbF
	ohRxXPzKuF3wgGfSFF5AS41f2ZqlXNVI2QjqXufD3SHlL31M8d3nH6lUBOSUWzJN9gik7D5any/
	aYa4q/ALxNTX//7PetqPK2UbcKw8aae8qui6uXhSFFxle8XIunbEogm+tPKbkNdoqTSNz4rKiQT
	BGyIM5eeBTmN4vMJCxnPJV5fGZ+VbETO+OGRxz0hDeQ0ZK5S1zHDwun2mwOWZE5W9NK2eOkK2RJ
	YyUVV/it9twiZq43zr1ii34NrmcIfxMo/AGcaFCJK+Z0GGunmlgepSeuRZLRJUsFrkgNH623lvN
	j9kefaVm8TRuhPcsrVk/NLZubAs4Hd4ZpHE9p7COQ2/eZuhhGKxXavbOLVDAabA==
X-Google-Smtp-Source: AGHT+IFKVDiqyeLRRwAZpNsUiXjihQklNAwRtRpOrO3aDhyURhUxOWyVrNC2ovqPRD+l0SvqAcUU4Q==
X-Received: by 2002:a05:690c:680c:b0:721:64ec:bc64 with SMTP id 00721157ae682-730650e0742mr139176837b3.35.1757976080933;
        Mon, 15 Sep 2025 15:41:20 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f791a35bcsm34972157b3.39.2025.09.15.15.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 15:41:20 -0700 (PDT)
Message-ID: <be567dd9-fe5d-499d-960d-c7b45f242343@gmail.com>
Date: Mon, 15 Sep 2025 18:41:19 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: Trigger host query on v6 addr valid
To: Ido Schimmel <idosch@nvidia.com>, Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250912223937.1363559-1-Joseph.Huang@garmin.com>
 <aMW2lvRboW_oPyyP@shredder>
Content-Language: en-US
From: "Huang, Joseph" <joseph.huang.at.garmin@gmail.com>
In-Reply-To: <aMW2lvRboW_oPyyP@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/2025 2:23 PM, Ido Schimmel wrote:
 > On Fri, Sep 12, 2025 at 06:39:30PM -0400, Joseph Huang wrote:
 >> Trigger the bridge to (re)start sending out Queries to the Host once
 >> IPv6 address becomes valid.
 >>
 >> In current implementation, once the bridge (interface) is brought up,
 >> the bridge will start trying to send v4 and v6 Queries to the Host
 >> immediately. However, at that time most likely the IPv6 address of
 >> the bridge interface is not valid yet, and thus the send (actually
 >> the alloc) operation will fail. So the first v6 Startup Query is
 >> always missed.
 >>
 >> This caused a ripple effect on the timing of Querier Election. In
 >> current implementation, :: always wins the election. In order for
 >> the "real" election to take place, the bridge would have to first
 >> select itself (this happens when a v6 Query is successfully sent
 >> to the Host), and then do the real address comparison when the next
 >> Query is received. In worst cast scenario, the bridge would have to
 >> wait for [Startup Query Interval] seconds (for the second Query to
 >> be sent to the Host) plus [Query Interval] seconds (for the real
 >> Querier to send the next Query) before it can recognize the real
 >> Querier.
 >>
 >> This patch adds a new notification NETDEV_NEWADDR when IPv6 address
 >> becomes valid. When the bridge receives the notification, it will
 >> restart the Startup Queries (much like how the bridge handles port
 >> NETDEV_CHANGE events today).
 >>
 >> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
 >> ---
 >>   include/linux/netdevice.h |  1 +
 >>   net/bridge/br.c           |  5 +++++
 >>   net/bridge/br_multicast.c | 16 ++++++++++++++++
 >>   net/bridge/br_private.h   |  1 +
 >>   net/core/dev.c            | 10 +++++-----
 >>   net/ipv6/addrconf.c       |  3 +++
 >>   6 files changed, 31 insertions(+), 5 deletions(-)
 >
 > A few comments:
 >
 > 1. The confidentiality footer needs to be removed.
 >
 > 2. Patches targeted at net need to have a Fixes tag. If you cannot
 > identify a commit before which this worked correctly (i.e., it's not a
 > regression), then target the patch at net-next instead.
 >
 > 3. The commit message needs to describe the user visible changes. My
 > understanding is as follows: When the bridge is brought administratively
 > up it will try to send a General Query which requires an IPv6 link-local
 > address to be configured on the bridge device. Because of DAD, such an
 > address might not exist right away, which means that the first General
 > Query will be sent after "mcast_startup_query_interval" seconds.
 >
 > During this time the bridge will be unaware of multicast listeners that
 > joined before the creation of the bridge. Therefore, the bridge will
 > either unnecessarily flood multicast traffic to all the bridge ports or
 > just to those marked as router ports.
 >
 > The patch aims to reduce this time period and send a General Query as
 > soon as the bridge is assigned an IPv6 link-local address.
 >
 > 4. Use imperative mood:
 > 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 >
 > 5. There is already a notification chain that notifies about addition /
 > deletion of IPv6 addresses. See register_inet6addr_notifier().
 >

It seems that inet6addr_notifier_call_chain() can be called when the 
address is still tentative, which means br_ip6_multicast_alloc_query() 
is still going to fail (br_ip6_multicast_alloc_query() calls 
ipv6_dev_get_saddr(), which calls __ipv6_dev_get_saddr(), which does not 
consider tentative source addresses).

What the bridge needs really is a notification after DAD is completed, 
but I couldn't find such notification. Or did you mean reusing the same 
notification inet6addr_notifier_call_chain() but with a new event after 
DAD is completed?

Thanks,
Joseph



