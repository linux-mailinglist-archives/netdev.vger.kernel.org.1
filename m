Return-Path: <netdev+bounces-54952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982B9808FD6
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52948281682
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD94D5BF;
	Thu,  7 Dec 2023 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvXJvhGi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABBD1400F
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 18:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27931C433C7;
	Thu,  7 Dec 2023 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701973639;
	bh=5S1VO0oETQWtW4PTLsC6FuGcquFJ1Tqqvq4cy4oY8ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pvXJvhGiV7oAYIesThU6gwdf5kIkHVPbaK/MAD/s8u5qyjg1a4hekLi2c1t7fiJNW
	 NG2tJTiieCcIXOOpXqGwUUCNcrZvpp8wGqC8DEb8+vQ+TjuWkKZF9s4vtUux/+0l0Z
	 KUlkhZa6MGz5k5H5yKnRIx33WJA8kedWGEzgWuDFtcYUTDVWcYkzJ5TVMpUPRs8HW3
	 9gSlOTF5/UHEMzqMnBEXYPlanwr+E0Ak7k9Sb44R+qxikBftV2oz+r3scdQYamILkA
	 XbXiwhFaoKVkfEl10FQmFlts8cihGmsEySal8/tvmlUouVcQbcleFpjkVbAMKxQUIR
	 9sMcDSMEHa6qg==
Date: Thu, 7 Dec 2023 10:27:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net v2 3/4] bnxt_en: Fix wrong return value check in
 bnxt_close_nic()
Message-ID: <20231207102718.4d930353@kernel.org>
In-Reply-To: <20231207000551.138584-4-michael.chan@broadcom.com>
References: <20231207000551.138584-1-michael.chan@broadcom.com>
	<20231207000551.138584-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Dec 2023 16:05:50 -0800 Michael Chan wrote:
> The wait_event_interruptible_timeout() function returns 0
> if the timeout elapsed, -ERESTARTSYS if it was interrupted
> by a signal, and the remaining jiffies otherwise if the
> condition evaluated to true before the timeout elapsed.
> 
> Driver should have checked for zero return value instead of
> a positive value.

Not sure how this was not caught earlier, maybe there is a more
complicated story behind it. Otherwise you should handle -ERESTARTSYS
as well.

