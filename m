Return-Path: <netdev+bounces-240574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C19C76557
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 22:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 798724E1415
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799432E7BC0;
	Thu, 20 Nov 2025 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="I8Bi1f9h"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD30253958;
	Thu, 20 Nov 2025 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673165; cv=none; b=abnmLJhz94uPPP3whIIJU9UhVSq/ly2YrJByK1yfB5lcxrYfDK6nRIKmBtNqsUvzfxvjCHgFMtj3kPxHZ7cjuqygZ6DQLdgniQsZCIuHNG5p/SSiai3SK2OKOWcMs/xq9LL/Z0XgHDV4e/aXd2hG4t++La1QrB19UN9r2kzXXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673165; c=relaxed/simple;
	bh=pOkFFhPWEt469H/xWxXlh75e0/pRvG2o41P/KfhMKHY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jFfcuM/4JuQyulv5O43xe+XDtxjD8gpv6g3C4umOj2AzNq8JU/6aaImSKT7q712PxLUM4yGPYSJeuF/gYWRQmdHJcwLQ+Z/pQYRuv9S4sAjqZGyxQRcQwanFs1FgC0plS/xFTUwah/KAIHZme2Extd9R+coE90aIshf4cCw6NEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=I8Bi1f9h; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vMBxD-009wgS-1J; Thu, 20 Nov 2025 22:12:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID;
	bh=m0BcLIFhPMM1vgYjkTG+EbnOTh4Iaz6u3ClLB7W2+dg=; b=I8Bi1f9hDBUu6aeJb82SJ0o4rn
	11v31+9W14L3ug8yFuBxypzT+mPK8PeUdJHA1+JX/zJYUhKnsdaoQ+n2ow3WuDGDf9HfA409O5PZ6
	zMhBEhj7FOxvBgMlJJUpzA6CqneFVJRIc1V2RqkCGP9B10q+za8ZF7ucACWOWnKmvBhEu21CVDQ0k
	mWRCuJsrH6vT12nNO3D/SoWgq4q30OwhF/OMT20pMkLzMm8QvGP2afxE/Gx2smtFdS3q9SBuOxprA
	80TKbB0vIXyci3i8NtLmC28tC/+cjBCbONiwE3qjbMGujEgskLs16A4nPTme3TKoNkxtKPLb3QDu/
	pDQXqWFw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vMBxC-0008QC-65; Thu, 20 Nov 2025 22:12:34 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vMBwz-000Sx6-Te; Thu, 20 Nov 2025 22:12:22 +0100
Message-ID: <06936b55-b359-4e3d-bec0-b157ca32d237@rbox.co>
Date: Thu, 20 Nov 2025 22:12:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
From: Michal Luczaj <mhal@rbox.co>
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
Content-Language: pl-PL, en-GB
In-Reply-To: <1b2255c7-0e97-4b37-b7ab-e13e90b7b0b9@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 20:52, Michal Luczaj wrote:
> ...
> To follow up, should I add a version of syzkaller's lockdep warning repro
> to vsock test suite? In theory it could test this fix here as well, but in
> practice the race window is small and hitting it (the brute way) takes
> prohibitively long.

Replying to self to add more data.

After reverting

f7c877e75352 ("vsock: fix lock inversion in vsock_assign_transport()")
002541ef650b ("vsock: Ignore signal/timeout on connect() if already
established")

adding

--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -2014,6 +2014,7 @@ static void test_stream_transport_change_client(const
struct test_opts *opts)
                        perror("socket");
                        exit(EXIT_FAILURE);
                }
+               enable_so_linger(s, 1);

                ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
                /* The connect can fail due to signals coming from the

is enough for vsock_test to trigger the lockdep warning syzkaller found.


