Return-Path: <netdev+bounces-285031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ni6MoWs+2lkfAMAu9opvQ
	(envelope-from <netdev+bounces-285031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:03:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 386914E0764
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 006533017BF4
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 21:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423CB34CFD6;
	Wed,  6 May 2026 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7m4WjgK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9642F745E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101377; cv=none; b=BcOloWWCf59ETQebnM4mB6WS+JvenTpZTfjLAUSng58Ca0LTe7vklKRiW1MGChdRUd7tulRHjEC/ebK83qa/MhZwjroUr6fjYamek6m/4tmp6shwj3TugzDHhpmRWUt6r7oI1kUA7WaD1CLI9cy6fvuz+1BYqNnWZOtEeqZrEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101377; c=relaxed/simple;
	bh=kg/hoNnYvD3Lg0Xfq1UWoozqvA/2ZKkAPtddRVGs3nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AK+k5tEnC+CqxpYjJis6gLSM11QdwsQ4ejeJXypRQ94Ccq9H4LUj4tT6L37bpi5xSGrNLrwo7buygSFOtb/9cUhTPNBZPcZs4V/QiibzKEwhcuxHLFYzanDuZnlsF3NBj2H1ITuiFmLRgNM1s7Hk3ymItuySvhq9w+t+RtgHpuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7m4WjgK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso136009f8f.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778101374; x=1778706174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLAkvKvrV0HB13/SHs9V956CFSV+FWTQd1z6gI/iQwg=;
        b=P7m4WjgK76otDKjP/r6fNKWaMMorEhEHwFk6kSUMWcnR8FOFFSMpTXJKlYeCIedJXo
         tFSpT1QclVbwtd0eGhLJ/fmbsoc0wKT+ly18JqKzUF6g9wTU5Zshgv+v8R01AJIbirhP
         FMNIfps7G5AavEXATuMbeopUbj+2vvfbMw6t+OpcO4g9lmjHVS35ItD6LZAoWL9Ww8ye
         f7KokI5N5njlJWzVs8bc09x3Fv/E0q+UTWbzi6cwZnxzR0j69uPfqn5HWf3PMsFG42CE
         xUTprdejOGbolhpSuHVIdyCdYW3u1s2y1nwX1HDzlca6RVxYfoUmSFi18SrrIbVZcTzW
         u7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778101374; x=1778706174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLAkvKvrV0HB13/SHs9V956CFSV+FWTQd1z6gI/iQwg=;
        b=LEe6Q5i+Adbkoz+8wPHisCGEHC/CfQs+qFf4FwYwYqIsEZPciy39g//xCoA6mBzjYZ
         OuL6OQOQbbEEuFP2Wg5uepXmQTivqgKu/i3wYgfAU+mcm9ixKT420diGU1lFcglsu9Db
         BIAdxt/dsbw7JB3jONBHeGLhNT6FIsvTYwBxzGAbSt+giA/NBaLHezTemawcJNgJXTAw
         v9mIpItocbuMd/2L59JSvlVv0cNid34WYGYts9cG5Smzyj/9SNfjcqN5OAy1/QTYxOYB
         rtWjb9DnvYA7tALuQli3kp8oe9s4d0r6ewb63+f2cA9D3ypSTxJmsjzWxg1WSkvFk/9+
         X3zg==
X-Gm-Message-State: AOJu0YxfC5tlxfZUg2op9kHu7t2fM34HLjSdfChqxMO9WO4qR2d8InBO
	nuDnx6fRtaDvHlWnSnfocpBnyQwg29C2PP25tWQ1Ij4hZlgUMbCPsGOc
X-Gm-Gg: AeBDiet0+zUzIF5cBS+FUCHhJkmD8Y6lOqGfEQBa7eeebOTF49XKDXnQM+4KbNR6fTH
	kfV+ZWaQNLFBu/rhLbGlmlp/gqWcPp5aZITL7rQrQ+jGGoMlERfAwFmM9PtQX2MR0Xvw0fPQqjf
	Tz5vSgRnG2nNVpERkAz/I2U/qWFRUVJu4f5TRcuYKTqh2+i3f4WTfmnp5YRD8pqmuaF+ohgQBf/
	Q/5AaSwC+FXSG4D7d4uB+c4tvm9tJb7bcSDw5dZUmRv0gm5TEh+n5RnfxA5HtGq6yPjhk9hBnfy
	Ej6qekNAabC0jJ5cxFDnkNYTPH5M1WZi4MIPMghlgRmerllhyoXb2X+7ijjeFhG3D50PvNWth3J
	A0me+pcbhERr5JcISqz8nQh3lGuGlc7xQGgbmhjEpqWBnILbVz/M07sM0NFclSeYG2wdMwO2izE
	2wDiEEnPDqgUP/pmiswUJ/UvMliR8GG8o+d5Z588/pXoZDnKKFJr1rFxRRpAnhdtjMETp54Q204
	jZZfrBZkgKDIfH0IHHaXCfVeZOdsknLcOR0UY7n4sgZwFBD821zXgUZ3/QZBG6iVbQFSMaQc8ez
	+rt2gcCqsdI=
X-Received: by 2002:a05:6000:144f:b0:441:1df5:480c with SMTP id ffacd0b85a97d-4515df67132mr8085180f8f.42.1778101374001;
        Wed, 06 May 2026 14:02:54 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f24:7800:4039:5b18:9ac5:4054? (p200300ea8f24780040395b189ac54054.dip0.t-ipconnect.de. [2003:ea:8f24:7800:4039:5b18:9ac5:4054])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505285e765sm14582738f8f.10.2026.05.06.14.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 14:02:53 -0700 (PDT)
Message-ID: <bf301c5e-f6a3-459f-8eaa-a4032aaa3aa3@gmail.com>
Date: Wed, 6 May 2026 23:02:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next v1 0/7] r8169: add RSS support for RTL8127
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506081326.767-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260506081326.767-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 386914E0764
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285031-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]

