Return-Path: <netdev+bounces-140646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3625D9B76AF
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EB3B23B24
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8BB15CD4A;
	Thu, 31 Oct 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="FYAs/z5n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EBCD517
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364295; cv=none; b=MZAOnm2GQsOXg3SCVbb80LPNZ3guL0hZXACCJkBvcstd8f1PE5NfBKnPJNKW3rNwCpsXCDDCq7ReU661Zoe+uUNWlw1r5g0zYruxFYWhzQWF1qZ4HUTamhWVfMGhR7i6x3BaxgP5wZYKE64Cne2Il4BKnl5QUkatmM1+3XjDpkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364295; c=relaxed/simple;
	bh=eNGZbXS5xYbci/PRfEF2hbIicvay9ljkesgFb9Zbwb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNEzdKRbwJh7P4japkPxjpAwhf2TZwmpJLUBLvUX3q7aYdbcxP5vEdfRnrTme9ZeZIuLHYoERIYqhQ0mIRNf/76Sq9EiNsDrgebwsldmnLARWCXm1I/szXcR9sguTraNMKRzlbeJ4Jw8JqxJKq8qRpnyjUuiD/mMknpxBMNep1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=FYAs/z5n; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so494416f8f.3
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 01:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730364292; x=1730969092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7XH+4h15HqpZhxc7vaK8pogYPWIYWMJq3J37NVY9vs=;
        b=FYAs/z5n/8dSXDaNMlgIhl2co9c+kWdvRv54wXOvRgyCe2gVTYMzNniZ1o+qM4FJ1w
         GL+htUUODkyJ7REwBxSemRHszO0lg3nL5XFsRXvxKWNbFt6SJG73P8eQ+nEesYYFrnwI
         t78lhPFvFxo+OpJakwDwGjV06HhVLBFsjzBHBV+y260smm5nH9/c7Kp5IRHoCFu8oTCS
         pg31k/NZ13zjabpe1w3jlA5W9BIt0fUqvtAzJVLZwO7b4U7N/2r08hLEFA4AEGOz/MbB
         +G6xx2fhnrq77I4ifzPfRYMvvo4Hnr6MGiBK+2wuVsLJgNu3RzWTt4KuPZpEVS8kpdx5
         H/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730364292; x=1730969092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7XH+4h15HqpZhxc7vaK8pogYPWIYWMJq3J37NVY9vs=;
        b=feKmge8GK6cAjcbIgj1nzc1siFUn7otLpicEjeIP2H6cNanjeaTqyS3Keq/RZ3KNCW
         OAZ13cG1MXq/4nd2ajWy3lF4V+z1aNdrASBTOpIwbZhKebtZG6F0N5wVHzhO3dMLpBjT
         DpkbSKYVEX7w//AHWDoAOKXvcnoL4KGcHFjOMfmPwzVnfJNt/HdVnHrwl2L+DlrCPuVb
         1IH5iefbEZxwaWjB04NpWd24qcCrSXs6JkckDgs6aHe6hdIOEloGcxgn5neRx7AS+4zT
         6sm9AlSRu5vpHZWOBbQiYPwwFuvVJ8CnXZG+YDHZjiFa6sW6/XEaHVQmJ5V7kpahgP8J
         eF6A==
X-Forwarded-Encrypted: i=1; AJvYcCW84eoDgADpk7ViwGX8PKC2wG5OH+/4rFi9P/0JrUx77JE5QrChJY8CxyV9k+bioO/seODSHho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqrL9nWjEHj7chLygi+azr74UsSdrYAufUXIdidviG+nTJa8yI
	h+mPMWJ7JQYHHLe1RGTlDKj03RLGgNOu4rjEvgHhrlLVOgOph0lwm/ZazIszUQL6UvhlaOT+oEd
	c
X-Google-Smtp-Source: AGHT+IGMPPAm8oKO3lf+cyTPbVkOrDb2WFhOlduZaxysibQCUGshe5RgjOS5o/oahMrPOON/kVx0eA==
X-Received: by 2002:a05:6000:18a7:b0:37d:45ab:422b with SMTP id ffacd0b85a97d-381b708b694mr5397349f8f.31.1730364290179;
        Thu, 31 Oct 2024 01:44:50 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e6b5sm1432467f8f.88.2024.10.31.01.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 01:44:49 -0700 (PDT)
Message-ID: <8c8a53ee-ce3b-4337-973a-9450cd4a1363@blackwall.org>
Date: Thu, 31 Oct 2024 10:44:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute] bridge: dump mcast querier state
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, entwicklung@pengutronix.de
References: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
 <f4efc424-6505-4e20-a9f2-14e973281921@blackwall.org>
 <58d40a6c-7c42-4a46-8c9a-0da4a0c77380@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <58d40a6c-7c42-4a46-8c9a-0da4a0c77380@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/10/2024 00:10, Fabian Pfitzner wrote:
>> For the second time(!), please CC maintainers because it's very easy to
>> miss a patch. In addition to maintainers, please CC reviewers of previous
>> versions as well.
> Could you please tell me at which mail addresses I should send the patch?
> You said that I should send it to "the bridge maintainers" as well, so I put "bridge@lists.linux-foundation.org" into the CC this time.
> 

from iproute2/MAINTAINERS file:
 Ethernet Bridging - bridge
 M: Roopa Prabhu <roopa@nvidia.com>
 M: Nikolay Aleksandrov <razor@blackwall.org>
 L: bridge@lists.linux-foundation.org (moderated for non-subscribers)
 F: bridge/*

Unrelated - I just noticed we have to add a few more F: lines there, I'll send a patch.

In addition to maintainers, please always add reviewers of previous patch versions.

Cheers,
 Nik

> On 10/30/24 4:29 PM, Nikolay Aleksandrov wrote:
>> On 30/10/2024 10:46, Fabian Pfitzner wrote:
>>> Kernel support for dumping the multicast querier state was added in this
>>> commit [1]. As some people might be interested to get this information
>>> from userspace, this commit implements the necessary changes to show it
>>> via
>>>
>>> ip -d link show [dev]
>>>
>>> The querier state shows the following information for IPv4 and IPv6
>>> respectively:
>>>
>>> 1) The ip address of the current querier in the network. This could be
>>>     ourselves or an external querier.
>>> 2) The port on which the querier was seen
>>> 3) Querier timeout in seconds
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
>>>
>>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>>> ---
>>>
>>> v1->v2: refactor code
>>>
>>>   ip/iplink_bridge.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 47 insertions(+)
>>>
>> For the second time(!), please CC maintainers because it's very easy to
>> miss a patch. In addition to maintainers, please CC reviewers of previous
>> versions as well.
>>
>> Thank you,
>>   Nik
>>
>>
>>


