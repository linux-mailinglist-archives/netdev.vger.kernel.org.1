Return-Path: <netdev+bounces-247431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E3CCFA209
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 19:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E315E305FE17
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C35357727;
	Tue,  6 Jan 2026 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zIp2kXqo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DA7357729
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723600; cv=none; b=a60Ksebojx16kVD53SN+t0C30nLIIBBksWdaOMGwQrHWdQD3SJLxaW5X0BPes0yQGcGpjKQ/Un1c7w8pExCBYLe2+a/Z1ZIwKtLgnvio348R49Ao+19h/9jVaf+FLBipyEej2BRUlKmhKRnWs9UTN7f9MAipbfK2VpWP/T03iJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723600; c=relaxed/simple;
	bh=kdKkRYYcwiM8yrP5/6IrbqbM4nyShOojwZ6pAQHliiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQ88WFPSwgBLYBsFICnzNUVsGDYiWMzjrFRwwU8n9GwC77LG5NCuz1/UkfcW3SQcOlTDN3f7J8lkzBe8pfl7FI+akQLEpnkYpChFzGW8UqnaJ5DEvlSR1QyVp+oLTMhBWVpkuQh03r1nET37x6szTsVd3dGQrvE3yoeACywATx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zIp2kXqo; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so1159668eec.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 10:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1767723597; x=1768328397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trT5e9qmw42xqqlHYRkk0Z7FLehgd4RFh1ytKbQv/9I=;
        b=zIp2kXqosrutrl5fQVVnGm4WgMgu2if9KlcafWRK1qHUFb01Cj7g+cgG/6n/IJI5GI
         ey6N/69b3TKsNvj+AxWMCJpDCHn5SPHdaULjZWsshzuxELmGOgTHlxiqZUvn8ZkLrCp5
         NkDSXFPUSS2uN9htamIzPUWr6qDL579bG5c01lT+7OomzLeInZBupLbcQr6Xu6TfCX3y
         76Uv7T6xzHgmVOO230HBbu12/i7NdURtLhGEZPZVCjlyZKSSJXIyQ6H10YED+tPpLVFL
         tHc7/zA8P1c99nK/ZEnFzWHfK1HMrz4X7aitjLSkJ9pPcFVGIaq7IH3r4nstCXSIjFk+
         9+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767723597; x=1768328397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trT5e9qmw42xqqlHYRkk0Z7FLehgd4RFh1ytKbQv/9I=;
        b=KAobVkF4dJJDtbDfqKYh+40TJT1Ij/A5WRJs0PSADML02rCOm+INVjDu/6vLqzz9YC
         VnbWqekUZzKaS5RVHQTRLjt26R+D8K2qQn6RL80UBfoXknFKCNsE7n7E5mPYryJ/DKmV
         eE0gVPRGgIL7JdZiPpVLJ5dAF0WgRblR4EFKtmzME0e/BD9YuKMCVmMyV5kBhfNbKSaD
         5SEukf65Xx3YuoidwpX5MJhqzzUegEGZhWj8GMEbAMJuEEQMfsSD4dPk37Q3X+s2Mel1
         K+ABrgp7zLXs2F+gyiHvpjWX/xRVslQzopDH3CIpCQ9/dDzW5A7smblZQNQ7ZHgOVxyr
         tRGw==
X-Forwarded-Encrypted: i=1; AJvYcCXJYWvOlrbssYzlVeEDyQw1tHgRuSAe1YS0h8P76y//CRFULlCc757FPz/pmUauLUQqw293i8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCais2d9CX6oITPgcTgN+lbQG7m8ygfWY4w4GvZFGPnZh31qWh
	616mMV6MuaD1wIYfnUdUnwsq7d+fltQHXD5mSY7xMN3xaqMND3/GIda5CO+WvZ6Nxw==
