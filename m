Return-Path: <netdev+bounces-102966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0811C905AA1
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 20:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA1B1C20EAD
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 18:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3A720DF7;
	Wed, 12 Jun 2024 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="DAI75xDf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236AA381AF
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216392; cv=none; b=ZVnq0tV8Z6PPNlcUVctABUhJfCUw6b+9PHoBAJXs+MQcl656QENjdZfk/L2kwESWuEQO8hwqKz0LHaO5TK2eJYSma+UPAv4ALYt0Xrc8rvUICY93zRHA0Qao3QTWlYofgBDEz9QHEkMvMCZZIzK3EX7nNtUX56rEjLjDkGlONRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216392; c=relaxed/simple;
	bh=fDiSdS8TviY3m9vb6hDei78I/cJkKh7pAXoP6EleCB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIYRYQGv9ZDqENYyycV5prW8zOt5mtHa9St1uDDpRVWsUCBJ4SDKlcoHxXGtAF1xdNuabrnt62dFHa1TSivUmlpBHR3c6aQM+yev5ue2DfLEcR2lny/bTogvOXclvmrC9KScxPU8hSjD9OJyINeVPnTTyqeHPIxck47dC1Aw0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=DAI75xDf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-705c739b878so439558b3a.1
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718216390; x=1718821190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/wSXN9xtxb1Wg8dMHhT8nkoAVfsLDw3vD222iizRsM=;
        b=DAI75xDfLHh64fiWRF5D6I63vUbVpqDYIfZll8hWP+fQ3+jQCs5MyLWopa/bm8SvEJ
         9IUNxLxfniae8bR2o9PogYAN2IKgz5hi5LZ8inoJIufUdOzHItLkJUqCgeTwu3736b+9
         PURSNE3dWmt1c6SiPzWCSlYn5/C1qTpp/R7lXSz0HLcn8SevIqT3hU4vcwTPNjInA6Gv
         xDs70SN3LsrDPKRUvXG14ImHayBN1TJnNdqCTUMriBnCxknWnBivlxgzjuTlur+QoW6Y
         uTfr7+YIsw2pXkjW3KdDHCvcL7YrgjkyDrueJI660lhF5yycw8tiUtgDhEzVGkL0aHeY
         tcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718216390; x=1718821190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/wSXN9xtxb1Wg8dMHhT8nkoAVfsLDw3vD222iizRsM=;
        b=nyzwX+fY2NmtawdQCxegL2iosmvRHY1s1nYQ0dVFZ+FodUxRMIgYtHeQSGU4Qx2bWp
         bOzPlb3qxjSso50TaZ77WM9Cv69/Fmi4cjmjlDRq6g8WWWIGEfB3Yh20swP5wzKzltBS
         w1QPOxJKXCU8eMh547wBX7APL6kl+gADQrrV/iDaUuRWH8L64w4oSC6IudPuK11ZuKe6
         Fo5qO1Wvlrxg9b5psCmk46NDAiTefzBfxCY/Vnj+4NfTQp3tR3am7bjd8iWKpCDrNXv/
         DznWGyUpCGnhvZxRbRr4wINMyYAAz6Gsb2+51YuIRuNNm8KVbKSnnXppnRzpH5Bo14Cb
         TLjg==
X-Forwarded-Encrypted: i=1; AJvYcCVzBuaSRhvRFFAQDi2a9zgv0W3P35Se+QgnXKBWmMKKUjrHvKvRoC5DDesVE4fVwY1Zyk96Wx1DnClyqpLFVtJyOUFxBOxc
X-Gm-Message-State: AOJu0Yxwqtrlfd7ETrZfLrszX1e5Hi2e9f2tVYnd+3Nkxc4RpMaugZBo
	gGdInOaRRsLJBbaXidqZJE6iLjXbgM8HrEiGL7rqdDUkelTsm0Kx6GjsUCI1al0=
X-Google-Smtp-Source: AGHT+IGM/PO044XPIsZ2DPcMubAbSVZ4Tvn+NeoxU69RCtBXz/H+dLA2kcTbPhmiHywKK2V+9/eVnA==
X-Received: by 2002:a05:6a20:7346:b0:1b2:b137:f864 with SMTP id adf61e73a8af0-1b8befda665mr690682637.7.1718216390233;
        Wed, 12 Jun 2024 11:19:50 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::4:71ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd372dbfsm10955375b3a.38.2024.06.12.11.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 11:19:49 -0700 (PDT)
Message-ID: <80a1ea79-738d-404d-8b50-cc5eb432153e@davidwei.uk>
Date: Wed, 12 Jun 2024 11:19:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 0/3] bnxt_en: implement netdev_queue_mgmt_ops
Content-Language: en-GB
To: David Ahern <dsahern@kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>,
 Adrian Alvarado <adrian.alvarado@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240611023324.1485426-1-dw@davidwei.uk>
 <e6617dc1-6b34-49f7-8637-f3b150318ae3@kernel.org>
 <b2dadafd-48c3-4598-bee5-a088ae5a4bc7@davidwei.uk>
 <1b26debd-8f18-46de-ac6e-05bff44a9c52@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <1b26debd-8f18-46de-ac6e-05bff44a9c52@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-12 08:52, David Ahern wrote:
> On 6/10/24 9:41 PM, David Wei wrote:
>>
>> This patchset is orthogonal to header split and page pool memory
>> providers. It implements netdev_queue_mgmt_ops which enables dynamically
> 
> Ok, where is the validation that these queues must be configured for
> header-data split to use non-kernel memory?

Any validation would be done outside of this patchset, which only
focuses on resetting an Rx queue. Reconfiguring page pools and HDS is
orthogonal and unrelated to this patchset.

The netdev core API consuming netdev_queue_mgmt_ops would be
netdev_rx_queue_restart() added in [1].

[1]: https://lore.kernel.org/lkml/20240607005127.3078656-2-almasrymina@google.com/

Validation would be done at a layer above, i.e. whatever that calls
netdev_rx_queue_restart(), as opposed to netdev_rx_queue_restart() or
netdev_queue_mgmt_ops itself.

