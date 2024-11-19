Return-Path: <netdev+bounces-146298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE99D2B0F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 17:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4AF281949
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 16:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9B21D0B9B;
	Tue, 19 Nov 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0y5cUvu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1B1CEAAA
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034175; cv=none; b=q2PxxR9Sb1PmHdvlWyVV0l+I6eLfwIAf4tRaKpCx3pG1rfvzTz8/Rft4tpQmPS0zVVbH3qT/n3/PSazx4Z8unsn7UUq2l+MYByI2YQYrE+r0Fzd+FOP/ynqF4VOpOp+dJHhQm2bZ7Zbn1iSWLCx/SdxLch2VY14KTrUeg+x5AfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034175; c=relaxed/simple;
	bh=xQ1t7fesoYZ8wV4g7LdmSKAMQbj6ENkUoUq1HdtxS8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWxkJVNvK/5Z9pwabqufeXox9Dc+oHYer5iJexvb7JdwMiEun8+Fc3VbOPHLGjzAX2uM9di6TPfWzVKm/Hh1Av5kDxupCbiEwgnMNDvM45tjjseci53QxPkpYjUSzZTMFUOu+0ltMbuwgiryLhLjALoFOs3s7+xKyrg5NenETKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0y5cUvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7683CC4CECF;
	Tue, 19 Nov 2024 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732034174;
	bh=xQ1t7fesoYZ8wV4g7LdmSKAMQbj6ENkUoUq1HdtxS8c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r0y5cUvuAV07U0o8e3HqWeViPzV8lOymA1zNZTGTWxRr9i7ISFrWvOWiWlD9G6AgW
	 ePnbvffoWciQr73QMhw8ZM/ImmleSjXoa4dOftRQp/eBMuULqSyZkR/swqpr9VV9Uy
	 4hyfJ4NHioAnLDqVvHQILZoCkkIeFKOME1Z0y4HlhN2VcnZnJLj/a4Muj3yJemYhZh
	 V/n8yUjUp5eIvNrYMJ9r5csXdp/AdeQ6A6mPSji+R/48DFumf8Du5zNtVnGpXPBkRf
	 hHzlTEbLKcwdL0IGybOFCXoy/Ara7+I1T+CLDxZcEsT/ViYPs78bSIa7Mgzs+VK5Ef
	 U5cvFKiVJMyUg==
Message-ID: <4a2f7ad9-6d38-4d9e-b665-80c29ff726d6@kernel.org>
Date: Tue, 19 Nov 2024 09:36:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GRE tunnels bound to VRF
Content-Language: en-US
To: Ben Greear <greearb@candelatech.com>, Ido Schimmel <idosch@idosch.org>
Cc: netdev <netdev@vger.kernel.org>
References: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>
 <ZzsCNUN1vl01uZcX@shredder>
 <aafc4334-61e3-45e0-bdcd-a6dca3aa78ff@candelatech.com>
 <e138257e-68a9-4514-90e8-d7482d04c31f@candelatech.com>
 <b8b88a15-5b62-4991-ab0c-bb30a51e7be6@candelatech.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <b8b88a15-5b62-4991-ab0c-bb30a51e7be6@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 7:59 AM, Ben Greear wrote:
> 
> Ok, I am happy to report that GRE with lower-dev bound to one VRF and
> greX in a different
> VRF works fine.
> 

mind sending a selftest that also documents this use case?


