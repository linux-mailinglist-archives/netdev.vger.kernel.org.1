Return-Path: <netdev+bounces-37746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFE77B6EB1
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9E213281267
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F12F30D1B;
	Tue,  3 Oct 2023 16:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EAD273F6
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:37:35 +0000 (UTC)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD6A1
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:37:34 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79fa387fb96so40796239f.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696351054; x=1696955854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMZWikDs/QhiqJTcYsectNDS57PoDzv0VSJnTx//otQ=;
        b=QPTvWwT2ckDQepBZHwbKO/DSULVqZajQOrBOokWWGW/BHzYS55GNGbPA3jjTmw79iE
         AqGKHG0Lhx+Yr59HaoMbbVEbOguvmqXoyQuxfwrElBMT05lWfcUayqlTgvehfPbd8C45
         8FTLaTDJ7zeaAS/oJQqvBz6X56WncHhDlPDRc9bMfBuaCRmBBnK1Hk1D7qGs/7brf4sY
         KSGr5YeMUHynYHR2XuQ/ToZZmrE8C6xyTXeKOx3lT/vbZjjASTJ2RXqHVvnm3H626zV3
         ODXCh3aqblK0IHk8EwNyrTykfbOXV00rq3xrnwb8xKP8/k4tGRQ4BXf1tSrDb/omhlce
         aqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696351054; x=1696955854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMZWikDs/QhiqJTcYsectNDS57PoDzv0VSJnTx//otQ=;
        b=OeNhiUTzaknCOBTbaOsyH0ARcWqPtUt1SE/+eNA1OSbuJ5hUZSLNjYKD6sCpsgux8P
         ieOnyvUXCRKeenE1EZ68ZMt+GMpbh8OrCUgkzd1X5tSBNxYa7g92JH3wkeIoHMsjG89n
         B3mM7NxW2jnLnpqMcUfbgzMoyOcyhoeOpIAA/KRPHKp2FHJtimCIL5+sH2wN2t1F0+/m
         45H36zOXAdOFtH4TqPgmkd7JkT9w4g5oNpoUApeUm988dm6tM6OefJZ0Sc8/ZxhYWXGe
         WKTRUX9+KGhowffxgIPZtGFIBC/1/yhZ8ALEcBSE+qXCPsBaixdQ6o0oFmwfqZDf0Z9b
         hWgg==
X-Gm-Message-State: AOJu0Yy4Tdu2NipxADN7hJw11M4zpufs/3VkxaYZ+EitVptRatTtXASm
	ZU/AJ0xGEiNBBLjWv3KdShc6eGA2+lY=
X-Google-Smtp-Source: AGHT+IFBs1F0AbqPF5kVOFv6qmV1+VRkb0m9Lgph5Hu0TKRBTfqjD4g9h3ZOVO371DpqRjTc6u0A1w==
X-Received: by 2002:a5e:c019:0:b0:79f:9edb:6e2d with SMTP id u25-20020a5ec019000000b0079f9edb6e2dmr16294144iol.18.1696351053757;
        Tue, 03 Oct 2023 09:37:33 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:ce2:4ffb:eae7:c0cc? ([2601:282:1e82:2350:ce2:4ffb:eae7:c0cc])
        by smtp.googlemail.com with ESMTPSA id fq22-20020a056638651600b0041e328a2084sm427432jab.79.2023.10.03.09.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 09:37:33 -0700 (PDT)
Message-ID: <ca25c554-4fd9-5db2-655d-a30ffca11d8d@gmail.com>
Date: Tue, 3 Oct 2023 10:37:31 -0600
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
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <ZRa1cu4TlCuj51gD@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/29/23 5:30 AM, Jiri Pirko wrote:
>>> The attribute is a namespace id, and the value is a namespace id. Given
>>> that, the name here should be netnsid (or nsid - we did a horrible job
>>> with consistency across iproute2 commands). I have not followed the
>>> kernel patches to understand what you mean by nested devlink instance.
>>
>> Please do that. Again, the netnsid is related to the nested instance.
>> Therefore I put the "nested_devlink" in the name. Putting just "netnsid"
>> as you suggest is wrong. Another possibility would be do nest this into
>> object, but:
>> 1) I didn't find nice way to do that
>> 2) We would break linecards as they expose nested_devlink already

well, that just shows I make mistakes as a reviewer. These really long
command lines are really taxing.

