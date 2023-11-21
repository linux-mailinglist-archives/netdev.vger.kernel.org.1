Return-Path: <netdev+bounces-49547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABEF7F2590
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 06:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF521C210E0
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 05:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7271A59C;
	Tue, 21 Nov 2023 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LrYQybni"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A02DE8
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 21:57:58 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5094727fa67so7224972e87.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 21:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700546276; x=1701151076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qlehtsZYfebpFdFAY73VV/paYzz6daNRXMckCDPI1Q=;
        b=LrYQybniTuoVmqlTcvQlF8ANVs8Z93Othbttao1VuFiDH9g9QIJKbgWhIocFpSJPKQ
         KwpCArSFOhUgMcH183gaGFvMJyuvWE4d7bdsSRzYLAE3xr9iwqlnZQgcC8gLcVBG93Ep
         4theNBc1PrNIlEwT6S9DVK2GDt+oLAZ46a6a8w6dMPXW+oht8VANVQQnDe0HmA4lkYWz
         wOl2GwBDFErY7ODKFQyum6D91KT9Y6gtyum7UUEo/l5/lehm+M3sKl/kmEFTslX/xYko
         aG6CRsj7WlcFvK+So6p/wwie79JmpS6TPN9UcPPv17T9NEYhhWfHolRgtkGVDIVtGjjY
         qkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700546276; x=1701151076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qlehtsZYfebpFdFAY73VV/paYzz6daNRXMckCDPI1Q=;
        b=G6FwRTz11AVBImk6uEJIy7fbOpFoGjr7SqWcNv8iffRDxyuADjSDnsAXO7HYlT6MZ2
         TYNg86fEkXEwNWiENHE/4QV3PGOaIsXVIr4VVAzQa+QS9oKSjgvAsYcp/xIPOCYT/7al
         rXGuOvCy1k+SCYRfqKRgpfpEwmOGcernvaguJGDAeN6fBdbYord3/HaMmmN/nJhp+1l5
         1/3oucuZ1aZ3cbWeXLqCB5gatWbSBuGQ1L/cOD3atbh3L7JJv8YhjbsqEL7TvIcNNvoD
         OjJCB1NXOjjZTIa/IOPGataW54SDZUDepInHKwaYqk31/pjss1SfN6M4F8yxrvENM46+
         YYRA==
X-Gm-Message-State: AOJu0YwvkENUundbBssNNpQemlJGIyWcBOQEK7ilihTpybqtJb2e9vMu
	/60hYAgAevhzyC8WLsWe/UEtiQ==
X-Google-Smtp-Source: AGHT+IEYL7tOmd1RZpAcsqf+lMzTOJfDHXI7QPhJmLWCzGt6NCj2voH5dnbxu1YvRCITJXwXNJuZCQ==
X-Received: by 2002:ac2:5191:0:b0:50a:7868:d3c0 with SMTP id u17-20020ac25191000000b0050a7868d3c0mr5423864lfi.23.1700546276378;
        Mon, 20 Nov 2023 21:57:56 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.3])
        by smtp.gmail.com with ESMTPSA id s21-20020aa7d795000000b00548679e4884sm3504193edq.46.2023.11.20.21.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 21:57:56 -0800 (PST)
Message-ID: <33a44057-eefa-44ba-8e06-b6eb8bd79e59@tuxon.dev>
Date: Tue, 21 Nov 2023 07:57:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] net: ravb: Use pm_runtime_resume_and_get()
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
 geert+renesas@glider.be, wsa+renesas@sang-engineering.com,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 sergei.shtylyov@cogentembedded.com, mitsuhiro.kimura.kc@renesas.com,
 masaru.nagai.vx@renesas.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120084606.4083194-3-claudiu.beznea.uj@bp.renesas.com>
 <a465e1fb-6ef8-0e10-1dc9-c6a17b955d11@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <a465e1fb-6ef8-0e10-1dc9-c6a17b955d11@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20.11.2023 21:23, Sergey Shtylyov wrote:
> On 11/20/23 11:45 AM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> pm_runtime_get_sync() may return with error. In case it returns with error
>> dev->power.usage_count needs to be decremented. pm_runtime_resume_and_get()
>> takes care of this. Thus use it.
>>
>> Along with this pm_runtime_resume_and_get() and reset_control_deassert()
>> were moved before alloc_etherdev_mqs() to simplify the error path.
> 
>    I don't see how it simplifies the error path...

By not changing it... Actually, I took the other approach: you suggested in
patch 1 to re-arrange the error path, I did it the other way around:
changed the initialization path...

>    Re-ordering the statements at the end of the error path seems cheaper than
> what you do.
> 
>> Also, in case pm_runtime_resume_and_get() returns error the reset signal
>> is deasserted and runtime PM is disabled (by jumping to the proper
>> error handling label).
>>
>> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [...]
> 
> MBR, Sergey

