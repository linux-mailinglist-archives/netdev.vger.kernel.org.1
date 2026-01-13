Return-Path: <netdev+bounces-249416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178AFD18296
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 441623007F3D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B7C3806DD;
	Tue, 13 Jan 2026 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRXR/S1S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557F34575A
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301316; cv=none; b=ucwB0jKDXqP5uAHKsGvRpJ6zGbdotYq6yY+TGxUrpYyp19znU/fGQzdKJLgz0TufxI2QCORNS4a4pEwNWBMInHv+GcyQ0nUTcvyO7YLyb2hHLaTtGK+7gd0k7m8chqZ2huyYCW4DQ8V33IU0QZOGGRAR+QJbL5Lr5JWHbYVAylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301316; c=relaxed/simple;
	bh=HVWq/nMqCWEx4KqTDxex3BJqfz0Jbfe3bSlD+3srwzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggTx6IC0KgzRnNuIv/AiKlrQ0CuvpAKEPd7vbxHROdUv2xb8GrMQlGtDxXO4XbsGMQspSuoZO+4uZ80XE7LJl9nv8XZIpvkBD6J4UnzMLqARkRDUzfpN7XXCbxyA14qmFjfP25TtLLDeqFLwZomJzlg3SZC0Cf46Ld0GA93IAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRXR/S1S; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fbc544b09so5879805f8f.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 02:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768301312; x=1768906112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JIXnem9PesbM4LOcpc3aqv8ZBT0fEVIpmQqCM7UApXg=;
        b=GRXR/S1S6o/2Ranq5ayXSyqhYVV8bg4+5JdPrIphjLLTHJFc1O2JOq2VCNapLtAJQC
         N6ew3TpIyyO0Juxx46/LTt67OuI1/+NPG1PDDhXfr4KXRCWs5VHyDH0eFMJO14Q1EJ1K
         nA/u5cGuLJJtr/IQRu4mxaqHAkiHxEMXyADjg1C0uBBWKI2C3KgQio/nU57qEgxlICp5
         x1ME/NRHAPxue8p5TkkuxhWLz3oiK+AKebPlqbFYY6SUCxgHo24GC+iLEQJT67FNUJEm
         ky1cwJd3rMdxvzzegaCRGwttKArdIByIKP9ze+XzGknlHB/zXf/+VCbUBBs7dw0PhnL5
         qDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768301312; x=1768906112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIXnem9PesbM4LOcpc3aqv8ZBT0fEVIpmQqCM7UApXg=;
        b=LLlbyRP6aqgcGZE3jpLm/fbF5sis9VZcA2r6Uei7UdvqDcegCH7qtN6OotWVQxkLgl
         j1oZ/gjjBae+u07DrdTPNNIC6FrW86meK09ERiaR2yk9qyWDf0CRd/EWzYYKnBFAJJqf
         jhQn087w9UxUM6I9NjmH3+rDpCjzw09FY1kjN0y5O+niz5SXX5AcYqB8fVZyd0efpnxO
         td6nZ09HWYMAJHYEC4QrnzznPlj0r6YM8BPAIEmi3f8r2THUeBM851V68B8SRjJ7CP1k
         oXheo0wmjRDmJCad8KLGl0fbC8YnlCdLoNYEykAMcZgmCATcYh6a5tZRCKN/dgCSd/It
         bnzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCMqtS4UtGDTiS4GtEvHg08m2pTSAioNbieDwrUlfrAJBShxLL+Vhe9KJNl9XNYa0HFiUwsbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVIovhKeBRD3M+9SrzZpWjH/XXfNrHvAp36tQBYyMcV3HbfIP
	Zkw2ZGgliAcaxNVQ+WoAkxluyjRrQ3zijmf/iE+P6c0+6S+uT3SZud6W
X-Gm-Gg: AY/fxX5gDyPWhBpsldHOOFQIS2J3Xf55oe3om2hjnGXSh6a0fdAsMT2uxpzq1Jvnw5A
	qXn+C3iJGebGGN4o7CXA4YYpUMMWFBFowja/WffUewqTnjTpGbVx4OYiXTNUdIx4uykKEiykAkn
	8IjXtncjnaHNFqlKoNGuGkuCpjggntrnlNd23pGgJFQwRdxbsTvSihlkXOnhz2uBPTv3WSIpZ0t
	BVPGbPGSU7pwiViE2Pa9eHuw4Q+BGX+3UevDiZXJv5bWzjAmMa/QSkiGhfJxJbgtGWYX0D4cT/0
	5UCymFfUEmBkP9bINizM5pCzEMGcv2pdKzI5KgTxDiObPler0rw1Gl0TF1pButX1xybkQrEImzv
	+CnmwFGd+Ae6pinlF6a8D6B0TorPKCt7Tv1gB9I9I90k9u8v+AcvJ/KCTz4RhAEWWAIFMNyAT7F
	eOt9H5ZrMBozhZpz5J2oJwmRjsnHyOBs18b/frii5FvwhUmjU1XZLKsw4ZblFSV3kPZ81YTg4xt
	BKa1s/pu6kNEKSqtoJegwQzk3x9L+8DgPQhc1pJ38pft65ZsRmzQ7F7e4+pgfaHqA==
X-Google-Smtp-Source: AGHT+IGJu2DfHIhwL2Wsz6KoyIUAUdvyVOnU75RxhvIHwpjQxcQz5RKKCJsMOQA4l3p4Bbb6eGcwyg==
X-Received: by 2002:a5d:5d81:0:b0:430:fd9f:e6e2 with SMTP id ffacd0b85a97d-432c378a9b2mr22136397f8f.9.1768301311656;
        Tue, 13 Jan 2026 02:48:31 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dade5sm43860084f8f.9.2026.01.13.02.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:48:30 -0800 (PST)
Message-ID: <a3b10677-a159-48dd-b45c-b78aed94f354@gmail.com>
Date: Tue, 13 Jan 2026 10:48:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 8/9] selftests: iou-zcrx: test large chunk
 sizes
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
 <bb51fe4e6f30b0bd2335bfc665dc3e30b8de7acb.1767819709.git.asml.silence@gmail.com>
 <6d4941fd-9807-4288-a385-28b699972637@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <6d4941fd-9807-4288-a385-28b699972637@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/26 10:34, Paolo Abeni wrote:
> On 1/9/26 12:28 PM, Pavel Begunkov wrote:
>> @@ -65,6 +83,8 @@ static bool cfg_oneshot;
>>   static int cfg_oneshot_recvs;
>>   static int cfg_send_size = SEND_SIZE;
>>   static struct sockaddr_in6 cfg_addr;
>> +static unsigned cfg_rx_buf_len;
> 
> Checkpatch prefers 'unsigned int' above
> 
>> @@ -132,6 +133,42 @@ def test_zcrx_rss(cfg) -> None:
>>           cmd(tx_cmd, host=cfg.remote)
>>   
>>   
>> +def test_zcrx_large_chunks(cfg) -> None:
> 
> pylint laments the lack of docstring. Perhaps explicitly silencing the
> warning?

fwiw, I left it be because all other functions in the file
have exactly the same problem.

-- 
Pavel Begunkov


