Return-Path: <netdev+bounces-111446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CABA93112E
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51D01F22AA6
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37B1186E2C;
	Mon, 15 Jul 2024 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scB3/At4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3706AC0
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035718; cv=none; b=MqaJ5VTQlgQHqqSoJzjHB6kJbMBWBGB7qg7SY00iN5PLSCDLg3as35h4Fq4G7ZQesUKOIVe4HcwBeP1ZraiAHVBe4/P/5JTk+xUM7i+mQ1+bLICej5/L5irWx+dzCi5wnWUAZdYHVup2BlfchVFPjkzkjL+YF+s55D84pFHEAb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035718; c=relaxed/simple;
	bh=LwTygWsN3kty2Mbq5/GyWmDxxW0b2Cf7T5hv656n0Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crPWdnG4d8828m913fQKtQKIXM7o7xmykNhfvE2FyQTpvwH5J5wyNO5gLxQk8SCHQQXrHVysN03ngO6dxcPlHc10vhI8KdaVglm/bNvo2XRwzehktK+UFICxFsDMHOLq8UqFAWUDMrbHsCVzkGJxy2vOHPJzdA/K/qeHjM+5X8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scB3/At4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADDEC32782;
	Mon, 15 Jul 2024 09:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721035718;
	bh=LwTygWsN3kty2Mbq5/GyWmDxxW0b2Cf7T5hv656n0Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scB3/At4a2ZM47EMEEXjcLKK54948rJs5rkmH5CyrtWE98M4JVc3pLecX04BttYdF
	 Yeenn2Ru2D4oZNChxfuDYtRdpwACepERY4ngS/A5NB/nlSM/BKMlvOmrL3QQxSYNgX
	 gmm3Uk0tddpraeyygwug0AuEOOb8pA50YYlaTrOhaPJMj+Kqre4xtcDi+FUuhotw3d
	 Nip+8Xc5al08ibPMDEhQjZJbvY0A8YV5/UGQVdpVLQwRhyZB4djMQempzG4S1ZSLnm
	 bPhXQGBDVdlM1+oICV0E6d5sk1Bz1vZMc2Li61Ht0SgUNuYup+PCSpw6dUsohC7L0U
	 K92G7spXyHXBQ==
Date: Mon, 15 Jul 2024 10:28:34 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next 2/9] bnxt_en: add support for retrieving crash
 dump using ethtool
Message-ID: <20240715092834.GG8432@kernel.org>
References: <20240713234339.70293-1-michael.chan@broadcom.com>
 <20240713234339.70293-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-3-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:32PM -0700, Michael Chan wrote:
> From: Vikas Gupta <vikas.gupta@broadcom.com>
> 
> Add support for retrieving crash dump using ethtool -w on the
> supported interface.
> 
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



