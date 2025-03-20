Return-Path: <netdev+bounces-176381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E25A69FBA
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A121A3B1DFE
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 06:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF081E5B81;
	Thu, 20 Mar 2025 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="trrMSK4A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0298415D5B6
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742451448; cv=none; b=EK6Ga7XvYxKGxgDwewKk8nwRjdysUVwf+bntwdCTYLt6GEWzGP/oqY2IqegGoTFLA2oP8NM6LKoujrzfCfeQrURoHnkpvvXiKlyYeBLX1aSYuPSu8d/UA6QcRCtirRMDdDh/q5xgu/Kt6c02FUnfnZo45dRA/IzSc1PcSYq7xzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742451448; c=relaxed/simple;
	bh=u0U9bVg2lTqsZtEo43vyK265DyxWNPo+6MP9a1qN1ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOEHYqailCZFi6NB/YHQIu6o/8QUnESKDU+x+bD62L1l4aifPPEtO94LuOqOqILs2OPNwdneBMvKeW8Nu1sifHrXsxQUJBEHoZL6IkpqilI+jNsMDgkBVyCCC/cs01S6lsS9E3JGqcKDSdFe2f7cg2Vrl2EI7qoh0f0pAjY2+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=trrMSK4A; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so3393685e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1742451444; x=1743056244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Df7/nJm6vBgqBIBBRK3eHSwVNX23gpqGbDFzSsS2AQ=;
        b=trrMSK4AvddFzbFgSN4FqY1NjPigR15ik+udqyRYhxt/ugMvuBxi8KW1Qrxnzugz5L
         CubTgW+JixVYA/DOOBNbKZoAeMYsiy1wzDRc4yvxtKoDtcKKnsS/wBiM+WtrKfV4p6Sy
         IHDWSq1MKmOfwK0GJgdlQJgNZzFsASEye7wHm8aBk821tO9Onp2ajQPjc431qsiO0qN9
         NE3QTY6Otv1HGxXr5v/xvzukk4G8hXEXot7/T6Xmp5IvBWgCxMJuIMP5rZlcpWdCVqUL
         9u02hCsBqHx8xuYEgkamJuBnd6FkPBRqMhvfXmvkWdPkhGCnYXLpQcdv7U+EMYh4HF9F
         /Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742451444; x=1743056244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Df7/nJm6vBgqBIBBRK3eHSwVNX23gpqGbDFzSsS2AQ=;
        b=quNiRe/luYr1ww3AExa0b/z21Vxwc367Q1GX3lz4DhaMelCeziJNWyJFJ6CnQgzmxC
         kX2AxlCT7mqGap1LbTzi+flLz9/yYsiw2Ba9CfKSpCkrZwG8E/Uk1BFrvsecYDh0JAYL
         vghVqETzWdKyRuJd9o55bttpvwf/n+QABzn5whj62VJCKjtjXmSuwMn3gmKJdGUzSp1s
         Pgej2EWOJFYAVXqOBqcg4r+HQsB1xBB/1RY9HdZd2oshTKjsbA10bdpkbixja4lYzL+o
         K/7ibBlJc4IAoZkpKTby7pp8UK/0XjgMkCOb3Tpmwy7gSh6lJoFQpLDjXtaqqBPfQ/bF
         CXwA==
X-Forwarded-Encrypted: i=1; AJvYcCWKzYf98ZpQWwYLMg5YcHO94iXrwmuWIG7E8SoEKMH2Vj6XMsdOF5gSSURi770y9rtxU37jMzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbtv73BcB/ONG/e2jbv07zghz8HNyrZnCFz8yxQgaqmRSXbxuF
	x57HoYSWz5dXNz3WcLdHJ3RaFidl8QUDj+Z6wetnQ3XKEYWSzEBKRobdcjcFObA=
