Return-Path: <netdev+bounces-241070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A80FDC7E7E1
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 22:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 658574E2228
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 21:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB05C26E6F8;
	Sun, 23 Nov 2025 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="r8w2Xhgq"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D49326CE11;
	Sun, 23 Nov 2025 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763934408; cv=none; b=FRXGKt6BtJ4PqiSVQOhx4Ylh3P3hoCE1gUaEJkN+sFAZKopn0SO+pO8oWUw4YYxL2O+4q2Ofcey9g3Jjoj6QPqz36ZizckC6miK10fsnBkJejz8/5fKYDhxKkQVmvTzV+pRAZLBz7BxR8Ree5CRa6agc+8ACo20I20IE1aFqndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763934408; c=relaxed/simple;
	bh=SXzlEMIfuqof9XPqr1BY5IV2ECcOmlshnjU0P8djnL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgSdKipjD8IeodVlGSjWswXat7HO0cFapCcvKSTMZQMcY32mxewtXg51ykJAZrrI+Ou983AkRcFWFrD51rr3OTarG9+8QqcPdXtEsncefOGLACdWDK/75jmH4kSUTEXbQqeLRmLkk8zEksSIONZPJ4/Tma3WeCRzYCDjjzcpbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=r8w2Xhgq; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vNHut-001CsT-HW; Sun, 23 Nov 2025 22:46:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=DRnvCSjVzgrSnN4EAonU/KtH7SXFjNQ93qQMIgdXMSY=; b=r8w2XhgqagmrvZiya5HF38/5zZ
	S1Pi4U9pbJ7fFqlbZqvSPWBXlaQMOFt0vioD9IwGX4Yv9pJ6lv1O7eHCLwB7Oae5x+cbLTLTzmGUz
	1S7tmnX6uyDc023ikOz7d/pEm7vi+L9LYAIUYPWmSAqQiGdXpeGwkURbRFToykOAXopShrVz1EFYR
	r1QxyACqjS9E2wftQsexM+IdqveBVZvO3GWy42M/4MOM6qEO2//dNrFazUP55gGIsuGcNNvtAV924
	i9w0pVMpjPTbPMcoeFCfUptJBWRj+MS2U1FmaOpBOfH46IgqsCpnlYV4kvgnIZxS/1nAM6MKiNmrr
	N9PtnrgA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vNHus-0005vZ-Nt; Sun, 23 Nov 2025 22:46:42 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vNHuZ-006wBS-R6; Sun, 23 Nov 2025 22:46:23 +0100
Message-ID: <69a3d223-dd95-43df-af3a-522968d6b850@rbox.co>
Date: Sun, 23 Nov 2025 22:46:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
 <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
 <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
 <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
 <09c6de68-06aa-404d-9753-907eab61b9ab@rbox.co>
 <663yvkk2sh5lesfvdeerlca567xb64qbwih52bxjftob3umsah@eamuykmarrfr>
 <1b2255c7-0e97-4b37-b7ab-e13e90b7b0b9@rbox.co>
 <06936b55-b359-4e3d-bec0-b157ca32d237@rbox.co>
 <fy3ep725gwaislzz6lyu27ckswp2iyy5gj6afw6jji6c3get3l@lqa6wpptq5ii>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <fy3ep725gwaislzz6lyu27ckswp2iyy5gj6afw6jji6c3get3l@lqa6wpptq5ii>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/25 10:21, Stefano Garzarella wrote:
> On Thu, Nov 20, 2025 at 10:12:20PM +0100, Michal Luczaj wrote:
>> On 11/19/25 20:52, Michal Luczaj wrote:
>>> ...
>>> To follow up, should I add a version of syzkaller's lockdep warning repro
>>> to vsock test suite? In theory it could test this fix here as well, but in
>>> practice the race window is small and hitting it (the brute way) takes
>>> prohibitively long.
>>
>> Replying to self to add more data.
>>
>> After reverting
>>
>> f7c877e75352 ("vsock: fix lock inversion in vsock_assign_transport()")
>> 002541ef650b ("vsock: Ignore signal/timeout on connect() if already
>> established")
>>
>> adding
>>
>> --- a/tools/testing/vsock/vsock_test.c
>> +++ b/tools/testing/vsock/vsock_test.c
>> @@ -2014,6 +2014,7 @@ static void test_stream_transport_change_client(const
>> struct test_opts *opts)
>>                        perror("socket");
>>                        exit(EXIT_FAILURE);
>>                }
>> +               enable_so_linger(s, 1);
>>
>>                ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>>                /* The connect can fail due to signals coming from the
>>
>> is enough for vsock_test to trigger the lockdep warning syzkaller found.
>>
> 
> cool, so if it's only that, maybe is worth adding.

Ok, there it is:
https://lore.kernel.org/netdev/20251123-vsock_test-linger-lockdep-warn-v1-1-4b1edf9d8cdc@rbox.co/

And circling back to [1], let me know if you think it's worth adding to the
suit. I guess it would test the case #2 from [2], but it'd take another 2s
and would require both h2g and non-h2g transports enabled.

[1]:
https://lore.kernel.org/netdev/fjy4jaww6xualdudevfuyoavnrbu45cg4d7erv4rttde363xfc@nahglijbl2eg/
[2]:
https://lore.kernel.org/netdev/20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co/


