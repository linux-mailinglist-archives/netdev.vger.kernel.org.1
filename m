Return-Path: <netdev+bounces-139188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A119B0D34
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 20:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E605E1F22D11
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B042220D4E8;
	Fri, 25 Oct 2024 18:25:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay162.nicmail.ru (relay162.nicmail.ru [91.189.117.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC52206505;
	Fri, 25 Oct 2024 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880727; cv=none; b=elPlRCRJl/uGlrVfYBTp3BN//08wlGCQyGP9TIHVxIvGyx8f+cSrD3DLinzmmCvmK/594dnGuG1TcSTPuIJSOTnC30vEVSIOpvpWwPXMA5OfDbbi87U25FVrbKxpUyEXBYp4eEGQVj/JD5ZPw4qXYRWaJp+Hp0DulPs9mTnk3xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880727; c=relaxed/simple;
	bh=ZRJFlXRAQRMnzFiGaRaE2Lz34/gU+03KlRhqUxDVI7Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aPVY0vSZbq36vdw0ovVIGbaYnNtjrRH9f0EvryYkiIDqS9n7IOsIaCQKMQv0wD9PCDkcRSpjLoK3f8p0KQ9Smh16HkN5f0+nza8V2nrET1Ej66H2Q35ohZDzaqDk6euB8OlzZNKzydtM+ECHLovwNoRyzxqD7h26FcqX5GgPAeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.148] (port=5944 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1t4Opz-0000000088U-5tJ7;
	Fri, 25 Oct 2024 21:15:04 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1101.mail.hosting.nic.ru (Exim 5.55)
	with id 1t4Opz-0097Vn-1f;
	Fri, 25 Oct 2024 21:15:03 +0300
Message-ID: <fa1c5922-ddbc-4765-a209-9c9477868635@ancud.ru>
Date: Fri, 25 Oct 2024 21:15:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bnx2x: turn off FCoE if storage MAC-address
 setup failed
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240712132915.54710-1-kiryushin@ancud.ru>
 <c9e7ab8a-9ccf-4fea-9711-11cc89e12fc4@lunn.ch>
 <faed05e5-f276-4445-85d0-bfa3d515539a@ancud.ru>
Content-Language: en-US
In-Reply-To: <faed05e5-f276-4445-85d0-bfa3d515539a@ancud.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

On 7/15/24 17:10, Nikita Kiryushin wrote:
>> How broken is it when this happens?
> I can not say what would happen exactly, if the address is not assigned
> the way it should. But there would be at least an attempt to free unallocated
> address (in __bnx2x_remove).
>
>> This is called from .probe. So
>> returning the error code will fail the probe and the device will not
>> be created. Is that a better solution?
> To me, it does not seem fatal, that is why I am not returning error,
> just print it and disable FCoE. The "rc" set will not be returned (unless
> jumped to error handlers, which we are not doing). Would it be better, if
> I used some other result variable other than "rc"? The check could be the call,
> but than handling would be inside a lock, which I think is a bad idea.

The patch is marked as "Changes Requested" at the Patchwork,
but I am not sure, what has to be done with it.