X-Gm-Gg: ASbGnctQoIrFUzCsN3WQjzurJPzTqUFv6bUjhnnGTYMLVoDyJY37IPPMbwmJ1Dd0e5O
	ylto40AV+iOs2b7It+bRlnVTv6NtXwhzlc9ycXCFJdpd7FKb2Wgs+4LfRlugt/kzH55IjyMFGvW
	IzfBu8mQEpBirCkwlE/9YbQEX2ldg4TU5X6TEv8cXBqWzUMUPBoT1n5hGVSW4QObYoWD1H1yY0w
	Jv2MiFt6YCbvJfHmaeUSdNbdmU5S/QYxZ0MuocFo3X+4Z0e27KawNoXJOg6Vq9dxf7kz4KgfJpx
	KX09Co/NaeUo+pdnbGn2FcL2pHJTDYBR4hg6DRJcXQ8/D9WhJ37faxVGe8OkxnKt5LDDue2xlfK
	i
X-Google-Smtp-Source: AGHT+IFwempKLPIhGnUTH6lwknWETQgWZuRBG0LDbF84yzf+Q+5WGmrF5EoT6BHx9aMLp2qTRB+XVQ==
X-Received: by 2002:a05:600c:4503:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-43d437c3327mr58255665e9.15.1742451443872;
        Wed, 19 Mar 2025 23:17:23 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43d803f6sm39439615e9.0.2025.03.19.23.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 23:17:23 -0700 (PDT)
Message-ID: <039a0673-6254-45a0-b511-69d2a15aa96d@blackwall.org>
Date: Thu, 20 Mar 2025 08:17:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 0/3] Add support for mdb offload failure
 notification
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250318224255.143683-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 00:42, Joseph Huang wrote:
> Currently the bridge does not provide real-time feedback to user space
> on whether or not an attempt to offload an mdb entry was successful.
> 
> This patch set adds support to notify user space about successful and
> failed offload attempts, and the behavior is controlled by a new knob
> mdb_notify_on_flag_change:
> 
> 0 - the bridge will not notify user space about MDB flag change
> 1 - the bridge will notify user space about flag change if either
>     MDB_PG_FLAGS_OFFLOAD or MDB_PG_FLAGS_OFFLOAD_FAILED has changed
> 2 - the bridge will notify user space about flag change only if
>     MDB_PG_FLAGS_OFFLOAD_FAILED has changed
> 
> The default value is 0.
> 
> A break-down of the patches in the series:
> 
> Patch 1 adds offload failed flag to indicate that the offload attempt
> has failed. The flag is reflected in netlink mdb entry flags.
> 
> Patch 2 adds the knob mdb_notify_on_flag_change, and notify user space
> accordingly in br_switchdev_mdb_complete() when the result is known.
> 
> Patch 3 adds netlink interface to manipulate mdb_notify_on_flag_change
> knob.
> 
> This patch set was inspired by the patch series "Add support for route
> offload failure notifications" discussed here:
> https://lore.kernel.org/all/20210207082258.3872086-1-idosch@idosch.org/
> 
> Joseph Huang (3):
>   net: bridge: mcast: Add offload failed mdb flag
>   net: bridge: mcast: Notify on offload flag change
>   net: bridge: Add notify on flag change netlink i/f
> 
>  include/uapi/linux/if_bridge.h |  9 +++++----
>  include/uapi/linux/if_link.h   | 14 ++++++++++++++
>  net/bridge/br_mdb.c            | 30 +++++++++++++++++++++++++-----
>  net/bridge/br_multicast.c      | 25 +++++++++++++++++++++++++
>  net/bridge/br_netlink.c        | 21 +++++++++++++++++++++
>  net/bridge/br_private.h        | 26 +++++++++++++++++++++-----
>  net/bridge/br_switchdev.c      | 31 ++++++++++++++++++++++++++-----
>  7 files changed, 137 insertions(+), 19 deletions(-)
> 

Hi,
Could you please share more about the motivation - why do you need this and
what will be using it? Also why do you need an option with 3 different modes
instead of just an on/off switch for these notifications?

Thanks,
 Nik


