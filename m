Return-Path: <netdev+bounces-53516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8743D803798
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 15:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 113D5B20837
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C7428DDC;
	Mon,  4 Dec 2023 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ov+fBVkk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29215B9
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 06:52:57 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce4d4c5ea2so689119b3a.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 06:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701701576; x=1702306376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q0Inyjuwt7vULPfDbeZtTpCSklV9diwHLHBhuIy0ynU=;
        b=ov+fBVkkzFkqQvhgOI/ESaplE85UN9g7FxgueC+EX3gFq8XWMy0cWKDCcVbz0CWTLY
         e47ArnfQyuUXK30TybawYcXMLJ6PBxMv5pyfo3ENEk/W2xB12rixNZA9CEA9RYac2DPl
         6L8qhPM2VaEZOje6RxncVyMyjUPZr8YJ4SihISe1m40z8rGeUUWEq3AuwefDJBOmvM9h
         X4Ogdw5v/PmBz+qItE+NBVEMMxgptva5tUGx232XcR0cAHX75KGNb/vUjX8v/WgdYx/C
         6gdeZVcNoxVuKWyK1wMVoni1eWuGrVIbg1XJhCIoXjhKpRavMcHfSkOWC/8JTa47e6Ak
         0bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701576; x=1702306376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0Inyjuwt7vULPfDbeZtTpCSklV9diwHLHBhuIy0ynU=;
        b=numB2O1gGw5IGBeC6z8ggBV3VJ3YyR4kxI8bl7N/qpG1YZeXGD9lHcCtYX1MWb23Ow
         MmtceyXNIDKjhfzy8TYZvQebALrzRWeBvP7QhmspAIzS/ZJcHcivxMOmx0vtnKbwsxVB
         RFrDHPjx8u46kZBIu/GwELHWIWZY0hm3tpdFC5gkD+XCYjs2TzNV51/4QY1vQTSPk81d
         kX2RfE+TIEesoHSqcB4hELtrXLgupKM7S/ZVkLaOmjC1Xmu3STp6kj4kSD2MYoXjebG2
         As5VQ/Awpp6VBkFRUU3lfakAztNFHDnDaOz3ud+vPtBjkHzL0P47tOHpoefsqMJ+tNjP
         lrkA==
X-Gm-Message-State: AOJu0YzDnmEKfvSWZC2wgRt7GepQ3P2+FfvIAW85NbgiyVbar2ziK6L/
	Q7HAnCN/1yfCJpdqsw37NIP6Lg==
X-Google-Smtp-Source: AGHT+IETSM2tJ+CeQCMmRN0X7CAh6aRAzMZaxuB0JzqR7V+X9hilsZP3QdvrBBoWdcbN8fo2YD25eQ==
X-Received: by 2002:a05:6a21:33a2:b0:18b:9031:822a with SMTP id yy34-20020a056a2133a200b0018b9031822amr34255656pzb.46.1701701576571;
        Mon, 04 Dec 2023 06:52:56 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id j4-20020a056a00234400b006cdd406e784sm988049pfj.136.2023.12.04.06.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 06:52:56 -0800 (PST)
Message-ID: <a8aebcd8-4d71-49c9-853d-d17647e69308@mojatatu.com>
Date: Mon, 4 Dec 2023 11:52:52 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net/sched: act_api: conditional notification
 of events
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, marcelo.leitner@gmail.com, vladbu@nvidia.com
References: <20231201204314.220543-1-pctammela@mojatatu.com>
 <20231201204314.220543-4-pctammela@mojatatu.com>
 <20231202112104.0ca43022@kernel.org>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231202112104.0ca43022@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2023 16:21, Jakub Kicinski wrote:
> On Fri,  1 Dec 2023 17:43:13 -0300 Pedro Tammela wrote:
>> --- a/net/sched/act_api.c
>> +++ b/net/sched/act_api.c
>> @@ -1791,6 +1791,13 @@ tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
>>   	struct sk_buff *skb;
>>   	int ret;
>>   
>> +	if (!tc_should_notify(net, 0)) {
>> +		ret = tcf_idr_release_unsafe(action);
>> +		if (ret == ACT_P_DELETED)
>> +			module_put(ops->owner);
>> +		return ret;
>> +	}
> 
> I fell like we can do better than this.. let's refactor this code a bit
> harder. Maybe factor out the alloc_skb() and fill()? Then add a wrapper
> around rtnetlink_send() which does nothing if skb is NULL?

Ack


