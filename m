Return-Path: <netdev+bounces-72065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AFD8566DB
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 16:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B0D1C203AC
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B28131E3D;
	Thu, 15 Feb 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGpImmQs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92DD433B9
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009456; cv=none; b=qGenAOiHOUwAqx0ib+oyCVj0cONiwsiCwOzzCTeXEqVx+jCoUnz5mZNIMnm7/vcN0NKT/fGMborjJO2J8/PvPNkwWrSeR9op89t2RoomjX0mi9sSCPpesrZSEs+oJ02g+QJ0C6FrDqhMGa5OP5V1CejArsfS6tNS8S2PtwHEQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009456; c=relaxed/simple;
	bh=OpTgxo/quhC8MiR78g6E5wJVQZubIku+aVidndfnPDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ww8NjFkT+FP9GXeRBL1fq+rBNxIHgYYHMV3NxYmGTm16TmadELz57f8nRFurZMbQTyjJbpcIyBavDRGZwpZGELhV95k9bHxg2xunWyN4MMAN1orDb2bZvQs0OTT8xicS3LTfAeRFXcc4tcx/NzFkglMPCDaBgA0csUelAfUwHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGpImmQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B14C433F1;
	Thu, 15 Feb 2024 15:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708009455;
	bh=OpTgxo/quhC8MiR78g6E5wJVQZubIku+aVidndfnPDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RGpImmQsJmgqwtbahN6MwQF2cJFW8A4y5exdHjhLT6ChTNBXymApuzN82xE2jvv31
	 BtqP4EimFiMzUE5rp9hKGnifMd4SYw7l+pEFyOFx5w0VFiJKZVI+ctu6dCssuu02Qb
	 RRL+RRUs87BZfjeOoWfCLt2yQvW7juEiCDMQT7W86LgsOripN43jQLoWrihpIvdmbZ
	 OP/HRDxp6zmu+oTEHYiF+045xjJ8bWeRYJbizJCXuNW6+1kE5Yfg+cG28B5GVpFvzx
	 4AzB69rp+j7sgFY3RTrjebviHpYhNlpiDbcqZj08ihAKs4SySuTViPY1/vuy+t7hg6
	 jMaubdti9aqOA==
Date: Thu, 15 Feb 2024 07:04:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, <netdev@vger.kernel.org>,
 <lorenzo.bianconi@redhat.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <hawk@kernel.org>,
 <ilias.apalodimas@linaro.org>, <linyunsheng@huawei.com>, <toke@redhat.com>
Subject: Re: [RFC net-next] net: page_pool: fix recycle stats for percpu
 page_pool allocator
Message-ID: <20240215070414.4d522c88@kernel.org>
In-Reply-To: <bff45ab9-2818-4b37-837e-f18ffcab8f47@intel.com>
References: <e56d630a7a6e8f738989745a2fa081225735a93c.1707933960.git.lorenzo@kernel.org>
	<bff45ab9-2818-4b37-837e-f18ffcab8f47@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 14:41:52 +0100 Alexander Lobakin wrote:
> For example, if I have an Rx queue always pinned to one CPU, I might
> want to create a PP for this queue with the cpuid set already to save
> some cycles when recycling. We might also reuse cpuid later for some
> more optimizations or features.

You say "pin Rx queue to one CPU" like that's actually possible to do
reliably :)

> Maybe add a new PP_FLAG indicating that system percpu PP stats should be
> used?

Part of me feels like checking the dev pointer would be good enough.
It may make sense to create more per CPU pools for particular devices
further down, but creating more pools without no dev / DMA mapping
makes no sense, right?

Dunno if looking at dev is not too hacky, tho, flags are cheap.

