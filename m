Return-Path: <netdev+bounces-87189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A38A20B9
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 23:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC6D1F2134C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 21:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3752DF84;
	Thu, 11 Apr 2024 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+lr+qbG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285E9205E0D
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712870074; cv=none; b=CMjGo+BpLvXwRWoIJ5Y9Sh+vKvT2wAX50k4W7noRSCuRcF7IltkmwV4sm/vyHwIoHWjWTUsoKge18aqSIvQdNgBiwzW/FzHrI86WaryELJDiJgOttqQlaR+o1BL8pEtLEe+hU0uSKzOKK2HKHiXmGeqNj8UQZpedEvLEY1nVKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712870074; c=relaxed/simple;
	bh=LkpCvjNdHx3AdcAwdq7W06nZei3e2TKwfDHNiCSe6gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqPJVWIbaL8Ky742/ZsfBh6y+fAD376fxDyT+7F2yiUa2BOzYjMeYlfRFV4+0k/DZX3JZVdoCZwCyrKDDU4+8bEctWN0TiDVlDdWSTZ8d6Z9kTZeu4J1XJuO8Ryy7i8UF41MBOFg0CSPPEM/K501prTje/U8tebYDW0cDnve29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+lr+qbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5269EC072AA;
	Thu, 11 Apr 2024 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712870073;
	bh=LkpCvjNdHx3AdcAwdq7W06nZei3e2TKwfDHNiCSe6gI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b+lr+qbGJw5UgEpkRMguaGHYuAhDh2JEOo5lyCxqWs4WcJal/APC80wipe2ipHBpL
	 O6UBYhVwT4vxMPiAJzfZ6IH5UGfLACdJLOTe/e2eIYWccYlFLh+WLTlPujNqiz7PDB
	 pjmt5msmLV8GYm/giXvYd7RXIAkAQXGZmHSkxIgRkWiTgRBFBwheX3+6QsxmZbPVqN
	 +tzw4yMM0qtic4ax6zW/DSwi3qmmwrtjMYgCAQJN4MSgunzZOADNZcWo8Nnsdg/Kcq
	 BXsbbbEaIbzNei6cRQIHmbEZ1VKtjZ+Vi8GL0s+IfDNfQNA+7iTf8yr7B3HpAolXHA
	 j+e/CLctNugqA==
Message-ID: <67ed4392-18d2-4cb3-8ed4-df65737f3da6@kernel.org>
Date: Thu, 11 Apr 2024 15:14:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() again
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Stefano Brivio <sbrivio@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, donald.hunter@gmail.com
References: <20240411180202.399246-1-kuba@kernel.org>
 <b4e24c74-0613-48be-9056-a931f7d9a772@kernel.org>
 <20240411140154.2acd3d0a@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240411140154.2acd3d0a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 3:01 PM, Jakub Kicinski wrote:
> On Thu, 11 Apr 2024 13:45:42 -0600 David Ahern wrote:
>>> +	/* Don't let NLM_DONE coalesce into a message, even if it could.
>>> +	 * Some user space expects NLM_DONE in a separate recv().  
>>
>> that's unfortunate
> 
> Do you have an opinion on the sysfs/opt-in question?

Not a performance critical path, so I would not add it right now.

> Feels to me like there shouldn't be that much user space doing raw
> netlink, without a library. Old crufty code usually does ioctls, right?
> So maybe we can periodically reintroduce this bug to shake out all 
> the bad apps? :D

:-) On the one hand, yea, push apps to improve. On the other, Donald
(FRR) is one who complains about nightmares chasing nuances across kernels.

