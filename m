Return-Path: <netdev+bounces-103031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B33906056
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 03:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B95B21ABB
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 01:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B13C9473;
	Thu, 13 Jun 2024 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA5u1y4P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567168F68
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718241542; cv=none; b=PvsOeA3JkD0iB3AAimP/xKfnkNS7/PnN00D+cw3NsQif9+kB7D5uDm2O7E9NdHmtSdPeJJBQS+ol5vqmBAcx5hcIuA0njkPfQysLM29121aWjvk74nDLKjjg7H68yX4kcvJv96qfLSX7iWRro2BuN6jmMGzQ9Y73cl9w1ZVCUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718241542; c=relaxed/simple;
	bh=EbwsNRZ1o7W/jyNasZzSwAtG3z5tX3Z8GuBM0iQpV0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2UhfiteI1zy9xeEL+0NcfzUPbDNpnXUSCjF3KQnmmKo2TqH3vAAaHHfgrbXbRAT3cg3AEeCMIPcLC5H8qdzNj074p76cANWpphKsvkWswHwigk6VszgSQJh3OV/rJum6DOF5iUlRuOLHJb7EoPxyD1aTrupy8iQXtiAqoJuCTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA5u1y4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D99C116B1;
	Thu, 13 Jun 2024 01:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718241542;
	bh=EbwsNRZ1o7W/jyNasZzSwAtG3z5tX3Z8GuBM0iQpV0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kA5u1y4PML12lv77zbBJ1CToTaZjvBTRhuTtPqzTHgo2jO/AjwqwVzCfojwehAUZe
	 +13DtbnGZ0X2Fxc4WTzXOARD82oEW6cP+FWRcSqiuvVDpC2KbBKWzX/B3nqwvnw5D3
	 O77JJeVeyTmIU/4uH37ZCV3Q0kopv+76FcMcV0HPQn/DE7I+GxJrp69k1MhwQqMeXa
	 JyHei+qee2nRoflVTMESPu3/7NPgE4cwmJjewB1bx/V5yMxJlB+M3Ug0YvBdin9/JO
	 BWKbVzYE8bcuxRZVMpiZfKExAKY5o44ThrAPguPSR23UDsmLqh6PJrR7IyIe80hoxi
	 BZnBhz7rLO6EA==
Date: Wed, 12 Jun 2024 18:19:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <brett.creeley@amd.com>, <drivers@pensando.io>
Subject: Re: [PATCH net-next 4/8] ionic: add work item for missed-doorbell
 check
Message-ID: <20240612181900.4d9d18d0@kernel.org>
In-Reply-To: <20240610230706.34883-5-shannon.nelson@amd.com>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
	<20240610230706.34883-5-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 16:07:02 -0700 Shannon Nelson wrote:
> +static void ionic_napi_schedule_do_softirq(struct napi_struct *napi)
> +{
> +	if (napi_schedule_prep(napi)) {
> +		local_bh_disable();
> +		__napi_schedule(napi);
> +		local_bh_enable();

No need to open code napi_schedule()

	local_bh_disable();
	napi_schedule(napi);
	local_bh_enable();

is a fairly well-established pattern

> +	}
> +}

> +static void ionic_doorbell_check_dwork(struct work_struct *work)
> +{
> +	struct ionic *ionic = container_of(work, struct ionic,
> +					   doorbell_check_dwork.work);
> +	struct ionic_lif *lif = ionic->lif;
> +
> +	if (test_bit(IONIC_LIF_F_FW_STOPPING, lif->state) ||
> +	    test_bit(IONIC_LIF_F_FW_RESET, lif->state))
> +		return;
> +
> +	mutex_lock(&lif->queue_lock);

This will deadlock under very inopportune circumstances, no?

The best way of implementing periodic checks using a workqueue is to
only cancel it sync from the .remove callback, before you free the
netdev. Otherwise cancel it non-sync or don't cancel at all, and once
it takes the lock double check the device is still actually running.

