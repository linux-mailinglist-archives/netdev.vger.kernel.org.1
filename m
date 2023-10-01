Return-Path: <netdev+bounces-37260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E31CD7B475C
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9B6B0281AF2
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EC217733;
	Sun,  1 Oct 2023 12:23:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BC517728
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 12:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68F6C433C8;
	Sun,  1 Oct 2023 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696163001;
	bh=cw7CS63l0RAvgmBKjdZgE6Zr9SOJsQukYNn5TfNmzr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8YO6GTkfcj4JiT/lH4zt0qDUd2lojUD8TpeAx+1zp7uWa9ifFLdGKzh7y1z6lhsW
	 CDk08CMgP+W9YzEAGGKPzJHTsrBor8YENr+PsefYeTUusTDE1ln4Kx4o0/D8LlrZUE
	 a7kxz+bseGR8Gf+mW8ZgDIcCu57ht0VFowX4cLurZvtvuXeU3oc3ku32I2I1KeGJdb
	 HEO6YDCSeRJ2a3f3xBJ1W2tc8fNDyxmeir8lGm9rMXJdK8jYt+0Fxsd+gBnniSgZX4
	 g7Qs4SLCDj4AopzW/FqrxBPbsWb0WRWUwbA/YsbMGchSFPXt2EMvvbTUKmJlZezEku
	 vbbH09vxKxuuw==
Date: Sun, 1 Oct 2023 14:23:16 +0200
From: Simon Horman <horms@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julien Panis <jpanis@baylibre.com>,
	Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v6 04/14] can: m_can: Implement receive coalescing
Message-ID: <20231001122316.GL92317@kernel.org>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <20230929141304.3934380-5-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-5-msp@baylibre.com>

On Fri, Sep 29, 2023 at 04:12:54PM +0200, Markus Schneider-Pargmann wrote:
> m_can offers the possibility to set an interrupt on reaching a watermark
> level in the receive FIFO. This can be used to implement coalescing.
> Unfortunately there is no hardware timeout available to trigger an
> interrupt if only a few messages were received within a given time. To
> solve this I am using a hrtimer to wake up the irq thread after x
> microseconds.
> 
> The timer is always started if receive coalescing is enabled and new
> received frames were available during an interrupt. The timer is stopped
> if during a interrupt handling no new data was available.
> 
> If the timer is started the new item interrupt is disabled and the
> watermark interrupt takes over. If the timer is not started again, the
> new item interrupt is enabled again, notifying the handler about every
> new item received.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>


