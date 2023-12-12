Return-Path: <netdev+bounces-56284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B180E697
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551CE1C2137B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5DC33988;
	Tue, 12 Dec 2023 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm7TpP8C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F2A138
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:45:51 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f223675aso14083341fa.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702370749; x=1702975549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PCG1GV6nAF1QJc7g5lT5OXeYjMxaZziQBepc3fCSZzY=;
        b=cm7TpP8C+7YJsqdMohGHVjf7dutTWG7y0ELNIJDhYLvL8/3JLAhpP4S8gCLNSZENAN
         ycqQEjaqHBZR7vcRJhFmqqsos6E381U4OgVbRlksIYQFyMlIFtyDWOMKEsxPlY2Ys57X
         k4xYlkhuy0cEit6RX5MWY8/mH3DUMMciDgZWbO365Phb+I2tVSk0xCPwHdoJDzcGANac
         HIyrGtY5TTlswKjsG4XeZJm2JKNufDs/ZQnzR66jloMlebkztuWZ0K4aVOuM/PK8XzjG
         rmqhGSFO4xUyZCQW8PFpEAXCROpbnajB+Y5pj1/wqbO4i16sa/h6TjkEHfFiyWWnwU17
         nSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702370749; x=1702975549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCG1GV6nAF1QJc7g5lT5OXeYjMxaZziQBepc3fCSZzY=;
        b=VY8G6oGCyK7WrcmxbvuxtHdYOD0BYhCIWm/GC3z376lgD896qWUBt8jTt3Ms3V60En
         YBqoqDsz3Q2pd9saMF7SSOsKYMWAg/Hul4zvWjJyEc6IjHxHIFcV47DDR3ltAG/r9M0C
         m1J6yXPUV3gHVmmTPNxn8Rknv+1OEJ0LyBY6WP5kMXoMpHG7UkOraik79BTyGJS9T5Qt
         xuB8+pS4tU/osj4MNx5l3Pqcau0NS7v0ipv5fcYdM0dFOUZGfwZsFmS9d0xJVzQSjmIo
         houFSzSBieGHooe7jOKtOoOzHfHaBhmqxrBj2+Xq5SdKhMlXyXTtd8FRwno4Hd2UzKQI
         rtFA==
X-Gm-Message-State: AOJu0YwgkiyxFGtpz8C9skX01o1pGOsN4h4o+PB70LwZ3vCa0JXvKXER
	SWIMgyCCJJmFzSQROIr2NEI=
X-Google-Smtp-Source: AGHT+IFgNr+zAGskOF3ixnLt7pIQ+H9ITVN95XXHPjJxsOu+7rd+ZXDH9x3iCG958Q501DbkGvJ7bg==
X-Received: by 2002:a2e:a451:0:b0:2c9:f86f:a9b with SMTP id v17-20020a2ea451000000b002c9f86f0a9bmr4419989ljn.1.1702370749188;
        Tue, 12 Dec 2023 00:45:49 -0800 (PST)
Received: from [10.0.0.4] ([78.240.84.75])
        by smtp.gmail.com with ESMTPSA id w18-20020a2e3012000000b002ca2961741csm1432239ljw.50.2023.12.12.00.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 00:45:48 -0800 (PST)
Message-ID: <db6e4234-37d8-4794-8917-fa7bd2431db8@gmail.com>
Date: Tue, 12 Dec 2023 09:45:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: netperf TCP_CRR test fails in bonding
 interfaces(mode 0)
To: ditang chen <ditang.c@gmail.com>, netdev@vger.kernel.org
References: <CAHnGgyF-oAnCd+NdvdZVzhE4VZLnK+BcVBH3gQqm9v0Q1s_QGw@mail.gmail.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <CAHnGgyF-oAnCd+NdvdZVzhE4VZLnK+BcVBH3gQqm9v0Q1s_QGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/10/23 16:16, ditang chen wrote:
> Reproduce
> 1. client/server:
> # modprobe bonding
> # ifconfig enp1s3 down
> # ifconfig enp2s3 down
> # echo "+bond0" > /sys/class/net/bonding_masters
> # edho "enp1s3" > /sys/class/net/bond0/bonding/slaves
> # edho "enp2s3" > /sys/class/net/bond0/bonding/slaves
> # ifconfig bond0 up
>
> 2. server
> # ifconfig bond0 192.168.50.101
> # netserver -D -d -f
>
> 3. client
> # ifconfig bond0 192.168.50.100
> # netperf -t TCP_CRR -H 192.168.50.101 -l 3600
>
> netperf may terminated with "netperf:send_omni:recv_data failed:
> Connection reset by peer".
> the client correctly establishes connection and then send its
> data(psh+ack), but if the server process the data(psh+ack) before the
> ack, and then server side just resets connection.
>
> ---
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 8afb0950a697..630bbe78539f 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6502,8 +6502,11 @@ int tcp_rcv_state_process(struct sock *sk,
> struct sk_buff *skb)
>                  goto discard;
>
>          case TCP_LISTEN:
> -               if (th->ack)
> +               if (th->ack) {
> +                       if (th->psh)
> +                               goto discard;
>                          return 1;
> +               }


This seems to be an invalid patch.

Please tell us which RFC would mandate such a thing...

It would help if you could cook a packetdrill test demonstrating the issue.

Also make sure to cc me next time (edumazet@google.com)





