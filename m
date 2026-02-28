Return-Path: <netdev+bounces-262132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1LBeAWLyomlD8QQAu9opvQ
	(envelope-from <netdev+bounces-262132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:49:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B5C1C3506
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E4E304CA60
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DC0285071;
	Sat, 28 Feb 2026 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bjqdLPJ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09417C77
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772286559; cv=none; b=F9id3CXa0/kUkW7q+ERXeosfiaXfk3bdbhaszI/46JemvuFPo2AWchJuNCJg0ucAxeXGCWwU9jekYm0GJEoKuZ6pgVCsoXN76kQu2di+vcLlrQNxQqSUCuoUe7VcRT70o/Dp7+5lsHsw/t3CAq7Mq69Nv4Zfvv/APom3djYzfJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772286559; c=relaxed/simple;
	bh=zoJGqBYDu+kP9KyJcYQcaGn2pROLqquEbujNOjCIFmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpM2NsuQwnKIH2hq5LPryYgZlZaQDZYM+HZFoQrapE7XECiZV7QG3mhNqm0K7XTeHQ41LkQqNsnUO5xmrM7uL5HOpx2F8MrMVw0+uvFtAjayP9NfG7NP1QljZRryH8gVrBR0zI3k9BXdjEmoq4QEDDRqRfjgilgeCRr3QD9O2JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bjqdLPJ8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4398d9a12c6so2303680f8f.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 05:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772286556; x=1772891356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVHskloqc6mKdj2P4gIFS2nKk+iqH2zp3tae36BxYg8=;
        b=bjqdLPJ8F9ZSgfcfHrcgYR6tPbSkEB3865KWTfKkKDmwfJL8PYTSuFRx/BfTi/M50G
         nwV7HiJt3gzYVscOOZJfvuXitdVXLOuF3ZrgzycwC8MdohephywerJ1xpze4BgLVKy8z
         BaxA4VN8odUuT3AmlItbeskRZ3yMKFUbxyrtydFHsx/RtofP+XDlXicgCWZR9wGbp+U1
         OcHCAntdOeJx4yJCgGU8sIJe2NqzGX848QEq1dJItyp25QYj+RJkvRO4cJLLCeB5vVUh
         SMRMO56kvmc5NHbSwXH18mSiOcKNOM6X8K6/oJwQy8MVjd3Vq96K0x5VAfAahPqJfJr5
         bIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772286556; x=1772891356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVHskloqc6mKdj2P4gIFS2nKk+iqH2zp3tae36BxYg8=;
        b=FJPcJaivfqDSRCSkwplMgz77KexIOVXp4Jb8ZmpvdqDitaQZOqaE3LzDEZQXW8TZQh
         fOSN1Gdwjex5rYmU//zMI9VQASq3SfELSbgz0aaqMglo0tbIV4yOMEQxjbmEE89rTO+I
         /P1iLEqlaregwt2zUPXOgYOiL1GeoKUo9Nq3qNuMJfVOcJiHN5dUrPMIEkVbJiwyt5w7
         tPgCEO4y1hNKVkpkvxcDE6zhWug7wt9BW6M7okURC2xy2x1o3s624nISfVcH83CulfS2
         ah/PXElihsgNYfAP6gHzHanXBe6O80DRbEAWvym52LnLgzIUflt9plCPVr+K5bojylyS
         EYTg==
X-Forwarded-Encrypted: i=1; AJvYcCUY3Z9PElODcEyNehTgDB7HwinJBG6yia9Nz09Nlw+JljE6jhmozj83xd+l7ul3O86sV9Xz2Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBAbhd4nJt6u3n+t2oPbdTmmr/0VoSstsg2Phz+BPlz4b8fNl
	03r5VR1aUKKHWybRSqsGz2nzyNlzJrJ73L0LtEV/2pyQiIOV0PWu8de2ndM8/QeHLAAOXDV+39/
	0Tnwh
X-Gm-Gg: ATEYQzzCmaXl8h2/WEcNt/4cS89pKuxzX9N3cBPXAAw8iCEb7DAxYTpJ3lVunoNY+PJ
	tJxEj6nOk5dWSfP1uADfACGD75WCH+F4hnXrDq8lLOZwL1Wg0J6YTBJ2fZAz0ow/9F13dXqB2f3
	DfNsT9tZAxCVH+chbZF2iQ4Ntgixa5+M03MpNXsJlKxyYf3HjbB8c3PGxYykzl7V2PxgzY89HNc
	5aRpDwnbh4uJO1/PwPEluoUmZaBz23HllSsJ7NuxqRiRyw4ned5ILezEKhVtRWSWbewgurtVip5
	scit+F5QilYN4vo3rCZ0c7DI+AyJnhdAKQ/qZG6FDvvmqXduLq7xMzkPrpBhkqjsWp5ozZTp8+U
	+yZQ2iKRriPeQ/a5IcWdGCGMPd5ZJU15ziu/2K3Op+uxj/AmZJAIZB2q3HFVnYx+7BBYcbn8gzf
	llFtSyzIhqGEO3x8R2XN1pOqiC9BfYqg==
X-Received: by 2002:a05:6000:4205:b0:439:8f9f:4994 with SMTP id ffacd0b85a97d-4399dd70434mr10151996f8f.0.1772286555493;
        Sat, 28 Feb 2026 05:49:15 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c597578sm13482622f8f.0.2026.02.28.05.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 05:49:14 -0800 (PST)
Message-ID: <5cbc2f17-69f7-4fad-9e1f-71b11e1b25be@tuxon.dev>
Date: Sat, 28 Feb 2026 15:49:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v2,5/8] net: macb: add XDP support for gem
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Paolo Valerio <pvalerio@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, nicolas.ferre@microchip.com, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, =?UTF-8?Q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260223182632.1681809-6-pvalerio@redhat.com>
 <20260224000844.140431-1-kuba@kernel.org> <878qcgn0av.fsf@redhat.com>
 <DGPORITW7CFW.1DBYQHGBZ8CEC@bootlin.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <DGPORITW7CFW.1DBYQHGBZ8CEC@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262132-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxon.dev:mid,tuxon.dev:dkim,linux.dev:url]
