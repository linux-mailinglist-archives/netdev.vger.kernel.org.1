Return-Path: <netdev+bounces-34223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C55597A2E2A
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 08:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8C71C209A2
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 06:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357BA6AAE;
	Sat, 16 Sep 2023 06:17:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC933DC;
	Sat, 16 Sep 2023 06:17:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9ABCC0;
	Fri, 15 Sep 2023 23:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694845046; x=1726381046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dpw80PtFYNDVGjI+iulRnzMBDHhLG8ZhcBIQvgHxF4s=;
  b=Wngwpc/9UFg3VxmQUA2UopDoOpA101MO/XPtYsa8oPSsgOSzrcqCZd9P
   PcKp2Jw0D2+jcgpfDLEAYaCqOGXbySWIWslZ/S8uLTajWSBohiPzhu+U7
   lTGE+tUSBxR40zDq/AjINTpzMMLuDG+8MU3FNaZodprMtLinihLkezGxg
   LsRXK/1eh2LhSu1JgGXnJo4C5GYJ4F9zXzY9bFdXXT1UVaPg/vJ+eUBJ0
   coyxRrNiyr/2akBcFJxj8iydEdONanUIwCOCQazk755APtciBxqp/G48Y
   K8xvDI1YbDj9muEgQYMlPorfYna2Nw2tnjcQHTrqtYiANufxe8whWwIdg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="443461809"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="443461809"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 23:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="738564989"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="738564989"
Received: from pglc00032.png.intel.com ([10.221.207.52])
  by orsmga007.jf.intel.com with ESMTP; 15 Sep 2023 23:17:21 -0700
From: rohan.g.thomas@intel.com
To: robh@kernel.org
Cc: alexandre.torgue@foss.st.com,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	fancer.lancer@gmail.com,
	joabreu@synopsys.com,
	krzysztof.kozlowski+dt@linaro.org,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	peppe.cavallaro@st.com,
	rohan.g.thomas@intel.com
Subject: Re: [linux-drivers-review] [PATCH net-next v2 1/3] net: stmmac: xgmac: EST interrupts handling
Date: Sat, 16 Sep 2023 14:17:18 +0800
Message-Id: <20230916061718.336-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915154258.GA3769303-robh@kernel.org>
References: <20230915154258.GA3769303-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rohan G Thomas <rohan.g.thomas@intel.com>

Thanks for the review comments.
Will address this in the next version.

On Fri, Sep 15, 2023 at 05:54:16PM +0800, Rohan G Thomas wrote:
>> Add dt-bindings for coe-unsupported property per tx queue.
>
>Why? (What every commit msg should answer)
>
>> 
>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
>> ---
>>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> index ddf9522a5dc2..365e6cb73484 100644
>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> @@ -394,6 +394,9 @@ properties:
>>                When a PFC frame is received with priorities matching the bitmask,
>>                the queue is blocked from transmitting for the pause time specified
>>                in the PFC frame.
>
>blank line needed
>
>> +          snps,coe-unsupported:
>> +            type: boolean
>> +            description: TX checksum offload is unsupported by the TX queue.
>
>And here.
>
>>          allOf:
>>            - if:
>>                required:
>> -- 
>> 2.25.1
>> 

