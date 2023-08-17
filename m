Return-Path: <netdev+bounces-28311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F29477EF89
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 05:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425A1281D7B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471D5639;
	Thu, 17 Aug 2023 03:31:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC7638
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:31:28 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410FE2686;
	Wed, 16 Aug 2023 20:31:27 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VpyH6Nq_1692243083;
Received: from 30.221.109.120(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VpyH6Nq_1692243083)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 11:31:24 +0800
Message-ID: <e6847761-af77-6673-9e06-cc08eb4ba483@linux.alibaba.com>
Date: Thu, 17 Aug 2023 11:31:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 3/6] net/smc: support smc v2.x features validate
Content-Language: en-US
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, kgraul@linux.ibm.com, tonylu@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
 <20230816083328.95746-4-guangguan.wang@linux.alibaba.com>
 <5421115a-a8d0-0eae-78b1-a2c5977e2ba1@linux.dev>
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <5421115a-a8d0-0eae-78b1-a2c5977e2ba1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/16 20:49, Vadim Fedorenko wrote:
> On 16/08/2023 09:33, Guangguan Wang wrote:

>> +
>> +int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
>> +                      struct smc_init_info *ini)
>> +{
>> +    if (ini->release_nr < SMC_RELEASE_1)
>> +        return 0;
>> +
>> +    return 0;
>> +}
> 
> This function always returns 0. Is it really what expected?
> 

This patch is a frame code of v2x features validate.
Please read the next 2 patches, where will fill more code logic in this function.


[PATCH net-next 4/6] net/smc: support max connections per lgr negotiation
 int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
 				      struct smc_init_info *ini)
 {
+	struct smc_clc_first_contact_ext_v2x *fce_v2x =
+		(struct smc_clc_first_contact_ext_v2x *)fce;
+
 	if (ini->release_nr < SMC_RELEASE_1)
 		return 0;
 
+	if (!ini->is_smcd) {
+		if (fce_v2x->max_conns < SMC_CONN_PER_LGR_MIN)
+			return SMC_CLC_DECL_MAXCONNERR;
+		ini->max_conns = fce_v2x->max_conns;
+	}
+
 	return 0;
 }


[PATCH net-next 5/6] net/smc: support max links per lgr negotiation in clc handshake
@@ -1208,6 +1216,11 @@ int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
 		if (fce_v2x->max_conns < SMC_CONN_PER_LGR_MIN)
 			return SMC_CLC_DECL_MAXCONNERR;
 		ini->max_conns = fce_v2x->max_conns;
+
+		if (fce_v2x->max_links > SMC_LINKS_ADD_LNK_MAX ||
+		    fce_v2x->max_links < SMC_LINKS_ADD_LNK_MIN)
+			return SMC_CLC_DECL_MAXLINKERR;
+		ini->max_links = fce_v2x->max_links;
 	}
 
 	return 0;


Thanks,
Guangguan Wang

