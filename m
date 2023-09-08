Return-Path: <netdev+bounces-32504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920567980C0
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 04:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191A92818F6
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 02:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A891106;
	Fri,  8 Sep 2023 02:59:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C8EDD
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 02:59:28 +0000 (UTC)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADED1BD8;
	Thu,  7 Sep 2023 19:59:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1b89b0c73d7so3011845ad.1;
        Thu, 07 Sep 2023 19:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694141967; x=1694746767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIIuQrovYE14MZMA9DrHJROcuwkTTSSF0MTAzbwwxMQ=;
        b=RNSV8RE2U3OrpWB8kI35fDi/JDGLG/2K9SQvL6qzBWvHiGryKozmaF1GomucXs2Da0
         2KOhg9oSDF8KB0VHFl6pgYABdfohXV6FA6Q7IgwuQbwjvpgFeUp2i1IUgiCZHk0gGBWR
         73mJio/1rq7yyPt7Q3zWAuKBTB82/2Di2lw+MO0Mpea/eyqSawNsic8Z45Y4yKf7899J
         GRBdj7at+hI7VtfLJfuO2Txf9Hum5dmUxsQzEIb5/yh/RadgvgXmFbQbHta4KXPP63uh
         b0yGw/eUdX22t0e04IdbBR9IJyGQTmGVbqRtBICR1+KxqVs9sAEef81q2L7RPGOqjN8H
         RP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694141967; x=1694746767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIIuQrovYE14MZMA9DrHJROcuwkTTSSF0MTAzbwwxMQ=;
        b=wDSvBO6VW17XSW6g3fb9qOPKi/Ml4GOWH/d90rCp3vBftbuOlSbWshclNzVEfwXd5h
         2ose/oAZP2xW3Jbai74TXQQEjjoOvHjnSHx1peGnua81yHpSeb4u+XW0IodLoecOBixC
         hXIvSCtHstDjjK7gFwzmSVSoVCqizl1GmMzJLinpbr0CeKLsCnowhziqHj2EhuNVPT3+
         FICnF3wXfR/rayIkPSBqVsnSbZwIXhq9Uw1MQT4wwUllys8SgSuZU2rcQstq8unK8vcE
         ASieW+c4OxHQ/iJCXN3vlIguY1635SA3jrGuvdKWsMKw8y8bA2b9P/K2ZF1haua2YEyU
         r4ug==
X-Gm-Message-State: AOJu0YwCpR5j0yjH1qZFg3hTYNkSdq3OAG9oRsEqQ46veRP0xE3Zuz1w
	mCur3xig1tY5bPAnxbo0K+M=
X-Google-Smtp-Source: AGHT+IFtDC1Jp8gX6StfUbJQiFJnDW8ht3WRhsEhN8WdX7ZAkgSoUp1PWMSH0rS5G/V1kdEbxtYroA==
X-Received: by 2002:a17:902:ecd2:b0:1bb:ac37:384b with SMTP id a18-20020a170902ecd200b001bbac37384bmr1422259plh.6.1694141967190;
        Thu, 07 Sep 2023 19:59:27 -0700 (PDT)
Received: from [127.0.0.1] ([103.152.220.17])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902e74300b001b8b4730355sm428470plf.287.2023.09.07.19.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 19:59:26 -0700 (PDT)
Message-ID: <94d077db-01e3-404e-1027-fb7532dc3c5c@gmail.com>
Date: Fri, 8 Sep 2023 10:59:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] net: ethernet: bcmasp: fix possible OOB write in
 bcmasp_netfilt_get_all_active()
To: Paolo Abeni <pabeni@redhat.com>, justin.chen@broadcom.com,
 florian.fainelli@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, mw@semihalf.com, linux@armlinux.org.uk, nbd@nbd.name,
 john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, maxime.chevallier@bootlin.com,
 nelson.chang@mediatek.com
Cc: bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20230906092107.19063-1-hbh25y@gmail.com>
 <20230906092107.19063-2-hbh25y@gmail.com>
 <7b42e1ca549f8d7d18a4df9d74a93cf527071a4d.camel@redhat.com>
Content-Language: en-US
From: Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <7b42e1ca549f8d7d18a4df9d74a93cf527071a4d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/9/2023 17:44, Paolo Abeni wrote:
> On Wed, 2023-09-06 at 17:21 +0800, Hangyu Hua wrote:
>> rule_locs is allocated in ethtool_get_rxnfc and the size is determined by
>> rule_cnt from user space. So rule_cnt needs to be check before using
>> rule_locs to avoid OOB writing or NULL pointer dereference.
>>
>> Fixes: c5d511c49587 ("net: bcmasp: Add support for wake on net filters")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   drivers/net/ethernet/broadcom/asp2/bcmasp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
>> index d63d321f3e7b..4df2ca871af8 100644
>> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
>> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
>> @@ -535,6 +535,9 @@ void bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
>>   	int j = 0, i;
>>   
>>   	for (i = 0; i < NUM_NET_FILTERS; i++) {
>> +		if (j == *rule_cnt)
>> +			break;
> 
> Side note: it's a bit unfortunate/confusing that the drivers can
> arbitrary return  -EMSGSIZE or silently truncate the list. I think it
> would be clearer if we could stick to single behavior - and I'll vote
> for -EMSGSIZE.

I see. I used break directly here beacause this function is defined as
void. But since you mentioned this I will fix this out.

Thanks,
Hangyu

> 
> Cheers,
> 
> Paolo
> 

