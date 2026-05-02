Return-Path: <netdev+bounces-283379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLagOgmU9Wm8MgIAu9opvQ
	(envelope-from <netdev+bounces-283379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 08:04:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BDA4B1189
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 08:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94DA33013889
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 06:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0443C2ECD1D;
	Sat,  2 May 2026 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="kG2wG6Jn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB52DF13E
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701892; cv=none; b=Ergiq9B2t+ceKLGhLIordijfqs4O/9zFwYYvJucJzZRr107MOeUa4duT79yFClxIYTQXsUVkRc1pFLc6/smdB606eCWJkI2iCJOParKL//ReTKBUeTq7dUcedf0b3QEVk8t2U2t6j1FzVgxTKF4MBBSLzJgO4AEozoRvU82n7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701892; c=relaxed/simple;
	bh=5VSyqBvoid9uFXOUdR772I1+U0H44cOPYNrNocs56ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InUQpwSZZWk+c1BENKcBTenyPLw1AvN/9CyYRVUdKKS9aL6AkLWQVI3oFYYh+JehtwTFhn6Ypc7KlrF9DFpzY6H/vZ+XB1IcLPo3gCEO3kZstQSvk/R9T7VZxguP7PwPzpKW/1/q1Uhd8dfFScsPahwgnWVicoNJBCuk25Tfeuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=kG2wG6Jn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488d2079582so27135215e9.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 23:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777701890; x=1778306690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePyFY9tU1bqBeZ/CDvqIuK5nLfvL0Jsqz80NzKwHDyY=;
        b=kG2wG6Jnt3Cj/nb5Iw7wIlfK0BOqouM0pPso1iI1aFMM1JRGe4Rc5gGpHAUarvapK+
         BDO3iNo5ZSsbbTBw0CfT2JK6mLRa9fCWNcREMIHoRVXwquDWZyZ+8aBHJN06BiQ2qSA8
         iM+hzH9wyNK157wxeE8yduPVxgWhhFJwF8k0OFEp2Lb5x1ylHUiLo6P6qJQaUQw+mhgp
         SlZZ0Fi4ufkWTgt5hqgf/GaDt4bNT5uxerA9Lbw0OkvYUAU+Jsr/K7nuJxkVTTUcAyuO
         ZjYFqpAKaWWYexn/ySeK9mVByCTSCgCAOZSDR0kj4krgJwkwRvFOxJyS7bx4072CwQII
         1GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777701890; x=1778306690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePyFY9tU1bqBeZ/CDvqIuK5nLfvL0Jsqz80NzKwHDyY=;
        b=EqhkrblpFfQwF0ft4ao3TbL1GkhC9rWCTHsLFzlWpn0zeNS3eEm7oLSl2KQn4sWn3q
         2WwGhDKAOJ49pVy7y32a4K4sMFfXgkZlg3gzXZ2z1LX11VARmA3WRgkWEgiGsqw2/kdC
         jjRv1fj+VGupVcryE40a3Zi98t74Dp4mtSo2jEmkWRojwMM0l8cp+Ys8qLaDm1OfVks8
         flfMpUpptUl3D2uOeYbbjq+pvWRBvUqouxD6oorZrLU6Dpqrayv7OLzYBT2whUztcJsM
         qPD9sVJoUX82VaQ7fv6mq8ISTZSd9VD2uxkSGJizsLtve3VRNECrhl0ydPhyIL6Y+XQR
         r5yg==
X-Forwarded-Encrypted: i=1; AFNElJ+kaO/30/Z/j8gyDQBFLJhsPxKeuqBI1pXpdddY/qLrb/kLRaSzkxltvNWbUO64V0N5lFcEnpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82ZANiyLx4vri3xW95by6aqnyc264RrBuv94iTHYScMZGsanN
	mUDMr167AorfreMNrErFMg4zHrENpbF2bLMnku1XrRIitPKI50Wo600CR5tB/UV8B5I=
X-Gm-Gg: AeBDievZ5EK+Io7W9uq0DqiaUxSdZ0zAQF31gZFF9D3KYD/0KQ70kXvxUHz9qm6+SId
	00a3MzuHAY2+xf9FwJPWZ2YdmRqlLb8m/QF5apOa89AGIhi2gxsqFYY76EepO408R42nvNiF+Vy
	Dq9QQznU1ewb3XAWzQW+gdWbGYKhBxIFq6LsoFZIGywS0St+aTmMUpRG4beHy9MesYp+NHhNoDT
	/RoK36ErbChFaJ7EjE+RDX+owJ5x7VGFOmJ7/vJoID5E278lJPICgLuTZTIUrn/Q8fi7BDkPzZu
	xP7a0hhFDlphA/YRiAWtc8l1UFeJX77cHurDwZsT0Je3pbPtq9ss2NIN0b2Jcv+DvPl/6uu8lMy
	vxdtmWv5nnxefxOvhQITbKqaJl/RrOhxybXkYNZaFgnDrpjT3HLzmvP2dHol3RXvAdG1NL5dLP1
	EVjHZtJGhxc9FS7kQnbfEWCqki32ILH7OtMqVI6MrV7DhwXiiO/wkWwGDCDpdE8ngiWEqg7Vo5H
	cE=
X-Received: by 2002:a05:600c:4450:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48a98639086mr24427625e9.9.1777701889840;
        Fri, 01 May 2026 23:04:49 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69698sm185348695e9.1.2026.05.01.23.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 23:04:49 -0700 (PDT)
Message-ID: <b4d8277a-2a5b-49d4-a132-0f875e580fae@blackwall.org>
Date: Sat, 2 May 2026 09:04:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] ipv4: igmp: encode multicast exponential
 fields
Content-Language: en-US, bg
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>,
 Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260501173130.3486-1-royujjal@gmail.com>
 <20260501173130.3486-4-royujjal@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260501173130.3486-4-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 69BDA4B1189
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283379-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,blackwall.org:email,blackwall.org:dkim,blackwall.org:mid]

On 01/05/2026 20:31, Ujjal Roy wrote:
> In IGMP, MRC and QQIC fields are not correctly encoded
> when generating query packets. Since the receiver of the
> query interprets these fields using the IGMPv3 floating-
> point decoding logic, any value that exceeds the linear
> threshold is incorrectly parsed as an exponential value,
> leading to an incorrect interval calculation.
> 
> Encode and assign the corresponding protocol fields during
> query generation. Introduce the logic to dynamically
> calculate the exponent and mantissa using bit-scan (fls).
> This ensures MRC and QQIC fields (8-bit) are properly
> encoded when transmitting query packets with intervals
> that exceed their respective linear threshold value of
> 128 (for MRT/QQI).
> 
> RFC3376: for both MRC and QQIC, values >= 128 represent
> the same floating-point encoding as follows:
>       0 1 2 3 4 5 6 7
>      +-+-+-+-+-+-+-+-+
>      |1| exp | mant  |
>      +-+-+-+-+-+-+-+-+
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   include/linux/igmp.h      | 87 +++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_multicast.c | 14 +++----
>   2 files changed, 93 insertions(+), 8 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


