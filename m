Return-Path: <netdev+bounces-192127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F5BABE98D
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 04:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911041BC01A2
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE4922A81D;
	Wed, 21 May 2025 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHjIJrgK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C22563
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793426; cv=none; b=X2mr602VyvqPrf1sVk19G5quhzOznWNHl5goLLWAu1oKVoTvFtLBuoQkK6O2MqFes6HcYpRQNKnnohEBZDIUNFbyUUeOXDe5joYMPVAENlo5i5t4VRBSkuAUihA0UY8KshsTCVfs474Cd80j9Nsvui3s6x2SF0Dzmahavjk+UhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793426; c=relaxed/simple;
	bh=xQg+pQDdj8WgT0suLFT5jNePoEMswhTtO+fAn47lXNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHzcUlGC0HX3UCE6Qm/vTEvH564g0pVobXQiD6shwyRv8MOUPt811RC2O6/SBazqAWBQ8yoHSZvnvd6H8nZodWvwcnNcAyrDswI5Dd/goBSc0ovhhxOq7LzcQIWtRCSw2Ur0VNwhw2FH12M4XgPo+O8ih2sygQ5ClqK2E55on4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHjIJrgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B84CC4CEE9;
	Wed, 21 May 2025 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747793425;
	bh=xQg+pQDdj8WgT0suLFT5jNePoEMswhTtO+fAn47lXNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WHjIJrgKmVQ0RdGsx97utXnPuusHFBUHclhs2hOchzDTpxG49dlmt8JYM2pLtzqc4
	 1bfLQt554O8wSAthQ251BMKqeQJrgOmWmArnpBvbilbtWLrb/+eq9afChOM4vIpj7Y
	 QWLbWTNreHZQ1PH5tlT8pjE+5nrpM62MlCHOVziDky9inQrxXWiuQ9B8WkMNBQdW3c
	 z6YItN3I9L1iKbqInFRUsMj7okueP2NM2lGJE3LIKdDx7y7lIkf/C+XoO84ogrte2h
	 tV4xYze6i7waJUbPgmLUJJllUhifCKLq1JssKP3Msbph2rj7Hsxl+hD8zbW6mIw6+f
	 /yyXU5MzgZwyA==
Date: Tue, 20 May 2025 19:10:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net 1/3] bnxt_en: Fix netdev locking in ULP IRQ
 functions
Message-ID: <20250520191024.1b92e207@kernel.org>
In-Reply-To: <20250519204130.3097027-2-michael.chan@broadcom.com>
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
	<20250519204130.3097027-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 13:41:28 -0700 Michael Chan wrote:
> netdev_lock is already held when calling bnxt_ulp_irq_stop() and
> bnxt_ulp_irq_restart().  When converting rtnl_lock to netdev_lock,
> the original code was rtnl_dereference() to indicate that rtnl_lock
> was already held.  rcu_dereference_protected() is the correct
> conversion after replacing rtnl_lock with netdev_lock.
> 
> Add a new helper netdev_lock_dereference() similar to
> rtnl_dereference().

I'll apply this one as is since its for the current release

