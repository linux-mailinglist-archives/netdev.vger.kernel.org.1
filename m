Return-Path: <netdev+bounces-52870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B97B8007FA
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D5E281EC6
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B194A208BB;
	Fri,  1 Dec 2023 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="BQlNUb26"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DEA84
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 02:12:29 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b4734b975so19927905e9.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 02:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1701425548; x=1702030348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7QCxPC+fYseWuexTotpYyV8w/1vbCfusdIIG1y6MSo=;
        b=BQlNUb264snWlw0B00LGXp5/042MwtsgtDbH+CeSH3REN7+E74AOMvAfJPoR3n1WDk
         v3iurBDviPU3WXMLUpQWHopO1kXFG55fWKTwGVFaJvxWBdTiGayaXpeVGXX+Smyq+5Eq
         mlkBJ9UciAWg2KYOkgSK+PHg5BzySTSzyfmfAhc1kT8H316q8XJxRUkFFZf5MiC0WbAw
         YFzOndpsKuYk9eToMohENbCoAl1W2s9NHDgMyoD8DT3GGH489My13WvToPVrWPwv/H/o
         zr4DuZWjvnJh7xW0RL3maiCK+R5wF6vB4wNx6YyTjrM1Getyn8wYUUC1MUcw3eQBAsTN
         GDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701425548; x=1702030348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7QCxPC+fYseWuexTotpYyV8w/1vbCfusdIIG1y6MSo=;
        b=cLYZbO/ibFEjOyzVYZp3YGC3TVnoh9KG5zluN+jMK1fIkeULVqprCtXZoJzLHnyvNu
         EmCrYaAvXK5HUpNEl5o5N9r0O96xyFWNBw6YSvqnLiMwVFr0IpLIFaF0PsI+YkBsB8m/
         AhjyisAQ410EDzxaa5NsUWHiALnTgk8HG8DB9KhIoQ6ef39Vcz0/HcYywjdGaFLRpJfP
         ylS+B3AESMFW4Wp4c8ZZXc7kZna8m18X4tkDbNMNTObcMqtGlIcd0NvprKc51+5U09Xp
         sG+vrxWNRjyPSvnykpzB1lZmvMNZSBxQoHnN4qarjPHi3eWcbdX0wF4dLaeL5R9Ix5NG
         U1iA==
X-Gm-Message-State: AOJu0YxvQcYYZ4wfCzjYSEZV4pHl/mPrXgWALRhyYUeqmfd37tcLOSPZ
	/2AAp4g7lIDMj8y4mne4v73BDw==
X-Google-Smtp-Source: AGHT+IFlCTKbYaADO7WKCziLqzHiA3ywHgZrnBRkgn1TMHHoy3VUQ4ul50xqVpORNEuysX9wk+QVFA==
X-Received: by 2002:a5d:4fd0:0:b0:333:2fd2:5d43 with SMTP id h16-20020a5d4fd0000000b003332fd25d43mr539920wrw.117.1701425547781;
        Fri, 01 Dec 2023 02:12:27 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id r13-20020adff70d000000b0033334c3acb6sm27153wrp.98.2023.12.01.02.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 02:12:27 -0800 (PST)
Message-ID: <c3f15499-931a-86d0-11aa-4b77f0a86ec6@blackwall.org>
Date: Fri, 1 Dec 2023 12:12:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv4 net-next 01/10] docs: bridge: update doc format to rst
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
 <20231201081951.1623069-2-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231201081951.1623069-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 10:19, Hangbin Liu wrote:
> The current bridge kernel doc is too old. It only pointed to the
> linuxfoundation wiki page which lacks of the new features.
> 
> Here let's start the new bridge document and put all the bridge info
> so new developers and users could catch up the last bridge status soon.
> 
> In this patch, Convert the doc to rst format. Add bridge brief introduction,
> FAQ and contact info.
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 47 +++++++++++++++++++++++------
>   1 file changed, 37 insertions(+), 10 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


