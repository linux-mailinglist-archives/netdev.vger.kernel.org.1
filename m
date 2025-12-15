Return-Path: <netdev+bounces-244855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A2CCC000C
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 22:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0F583000B30
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 21:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4074C32E13B;
	Mon, 15 Dec 2025 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcVsU1eW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBB22EDD62
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835116; cv=none; b=O8niK9ip644Nu0lbi2BcEQYUToQqjjm/8+2dqAYmUzlJ5foqy1VNYVVEXAq2AEIcLDv3GMTFKnMG95VviT8Aq0h5fExyT/eGDsBChfbYmLfgYT9Bgmxvg4TGnJqq0ztXA07S7hEuFYsd5iJIz2SuoIHKUDTverwmMLqxfUBvyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835116; c=relaxed/simple;
	bh=9w7xCdrO/3oqLfn1oVLYvp4Vo/5UgUWO5sZsh5bnAlQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Pqfw0m2mHlzI/k+YDXyF1F8gYuZW3gXcZ+IF3/AQbjQ+8gmsVzSNifJl9vhFeJfW7BYp2dyGl0o/AHuQEbjKgZG/Bu4BseZeoKAIaed29snHF38NMvdRv1U6mTChTSYRG4i4BUgRxnA2CbZNWwHhUIF3DAHQaNVxgj0j8IPnqxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcVsU1eW; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78e2fe1f568so35050547b3.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 13:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765835113; x=1766439913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rb0PTJE78xnW+sNXT9skSWBiTHzcsR6qVa2Tqn/IY3g=;
        b=YcVsU1eWR3FiXvmBT1MHCYvDbdLwW29FXwm7vReVfsnD7AhfAfX9q02O9ERKY3Psxi
         3c4PkPLiGv9ZEC3GHU+vpbHtMsJXT70UYB175JG3FWG5ajNIP7MDijQKjWw4dbnFBt+9
         3fMoZaEi2CafWZD/8c2Jt0NYYbuOA9D1J2e+Zyg9CpbYMcSBkgugp80Wvu4J0lj/s/XD
         qCEL7shr7zSKq/fwqHi7YFqv29+Bcacb3N8ry4mMTybEQriX0PJvXx4K7IWCb35OFk+7
         1JCYKH/O0EifRNX58R+PJ2kZ7apV/ImeZuOm75MlknOkvkkUsUg8z+SDEf0mbL8lqA7D
         drGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765835113; x=1766439913;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rb0PTJE78xnW+sNXT9skSWBiTHzcsR6qVa2Tqn/IY3g=;
        b=aaCfJS3L6QLNVUhAHrJfbd6ZH2JDVEs/LfLPOBPc4oyeNKpbzZ/Q8TIc8nEsmjBYBQ
         Lg89xbNTxzRPVZcv1/UXEf9FgHpeYiPzk2nzxuu3H7Ic44CdKPcdhJMQN5tdjtiP0k7i
         hXOfUl+0hrzdxJ3fJ/GHqQMpx6EWZSaY1S8s+mFPUuKGX9SnwZBc0UjgdnqUf6plkE+T
         W4Bqx90c1b6u9aKAV2XNwAzqWdTXBrJYJo5tjIQTzN4Gm8tfq5Rx0tqXrakqu0CjQfpd
         4vk+ILo4zyPkENhpjA2jxif8gU4SaSmVjJMTMaIySr3FbmAZJQfTl3/cNxBWuioVjKHr
         qufA==
X-Forwarded-Encrypted: i=1; AJvYcCXdDgyNrZI0DUthPn7tZ2dsajZgkSc+Cps67QziVBm93Ua00jjgqhY37lMYohA0qjqZXhG0Frs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL6t/9vzPis6fwg22m2MghU6r/xW0JUCQiyhmvHI2iuEez3q9Z
	x98ryTbYhHY4FepD6CbhXkJRdgSJyfAO/dTIQNXbSMeBqkWo9PtDp2Rw
X-Gm-Gg: AY/fxX6xyoSeSu96oohEoXd4HNOt/lM2w2iku2ITxmvq/IKC7Wo3uwepsQ8GChd87e3
	fqSifyuWaK2mF47lO8h03gmioQEtFCavhPpeAYhMCgp8Czvry/MQObVBjAnRykFTZa/mPqzIdO2
	Ln0msQYmTWcqByzG0qDuRn6r0AQ9obZQyAqkn6v2vseg8VaEhOfBnE483nI1Z2UWONlcZacqGFo
	9n/JIRwkE55skIvuFnLGH9DfRpHyKaV6kqpNSBgAsayXKLhJ4tsO4VpQR5VVEo0Ns+dX+TuVNR1
	yk0BzDu3oMyUqVTt5pEs43xn0vwUWO16jjCwkrhaiNehYOB9ycNLOxWRNwQMLeuAFWrRZ3VdbvS
	Xx2waa4YmwyZmJxk4OPyLp2UenCmIoDSK/sVx0msSAw97ovRH7tXhuyeHyJOytJ7+bsL2WJ4eOY
	G1vE2/k8x6+D9coidhdAkc12NUorwYZX01aRQqCzYvXjPgXqr9D7zmZkVxpe/NkaDQpnqopfUKf
	OJNtQ==
X-Google-Smtp-Source: AGHT+IF1uiuJ2ljWA8IXejh11mJ3LsAcrsupCHhrjvr++Eu4/UWZazNst2kFizXi721aJh0CaOcMBA==
X-Received: by 2002:a05:690e:1407:b0:644:7b19:15e0 with SMTP id 956f58d0204a3-645555bd6c9mr8401198d50.9.1765835112785;
        Mon, 15 Dec 2025 13:45:12 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78e748d0bdfsm32558657b3.4.2025.12.15.13.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 13:45:11 -0800 (PST)
Date: Mon, 15 Dec 2025 16:45:11 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1d692ef4130e8@gmail.com>
In-Reply-To: <d0b3f358-4e0a-42f3-84f0-cbcf19066d49@linux.dev>
References: <20251213135849.2054677-1-vadim.fedorenko@linux.dev>
 <willemdebruijn.kernel.5c4c191262c5@gmail.com>
 <d0b3f358-4e0a-42f3-84f0-cbcf19066d49@linux.dev>
Subject: Re: [PATCH net 1/2] net: fib: restore ECMP balance from loopback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> On 13/12/2025 20:54, Willem de Bruijn wrote:
> > Vadim Fedorenko wrote:
> >> Preference of nexthop with source address broke ECMP for packets with
> >> source address from loopback interface. Original behaviour was to
> >> balance over nexthops while now it uses the latest nexthop from the
> >> group.
> > 
> > How does the loopback device specifically come into this?
> 
> It may be a dummy device as well. The use case is when there are 2 
> physical interfaces and 1 service IP address, distributed by any
> routing protocol. The socket is bound to service, thus it's used in
> route selection.

Can you elaborate a bit more on this. Maybe in the commit message
itself. How is loopback relevant to this service IP.

