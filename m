Return-Path: <netdev+bounces-168828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0961BA40F6A
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 16:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C64188DD03
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A912A20967B;
	Sun, 23 Feb 2025 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOAgIvY6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357222054E9
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740323993; cv=none; b=OTJJsvKZ0oabItTnkz5rVJaZxW9wtSVdDwMJI9KrUJJoTyk8OAcuO1FiEHkdbfG4XP1eJJ/MB6/smMTQM9iy6zo305KAeksFgoEszvyyjFBZnzFhF7B6c73VMDF7XvLMhlhj/Fewdk5WntjaiPO4i1fpSyTWbBKkR8SGpz8rcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740323993; c=relaxed/simple;
	bh=T/2xb7muvL55Dk7o59poGR1yUA8xbheTCRauo126IEQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nuvuvhCJqu584OzVp0OkGXsQr3yVMRjJSmIma6rsluGLhfQiHg4FzkdwXKQ9fxwSp1k+N2fKUY/O7K7pHGMNdFrnoVi5SStR8stCxv2nuMSEaiK03V/2+dLSe9rTo4ZjDNFGw8OEorggTn7Owq96xSukjoZqTrekzfMqjZHoqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOAgIvY6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220f87a2800so121424285ad.0
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 07:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740323991; x=1740928791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovxXS/6Fh7CBfimDBUGP6a/bz+MG/2ipqKfqnHfFW1U=;
        b=OOAgIvY6Oubh3wbdSnoLehXz6d+U2U0gcgSZEszxDCn6GkGIUnDHbxGLxCYOsSJImu
         0ejljuAR4L3L/+snnvxlCvA9zjQksk1QRrsYo2tgMImy2ryZulVvhNJIgOWrG30PHFnH
         sb60wmXPPfWrjGhQchBGl1Pmu4juPOnYNRPAAW2Y3wwcwdoYi5uwWwSj++MzR09+y01v
         ITw+NEQ9pQKZW/+hBiG0GBufU2ljAz6MO1tRpi05xw1DgcCqUT8SqNOAoaRzRUDVj71W
         G9KOVrhOs+eAaXqUn6TQZ4ziDD44pqqgoSoJP8UIDEL3ubvE9wuq3OyTaW75H/CrKX5U
         H0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740323991; x=1740928791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovxXS/6Fh7CBfimDBUGP6a/bz+MG/2ipqKfqnHfFW1U=;
        b=iq3mBzEWRWokgHo/0TNLjQYPdrkrn1QaJ1XxhQe1d7D78PTs46x4fe3+0Q6h1syfe3
         6X4RFc+Qlq3GPCcsFNe2H2iYL394HX1ujEfUDuCbBnqnoTWbqJtw+AdCJWYb4yxCjG5b
         pRnc39ve7dQ0vmxVuJxIaPLyeewukm/8USDVFbxApEcBxiFAVq6pTbgLKeF4DrEjOYuH
         lxBLAEpOH15RU6aOnTy6c802CW7pMhwndYAwq7S7s+XA/OpFDtvLY0Qx0Dr5q1yqld68
         XnqEMC6myC8p9zv+qjaAOVk0XCTZewTpLWoYwxl67FDdaQClAz1Ot4RSdmLdL3nAaUVS
         TsKw==
X-Forwarded-Encrypted: i=1; AJvYcCUuLR1QE+PUsr3boFWUBC/KqFevyc4ZryBlrRnu/lruM3wqY3BTQILDS8cKwPP4ycp3bKCtreY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4pDlyifOAEdad/YkJRZKHA2zXxilxiSoNkmqBvnMay4/NUQM
	TBk2YQTs7UIsEMKy5NE4ez5IHvaHoq9KPR5wEhmCjEzye85Hq+9lmxJflJ2Ri0mLGjMP6csRf2Y
	P7W5EBX6D
X-Google-Smtp-Source: AGHT+IHKSrqSq31ICSQXXKKaZjDLG3cawrFG5g1v+7iLBFT2U5yOgUgrXrTyro+FOIcaeKsHyqZNWPF5+0Q6TA==
X-Received: from pjbee16.prod.google.com ([2002:a17:90a:fc50:b0:2fa:15aa:4d1e])
 (user=krakauer job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c94d:b0:216:3d72:1712 with SMTP id d9443c01a7336-221a118cc5emr167376045ad.48.1740323991538;
 Sun, 23 Feb 2025 07:19:51 -0800 (PST)
Date: Sun, 23 Feb 2025 07:19:49 -0800
In-Reply-To: <20250220170409.42cce424@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220170409.42cce424@kernel.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250223151949.1886080-1-krakauer@google.com>
Subject: [PATCH] selftests/net: deflake GRO tests and fix return value and output
From: Kevin Krakauer <krakauer@google.com>
To: kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	krakauer@google.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the review! I'll split this up. Do you think it's better as two
patchsets -- one for stability/deflaking, one for return value and output
cleanup -- or as a single patchset with several commits?

> To be clear - are you running this over veth or a real device?

Over a veth.

>> Set the device's napi_defer_hard_irqs to 50 so that GRO is less likely
>> to immediately flush. This already happened in setup_loopback.sh, but
>> wasn't added to setup_veth.sh. This accounts for most of the reduction
>> in flakiness.
>
>That doesn't make intuitive sense to me. If we already defer flushes
>why do we need to also defer IRQs?

Yep, the behavior here is weird. I ran `gro.sh -t large` 1000 times with each of
the following setups (all inside strace to increase flakiness):

- gro_flush_timeout=1ms, napi_defer_hard_irqs=0  --> failed to GRO 29 times
- gro_flush_timeout=5ms, napi_defer_hard_irqs=0  --> failed to GRO 45 times
- gro_flush_timeout=50ms, napi_defer_hard_irqs=0 --> failed to GRO 35 times
- gro_flush_timeout=1ms, napi_defer_hard_irqs=1  --> failed to GRO 0 times
- gro_flush_timeout=1ms, napi_defer_hard_irqs=50 --> failed to GRO 0 times

napi_defer_hard_irqs is clearly having an effect. And deferring once is enough.
I believe that deferring IRQs prevents anything else from causing a GRO flush
before gro_flush_timeout expires. While waiting for the timeout to expire, an
incoming packet can cause napi_complete_done and thus napi_gro_flush to run.
Outgoing packets from the veth can also cause this: veth_xmit calls
__veth_xdp_flush, which only actually does anything when IRQs are enabled.

So napi_defer_hard_irqs=1 seems sufficient to allow the full gro_flush_timeout
to expire before flushing GRO.