X-Gm-Gg: AY/fxX60UpB1aNc7La3TPi7ihIN9baAG052M23CBb+eneAHo7wOKlVOLTz3Mz8QACK3
	88vMMeqQXf2ZuENBlyXWt4A3JhqqUQUCgfo6JwED3wDmicjL+IkNq4yRREK98fUgWOslSYDuN+X
	LiPpVKQ4kFhSghAmiOnEY3/HdB0YR2WaHs8UXIg4TCIfZWKbLlpsUofTSmfXhl3HTFmzqawLV99
	kW9TSKobLXKlWCrdJxaSgEhBbbdPE9nWC6FBTx8zvAAY/wT77svTS8CkTBtJT9baK/l7dqGqrBm
	NIujMnKfZ6iVSkI07Z7NZs6NqCw4BrFwLJaK4XwH0JDZDzqNiiQ0vmPcoKaGU7IMlVxx2rMI/F5
	tdb9QXQB37jA46qKPO/9x/dWYUTrgypjg35wpoPs/j7PcuD+Jlk5nR0qGoDPL2dN/hvmTK/DL0W
	6w/G7y3WNj4HwfmM7mAlJroA==
X-Google-Smtp-Source: AGHT+IHdM+Pe2O19qzx4peU7mNXEr2NTKva0bAIMrxBULdr3+Sccns0d3fmGH0lYFudKBTMf0q+vJQ==
X-Received: by 2002:a05:7300:2319:b0:2a4:3594:d54e with SMTP id 5a478bee46e88-2b16f906c1bmr2704088eec.27.1767723597459;
        Tue, 06 Jan 2026 10:19:57 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::2000? ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706c503csm5244344eec.15.2026.01.06.10.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 10:19:56 -0800 (PST)
Message-ID: <1cacbd67-7d09-4ddd-8762-8be3c238efa9@mojatatu.com>
Date: Tue, 6 Jan 2026 15:19:52 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 6/6] selftests/tc-testing: add selftests for
 cake_mq qdisc
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org
References: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
 <20260106-mq-cake-sub-qdisc-v6-6-ee2e06b1eb1a@redhat.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260106-mq-cake-sub-qdisc-v6-6-ee2e06b1eb1a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/01/2026 08:40, Toke HÃ¸iland-JÃ¸rgensen wrote:
> From: Jonas Köppeler <j.koeppeler@tu-berlin.de>
> 
> Test 684b: Create CAKE_MQ with default setting (4 queues)
> Test 7ee8: Create CAKE_MQ with bandwidth limit (4 queues)
> Test 1f87: Create CAKE_MQ with rtt time (4 queues)
> Test e9cf: Create CAKE_MQ with besteffort flag (4 queues)
> Test 7c05: Create CAKE_MQ with diffserv8 flag (4 queues)
> Test 5a77: Create CAKE_MQ with diffserv4 flag (4 queues)
> Test 8f7a: Create CAKE_MQ with flowblind flag (4 queues)
> Test 7ef7: Create CAKE_MQ with dsthost and nat flag (4 queues)
> Test 2e4d: Create CAKE_MQ with wash flag (4 queues)
> Test b3e6: Create CAKE_MQ with flowblind and no-split-gso flag (4 queues)
> Test 62cd: Create CAKE_MQ with dual-srchost and ack-filter flag (4 queues)
> Test 0df3: Create CAKE_MQ with dual-dsthost and ack-filter-aggressive flag (4 queues)
> Test 9a75: Create CAKE_MQ with memlimit and ptm flag (4 queues)
> Test cdef: Create CAKE_MQ with fwmark and atm flag (4 queues)
> Test 93dd: Create CAKE_MQ with overhead 0 and mpu (4 queues)
> Test 1475: Create CAKE_MQ with conservative and ingress flag (4 queues)
> Test 7bf1: Delete CAKE_MQ with conservative and ingress flag (4 queues)
> Test ee55: Replace CAKE_MQ with mpu (4 queues)
> Test 6df9: Change CAKE_MQ with mpu (4 queues)
> Test 67e2: Show CAKE_MQ class (4 queues)
> Test 2de4: Change bandwidth of CAKE_MQ (4 queues)
> Test 5f62: Fail to create CAKE_MQ with autorate-ingress flag (4 queues)
> Test 038e: Fail to change setting of sub-qdisc under CAKE_MQ
> Test 7bdc: Fail to replace sub-qdisc under CAKE_MQ
> Test 18e0: Fail to install CAKE_MQ on single queue device
> 
> Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

