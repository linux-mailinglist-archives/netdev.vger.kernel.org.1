Return-Path: <netdev+bounces-152262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 587289F342B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E9B1881274
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2B913CA8A;
	Mon, 16 Dec 2024 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="cBfKT1fg"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615CD13777E
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362077; cv=none; b=JbQV+IP2vY/CR9IPtwGulhMrdhskiKpIbEaikVtjuzB3p9lD5Iay0kibo5SeZZLVfSIeUwhW8vwvyQXC2b2LbN+ZUpnzdiZxcL3VT7XCeFuSX1PbZMr91mTm3lxiVx5jtH3Uu10uiVqpZnu5a3lFJT9YCpZM6atund9opbPkxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362077; c=relaxed/simple;
	bh=+VkAIOdcmR4wgVWkkqpzUtcUv3Hj4sxLLEDKxTVVvhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1arIbuKvSxJUmK2hqtJ0caRYCTFD+bfS5kMZE2gEcdedSLNy6WVjZcH3FY345dRh85vvZqxA43ESWbUQHCcF8mlte7KOky68psrIC+QeywybTwj0b6lCtPd6PjWfFekaUmkEyAtil4YyhmIUwXiAiH6mDptJYbbr9JbeDa0UCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=cBfKT1fg; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tNCnl-00GC9a-Iz; Mon, 16 Dec 2024 16:14:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=EgD51ABTIV57+0VbUiNGN4UzuXE/+vec3SMwLtrK3Ys=; b=cBfKT1fgmZk7uU8A5IBpGjSMei
	g1MZW5Z/aBqhEkkt0NDjQtMADwTRbZKZqxvrMCCRMFdd53XTcVet7mVNJb3xNNLHcmZE7038C5Z6w
	5yF5oL5xxbdZpIT70W2zDjG2lbCSwg4b8brCuMhQgBQg0WvOnslK+dvf1vyBot5K3cC7PgwClb9Us
	UOzfHwryRDkLQXn1ddJQmTNDTnhQdXWoAlx090LBeKpqgs3CS5BG2pp3avvGmu4UnBPxXAkhNFZXp
	aNzES5OOc3dCjxRpaxt8W6f8P7gaRSUgRXYZwJcRp3t8kLzOA+2htTwHzS/CMO/8oiu+yvqZ/q+hH
	PcQq2w7Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tNCnl-0001ZA-1O; Mon, 16 Dec 2024 16:14:29 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tNCnf-00CxgX-KT; Mon, 16 Dec 2024 16:14:23 +0100
Message-ID: <12fd9c75-8a93-4ce5-949c-2ff2c7c727d6@rbox.co>
Date: Mon, 16 Dec 2024 16:14:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/6] vsock/test: Introduce option to run a
 single test
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
 <20241216-test-vsock-leaks-v2-2-55e1405742fc@rbox.co>
 <ybwa5wswrwbfmqyttvqljxelmczko5ds2ln5lvyv2z5rcf75us@22lzbskdiv3d>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <ybwa5wswrwbfmqyttvqljxelmczko5ds2ln5lvyv2z5rcf75us@22lzbskdiv3d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/24 15:32, Stefano Garzarella wrote:
> On Mon, Dec 16, 2024 at 01:00:58PM +0100, Michal Luczaj wrote:
>> Allow for singling out a specific test ID to be executed.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> [...]
>> +		case 't':
>> +			pick_test(test_cases, ARRAY_SIZE(test_cases) - 1,
>> +				  optarg);
>> +			break;
> 
> Cool, thanks for adding it!
> Currently, if we use multiple times `--test X`, only the last one is 
> executed.
> 
> If we want that behaviour, we should document in the help, or just error 
> on second time.
> 
> But it would be cool to support multiple --test, so maybe we could do 
> the following:
> - the first time we call pick_test, set skip to true in all tests
> - from that point on go, set skip to false for each specified test
> 
> I mean this patch applied on top of your patch (feel free to change it, 
> it's just an example to explain better the idea) [...]

Sure, make sense. One question, though: do you want to stick with the verb
--test? Or should it be something more descriptive, e.g. --select, --pick,
--choose?


