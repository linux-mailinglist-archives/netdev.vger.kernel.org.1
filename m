Return-Path: <netdev+bounces-119944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929AB957A92
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CE21F23AAC
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1FC5234;
	Tue, 20 Aug 2024 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvawstMi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA128F7;
	Tue, 20 Aug 2024 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724114844; cv=none; b=EOBLXBX1aqAsu50W16iy3TbU16BPPVNuFtzBsyQyUBTfS3kM3vmnzno9OjkZxerDzw6yikP9Qr84sTfcicwCmQ5cYNn2K0A/ygiVNPZZ5Rie8R3TToii9LiDzNMHUEGEHVqyjPZPfmqs/U6MSOLx8GPu5A8SNMLmFcmpUfEY5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724114844; c=relaxed/simple;
	bh=Y1h5ym9kb367IdR8Us0YqRAQVqLRh9WRaQp2YNqrUKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ss8xgMW0h9neuv/z4zZyY0aTt+AR/hTbiiaUdCRMdH154ooWjtV4mWiCmq8/P6OslpNbI8EkvGqfWK/9wZm+uh0urb8xzqyVwSc+M555Aa4UaiIfzg4B5iuWgAUD24XuexQCTYAVtUe+CdZKRko0U1x7NnAWkTIMZb1WIZwCKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvawstMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB42C32782;
	Tue, 20 Aug 2024 00:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724114843;
	bh=Y1h5ym9kb367IdR8Us0YqRAQVqLRh9WRaQp2YNqrUKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AvawstMi8YM+Yt6tHk+whnQ4MrkKqmJpwnozBnbFU0+sY4uiOagYajJIM9wrfHu3e
	 4XhYAq/2Z5FDsnHF5X5EZclISkB9vYFqtv7lqJzLhn7SjsfXU4r0bZV2MYb6ls13fU
	 ZJ61Wcalk89J5a9Eo6tEovNKlShAruMVU0xbvmanpDLHdLz2kOIYg2ctcVirj4Jd7B
	 siSK0eY5rFk2NEJ9K6ofsVPbFwPn+gMDIjqUH3XLGr12Uo66uxVXQL/21982kzHwAu
	 eNbmR6cLVAplKVNzOBOW6HFgaCATGxBEjLoK67rtzIQGQiFxfVBl1fK4xotycOApBi
	 mP0oAEXOJhXaw==
Date: Mon, 19 Aug 2024 17:47:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Thompson <davthompson@nvidia.com>
Cc: Benjamin Poirier <benjamin.poirier@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andriy.shevchenko@linux.intel.com,
 u.kleine-koenig@pengutronix.de, asmaa@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] mlxbf_gige: disable port during stop()
Message-ID: <20240819174722.7701fa3c@kernel.org>
In-Reply-To: <ZsOVEMvzAXfaRiEY@f4>
References: <20240816204808.30359-1-davthompson@nvidia.com>
	<ZsOVEMvzAXfaRiEY@f4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 14:55:12 -0400 Benjamin Poirier wrote:
> Is this memory barrier paired with another one?

+1 
You probably want synchronize_irq() here?
You should explain in the cover letter, the mb() seems to not be
mentioned.
-- 
pw-bot: cr

