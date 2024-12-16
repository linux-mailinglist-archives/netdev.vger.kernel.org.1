Return-Path: <netdev+bounces-152254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564AF9F33C8
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C335E1889D16
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2412C45945;
	Mon, 16 Dec 2024 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="pEKiok5M"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FED29422
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360747; cv=none; b=NI3F1Alt7+N9Gc8vBfZLaRMSoMFjgyoEl+HUxF4Dd0fCDKt50x0ze2eutdIsNEj61xn21lEmpvkkBxPm6RkHEKd9jW5SxFSPKYuGelbxrHPS8IwPv4FhM0X4hnp+VnR599MRW56OmAvGE/zgNtvzJ69mcY4/NmhFhiIHt6idHDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360747; c=relaxed/simple;
	bh=k3OTx4TRmvj19RHS/jibIOBf443K9DH+wOt6RfKZtf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itKX8dP35wtJdgckhtonDM2I1NU/zU0O6pO6yYE6HrMDfCdveD6N1pwDF4ddzQ4FMFHbE1SJSLTZkuruLSPf31hmowIE713JNv0xvHF2ibiIkDaRyS7aHbW8+Y6H5gGH7RvsVGr8m4OJacvKpL7q3jwkmAlOeaeUz1CyQUD7hg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=pEKiok5M; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tNCSI-00G9e6-BN; Mon, 16 Dec 2024 15:52:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=YIf/RRvoa/looScDDFFEBgTINzy28DW0ixQG32Ee7R4=; b=pEKiok5MU6MKVsy5YoT19y8u0B
	P4zs1s+JRfz/z7OExL3SDinPFxLUfP8wmNp4BCLPeuDwLzTJhmX+ahZ8ALg/h8PwD9S01TgCGFXfC
	Q7cCfDOKLwHQhXxahkoJK2RKSu4kqFHUYM2yl+xmo4tLut1CU/Vsbj+lZUaiBWB7pEaHu5zC/eaoe
	wJOSGK5TzhMWh466ts/4mC3clFWetAjjVw4waLGwftnhffuq0TCl9VH+8ut+X+itNbl9yPkE54/tG
	z7/ZszS0ZfahBfl2N/A06yzcNVKOBai/0q5hyQqomRX/teK8oHN1/0vPawTTas8XuA+uucQn42cRB
	PW6V+HqA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tNCSH-00063T-Qk; Mon, 16 Dec 2024 15:52:18 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tNCS4-00Dx3T-P0; Mon, 16 Dec 2024 15:52:04 +0100
Message-ID: <dfc51f68-5013-4c7a-ba0d-d3969ac9ecc8@rbox.co>
Date: Mon, 16 Dec 2024 15:52:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/6] vsock/test: Add test for accept_queue
 memory leak
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
 <20241216-test-vsock-leaks-v2-4-55e1405742fc@rbox.co>
 <bl3osg7ze6bjivu53j5vdlrtkzq35vk3zbp2veosyklp53rf2i@drb2efczau6n>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <bl3osg7ze6bjivu53j5vdlrtkzq35vk3zbp2veosyklp53rf2i@drb2efczau6n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/24 15:35, Stefano Garzarella wrote:
> On Mon, Dec 16, 2024 at 01:01:00PM +0100, Michal Luczaj wrote:
>> Attempt to enqueue a child after the queue was flushed, but before
>> SOCK_DONE flag has been set.
>>
>> Test tries to produce a memory leak, kmemleak should be employed. Dealing
>> with a race condition, test by its very nature may lead to a false
>> negative.
>>
>> Fixed by commit d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory
>> leak").
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> tools/testing/vsock/vsock_test.c | 51 ++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 51 insertions(+)
>>
>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>> index 1ad1fbba10307c515e31816a2529befd547f7fd7..1a9bd81758675a0f2b9b6b0ad9271c45f89a4860 100644
>> --- a/tools/testing/vsock/vsock_test.c
>> +++ b/tools/testing/vsock/vsock_test.c
>> @@ -1474,6 +1474,52 @@ static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
>> 	test_stream_credit_update_test(opts, false);
>> }
>>
>> +/* The goal of test leak_acceptq is to stress the race between connect() and
>> + * close(listener). Implementation of client/server loops boils down to:
>> + *
>> + * client                server
>> + * ------                ------
>> + * write(CONTINUE)
>> + *                       expect(CONTINUE)
>> + *                       listen()
>> + *                       write(LISTENING)
>> + * expect(LISTENING)
>> + * connect()             close()
>> + */
>> +#define ACCEPTQ_LEAK_RACE_TIMEOUT 2 /* seconds */
>> +
>> +#define CONTINUE	1
>> +#define DONE		0
> 
> I would add a prefix here, looking at the timeout, I would say
> ACCEPTQ_LEAK_RACE_CONTINUE and ACCEPTQ_LEAK_RACE_DONE.

I was hoping to make them useful for other tests (see failslab example in
patch 6/6). If CONTINUE/DONE is too generic, how about prefixing them with
something like LOOP_ or TEST_ or CONTROL_ ?


