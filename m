Return-Path: <netdev+bounces-226156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9085B9D100
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23C819C34B1
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537AC2DE71D;
	Thu, 25 Sep 2025 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OWVgTpAV"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE91C27
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758765065; cv=none; b=FhDUjtf9e/zWR4HzFCEoTGPCzAC2dNzIY4cAgmv97lJUYooqo9v14lIPGXCUB3k92VRM/2O3SXhxIgByD13FcZXNbTiPUcStdLr162pqkMMvzbQ7Anx4OT05wx1jWl6bDJZtCe2OPUAeho/qzH/p9ldBNBIIFvl+e7sWnKJ3/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758765065; c=relaxed/simple;
	bh=7sRcqIsXTynk4sMdnmpY8ksusNwcLK1aghcgGRP2gvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbzNAOfK93wV9RLlNJ/mvyH2AHOO6nBRpB1suRU98THE2rWnqB15zq7AKCQ8hHbzxpX3zsk7J+PgpoBFkULVf2zpGtzDsAtWx/7EO6Etk5B9LjlcawYnvTsTVyPd0dhAuL9QaXvUUmbvX7IDgjzwkB7zkb2RdNl/gwpgj0DEepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OWVgTpAV; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2f93a746-e23e-4e35-aafc-2ecde8b5f172@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758765059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sRcqIsXTynk4sMdnmpY8ksusNwcLK1aghcgGRP2gvk=;
	b=OWVgTpAVEQB9ARBVhGsbh2s3zsC+DPhodeE9wP0B7o5LyMe5mTs5n3mX9RjhyNdzvWIpdK
	UhvlbB5N2Pte2etHs8mOvVAPp2i7Hhsh6Nks2v2KTrVD2l4dGI8mfcaZSR9z0jBXRdkaGs
	CADtGQSNIbr5FbEU/G66pSWnKpJWNYk=
Date: Thu, 25 Sep 2025 09:50:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, kuniyu@google.com, kerneljasonxing@gmail.com,
 davem@davemloft.net, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250924015034.587056-1-xuanqiang.luo@linux.dev>
 <20250924015034.587056-2-xuanqiang.luo@linux.dev>
 <20250924175449.36b71e48@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20250924175449.36b71e48@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/25 08:54, Jakub Kicinski 写道:
> On Wed, 24 Sep 2025 09:50:32 +0800 xuanqiang.luo@linux.dev wrote:
>> Add two functions to atomically replace RCU-protected hlist_nulls entries.
>>
>> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
>> mentioned in the patch below:
>> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
>> rculist_nulls")
>> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for
>> hlist_nulls")
> You most definitely have to CC RCU maintainers on this patch.

Got it, I'll make sure to CC the RCU maintainers in the next version.

Thanks for the reminder!


