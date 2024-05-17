Return-Path: <netdev+bounces-97042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6B8C8E3C
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 00:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DF41C22099
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 22:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A23141995;
	Fri, 17 May 2024 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7Pd2o+f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC14C69;
	Fri, 17 May 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715983456; cv=none; b=SWiKPUk8gxxrxkgFuOs/isAchCinKm4KJPS40S5cbrgKj9au/hMlXbv9wB6mb9nqCdl+wnSmfoufqaIO6HAPLkkmO18F618UhlrlpiQQ72z1/7fodtdjUE3YsBlRL96IqYPqClH4PRf/WhG81vkwGkcbiZuTwkMQQzMIJI4gmBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715983456; c=relaxed/simple;
	bh=n8SD8ziMkDz3/npEj7IDyY34YAEf7wRETO/7yeEm57E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dR/nwopkpJcKvSDIdpV8wg/iejBWDcioQju+ZJRsNX9EXPPKsu7OK7R03PXZCfQMSNaZ3OxZiNMYvd6LDc3KKgdVsnTRgTBXkt5IP59yq33z0Zc2C5GLfaCBMtpKzOknh9H8VxL/xAkCJR9FXmXM8nKSiG7Pd9vQZamlHqTD6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7Pd2o+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EB7C32782;
	Fri, 17 May 2024 22:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715983456;
	bh=n8SD8ziMkDz3/npEj7IDyY34YAEf7wRETO/7yeEm57E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n7Pd2o+fxgdGolgAPY0C+NmpYXAdsrEy2ftv8U7ZYJK6vURiSbZIXsJl5iWbTklOx
	 zOVLwQv8aAnPSVNAZ87ia8ehiZt1M3XjW+aoAxFBMe68MCvO2MAspxR7CZbmKi7mkN
	 5uAV+iZxXmCYQlvgjTaWXmREAuRzCc0UZ6ClJHjCYOU3u1cit5EgbRA2I89D5Zl5QP
	 ZVExYpDA96CEhp0+Sy8PabjMqHqZEHZCLSKpGoKx9abn/Zh0XslOJpGPCkpnE5EfJU
	 ta8lr8W0RF4LtqfnDIcE633UxHrGt6y2PHzYmuEMMRkAAyyLSA7DhgKeyBYvANiTe5
	 xG6OMHh0QREAg==
Message-ID: <5516f2af-cc92-408a-89ce-f571bcc998d6@kernel.org>
Date: Fri, 17 May 2024 16:04:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net] ipv6: sr: fix missing sk_buff release in seg6_input_core
Content-Language: en-US
To: Andrea Mayer <andrea.mayer@uniroma2.it>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Lebrun <david.lebrun@uclouvain.be>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 Ahmed Abdelsalam <ahabdels.dev@gmail.com>
References: <20240517164541.17733-1-andrea.mayer@uniroma2.it>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240517164541.17733-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/24 10:45 AM, Andrea Mayer wrote:
> The seg6_input() function is responsible for adding the SRH into a
> packet, delegating the operation to the seg6_input_core(). This function
> uses the skb_cow_head() to ensure that there is sufficient headroom in
> the sk_buff for accommodating the link-layer header.
> In the event that the skb_cow_header() function fails, the
> seg6_input_core() catches the error but it does not release the sk_buff,
> which will result in a memory leak.
> 
> This issue was introduced in commit af3b5158b89d ("ipv6: sr: fix BUG due
> to headroom too small after SRH push") and persists even after commit
> 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane"),
> where the entire seg6_input() code was refactored to deal with netfilter
> hooks.
> 
> The proposed patch addresses the identified memory leak by requiring the
> seg6_input_core() function to release the sk_buff in the event that
> skb_cow_head() fails.
> 
> Fixes: af3b5158b89d ("ipv6: sr: fix BUG due to headroom too small after SRH push")
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/seg6_iptunnel.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



