Return-Path: <netdev+bounces-250262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C854D2638E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEC6B302D9FD
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1523BF30A;
	Thu, 15 Jan 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt1r2nl5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D43BF301
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497067; cv=none; b=qhGSFCZPRLddw3br8G5Oqy7K+bA5S0/DK9PNBOter0rOnVFzOBagtVgDr/QNTg3ugCPD+uvCaiXSUx/MVLafq2XgKeYTHlzl8jedai/1/F5ZlsjTIrcMP42Zy2ed4JG5eC07mIUwTbYgrwuG/7f6iXF2nKLi5B9IoPPJKhMvdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497067; c=relaxed/simple;
	bh=z5fuYqtywwL6KOIHKbWzEHmAdjuqly6oA3cwR7sT8v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TojmgdytZJbUkLbJr4QpkSA/vFIfNgmsFSSyR6bTcU/eBePSWQ9LjwOkshI9IN3HeSQi7aHuAlGCTonFs17W9+YzrufKEq3zfi9PQWA21hnepy9l6tV4oOZByfqK/yp3y6defH1Sv1EKoeR533eFM0cMlclWyAayhpI0lH3U01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt1r2nl5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so1045954f8f.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497063; x=1769101863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9zIIkhhFGJW7c5euU+uczxwuqnCR/g7cOorqaRVjc8=;
        b=mt1r2nl5+IcwV4rIclf6O+vfsoItttvYMAwELjX7wAw87RRtgoOW4yjf89VreUeVMN
         DUvrtR/D70+SBDc9heH/xdBvKbODGU113itq08ukub4tw+xmUGwWcQhvsS/yavKIjx8y
         PASkfYCvUsV604SnIoRkl5iKxMvUsKrbTugd7YH3ahhdIWQQnwHQ1c0NgQjcQgRbKuv2
         7EhanVPn/TK/MhaAGM941iuLfLGdB+n9VQzBnIWd0wo7hXd3PVboAUZARPbzFlr0f3XW
         mTrXKtW8TsgnMgSgjAIi7VeQPc9k6LrWVpOEBn+lZbb7YXfAaBO7VVSecu2OIE4EI6IW
         MwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497063; x=1769101863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9zIIkhhFGJW7c5euU+uczxwuqnCR/g7cOorqaRVjc8=;
        b=URRw0gKkPnVpUggtTHvOkK4oJF00YwdMolAWZ+Bk/1SqTGjDe7BSrRXdwFx5DSiCsV
         86HrLNXId8CPzskDMgYjFt8ktFCY/eBBuP/g3R5KU/LNWsbdMebFLB6eK8JBU4/6fCF4
         WsAktvTeWJCc/gNkLzbrEqmmSNM7+IMwmLY0icH92EuRSQStiZs9c6QbxfAO9BgVxehP
         H9/irRUlk5yTS/5us4cQPi3X2OPuu/SarqfFIXLHDX8SdBnFVNrvEFlKl6S/DxcV/R2G
         tD0jrodi6LJTfgaaQ2xEmqMBGSAD7U5/rcsRF4HeGuIoQ9WS2kmbKVGtpPRYKlLG1wmh
         M8Kg==
X-Gm-Message-State: AOJu0Yy6Rc9/o+2DXsaxTrqBVqBCAWPGTBhlI2Wz+lM1CoGKncVoCMBe
	dmKwgroDfL89DSpEhCssuNVubUShJbAr+Rt/egtBSS7T27rm0HQX5gI2
X-Gm-Gg: AY/fxX70D55UXLIiqnE/WyWVtoTa+sKacPIihLXvj8Q67gbCgLJ06MhEYPo1HqNxLwi
	I7N+l8NTKmd8V0tziUe+xT72npyN36FpE/cw2eAsnFdLrnuMFAd9hHDGd8nIyeQYHIQB/gnvU36
	VEDE9woWtn3DrfN0/4aw+7IXq8BFGm4S4/FiCXgrQu2GH+RQm2DhP08c0hUvJZtoh0dZ7LvTRg8
	R8AFm35yD9Fugjvj+UL/ghH1co5Lf3aza2JREp+lfTMBFLofjhT7uItZsytUIcKobM5+rnCEUYO
	J0PS+8CPhnxhEpeInVRHjV3SuiWZbJTzBB697c+HUd2pwHUfs6CgwvsDOrsG2+ILOTN3aIYu2l9
	MqhO1QV6Id6/Y9P7Hp1sO+HCYSk3r3YTfIl2shMBOaEJw9htSljqdEsrah5ZyL1O7B24FN6xW6M
	TUPSelA9GIokZvNcvrF5vXC0Fd+N1fobuFV+nOloFXrV86/juXWZDAKLVywqB14QNqMcbr0a6HN
	fbCalLZ1TWcUGb5WbxLjDnCIp5Ybr/9mxSVAkeFFC+4K/iT6oOALZ4kdQ4px5pWIA==
X-Received: by 2002:a05:6000:1889:b0:431:9b2:61c4 with SMTP id ffacd0b85a97d-43569bc77b8mr74982f8f.45.1768497062676;
        Thu, 15 Jan 2026 09:11:02 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cf42sm104023f8f.20.2026.01.15.09.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 09:11:01 -0800 (PST)
Message-ID: <5c0f28de-41dd-47c6-9b0b-9ea40cbbeab2@gmail.com>
Date: Thu, 15 Jan 2026 17:10:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 7/9] eth: bnxt: support qcfg provided rx page
 size
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Ziwei Xiao <ziweixiao@google.com>,
 John Fraker <jfraker@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Joe Damato <joe@dama.to>,
 Mina Almasry <almasrymina@google.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Wei
 <dw@davidwei.uk>, Yue Haibing <yuehaibing@huawei.com>,
 Haiyue Wang <haiyuewa@163.com>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com,
 io-uring@vger.kernel.org
References: <cover.1767819709.git.asml.silence@gmail.com>
 <28028611f572ded416b8ab653f1b9515b0337fba.1767819709.git.asml.silence@gmail.com>
 <20260113193612.2abfcf10@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260113193612.2abfcf10@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/26 03:36, Jakub Kicinski wrote:
> On Fri,  9 Jan 2026 11:28:46 +0000 Pavel Begunkov wrote:
>> @@ -4342,7 +4343,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
>>   		if (!rxr)
>>   			goto skip_rx;
>>   
>> -		rxr->rx_page_size = BNXT_RX_PAGE_SIZE;
>> +		rxq = __netif_get_rx_queue(bp->dev, i);
>> +		rxr->rx_page_size = rxq->qcfg.rx_page_size;
> 
> Pretty sure I asked for the netdev_queue_config() helper to make
> a return, instead of drivers poking directly into core state.
> Having the config live in rxq directly is also ugh.

Having a helper would be a good idea, but I went for stashing
configs in the queue as it's simpler, while dynamic allocations
were of no benefit for this series. Maybe there are some further
plans for it, but as you mentioned, it'd be better to do on top.

> But at this stage we're probably better off if you just respin
> to fix the nits from Paolo and I try to de-lobotimize the driver
> facing API. This is close enough.

Ok

-- 
Pavel Begunkov


