Return-Path: <netdev+bounces-73256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A886E85B9DA
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1721C21D10
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56893657DF;
	Tue, 20 Feb 2024 11:04:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A643862178
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427042; cv=none; b=qezHkdNRGBQnxl99eCCNij06rnVuFaT+ll1AepjQ6DMQ999+1eS4FXQL3ENhX3+RS81xfaZmQ7Wu5aEm2zWzQOWcRFq64h3EFXevfnWWpdFaNtRvcKaRK/m5oGM4MnrHR49KDiTCaIBdn7BdbGkWzz5rCWTB9ifksLK2akdsm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427042; c=relaxed/simple;
	bh=YU6/1yT+K9NW08YsS8L2OX81iL7PTaEywsijjA86zCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxpXo7ZKFrZzQRa/oy4rRoNHb9gJrDVNqDO68T/Nbsi7Pfq4c46Hfla8WjuUBmVMkeltugsiNFPn78669Ibt8viu9HS6XaOVlAb8dWmXYFoPkTwK0f91UYnXk7EDywotQ4p8rrfPjk/2hscsLdNSiUeQ4jIv/4qk6iVLQEZ2fSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id D10C82F20257; Tue, 20 Feb 2024 11:03:57 +0000 (UTC)
X-Spam-Level: 
Received: from [10.88.144.178] (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id A68242F20257;
	Tue, 20 Feb 2024 11:03:55 +0000 (UTC)
Message-ID: <61ba58b4-abc7-2b87-c25f-91ada2f28cfc@basealt.ru>
Date: Tue, 20 Feb 2024 14:03:55 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net ver.2] genetlink: fix possible use-after-free and
 null-ptr-deref in genl_dumpit()
Content-Language: en-US
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jiri@resnulli.us,
 jacob.e.keller@intel.com, johannes@sipsolutions.net, idosch@nvidia.com,
 horms@kernel.org, david.lebrun@uclouvain.be
References: <20240220102512.104452-1-kovalev@altlinux.org>
 <ZdSAndRQxKGkV/EO@calendula>
From: kovalev@altlinux.org
In-Reply-To: <ZdSAndRQxKGkV/EO@calendula>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Pablo,

20.02.2024 13:36, Pablo Neira Ayuso wrote:
> On Tue, Feb 20, 2024 at 01:25:12PM +0300, kovalev@altlinux.org wrote:
>> From: Vasiliy Kovalev <kovalev@altlinux.org>
>>
>> The pernet operations structure for the subsystem must be registered
>> before registering the generic netlink family.
> IIRC, you pointed to a syzbot report on genetlink similar to gtp.

Yes, I was referring to the link 
https://lore.kernel.org/all/0000000000007549a6060f99544d@google.com/T/ ,

>
> Maybe add that tag here and get the robot to test this fix?
but since the syzbot does not have a reproducer, I cannot say for sure 
that this is exactly the problem that this patch fixes, since syzbot 
refers to the tipc_udp_nl_dump_remoteip function and suddenly there is 
another problem...
>
> I'd suggest to describe the scenario, which is: There is a race that
> allows netlink dump and walking on pernet data while such pernet data
> is not yet set up.
>
> Thanks.

-- 
Regards,
Vasiliy Kovalev


