Return-Path: <netdev+bounces-58264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 767AD815AF9
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 19:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E934B22642
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 18:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8556C3159D;
	Sat, 16 Dec 2023 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX9Kdhkq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB53172C
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 18:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F59C433C8;
	Sat, 16 Dec 2023 18:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702750367;
	bh=FAYHOy3uoYdgSL/kCcJkzYLX/Fow48UAa70BZKEWKvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iX9KdhkqrENQ3hYXpEeS8GnU7eTgTMsVVOra4gyujbqrq4XWwjB33XEg8Z0vZHERf
	 yS9HpR9+0UMkbfzWBSzwXYxJL6IKSCoAXPEci5FHc/2i6M4NZEhIoMl8daFP1vnLTL
	 vKTXN6979iwE2RpDt8D+ASAqRDmjvQdtHiFqS+T/+E42UyOHUyjlODqWRDG9iqzMqi
	 QFw2E7EzSplU1vk+4OgLMUAaOV10zVOySC0SyxRABa40G414l+zxVDZ1a/EmnnTWBq
	 rCqrlwmC2EZuGhvmeD+w/AlrGRqKlz4hi/Uq/ePUuUJ8mS0X3l+0CoWcHhfrZFRagR
	 f7SP/VwgNzlmw==
Message-ID: <aa341e85-6a3f-4d4b-a2a7-b19bf0c9ba2f@kernel.org>
Date: Sat, 16 Dec 2023 11:12:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: net: ipconfig: temporarily bring interface down when
 changing MTU.
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Graeme Smecher <gsmecher@threespeedlogic.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com, mdf@kernel.org
References: <58519bfa-260c-4745-a145-fdca89b4e9d1@kernel.org>
 <20231216010431.84776-1-gsmecher@threespeedlogic.com>
 <20231215193024.02819d85@hermes.local>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231215193024.02819d85@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/23 7:30 PM, Stephen Hemminger wrote:
>> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
>> index c56b6fe6f0d7..69c2a41393a0 100644
>> --- a/net/ipv4/ipconfig.c
>> +++ b/net/ipv4/ipconfig.c
>> @@ -396,9 +396,21 @@ static int __init ic_setup_if(void)
>>  	 */
>>  	if (ic_dev_mtu != 0) {
>>  		rtnl_lock();
>> -		if ((err = dev_set_mtu(ic_dev->dev, ic_dev_mtu)) < 0)
>> -			pr_err("IP-Config: Unable to set interface mtu to %d (%d)\n",
>> -			       ic_dev_mtu, err);
>> +		/* Some Ethernet adapters only allow MTU to change when down. */
> Check if interface was already down first.


it is; see ic_open_devs. ic_close_devs will bring down all interfaces
not configured by ipconfig.



