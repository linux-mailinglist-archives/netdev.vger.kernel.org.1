Return-Path: <netdev+bounces-157840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2971A0BFDA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A2B1888C11
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80E1C54A7;
	Mon, 13 Jan 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i62wOox8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D921C5496
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793188; cv=none; b=SnzCQPIeD7sNi8yxaH4B5xcf8DetAlrZIfjd5+P23ptqb11pMcZtaA7WFceF6NrwPpidM78JSBHsuZvTemBpZBm44owHMRz7pqkDOePHNG6yL15IWwFBhmrUqLARp5MRm1wHn1LoYMltE7IzHaS7s1YTvyhBvj3Oyft6qmORDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793188; c=relaxed/simple;
	bh=ftuGto6o0TyZO6bCqv7JLGst0izHcOC60PbCmGiNDYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaOq6sBM8kNllVFWPt8QrB89s+BSb8PWtHzFHezTBExFm3YEhPykgDEOsdSOb4p+X+YK08H3FtkVh0/NzulaEYrp/cGtaq6+JTglJIksjnR37AsscrpAj7RFoj5vKy6ycYYCjdVHGO5EY93rQ248q6wUIcFjmWHlkSpPlXX2pow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i62wOox8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536F5C4CED6;
	Mon, 13 Jan 2025 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793187;
	bh=ftuGto6o0TyZO6bCqv7JLGst0izHcOC60PbCmGiNDYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i62wOox8MniqsjtQT9Hq6aGo5XuV8xP9s5ba2+LMgJHKnSvPA3hRONomqBADIKvIO
	 ydYt8aMMyV9fIvD6W0lE53JFfltBL+RwyBfod5AKvWaWkjLJOJ40zyFuLLAh8eWanS
	 31u2dQ/OfOP8t5Ywb3Lfor8ip2k2xGUo5EeQcdeKcIPpggCUqBrrdN3Xn0iGTQTnIo
	 HsPaX1f4KPZ3ZnO3C6rw0ovlrKtrOwqHhkXYE9SH+aOGGNI16g2xeM1f9wgrBplFzH
	 3Mzsahxc0NjTYpKsFk/ykn5JfwSYFwZPJsnqC1VBPk3bGS+bfXAs1y/dwYRFfp2zTq
	 RoVV+qtMkmAMA==
Date: Mon, 13 Jan 2025 10:33:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
 <netdev@vger.kernel.org>, <anton.nadezhdin@intel.com>,
 <przemyslaw.kitszel@intel.com>, <milena.olech@intel.com>,
 <arkadiusz.kubalewski@intel.com>, <richardcochran@gmail.com>, "Karol
 Kolacinski" <karol.kolacinski@intel.com>, Rinitha S <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next 08/13] ice: use rd32_poll_timeout_atomic in
 ice_read_phy_tstamp_ll_e810
Message-ID: <20250113103306.5b4f8f86@kernel.org>
In-Reply-To: <a0b535bd-3569-4d36-9752-ec8dcdc23aaf@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
	<20250108221753.2055987-9-anthony.l.nguyen@intel.com>
	<20250109182148.398f1cf1@kernel.org>
	<55655440-71b4-49e0-9fc8-d8b1b4f77ab4@intel.com>
	<20250110172536.7165c528@kernel.org>
	<a0b535bd-3569-4d36-9752-ec8dcdc23aaf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 10:18:05 -0800 Jacob Keller wrote:
> > Ack, and short hands make sense. But both rd32_poll_timeout_atomic and
> > the exiting rd32_poll_timeout have a single user.  
> 
> The intention with introducing these is to help make it easier for other
> developers to use poll_timeout and friends throughout the driver.
> There's only one user now, but my intention had been that we'd see more
> as it becomes more known and is easier to use.

IMHO the ease of use gain is equal to the loss of generality (driver
local flavor of a common function will make contributing outside the
driver harder).

To be clear it's not a blocker, I'm only complaining because there was
a bug in the other patch.

