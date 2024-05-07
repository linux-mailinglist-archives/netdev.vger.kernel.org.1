Return-Path: <netdev+bounces-93977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B87F8BDCE9
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D931F24E4F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920D513C825;
	Tue,  7 May 2024 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="2h/stbQJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E267613B7AF
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069204; cv=none; b=e4wPeqmqDHgrhJWT4UIuvCMjVl9xVuvXrW0uqXQ+qVYEWnkbYvZv5oa9KrZPrV/9v1lVT0ELYhz3sgThQZdeEwK8LFaOOqgkHsP8tScmNbiCnM+Ft1UoLUWMfH8Do2jhesEDLvoE5XV6Odl/f96UyxLxOrY+FEnSnrrBF7+jrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069204; c=relaxed/simple;
	bh=0pyedL1BVFoLLwp23WgMVifr+cMqistJ0hLnWEMvfh0=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=FfrbOZpqiK5SBAOUxKkVEoosZ1/mAaauLd9/qtICRKyUKyILil0YaIQ7huof/h2pGFezWGqD2u6eBMUwyTPvuuvN8P+TxfJLYr5R9qTdcHLHmgPPNVSfuDCHHBTLXxCyTRPzikMkCBVCr77b+8XQmMd7LauoVOhQEwl2ZO//yA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=2h/stbQJ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:f8c1:ac3:4d22:e947] (unknown [IPv6:2a02:8010:6359:2:f8c1:ac3:4d22:e947])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 8C6277D9CF;
	Tue,  7 May 2024 09:06:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1715069195; bh=0pyedL1BVFoLLwp23WgMVifr+cMqistJ0hLnWEMvfh0=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<66998255-7078-8d4b-6efa-fa7b0751176e@katalix.com>|
	 Date:=20Tue,=207=20May=202024=2009:06:35=20+0100|MIME-Version:=201
	 .0|To:=20Samuel=20Thibault=20<samuel.thibault@ens-lyon.org>,=0D=0A
	 =20Tom=20Parkin=20<tparkin@katalix.com>,=20Eric=20Dumazet=20<eduma
	 zet@google.com>,=0D=0A=20Jakub=20Kicinski=20<kuba@kernel.org>,=20P
	 aolo=20Abeni=20<pabeni@redhat.com>,=0D=0A=20netdev@vger.kernel.org
	 |References:=20<20240502231418.2933925-1-samuel.thibault@ens-lyon.
	 org>=0D=0A=20<ea4ddddc-719c-673e-7646-8f89cd341e7b@katalix.com>=0D
	 =0A=20<20240506214424.4wddiwjdpdl2gf4w@begin>|From:=20James=20Chap
	 man=20<jchapman@katalix.com>|Subject:=20Re:=20[PATCH]=20l2tp:=20Su
	 pport=20several=20sockets=20with=20same=20IP/port=20quadruple|In-R
	 eply-To:=20<20240506214424.4wddiwjdpdl2gf4w@begin>;
	b=2h/stbQJ5Vq1gSbqddIXYxULpK9lXId0j2xezmcPUntG3GWCVP65zBVbf1fkXTyxP
	 oBneUxJgavhyFfk2GE8VAkhvqNwJC0pyXrK6mbBTDvwcpHs3vjEVLni3F15kJxPW0D
	 tPkhQupRUD1+DL7YM3sbvP2pJWJCZXGyefGuWwljAu9gyPg0wEoZCG4hTlYdBlPCMC
	 Ai4R7iikTehVvNQfQA7YermJUapKWaS76b/k0Cy4ZRIO0QlsQuo82TzR3Rxyn1qjTN
	 qQYW9EfEo9aI4lgOct4UDBcHOpzzKYaD6bCiTH+YfHMKuH27cObY4oi+MrJrd4XgtZ
	 HvbcSvSUgiu0w==
Message-ID: <66998255-7078-8d4b-6efa-fa7b0751176e@katalix.com>
Date: Tue, 7 May 2024 09:06:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Tom Parkin <tparkin@katalix.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240502231418.2933925-1-samuel.thibault@ens-lyon.org>
 <ea4ddddc-719c-673e-7646-8f89cd341e7b@katalix.com>
 <20240506214424.4wddiwjdpdl2gf4w@begin>
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH] l2tp: Support several sockets with same IP/port quadruple
In-Reply-To: <20240506214424.4wddiwjdpdl2gf4w@begin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Samuel,

On 06/05/2024 22:44, Samuel Thibault wrote:
> Hello,
>
> James Chapman, le ven. 03 mai 2024 12:36:14 +0100, a ecrit:
>
>>> +			/* We are receiving trafic for another tunnel, probably
>>> +			 * because we have several tunnels between the same
>>> +			 * IP/port quadruple, look it up.
>>> +			 */
>>> +			struct l2tp_tunnel *alt_tunnel;
>>> +
>>> +			alt_tunnel = l2tp_tunnel_get(tunnel->l2tp_net, tunnel_id);
>> This misses a check that alt_tunnel's protocol version matches the header.
>> Move the existing header version check to after this fragment?
> We need to check the version before getting the tunnel id, which we need
> to look up the struct l2tp_tunnel :)
I was referring to the following code fragment which is before your change:

 >    version = hdrflags & L2TP_HDR_VER_MASK;
 >    if (version != tunnel->version) {
 >        pr_debug_ratelimited("%s: recv protocol version mismatch: got 
%d expected %d\n",
 >                     tunnel->name, version, tunnel->version);
 >        goto invalid;
 >    }

The tunnel->version check should now be done after the tunnel pointer is 
possibly modified by your code.

Also, if the tunnel pointer from sk_user_data isn't trusted due to 
5-tuple aliasing, l2tp_udp_recv_core should compare with the local 
'version' variable, not tunnel->version, when parsing the L2TP IDs e.g.:

 >    if (version == L2TP_HDR_VER_2) {
 >        /* If length is present, skip it */

otherwise, L2TPv2 socket aliasing will still not work properly if one or 
more L2TPv3 sockets also alias L2TPv2 sockets, even if there is no 
L2TPv3 traffic.



