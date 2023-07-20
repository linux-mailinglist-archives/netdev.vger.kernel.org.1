Return-Path: <netdev+bounces-19459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CC675AC3B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9478281DAF
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E2C171CC;
	Thu, 20 Jul 2023 10:44:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964EB19A0B
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 10:44:08 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B830171B
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 03:44:07 -0700 (PDT)
Received: from [192.168.1.35] (193-80-203-62.hdsl.highway.telekom.at [193.80.203.62])
	by mail.svario.it (Postfix) with ESMTPSA id 1403CD90CA;
	Thu, 20 Jul 2023 12:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689849843; bh=sgBAnX/bnW0smJ7IipIBHWNQ6NUGnkY1NoJygIKps5Y=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
	b=w7l5LpPdsiWHPKKP3Ko2iXD88OG/ngfQOn4YRARx86/pQlBza4sThI/K8WRTdrXIz
	 Qu+akTowh4NcAAmvM3lHxKxanFuyfFWjqRWRYNPXWR7DpVGmj0AAgNXqgljvbtl7B8
	 XJN4fLQW42OJoNOBHHu2smsfdNvUOwwTgscGBSZUYow7Xm4lFOvm5KnLStZ/yoRMYk
	 P0D6FYxwtya7LxxBeJlLRZknnP7qtKNY5PaqwBHTrukMPmTXsDH6qU+pjYs9Z7+C9W
	 nm7PI452Y5I2Gh7MnJil7e3DsgPb2DawJ/VVnCagfnvrDKdm2yt+yM4NtHGq0dXpB3
	 2t/0BsGb9osPQ==
Message-ID: <88ab68eb-2ddd-50a7-a9ea-c3e213406373@svario.it>
Date: Thu, 20 Jul 2023 12:44:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
References: <20230719185106.17614-1-gioele@svario.it>
 <20230719185106.17614-5-gioele@svario.it> <878rba98fl.fsf@nvidia.com>
Content-Language: en-US
From: Gioele Barabucci <gioele@svario.it>
Subject: Re: [iproute2 04/22] tc/tc_util: Read class names from provided path,
 /etc/, /usr
In-Reply-To: <878rba98fl.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/07/23 12:10, Petr Machata wrote:
>> diff --git a/tc/tc_util.c b/tc/tc_util.c
>> index ed9efa70..e6235291 100644
>> --- a/tc/tc_util.c
>> +++ b/tc/tc_util.c
>> @@ -28,7 +28,8 @@
>>   
>>   static struct db_names *cls_names;
>>   
>> -#define NAMES_DB "/etc/iproute2/tc_cls"
>> +#define NAMES_DB_USR "/usr/lib/iproute2/tc_cls"
>> +#define NAMES_DB_ETC "/etc/iproute2/tc_cls"
> 
> Is there a reason that these don't use CONF_USR_DIR and CONF_ETC_DIR?
> I thought maybe the caller uses those and this is just a hardcoded
> fallback, but that's not the case.

Thanks for the review Petr.

The reason why I did not use CONF_USR_DIR in these patches is because I 
wanted to minimize the number and amount of changes. But I asked myself 
the same question when I first looked at this and other similar occurrences.

Let me know if I should update the patches to use CONF_{USR,ETC}_DIR.

Regards,

-- 
Gioele Barabucci

