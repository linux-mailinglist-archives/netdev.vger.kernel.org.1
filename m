Return-Path: <netdev+bounces-182655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 532B7A8985A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F95B16D6CF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FFF292932;
	Tue, 15 Apr 2025 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="HjiPiKLZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060329291C
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710005; cv=none; b=ftym4dyVQ7vwJ/Te+/6MCuTh+g9OIt7130Q3znTB2gUOJNPIZuo0hvLPOGcchWJjir+T1+DaExc+tnJ17ubXDM1vXhlOywTHuCTYlQE/2YjI4J2azfbN+/88ab4K7M6S6geLww+VofsI37wJgPI4edTADkHS3WBBC1LatSMw+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710005; c=relaxed/simple;
	bh=zuT+UrwO92mBo3PFOJ4dtbbO5SqyhaBWwQA8C7tLxqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuJOH+IsIWw+THwow4U/1i0mrsxQo2uZw6CY3Js1gsj5lRruzZnMFHBIr85j8MXG2VnMsfeBnuNpths/QpOQFldbLOX3IfokOBbJmdPZj+9+y0OU5FZtCRMHti/bln9AI6BhG25U2shDyTnnbxW6+3iJ7MUPzZIAac/omDA4j5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=HjiPiKLZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so44773375e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744710001; x=1745314801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmZOs8Rz2SRsBXQDEu0M9cDNyzZUv/bQ4RbErsr9sHY=;
        b=HjiPiKLZkwf6zK62xpzE/BHjLc17KsQLkb11QXuRGGD3aVYDGvIMOw/SCm0P92gBKa
         fZ7HQglzImY6+sKBz5BKRO7S2U2Ic344A2OUnodo6ZAfjg1GJ8ikvmZjwFez81kaeBC0
         b91cGKAoCUr5ch0nz3t+iyZFAu1TTPfVtqTJYIj3N/Pi34cHGghuAisD4b51x8jfQc2+
         HfH5jukfAkCdNNW2vVstSb0TN8VI/FflEKJ2bYRJIFbycMtgqKprj3lQhIoVcsHnmuLK
         Ho6IvOx6nadEtmgFWlrjY3BQs5v9f5kmC4JL3s5DEabClDH5x/4cVbp4cNa6ENRdvuLl
         QqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744710001; x=1745314801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmZOs8Rz2SRsBXQDEu0M9cDNyzZUv/bQ4RbErsr9sHY=;
        b=oCy4/LSxQJWAweN5gAMdtH12MUfDO2n30ovOKuWGIwo1/BbwyLLVbf09z+qJwEJGGP
         4lyfUF5DqqwA4ZazlLHLmUEESB2d1cuitXEWjuGzGO9NbZ2+oiRD4++1KA54wSGxjbME
         id5/eXdJmqIzPaw9nC7w1PWTnSFUf7gNvlaYm4gv1N+eTHgsZbxmY0ShDibQrci4Jfju
         +fp8v66BB4Q5P/Z2t3LvZHHDTlTsm3L00FJsO/FT3w2MZmslBUTMFlv/4/R75iWcDhj+
         p7IBbi1/Bldv7tj3V/hma/+PmNShmdfZCi4dfyfyi/hqupy7FXGdBJgQwxCPfN47amTk
         fG8A==
X-Forwarded-Encrypted: i=1; AJvYcCWBRhWKJuodOiNzecuUPeUTkfZSJMGM2akCXRiFTzapyj5w129JpOUehrSEuguF4T+9Z7SvHk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxksKoTN8mYdcKDHTP2z9OdKBuolK6I1zD1Ln+qDSP0BMDfq5ro
	nR+1a2+BjAXr48AR4lZtgbHIUk+XdGiYWInE4xQAfdf41kK3eI9P3oLK3hGCoSs=
X-Gm-Gg: ASbGnctT7ZPxIc8lpRvsp0nW5Z1x5hdpucR3MhiWI0fptH7BPvscY3B8ZMvWS9wqufN
	+U5LSDc6J0yzaRg87Ab6rVRS1UjCATM0EVL7++3J9SpYrsi4V0tE2oWYlCk7I+6lcXxmYh9WSy8
	qNK4n5ljJADBpxc44V8qTnL3td9jh+IgXvDjyKQlstoHIJU4+lfGbM3GpDBLulrN2jhYYYfKmhB
	QJAOYbiVfKa0tjBbpmjLpyVM0NXJPDvs0u/81cQ38KIqI32AtkPyhSSfhlPpjz3HsMAhZUOiXsS
	Sc1Pfo3BeegvIvAubCPlV6u1R+IqxSjrY67wToTZ+MmPIdiLj98HgILcZ5hMNvjYyqx+rS2uD8Y
	gZaCGVT0=
X-Google-Smtp-Source: AGHT+IHF2FagMNaFNbqP/pP/Mm5s2FMwRszKIuGZ4NXlyxggm0m0+ymsT1EDLfxfWhc/bLYDwM86og==
X-Received: by 2002:a05:600c:1f94:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-43f3a925eb1mr132089105e9.7.1744710000434;
        Tue, 15 Apr 2025 02:40:00 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d109sm207839905e9.20.2025.04.15.02.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 02:39:59 -0700 (PDT)
Message-ID: <8b338c8b-9514-43e4-b1b8-3240b3bde798@blackwall.org>
Date: Tue, 15 Apr 2025 12:39:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: bridge: locally receive all multicast
 packets if IFF_ALLMULTI is set
To: Shengyu Qu <wiagn233@outlook.com>, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
References: <OSZPR01MB8434308370ACAFA90A22980798B32@OSZPR01MB8434.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <OSZPR01MB8434308370ACAFA90A22980798B32@OSZPR01MB8434.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 13:56, Shengyu Qu wrote:
> If multicast snooping is enabled, multicast packets may not always end up
> on the local bridge interface, if the host is not a member of the multicast
> group. Similar to how IFF_PROMISC allows all packets to be received
> locally, let IFF_ALLMULTI allow all multicast packets to be received.
> 
> OpenWrt uses a user space daemon for DHCPv6/RA/NDP handling, and in relay
> mode it sets the ALLMULTI flag in order to receive all relevant queries on
> the network.
> 
> This works for normal network interfaces and non-snooping bridges, but not
> snooping bridges (unless multicast routing is enabled).
> 
> Reported-by: Felix Fietkau <nbd@nbd.name>
> Closes:https://github.com/openwrt/openwrt/issues/15857#issuecomment-2662851243
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
> Changes since v1:
>  - Move to net-next
>  - Changed code according to Nikolay's advice
> 
> Changes since v2:
>  - Fix alignment
>  - Remove redundant parenthesis
>  - Add more infomation in commit message
> ---
>  net/bridge/br_input.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 232133a0fd21..5f6ac9bf1527 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -189,7 +189,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
>  		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
>  			if ((mdst && mdst->host_joined) ||
> -			    br_multicast_is_router(brmctx, skb)) {
> +			    br_multicast_is_router(brmctx, skb) ||
> +			    br->dev->flags & IFF_ALLMULTI) {
>  				local_rcv = true;
>  				DEV_STATS_INC(br->dev, multicast);
>  			}

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

