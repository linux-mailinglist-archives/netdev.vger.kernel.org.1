Return-Path: <netdev+bounces-140730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B56D9B7BED
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A51428262B
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA9F19DFA7;
	Thu, 31 Oct 2024 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="XZ93d0Ep"
X-Original-To: netdev@vger.kernel.org
Received: from antelope.elm.relay.mailchannels.net (antelope.elm.relay.mailchannels.net [23.83.212.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5BF19D89D
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382170; cv=pass; b=cmbWLJP78Sdccit8/wO+Ah06Nwl4r5bLoZXlAscnxauyRiYHLg1ku+LcTQ2XtTd7wpAw4KaBwnphzcHE4+xonKX0dtFfyo3Tu2L3RWSR6+O4nrG6RgXa7NWSnOaCqNYiMBgAElh928JjLQfuUJ7oOyU3YmekBViLlGmkxRohglo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382170; c=relaxed/simple;
	bh=j55Rm5Pt5e4EzAS5v0eiFuXVhv+4pTM57AbCjJPPrrg=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=GfqocNtxHLZAlPBCJU+y08ClzlhlaIC+qHi6IxJ7NkNKBonfa/UGb5VTV1jp132TLoF87zLDNizlJ6U6DW/EwuJOKDRcV5NRyv4I48nwF8wEdLHJ2gIaDHQT7+7b3lgAw+DNI/CoNatEMS4CKh+tN03u3L/WxMZ5WhUmoJgqpX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=XZ93d0Ep; arc=pass smtp.client-ip=23.83.212.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|arinc.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6DF417836D6
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 13:35:44 +0000 (UTC)
Received: from uk-fast-smtpout9.hostinger.io (100-102-250-142.trex-nlb.outbound.svc.cluster.local [100.102.250.142])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id A740678362D
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 13:35:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730381743; a=rsa-sha256;
	cv=none;
	b=YxTWttwF2fG9zl0vey7ZsLk6Y0AsArC0EmE/wDhukO3Q2lyG/cg6/G6olP+iOlS4inT/5A
	5GZgQV9lyuX4Lht2HcxpfgocU4Bbx5FdOasFeTnkX+bbu4ort9eHLs5302QBt5h9hU/3S/
	6t99NjXo/MiTTMAbpXrJqeOUjbV7ije+Ouoep6PJaHns3VXH/Od4d+Jt4T9/d2WZbyDsNG
	RTzl0Nem4j2Y8vY32cZBmR4vH1iTsQxWJBerwzob79j4Wse3NPB0CTRGs9TTuiz6adydMJ
	WCtKnlaaa9YJfvuiUPeSlDf2VtPfTSifl1kpcsIGS+TA3gbWpexgGFrAHUgp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730381743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VA2D/3s3T/BEXi5y4Fa4JGpA6vR01kfLSIvpX9EDjM0=;
	b=Xm9oiRyWzzju5a3XgqtIELxw0cwjqKIgMb5D9BJmEkHWFXxyyEMfPH/hlLLCNTZ6Kz1wzw
	amhkdaFkR4an6VUpxxz9qmtq4LxCXgjymMgic+3T8cQVMK3KoVeZO4ZEfgoy742K6zDJwN
	KjMCgzy95XDqrkOmwJejXX9nczQ9YjblAlOsiJbBxFDpdYfqhzrsKiBcVLviaBoCAiEJm2
	09zCrUtWp6q4SZMW94JQqj1xzRW7TqmbcRhU2NbbfVyaSPf9aHFxkC66xTA/6NUy7iREMU
	taRdsBNxuGTPn4B5gqYJ+VvxWEP8GTk4rjFdgbKtbITnTC2FC849+J8dFVaKpg==
ARC-Authentication-Results: i=1;
	rspamd-77cfccfb8-gmr4g;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=arinc.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|arinc.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|arinc.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Lyrical-Versed: 2595bb2b0f6dbbfa_1730381744176_3768256655
X-MC-Loop-Signature: 1730381744176:2728131966
X-MC-Ingress-Time: 1730381744176
Received: from uk-fast-smtpout9.hostinger.io (uk-fast-smtpout9.hostinger.io
 [31.220.23.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.250.142 (trex/7.0.2);
	Thu, 31 Oct 2024 13:35:44 +0000
Message-ID: <d2776a19-5176-4ce4-9306-273ec7cda0a6@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1730381741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VA2D/3s3T/BEXi5y4Fa4JGpA6vR01kfLSIvpX9EDjM0=;
	b=XZ93d0EpvzYzHqsXjJbn3ujqnNXJ6i58bnSgHu+5Vj7mGJdKWQxTLBlxpOs+cHwM2O/Q9v
	GcaVm8Ha71r5FMWxOUY13wv3gKPvU7eeGaSKfCmNZA9CT6PfodxwJoJryqNRu+eSwXld8e
	naB/9gn4qYMM4MqG6oYcZBEuxVVIJvWpZ3rAI6LXHHCG3EmPMxYkUqT8cISnd4z1E2ynMI
	R367UCo5Y0YcG2k+KtUa4K5dslTBvxIZpbjk7HzRAIVIl1YxHKgmPBDchgwnJKHGcUyk/2
	+yWH3IjIhcuHu/8+/OAxAZBQEvg3ml71p3YbcKHVqNsjSsq3JvICJC85i/SBRw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mt7530: Add TBF qdisc offload support
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241030-mt7530-tc-offload-v1-1-f7eeffaf3d9e@kernel.org>
 <a66528bd-37cb-46b2-90e5-37b10dfa9c78@arinc9.com>
 <ZyM5CPfQYHc_Eolh@lore-desk>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZyM5CPfQYHc_Eolh@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 31 Oct 2024 13:35:39 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=ZLWFmm7b c=1 sm=1 tr=0 ts=672387ad a=aGj/nXfi4qz2iMxz7h0kJQ==:117 a=aGj/nXfi4qz2iMxz7h0kJQ==:17 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=LYXDv5rQIZ189asnIbQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-CM-Envelope: MS4xfCfguuhZl9jj8TTlQ0BBGoVE4NCQHUKSMlnIjPUdQpeXnVRPJJIzY/PL1QnOcPwa9fEB9GoRLsmv6tlPeU1OUnQUyhOnssZj8K/3Jqf/y8j6GvIWThU9 6tNuW6h+uxTgOqQnS9GrVdB0FQUTsyIRpdf9//BYkD3Y1DubfPHmlWJBH+B9NeMUgXZdGlyryRWRtK1p2x2iUK/NRGLEK3MVHixjsSzi6BVTJ9oFC7Bymcnp jRStttJLp7W4KlV1OGSmqHM1vr5MxOGbxKKPaTQ7ErI60Tv2+vEYZDk+QXMAqzZs3VFeUUNxuydKwCv98dbMhdFdFr7Qv1xXDWlP/oncRWURJrBh7vhy77Qy 64jbcJph/3Lypl+8Y3Xh4pQE2igSoIQyyK3m6f18gUb1g/ReIlLXMvh59y8cXe6NYCgAnoALEgrX9Z0x5cYvsdqifryrK9jYPjYHJJud/dLJWyb2YnqswX8a SJD4+BitVvWpeMuzq+P3wQzAZMmFAHvJVGHmRb+QsSXW5re1D7GbTgoX3vvXBSnprKM5RQf8iSZBFbQPFN6OAHRH7vnkTf9C7mCu3gm7sNL9QlR8z6HEsCFV PwZ8JaOcXr/qVujUKBsqlZI5sl8aAwyrPfdJ99rCtAqMY5hU7GYRzGotqr6ZPHh7a0AWjGSpWfuVNJpPRRLjEcqRusArVz2Tj5uRtSBdqZP4ecpV96ueywVV 0zhzQK/Uzk8=
X-AuthUser: arinc.unal@arinc9.com

On 31/10/2024 11:00, Lorenzo Bianconi wrote:
>> On 30/10/2024 22:29, Lorenzo Bianconi wrote:
>>> Introduce port_setup_tc callback in mt7530 dsa driver in order to enable
>>> dsa ports rate shaping via hw Token Bucket Filter (TBF) for hw switched
>>> traffic. Enable hw TBF just for EN7581 SoC for the moment.
>>
>> Is this because you didn't test it on the other models? Let me know if
>> that's the case and I'll test it.
> 
> yep, exactly. I have tested it just on EN7581 since I do not have any other
> boards for testing at the moment. If you confirm it works on other SoCs too,
> I can remove the limitation.

Seems to be working fine on MT7530. As we have tested this on the oldest
and newest models that use this switching IP, I'm going to assume it will
work on the other models as well. You can remove the limitation. Also,
please change MT7530_ERLCR_P and MT7530_GERLCR to MT753X_ERLCR_P and
MT753X_GERLCR.

tc qdisc add dev lan4 root tbf rate 10mbit burst 10kb latency 50ms

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-5.00   sec  5.88 MBytes  9.85 Mbits/sec    4             sender
[  5]   0.00-5.00   sec  5.50 MBytes  9.23 Mbits/sec                  receiver

tc qdisc del dev lan4 root

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-5.00   sec   469 MBytes   786 Mbits/sec    0             sender
[  5]   0.00-5.00   sec   468 MBytes   785 Mbits/sec                  receiver

tc qdisc add dev lan4 root tbf rate 11mbit burst 10kb latency 50ms

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-5.00   sec  6.38 MBytes  10.7 Mbits/sec    6             sender
[  5]   0.00-5.00   sec  6.00 MBytes  10.1 Mbits/sec                  receiver

tc qdisc del dev lan4 root

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-5.00   sec   467 MBytes   783 Mbits/sec    0             sender
[  5]   0.00-5.00   sec   466 MBytes   783 Mbits/sec                  receiver

tc qdisc add dev lan4 root tbf rate 11mbit burst 10kb latency 50ms
tc qdisc replace dev lan4 root tbf rate 10mbit burst 10kb latency 50ms

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-5.00   sec  5.88 MBytes  9.85 Mbits/sec    4             sender
[  5]   0.00-5.00   sec  5.50 MBytes  9.23 Mbits/sec                  receiver

Arınç

