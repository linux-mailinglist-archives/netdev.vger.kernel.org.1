Return-Path: <netdev+bounces-52871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7C68007FD
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6B5282121
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4AC208CE;
	Fri,  1 Dec 2023 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="zvUEzXEN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39629A8
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 02:13:09 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so18358675e9.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 02:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1701425587; x=1702030387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YyIW3w09jbQY5twCOf2in0LfsR8rFFJTW7vEYJYxkoo=;
        b=zvUEzXENhTRygeprNWHwi1+efD+pJZxGhnMPLe2KdsIgx3PmlKQKY0I7CpwV+HndIn
         k4QKtBaC4TPj+7kbxF7TfttBnoPoYpo3ze4uArhcLJgLOZ/2ncXklG6k4pYAxObmSZRl
         mvGD2l6a1UFtPUIjGY5lgt/vP9sOETkS+Hl5wNWLi9yk3tdVeK0jaO82XQP/CKC/zvUo
         Xz9FckFOgIpJ2qy3uTZynGy8IncB/06f3b/BwdiV8OTjDTSzNKBpbeAiU6OO6UR4Njxb
         VpFtUzCZZCu2KkLg8Xhb2e1pJVfQKfe9raAx6CF3HG5Zg6hfQJfPxbaeAHprgcTHxOPs
         EzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701425587; x=1702030387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyIW3w09jbQY5twCOf2in0LfsR8rFFJTW7vEYJYxkoo=;
        b=hzZoFBlzdEPfaGzacFV7sxmOB3JfKijTwbSc0VaAEgYJNDYtDSf2tZgeZHQIIZzXcm
         bblLzsQoVZru6hGbYlPRitD9k32Gg3cK8i0mEAQCy2ifpeRZMegjoquQCW1jv9ZcGEM1
         m3lyLKBVJVzlBc5aZNOe3nNSXluec7v8sJjB1E8tlzp6hyUFYjEUBRESSDLHgaDmq2ym
         0h1lhIDz7z1QbB4iOdQcEIOcofNekfslxT8vJxTaWXt4op5ePcicisoeHhYOZNZqhtY0
         wGkZCNfUgp4M3vik0oAo+7Dj5ugi53dLIPv2DXQ07GoYFqYtGXe059r41l7S1D/8wFdy
         ohJA==
X-Gm-Message-State: AOJu0YyBP0sjRaXHzKKQC/oE2tNjrnuwKZ7G/+ujXHGsFvYQrmrG+q1f
	8mJK5X/gMBCHnxbcPAnhG1al0A==
X-Google-Smtp-Source: AGHT+IFuXoWybp6h1jNJmh8kSzY0mJbZ42gSujBt/hDf3Jc6xcHOkBIWKrIt1ErkaY6/ZT5FAsI9Mg==
X-Received: by 2002:adf:fed2:0:b0:333:2fd2:68d8 with SMTP id q18-20020adffed2000000b003332fd268d8mr559076wrs.107.1701425587759;
        Fri, 01 Dec 2023 02:13:07 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d4a4f000000b0033328f47c83sm2875402wrs.2.2023.12.01.02.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 02:13:07 -0800 (PST)
Message-ID: <eaf6960c-6169-0e47-144c-cc69479bb5f2@blackwall.org>
Date: Fri, 1 Dec 2023 12:13:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv4 net-next 02/10] net: bridge: add document for IFLA_BR
 enum
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
 Marc Muehlfeld <mmuehlfe@redhat.com>
References: <20231201081951.1623069-1-liuhangbin@gmail.com>
 <20231201081951.1623069-3-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231201081951.1623069-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 10:19, Hangbin Liu wrote:
> Add document for IFLA_BR enum so we can use it in
> Documentation/networking/bridge.rst.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   include/uapi/linux/if_link.h | 280 +++++++++++++++++++++++++++++++++++
>   1 file changed, 280 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



