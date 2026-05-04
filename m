Return-Path: <netdev+bounces-283722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKwoJ3xO+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:45:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A734B98E1
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D135A301DCD3
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145443033F7;
	Mon,  4 May 2026 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="RUQZ8Jcu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C42E1C7C
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880491; cv=none; b=LreiB0G69u97NsRsEtLmBmOuRyEGWTPmI9dxCiOfavMy4rkb7DKcAbz4m6VBXoHIVwxzw7c6qJxE6lc8A8FbRWQne+StN9pC+ZQdvND0XJeCzrRmyXkbCDlD1ylugEAuL7a0QIWx4zBZ4zNFas6d5CWiLgaMKggddVq3JnL4z+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880491; c=relaxed/simple;
	bh=9C2sSNNeZ1cCc4ayki9NO6X/nZzRwbOwT0cnpksF4xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkbpDZdMVfE9/QHq1N737FewqjmXea+aYYlHdSH98EHf5JEZP8GK0MjjAeceFKz8Q8QJRNl81qR19lRnULFhoaHTGgRNLddDaL7amXMhzL1CXJ3Xh65dLRxZnJwiyQO1aUW1O5MSkdhDPwR6BIWFAx7PHhbWLLBDKt0S38nCHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=RUQZ8Jcu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so35710245e9.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777880488; x=1778485288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N53aTZ6Alw9A7BKH2xpHsS6zd2eepFFKtOswmVsDqXA=;
        b=RUQZ8JcuUclm2Iaw/GyghTCe4JX5eTfQMY0hu4ieGEPN8ZvjPUYqGCS/eoSzNPonVl
         xJ4o3VmJLIRwJLc9dI5YzI9gJs3zhK0SAzHxxyKlMtvQs4mKe3t9dm0xg+t+z8yhRBH7
         ysjMNXIyh0tF/XF+5iJA7R921b65NG/cyp2vvBCqbmrZVngQ5k2K06grXLmGgeLCrTLD
         SYehA3mjcf9GyMNsRWiCemUFRi5/5PDtls7l21WntFcd2nzstnSn6jeUkhvBxU6oFIym
         IYzQRBEi+fi7wLtpncciYCxFSX8FOcrpXbecleIZYLPOQEfUzlPVinfl+bl6vh5oC9fp
         HwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880488; x=1778485288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N53aTZ6Alw9A7BKH2xpHsS6zd2eepFFKtOswmVsDqXA=;
        b=i7HxcmVya+lM3O4H2Rd68YQhcZeY+rmtr4iIyAUzGv7cwwIb9IoTCUpsrgglxjBP8W
         eMcIlWO5+CoALmDUBqdawJLxXrwGBDhtM7qr2v+3y9GcKfmRiA/9i1TkGTspuTVwM9sJ
         9NM/bQDN1mzYJ0IrW0T1VrmdM3PJPT9dvHrJQMM9EzRJfUOMqHTMzvw1swLKX/nf4DxW
         ZZl4efiVqIa1bqRsoUt+6rHYnGl0/xH9dMf+7abYuAOKsoPEiYx0sQbqDShI57qWSXd1
         Jwxjw5C3M6YfUqiTInf2h7kp84j98GTQkf59e2IyHz7yB6gIoHI+3ta9UJ60a+myKa1/
         SC9g==
X-Forwarded-Encrypted: i=1; AFNElJ+WH7NeIjye0wu7RKe5hqZOiMl6EHDW2N9Pj9uw0cIHa3K0QdNpt/Fzs0PvHVzTTBqGRzKCz8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyccu0z+xbqCmFhgTBcYho0Pf56ZyyFxqcsaqsaDM6H1n/ncGgt
	/zjlUDNpSsmi4rMdQP6UrqlCXeU0GW67uHBBRE1kqQxeNSUMEmn8CfZhNKYRTph+szZsYzPvg4S
	EK3swnVg=
X-Gm-Gg: AeBDieszM6Hxi/W3JCCvvo8wQHTgQrhr8u+5pH5BaU/d2IICWrJqcdh7d3muebSlAPP
	EluGSRbKD/mJvMidZUSFrF3efyHDrJlkoF88SSUtjwnMkL78wj4Ci1WNVZSi5RSyVC72KqOgiEG
	H1FLwtyKLdIXOtD6aHbVJXhFzPNvWyCkECCA5fmw2KlEipGQ2jBlf9XUAqlWGwdLM9f0c7U8qi9
	KKjXY/unGv7v4T7KH4LMOUzjPNE3GUE5Y6htbpwmNaNGhNatS5WXhRLM4em5SWudqSDsFt5qBEE
	EBONfDzacf/mKNIki82sUlmhHCdSFgOFwmpuRqTSqgx+zPBXZh94NROlIVvCBnDW7Ck/9fh47+N
	QXfdr0riHeOYU0YaR9PBidwnpzAoV95JZa6ixxqik/x3yEOguVoIMVV98KI8u3sWAjoiWvmI72Q
	0t+Q4AK+PBu6/ZUMPItNLVAA9dUUpR9eBPO2oU0mW8G05NxgkoKF88601zmIu4V2nI
X-Received: by 2002:a05:600c:c0c5:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48a98662e71mr109163945e9.21.1777880487219;
        Mon, 04 May 2026 00:41:27 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a9919fc3asm86901945e9.0.2026.05.04.00.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:41:26 -0700 (PDT)
Message-ID: <7f600103-db90-425d-8ae7-b80cd9d81ad1@blackwall.org>
Date: Mon, 4 May 2026 10:41:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] bridge: Add internal flags for
 neigh_forward_grat
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, ast@fiberby.net,
 liuhangbin@gmail.com, daniel@iogearbox.net, aroulin@nvidia.com,
 fmaurer@redhat.com, sdf.kernel@gmail.com, sd@queasysnail.net,
 kees@kernel.org, nickgarlis@gmail.com, amorenoz@redhat.com,
 alasdair@mcwilliam.dev, johannes.wiesboeck@aisec.fraunhofer.de,
 petrm@nvidia.com, linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260503073532.2138165-1-danieller@nvidia.com>
 <20260503073532.2138165-3-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260503073532.2138165-3-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 44A734B98E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283722-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On 03/05/2026 10:35, Danielle Ratson wrote:
> Add internal flags for the neigh_forward_grat feature:
> 
> - BR_NEIGH_FORWARD_GRAT: Port-level flag
> - BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED: Per-VLAN flag
> 
> These will be used to control whether gratuitous ARP and unsolicited NA
> packets are forwarded when neighbor suppression is enabled.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   include/linux/if_bridge.h | 1 +
>   net/bridge/br_private.h   | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index c5fe3b2a53e8..ec9ffea1e46e 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -61,6 +61,7 @@ struct br_ip_list {
>   #define BR_PORT_LOCKED		BIT(21)
>   #define BR_PORT_MAB		BIT(22)
>   #define BR_NEIGH_VLAN_SUPPRESS	BIT(23)
> +#define BR_NEIGH_FORWARD_GRAT	BIT(24)
>   
>   #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>   
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 31e317a3529c..677cd5d68dc7 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -187,6 +187,7 @@ enum {
>   	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
>   	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
>   	BR_VLFLAG_TAGGING_BY_SWITCHDEV = BIT(5),
> +	BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED = BIT(6),
>   };
>   
>   /**

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


