Return-Path: <netdev+bounces-184070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E27A93159
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 07:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E59A19E707E
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 05:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239A3253345;
	Fri, 18 Apr 2025 05:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uu3lHf2O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7FA1DE8B0;
	Fri, 18 Apr 2025 05:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744952633; cv=none; b=E+4pEzvn5WFjBuvU1Lh1b1sOWrB70FnaEx0ACSS8jNoSYHHYozS/9lD9ayN5I5n/EIfZKLvtlFJiq+nC/KmRqUZSC3HqdWMDFBcoXEWwRWWHM26+OROsRL8dTjz4q/1VTyQ39/zRAE9yF8ItNhkyiRfLy92dnlm0dLlQhLwquvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744952633; c=relaxed/simple;
	bh=SQFUYdmJNULAJakfWcZnuYhn8q/rBq3rBLw6yHZ8kgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aasoP4p/0vvFhFYopxVBVprfvqiybqmo9sc8pxvUWnf1/U6qsluovkNfAoraExK4Cn2gWAS/4tSPlr4c+z/ZwXgc3oRZ/zTgMWwE+SsZD4sHMfUBKTO40BKXd09yJn9W2REz1K0qZTcb2slTJn1lButI7PTa5GjhVhVvXWAldXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uu3lHf2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0030C4CEE2;
	Fri, 18 Apr 2025 05:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744952632;
	bh=SQFUYdmJNULAJakfWcZnuYhn8q/rBq3rBLw6yHZ8kgE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uu3lHf2OQamWkLOyt70IuLa+RKOwjfCq9OM/t0mv1wjcXpKEjUY3WQq5O46qSK1dP
	 oCoTGkHmRAEKF+bIkKssTVC+8JgOg/xj+DmOfe+DTIi6jvCPJHwZaUzL4s7bpymaYW
	 a1uTZKYnq4Mbmthn0SJVnkwR/oTBvRrVo6RDgCtYRxX0kWeeneXRmgygL3c6148cL9
	 8tg8SZ5fS4RIduMTTxKYV4RDOy92VG73JAFJTKXv5HZYLyuWi0CP0tpDNXlG7Pc260
	 mTsVXUVlJyrCv3mg6KgzlZQ0qVQA+I1vtbE3MSCjZ1wqLGWHrB/JJsg3OUSbgefDtY
	 Xi6yJ3tfkgQqA==
Message-ID: <b137f4c6-9cbd-456d-b839-bc77d6ef9079@kernel.org>
Date: Thu, 17 Apr 2025 22:03:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipv4: Fix uninitialized pointer warning in
 fnhe_remove_oldest
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>, purvayeshi550@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <20250417094126.34352-1-purvayeshi550@gmail.com>
 <20250417220022.23265-1-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250417220022.23265-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 4:00 PM, Kuniyuki Iwashima wrote:
> From: Purva Yeshi <purvayeshi550@gmail.com>
> Date: Thu, 17 Apr 2025 15:11:26 +0530
>> Fix Smatch-detected issue:
>> net/ipv4/route.c:605 fnhe_remove_oldest() error:
>> uninitialized symbol 'oldest_p'.
>>
>> Initialize oldest_p to NULL to avoid uninitialized pointer warning in
>> fnhe_remove_oldest.
> 
> How does it remain uninitialised ?
> 
> update_or_create_fnhe() ensures the bucket is not empty before
> calling fnhe_remove_oldest().
> 

agreed. Not the simplest logic, but I do not see how oldest_p can be
unset after the loop.

