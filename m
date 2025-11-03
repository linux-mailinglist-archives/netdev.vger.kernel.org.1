Return-Path: <netdev+bounces-235126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85170C2C71B
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 15:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF5C3A57B9
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E8927F747;
	Mon,  3 Nov 2025 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOgB7fE/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A91D7E5C;
	Mon,  3 Nov 2025 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180356; cv=none; b=BdkojBbID/P7Z7Hjj2CcKQvg7Un1/te7ICIvi76uihAw99YAIwZbrOmbI4tIry6XC2kz8XKFpRV8FhCd2r29H8+C3HoboJtVhCYC8dIytn0lMUg5e/xTbUr466SCz8+DmIufkWwkPZDE+52IZ5T72CRjRFVrfEdQQVuUcPK33XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180356; c=relaxed/simple;
	bh=FjijuDA4E5Wq4MOBEyRWsWNhUVP8QhoN79MBpayGczI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGh+W5pCyV456wohr+GBQdPj6txkz8BeomMPU3cFl8rx4C214R5pljExtJJk+X9WkrwacKHSmlDk+utVitOic27QJmlfTdMb32r7yS/LbhCVShSD32pxt12v2cPUY83noezmQ21ce6lVsYuzrd75LjVDqhS8b7gZjTUJuZknGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOgB7fE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E884CC4CEE7;
	Mon,  3 Nov 2025 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762180355;
	bh=FjijuDA4E5Wq4MOBEyRWsWNhUVP8QhoN79MBpayGczI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOgB7fE/048QNi/w3c96EvqQqITq3t5dgd7sO3zyee1uz+chfiFpJ2sEjRD8q+6A6
	 Qwci25YyMrMKmPNAQuJn8Xd5iioWEKPNxgkhIxKvr3RTuI9Pz0cjmu6znzNdIoxHLd
	 iuQ9PWUr4j3VE0D0ibAKy9nBU5DiOaNDRdOcmeBB1YD79psAiJ4kXBCSqYgVczrzZX
	 2NVhUgrOic8FdVxU+MMNkxvh96/mZWS5LV4e5vQ/EgtbF7FFCCGF39yarRN7FP5zvc
	 3F4xCPRRx2kExD/yqezn0zcwbxIIjY+9Dzy1unbHezBPN6dbItrwMtZVtQSiauY7gK
	 Yu8Tv/DnxX7XA==
Date: Mon, 3 Nov 2025 14:32:31 +0000
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <David.Woodhouse@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] atm: solos-pci: Use pointer from memcpy() call for
 assignment in fpga_tx()
Message-ID: <aQi8_9-VH5QJSLVF@horms.kernel.org>
References: <093033d3-0ea3-49a0-83e8-621fc4fe1d24@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <093033d3-0ea3-49a0-83e8-621fc4fe1d24@web.de>

On Fri, Oct 31, 2025 at 12:42:09PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 31 Oct 2025 12:30:38 +0100
> 
> A pointer was assigned to a variable. The same pointer was used for
> the destination parameter of a memcpy() call.
> This function is documented in the way that the same value is returned.
> Thus convert two separate statements into a direct variable assignment for
> the return value from a memory copy action.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Quoting documentation:

1.6.6. Clean-up patches¶

Netdev discourages patches which perform simple clean-ups, which are not in
the context of other work. For example:

 * Addressing checkpatch.pl, and other trivial coding style warnings

 * Addressing Local variable ordering issues

 * Conversions to device-managed APIs (devm_ helpers)

This is because it is felt that the churn that such changes produce comes
at a greater cost than the value of such clean-ups.

Conversely, spelling and grammar fixes are not discouraged.

https://docs.kernel.org/6.18-rc4/process/maintainer-netdev.html#clean-up-patches

-- 
pw-bot: rejected

