Return-Path: <netdev+bounces-203239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4811BAF0E38
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755E21BC5A14
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A111238C1D;
	Wed,  2 Jul 2025 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="QmPLTBMq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C55235061
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445712; cv=none; b=UQd6bj8RlLn1TizLpHGgbVuaY3PKZq2GrzDeIvu1YH/Beuy/+1nrdvEozQs1E61TvHZkkzpuTiYKSv8Dz6gd/dSC+A6JIplwAyMWJVDxRLaLULsy7IdF4HBJGhRoXE1QyuoySb0RtpwxRMOJJO9+10wb+jJko4/DZqVs8BI81OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445712; c=relaxed/simple;
	bh=yiZwDP3lXQ5zigCNoF6oAAAWr7zjLZWfVbmf4bcC2SA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BnrHXRhkP/DcHzsTdAfBqp+f6+mLYbZFkceS+xw0WhJuHCHC90c5RhIwqQMIOdA/lZLOVX7FesQdKq2ckLKO0+XLufTYh9UecwKdP2ruVIso5Z3hyVsuqPx7Ic4qvJGnsviLQ0Xnr2p2FMiWF2wR0gwezbFdVa3Htpg1KsOVX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=QmPLTBMq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so13208092a12.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1751445708; x=1752050508; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+g1v0m8aDNnOEfwu4uRQC0dDUg9Qe01yaAwfMhR5CgU=;
        b=QmPLTBMqcXHZihkwxbLm4jjUDK7jxZn9J29NIVFXpxv+hGPX3Q2GrRVjVaGJLYgyMk
         +VdBi82Yo6IKDRO7P+TKByyrLhJTl16LZhSczU/AHxZC7oIVWIE7CUQ6aaer2rqmSPP7
         8ncQWB/4YnL8wT3E/ZWdCpAyefQvc7iUbb7UcVz1kRaFivOVt6tHC1RNW9kFLJvV8XWl
         O6pz24YnZlQ50p9I95gBH5Cjj3MozTGyGzgGOxY+jKqHtbkXdN/huP2wmhR8NyZlgycG
         RHGgE0glj91brhQAvhBISwtJqltJICTd9dvUUvtqgv7e/WP873GTxi+Y/fy0aefGO5oy
         S3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751445708; x=1752050508;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+g1v0m8aDNnOEfwu4uRQC0dDUg9Qe01yaAwfMhR5CgU=;
        b=aM+/R0ZBd9PYn8AeW782vBDGWbBSjgy5DThd2j+WnOr5q5K+GNVkPuTcaAVMaUFjOt
         gerfObctCwCYNlXcWuNWkiJ7PKQSnXlS1k18VZTWCCNpNA6gQF161C+o2GVBrYx2EvL8
         t/zFLJVXANzCFPD2RKRex1Sc12MXcfbCVLPa17z6InQxh/Bu5dLABjveCox8iMQHAUQv
         PMT2wlEGfsBiJ6VryNIRGI+Z4Gs3+r2xn3CNZnBBXEkjwDQlTP3TPGXl/yQ2qAizDeY6
         ncmbufN+pi2N2xo2lEShvaagjUykUcGCCCFIcaZclKYyQx612u8CyhuZue91QcS7HsZe
         EQsA==
X-Forwarded-Encrypted: i=1; AJvYcCWQuEX5M4hJszQ8KSyv3nr8J5tBeRmuGgvEi8DwAT+gUoo5c9HTN9xc1IiP6di9j6m8DDdblPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8K6BcnjE54GjL4tHufIAEAR804IAgOCMOxCxJgBtMP2R/A1si
	D0SpIfUvGGRxeGanjKuQi0zjObqdXC6XGijoiCDJ286zxXfrcN2UI8Gma7MSceVd4x4=
X-Gm-Gg: ASbGncve05dW05wtszhwl+S8/HwFStzUOJQ4hA3s75avUMnJds00O2z0k12MjOs9qSx
	keNLQq0z3ANVXGtReDoR4HJ/0Utw9Sw7UGVrqX618xBb8T0pbiJ/lio2qa8A3oj/KOcZuYtuXXL
	4z+z9vBqJsOlWtWs551HV9sJgbO4s9EYj404hoiFe2Q89PwjxdABhKp+S5Vl3njDHQClAztet/h
	idGSnd+KRN7zzL8k3Tcgu4qDrCrhNqxlk5dtnBl0L9lS38e5LfkXm3woBhKiWayhanoNmPAm8TY
	21mCux0ifO/USsML1NurL+2ucgiumOhkMPBGopicA4Emp17IRgcQsNjjtmpHJjt/hsbJwk0LVtU
	j5JP8qcvDHmvE4aOt
X-Google-Smtp-Source: AGHT+IEAT04i+G6dTY7KDU/s2zt7X2lFu59Vom3aNPj/WoKa/U2EndBYJk+f2l1y2tj0gHmlMwt+vg==
X-Received: by 2002:a17:907:944e:b0:ad8:9b5d:2c1e with SMTP id a640c23a62f3a-ae3c2c8b851mr204395766b.29.1751445708272;
        Wed, 02 Jul 2025 01:41:48 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353659678sm1041760966b.38.2025.07.02.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:41:47 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <Joseph.Huang@garmin.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: Do not offload IGMP/MLD messages
In-Reply-To: <20250701193639.836027-1-Joseph.Huang@garmin.com>
References: <20250701193639.836027-1-Joseph.Huang@garmin.com>
Date: Wed, 02 Jul 2025 10:41:45 +0200
Message-ID: <87a55nyofq.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tis, jul 01, 2025 at 15:36, Joseph Huang <Joseph.Huang@garmin.com> wrote:
> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
> being unintentionally flooded to Hosts. Instead, let the bridge decide
> where to send these IGMP/MLD messages.

Hi Joseph,

Do I understand the situation correctly that this is the case where the
local host is sending out reports in response to a remote querier?

       mcast-listener-process (IP_ADD_MEMBERSHIP)
          \
          br0
         /   \
      swp1   swp2
        |     |
  QUERIER     SOME-OTHER-HOST

So in the above setup, br0 will want to br_forward() reports for
mcast-listener-process's group(s) via swp1 to QUERIER; but since the
source hwdom is 0, the report is eligible for tx offloading, and is
flooded by hardware to both swp1 and swp2, reaching SOME-OTHER-HOST as
well?

> Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  net/bridge/br_switchdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 95d7355a0407..757c34bf5931 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -18,7 +18,8 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
>  		return false;
>  
>  	return (p->flags & BR_TX_FWD_OFFLOAD) &&
> -	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
> +	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom) &&
> +	       !br_multicast_igmp_type(skb);
>  }
>  
>  bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
> -- 
> 2.49.0