On 06.05.2026 10:13, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch series adds RSS (Receive Side Scaling) support for the r8169
> ethernet driver, specifically for RTL8127 (RTL_GIGA_MAC_VER_80).

Series adds RSS support for RTL8127 only. Is this generic enough to retrofit
RSS support for other chip versions like RTL8126 w/o bigger refactoring?

> 
> RSS enables packet distribution across multiple receive queues, which can
> significantly improve network throughput on multi-core systems by allowing
> parallel processing of incoming packets.
> 
> Key features:
> - Multi-queue RX support (up to 8 queues)
> - MSI-X interrupt with vector mapping
> - Dynamic queue configuration via ethtool (-L)
> - RSS hash computation for flow classification
> 
> Experiments:
> Platform: AMD Ryzen Embedded R2514 with Radeon Graphics(4 Cores/8 Threads)
> Arch: x86_64
> Test command: 
>   Server: iperf3 -s
>   Client: iperf3 -c 192.168.2.1 -P 20 -t 3600
> Monitor: mpstat -P ALL 1
> 
> Before this patch (Without RSS):
>   Throughput: Unstable, fluctuating between 3.76 Gbits/sec and
>   8.2 Gbits/sec.
>   CPU Usage: A single CPU core is fully occupied with softirq reaching 
>   up to 96%.
> 
> After this patch (With RSS enabled):
>   Throughput: Stable at 9.42 Gbits/sec.
>   CPU Usage: The traffic load is evenly distributed across multiple CPU
>   cores. The maximum softirq on a single core dropped to 63%.
>   
> Other Experiments:
> Link: https://lore.kernel.org/netdev/0A5279953D81BB9C+f50c9b49-3e5d-467f-b69a-7e49ed223383@radxa.com/
> 
> Javen Xu (7):
>   r8169: add support for multi irqs
>   r8169: add support for multi rx queues
>   r8169: add support for new interrupt mapping
>   r8169: enable new interrupt mapping
>   r8169: add support and enable rss
>   r8169: move struct ethtool_ops
>   r8169: add support for ethtool
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 1202 ++++++++++++++++++---
>  1 file changed, 1080 insertions(+), 122 deletions(-)
> 