X-Rspamd-Queue-Id: 52B5C1C3506
X-Rspamd-Action: no action

Hi,

On 2/27/26 12:52, Théo Lebrun wrote:
> Hello Paolo,
> 
> On Wed Feb 25, 2026 at 7:30 PM CET, Paolo Valerio wrote:
>> On 23 Feb 2026 at 04:08:44 PM, Jakub Kicinski <kuba@kernel.org> wrote:
>>> This is an AI-generated review of your patch. The human sending this
>>> email has considered the AI review valid, or at least plausible.
>>>
>>> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
>>> ---
>>> net: macb: add XDP support for gem
>>>
>>> This patch introduces basic XDP support for the macb/gem driver with
>>> XDP_PASS, XDP_DROP, and XDP_REDIRECT verdict support.
>>>
>>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>>>> index 708107e47ae3..26b517ed251c 100644
>>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
> [...]
>>>> @@ -2641,21 +2724,23 @@ static int macb_alloc_consistent(struct macb *bp)
>>>>   	return -ENOMEM;
>>>>   }
>>>>
>>>> -static int gem_create_page_pool(struct macb_queue *queue)
>>>> +static int gem_create_page_pool(struct macb_queue *queue, int qid)
>>>>   {
>>>>   	struct page_pool_params pp_params = {
>>>>   		.order = 0,
>>>>   		.flags = PP_FLAG_DMA_MAP,
>>>>   		.pool_size = queue->bp->rx_ring_size,
>>>>   		.nid = NUMA_NO_NODE,
>>>> -		.dma_dir = DMA_FROM_DEVICE,
>>>> +		.dma_dir = rcu_access_pointer(queue->bp->prog)
>>>> +				? DMA_BIDIRECTIONAL
>>>> +				: DMA_FROM_DEVICE,
>>>>   		.dev = &queue->bp->pdev->dev,
>>>>   		.netdev = queue->bp->dev,
>>>>   		.napi = &queue->napi_rx,
>>>>   		.max_len = PAGE_SIZE,
>>>>   	};
>>>>   	struct page_pool *pool;
>>>> -	int err = 0;
>>>> +	int err;
>>>>
>>>>   	/* This can happen in the case of HRESP error.
>>>>   	 * Do nothing as page pool is already existing.
>>>>   	 */
>>>>   	if (queue->page_pool)
>>>>   		return err;
>>>                         ^^^
>>>
>>> Does this return an uninitialized value? The patch changed 'int err = 0'
>>> to 'int err' without initialization. The early-return path for HRESP error
>>> recovery returns err when the page pool already exists.
>>>
>>
>> argh, I missed this patch removing the initialization while rebasing.
> 
> I debugged a nasty bug yesterday, which ended up being this typo
> combined with the fact that we call gem_init_rings() through the
> mog_init_rings function pointer twice at open. Once near the end of
> macb_alloc_consistent() and once from macb_open().
> 
> This bug is invisible because we supposedly skip the second
> gem_create_page_pool() with the queue->page_pool check.
> 
> On my system it lead to the "DMA bus error: HRESP not OK" error;

This is reproducible also on Microchip SAMA7G5-EK with this series, following 
these steps:

# ifconfig eth0 192.168.32.8
# ping 192.168.32.2
PING 192.168.32.2 (192.168.32.2) 56(84) bytes of data.
64 bytes from 192.168.32.2: icmp_seq=1 ttl=64 time=0.589 ms
64 bytes from 192.168.32.2: icmp_seq=2 ttl=64 time=0.629 ms
64 bytes from 192.168.32.2: icmp_seq=3 ttl=64 time=0.550 ms
LDO2: disabling
64 bytes from 192.168.32.2: icmp_seq=4 ttl=64 time=0.579 ms

--- 192.168.32.2 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 0.550/0.586/0.629/0.028 ms
#
# uname -r
7.0.0-rc1-next-20260227+
# iperf3 -c 192.168.32.2
Connecting to host 192.168.32.2, port 5201
[  5] local 192.168.32.8 port 51488 connected to 192.168.32.2 port 5201
macb e2800000.ethernet eth0: DMA bus error: HRESP not OK
macb e2800000.ethernet eth0: inconsistent Rx descriptor chain
macb e2800000.ethernet eth0: inconsistent Rx descriptor chain
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  31.2 MBytes   262 Mbits/sec   14   1.41 KBytes
[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes



[  5]  10.00-25.83  sec  0.00 Bytes  0.00 bits/sec    1   1.41 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-25.83  sec  31.2 MBytes  10.1 Mbits/sec   19             sender
[  5]   0.00-25.83  sec  0.00 Bytes  0.00 bits/sec                  receiver
iperf3: interrupt - the client has terminated
#

Thank you,
Claudiu

