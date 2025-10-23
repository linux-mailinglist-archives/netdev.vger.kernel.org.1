Return-Path: <netdev+bounces-232138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B108C01ABD
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11E61886830
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05910320A32;
	Thu, 23 Oct 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz1fWK8d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAFD314B81;
	Thu, 23 Oct 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228781; cv=none; b=tVfRIzu/asGQn5DWS6uPwi+b3vzHdOXnkFlEyQutgepUu4zPOQGWmmgw0SbOHcpqEnwXvz66HGqR9B7HExldJtpbqN0FTNXFq7R5Jb9ddY4YyydRHXjwey9am8qqinQfK4h3wDzJl+VZEDaOd1C0EkUsLG2zuf1us3XIVp9wBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228781; c=relaxed/simple;
	bh=NJZX715J8X/ePUXGj2kC9r5cpZuVmLm4kR8Ex4cYbfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2ZUKmFPkwWqVfOmoMhjILp+9wMj1tGdYqQ9CoNkTb2RYpFWBDYAXX83FOEeHlwORb7RNlcb6yDNKG78uzgZYoR3N134m1AaFj7aB6SDC+PvwbZz3WYThO5z1CiGTxMpbdTF8v3fXiLd/Tun+Z8AqJnhoHnGXHWVdcfQI7MXyaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz1fWK8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7BAC4CEE7;
	Thu, 23 Oct 2025 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761228781;
	bh=NJZX715J8X/ePUXGj2kC9r5cpZuVmLm4kR8Ex4cYbfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bz1fWK8d/s4KPkLScpGdeJ1RysznYLF4t51w+ePzFslWYOsSVfEEiUqLvbnJ4hZ0b
	 mqzNgYOkxCwY6nRQxi2iygMURtmJf/96xnNBjK9VsflN3yWDeMrR0mKnKj4AeXMkLe
	 S2PpBjMWJ+WvgGc/yKkkmiJYm+xkVGgXu3T8gekE1ZanpQTAN0ZxIAFBCqhtNljnHT
	 rva7xdphm/fRUHaXmyutCw7Plwb6qiF+7EKj8hIz5DYf0kgtSQ/zM+lXnZI7Vda37P
	 Acx/582opp+iAzERdKNeR47HCo+wI8Tmphcve88wp6pRuRN5k3jhD5XzX8ZydvdSQg
	 96o0rqHokMLHQ==
Date: Thu, 23 Oct 2025 07:12:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: daniel.machon@microchip.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, horatiu.vultur@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 luka.perkov@sartura.hr
Subject: Re: [PATCH net] net: phy: micrel: always set shared->phydev for
 LAN8814
Message-ID: <20251023071259.77076fd4@kernel.org>
In-Reply-To: <20251021132034.983936-1-robert.marko@sartura.hr>
References: <20251021132034.983936-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 15:20:26 +0200 Robert Marko wrote:
> Currently, during the LAN8814 PTP probe shared->phydev is only set if PTP
> clock gets actually set, otherwise the function will return before setting
> it.
> 
> This is an issue as shared->phydev is unconditionally being used when IRQ
> is being handled, especially in lan8814_gpio_process_cap and since it was
> not set it will cause a NULL pointer exception and crash the kernel.
> 
> So, simply always set shared->phydev to avoid the NULL pointer exception.
> 
> Fixes: b3f1a08fcf0d ("net: phy: micrel: Add support for PTP_PF_EXTTS for lan8814")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Hopefully I'm not misunderstanding the situation, but since we're
considering taking the other patchset via net-next I'll apply
already this to prevent crashes in net..

