Return-Path: <netdev+bounces-160415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA37A19982
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 21:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6FC188D5A4
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 20:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1C21576D;
	Wed, 22 Jan 2025 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="pnVG5PeJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0F1BD9C1
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576671; cv=none; b=JphbDvxc4HWlEg2OsR9LXmiDtfrntUfCCgw0ldwkfiqQx5+MXcYPYZgIkLzNTBLkXNB9t2YgqCdgMZUrTPvhEFWujx0V1fBjFRcFk+ZRtkVnmcSn3C882I0RbZnGtXt3tJQCfkWxskZRYnKjy+29LwoDKsIwUoz1Vdfl5PbjYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576671; c=relaxed/simple;
	bh=xiVklZWeDyqQaIb7NQirPPzWOTaC7AWuhSk1SfYzmSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQI03wdGa/RDeSKnFZsef03BGVGgP8NpkORkYgQEAMy9ZSHIywzmOVJLv/L2U3i6Ag1z43DL7QGlq332/IfQluRQiwO5llqG/dH085dd7PCp5WkyEsTRaw3LWR3VPXlNTOdbhHE9yE/3L0tfZngSkSW0JspCkRxbSCWia4c5bCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=pnVG5PeJ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tah3s-004ZhE-Ar; Wed, 22 Jan 2025 21:10:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=96N5yEpnpGGbPvNGnxUtkM1/nlXoKkOwvrM3xTWF/wU=; b=pnVG5PeJsGdetLBvx9EuIUz8O5
	S14heXhNsosPvtMk5Reu5UBo3lrY/DoAVnbn+yPeCrhTRcX7SORwpc5h7rvcdOkqw+c6XxYUD7tLL
	0IONqdKPF4GQ82QmXx00Yw0uaWQaXrEyVH7w28jbUtg3oeb58RQoaxQVJbCQFFjJcyHsBWH9TkoPC
	xBpJvF34eRLKIDCjtddkkX2C/26iMwAPwdsM12g4zB+AUFDFMFLPAEbdgbK6M6JHm5bNJf3gkupVq
	4+7kD6LoXbSLjdEbkAbQD5tleLdwg08iymsR32RyLHmFecHPuyQf0UMUmtEqTi5NIRqRQkyAnCSiR
	wFRxU7cQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tah3r-0002Q4-7g; Wed, 22 Jan 2025 21:10:51 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tah3i-00DIsB-4c; Wed, 22 Jan 2025 21:10:42 +0100
Message-ID: <44f050cb-b89d-4c93-ba24-18091dada750@rbox.co>
Date: Wed, 22 Jan 2025 21:10:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/6] vsock: Transport reassignment and error
 handling issues
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 Andy King <acking@vmware.com>, netdev@vger.kernel.org
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <kxipc432xhur74ygdjw3ybcmg7amg6mnt2k4op3d4cb5d3com6@jsv3jzic5nrw>
 <282fbb3c-97d6-4835-86d3-97eb14ff74ea@rbox.co>
 <CAGxU2F5zhfWymY8u0hrKksW8PumXAYz-9_qRmW==92oAx1BX3g@mail.gmail.com>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <CAGxU2F5zhfWymY8u0hrKksW8PumXAYz-9_qRmW==92oAx1BX3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/25 16:47, Stefano Garzarella wrote:
> On Wed, 22 Jan 2025 at 15:16, Michal Luczaj <mhal@rbox.co> wrote:
>>
>> On 1/22/25 12:45, Stefano Garzarella wrote:
>>> On Tue, Jan 21, 2025 at 03:44:01PM +0100, Michal Luczaj wrote:
>>>> Series deals with two issues:
>>>> - socket reference count imbalance due to an unforgiving transport release
>>>>  (triggered by transport reassignment);
>>>> - unintentional API feature, a failing connect() making the socket
>>>>  impossible to use for any subsequent connect() attempts.
>>>>
>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>> ---
>>>> Changes in v2:
>>>> - Introduce vsock_connect_fd(), simplify the tests, stick to SOCK_STREAM,
>>>>  collect Reviewed-by (Stefano)
>>>> - Link to v1: https://lore.kernel.org/r/20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co
>>>
>>> Thanks for sorting out my comments, I've reviewed it all and got it
>>> running, it seems to be going well!
>>
>> Great! I was worried that I might have oversimplified the UAF selftest
>> (won't trigger the splat if second transport == NULL), so please let me
>> know if it starts acting strangely (quietly passes the test on an unpatched
>> system), and for what combination of enabled transports.
> 
> Yeah, I was worrying the same and thinking if it's better to add more
> connect also with LOOPBACK and a CID > 2 to be sure we test all the
> scenarios, but we can do later, for now let's have this series merged
> to fix the real issue.

Sure, I'll take care of this CID galore later on.

> I tested without the fixes (first 2 patches) and I can see the
> use-after-free reports only on the "host" where I have both loopback
> and H2G loaded, but this should be fine.

Argh, sorry. FWIW, re-adding a bind() after the second connect should
increase the coverage.


