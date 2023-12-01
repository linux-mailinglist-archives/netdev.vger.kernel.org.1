Return-Path: <netdev+bounces-52874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0021D800804
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA2828252E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA82208C3;
	Fri,  1 Dec 2023 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0idJG4+r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6C184
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 02:14:09 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b27b498c3so20142595e9.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 02:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1701425648; x=1702030448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ln0aDIJxgZzxRMP93FyjuordX8tym8xPIeENLSVLO/o=;
        b=0idJG4+r4JgmuViOfVZqMz4IxyszcZPuLq2+PSEhs1kbYndPLUewTRPJxzYz4AHCYn
         lDlccKLTJISikMUfhqGM2kC2vtho69QLftKoT9xUJc1s6Z+nGS2UIUJE4GomT7r6KGy0
         uXfHeUqhN93dhf6DqnNiW92LBKykPNDzh1/JEZHgJ6OsIliTAtv7H8zgobjQjKc6t2kB
         3FZwGuhE7EJhoTCpneR61xZ/06CspwiXccahPe4VAktrONZkTZTKNKtsXuQMeVTPPeP/
         pBtNpFrKuI/hdRNlK4lbcG+s6HHGlXZUkCUVBJekfv7ao6ZflpUq0VuCFWETM+OUYSYi
         1OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701425648; x=1702030448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln0aDIJxgZzxRMP93FyjuordX8tym8xPIeENLSVLO/o=;
        b=ps2npSRrQw071UOl6p5o/RqNtNq5qdh1itBbaL6BnpNDVGa6Noc3RnwvY/h57KSFzX
         H2CAGglTAuXQV7Y4/VjQmVSG6J834uRx+XlU5RLNeE+wOW+MmHn2UrwmFGtxCdj1P1v3
         yTjQvXO1A2R+aL6CPM3KLdyVRLnW8NbP9NopAWT0aEqkOe+MQinMAjLh4nvOuhwVKcvE
         wIAzMbbGSJkk0dCHPlvpMb5wCKv66LmQFkMJXQeNOSUVpI17Dr7vvdd7AMhvq6ondaQJ
         EmzoYle6oudzj14Obhe9dTpyZmYgtgLWPjBPuRtRr4diS5PotWzk342f8+DzVTJZltMV
         MEYQ==
X-Gm-Message-State: AOJu0YyIbJ2/qEB4XVK2LDgdGwqHcvH+l0k6GBwsSDrRf9PjtVB8zqpj
	ReKAkkZDMbo+GVnmGRT3gOrThg==
X-Google-Smtp-Source: AGHT+IE8sxSnI1Z/hdWVGKuAH2q7abGD3TgYu/mfcbVFh5o5CoCDA1XtWH+nasrazewAGtNfHFdkFw==
X-Received: by 2002:a05:600c:3553:b0:402:ea96:c09a with SMTP id i19-20020a05600c355300b00402ea96c09amr349881wmq.16.1701425648421;
        Fri, 01 Dec 2023 02:14:08 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id y17-20020a05600c20d100b00405c33a9a12sm2117555wmm.0.2023.12.01.02.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 02:14:08 -0800 (PST)
Message-ID: <066d055d-0f3c-56d0-6dfe-5097df454381@blackwall.org>
Date: Fri, 1 Dec 2023 12:14:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv4 net-next 04/10] docs: bridge: Add kAPI/uAPI fields
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marc Muehlfeld <mmuehlfe@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
References: <20231201081951.1623069-1-liuhangbin@gmail.com>
 <20231201081951.1623069-5-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231201081951.1623069-5-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 10:19, Hangbin Liu wrote:
> Add kAPI/uAPI field for bridge doc. Update struct net_bridge_vlan
> comments to fix doc build warning.
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 33 +++++++++++++++++++++++++++++
>   net/bridge/br_private.h             |  2 ++
>   2 files changed, 35 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



