Return-Path: <netdev+bounces-54257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DAC8065F3
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629D21F21420
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ACBDDCA;
	Wed,  6 Dec 2023 04:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjDu4Syq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C168D286
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2DCC433C8;
	Wed,  6 Dec 2023 04:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701835353;
	bh=f6TUQi8YLonQSXR1Mwy5Ic6tqKo5drSWb160rTjbLJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jjDu4Syql+aC4BpMWIQK9tsITUMj6q3ueujPYpxdCYjDZ0yFfvNnUSLze1H1711BE
	 uQcFfhwd4CLE8HxM1RdD51PcgIqDDVrNaLBOKzPrbAxzjA7/Ckj9JlRLLegvDDRwSd
	 IoxyT2wwp+QkbK3gqM8qmxpCaz8Ssn2hCzcICAorNquRopWi6TX4cjOYia4NwDT7cX
	 ji76nJ93z2W95uu9ByVZ+jfIeeBh4tEVtJ1bTJ0+tQqgbf4HdLFcVS0VVnRw9q+tUI
	 UUg9KaB/SDhWe8NaKL9b29fQ0ksBl5ZQVFQ/XcoLzJC+vlhne3t7Ps/m7r6LestrNI
	 Irc8CSYO66K7g==
Date: Tue, 5 Dec 2023 20:02:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH 5/8] dpaa2-switch: do not clear any interrupts
 automatically
Message-ID: <20231205200232.410387cc@kernel.org>
In-Reply-To: <20231204163528.1797565-6-ioana.ciornei@nxp.com>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
	<20231204163528.1797565-6-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Dec 2023 18:35:25 +0200 Ioana Ciornei wrote:
> The dpsw_get_irq_status() can clear interrupts automatically based on
> the value stored in the 'status' variable passed to it. We don't want
> that to happen because we could get into a situation when we are
> clearing more interrupts that we actually handled.
> 
> Just resort to manually clearing interrupts after we received them using
> the dpsw_clear_irq_status().

Currently it can't cause any issues?
We won't get into an IRQ storm if some unexpected IRQ fires?

