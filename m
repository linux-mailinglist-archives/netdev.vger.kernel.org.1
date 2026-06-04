Return-Path: <netdev+bounces-295234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zoq/AK11IWo+GwEAu9opvQ
	(envelope-from <netdev+bounces-295234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:55:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFDF640174
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:55:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=EC5j3yEx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295234-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295234-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A185300B5A1
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 12:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD2E478E28;
	Thu,  4 Jun 2026 12:55:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26F4477987;
	Thu,  4 Jun 2026 12:55:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577706; cv=none; b=MG8QJqSyPVmODSThx71bO3ZsdkCmRhnzuVsnZjxOkFpoywj8ba8uGnvbirPq/hyjsEa+OvzXgzb+lZ7w3nNR8cN80pFD/jX2ctp+CMPPJpTMCvgaBWi/rknxlPdMZ/mPpMqtT3wDiK6k9QN9h5m/wyEvn+fqBzvtEAQz7sNcsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577706; c=relaxed/simple;
	bh=QxSGRY4L3Tgf3x+iOHyGVPvIzaF30Hlk6xO46vSv8Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B39Fp8u+CC1g7YUgz/0CdRaluryFqEzhE7Anhv2qZEPqLikggzxFdlncQKV6AqPed4W2UTYSVtR8RsHx7CBwT4/MjoxVnnq0TlZ4/CRJNf/7RNbA2CIfHJPPH2Wm6kJ4Qd+xuANa+m1cVORa+8oUYfalttujZMmc5wIXqvwhL3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EC5j3yEx; arc=none smtp.client-ip=91.218.175.184
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780577702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3MGpzxEfhVL51O4IZ6GwBDnyJ7cfCwaCriJzF1YfgA=;
	b=EC5j3yExvJBfA12Qtv3Xe8KvPU/oWt4LMe09BEih7PuEK7sFCewUk6c0aOoTt2zMQagtxL
	HrxRt8uNXG69bG05So1eGhMN0vuJSFouqWWo8WHKN/pLzG+XUtm7MYmFAmdvPl03KZpQ7p
	n7YLamSWiSJ38bqRJHatqfW0QgGjvBI=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: shayd@nvidia.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	fushuai.wang@linux.dev,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	moshe@nvidia.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	parav@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	wangfushuai@baidu.com
Subject: Re: [PATCH 2/2] net/mlx5: Only consider online CPUs in affinity subset check
Date: Thu,  4 Jun 2026 20:54:42 +0800
Message-Id: <20260604125442.20673-1-fushuai.wang@linux.dev>
In-Reply-To: <7018a27a-29fb-4c8e-84cf-dc90d1b3bd9c@nvidia.com>
References: <7018a27a-29fb-4c8e-84cf-dc90d1b3bd9c@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295234-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shayd@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:fushuai.wang@linux.dev,m:kuba@kernel.org,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:parav@nvidia.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:wangfushuai@baidu.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fushuai.wang@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fushuai.wang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BFDF640174

> > From: Fushuai Wang <wangfushuai@baidu.com>
> > 
> > When an SF is created after a CPU has been taken offline, the IRQ pool may
> > contain IRQs with affinity masks that include the offline CPU. Since only
> > online CPUs should be considered for IRQ placement, cpumask_subset() check
> > would fail because the iter_mask contains offline CPUs that are not present
> > in req_mask, causing SF creation to fail.
> 
> Thank for the patch!
> 
> can you please provide a full example? for simplicity, lets say the SF
> pool is of size of 2 IRQs.
> 

Sure, here are the AI summarized steps:

  1. When mlx5 driver loads, it initializes the IRQ pools.
     For sf_ctrl_pool with ≤64 SFs:
     - xa_num_irqs = {N, N} (There is only one slot)
  2. When the first SF is created:
     - The ctrl IRQ is allocated with mask=cpu_online_mask={0-191}
  2. We take CPU 20 offline
  3. Existing ctl irq still have mask={0-191}
  4. Create a new SF:
     - req_mask={0-19,21-191}
     - iter_mask={0-191}
     - {0-191} is NOT a subset of {0-19,21-191}
     - least_loaded_irq=NULL
  5. Try to allocate a new irq via irq_pool_request_irq()
  6. xa_alloc() fails because the pool is full(There is only one slot)
  7. sf creation fails with error


> > 
> > Filter the affinity mask to only include online CPUs before checking if it's
> > a subset of the requested mask, 
> 
> won't this cause the affinity mask to be empty, which is kind of missing
> the point of this API... :(

Yes, I didn't realize this.

> can you check if irq_get_effective_affinity_mask() will solve the issue?
> 

Yes, I tested that irq_get_effective_affinity_mask can solve the issue.
I will send a v2 shortly.

-- 
Regards,
WANG

