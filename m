Return-Path: <netdev+bounces-26808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9D7790AF
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B24F1C20A3A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 13:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8432320FB3;
	Fri, 11 Aug 2023 13:23:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D3063B3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 13:23:19 +0000 (UTC)
Received: from out-114.mta1.migadu.com (out-114.mta1.migadu.com [IPv6:2001:41d0:203:375::72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB44125
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:23:17 -0700 (PDT)
Message-ID: <271b76c6-a52a-0c8b-5560-8a72c4340faf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691760195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkZWE4XFj7n8PtSuWO95wRoJ9c9BRctbYRXHgzE+874=;
	b=q9k1tHJR1cMhrkd4lyzS4+BSxbHSM490dxoSUrrR8QHrxenoc5OqPCuV0LHLB4XLaiM0Dw
	N8ObBd2AOuHAaL+3bIkd10FDI6YsmHru3PRZOeZh6EbkHFkL+Pd8RPXucsT1d+yT5pTWU/
	n+upeYSRMSeTp3dB4DCewzo6X1LIJiE=
Date: Fri, 11 Aug 2023 14:23:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 6/9] ice: add admin commands to access cgu
 configuration
Content-Language: en-US
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, "Olech, Milena" <milena.olech@intel.com>,
 "Michalik, Michal" <michal.michalik@intel.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>,
 mschmidt <mschmidt@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Bart Van Assche <bvanassche@acm.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20230809214027.556192-1-vadim.fedorenko@linux.dev>
 <20230809214027.556192-7-vadim.fedorenko@linux.dev>
 <20230810192102.2932d58f@kernel.org>
 <8d52ab61-e532-0ef8-4227-ea1ab469f4cb@linux.dev>
 <DM6PR11MB46578D7F73BDA4D6EE7E0E239B10A@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <DM6PR11MB46578D7F73BDA4D6EE7E0E239B10A@DM6PR11MB4657.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/08/2023 13:16, Kubalewski, Arkadiusz wrote:
>> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> Sent: Friday, August 11, 2023 11:31 AM
>>
>> On 11/08/2023 03:21, Jakub Kicinski wrote:
>>> On Wed,  9 Aug 2023 22:40:24 +0100 Vadim Fedorenko wrote:
>>>> From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>
>>>> Add firmware admin command to access clock generation unit
>>>> configuration, it is required to enable Extended PTP and SyncE features
>>>> in the driver.
>>>> Add definitions of possible hardware variations of input and output pins
>>>> related to clock generation unit and functions to access the data.
>>>
>>> Doesn't build, but hold off a little with reposting, please hopefully
>>> I'll have more time tomorrow to review.
>>
>> Yeah, we've found the issue already and Arkadiusz has prepared a patch
>> to fix it. I can do the repost once you are ok to review.
> 
> Thanks Vadim,
> 
> Just realized you have already replied on this..
> Ok, so I guess v4 after all.
> 
> Thank you!
> Arkadiusz


Yeah, it will be v4 anyway

