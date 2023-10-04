Return-Path: <netdev+bounces-37988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B57B836D
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id BB92AB207D4
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D418E34;
	Wed,  4 Oct 2023 15:20:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E514261
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 15:20:50 +0000 (UTC)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30E0C1
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 08:20:48 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79faba5fe12so81998339f.3
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696432848; x=1697037648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQj5CWQkTyYkUylC1mUHiVLsmc5BWnp+qnfRCUvF8zM=;
        b=UWRHXAKQ6/lL2Bulg+os2AtcqAWQPo4+8QEpKCuIfj3/t6W2wMqYGo8MDUtJXoSDow
         RWTDGj5u30XfE4lnqspPQ7xXXLl2LEroS2jaHwzwk4Si7YDPz22Ig7mojXHVDq+wJmLi
         H56LPNFp5kAQbOozYR2keKU0msrEilsu5z7BHudI/ZFmtrEydOjoKnCO3N/I2eNyG0DD
         tL2nUl831bXiX3M6NHx6Ry1M95LsURwKVSSDRfD96OTiiub3AhRNW6kOA57MR46CLNKc
         0s68kBe3Ah0pxU5OU/pzIWCuHrlqDXOlQCplizdFk3Q1Ed3/75EX5mpynJbv6TKijhKL
         B+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432848; x=1697037648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQj5CWQkTyYkUylC1mUHiVLsmc5BWnp+qnfRCUvF8zM=;
        b=wxksyR17UfJvWLLpvi1Qv4B+TRgVpg+k8ye/3eqMZr2eFWp/YZoVfo44bllCTbeij7
         GZjn2AemLGiDU23ZBSwT2vaIx0G5E1bkQX+GW7+aAc7U8EMCfsaocZFhPQfJ7mscxCXP
         j4LARpR3S8LNKxkas1JuUhAuFhUrnOEZqoS8BTLHPviF6p7zL0a0UtHw5NZ2svd89+PY
         YYMH3tjbhcV3O4HiraRrzuwNI8CNF+Fiok/C7Id0r3RsgNZIi0VtyxKkNuK3JTN37/8Q
         Vg03lEUpJGtc5SX5QJ9TWBzDzpK9KKtjCYGjq7iLTEYYH0EQeib2cMzPIoFej+wldrrA
         SVFQ==
X-Gm-Message-State: AOJu0Yzlbcg6z+9Cs+TcIEfF4TMzH2OsCfqDHzYOwkgttFLVyNCad0zR
	BdHOdmbyKaMU2JRpV+cB7vnf0NA2H0s=
X-Google-Smtp-Source: AGHT+IFSGqKgoGgkr5EUpnYMDWIIs+XTF2EUpWpAWRGNgTc6WeHssXiq0/WXqUHDBZTBn/Lzav0AgA==
X-Received: by 2002:a6b:5b15:0:b0:786:cc36:360c with SMTP id v21-20020a6b5b15000000b00786cc36360cmr2697709ioh.8.1696432848180;
        Wed, 04 Oct 2023 08:20:48 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:ce2:4ffb:eae7:c0cc? ([2601:282:1e82:2350:ce2:4ffb:eae7:c0cc])
        by smtp.googlemail.com with ESMTPSA id f9-20020a02b789000000b004317dfe68e7sm993647jam.153.2023.10.04.08.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:20:47 -0700 (PDT)
Message-ID: <017e9228-f003-8056-d3a8-3fe1337db2f6@gmail.com>
Date: Wed, 4 Oct 2023 09:20:46 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [patch iproute2-next v2 3/5] devlink: introduce support for netns
 id for nested handle
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
 daniel.machon@microchip.com
References: <20230919115644.1157890-1-jiri@resnulli.us>
 <20230919115644.1157890-4-jiri@resnulli.us>
 <3652856a-1cda-c050-04da-fe2204949ff5@gmail.com>
 <ZQnYDVBeuIRn7uwK@nanopsycho>
 <5476af84-7f3d-2895-3be3-83b5abc38485@gmail.com>
 <ZQqfeQiz2OoVHqdS@nanopsycho> <ZRa1cu4TlCuj51gD@nanopsycho>
 <ca25c554-4fd9-5db2-655d-a30ffca11d8d@gmail.com>
 <ZRxMrelhKF9QHGrj@nanopsycho>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <ZRxMrelhKF9QHGrj@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/3/23 11:17 AM, Jiri Pirko wrote:
> Tue, Oct 03, 2023 at 06:37:31PM CEST, dsahern@gmail.com wrote:
>> On 9/29/23 5:30 AM, Jiri Pirko wrote:
>>>>> The attribute is a namespace id, and the value is a namespace id. Given
>>>>> that, the name here should be netnsid (or nsid - we did a horrible job
>>>>> with consistency across iproute2 commands). I have not followed the
>>>>> kernel patches to understand what you mean by nested devlink instance.
>>>>
>>>> Please do that. Again, the netnsid is related to the nested instance.
>>>> Therefore I put the "nested_devlink" in the name. Putting just "netnsid"
>>>> as you suggest is wrong. Another possibility would be do nest this into
>>>> object, but:
>>>> 1) I didn't find nice way to do that
>>>> 2) We would break linecards as they expose nested_devlink already
>>
>> well, that just shows I make mistakes as a reviewer. These really long
>> command lines are really taxing.
> 
> So what do you suggest?

That you learn how to make up shorter names, leveraging established
abbreviations for example. This one new parameter is 22 chars. How do
you expect these command lines and responses to fit on a reasonable
width terminal? I have been saying this now for many years about devlink
commands - excessively long attribute names combined with duplicate
terms in a command line. Not user friendly.

