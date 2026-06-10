Return-Path: <netdev+bounces-297482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V+0pEBoFKWqsOwMAu9opvQ
	(envelope-from <netdev+bounces-297482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:32:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CEA666463
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:32:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=Rkohv5Ib;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297482-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297482-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6251B304EA1B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E288C3019BA;
	Wed, 10 Jun 2026 06:27:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE721A5B90
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:27:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072835; cv=none; b=PHt0ZmXCAJEaM1rDeGsdXC0xPYWsmUtUPlnq68ogEmRyy3P97wWGZVFigIgb4zLldNaAF2RtkMi+660B4Q2ZmQTcCCpcuCVjSwFW8sBVk+THYScUgVKwj+n9opAKWPjk3DF/m2ssG7ol9nDUxtM+ZQV14T4htWjyyemrzhuieYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072835; c=relaxed/simple;
	bh=zHk4TF/iCDFb1jjnvh8IIfqq0u5BFsKY/w2Jt09Hfyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0DGHZoJWmGbdCNW38JS49cc/WZFdvi+reHH0JEEDrg99bQNWPgkjI7DxrLnH34H7NcKWutfOkOy9+W6THuYMibuDua0garn3nNnsgvYdtXFquELDwsNtEQG9/jx2AB9tSPGNoPi1YTBsLNJ18nKkpQ44848iwdk3dRqhFznq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Rkohv5Ib; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso52628425e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 23:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781072833; x=1781677633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9oxKVU0hw/V+LeBxqsgE4VPZXZMlQT+5pcvHUiDUUjA=;
        b=Rkohv5IbhJ3qrjRZoLvauS7SQ2OlrHJqonuJ5MGLwPMTnrVgvllyf8edknz3es5+to
         /DVSRd2EcHOMqIfYqZ238iDenHSNDLRN4t8W+ysrMR7aMTdx8jB8l+BkmYVIj6RVce2I
         lkEKYo344cOluCgOEIjzOX/V0/egu3ejf035sWCWEqua3mknptM0E6A9BAjBHAhP1ULy
         7QMXJ5yxrBvxuBhkKea4BNuQKNhgCQkmE8U4YK1vUpDMXQi/ThwUv7x3hQrW1PUrzfS6
         aSwb3LNuQUpfTE7xe+QgZIrUaROQRCsPXW68KZ5s9bEZ9y6CSoV5qtPe0c+lfYv3Lupg
         Jt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781072833; x=1781677633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9oxKVU0hw/V+LeBxqsgE4VPZXZMlQT+5pcvHUiDUUjA=;
        b=ddCoxkGNaz2qtm23S1kutXnv4OO7xUcxCpO9mRCVmxkKP9LdXljmr2w4ig/q5VAvtf
         Ulx7a6+LofUHmT52ia7F9cLLJ4q0Y0+Hmqm/6OustEyA52IxJhqkCeKaqb6mYY5ulmhp
         OZMUFSuTyXq1/0RTs19iSrwDsHmDgHBQiUBCcMSdXmcml2R8smuEaiwUDIE1uJ+tSnZG
         zfaCUnRwHJcj3//QbYFdxL3ZykqKQAWPif/OBIDOuRPLRohyVSUXgdovoMIskx5t9/Eh
         Zt7BWLYxeAjXBR/LDuCWSBSQ9EC2V2UgoiD0ZGAkUTk7VcJB4Qosemt9kG042ukifM87
         0qPA==
X-Forwarded-Encrypted: i=1; AFNElJ8G4sh9IAZi6fUfC7hlFFiSjc2HoX7X0mBoDO8LLU5Rw76mT49Gx2xCm3njyA9mxDB/8B3bz7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBvJq1H7RTIR1LQl79DCpb0mVwusOg7I+nFH5iigVV/qfIIUp
	+EApWoB048FMz2pmgbNLPn80pjFg6p2Kgh+dLeQXTyEF2WLj/A/aP5WiCi46WaJZwwI=
X-Gm-Gg: Acq92OGxjM+KftyV6XRmKTMi+8jWz4JkfmM4YaMo4PGOUL1hlm5v75pRSL4QJrIT1uF
	vTB0M6sN4BLHPlFdzYHZ8I7lZ70kyJ731oJIYiC9cTSEEuBb3B2NgWquXSB9yyoVSbxNppG7tGU
	Z5GDqi/0ZZt/IZdTdI3B+UL38WkBfhUn/l2Ne/M2wqW7E1c9UMqPSE2HNNoma0VAwXseKpxUdQv
	BC3s3iK0q1oA6EcR4L8smIbayhoYQKUyoIVudTZBG5d9wFu7qswTD6Ra8LJvs055p1A1YVMpYVy
	eDOxMWVE+BSJvBUiJ18wCkrqPC/qD0BO6w44ZyesjpsnDRLvdhYhSLSW6ebnVT4xhU44H3YD8gr
	ZKBCiVU3nL8csRzW/KFu8izxZphF47Bho1tfjVHuAympX+O+I4vMFD1WrRTt9a5H01YU1RkRBCP
	aJOaZzy3NsAcZYSy62L5al7baDOMLjfawTckptCxXf61luJwU9Ngy+xZK8j+WJ57fm
X-Received: by 2002:a05:600c:4e4e:b0:490:c2a2:e91e with SMTP id 5b1f17b1804b1-490d7244543mr83594545e9.34.1781072832727;
        Tue, 09 Jun 2026 23:27:12 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2eadefsm71329082f8f.11.2026.06.09.23.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 23:27:12 -0700 (PDT)
Message-ID: <9c330505-483c-47fc-9a7a-29b8abd6aad7@blackwall.org>
Date: Wed, 10 Jun 2026 09:27:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] net: bridge: use atomic ops to read/change
 p->flags (II)
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260609080839.2506801-1-edumazet@google.com>
 <20260609080839.2506801-5-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260609080839.2506801-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297482-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,blackwall.org:dkim,blackwall.org:mid,blackwall.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90CEA666463

