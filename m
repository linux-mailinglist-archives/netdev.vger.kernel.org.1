Return-Path: <netdev+bounces-119635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D70429566A5
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F751C20C35
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3CF15DBB6;
	Mon, 19 Aug 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPiEfQ7e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555515D5DE
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059044; cv=none; b=lVgI7R4KiQWnRWhFhcsdJZftrm9PLD5WNQ1xlPAC7cST7W2+wBec9vIHFl01iP4LdqGsa/QF5TIoFLAz3bYdebnJf8dAORVMhbY+Lohsl+tgw10fnPQ9BVzEiD8UVuKYo+mNDGrK2yec3IJlZFH2lT1kv2/fzZC6mtA/noT8Ft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059044; c=relaxed/simple;
	bh=N15wJ8YSzrdUupXx24mGoHm1GxYX7wkyfvT+9LytlCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaM/zSnbt3eRzOuVbuqN/bVNsXUomnf9Czrt4XTHBBGSI0ozQxaTghz+beMl4yEVJ29D2p5HyozNImrULR/VHilDmOdpJh8klnyZiftzQoU7s7DM/wtQ0cew+utx3DULjvVXDgaE3lTyJ8u8jMzoJ4/+jZHZWp5rFIFijZu01SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPiEfQ7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDF8C32782;
	Mon, 19 Aug 2024 09:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724059044;
	bh=N15wJ8YSzrdUupXx24mGoHm1GxYX7wkyfvT+9LytlCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPiEfQ7eFIBFKsczo+PwZYCFKgOSxhMFIGEwoaNpe+WuJuHv7Ralu25IEub1JJ4uu
	 O+0FqOCxkLHP+935E0/YlMw6iNWnsoHXl1ev2Pcv5YhW54Lm5jsN4HPwvYJNxfLU39
	 eAkNiBte0uNYPeAWgPnGQfako3N5Ai1s/2BbOvseM1QmcV1PhJydlUV4DI8r/SKwDb
	 IPsuIUi7fG8jzc2Kq/AXTSof3OFE99kmlDy1rMGvRbD1UX6WZDNf0n3lZEy/M92KOG
	 vaadw6cnPTz+StxrD1uJC3em2v5DXb3VFLHFinSliJ0AKnRxZxXIYgixOkh8+b+0XE
	 39P4D/hXacnxw==
Date: Mon, 19 Aug 2024 10:17:19 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com, helgaas@kernel.org,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next v2 4/9] bnxt_en: Deprecate support for legacy
 INTX mode
Message-ID: <20240819091719.GA11472@kernel.org>
References: <20240816212832.185379-1-michael.chan@broadcom.com>
 <20240816212832.185379-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816212832.185379-5-michael.chan@broadcom.com>

On Fri, Aug 16, 2024 at 02:28:27PM -0700, Michael Chan wrote:
> Firmware has deprecated support for legacy INTX in 2022 (since v2.27)
> and INTX hasn't been tested for many years before that.  INTX was
> only used as a fallback mechansim in case MSIX wasn't available.  MSIX
> is always supported by all firmware.  If MSIX capability in PCI config
> space is not found during probe, abort.
> 
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2: Fix memory leak, update changelog

Hi Michael, Hongguang Gao, all,

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

