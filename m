Return-Path: <netdev+bounces-195257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 982C8ACF15F
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7068C7A7935
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4CA2749D9;
	Thu,  5 Jun 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulp39EOv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588EC2749CF
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131779; cv=none; b=XID1v/jevC/PDpkIl7rDneDmx2Fd1RfW5P6/eXwIp8Qj1/+bSHpbO9I7BBZavngfYhuQWbSSSrwYrOoXuMexFJf2d9P90/yyzvtWvgOrQdOWAhrUApSywec+M5t6hYt40HVb1UYgNassELBWkEkYBhAchtFOGejam8C3mgMe+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131779; c=relaxed/simple;
	bh=bKJ62gabTP150QYYP+4gJiWbSOcSkYqSdoqrmfZxGqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbMJ3z9Wkb8vedoK06moM6G/wgg+8bjIAb+9jLcRiy8LAtvPSIfsHO0jPBXeeozKrYY8FKi868CQ23Eoi6c6N+04sT777oCN9CUFWE44icssqNDX6vCk6OgnRrqFtEZJRxS5BfzaizZHRhHtWqNpKlz9GChlc84lewJazHCzh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulp39EOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E49C4CEE7;
	Thu,  5 Jun 2025 13:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749131776;
	bh=bKJ62gabTP150QYYP+4gJiWbSOcSkYqSdoqrmfZxGqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ulp39EOv6WU0lelAnuBitHZybHEyKrUGHQl1wmtMFgoOirFEa0NXpJYN1ogVJvtjw
	 Vv+90aJg99Y2J146KtY9IdRqyhECAbJtcWcxqLV39ti5yIo2SOlq0GHwWNowZYIvEW
	 x5IrkhZwXKCHcqhsCfIJCEEkQxjPA5AVZNTHyAxIf41nGidrPBzLrt+MvDbqechw6r
	 pUxMATI5pPrnHSTu/ZQy0ly5kiVa4WZ1kKrWUJbxIFuo4jLu/+E7QgNDo2zM+0mRRc
	 DNWpdfPGs0jAwfIp7HuOSaFNohcc1X3N5N8bU7zFxAPvuXVjn51ZioYUT3lwvlaVm8
	 tF5/5HRptzvbg==
Date: Thu, 5 Jun 2025 06:56:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org,
 leon@kernel.org, andrew+netdev@lunn.ch, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
 przemyslaw.kitszel@intel.com, weihg@yunsilicon.com, wanry@yunsilicon.com,
 jacky@yunsilicon.com, horms@kernel.org,
 parthiban.veerasooran@microchip.com, masahiroy@kernel.org,
 kalesh-anakkur.purayil@broadcom.com, geert+renesas@glider.be
Subject: Re: [PATCH net-next v11 14/14] xsc: add ndo_get_stats64
Message-ID: <20250605065615.46e015eb@kernel.org>
In-Reply-To: <CAMuHMdVMrFzeFUu+H0MvMmf82TDc=4qfM2kjcoUCXiOFLmutDA@mail.gmail.com>
References: <20250423103923.2513425-1-tianx@yunsilicon.com>
	<20250423104000.2513425-15-tianx@yunsilicon.com>
	<20250424184840.064657da@kernel.org>
	<3fd3b7fc-b698-4cf3-9d43-4751bfb40646@yunsilicon.com>
	<20250605062855.019d4d2d@kernel.org>
	<CAMuHMdVMrFzeFUu+H0MvMmf82TDc=4qfM2kjcoUCXiOFLmutDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Jun 2025 15:39:54 +0200 Geert Uytterhoeven wrote:
> On Thu, 5 Jun 2025 at 15:29, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Thu, 5 Jun 2025 15:25:21 +0800 Xin Tian wrote:  
> > > Regarding u64_stats_sync.h helpers:
> > > Since our driver exclusively runs on 64-bit platforms (ARM64 or x86_64)
> > > where u64 accesses are atomic, is it still necessary to use these helpers?  
> >
> > alright.  
> 
> [PATCH 1/14] indeed has:
> 
>     depends on PCI
>     depends on ARM64 || X86_64 || COMPILE_TEST
> 
> However, if this device is available on a PCIe expansion card, it
> could be plugged into any system with a PCIe expansion slot?

I've been trying to fight this fight but people keep pushing back :(
Barely any new PCIe driver comes up without depending on X86_64 and/or
ARM64. Maybe we should write down in the docs that it's okay to depend
on 64b but not okay to depend on specific arches?

Requiring 32b arch support for >= 100Gbps NICs feels a bit hard to
justify to me at this stage, but I'm happy to oblige if there are
reasons.