On 09/06/2026 11:08, Eric Dumazet wrote:
> Use READ_ONCE(p->flags) in br_port_flag_is_set() to keep its ABI.
> 
> Use test_bit(), clear_bit(), set_bit() in:
> 
>     net/bridge/br_input.c
>     net/bridge/br_mrp.c
>     net/bridge/br_mrp_netlink.c
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_if.c          |  2 +-
>   net/bridge/br_input.c       | 12 ++++++------
>   net/bridge/br_mrp.c         | 20 ++++++++++----------
>   net/bridge/br_mrp_netlink.c |  8 ++++----
>   4 files changed, 21 insertions(+), 21 deletions(-)
> 
[snip]
> @@ -1246,7 +1246,7 @@ static int br_mrp_rcv(struct net_bridge_port *p,
>   static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
>   {
>   	/* If there is no MRP instance do normal forwarding */
> -	if (likely(!(p->flags & BR_MRP_AWARE)))
> +	if (likely(!test_bit(BR_MRP_AWARE_BI, &p->flags)))

s/BR_MRP_AWARE_BI/BR_MRP_AWARE_BIT/

>   		goto out;
>   
>   	return br_mrp_rcv(p, skb, p->dev);
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index 86f0e75d6e345f8f388ae163860a685279174222..cebd4037744ffa2796c170c1e1ac2f213b315760 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -538,9 +538,9 @@ int br_mrp_ring_port_open(struct net_device *dev, u8 loc)
>   	}
>   
>   	if (loc)
> -		p->flags |= BR_MRP_LOST_CONT;
> +		set_bit(BR_MRP_LOST_CONT_BIT, &p->flags);
>   	else
> -		p->flags &= ~BR_MRP_LOST_CONT;
> +		clear_bit(BR_MRP_LOST_CONT_BIT, &p->flags);
>   
>   	br_ifinfo_notify(RTM_NEWLINK, NULL, p);
>   
> @@ -560,9 +560,9 @@ int br_mrp_in_port_open(struct net_device *dev, u8 loc)
>   	}
>   
>   	if (loc)
> -		p->flags |= BR_MRP_LOST_IN_CONT;
> +		set_bit(BR_MRP_LOST_CONT_BIT, &p->flags);
>   	else
> -		p->flags &= ~BR_MRP_LOST_IN_CONT;
> +		clear_bit(BR_MRP_LOST_CONT_BIT, &p->flags);

this one changes LOST_IN_CONT to LOST_CONT_BIT

>   
>   	br_ifinfo_notify(RTM_NEWLINK, NULL, p);
>   


