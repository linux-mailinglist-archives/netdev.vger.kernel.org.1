Return-Path: <netdev+bounces-246615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D62CEF3F1
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 20:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBFF6300CB84
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 19:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7AC2D2490;
	Fri,  2 Jan 2026 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAb1q+jE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840432D0606;
	Fri,  2 Jan 2026 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767383498; cv=none; b=IEaOSHaq9SDp1aCtAYKX2kw8HoYSy+OhfxbFBWfV9GVdTGUbVgg0RyoFzvF7/AvcRUr7UNH7lAU/ECOHZiA4LVMPxRaSCaIfaiog0Oq3kp8ImIQggJi/0iRbR+Y2Q5sywQd2jhRcCpNDxgNYhB0cs9xQ+QlMpVxbKsGcYSeUwAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767383498; c=relaxed/simple;
	bh=XO8nfIIMIOeyft3TWTJEGlqdi7kY1s5i+DL11uhX8Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkopBgYFYmNXWAFb765x+HEcloc7D+y2G2JzlDik3tcoSZd5aqtYdzC4OnPi/ysxTHivT/z0Op0KLA2E1nGvr7pC2D095Q/MnY6cWnlSGM47pJPWXyZoNkEh5w3nrDZCj+OWqjc9o2LLEA5mvbpMND4zJeN94yMgDVM3zmCVeqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAb1q+jE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F3DC116B1;
	Fri,  2 Jan 2026 19:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767383497;
	bh=XO8nfIIMIOeyft3TWTJEGlqdi7kY1s5i+DL11uhX8Lg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hAb1q+jE2b+lEiRJ0WK++1HFWc9dkYEVpwFVUs5HTGYm+VObcrxcUeCK19rVjKZKB
	 Kwitk7mty4sBFjnRZitUAjGJm4U4/0ri0jh4IA+vklCZkAMAcMCZ+qwXQtHT1BKK4g
	 dh3ppOKFCWGNtsyh5GwrS2nnctkKo+uoIMOaDBULIzxFeBHr8yQ2xt3D6oOwCn/stY
	 yji561vHe7LEdb7HBULKlbxkV6KjoXvF5xA0xNS1GiNEPkJ2Qm0MLOGd25qErhhGVn
	 rlH2UD+yYuGtjEeMzWELfQgtYtHZohw/VMlm6WWti8OHs4Bknd4gaE/xAtQPgCatRD
	 AZ23rmbgVI21g==
Date: Fri, 2 Jan 2026 11:51:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Richard Cochran
 <richardcochran@gmail.com>, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
Message-ID: <20260102115136.239806fa@kernel.org>
In-Reply-To: <957500e7-5753-488d-872d-4dbbdcac0bb2@linux.alibaba.com>
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
	<20251030121314.56729-2-guwen@linux.alibaba.com>
	<20251031165820.70353b68@kernel.org>
	<8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
	<20251105162429.37127978@kernel.org>
	<34b30157-6d67-46ec-abde-da9087fbf318@linux.alibaba.com>
	<20251127083610.6b66a728@kernel.org>
	<f2afb292-287e-4f2f-b131-50a1650bbb1d@linux.alibaba.com>
	<20251128102437.7657f88f@kernel.org>
	<9a75e3b2-4d1c-4911-81e4-cab988c24b77@linux.alibaba.com>
	<c92b47cf-3da0-446d-8b8f-674830256143@linux.alibaba.com>
	<20251213075028.2f570f23@kernel.org>
	<fb01b35d-55a8-4313-ad14-b529b63c9e04@linux.alibaba.com>
	<20251216135848.174e010f@kernel.org>
	<957500e7-5753-488d-872d-4dbbdcac0bb2@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2025 15:18:19 +0800 Wen Gu wrote:
> The same applies to ptp_cipu, since it is already used and relies on
> exposing /dev/ptpX.

IIUC you mean that the driver is already used downstream and abandoning
PTP will break the OOT users? This is a non-argument upstream.

> Given the historical baggage, it seems better to keep using the
> existing ptp framework, but separate these pure phc drivers into a
> new subsystem with a dedicated directory (e.g. drivers/phc/) and a
> MAINTAINERS entry, moving them out of the netdev maintenance scope.
> This should also address the concern that these pure phc drivers are
> not a good fit to be maintained under the networking subsystem.

I'd rather you left PTP completely alone with your funny read only
clocks. Please and thank you.

