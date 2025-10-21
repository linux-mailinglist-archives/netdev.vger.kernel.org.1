Return-Path: <netdev+bounces-231424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C59BF92F2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 750313478B2
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85938298CB7;
	Tue, 21 Oct 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss19cS+T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E515CD74;
	Tue, 21 Oct 2025 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088208; cv=none; b=R/5X/jUwpdcQjXZUd66Dl42r6JceCznT7qnH09thJ2Q/qjXNS4PIr9My4qoLqKbK6RjosdrP+6+VU4R32ziRZPSrHPLuIA0GtKMtRreZtDzniQ8bgdOYjOAnH75gE7kYT4EZfOE+ggVHEgq6mk9wZcfEbMKDKfoU5fXNKM2wVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088208; c=relaxed/simple;
	bh=NGV1UzFE2Uh7tl2QQ+zFh/mVjQTfDNAfn+ezZJjyUVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbNjnFybvkVYBh1S2/MKV8QORrtGSbG6UjbGWAKWb53sT7u4bY/SPr961NRTUEpBsbGBS6fGATzgvucwLeWn7Tk0EOOVZEk93kmCXEdgvO8Ugg1EQC5P6r//NqdTDb96crAJSkwWIXV+6d03rG4UuVyWgP4hoikAGz/iS0+FyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss19cS+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C25CC4CEF1;
	Tue, 21 Oct 2025 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761088207;
	bh=NGV1UzFE2Uh7tl2QQ+zFh/mVjQTfDNAfn+ezZJjyUVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ss19cS+TG3YX6h+4SiNY/TdEzix8LEKDm+eP/Fma8qH/+T1Pp9SzlQR4ZBzAszWs4
	 UheV2tXS+F8OF3nieb0ws5zkd+bCQIFo9ipPIaHqwz4zZK4tX+33rOVLwhr9gtbYd+
	 7qri9sW8bQb5uH1ImpLxU/a/gZ+Gv7rSYgZL3EFXxiZb6onZ3s7QDdI2vwjYdcTUac
	 yPE5/AxjOMwSJGVtQP1dDgN0kfGG0zu3wD0cFGEMg9SWIW8UH1hiaOdvV+jukPUFJx
	 dEhNlkDx2wP7KsiUgRIlTpMs9X18/mJGzssRCB8B7gvFlRdncesYbtMLBv5PXS6Yd5
	 xn4wAkCfiIf7A==
Date: Tue, 21 Oct 2025 16:10:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: <aleksander.lobakin@intel.com>, <andrew+netdev@lunn.ch>,
 <anthony.l.nguyen@intel.com>, <corbet@lwn.net>, <davem@davemloft.net>,
 <edumazet@google.com>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
 <jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>, <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next v2 13/14] ixgbe: preserve RSS indirection table
 across admin down/up
Message-ID: <20251021161006.47e42133@kernel.org>
In-Reply-To: <20251021040000.15434-1-enjuk@amazon.com>
References: <20251020183246.481e08f1@kernel.org>
	<20251021040000.15434-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 12:59:34 +0900 Kohei Enju wrote:
> For example, consider a scenario where the queue count is 8 with user
> configuration containing values from 0 to 7. When queue count changes
> from 8 to 4 and we skip the reinitialization in this scenario, entries
> pointing to queues 4-7 become invalid. The same issue applies when the
> RETA table size changes.

Core should reject this. See ethtool_check_max_channel()

> Furthermore, IIUC, adding netif_is_rxfh_configured() to the current
> condition wouldn't provide additional benefit. When parameters remain
> unchanged, regardless of netif_is_rxfh_configured(), we already preserve
> the RETA entries which might be user-configured or default values, 

User may decide to "isolate" (take out of RSS) a lower queue,
to configure it for AF_XDP or other form of zero-copy. Install
explicit rules to direct traffic to that queue. If you reset
the RSS table random traffic will get stranded in the ZC queue
(== dropped).

