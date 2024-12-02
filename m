Return-Path: <netdev+bounces-148253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E49E0F14
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 23:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44D21616D2
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5AB1DF96B;
	Mon,  2 Dec 2024 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHHgGDsF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D741D79B4;
	Mon,  2 Dec 2024 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733180225; cv=none; b=fzpIbIzO1lhUJlVWdeczkMfyVK86Yed4zauIskr1z/ZnXwob1Ur/hDxY35gwerg4O3Mx1OUd5Gp2GcOj450gTKDGkjokxCdYq7A+mIln7Ypc8ckcjeNii1POLStEcQDOr+61mPiPZkkwYY6hGmAmqXbnc818MQxxQ2xa/rcVmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733180225; c=relaxed/simple;
	bh=sRnHEAOc8yn9NE0hSsRK5dTFQHwcas3LidqcY45aKFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DziagqE7mAgtwqbW1FMXB0HLSDQLYvMrKvEkGY70jUhJTRlYnTsIi4PtN0T7BfHAS/ztZwZEZX8570RhldDwQrjAhJAwnMgCaeE4PwLHh/I3G2TzeO7+rhx/OsK2IhvSUybn+HafTFF52zCm2toGrdajvzAbRGoiOIFcy01S29M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHHgGDsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29177C4CED1;
	Mon,  2 Dec 2024 22:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733180224;
	bh=sRnHEAOc8yn9NE0hSsRK5dTFQHwcas3LidqcY45aKFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SHHgGDsFAj3q7QjHMDdrcmgEJW2py+cW+TyShEdPzE18TYTUm5r2JqS87Cqqxt2II
	 eoSm6e4Jm4KZ5mrlS3yhAvGfPd0FU/gB1ohK1Lq9C83/fSVpllRBR1V7dpbcc2x0fj
	 6xgRaeOnaLNHaBjEvjWp5Vq29cl5lw1HIyEZQuI/rIxhrTFqRmwvqLOoHH00QSTlLQ
	 uKCmkSz0LMqPDJryzNl8VsbsBsVuDgNQ4uCk55cPArGFXkuSfTaX1xuN9DHeAg9a/k
	 SrgK+1z/QRFuK8XSc+OLxJPmre1MXxuW1CGFqDDiH+OS1pwc3VWExNJAYwT1aZ3Pp4
	 Rlpwg6VBvJseQ==
Date: Mon, 2 Dec 2024 14:57:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lenny Szubowicz <lszubowi@redhat.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 george.shuklin@gmail.com, andrea.fois@eventsense.it,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch v2] tg3: Disable tg3 PCIe AER on system reboot
Message-ID: <20241202145703.388913d1@kernel.org>
In-Reply-To: <20241129203640.54492-1-lszubowi@redhat.com>
References: <20241129203640.54492-1-lszubowi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 15:36:40 -0500 Lenny Szubowicz wrote:
> Disable PCIe AER on the tg3 device on system reboot on a limited
> list of Dell PowerEdge systems. This prevents a fatal PCIe AER event
> on the tg3 device during the ACPI _PTS (prepare to sleep) method for
> S5 on those systems. The _PTS is invoked by acpi_enter_sleep_state_prep()
> as part of the kernel's reboot sequence as a result of commit
> 38f34dba806a ("PM: ACPI: reboot: Reinstate S5 for reboot").
> 
> There was an earlier fix for this problem by commit 2ca1c94ce0b6
> ("tg3: Disable tg3 device on system reboot to avoid triggering AER").
> But it was discovered that this earlier fix caused a reboot hang
> when some Dell PowerEdge servers were booted via ipxe. To address
> this reboot hang, the earlier fix was essentially reverted by commit
> 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF").
> This re-exposed the tg3 PCIe AER on reboot problem.
> 
> This fix is not an ideal solution because the root cause of the AER
> is in system firmware. Instead, it's a targeted work-around in the
> tg3 driver.
> 
> Note also that the PCIe AER must be disabled on the tg3 device even
> if the system is configured to use "firmware first" error handling.

sparse (make C=1) complains:

drivers/net/ethernet/broadcom/tg3.c:18259:22: warning: restricted pci_power_t degrades to integer
-- 
pw-bot: cr

