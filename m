Return-Path: <netdev+bounces-177094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2923EA6DD44
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD51169268
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB51225FA1B;
	Mon, 24 Mar 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8Q+Da9M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569625F997
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827464; cv=none; b=iT/QBDynNKpKFdDeZ/M2eomEIF1eQW6XXl08eE0s2XFkQPs/7HDKvS60AJ2wkcWB+LGEbO/C2ZUBulgXaBkjxAKrh/6+LT5XcTamhyIoRej1ovw0A/HR8pURh5FswORe3Os6lf6tKhzrQ5S6FQlRRTOuLL+52638oupwtOEgVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827464; c=relaxed/simple;
	bh=1hY5snS570IAZoPRI3BAhwwNMOBAOt+8fY7GKePhpiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptcKmNEQbcQf2S3oBuHSge+olx+zP1ClU9oOWy8pqt8oMnekAZ3qFByRt3gUbej3+euyakJuHienCtkQHzfhrEoAcnD/9xBK1BlTZpKyq66hACcMKW2xCaZI0L/j+NPg/ZSMr2lL8yq7E7tDv1BCmZHvbzF/F+SvFF7qX4qUgRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8Q+Da9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCCBC4CEDD;
	Mon, 24 Mar 2025 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742827464;
	bh=1hY5snS570IAZoPRI3BAhwwNMOBAOt+8fY7GKePhpiU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H8Q+Da9MXJMm/ofVrsMEtJThnNQf5yDDjm47+HIyNa84LFHkPUamMqeHXI591LGgF
	 YYTEim9XXCfSXXK9zp67HkE0+n0nqJPPX91xEZDWUcP/SjnjyZ+daTkWxSkpL9jBFP
	 30Zi6Rltw3IVQ/XhLnZxwcxAMsMfn8FoVc769HLb5+Br6tYmGVxPTAzysm0BHj8WiW
	 LcHLBLlHKVbaxjgUOs0abzCLld4F6BFNya7WyJGjJLFQawBrnzeW8F5efv9z+V3Oak
	 VsXUkSbeDPlPvx6Vh3rayAFAQrLFUWK9gFXzBqq5/c9vWkaOqc3dwu1Mziek0+KHgo
	 iWb3VUgdgZc6w==
Message-ID: <3bd78b6a-3c6d-4130-b086-36f2f728bc3e@kernel.org>
Date: Mon, 24 Mar 2025 16:44:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ti: icssg-prueth: Check return value to avoid a
 kernel oops
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: netdev@vger.kernel.org, MD Danish Anwar <danishanwar@ti.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250322143314.1806893-1-b.spranger@linutronix.de>
 <89f81b99-b505-48ad-b717-99e5d4d8e87b@kernel.org>
 <20250323161826.5bcd9cf8@mitra>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250323161826.5bcd9cf8@mitra>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/03/2025 17:18, Benedikt Spranger wrote:
> On Sun, 23 Mar 2025 09:19:35 +0200
> Roger Quadros <rogerq@kernel.org> wrote:
> 
>> Did you actually get a kernel oops?
> Yes. And I would like to attach the kernel output, but I do not have
> access to the board ATM.
> 
>> If yes, which part of code produces the oops.
> I get an NULL pointer dereference in is_multicast_ether_addr().
> It happens here:
> 
>     u32 a = *(const u32 *)addr;

But this should not happen. Because ndev->addr (pointer) should not be zero.
Driver allocated ndev with alloc_etherdev_mq() which allocates memory for ndev->addr using dev_addr_init(dev)).

> 
>> Even if it fails we do set a random MAC address and do not return
>> error. So above statement is false.
> I doubt that. of_get_ethdev_address() do not set a random MAC address
> in case of a failure. It simply returns -ENODEV. Since
> is_valid_ether_addr() fails with a NULL pointer dereference in
> is_multicast_ether_addr() on the other hand, no random MAC address is
> set. 

What I meant was we set random address using eth_hw_addr_random().

> 
>>> Check the return value of of_get_ethdev_address() before validating
>>> the MAC address.  
>>
>> If of_get_ethdev_address() fails the netdev address will remain zero
>> (as it was zero initialized during allocation) so
>> is_valid_ether_addr() will fail as well.
> Yes. It will fail to. But is_valid_ether_addr() is not called any more.
> 
> Due to the if statement is_valid_ether_addr() is only called, if
> of_get_ethdev_address() exits with 0 aka success. In case of a failure
> the if statement is true and there is no call to is_valid_ether_addr().
> 
> Regards
>     Bene

-- 
cheers,
-roger


