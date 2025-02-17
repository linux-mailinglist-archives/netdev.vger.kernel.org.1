Return-Path: <netdev+bounces-166961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C92EA38263
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1375167909
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D125219A97;
	Mon, 17 Feb 2025 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QAClIXWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC8A19F128
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793283; cv=none; b=PdQl/RO37HqW9/1Z6+8LKvfoiefkZW4dhaXigED/0vkH8uQ1fc/+SdrdwtSiy7u3iyLdJvBG8PdHDDlASz+kwoMIYby8D3Ka3oNZTd4yDrz3a/qrLvJYf2x/VhghESVf3itFIIkWAcfv7A9XQholAI9E55P0CUIOW71YKeynFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793283; c=relaxed/simple;
	bh=CNZT+25ePdrVoRVjO98eXznFTfieoFVKs8XN57JBj0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7VB/Xnd1SwcbvrwmcXBnGK79FulTWNTWM2Lmmps219jgWadnUMZ1YCV9zu+Lzlw3Ac06Sgrfcp6PFVAV9T3VAOtoqOE7z8GaJJ7vHuv7JJAhCQuwb28sv5XbuUHcHAZhcM6UOuJY3vZgtVTnLTcAjLhf3fv2eYfKI9tQBI8lko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QAClIXWv; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so6860304a12.3
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 03:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1739793280; x=1740398080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ODoUNIzhz8wbS9RlnqshxBZqUZSt9lnSSqoVHSSyPbo=;
        b=QAClIXWvVYY01roVLlcpb9TTJ86LJOq+KhJTDD2k/6ImP4iy7SZyLNBPkRBaigkkSr
         U4utWB2Diy9ewkOktgrDjUpHf7j5YLSavn1NquBdjaPHgtYiJpqv+49QQXP5qMg8mApU
         9eZjKzhr5JZgxON733sTMGNZcikGleNrP4kmjg4LNcV2zhyJGBoUBXGdkBIoR84WEzZQ
         /60jp5D5QEoyCsUrnimWYUS7fsA+ASbotSf+9yXvll5ehzTDP3kQhedo8r7DosQN5k0G
         z7m03Xdlv1ArqJvXwy9IRLIi4WV7wmi31FfXN1RnqaECNz25G5YjArUVRyK5bVZEri9B
         Dp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739793280; x=1740398080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODoUNIzhz8wbS9RlnqshxBZqUZSt9lnSSqoVHSSyPbo=;
        b=FKpsyRSFpajVsg2J1qtseYJ7RDxHgm1Uayp1Rvi8E7wOGBd8DJ2eCC9iCYIvXxibbG
         FpemR9hmGiG2HvDZDQGNtDgv7z6QW4pdaGJMqRdxRdZxgQuiLA2EsrK91oZm0KMKQ/Dc
         B4bW2WoxQFFYbYSVSCC+rrF/K5lF4JWuQS8BwnpHlwzMtqyekURuuUnS0yOe5orp0UBN
         aEsXYPOyRvEZGf0cE5XzDYHRU1vezAVjgf0OrkxeLT+UQkUuwikDJNie6ml203CRX7aM
         2tIQYFnBxtihskNnKz/xWciNeb7S5aAaK4X31g/8rR2gZrR/vSeIsETmT9jrCCDXETgs
         WvkA==
X-Forwarded-Encrypted: i=1; AJvYcCUcltyUl1/TQIlCmTfCtdyQagsyR5HVCeCKRlWs/ZQAy5T8Gt/7SQlsc3Bsri4qyDMiYODSndE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysxMK8BhzKJgbQlSJSjmF0u6/DPYAANuHuqDyY8FB2iQYQUTtW
	R/QoLHMf2C5wDomwH5G/2b9IEcO1DEGgC9eoOhTe48vjjwaKUnkEAK4KwYYVffI=
X-Gm-Gg: ASbGncu7usP99qx9CuPlhgpGgIR+EmgQrrCtpjKb6nnhmcOUJOOz03lG/Bqv3EkHnKq
	XQxCmOdzOur0acwgAbX5DFRFKP53L63hcRNLY8iDOnXXA/F2SalNW6yMV5jYUmVMgvB7VgPTHCA
	WiYA2msNpiXIlEraugPVH4Njp0aDcnnQ+IvYNJdew3KB8epgy4TIQQqTJVLrZT1A3IYL1grugrY
	S/bvrtIJxoxp+U6G8UiHTIKkOk5/69EGx4V8pqf1krYSlQpB/9egc7+ZtRSwyNdIJIPsnkAJmoV
	aUA+DIejvI9xDmbbfGtexOK8WM2rEyjvJUfXE/VwGhg6ncs=
X-Google-Smtp-Source: AGHT+IH5LYB6p/HXb8BGQs5I7Qwcm3npFyWcKGxO91RFb9WWl38/bVbziniG96GtqAkw2iimohL1RQ==
X-Received: by 2002:a17:907:72c8:b0:ab7:be66:792f with SMTP id a640c23a62f3a-abb7112e046mr1020984366b.49.1739793279612;
        Mon, 17 Feb 2025 03:54:39 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba9bd6e22sm71743666b.121.2025.02.17.03.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 03:54:39 -0800 (PST)
Message-ID: <37bf04ee-954e-461f-9e37-210a8c5a790a@blackwall.org>
Date: Mon, 17 Feb 2025 13:54:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: locally receive all multicast packets if
 IFF_ALLMULTI is set
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250217112621.66916-1-nbd@nbd.name>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250217112621.66916-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 13:26, Felix Fietkau wrote:
> If multicast snooping is enabled, multicast packets may not always end up on
> the local bridge interface, if the host is not a member of the multicast
> group. Similar to how IFF_PROMISC allows all packets to be received locally,
> let IFF_ALLMULTI allow all multicast packets to be received.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/bridge/br_input.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 232133a0fd21..7fa2da6985b5 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -155,6 +155,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  			pkt_type = BR_PKT_MULTICAST;
>  			if (br_multicast_rcv(&brmctx, &pmctx, vlan, skb, vid))
>  				goto drop;
> +			if (br->dev->flags & IFF_ALLMULTI)
> +				local_rcv = true;
>  		}
>  	}
>  

This doesn't look like a bug fix, IMO it should be for net-next.

Also you might miss a mcast stat increase, see the multicast code
below, the only case that this would cover is the missing "else"
branch of:
                       if ((mdst && mdst->host_joined) ||
                            br_multicast_is_router(brmctx, skb)) {
                                local_rcv = true;
                                DEV_STATS_INC(br->dev, multicast);
                        }

So I'd suggest to augment the condition and include this ALLMULTI check there,
maybe with a comment to mention that all other cases are covered by the current
code so people are not surprised.

By the way what is the motivation for supporting this flag? I mean you can
make the bridge mcast router and it will receive all mcast anyway.

Thanks,
 Nik


